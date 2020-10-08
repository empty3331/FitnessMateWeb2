package com.javaex.vo;

public class SearchVo {
    private String province, city, region, location, gender, name;
    private int field, page, pageView;

    public SearchVo() {
    }

    public SearchVo(String province, String city, String region, String location, String gender, String name, int field, int page, int pageView) {
        this.province = province;
        this.city = city;
        this.region = region;
        this.location = location;
        this.gender = gender;
        this.name = name;
        this.field = field;
        this.page = page;
        this.pageView = pageView;
    }

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

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getField() {
        return field;
    }

    public void setField(int field) {
        this.field = field;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getPageView() {
        return pageView;
    }

    public void setPageView(int pageView) {
        this.pageView = pageView;
    }

    @Override
    public String toString() {
        return "SearchVo{" +
                "province='" + province + '\'' +
                ", city='" + city + '\'' +
                ", region='" + region + '\'' +
                ", location='" + location + '\'' +
                ", gender='" + gender + '\'' +
                ", name='" + name + '\'' +
                ", field=" + field +
                ", page=" + page +
                ", pageView=" + pageView +
                '}';
    }
}
