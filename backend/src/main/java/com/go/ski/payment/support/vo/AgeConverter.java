package com.go.ski.payment.support.vo;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter
public class AgeConverter implements AttributeConverter<Age, String> {

	@Override
	public String convertToDatabaseColumn(Age attribute) {
		return attribute != null ? attribute.getValue() : null;
	}

	@Override
	public Age convertToEntityAttribute(String dbData) {
		return dbData != null ? Age.fromValue(dbData) : null;
	}
}