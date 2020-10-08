package com.javaex.dao;

import java.util.List;
import java.util.Map;

import com.javaex.vo.*;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SearchDao {
	
	@Autowired
	private SqlSession sqlSession;

	// 지역정보 받기
	public List<AddressVo> provinceList() {
		System.out.println("searchDao:province list");

		return sqlSession.selectList("search.addressProvince");
	}

	// 구정보 받기
	public List<Object> cityList(String province) {
		System.out.println("searchDao:city list");
		System.out.println(province);

		return sqlSession.selectList("search.addressCity", province);
	}

	// 동정보 받기
	public List<Object> regionList(String city) {
		System.out.println("searchDao:region list");
		System.out.println(city);

		return sqlSession.selectList("search.addressRegion", city);
	}

	///////////////////////////////////////////////////////

	// 전문분야 정보 받기
	public List<InterestFieldVo> fieldList() {
		System.out.println("searchDao:field list");
		return sqlSession.selectList("search.fieldname");
	}

	//트레이너리스트 카운트 받기
	public int getTrainerCount(SearchVo searchVo) {
		return sqlSession.selectOne("search.getTrainerCount", searchVo);
	}

	//트레이너 리스트 받기
	public List<UserVo> getTrainerList(SearchVo searchVo) {
		return sqlSession.selectList("search.getTrainerList", searchVo);
	}
	///////////////////////////////////////////////////////
	
	//트레이너 세부정보 보기
	public UserVo readTrainer(int no) {
		System.out.println("searchDao:readTrainer");
		
		UserVo uVo = sqlSession.selectOne("search.readTrainer",no);
		
		
		return uVo;
	}

	public List<Object> userField(int no) {
		
		List<Object> uVo = sqlSession.selectList("search.readField",no);
		
		return uVo;
	}

	public List<Object> userRecord(int no) {
		
		
		List<Object> uVo = sqlSession.selectList("search.readCareer",no);
		
		return uVo;
	}
	
	public List<Object> reviewInfo(int no) {
		System.out.println("다오:리뷰정보 불러오기");
		System.out.println("다오"+no);
		List<Object> uVo = sqlSession.selectList("search.readReviewInfo",no);
		
		return uVo;
	}
	
	///////////////////////////////////////////////////////

	//리뷰리스트
	public List<ReviewVo> reviewList(ReviewVo reviewVo) {
		System.out.println("searchDao:reviewList");
		
		System.out.println("다오"+reviewVo);
		List<ReviewVo> rVo = sqlSession.selectList("review.reviewList",reviewVo);
		System.out.println("다오: "+rVo);
		
		return rVo;
	}
	
	//리뷰카운트
	public Integer reviewCount(int i) {
		System.out.println("다오:리뷰페이지 숫자"+i);
		return sqlSession.selectOne("review.reviewCount",i);
	}


	
	public ReviewVo reviewWrite(int no) {
		System.out.println("searchDao:reviewWrite");
		
		ReviewVo reviewWr = sqlSession.selectOne("review.reviewWrite",no);
		System.out.println("리뷰작성자격 다오: "+reviewWr);
		
		return reviewWr;
	}
	


	//리뷰 추가
	public int reviewPlus(ReviewVo vo ) {
		System.out.println("searchDao:reviewPlus");
		
		int reviewVo = sqlSession.insert("review.reviewPlus",vo);
		return reviewVo;
	}
	
	
	//답글 추가
	public int rereviewPlus(ReviewVo vo ) {
		System.out.println("searchDao:rereviewPlus");
		int rereVo = sqlSession.insert("review.rereviewPlus",vo);
		
		return rereVo;
	}
	
	
	//리뷰수정
	public int reviewModify(ReviewVo reviewVo) {
		System.out.println("searchDao:reviewModify");
		
		int vo = sqlSession.update("review.reviewModify",reviewVo);
		return vo;
	}
	
	//추가,수정된 리뷰정보 가지고 오기
	public ReviewVo reviewOne(int reviewNo) {
		System.out.println("searchDao:reviewOne");
		ReviewVo vo =sqlSession.selectOne("review.reviewOne", reviewNo);
		
		return vo;
	}

	//내용 추가위해 pt정보 불러오기
	public int findPt(int userNo) {
		System.out.println("searchDao:findPt");
		
		int ptNo = sqlSession.selectOne("review.findPt", userNo);
		System.out.println(ptNo);
		
		return ptNo;
	}

	//리뷰(답글)삭제위한 정보
	public ReviewVo reviewRemove(ReviewVo reviewVo) {
		System.out.println("searchDao:reviewRemove");
		
		ReviewVo pt = sqlSession.selectOne("review.findPt2",reviewVo);
		System.out.println("pt넘받아와지나 확인"+pt);
		
		return pt;
	}
	
	//리뷰(답글)삭제위한 정보
	public void reviewRemove2(ReviewVo reviewVo) {
		sqlSession.delete("review.reviewRemove", reviewVo);
	}
	
	public void reviewRemove3(ReviewVo reviewVo,int ptNo) {
		sqlSession.delete("review.reviewRemove2",reviewVo);
		sqlSession.update("review.reviewRemove3", ptNo);
		
	}

	
	//이미 리뷰,답글 썼는지 체크
	public void checkReview(int ptNo) {
		System.out.println("searchDao:리뷰쓴거 카운트업");
		
		sqlSession.update("review.checkReview",ptNo);
	}

	

	

	

	

	

	
	

	

	

	

	

	
	

}
