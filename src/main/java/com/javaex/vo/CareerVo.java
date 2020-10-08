package com.javaex.vo;

public class CareerVo {
	
	private int careerNo;
	private int userNo;
	private String recordInfo;
	
	public CareerVo() {}

	public int getCareerNo() {
		return careerNo;
	}

	public void setCareerNo(int careerNo) {
		this.careerNo = careerNo;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getRecordInfo() {
		return recordInfo;
	}

	public void setRecordInfo(String recordInfo) {
		this.recordInfo = recordInfo;
	}

	@Override
	public String toString() {
		return "CareerVo [careerNo=" + careerNo + ", userNo=" + userNo + ", recordInfo=" + recordInfo + "]";
	}
	
}
