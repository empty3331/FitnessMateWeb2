package com.javaex.vo;

public class InbodyVo {
	
	private int inbodyNo;
	private int ptNo;
	private String measureDate;
	private float weight;
	private float percentFat;
	private float muscleMass;
	private float bmi;
	
	public InbodyVo() {}
	
	public InbodyVo(int ptNo, float weight, float percentFat, float muscleMass, float bmi) {
		this.ptNo = ptNo;
		this.weight = weight;
		this.percentFat = percentFat;
		this.muscleMass = muscleMass;
		this.bmi = bmi;
	}

	public int getInbodyNo() {
		return inbodyNo;
	}

	public void setInbodyNo(int inbodyNo) {
		this.inbodyNo = inbodyNo;
	}

	public int getPtNo() {
		return ptNo;
	}

	public void setPtNo(int ptNo) {
		this.ptNo = ptNo;
	}

	public String getMeasureDate() {
		return measureDate;
	}

	public void setMeasureDate(String measureDate) {
		this.measureDate = measureDate;
	}

	public float getWeight() {
		return weight;
	}

	public void setWeight(float weight) {
		this.weight = weight;
	}

	public float getPercentFat() {
		return percentFat;
	}

	public void setPercentFat(float percentFat) {
		this.percentFat = percentFat;
	}

	public float getMuscleMass() {
		return muscleMass;
	}

	public void setMuscleMass(float muscleMass) {
		this.muscleMass = muscleMass;
	}

	public float getBmi() {
		return bmi;
	}

	public void setBmi(float bmi) {
		this.bmi = bmi;
	}

	@Override
	public String toString() {
		return "InbodyVo [inbodyNo=" + inbodyNo + ", ptNo=" + ptNo + ", measureDate=" + measureDate + ", weight="
				+ weight + ", percentFat=" + percentFat + ", muscleMass=" + muscleMass + ", bmi=" + bmi + "]";
	}
	
}
