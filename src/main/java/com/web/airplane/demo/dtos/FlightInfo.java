package com.web.airplane.demo.dtos;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.time.LocalDateTime;
@Getter
@Setter
@NoArgsConstructor
public class FlightInfo {
    private String flightNumber;
    private String departureCode;
    private String arrivalCode;
    private int numOfTicketRequest;

    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime expectedDepartureTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime expectedArrivalTime;


    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime cancelDueTime;
    private String aircraftCode;
    private String serialNumber;
    private boolean isAvailableFirstSeats;
    private boolean isAvailableBusinessSeats;
    private boolean isAvailableEconomySeats;
    private String status;
    private BigDecimal mealDiscount;
    private BigDecimal ticketDiscount;
    private BigDecimal basePrice;

    public String getManufacture() {
        if (aircraftCode != null && !aircraftCode.isEmpty()) {
            String[] parts = aircraftCode.split("-");
            if (parts.length > 0) {
                return parts[0];  // Trả về phần manufacture
            }
        }
        return null;  // Trả về null nếu aircraftCode không hợp lệ
    }


    public String getModel() {
        if (aircraftCode != null && !aircraftCode.isEmpty()) {
            String[] parts = aircraftCode.split("-");
            if (parts.length > 1) {
                return parts[1];  // Trả về phần model
            }
        }
        return null;  // Trả về null nếu aircraftCode không hợp lệ
    }

    public String getDepartureDate() {
        return expectedDepartureTime.getDayOfMonth() + " tháng "
        + expectedDepartureTime.getMonthValue() + " năm "
        + expectedDepartureTime.getYear();
    }

    public String getDepartureTime() {
        return String.format("%02d:%02d", expectedDepartureTime.getHour(), expectedDepartureTime.getMinute());
    }

    public String getArrivalDate() {
        return expectedArrivalTime.getDayOfMonth() + " "
        + expectedArrivalTime.getMonthValue() + " "
        + expectedArrivalTime.getYear();
    }

    public String getArrivalTime() {
        return String.format("%02d:%02d", expectedArrivalTime.getHour(), expectedArrivalTime.getMinute());
    }

    @Override
    public String toString() {
        return "FlightInfo [flightNumber=" + flightNumber + ", departureCode=" + departureCode + ", arrivalCode=" + arrivalCode + ", numOfTicketRequest=" + numOfTicketRequest + ", expectedDepartureTime=" + expectedDepartureTime + ", expectedArrivalTime=" + expectedArrivalTime + ", cancelDueTime=" + cancelDueTime + ", aircraftCode=" + aircraftCode + ", serialNumber=" + serialNumber + ", isAvailableFirstSeats=" + isAvailableFirstSeats + ", isAvailableBusinessSeats=" + isAvailableBusinessSeats + ", isAvailableEconomySeats=" + isAvailableEconomySeats + ", status=" + status + "]";
    }
}
