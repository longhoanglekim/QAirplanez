package com.web.airplane.demo.utils;

import lombok.extern.slf4j.Slf4j;
import org.antlr.v4.runtime.misc.Pair;
@Slf4j
public class UserUtil {
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
