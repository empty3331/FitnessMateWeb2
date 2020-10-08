package com.javaex.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.CareerVo;
import com.javaex.vo.InterestVo;
import com.javaex.vo.UserVo;

@Repository
public class UserDao {
	
	@Autowired
	private SqlSession sqlSession;

	public int selectSameId(String id) {
		System.out.println("userDao.selectSameId");
		
		return sqlSession.selectOne("user.selectSameId", id);
	}

	public UserVo insertUser(UserVo vo) {
		System.out.println("userDao.insertUser");
		
		sqlSession.insert("user.insertUser", vo);
	
		return vo;
	}

	public List<String> selectAddress() {
		System.out.println("userDao.주소가져오기");
		
		return sqlSession.selectList("user.selectAddress");
	}

	public List<String> selectCity(String thisProvince) {
		System.out.println("userDao.도시가져오기");
		
		return sqlSession.selectList("user.selectCity", thisProvince);
	}

	public List<String> selectRegion(String thisCity) {
		System.out.println("userDao.동네가져오기");
		
		return sqlSession.selectList("user.selectRegion", thisCity);
	}

	public List<InterestVo> selectInterestAll() {
		System.out.println("userDao.관심분야가져오기");
		
		return sqlSession.selectList("user.selectInterestAll");
	}

	public void updateTrainerInfo(UserVo vo) {
		System.out.println("userDao.트레이너 정보 수정");
		System.out.println(vo);
		
		sqlSession.update("user.updateTrainerInfo", vo);
	}

	public void insertInterest(Map<String, Object> interestMap) {
		System.out.println("userDao.전문분야 insert");
		
		sqlSession.insert("user.insertInterest", interestMap);
	}

	public void insertCareer(Map<String, Object> careerMap) {
		System.out.println("userDao.경력 insert");
		System.out.println(careerMap);
		
		sqlSession.insert("user.insertCareer", careerMap);
		
	}

	public UserVo selectUser(UserVo userVo) {
		System.out.println("userDao.로그인!");
		
		return sqlSession.selectOne("user.selectUser", userVo);
	}

	public UserVo selectProfile(int userNo) {
		System.out.println("userDao.기본 프로필");
		
		return sqlSession.selectOne("user.selectProfile", userNo);
	}

	public List<String> selectUserInterest(int userNo) {
		System.out.println("userDao.프로필 전문분야");

		return sqlSession.selectList("user.selectUserInterest", userNo);
	}

	public List<CareerVo> selectCareerList(int userNo) {
		System.out.println("userDao.프로필 경력상세");

		return sqlSession.selectList("user.selectCareerList", userNo);
	}

	public void deleteInterest(int userNo) {
		System.out.println("userDao.전문분야 초기화");

		sqlSession.delete("user.deleteInterest", userNo);
	}
	

	public void deleteCareer(int careerNo) {
		System.out.println("userDao.커리어지우기");

		sqlSession.delete("user.deleteCareer", careerNo);
	}

	public void updateUserInfo(UserVo vo) {
		System.out.println("userDao.일반유저 정보 수정");
		
		sqlSession.update("user.updateUserInfo", vo);
	}

	
}
