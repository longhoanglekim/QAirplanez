package com.web.airplane.demo.dtos;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
public class EconomyCabbageInfo {
    private double handBaggageWeight;
    private int handBaggageCount;

    private double checkedBaggageWeight;
    private int checkedBaggageCount;
}
