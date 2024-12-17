package com.web.airplane.demo.services;

import com.web.airplane.demo.repositories.PassengerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Random;


@Service
public class BookingCodeService {

    @Autowired
    private PassengerRepository passengerRepository;



    public String generateBookingCode() {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        Random random = new Random();
        String bookingCode;

        int codeLength = 6 + random.nextInt(3);  // 6 + random value from 0 to 2 (i.e. 6, 7, or 8)

        // Tiếp tục tạo mã cho đến khi không trùng với mã đã có trong CSDL
        do {
            StringBuilder code = new StringBuilder();
            for (int i = 0; i < codeLength; i++) {  // Mã có chiều dài ngẫu nhiên
                int randomIndex = random.nextInt(characters.length());
                code.append(characters.charAt(randomIndex));
            }
            bookingCode = code.toString();
        } while (passengerRepository.existsPassengerByBookingCode(bookingCode));  // Kiểm tra tính duy nhất trong DB

        return bookingCode;
    }
}
