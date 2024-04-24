package com.go.ski.payment.support.vo;

public enum Age {
	PRESCHOOL_CHILD("미취학 아동"),
	ELEMENTARY("초등"),
	MIDDLE_HIGH("중고등"),
	TWENTIES("20대"),
	THIRTIES("30대"),
	FORTIES("40대"),
	SIXTIES_OVER("60대 이상");

	private final String value;

	Age(String value) {
		this.value = value;
	}

	public String getValue() {
		return value;
	}

	public static Age fromValue(String value) {
		for (Age age: Age.values()) {
			if(age.value.equals(value)) {
				return age;
			}
		}
		throw new IllegalArgumentException("Unsupported value: " + value);
	}
}
