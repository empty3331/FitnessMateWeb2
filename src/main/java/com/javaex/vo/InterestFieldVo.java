package com.javaex.vo;

public class InterestFieldVo {
	
	private int fieldNo;
	private String fieldName;
	
	
	public InterestFieldVo() {}
	public InterestFieldVo(int fieldNo, String fieldName) {
		this.fieldNo = fieldNo;
		this.fieldName = fieldName;
	}
	
	
	public int getFieldNo() {
		return fieldNo;
	}
	public void setFieldNo(int fieldNo) {
		this.fieldNo = fieldNo;
	}
	public String getFieldName() {
		return fieldName;
	}
	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}
	
	
	@Override
	public String toString() {
		return "InterestFieldVo [fieldNo=" + fieldNo + ", fieldName=" + fieldName + "]";
	}
	
	
	
	
	
	

}
