package com.go.ski.notification.support.generators;

import com.fasterxml.jackson.databind.ObjectMapper;

import java.time.format.DateTimeFormatter;

public interface MessageGenerator {

    boolean VALIDATE_ONLY = false;
    DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("yyyy:MM:dd:HH:mm:ss");

    String makeMessage(
            String targetToken,
            ObjectMapper objectMapper
    );

}
