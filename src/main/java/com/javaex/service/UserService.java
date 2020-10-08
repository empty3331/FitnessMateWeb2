package com.javaex.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.UserDao;
import com.javaex.vo.AddressVo;
import com.javaex.vo.InterestVo;
import com.javaex.vo.UserVo;

@Service
public class UserService {
	
	@Autowired
	private UserDao userDao;

	public int idCheck(String id) {
		return userDao.selectSameId(id);
	}
	
	public UserVo signUp(UserVo vo) {
		return userDao.insertUser(vo);
	}

	public boolean checkSignUp(UserVo userVo) {
		String userId = userVo.getUserId();
		return userDao.selectSameId(userId) != 1;
	}

	public List<String> getAddress() {
		return userDao.selectAddress();
	}

	public List<String> getCityList(String thisProvince) {
		return userDao.selectCity(thisProvince);
	}

	public List<String> getRegionList(String thisCity) {
		return userDao.selectRegion(thisCity);
	}

	public List<InterestVo> getInterestList() {
		return userDao.selectInterestAll();
	}

	public void updateProfile(UserVo vo, AddressVo addressVo, List<String> fieldList, List<String> careerList, List<String> birthList) {
		//날짜 합치기
		String birthDate = birthList.get(0).substring(2)+"/"+birthList.get(1)+"/"+birthList.get(2);
		
		vo.setBirthDate(birthDate);
		
		if("normal".equals(vo.getUserType())) {
			userDao.updateUserInfo(vo);
			
		}else {
			//이전 전문분야 지우기
			userDao.deleteInterest(vo.getUserNo());
			
			//주소 합치기
			String address = "";
	
			if(addressVo == null) {
				address = " | | ";
			}else {
				address = addressVo.getProvince()+"|"+addressVo.getCity()+"|"+addressVo.getRegion();
			}
			
			vo.setLocation(address);
		
			userDao.updateTrainerInfo(vo);
			
			Map<String, Object> interestMap = new HashMap<>();
			interestMap.put("userNo", vo.getUserNo());
	
			if(fieldList != null) {
	
				for(String fieldNo : fieldList) {
					interestMap.put("fieldNo", fieldNo);
					userDao.insertInterest(interestMap);
				}
			}
			
			if(careerList != null) {
				Map<String, Object> careerMap = new HashMap<>();
				careerMap.put("userNo", vo.getUserNo());
				
				for(String career : careerList) {
					careerMap.put("career", career);
					userDao.insertCareer(careerMap);
				}
			}
		}
		
	}

	public UserVo login(String userId, String userPw) {
		UserVo userVo = new UserVo();
		userVo.setUserId(userId);
		userVo.setPassword(userPw);
		
		return userDao.selectUser(userVo);
	}

	public void deleteCareer(int careerNo) {
		userDao.deleteCareer(careerNo);
	}
}
