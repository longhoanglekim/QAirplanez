package com.web.airplane.demo.controllers;

import com.web.airplane.demo.dtos.FlightInfo;
import com.web.airplane.demo.dtos.PassengerInfo;
import com.web.airplane.demo.exceptions.SeatUnavailableException;
import com.web.airplane.demo.models.Flight;
import com.web.airplane.demo.models.Passenger;
import com.web.airplane.demo.models.User;
import com.web.airplane.demo.repositories.FlightRepository;
import com.web.airplane.demo.repositories.PassengerRepository;
import com.web.airplane.demo.repositories.TicketClassRepository;
import com.web.airplane.demo.repositories.UserRepository;
import com.web.airplane.demo.services.BookingCodeService;
import com.web.airplane.demo.services.FlightService;
import com.web.airplane.demo.services.UserService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api/user")
@Slf4j
public class UserController {
    private final UserRepository userRepository;
    @Autowired
    private TicketClassRepository ticketClassRepository;
    private final UserService userService;
    @Autowired
    private FlightService flightService;
    @Autowired
    private FlightRepository flightRepository;
    @Autowired
    private PassengerRepository passengerRepository;
    private final BookingCodeService bookingCodeService;

    public UserController(UserRepository userRepository, UserService userService, BookingCodeService bookingCodeService) {
        this.userRepository = userRepository;
        this.userService = userService;
        this.bookingCodeService = bookingCodeService;
    }

    @GetMapping("/flights")
    public List<FlightInfo> getFlightInfo(HttpServletRequest request) {
        List<Flight> flights = userService.findAllFlight(userService.getCurrentUser(request));
        List<FlightInfo> flightInfos = new ArrayList<>();
        for (Flight flight : flights) {
            FlightInfo flightInfo = flightService.getFlightInfo(flight);
            flightInfos.add(flightInfo);
        }
        return flightInfos;
    }

    @GetMapping("/currentUser")
    public User getCurrentUser(HttpServletRequest request) {
        return userService.getCurrentUser(request);
    }

    @Transactional
    @PostMapping("/bookFlight")
    public ResponseEntity<?> bookFlight(@RequestParam("flight_number") String flightNumber,
                                        HttpServletRequest request,
                                        @RequestBody List<PassengerInfo> passengerInfoList) {
        try {
            log.debug("Tim chuyen bay");
            Flight flight = flightRepository.findByFlightNumber(flightNumber);
            if (flight == null) {
                return ResponseEntity.badRequest().body("Flight not found.");
            }


            int bookedSeats = flight.getPassengers().size();

            if (flight.getFirstAvailableSeats() == 0 && flight.getBusinessAvailableSeats() == 0 && flight.getEconomyAvailableSeats() == 0) {
                throw new SeatUnavailableException("There are only " + (flight.getAircraft().getNumberOfSeats() - bookedSeats) + " available seats.");
            }
            //Todo : Xét ngoại lệ với từng hạng ghế
            log.debug("Xet ngoai le tung hang ghe");
            int numberReqFirstSeat = 0;
            int numberReqBusinessSeat = 0;
            int numberReqEconomySeat = 0;
            for (PassengerInfo passengerInfo : passengerInfoList) {
                if (passengerInfo.getTicketClassCode().equals("First")) {
                    numberReqFirstSeat++;
                } else if (passengerInfo.getTicketClassCode().equals("Business")) {
                    numberReqBusinessSeat++;
                } else numberReqEconomySeat++;
            }
            log.debug("Xet first class");
            if (flight.getFirstAvailableSeats() - numberReqFirstSeat < 0) {
                throw new SeatUnavailableException("There're not enough seats for first class!");
            }
            log.debug("Xet business class");
            if (flight.getBusinessAvailableSeats() - numberReqBusinessSeat < 0) {
                throw new SeatUnavailableException("There're not enough seats for business class!");
            }
            log.debug("Xet economy class");
            if (flight.getEconomyAvailableSeats() - numberReqEconomySeat < 0) {
                throw new SeatUnavailableException("There're not enough seats for economy class!");
            }

            // Todo : Tiến hành đặt vé, ví dụ thêm hành khách vào chuyến bay
            String genBookingCode = bookingProcess(request, passengerInfoList, flight);
            flightRepository.save(flight);  // Lưu lại chuyến bay với hành khách đã được đặt

            return ResponseEntity.ok(genBookingCode);

        } catch (SeatUnavailableException e) {
            // Xử lý exception nếu không đủ ghế
            return ResponseEntity.badRequest().body(e.getMessage());
        } catch (Exception e) {
            // Xử lý các lỗi khác (nếu có)
            return ResponseEntity.status(500).body("An error occurred: " + e.getMessage());
        }
    }

    private String bookingProcess(HttpServletRequest request, List<PassengerInfo> passengerInfoList, Flight flight) throws SeatUnavailableException {
        log.debug("Tiến hành đặt vé, ví dụ thêm hành khách vào chuyến bay");
        StringBuilder stringBuilder = new StringBuilder();
        for (PassengerInfo passengerInfo : passengerInfoList) {
            log.debug("THEM KHACH HANG");
            Passenger passenger = new Passenger();
            passenger.setFirstName(passengerInfo.getFirstName());
            passenger.setLastName(passengerInfo.getLastName());
            passenger.setBirthdate(passengerInfo.getBirthdate());
            log.debug("Set cho ngoi");
            passenger.setFlight(flight);
            if (passengerInfo.getTicketClassCode().equals("First")) {
                passenger.setTicketClass(ticketClassRepository.findById(3L).get());
                if (passengerInfo.getSeatPosition() == null && passengerInfo.getSeatRow() == null) {
                    log.debug("Chon ghe first");
                    String seatCode = flightService.getFirstSeatForAutoBooking(flight);
                    passenger.setSeatPosition(String.valueOf(seatCode.charAt(0)));
                    passenger.setSeatRow(Integer.parseInt(String.valueOf(seatCode.charAt(1))));
                } else {
                    passenger.setSeatRow(passengerInfo.getSeatRow());
                    passenger.setSeatPosition(passengerInfo.getSeatPosition());
                }
                flight.setFirstAvailableSeats(flight.getFirstAvailableSeats() - 1);
                stringBuilder.append(bookingCodeService.generateBookingCode());
                passenger.setBookingCode(stringBuilder.toString());
            } else if (passengerInfo.getTicketClassCode().equals("Business")) {
                passenger.setTicketClass(ticketClassRepository.findById(2L).get());
                if (passengerInfo.getSeatPosition() == null && passenger.getSeatRow() == null) {
                    log.debug("Chon ghe bus");
                    String seatCode = flightService.getBusinessSeatForAutoBooking(flight);
                    passenger.setSeatPosition(String.valueOf(seatCode.charAt(0)));
                    passenger.setSeatRow(Integer.parseInt(String.valueOf(seatCode.charAt(1))));
                } else {
                    passenger.setSeatRow(passengerInfo.getSeatRow());
                    passenger.setSeatPosition(passengerInfo.getSeatPosition());
                }
                flight.setBusinessAvailableSeats(flight.getBusinessAvailableSeats() - 1);
                stringBuilder.append(bookingCodeService.generateBookingCode());
                passenger.setBookingCode(stringBuilder.toString());
            } else {
                passenger.setTicketClass(ticketClassRepository.findById(1L).get());
                if (passengerInfo.getSeatPosition() == null && passenger.getSeatRow() == null) {
                    log.debug("Chon ghe economy");
                    String seatCode = flightService.getEconomySeatForAutoBooking(flight);
                    passenger.setSeatPosition(String.valueOf(seatCode.charAt(0)));
                    passenger.setSeatRow(Integer.parseInt(String.valueOf(seatCode.charAt(1))));
                } else {
                    passenger.setSeatRow(passengerInfo.getSeatRow());
                    passenger.setSeatPosition(passengerInfo.getSeatPosition());
                }
                flight.setEconomyAvailableSeats(flight.getBusinessAvailableSeats() - 1);
                stringBuilder.append(bookingCodeService.generateBookingCode());
                passenger.setBookingCode(stringBuilder.toString());
            }
            log.debug("Them vao database");
            passenger.setUser(getCurrentUser(request));
            log.debug("Set booking code");
            passenger.setBookingCode(bookingCodeService.generateBookingCode());
            log.debug("Them Passenger");
            passengerRepository.save(passenger);
            flight.getPassengers().add(passenger);

        }
        return stringBuilder.toString();
    }

    @Transactional
    @PostMapping("/cancel")
    public ResponseEntity<?> cancelFlight(HttpServletRequest request,
                                          @RequestParam("passenger_id") long passengerId,
                                          @RequestParam("flight_number") String flightNumber) {
        // Find the flight by flight number
        Flight flight = flightRepository.findByFlightNumber(flightNumber);
        if (flight == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Flight not found");
        }

        // Find the passenger by passenger ID
        Passenger passenger = passengerRepository.findById(passengerId).orElse(null);
        if (passenger == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Passenger not found");
        }
        LocalDateTime localDateTime = LocalDateTime.now();
        if (flight.getCancelDueTime().isBefore(localDateTime)) {
            return ResponseEntity.status(HttpStatus.UNPROCESSABLE_ENTITY).body("Booking is too late to cancel.");
        }


        // Remove the passenger from the flight's list of passengers
        flight.getPassengers().remove(passenger);

        // Save the flight (cascading the removal of the passenger)
        flightRepository.save(flight);

        return ResponseEntity.ok().body("Passenger has been removed from the flight and deleted");
    }

    @GetMapping("/public/checkLogged")
    public ResponseEntity<?> hasLoggedIn(HttpServletRequest request) {
        // Lấy người dùng hiện tại
        User currentUser = getCurrentUser(request);

        if (currentUser == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body("User not logged in");
        }

        // Trả về thông tin người dùng (ví dụ: tên người dùng)
        return ResponseEntity.ok("User is logged in: " + currentUser.getUsername());
    }


    @PostMapping("/logout")
    public ResponseEntity<?> logout(HttpServletRequest request, HttpServletResponse response) {
        try {
            // Xóa JWT token khỏi cookie
            Cookie cookie = new Cookie("jwtToken", null);
            cookie.setHttpOnly(true);
            cookie.setSecure(true);
            cookie.setPath("/");
            cookie.setMaxAge(0);
            response.addCookie(cookie);
            SecurityContextLogoutHandler logoutHandler = new SecurityContextLogoutHandler();
            logoutHandler.logout(request, response, null);
            return ResponseEntity.ok("Logout successful");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred during logout :" + e.getMessage());
        }
    }


}
