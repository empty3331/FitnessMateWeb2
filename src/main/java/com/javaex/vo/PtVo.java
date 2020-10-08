package com.javaex.vo;

public class PtVo {
	
	private int ptNo;
	private int userNo;
	private String userId;
	private String name;
	private String gender;
	private String phone;
	private String profileImg;
	private String startDate;
	private String endDate;	
	private int intEndDate;
	private int regCount;
	private int scheduleCount;
	private String memo;
	private boolean proceed;

	public PtVo() {}
	
	public int getPtNo() {
		return ptNo;
	}

	public void setPtNo(int ptNo) {
		this.ptNo = ptNo;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public int getIntEndDate() {
		return intEndDate;
	}

	public void setIntEndDate(int intEndDate) {
		this.intEndDate = intEndDate;
	}

	public int getRegCount() {
		return regCount;
	}

	public void setRegCount(int regCount) {
		this.regCount = regCount;
	}

	public int getScheduleCount() {
		return scheduleCount;
	}

	public void setScheduleCount(int scheduleCount) {
		this.scheduleCount = scheduleCount;
	}

	public boolean isProceed() {
		return proceed;
	}

	public void setProceed(boolean proceed) {
		this.proceed = proceed;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	@Override
	public String toString() {
		return "PtVo [ptNo=" + ptNo + ", userNo=" + userNo + ", userId=" + userId + ", name=" + name + ", gender="
				+ gender + ", phone=" + phone + ", profileImg=" + profileImg + ", startDate=" + startDate + ", endDate="
				+ endDate + ", intEndDate=" + intEndDate + ", regCount=" + regCount + ", scheduleCount=" + scheduleCount
				+ ", memo=" + memo + ", proceed=" + proceed + "]";
	}


}
