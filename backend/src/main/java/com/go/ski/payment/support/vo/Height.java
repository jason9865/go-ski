package com.go.ski.payment.support.vo;

import com.fasterxml.jackson.annotation.JsonFormat;

public enum Height {
	HEIGHT_UNDER_140CM("140cm 미만"),
	HEIGHT_140CM_TO_150CM("140cm~150cm"),
	HEIGHT_150CM_TO_160CM("150cm~160cm"),
	HEIGHT_160CM_TO_170CM("160cm~170cm"),
	HEIGHT_170CM_TO_180CM("170cm~180cm"),
	HEIGHT_ABOVE_180CM("180cm 이상");

	private final String value;

	Height(String value) {
		this.value = value;
	}

	public String getValue() {
		return value;
	}

	public static Height fromValue(String value) {
		for(Height height : Height.values()) {
			if (height.value.equals(value)) {
				return height;
			}
		}
		throw new IllegalArgumentException("Unsupported value: " + value);
	}


}
