package com.web.airplane.demo.dtos;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;
@Getter
@Setter
@NoArgsConstructor
public class BookingInfo {
    private String flightNumber;
    private String departureAirportCode;
    private String destinationAirportCode;

    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime expectedDepartureTime;

    private LocalDateTime expectedArrivalTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime expectedReturnTime;



    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime cancelDueTime;

    private String aircraftCode;


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
}
