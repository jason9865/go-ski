package com.go.ski.payment.support.vo;

public enum Weight {
	WEIGHT_UNDER_40KG("40kg 이하"),
	WEIGHT_40KG_TO_49KG("40kg~49kg"),
	WEIGHT_50KG_TO_59KG("50kg~59kg"),
	WEIGHT_60KG_TO_69KG("60kg~69kg"),
	WEIGHT_70KG_TO_79KG("70kg~79kg"),
	WEIGHT_80KG_TO_89KG("80kg~89kg"),
	WEIGHT_90KG_TO_99KG("90kg~99kg"),
	WEIGHT_OVER_100KG("100kg 초과");

	private final String value;

	Weight (String value) {
		this.value = value;
	}

	public String getValue(String value) {
		return value;
	}

	public Weight fromValue(String value){
		for(Weight weight : Weight.values()) {
			if(weight.value.equals(value)) {
				return weight;
			}
		}
		throw new IllegalArgumentException("Unsupported value: " + value);
	}
}
