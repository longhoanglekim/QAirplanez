package com.web.airplane.demo.controllers;

import com.web.airplane.demo.dtos.AircraftInfo;
import com.web.airplane.demo.dtos.FlightInfo;
import com.web.airplane.demo.models.*;
import com.web.airplane.demo.repositories.AircraftRepository;
import com.web.airplane.demo.repositories.AirportRepository;
import com.web.airplane.demo.repositories.BookingTicketRepository;
import com.web.airplane.demo.repositories.FlightRepository;
import com.web.airplane.demo.services.AircraftService;
import com.web.airplane.demo.services.BookingTicketService;
import com.web.airplane.demo.services.FlightService;
import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/flight")
@Slf4j
public class FlightController {
    @Autowired
    private BookingTicketRepository bookingTicketRepository;
    @Autowired
    private BookingTicketService bookingTicketService;
    @Autowired
    private AircraftService aircraftService;
    private final FlightRepository flightRepository;
    private final AircraftRepository aircraftRepository;
    @Autowired
    private FlightService flightService;
    @Autowired
    private AirportRepository airportRepository;

    public FlightController(FlightRepository flightRepository, AircraftRepository aircraftRepository) {
        this.flightRepository = flightRepository;
        this.aircraftRepository = aircraftRepository;
    }



    @PreAuthorize("hasRole('ADMIN_FLIGHT')")
    @GetMapping("/flightList")
    public List<FlightInfo> getFlightList() {
        log.debug("Get flight list");
        List<Flight> flights = flightRepository.findAll();
        List<FlightInfo> flightInfoList = new ArrayList<>();
        for (Flight flight : flights) {
            FlightInfo newFlightInfo = flightService.getFlightInfo(flight);
            flightInfoList.add(newFlightInfo);
        }
        log.debug("success load flight list");
        return flightInfoList;
    }

    @PreAuthorize("hasRole('ADMIN_FLIGHT')")
    @GetMapping("/passengers")
    public List<Passenger> getAllPassengers(@RequestParam("flight_id") long flightId) {
        return flightRepository.findById(flightId).get().getPassengers();
    }

    @PreAuthorize("hasRole('ADMIN_FLIGHT')")
    @PostMapping("/addFlight")
    public ResponseEntity<?> addFlight(@RequestBody FlightInfo flightInfo) {
        try {
            // Validate flight info
            if (!validateFlightInfo(flightInfo)) {
                return ResponseEntity.badRequest().body("Invalid flight information. Please check all required fields.");
            }

            Aircraft aircraft = aircraftRepository.findBySerialNumber(flightInfo.getSerialNumber());
            if (aircraft == null) {
                return ResponseEntity.badRequest().body("Aircraft with given serial number not found.");
            }


            // Kiểm tra xem có chuyến bay nào đã tồn tại với cùng mã chuyến bay, mã máy bay và thời gian bay không
            boolean isFlightExist = flightRepository.existsByExpectedArrivalTimeAndFlightNumberAndAircraft(
                    flightInfo.getExpectedArrivalTime(),
                    flightInfo.getFlightNumber(),
                    aircraft
            );

            if (isFlightExist) {
                // Trả về lỗi nếu có chuyến bay trùng
                return ResponseEntity.badRequest().body("Flight with the same flight number, aircraft code, and expected departure time already exists.");
            }
            flightInfo.setFlightNumber(flightService.generateFlightNumber(flightInfo.getDepartureCode(), flightInfo.getArrivalCode()));
            flightInfo.setCancelDueTime(flightInfo.getExpectedDepartureTime().minusHours(2));
            // Nếu không có chuyến bay trùng, tiến hành thêm chuyến bay mới
            Flight flight = flightService.createFlight(flightInfo);
            aircraft.setStatus("Active");
            aircraft.getFlights().add(flight);
            aircraftRepository.save(aircraft);
            // Lưu chuyến bay mới vào cơ sở dữ liệu
            flightRepository.save(flight);
            // Trả về phản hồi thành công
            return ResponseEntity.ok("Flight added successfully.");
        } catch (Exception e) {
            // Trả về lỗi nếu có bất kỳ vấn đề nào xảy ra
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred while adding the flight.");
        }
    }

    private boolean validateFlightInfo(FlightInfo flightInfo) {
        log.debug("Validate flight info");
        // Check for null values
        if (flightInfo == null) return false;
        // Validate required fields
        if (flightInfo.getSerialNumber() == null || flightInfo.getSerialNumber().trim().isEmpty() ||
            flightInfo.getDepartureCode() == null || flightInfo.getDepartureCode().trim().isEmpty() ||
            flightInfo.getArrivalCode() == null || flightInfo.getArrivalCode().trim().isEmpty() ||
            flightInfo.getExpectedDepartureTime() == null ||
            flightInfo.getExpectedArrivalTime() == null) {
                
            return false;
        }
        
        // Validate departure time is before arrival time
        if (flightInfo.getExpectedDepartureTime().isAfter(flightInfo.getExpectedArrivalTime())) {
            return false;
        }
        
        // Validate airport codes are different
        if (flightInfo.getDepartureCode().equals(flightInfo.getArrivalCode())) {
            return false;
        }
        return true;
    }


    @PreAuthorize("hasRole('ADMIN_FLIGHT')")
    @DeleteMapping("/deleteFlight")
    @Transactional
    public ResponseEntity<?> deleteFlight(@RequestParam(name = "flight_number") String flightNumber ) {
        try {
            Flight flight = flightRepository.findByFlightNumber(flightNumber);
            Aircraft aircraft = flight.getAircraft();
            aircraft.getFlights().remove(flight);
            flightRepository.delete(flight);
            return ResponseEntity.ok().body("Xoá chuyến bay thành công");
        } catch (Exception e) {
            log.debug(e.getMessage());
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/public/getAircraft")
    // Todo: Chỉnh thành get list ghế ngồi, thêm vào aircraftInfo
    public AircraftInfo getAircraft(@RequestParam(name = "flight_number") String flightNumber) {
        log.debug("Get aircraft info");
        Flight flight = flightRepository.findByFlightNumber(flightNumber);
        Aircraft aircraft = flight.getAircraft();
        return aircraftService.getAircraftInfo(aircraft);
    }

    @GetMapping("/public/getSeatList")
    public ResponseEntity<?> getSeatList(@RequestParam(name = "flight_number") String flightNumber) {
        log.debug("Get seat list");
        try {
            List<List<Boolean>> seatList = flightService.getSeatList(flightNumber);
            return ResponseEntity.ok(seatList);
        } catch (Exception e) {
            log.debug(e.getMessage());
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    /**
     *
     * @param flightInfo
     *      destination airport
     *      departure airport
     *      expected departure time
     *      expected destination time
     * @return list of flightInfo
     */
    @PostMapping("/public/findFlight")
    public List<FlightInfo> findFlight(@RequestBody FlightInfo flightInfo) {
        log.debug("Find flight");

        // Find and filter outbound flights
        List<Flight> flights;
        log.debug(flightInfo.toString());
        flights = findAndFilterFlights(flightInfo.getDepartureCode(),
                flightInfo.getArrivalCode(), flightInfo);

        if (flights.isEmpty()) {
            log.debug("Khong tim thay chuyen bay phu hop");
            return List.of();
        }

        List<FlightInfo> flightInfoList = new ArrayList<>();
        for (Flight flight : flights) {
            FlightInfo tempFlightInfo = flightService.getFlightInfo(flight);


            log.debug((flight.getFirstAvailableSeats()) + " " + flight.getEconomyAvailableSeats() 
            + " " + flight.getBusinessAvailableSeats() + " " + flightInfo.getNumOfTicketRequest());
            
            tempFlightInfo.setAvailableFirstSeats((flight.getFirstAvailableSeats() - flightInfo.getNumOfTicketRequest() >= 0));
            tempFlightInfo.setAvailableEconomySeats((flight.getEconomyAvailableSeats() - flightInfo.getNumOfTicketRequest() >= 0));
            tempFlightInfo.setAvailableBusinessSeats((flight.getBusinessAvailableSeats() - flightInfo.getNumOfTicketRequest() >= 0));
            if(tempFlightInfo.isAvailableBusinessSeats() 
            || tempFlightInfo.isAvailableEconomySeats() 
            || tempFlightInfo.isAvailableFirstSeats()) flightInfoList.add(tempFlightInfo);
        }
        return flightInfoList;
    }


    private List<Flight> findAndFilterFlights(String departureAirportCode, String destinationAirportCode, FlightInfo flightInfo) {
        log.debug("Tìm chuyến bay từ " + departureAirportCode + " đến " + destinationAirportCode);

        // Step 1: Find all flights between the two airports
        List<Flight> flights;
        flights = flightRepository.findAllByDepartureAirportAndDestinationAirport(
                airportRepository.findByAirportCode(departureAirportCode),
                airportRepository.findByAirportCode(destinationAirportCode)
        );
        log.debug(flights.toString());
        log.debug(flightInfo.toString());
        if (flights.isEmpty()) return new ArrayList<>();
        log.debug("THấy chuyến");
        List<Flight> filteredFlights = new ArrayList<>();
        for (Flight flight : flights) {
                if (flight.getExpectedDepartureTime().getDayOfMonth() == flightInfo.getExpectedDepartureTime().getDayOfMonth()
                        && flight.getExpectedDepartureTime().getMonth() == flightInfo.getExpectedDepartureTime().getMonth()
                ) {
                    filteredFlights.add(flight);
                    log.debug("Tim thay may bay tu" + departureAirportCode + " den " + destinationAirportCode);
                }
        }

        return filteredFlights;
    }

    boolean isWithinOneWeek(LocalDateTime timeToCheck, LocalDateTime ms) {
        LocalDateTime oneWeekBefore = ms.minusWeeks(1);
        LocalDateTime oneWeekAfter = ms.plusWeeks(1);

        return (timeToCheck.isEqual(oneWeekBefore) || timeToCheck.isAfter(oneWeekBefore)) &&
                (timeToCheck.isEqual(oneWeekAfter) || timeToCheck.isBefore(oneWeekAfter));
    }

    @PreAuthorize("hasRole('ADMIN_FLIGHT')")
    @PutMapping("/editFlight")
    @Transactional
    public ResponseEntity<?> editFlight(@RequestBody FlightInfo flightInfo) {
        try {
            return ResponseEntity.ok(flightService.editFlight(flightInfo));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PreAuthorize("hasRole('ADMIN_FLIGHT')")
    @PostMapping("/getTicketList")
    public ResponseEntity<?> getTicketListInfo() {
        List<BookingTicket> bookingTickets = bookingTicketRepository.findAll();
        log.debug("Get ticket list + " + bookingTickets.size());
        return ResponseEntity.ok(bookingTickets.stream()
                .map(bookingTicket -> bookingTicketService.getBookingTicketInfo(bookingTicket))
                .collect(Collectors.toList()));
    }
}