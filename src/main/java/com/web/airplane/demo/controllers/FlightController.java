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
    @GetMapping("/public/findFlight")
    public List<FlightInfo> findFlight(@RequestBody FlightInfo flightInfo) {
        // Lấy danh sách các chuyến bay theo mã sân bay
        List<Flight> flights = flightRepository.findAllByDepartureAirportAndDestinationAirport(
                airportRepository.findByAirportCode(flightInfo.getDepartureAirportCode()),
                airportRepository.findByAirportCode(flightInfo.getDestinationAirportCode())
        );


        if (flights.isEmpty()) return List.of();


        List<Flight> filterFlightList = new ArrayList<>();
        for (Flight flight : flights) {
            if (isWithinOneWeek(flight.getExpectedDepartureTime(), flightInfo.getExpectedDepartureTime()) &&
                    isWithinOneWeek(flight.getExpectedArrivalTime(), flightInfo.getExpectedArrivalTime())) {
                filterFlightList.add(flight);
            }
        }


        List<FlightInfo> flightInfoList = new ArrayList<>();
        for (Flight flight : filterFlightList) {
            flightInfoList.add(flightService.getFlightInfo(flight));
        }

        return flightInfoList;
    }

    boolean isWithinOneWeek(LocalDateTime timeToCheck, LocalDateTime ms) {
        LocalDateTime oneWeekBefore = ms.minusWeeks(1);
        LocalDateTime oneWeekAfter = ms.plusWeeks(1);

        return (timeToCheck.isEqual(oneWeekBefore) || timeToCheck.isAfter(oneWeekBefore)) &&
                (timeToCheck.isEqual(oneWeekAfter) || timeToCheck.isBefore(oneWeekAfter));
    }
}
