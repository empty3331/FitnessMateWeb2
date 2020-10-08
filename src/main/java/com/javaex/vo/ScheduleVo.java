package com.javaex.vo;

public class ScheduleVo {
    private int scheduleNo, ptNo, amount, trainerNo;
    private String state, memo, startTime, endTime, userId, userName;

    public ScheduleVo() {
    }

    public ScheduleVo(int scheduleNo, int ptNo, int amount, int trainerNo, String state, String memo, String startTime, String endTime, String userId, String userName) {
        this.scheduleNo = scheduleNo;
        this.ptNo = ptNo;
        this.amount = amount;
        this.trainerNo = trainerNo;
        this.state = state;
        this.memo = memo;
        this.startTime = startTime;
        this.endTime = endTime;
        this.userId = userId;
        this.userName = userName;
    }

    public ScheduleVo(int scheduleNo, String startTime) {
		this.scheduleNo = scheduleNo;
		this.startTime = startTime;
	}

	public int getScheduleNo() {
        return scheduleNo;
    }

    public void setScheduleNo(int scheduleNo) {
        this.scheduleNo = scheduleNo;
    }

    public int getPtNo() {
        return ptNo;
    }

    public void setPtNo(int ptNo) {
        this.ptNo = ptNo;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public int getTrainerNo() {
        return trainerNo;
    }

    public void setTrainerNo(int trainerNo) {
        this.trainerNo = trainerNo;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Override
    public String toString() {
        return "ScheduleVo{" +
                "scheduleNo=" + scheduleNo +
                ", ptNo=" + ptNo +
                ", amount=" + amount +
                ", trainerNo=" + trainerNo +
                ", state='" + state + '\'' +
                ", memo='" + memo + '\'' +
                ", startTime='" + startTime + '\'' +
                ", endTime='" + endTime + '\'' +
                ", userId='" + userId + '\'' +
                ", userName='" + userName + '\'' +
                '}';
    }
}
