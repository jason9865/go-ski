package com.go.ski.user.support.vo;

import com.go.ski.payment.support.vo.Age;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter
public class GenderConvert implements AttributeConverter<Gender, String> {
	@Override
	public String convertToDatabaseColumn(Gender attribute) {
		return attribute != null ? attribute.getValue() : null;
	}

	@Override
	public Gender convertToEntityAttribute(String dbData) {
		return dbData != null ? Gender.fromValue(dbData) : null;
	}
}
