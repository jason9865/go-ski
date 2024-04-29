package com.go.ski.payment.support.vo;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter
public class WeightConverter implements AttributeConverter<Weight, String> {

	@Override
	public String convertToDatabaseColumn(Weight attribute) {
		return attribute != null ? attribute.getValue() : null;
	}

	@Override
	public Weight convertToEntityAttribute(String dbData) {
		return dbData != null ? Weight.fromValue(dbData) : null;
	}
}