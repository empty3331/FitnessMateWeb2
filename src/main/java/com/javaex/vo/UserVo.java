package com.javaex.vo;

public class UserVo {

	private int userNo; /* 회원번호 PK */
	private String career; /* 경력 */
	private String userId; /* 아이디 */
	private String password; /* 패스워드 */
	private String name; /* 이름 */
	private String gender; /* 성별 */
	private String phone; /* 전화번호 */
	private String birthDate; /* 생년월일 */
	private String userType; /* 회원구분 */
	private String profileImg; /* 프로필img경로 */
	private String introduction; /* 자기소개 */
	private String location; /* 지역 */
	private String company; /* 소속회사 */
	private String price; /* 가격 */
	private String fieldNo; /* 전문분야 고유넘버 */
	private String fieldName;/* 전문분야  */
	private String invisible; /* 프로필 공개여부 */
	private String workingHours; /* PT운영시간 */
	
	
	public UserVo() {}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getCareer() {
		return career;
	}

	public void setCareer(String career) {
		this.career = career;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
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

	public String getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getFieldNo() {
		return fieldNo;
	}

	public void setFieldNo(String fieldNo) {
		this.fieldNo = fieldNo;
	}

	public String getFieldName() {
		return fieldName;
	}

	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}

	public String getInvisible() {
		return invisible;
	}

	public void setInvisible(String invisible) {
		this.invisible = invisible;
	}

	public String getWorkingHours() {
		return workingHours;
	}

	public void setWorkingHours(String workingHours) {
		this.workingHours = workingHours;
	}

	@Override
	public String toString() {
		return "UserVo [userNo=" + userNo + ", career=" + career + ", userId=" + userId + ", password=" + password
				+ ", name=" + name + ", gender=" + gender + ", phone=" + phone + ", birthDate=" + birthDate
				+ ", userType=" + userType + ", profileImg=" + profileImg + ", introduction=" + introduction
				+ ", location=" + location + ", company=" + company + ", price=" + price + ", fieldNo=" + fieldNo
				+ ", fieldName=" + fieldName + ", invisible=" + invisible + ", workingHours=" + workingHours + "]";
	}

}
