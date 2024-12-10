package com.web.airplane.demo.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;

@Entity
@Table(name="passengers")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Passenger {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long passengerId;
    @NotBlank
    private String firstName;
    @NotBlank
    private String lastName;


    @Pattern(regexp = "^[0-9]+$", message = "Số điện thoại chỉ được chứa các chữ số")
    @Size(min = 10, max = 10, message = "Số điện thoại phải có đúng 9 chữ số")
    private String phoneNumber;

    private String passportNumber;

    @NotNull(message = "Email không được để trống")
    @Email(message = "Địa chỉ email không hợp lệ")
    @Size(max = 100, message = "Email không được vượt quá 100 ký tự")
    private String email;
    @NotNull
    @ManyToOne
    private TicketClass ticketClass;


    private String bankName;
    private LocalDate birthdate;

    @NotNull
    private Integer seatRow;

    @NotBlank
    private String seatPosition;

    @NotNull
    @ManyToOne
    private Flight flight;

    private String identification;

    private String bookingCode;

    @NotNull
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
}
