package com.web.airplane.demo.services;

import com.web.airplane.demo.dtos.FlightInfo;

import com.web.airplane.demo.dtos.bookings.FlightResponse;
import com.web.airplane.demo.enums.FlightStatus;
import com.web.airplane.demo.models.Flight;
import com.web.airplane.demo.models.Notification;
import com.web.airplane.demo.models.Passenger;
import com.web.airplane.demo.repositories.*;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

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

    @Autowired
    private NotificationRepository notificationRepository;
    // Phương thức tạo flight mới mà không cần actual times và passengers
    public Flight createFlight(FlightInfo flightInfo) {

        // Tạo đối tượng Flight với các thông tin cần thiết
        Flight flight = new Flight();
        flight.setFlightNumber(flightInfo.getFlightNumber());
        flight.setDepartureAirport(airportRepository.findByAirportCode(flightInfo.getDepartureCode()));
        log.debug("Departure airport " + flightInfo.getDepartureCode() +":" + airportRepository.findByAirportCode(flightInfo.getDepartureCode()));
        flight.setDestinationAirport(airportRepository.findByAirportCode(flightInfo.getArrivalCode()));
        flight.setExpectedDepartureTime(flightInfo.getExpectedDepartureTime());
        flight.setExpectedArrivalTime(flightInfo.getExpectedArrivalTime());
        flight.setStatus(flightInfo.getStatus());
        flight.setAircraft(aircraftRepository.findBySerialNumber(flightInfo.getSerialNumber()));
        flight.setCancelDueTime(flightInfo.getCancelDueTime());
        flight.setMealDiscount(flightInfo.getMealDiscount());
        flight.setTicketDiscount(flightInfo.getTicketDiscount());
        int numberOfSeats = flight.getAircraft().getNumberOfSeats();
        int firstAvailableSeats = (int) (numberOfSeats * 0.1);
        int businessAvailableSeats = (int) (numberOfSeats * 0.2);
        int economyAvailableSeats = numberOfSeats - firstAvailableSeats - businessAvailableSeats;
        flight.setFirstAvailableSeats(firstAvailableSeats);
        flight.setBusinessAvailableSeats(businessAvailableSeats);
        flight.setEconomyAvailableSeats(economyAvailableSeats);
        // Lưu vào cơ sở dữ liệu
        return flightRepository.save(flight);
    }

    public FlightInfo getFlightInfo(Flight flight) {
        FlightInfo flightInfo = new FlightInfo();
        flightInfo.setFlightNumber(flight.getFlightNumber());
        log.debug(flight.getAircraft().getManufacturer() + " -" + flight.getAircraft().getManufacturer());
        flightInfo.setAircraftCode(flight.getAircraft().getManufacturer() + "-" + flight.getAircraft().getModel());
        flightInfo.setDepartureCode(flight.getDepartureAirport().getAirportCode());
        flightInfo.setArrivalCode(flight.getDestinationAirport().getAirportCode());
        flightInfo.setMealDiscount(flight.getMealDiscount());
        flightInfo.setTicketDiscount(flight.getTicketDiscount());
        if (flight.getActualDepartureTime() == null) {
            flightInfo.setExpectedArrivalTime(flight.getExpectedArrivalTime());
            flightInfo.setExpectedDepartureTime(flight.getExpectedDepartureTime());
        } else {
            flightInfo.setExpectedArrivalTime(flight.getActualArrivalTime());
            flightInfo.setExpectedDepartureTime(flight.getActualDepartureTime());
        }
        flightInfo.setCancelDueTime(flight.getCancelDueTime());
        flightInfo.setAvailableFirstSeats(flight.getFirstAvailableSeats() > 0);
        flightInfo.setAvailableBusinessSeats(flight.getBusinessAvailableSeats() > 0);
        flightInfo.setAvailableEconomySeats(flight.getEconomyAvailableSeats() > 0);
        flightInfo.setStatus(flight.getStatus());
        flightInfo.setSerialNumber(flight.getAircraft().getSerialNumber());
        return flightInfo;
    }

    public String getFirstSeatForAutoBooking(Flight flight) {
        for (int row = 1; row <= getMaxFirstRow(flight); row++) {
            // Vòng lặp qua các cột ghế từ A đến F
            log.debug("Chon hang ghe");
            for (char col ='A'; col <= 'F'; col++) {
                if (passengerRepository.findPassengerIfSeatBooked(flight.getId(), row, String.valueOf(col)) == null) {
                    log.debug("Thay ghe");
                    return col + String.valueOf(row);
                }
            }
        }
        return null;
    }

    public String getBusinessSeatForAutoBooking(Flight flight) {
        for (int row = getMaxFirstRow(flight) + 1; row <= getMaxBusinessRow(flight); row++) {
            // Vòng lặp qua các cột ghế từ A đến F
            for (char col ='A'; col <= 'F'; col++) {
                if (passengerRepository.findPassengerIfSeatBooked(flight.getId(), row, String.valueOf(col)) == null) {
                    return col + String.valueOf(row);
                }
            }
        }
        return null;
    }

    public String getEconomySeatForAutoBooking(Flight flight) {
        for (int row = getMaxBusinessRow(flight) + 1; row <= getMaxFirstRow(flight); row++) {
            // Vòng lặp qua các cột ghế từ A đến F
            for (char col ='A'; col <= 'F'; col++) {
                if (passengerRepository.findPassengerIfSeatBooked(flight.getId(), row, String.valueOf(col)) == null) {
                    return col + String.valueOf(row);
                }
            }
        }
        return null;
    }






    private int getMaxFirstRow(Flight flight) {
        int maxFirstSeats = (int) ((flight.getAircraft().getNumberOfSeats()) * 0.1);
        return maxFirstSeats/6;
    }

    private int getMaxBusinessRow(Flight flight) {
        int maxBusinessSeats = (int) ((flight.getAircraft().getNumberOfSeats()) * 0.2) ;
        return getMaxFirstRow(flight) + maxBusinessSeats/6;
    }

    private int getMaxEconomyRow(Flight flight) {
        return flight.getAircraft().getNumberOfSeats()/6;
    }

    // false tức là đã chọn, true là chưa chọn
    public List<List<Boolean>> getSeatList(String flightNumber) {
        Flight flight = flightRepository.findByFlightNumber(flightNumber);
        List<List<Boolean>> seatList = new ArrayList<>();
        // tạo seatList với ban đầu là mảng toàn false
        for (int i = 0; i < flight.getAircraft().getNumberOfSeats()/6; i++) {
            List<Boolean> row = new ArrayList<>();
            for (int j = 0; j < 6; j++) {
                row.add(true);
            }
            seatList.add(row);
        }
        // ITERATOR ALL PASSSENGER LIST IN FLIGHT, AND UPDATE TRUE FOR EACH SEAT
        for (Passenger passenger : flight.getPassengers()) {
            int row = passenger.getSeatRow() - 1;
            int col = passenger.getSeatPosition().charAt(0) - 'A';
            seatList.get(row).set(col, false);
        }
        return seatList;
    }

    public FlightInfo editFlight(FlightInfo flightInfo) {
        log.debug("Edit flight: " + flightInfo);
        Flight flight = flightRepository.findByFlightNumber(flightInfo.getFlightNumber());
        flight.setDepartureAirport(airportRepository.findByAirportCode(flightInfo.getDepartureCode()));
        flight.setDestinationAirport(airportRepository.findByAirportCode(flightInfo.getArrivalCode()));

        if (!flight.getExpectedDepartureTime().equals(flightInfo.getExpectedDepartureTime()) ||
                !flight.getExpectedArrivalTime().equals(flightInfo.getExpectedArrivalTime())) {

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm dd/MM/yyyy");
            String originalTime = flight.getExpectedDepartureTime().format(formatter);
            Notification notification = new Notification();

            if (flight.getExpectedDepartureTime().isBefore(flightInfo.getExpectedDepartureTime())) {
                // Trường hợp hoãn chuyến
                Duration delay = Duration.between(flight.getExpectedDepartureTime(), flightInfo.getExpectedDepartureTime());

                long days = delay.toDays();
                long hours = delay.minusDays(days).toHours();

                StringBuilder delayMessage = new StringBuilder();
                if (days > 0) {
                    delayMessage.append(days).append(" ngày ");
                }
                if (hours > 0) {
                    delayMessage.append(hours).append(" giờ");
                }

                notification.setTitle("Chuyến bay với mã số " + flight.getFlightNumber()
                        + " đã bị hoãn " + delayMessage);

                notification.setContent("Chuyến bay với mã số " + flight.getFlightNumber()
                        + " có thời gian khởi hành dự kiến ban đầu là " + originalTime
                        + " đã bị hoãn " + delayMessage
                        + " do lí do sắp xếp lịch trình.");
                notification.setType("Flight");
                flight.setStatus("Delayed");
            } else {
                // Trường hợp đẩy sớm chuyến
                Duration early = Duration.between(flightInfo.getExpectedDepartureTime(), flight.getExpectedDepartureTime());

                long days = early.toDays();
                long hours = early.minusDays(days).toHours();

                StringBuilder earlyMessage = new StringBuilder();
                if (days > 0) {
                    earlyMessage.append(days).append(" ngày ");
                }
                if (hours > 0) {
                    earlyMessage.append(hours).append(" giờ");
                }

                notification.setTitle("Chuyến bay với mã số " + flight.getFlightNumber()
                        + " đã được đẩy sớm " + earlyMessage);

                notification.setContent("Chuyến bay với mã số " + flight.getFlightNumber()
                        + " có thời gian khởi hành dự kiến ban đầu là " + originalTime
                        + " đã được đẩy sớm " + earlyMessage
                        + " do lí do sắp xếp lịch trình.");
                flight.setStatus("Advanced");
            }

            flight.setActualDepartureTime(flightInfo.getExpectedDepartureTime());
            flight.setActualArrivalTime(flightInfo.getExpectedArrivalTime());

            // Lưu notification vào database hoặc gửi notification
            notificationRepository.save(notification); // Thêm dòng này nếu cần
        }

        flight.setAircraft(aircraftRepository.findBySerialNumber(flightInfo.getSerialNumber()));
        flight.setStatus(flightInfo.getStatus());
        flight.setCancelDueTime(flightInfo.getCancelDueTime());

        flightRepository.save(flight);
        return getFlightInfo(flight);
    }
    public String generateFlightNumber(String departureCityCode, String arrivalCityCode) {
        Random random = new Random();
        String flightNumber;
        boolean isUnique;

        do {
            int randomNumber = 100 + random.nextInt(900);
            flightNumber = departureCityCode.toUpperCase() + arrivalCityCode.toUpperCase() + randomNumber;
            isUnique = (flightRepository.findByFlightNumber(flightNumber) == null);
        } while (!isUnique);

        return flightNumber;
    }

    public FlightResponse getFlightResponse(Flight flight) {
        FlightResponse flightInfo = new FlightResponse();
        flightInfo.setFlightNumber(flight.getFlightNumber());

        StringBuilder departCode = new StringBuilder(airportRepository.findByAirportCode(flight.getDepartureAirport().getAirportCode()).getCity());
        departCode.append("(").append(flight.getDepartureAirport().getAirportCode()).append(")");
        flightInfo.setDepartAirportCode(departCode.toString());
        StringBuilder arrivalCode = new StringBuilder(airportRepository.findByAirportCode(flight.getDestinationAirport().getAirportCode()).getCity());
        arrivalCode.append("(").append(flight.getDestinationAirport().getAirportCode()).append(")");
        flightInfo.setArrivalAirportCode(arrivalCode.toString());
        flightInfo.setArrivalTime(flight.getExpectedArrivalTime());
        flightInfo.setDepartTime(flight.getExpectedDepartureTime());
        flightInfo.setCancelTime(flight.getCancelDueTime());
        flightInfo.setSerialNumber(flight.getAircraft().getSerialNumber());
        flightInfo.setStatus(flight.getStatus());
        return flightInfo;
    }
}