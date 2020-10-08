package com.javaex.vo;

public class InterestVo {
	
	private int fieldNo;
	private String fieldName;
	
	private InterestVo() {}

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
		return "InterestVo [fieldNo=" + fieldNo + ", fieldName=" + fieldName + "]";
	}
	

}
