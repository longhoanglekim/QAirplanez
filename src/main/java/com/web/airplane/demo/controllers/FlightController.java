package com.web.airplane.demo.controllers;

import com.web.airplane.demo.dtos.FlightInfo;
import com.web.airplane.demo.models.Aircraft;
import com.web.airplane.demo.models.Airport;
import com.web.airplane.demo.models.Flight;
import com.web.airplane.demo.models.Passenger;
import com.web.airplane.demo.repositories.AircraftRepository;
import com.web.airplane.demo.repositories.AirportRepository;
import com.web.airplane.demo.repositories.FlightRepository;
import com.web.airplane.demo.services.FlightService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cglib.core.Local;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api/flight")
@Slf4j
public class FlightController {
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

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @GetMapping("/admin/passengers")
    public List<Passenger> getAllPassengers(@RequestParam("flight_id") long flightId) {
        return flightRepository.findById(flightId).get().getPassengers();
    }

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @PostMapping("/admin/addFlight")
    public ResponseEntity<?> addFlight(@RequestBody FlightInfo flightInfo) {
        try {
            Aircraft aircraft =  aircraftRepository.findByManufacturerAndModel(flightInfo.getManufacture(), flightInfo.getModel());
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

            // Nếu không có chuyến bay trùng, tiến hành thêm chuyến bay mới
            Flight flight = flightService.createFlight(flightInfo);
            // Lưu chuyến bay mới vào cơ sở dữ liệu
            flightRepository.save(flight);

            // Trả về phản hồi thành công
            return ResponseEntity.ok("Flight added successfully.");
        } catch (Exception e) {
            // Trả về lỗi nếu có bất kỳ vấn đề nào xảy ra
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred while adding the flight.");
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

    public List<List<FlightInfo>> findFlight(@RequestBody FlightInfo flightInfo) {
        // Find and filter outbound flights
        List<Flight> departFlights = findAndFilterFlights(flightInfo.getDepartureAirportCode(), flightInfo.getDestinationAirportCode(), flightInfo);
        List<Flight> returnFlights = findAndFilterFlights(flightInfo.getDestinationAirportCode(), flightInfo.getDepartureAirportCode(), flightInfo);
        if (departFlights.isEmpty() && returnFlights.isEmpty()) {
            log.debug("Khong tim thay chuyen bay phu hop");
            return List.of();
        }

        List<FlightInfo> departFlightInfoList = new ArrayList<>();
        for (Flight flight : departFlights) {
            departFlightInfoList.add(flightService.getFlightInfo(flight));
        }
        List<FlightInfo> returnFlightInfoList = new ArrayList<>();
        for (Flight flight : returnFlights) {
            returnFlightInfoList.add(flightService.getFlightInfo(flight));
        }
        List<List<FlightInfo>> foundFlights = new ArrayList<>();
        foundFlights.add(departFlightInfoList);
        foundFlights.add(returnFlightInfoList);
        return foundFlights;
    }


    private List<Flight> findAndFilterFlights(String departureAirportCode, String destinationAirportCode, FlightInfo flightInfo) {
        log.debug("Tìm chuyến bay từ " + departureAirportCode + " đến " + destinationAirportCode);

        // Step 1: Find all flights between the two airports
        List<Flight> flights = flightRepository.findAllByDepartureAirportAndDestinationAirport(
                airportRepository.findByAirportCode(departureAirportCode),
                airportRepository.findByAirportCode(destinationAirportCode)
        );
        if (flights.isEmpty()) return null;
        List<Flight> filteredFlights = new ArrayList<>();
        for (Flight flight : flights) {
            if (isWithinOneWeek(flight.getExpectedDepartureTime(), flightInfo.getExpectedDepartureTime()) &&
                    isWithinOneWeek(flight.getExpectedArrivalTime(), flightInfo.getExpectedArrivalTime())) {
                filteredFlights.add(flight);
                log.debug("Tim thay may bay");
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
}
