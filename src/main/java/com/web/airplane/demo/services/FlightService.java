package com.web.airplane.demo.services;

import com.web.airplane.demo.dtos.FlightInfo;
import com.web.airplane.demo.models.Aircraft;
import com.web.airplane.demo.models.Airport;
import com.web.airplane.demo.models.Flight;
import com.web.airplane.demo.models.Passenger;
import com.web.airplane.demo.repositories.AircraftRepository;
import com.web.airplane.demo.repositories.AirportRepository;
import com.web.airplane.demo.repositories.FlightRepository;
import com.web.airplane.demo.repositories.PassengerRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Optional;

@Service
@Slf4j
public class FlightService {
    @Autowired
    private FlightRepository flightRepository;
    @Autowired
    private AircraftRepository aircraftRepository;
    @Autowired
    private AirportRepository airportRepository;
    @Autowired
    private PassengerRepository passengerRepository;
    // Phương thức tạo flight mới mà không cần actual times và passengers
    public Flight createFlight(FlightInfo flightInfo) {

        // Tạo đối tượng Flight với các thông tin cần thiết
        Flight flight = new Flight();
        flight.setFlightNumber(flightInfo.getFlightNumber());
        flight.setDepartureAirport(airportRepository.findByAirportCode(flightInfo.getDepartureAirportCode()));
        log.debug("Departure airport " + flightInfo.getDepartureAirportCode() +":" + airportRepository.findByAirportCode(flightInfo.getDepartureAirportCode()));
        flight.setDestinationAirport(airportRepository.findByAirportCode(flightInfo.getDestinationAirportCode()));
        flight.setExpectedDepartureTime(flightInfo.getExpectedDepartureTime());
        flight.setExpectedArrivalTime(flightInfo.getExpectedArrivalTime());
        flight.setAircraft(aircraftRepository.findByManufacturerAndModel(flightInfo.getManufacture(), flightInfo.getModel()));
        flight.setCancelDueTime(flightInfo.getCancelDueTime());

        // Lưu vào cơ sở dữ liệu
        return flightRepository.save(flight);
    }

    public FlightInfo getFlightInfo(Flight flight) {
        FlightInfo flightInfo = new FlightInfo();
        flightInfo.setFlightNumber(flight.getFlightNumber());
        flightInfo.setAircraftCode(flight.getAircraft().getManufacturer() + "-" + flight.getAircraft().getModel());
        flightInfo.setDepartureAirportCode(flight.getDepartureAirport().getAirportCode());
        flightInfo.setDestinationAirportCode(flight.getDestinationAirport().getAirportCode());
        flightInfo.setExpectedArrivalTime(flight.getExpectedArrivalTime());
        flightInfo.setExpectedDepartureTime(flight.getExpectedDepartureTime());
        flightInfo.setActualArrivalTime(flight.getActualArrivalTime());
        flightInfo.setActualDepartureTime(flight.getActualDepartureTime());
        flightInfo.setCancelDueTime(flight.getCancelDueTime());
        return flightInfo;
    }

    public String getNextFirstSeat(Flight flight) {

        Optional<Passenger> optPassenger = passengerRepository.findPassengerWithMaxRowLessThanOrEqual(getMaxFirstRows(flight), flight);

        // Kiểm tra nếu hành khách tồn tại
        if (optPassenger.isPresent()) {
            Passenger passenger = optPassenger.get();

            // Kiểm tra seat position của hành khách
            String currentSeat = passenger.getSeatPosition();
            char seatChar = currentSeat.charAt(0);  // Lấy ký tự ghế (A, B, C, ...)
            int currentRow = passenger.getRow();  // Lấy số hàng hiện tại

            // Nếu ghế là "F", tăng số hàng (row) lên 1
            if (seatChar == 'F') {
                currentRow++;  // Tăng số hàng lên 1
                // Kiểm tra nếu row vượt quá giới hạn cho hạng ghế đầu tiên (max row cho hạng ghế F)
                if (currentRow > getMaxFirstRows(flight)) {
                    return null;  // Nếu row vượt quá giới hạn, trả về null
                }
                return "F" + currentRow;  // Trả về ghế F với số hàng đã tăng
            } else {
                // Nếu ghế không phải là "F", tiếp tục tăng ghế theo bảng chữ cái
                seatChar = (char) (seatChar + 1);
                if (seatChar > 'F') {
                    // Nếu đã đến "F", dừng lại và không cho phép ghế vượt qua "F"
                    return null;
                }
                // Trả về ghế mới (ghế + row)
                return seatChar + String.valueOf(currentRow);
            }
        }

        return "A1";
    }

    public String getNextBusinessSeat(Flight flight) {

        Optional<Passenger> optPassenger = passengerRepository.findPassengerWithMaxRowInRange(getMaxFirstRows(flight) + 1,
                getMaxBusinessRows(flight), flight);

        // Kiểm tra nếu hành khách tồn tại
        if (optPassenger.isPresent()) {
            Passenger passenger = optPassenger.get();

            // Kiểm tra seat position của hành khách
            String currentSeat = passenger.getSeatPosition();
            char seatChar = currentSeat.charAt(0);  // Lấy ký tự ghế (A, B, C, ...)
            int currentRow = passenger.getRow();  // Lấy số hàng hiện tại

            // Nếu ghế là "F", tăng số hàng (row) lên 1
            if (seatChar == 'F') {
                currentRow++;  // Tăng số hàng lên 1
                // Kiểm tra nếu row vượt quá giới hạn cho hạng ghế đầu tiên (max row cho hạng ghế F)
                if (currentRow > getMaxBusinessRows(flight)) {
                    return null;  // Nếu row vượt quá giới hạn, trả về null
                }
                return "F" + currentRow;  // Trả về ghế F với số hàng đã tăng
            } else {
                // Nếu ghế không phải là "F", tiếp tục tăng ghế theo bảng chữ cái
                seatChar = (char) (seatChar + 1);
                if (seatChar > 'F') {
                    // Nếu đã đến "F", dừng lại và không cho phép ghế vượt qua "F"
                    return null;
                }
                // Trả về ghế mới (ghế + row)
                return seatChar + String.valueOf(currentRow);
            }
        }

        return "A" + (getMaxFirstRows(flight) + 1);
    }

    public String getNextEconomySeat(Flight flight) {

        Optional<Passenger> optPassenger = passengerRepository.findPassengerWithMaxRowInRange(getMaxBusinessRows(flight) + 1,
                getMaxEconomyRows(flight), flight);

        // Kiểm tra nếu hành khách tồn tại
        if (optPassenger.isPresent()) {
            Passenger passenger = optPassenger.get();

            // Kiểm tra seat position của hành khách
            String currentSeat = passenger.getSeatPosition();
            char seatChar = currentSeat.charAt(0);  // Lấy ký tự ghế (A, B, C, ...)
            int currentRow = passenger.getRow();  // Lấy số hàng hiện tại

            // Nếu ghế là "F", tăng số hàng (row) lên 1
            if (seatChar == 'F') {
                currentRow++;  // Tăng số hàng lên 1
                // Kiểm tra nếu row vượt quá giới hạn cho hạng ghế đầu tiên (max row cho hạng ghế F)
                if (currentRow > getMaxBusinessRows(flight)) {
                    return null;  // Nếu row vượt quá giới hạn, trả về null
                }
                return "F" + currentRow;  // Trả về ghế F với số hàng đã tăng
            } else {
                // Nếu ghế không phải là "F", tiếp tục tăng ghế theo bảng chữ cái
                seatChar = (char) (seatChar + 1);
                if (seatChar > 'F') {
                    // Nếu đã đến "F", dừng lại và không cho phép ghế vượt qua "F"
                    return null;
                }
                // Trả về ghế mới (ghế + row)
                return seatChar + String.valueOf(currentRow);
            }
        }


        return "A" + (getMaxBusinessRows(flight) + 1);
    }


    private int getMaxFirstRows(Flight flight) {
        int maxFirstSeats = flight.getFirstSeats();
        return maxFirstSeats/6;
    }

    private int getMaxBusinessRows(Flight flight) {
        int maxBusinessSeats = flight.getBusinessSeats();
        return getMaxFirstRows(flight) + maxBusinessSeats/6;
    }

    private int getMaxEconomyRows(Flight flight) {
        return (flight.getFirstSeats() + flight.getBusinessSeats() + flight.getEconomySeats())/6;
    }
}
