package com.javaex.vo;

public class ReviewVo {
	
	
	private int reviewNo;/*리뷰넘버*/
	private int ptNo;/*피티번호*/
	private String regDate;/*리뷰등록 날짜*/
	private int score;/*평점*/
	private String content;/*리뷰내용*/
	private int userNo;/*회원번호*/
	private int trainerNo;/*트레이너번호*/
	private int scheduleCount;/*트레이닝 횟수*/
	private String name;/*회원이름*/
	private int reviewCount;/*리뷰갯수*/
	private String reviewAvg;/*평점 평균*/
	private String profileImg; /*프로필 이미지*/ 
	private int group_no; /*그룹넘버*/ 
	private int order_no; /*그룹내 글순서*/ 
	
	private String trainerName;/*트레이너 이름*/
	private String trainerImg;/*트레이너 프사*/
	
	private int page;/*페이지*/
	private int pageView;/*페이지*/
	
	private int check_review;/*리뷰,답글 썼는지 체크*/

	public ReviewVo() {}
	
	
	public ReviewVo(int score, String content,int ptNo) {
		this.score = score;
		this.content = content;
		this.ptNo = ptNo;	
	}

	public ReviewVo( int score, String content,int ptNo, int group_no) {
		this.ptNo = ptNo;
		this.score = score;
		this.content = content;
		this.group_no = group_no;
	}

	public ReviewVo(int reviewNo, int ptNo, String regDate, int score, String content, int userNo, int trainerNo,
			int scheduleCount, String name, int reviewCount, String reviewAvg, String profileImg, int group_no,
			int order_no, String trainerName, String trainerImg, int page, int pageView, int check_review) {
		super();
		this.reviewNo = reviewNo;
		this.ptNo = ptNo;
		this.regDate = regDate;
		this.score = score;
		this.content = content;
		this.userNo = userNo;
		this.trainerNo = trainerNo;
		this.scheduleCount = scheduleCount;
		this.name = name;
		this.reviewCount = reviewCount;
		this.reviewAvg = reviewAvg;
		this.profileImg = profileImg;
		this.group_no = group_no;
		this.order_no = order_no;
		this.trainerName = trainerName;
		this.trainerImg = trainerImg;
		this.page = page;
		this.pageView = pageView;
		this.check_review = check_review;
	}
	
	
	


	public int getCheck_review() {
		return check_review;
	}


	public void setCheck_review(int check_review) {
		this.check_review = check_review;
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


	public String getTrainerName() {
		return trainerName;
	}


	public void setTrainerName(String trainerName) {
		this.trainerName = trainerName;
	}


	public String getTrainerImg() {
		return trainerImg;
	}


	public void setTrainerImg(String trainerImg) {
		this.trainerImg = trainerImg;
	}


	public int getGroup_no() {
		return group_no;
	}


	public void setGroup_no(int group_no) {
		this.group_no = group_no;
	}


	public int getOrder_no() {
		return order_no;
	}


	public void setOrder_no(int order_no) {
		this.order_no = order_no;
	}



	public String getProfileImg() {
		return profileImg;
	}


	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	public int getReviewCount() {
		return reviewCount;
	}


	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}


	public String getReviewAvg() {
		return reviewAvg;
	}


	public void setReviewAvg(String reviewAvg) {
		this.reviewAvg = reviewAvg;
	}


	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getScheduleCount() {
		return scheduleCount;
	}
	public void setScheduleCount(int scheduleCount) {
		this.scheduleCount = scheduleCount;
	}
	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	public int getPtNo() {
		return ptNo;
	}
	public void setPtNo(int ptNo) {
		this.ptNo = ptNo;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public int getTrainerNo() {
		return trainerNo;
	}
	public void setTrainerNo(int trainerNo) {
		this.trainerNo = trainerNo;
	}


	@Override
	public String toString() {
		return "ReviewVo [reviewNo=" + reviewNo + ", ptNo=" + ptNo + ", regDate=" + regDate + ", score=" + score
				+ ", content=" + content + ", userNo=" + userNo + ", trainerNo=" + trainerNo + ", scheduleCount="
				+ scheduleCount + ", name=" + name + ", reviewCount=" + reviewCount + ", reviewAvg=" + reviewAvg
				+ ", profileImg=" + profileImg + ", group_no=" + group_no + ", order_no=" + order_no + ", trainerName="
				+ trainerName + ", trainerImg=" + trainerImg + ", page=" + page + ", pageView=" + pageView
				+ ", check_review=" + check_review + "]";
	}


	

}
