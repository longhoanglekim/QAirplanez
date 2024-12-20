package com.web.airplane.demo.controllers;

import com.web.airplane.demo.dtos.FlightInfo;
import com.web.airplane.demo.dtos.ImageResponse;
import com.web.airplane.demo.dtos.PassengerInfo;
import com.web.airplane.demo.dtos.UserInfo;
import com.web.airplane.demo.exceptions.SeatUnavailableException;
import com.web.airplane.demo.models.Flight;
import com.web.airplane.demo.models.Image;
import com.web.airplane.demo.models.Passenger;
import com.web.airplane.demo.models.User;
import com.web.airplane.demo.repositories.*;
import com.web.airplane.demo.services.BookingCodeService;
import com.web.airplane.demo.services.FlightService;
import com.web.airplane.demo.services.ImageService;
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
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.web.airplane.demo.dtos.BookingDTO;

@RestController
@RequestMapping("/api/user")
@Slf4j
public class UserController {
    @Autowired
    private ImageRepository imageRepository;
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
    @Autowired
    private ImageService imageService;

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
    public UserInfo getCurrentUser(HttpServletRequest request) {
        return userService.getUserInfo(userService.getCurrentUser(request));
    }

    @Transactional
    @PostMapping("/public/bookFlight")
    public ResponseEntity<?> bookFlight(@RequestParam("depart_flight_number") String departFlightNumber,
                                        @RequestParam(value = "return_flight_number", required = false) String returnFlightNumber,
                                        HttpServletRequest request,
                                        @RequestBody BookingDTO bookingDTO) {
        List<PassengerInfo> passengerInfoList = bookingDTO.getPassengerInfoList();
        try {
            log.debug("Tim chuyen bay: " + departFlightNumber);
            Flight departFlight = flightRepository.findByFlightNumber(departFlightNumber);
            if (departFlight == null) {
                return ResponseEntity.badRequest().body("Depart flight not found.");
            }

            Flight returnFlight = null;
            if (returnFlightNumber != null) {
                log.debug("Tim chuyen bay ve: " + returnFlightNumber);
                returnFlight = flightRepository.findByFlightNumber(returnFlightNumber);
                if (returnFlight == null) {
                    return ResponseEntity.badRequest().body("Return flight not found.");
                }
            }

            // Kiểm tra ghế khả dụng
            if (!checkAvailableSeats(departFlight, passengerInfoList)) {
                return ResponseEntity.badRequest().body("Not enough seats available for the departure flight.");
            }

            if (returnFlight != null && !checkAvailableSeats(returnFlight, passengerInfoList)) {
                return ResponseEntity.badRequest().body("Not enough seats available for the return flight.");
            }

            // Tạo bookingCode chung
            String commonBookingCode = bookingCodeService.generateBookingCode();

            // Đặt vé cho chiều đi
            bookingProcess(commonBookingCode, request, passengerInfoList, departFlight);
            flightRepository.save(departFlight);
            log.debug("booking xong");
            // Đặt vé cho chiều về (nếu có)
            if (returnFlight != null) {
                bookingProcess(commonBookingCode, request, passengerInfoList, returnFlight);
                flightRepository.save(returnFlight);
            }

            return ResponseEntity.ok(commonBookingCode);

        } catch (Exception e) {
            log.error("Error occurred while booking flight", e);
            return ResponseEntity.status(500).body("An error occurred: " + e.getMessage());
        }
    }

    private boolean checkAvailableSeats(Flight flight, List<PassengerInfo> passengerInfoList) {
        int numberReqFirstSeat = 0;
        int numberReqBusinessSeat = 0;
        int numberReqEconomySeat = 0;

        for (PassengerInfo passengerInfo : passengerInfoList) {
            switch (passengerInfo.getTicketClassCode()) {
                case "First" -> numberReqFirstSeat++;
                case "Business" -> numberReqBusinessSeat++;
                default -> numberReqEconomySeat++;
            }
        }

        return flight.getFirstAvailableSeats() >= numberReqFirstSeat &&
                flight.getBusinessAvailableSeats() >= numberReqBusinessSeat &&
                flight.getEconomyAvailableSeats() >= numberReqEconomySeat;
    }


    private void bookingProcess(String commonBookingCode, HttpServletRequest request, List<PassengerInfo> passengerInfoList, Flight flight) throws SeatUnavailableException {
        log.debug("Tiến hành đặt vé, ví dụ thêm hành khách vào chuyến bay");



        for (PassengerInfo passengerInfo : passengerInfoList) {
            log.debug("THEM KHACH HANG");

            Passenger passenger = new Passenger();
            passenger.setFirstName(passengerInfo.getFirstName());
            passenger.setLastName(passengerInfo.getLastName());
            passenger.setBirthdate(passengerInfo.getBirthdate());
            passenger.setFlight(flight);
            passenger.setEmail(passengerInfo.getEmail());
            passenger.setPhoneNumber(passengerInfo.getPhoneNumber());
            // Xử lý logic chọn ghế dựa trên hạng vé
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

            } else if (passengerInfo.getTicketClassCode().equals("Business")) {
                passenger.setTicketClass(ticketClassRepository.findById(2L).get());
                if (passengerInfo.getSeatPosition() == null && passengerInfo.getSeatRow() == null) {
                    log.debug("Chon ghe bus");
                    String seatCode = flightService.getBusinessSeatForAutoBooking(flight);
                    passenger.setSeatPosition(String.valueOf(seatCode.charAt(0)));
                    passenger.setSeatRow(Integer.parseInt(String.valueOf(seatCode.charAt(1))));
                } else {
                    passenger.setSeatRow(passengerInfo.getSeatRow());
                    passenger.setSeatPosition(passengerInfo.getSeatPosition());
                }
                flight.setBusinessAvailableSeats(flight.getBusinessAvailableSeats() - 1);

            } else {
                passenger.setTicketClass(ticketClassRepository.findById(1L).get());
                if (passengerInfo.getSeatPosition() == null && passengerInfo.getSeatRow() == null) {
                    log.debug("Chon ghe economy");
                    String seatCode = flightService.getEconomySeatForAutoBooking(flight);
                    passenger.setSeatPosition(String.valueOf(seatCode.charAt(0)));
                    passenger.setSeatRow(Integer.parseInt(String.valueOf(seatCode.charAt(1))));
                } else {
                    passenger.setSeatRow(passengerInfo.getSeatRow());
                    passenger.setSeatPosition(passengerInfo.getSeatPosition());
                }
                flight.setEconomyAvailableSeats(flight.getEconomyAvailableSeats() - 1);
            }

            log.debug("Them vao database");
            // Gán bookingCode chung
            passenger.setBookingCode(commonBookingCode);

            log.debug("Them Passenger");
            passengerRepository.save(passenger);
            flight.getPassengers().add(passenger);
            log.debug("Them thanh cong Passenger");
        }

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
        User currentUser = userService.getCurrentUser(request);

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

    @PostMapping("/setAvatar")
    @Transactional
    public ResponseEntity<?> setAvatar(@RequestParam("image")MultipartFile file, HttpServletRequest request) {
        Image image = null;
        log.debug("Set avatar");
        try {
            log.debug("Bắt đâu set ảnh");
            image = imageService.storeImage(file);
            if (image != null) {
                log.debug("Thêm vào database");
                User user = userService.getCurrentUser(request);
                user.getAvatarList().add(image);
                image.setUser(user);
                imageRepository.save(image);
                userRepository.save(user);
                return ResponseEntity.ok(image);
            }
            return ResponseEntity.status(HttpStatus.NO_CONTENT).body(image);
        } catch (IOException e) {
            log.debug(e.getMessage());
            return ResponseEntity.badRequest().body(e.getMessage());
        }

    }

    @PostMapping("/getAvatar")
    public ResponseEntity<?> getImage(HttpServletRequest request) {
        User user = userService.getCurrentUser(request);
        Image currentAvatar = user.getAvatarList().get(user.getAvatarList().size() - 1);
        String imgUrl = imageService.getImage(currentAvatar);
        ImageResponse imageResponse = new ImageResponse();
        imageResponse.setImageUrl(imgUrl);
        // Trả về ảnh dưới dạng base64
        return ResponseEntity.ok(imageResponse);
    }
}
