package com.javaex.vo;

public class AddressVo {
	

	//필드
	private String province; //시,도
	private String city;	//구
	private String region;	//동
	
	//생성자
	public AddressVo() {}
	
	
	public AddressVo(String province, String city, String region) {
		super();
		this.province = province;
		this.city = city;
		this.region = region;
	}

	//g/s
	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	//toString
	@Override
	public String toString() {
		return "AddressVo [province=" + province + ", city=" + city + ", region=" + region + "]";
	}
	

}
