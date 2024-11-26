package com.web.airplane.demo.dtos;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class BusinessCabbageInfo {
    private double handBaggageWeight;
    private int handBaggageCount;

    private double checkedBaggageWeight;
    private int checkedBaggageCount;
}
