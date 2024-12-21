package com.web.airplane.demo.controllers;

import com.web.airplane.demo.dtos.BookingDTO;
import com.web.airplane.demo.dtos.FlightInfo;
import com.web.airplane.demo.dtos.ImageResponse;
import com.web.airplane.demo.dtos.PassengerInfo;
import com.web.airplane.demo.dtos.UserInfo;
import com.web.airplane.demo.dtos.bookings.TicketInput;
import com.web.airplane.demo.dtos.bookings.TicketResponse;
import com.web.airplane.demo.exceptions.SeatUnavailableException;
import com.web.airplane.demo.models.*;
import com.web.airplane.demo.repositories.*;
import com.web.airplane.demo.services.*;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.antlr.v4.runtime.misc.Pair;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Period;
import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/user")
@Slf4j
public class UserController {
    @Autowired
    private ImageRepository imageRepository;
    @Autowired
    private PassengerService passengerService;
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
    @Autowired BookingTicketRepository bookingTicketRepository;
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
                                        @RequestBody BookingDTO bookingData) {
        log.debug("Bắt đầu đặt vé");
        List<PassengerInfo> passengerInfoList = bookingData.getPassengerInfoList();
        String service = bookingData.getAllService();
        log.debug("dịch vụ: " + service);
        BigDecimal totalPrice = bookingData.getTotalPrice();
        log.debug("tổng giá: " + totalPrice);

        try {
            if (checkDuplicateIdentification(passengerInfoList)) {
                return ResponseEntity.badRequest().body("Có trùng hành khách!");
            }


            log.debug("Tim chuyen bay: " + departFlightNumber);
            Flight departFlight = flightRepository.findByFlightNumber(departFlightNumber);
            if (departFlight == null) {
                return ResponseEntity.badRequest().body("Depart flight not found.");
            }

            Flight returnFlight = flightRepository.findByFlightNumber(returnFlightNumber);
            if (returnFlightNumber != null) {
                log.debug("Tim chuyen bay ve: " + returnFlightNumber);
                if (returnFlight == null) {
                    return ResponseEntity.badRequest().body("Return flight not found.");
                }
            }

            // Kiểm tra ghế khả dụng
            if (!checkAvailableSeats(departFlight, passengerInfoList, true)) {
                return ResponseEntity.badRequest().body("Not enough seats available for the departure flight.");
            }

            if (returnFlight != null && !checkAvailableSeats(returnFlight, passengerInfoList, false)) {
                return ResponseEntity.badRequest().body("Not enough seats available for the return flight.");
            }

            // Tạo bookingCode chung
            String commonBookingCode = bookingCodeService.generateBookingCode();
            BookingTicket bookingTicket = new BookingTicket();
            bookingTicket.setBookingCode(commonBookingCode);
            bookingTicket.setService(service);
            bookingTicket.setTotalPrice(totalPrice);
            bookingTicketRepository.save(bookingTicket);
            // Đặt vé cho chiều đi
            bookingProcess(bookingTicket, request, passengerInfoList, departFlight, true);
            flightRepository.save(departFlight);
            log.debug("booking xong");
            // Đặt vé cho chiều về (nếu có)
            if (returnFlight != null) {
                log.debug("sET CHUYẾN VỀ");
                bookingProcess(bookingTicket, request, passengerInfoList, returnFlight, false);
                Flight temp = flightRepository.save(returnFlight);
                if (temp.getPassengers().isEmpty()) {
                    log.debug("Có");
                }
            }

            return ResponseEntity.ok(commonBookingCode);

        } catch (Exception e) {
            log.error("Error occurred while booking flight", e);
            return ResponseEntity.status(500).body("An error occurred: " + e.getMessage());
        }
    }

    private boolean checkAvailableSeats(Flight flight, List<PassengerInfo> passengerInfoList, boolean outbound) {
        int numberReqFirstSeat = 0;
        int numberReqBusinessSeat = 0;
        int numberReqEconomySeat = 0;

        for (PassengerInfo passengerInfo : passengerInfoList) {
            String ticketClassCode;
            if (outbound) {
                ticketClassCode = passengerInfo.getOutboundTicketClassCode();
            } else {
                ticketClassCode = passengerInfo.getInboundTicketClassCode();
            }
            switch (ticketClassCode) {
                case "First" -> numberReqFirstSeat++;
                case "Business" -> numberReqBusinessSeat++;
                default -> numberReqEconomySeat++;
            }
        }

        return flight.getFirstAvailableSeats() >= numberReqFirstSeat &&
                flight.getBusinessAvailableSeats() >= numberReqBusinessSeat &&
                flight.getEconomyAvailableSeats() >= numberReqEconomySeat;
    }

    private boolean checkDuplicateIdentification(List<PassengerInfo> passengerInfoList) {
        Set<String> identificationSet = new HashSet<>();
        for (PassengerInfo passengerInfo : passengerInfoList) {
            if (!identificationSet.add(passengerInfo.getIdentification())) {
                return true;
            }
        }
        return false;
    }


    private void bookingProcess(BookingTicket bookingTicket, HttpServletRequest request, List<PassengerInfo> passengerInfoList, Flight flight, boolean outbound) throws SeatUnavailableException {
        log.debug("Tiến hành đặt vé");

        for (PassengerInfo passengerInfo : passengerInfoList) {
            log.debug("THÊM KHÁCH HÀNG");

            Passenger passenger = new Passenger();
            passenger.setFirstName(passengerInfo.getFirstName());
            passenger.setLastName(passengerInfo.getLastName());
            passenger.setBirthdate(passengerInfo.getBirthdate());
            passenger.setFlight(flight);
            passenger.setEmail(passengerInfo.getEmail());
            passenger.setPhoneNumber(passengerInfo.getPhoneNumber());
            passenger.setIdentification(passengerInfo.getIdentification());
            String ticketClassCode = outbound ? passengerInfo.getOutboundTicketClassCode() : passengerInfo.getInboundTicketClassCode();
            // Xử lý logic chọn ghế dựa trên hạng vé
            String seat = outbound ? passengerInfo.getOutboundSeatCode() : passengerInfo.getInboundSeatCode();
            log.debug(String.valueOf(seat == null));
            if (ticketClassCode.equals("First")) {
                passenger.setTicketClass(ticketClassRepository.findById(3L).get());
                Pair<String, Integer> pair = splitString(seat);
                if (seat == null || seat.isEmpty()) {
                    log.debug("seat null");
                    String seatCode = flightService.getFirstSeatForAutoBooking(flight);
                    passenger.setSeatPosition(String.valueOf(seatCode.charAt(0)));
                    passenger.setSeatRow(Integer.parseInt(String.valueOf(seatCode.charAt(1))));
                } else {
                    passenger.setSeatRow(pair.b);
                    passenger.setSeatPosition(pair.a);
                }
                flight.setFirstAvailableSeats(flight.getFirstAvailableSeats() - 1);
            } else if (ticketClassCode.equals("Business")) {
                passenger.setTicketClass(ticketClassRepository.findById(2L).get());
                Pair<String, Integer> pair = splitString(seat);
                if (seat == null || seat.isEmpty()) {
                    log.debug("seat null");
                    String seatCode = flightService.getFirstSeatForAutoBooking(flight);
                    passenger.setSeatPosition(String.valueOf(seatCode.charAt(0)));
                    passenger.setSeatRow(Integer.parseInt(String.valueOf(seatCode.charAt(1))));
                } else {
                    passenger.setSeatRow(pair.b);
                    passenger.setSeatPosition(pair.a);
                }
                flight.setBusinessAvailableSeats(flight.getBusinessAvailableSeats() - 1);
            } else {
                passenger.setTicketClass(ticketClassRepository.findById(1L).get());
                Pair<String, Integer> pair = splitString(seat);
                if (seat == null || seat.isEmpty()) {
                    log.debug("seat null");
                    String seatCode = flightService.getFirstSeatForAutoBooking(flight);
                    passenger.setSeatPosition(String.valueOf(seatCode.charAt(0)));
                    passenger.setSeatRow(Integer.parseInt(String.valueOf(seatCode.charAt(1))));
                } else {
                    passenger.setSeatRow(pair.b);
                    passenger.setSeatPosition(pair.a);
                }
                flight.setEconomyAvailableSeats(flight.getEconomyAvailableSeats() - 1);
            }

            // Liên kết Passenger với BookingTicket
            passenger.setBookingTicket(bookingTicket);
            bookingTicket.getPassengers().add(passenger);

            passengerRepository.save(passenger);
            log.debug("Thêm thành công Passenger");
        }

        // Lưu lại BookingTicket để cập nhật danh sách hành khách
        bookingTicketRepository.save(bookingTicket);

        // Lưu lại Flight để cập nhật danh sách hành khách
        flightRepository.save(flight);

        log.debug("Hoàn thành đặt vé");
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

    @PostMapping("/public/findTicketInfo")
    public ResponseEntity<?> getTicketInfo(@RequestBody TicketInput ticketInput) {
        log.debug("Bắt đầu tìm vé");
        BookingTicket bookingTicket = bookingTicketRepository.findBookingTicketByBookingCode(ticketInput.getBookingCode());
        if (bookingTicket == null) {
            return ResponseEntity.badRequest().body("Không có vé với mã số trên!");
        }
        List<Passenger> passengerList = passengerRepository.findAllByBookingTicket(bookingTicket);
        if (passengerList == null) {
            return ResponseEntity.badRequest().body("Danh sách khách hàng trống");
        }
        if (!checkIfExistPassengerWithFirstName(passengerList, ticketInput.getFirstName())) {
            return ResponseEntity.badRequest().body("Không có hành khách nào có họ như trên");
        }
        log.debug("Set vé");
        TicketResponse ticketResponse = new TicketResponse();
        ticketResponse.setBookingCode(bookingTicket.getBookingCode());
        ticketResponse.setService(bookingTicket.getService());
        ticketResponse.setPrice(bookingTicket.getTotalPrice());
        List<Flight> flights = getFlights(passengerList);
        ticketResponse.setOutboundFlight(flightService.getFlightResponse(flights.get(0)));

        ticketResponse.setOutboundPassengerInfoList(
                passengerList.stream()
                        .filter(passenger -> passenger.getFlight().equals(flights.get(0)))
                        .map(passenger -> passengerService.getPassengerTicketInfo(passenger)) // Chuyển từ Passenger sang PassengerInfo
                        .collect(Collectors.toList()) // Thu thập thành danh sách
        );
        if (flights.size() == 2) {
            ticketResponse.setInboundFlight(flightService.getFlightResponse(flights.get(1)));
            ticketResponse.setInboundPassengerInfoList(
                    passengerList.stream()
                            .filter(passenger -> passenger.getFlight().equals(flights.get(1)))
                            .map(passenger -> passengerService.getPassengerTicketInfo(passenger)) // Chuyển từ Passenger sang PassengerInfo
                            .collect(Collectors.toList()) // Thu thập thành danh sách
            );
        }



        return ResponseEntity.ok(ticketResponse);
    }

    private boolean isAdult(Passenger passenger) {

        LocalDate today = LocalDate.now();
        int age = Period.between(passenger.getBirthdate(), today).getYears(); // Tính số năm

        return age >= 18;
    }
//    private boolean checkIfExistInboundFlight(List<Passenger> passengerList) {
//        Map<String, Integer> identificationCount = new HashMap<>();
//
//        // Đếm số lần xuất hiện của mỗi identification
//        for (Passenger passengerInfo : passengerList) {
//            String identification = passengerInfo.getIdentification();
//            identificationCount.put(identification, identificationCount.getOrDefault(identification, 0) + 1);
//        }
//
//        // Kiểm tra nếu có bất kỳ identification nào xuất hiện đúng 2 lần
//        for (Integer count : identificationCount.values()) {
//            if (count == 2) {
//                return true; // Có chuyến bay khứ hồi
//            }
//        }
//
//        return false;
//    }

    boolean checkIfExistPassengerWithFirstName(List<Passenger> passengerList, String firstName) {
        for (Passenger passenger : passengerList) {
            if (passenger.getFirstName().equalsIgnoreCase(firstName)) {
                return true; // Tìm thấy hành khách có firstName khớp
            }
        }
        return false; // Không tìm thấy hành khách nào khớp
    }

    private List<Flight> getFlights(List<Passenger> passengerList) {
        List<Flight> flights = new ArrayList<>();
        for (Passenger passenger : passengerList) {
            if (!flights.contains(passenger.getFlight())) {
                flights.add(passenger.getFlight());
            }
        }
        log.debug(String.valueOf(flights.size()));
        if (flights.size() == 1) return flights;
        if (flights.get(0).getExpectedDepartureTime().isAfter(flights.get(1).getExpectedDepartureTime())) {
            Flight temp = flights.get(0);
            flights.set(0, flights.get(1));
            flights.set(1, temp);
        }
        log.debug(String.valueOf(flights.size()));
        return flights;
    }
    @PostMapping("/update")
    public ResponseEntity<?> updateUser(@RequestBody UserInfo userInfo, HttpServletRequest request) {
        try {
            User currentUser = userService.getCurrentUser(request);
            currentUser.setFirstname(userInfo.getFirstname());
            currentUser.setLastname(userInfo.getLastname());
            currentUser.setBirthdate(userInfo.getBirthdate());
            currentUser.setPhoneNumber(userInfo.getPhoneNumber());
            currentUser.setEmail(userInfo.getEmail());
            currentUser.setNationality(userInfo.getNationality());
            userService.updateUser(currentUser);
            return ResponseEntity.ok("User information updated successfully");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred while updating user information: " + e.getMessage());
        }


    }

    public static Pair<String, Integer> splitString(String input) {
        log.debug("input: " + input);
        if (input != null && input.length() > 1 && Character.isLetter(input.charAt(0))) {
            // Tách phần chữ cái và phần số
            String letter = input.substring(0, 1);
            String numberPart = input.substring(1);

            try {
                // Chuyển phần số từ String sang Integer
                int number = Integer.parseInt(numberPart);
                return new Pair<>(letter, number); // Trả về cặp (String, Integer)
            } catch (NumberFormatException e) {
                System.out.println("Number parsing error: " + e.getMessage());
                return null; // Lỗi nếu phần số không hợp lệ
            }
        }
        return null; // Trả về null nếu không đúng định dạng
    }
}