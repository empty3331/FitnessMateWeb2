package com.javaex.vo;

public class ExGraphVo {

	private int maxAmount;
	private int maxCount;
	private String exDate;
	
	public ExGraphVo() {}

	public ExGraphVo(int maxAmount, int maxCount, String exDate) {
		this.maxAmount = maxAmount;
		this.maxCount = maxCount;
		this.exDate = exDate;
	}

	public int getMaxAmount() {
		return maxAmount;
	}

	public void setMaxAmount(int maxAmount) {
		this.maxAmount = maxAmount;
	}

	public int getMaxCount() {
		return maxCount;
	}

	public void setMaxCount(int maxCount) {
		this.maxCount = maxCount;
	}

	public String getExDate() {
		return exDate;
	}

	public void setExDate(String exDate) {
		this.exDate = exDate;
	}

	@Override
	public String toString() {
		return "ExGraphVo [maxAmount=" + maxAmount + ", maxCount=" + maxCount + ", exDate=" + exDate + "]";
	};

	
}
