package com.go.ski.user.support.vo;

import com.go.ski.payment.support.vo.Height;

public enum Gender {
    MALE("남자"),
    FEMALE("여자");
    private final String value;
    Gender (String value) {
        this.value = value;
    }
    public String getValue() {
        return value;
    }
    public static Gender fromValue(String value) {
        for(Gender gender : Gender.values()) {
            if (gender.value.equals(value)) {
                return gender;
            }
        }
        throw new IllegalArgumentException("Unsupported value: " + value);
    }
}
