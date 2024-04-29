package com.go.ski.payment.support.vo;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter
public class HeightConverter implements AttributeConverter<Height, String> {
	@Override
	public String convertToDatabaseColumn(Height attribute) {
		return attribute != null ? attribute.getValue() : null;
	}

	@Override
	public Height convertToEntityAttribute(String dbData) {
		return dbData != null ? Height.fromValue(dbData) : null;
	}

}
