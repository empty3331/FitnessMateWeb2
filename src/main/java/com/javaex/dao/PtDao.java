package com.javaex.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.InbodyVo;
import com.javaex.vo.PtVo;
import com.javaex.vo.ScheduleVo;
import com.javaex.vo.UserVo;

@Repository
public class PtDao {
	
	@Autowired
	private SqlSession sqlSession;

	public List<PtVo> selectTraineeList(int trainerNo) {
		System.out.println("dao 트레이니 리스트");
		
		List<PtVo> ptList = sqlSession.selectList("pt.selectTraineeList", trainerNo);
		System.out.println(ptList);
		
		return ptList;
	}

	public PtVo selectPtInfo(int ptNo) {
		System.out.println("dao 트레이니 인포");
		
		PtVo ptVo = sqlSession.selectOne("pt.selectPtInfo", ptNo);
		System.out.println(ptVo);
		
		return ptVo;
	}

	public UserVo selectUserInfo(String keyword) {
		System.out.println("dao 회원 검색");

		return sqlSession.selectOne("pt.selectUserInfo", keyword);
	}

	public void insertPt(Map<String, Integer> regMap) {
		System.out.println("dao pt 추가");
		
		sqlSession.insert("pt.insertPt", regMap);
	}

	public void updateMemo(Map<String, Object> memoMap) {
		System.out.println("dao 메모 수정");
		
		sqlSession.update("pt.updateMemo", memoMap);
	}

	public List<InbodyVo> selectInbodyList(int ptNo) {
		System.out.println("dao 인바디 리스트");
		
		return sqlSession.selectList("pt.selectInbodyList", ptNo);
	}

	public InbodyVo selectInbodyInfo(int inbodyNo) {
		System.out.println("dao 인바디 정보");
		
		return sqlSession.selectOne("pt.selectInbodyInfo", inbodyNo);
	}

	public void insertInbody(InbodyVo inbodyVo) {
		System.out.println("dao 인바디 저장하기");
		
		sqlSession.insert("pt.insertInbody", inbodyVo);
	}

	public void updatePt(Map<String, Integer> extendMap) {
		System.out.println("dao pt 연장");
		
		sqlSession.update("pt.updatePt", extendMap);
	}

	public List<InbodyVo> selectUserInbodyList(int userNo) {
		System.out.println("dao 개인회원 인바디리스트");
		
		return sqlSession.selectList("pt.selectUserInbodyList", userNo);
	}

	public InbodyVo selectRecentInbody(int userNo) {
		System.out.println("dao 개인회원 최근 인바디");
		
		return sqlSession.selectOne("pt.selectRecentInbody", userNo);
	}

	public PtVo summaryNormal(int userNo) {
		System.out.println("dao 개인회원 최근 인바디");
		
		return sqlSession.selectOne("pt.summaryNormal", userNo);
	}

	public ScheduleVo nextPt(int userNo) {
		System.out.println("dao 개인회원 최근 인바디");
		
		return sqlSession.selectOne("pt.nextPt", userNo);
	}

	public List<ScheduleVo> selectReserveList(int userNo) {
		System.out.println("dao 개인회원 예약 내역");
		
		return sqlSession.selectList("pt.selectReserveList", userNo);
	}
	
}
