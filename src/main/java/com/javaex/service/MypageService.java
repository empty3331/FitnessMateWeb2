package com.javaex.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.javaex.dao.*;
import com.javaex.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MypageService {

	@Autowired
	private PtDao ptDao;
	
	@Autowired
	private UserDao userDao;

	@Autowired
	private ExerciseDao exerciseDao;

	@Autowired
	private RecordDao recordDao;

	@Autowired
	private ScheduleDao scheduleDao;

	/* 프로필수정 페이지로 이동 */
	public Map<String, Object> getProfile(String userType, int userNo) {
		System.out.println("/마이페이지 서비스/프로필 수정");
		
		//데이터 화면으로 보내줄 맵
		Map<String, Object> proMap = new HashMap<>();

		//기본프로필
		UserVo vo = userDao.selectProfile(userNo);
		proMap.put("userVo", vo);
		if("trainer".equals(userType)) {

			//주소 자를 배열
			String[] splitAddress = new String[3];
			
			//주소 자르기
			if(vo.getLocation() != null) {
				splitAddress = vo.getLocation().split("[|]");
				proMap.put("splitAddress", splitAddress);
			}else {
				splitAddress = " | | ".split("[|]");
				proMap.put("splitAddress", splitAddress);
			}
			
			//생년월일 자르기
			if(vo.getBirthDate() != null) {
				String[] splitBirthDate = vo.getBirthDate().split("[/]");
				proMap.put("splitBirthDate", splitBirthDate);
			}
			
			//경력상세
			List<CareerVo> careerList = userDao.selectCareerList(userNo);
			proMap.put("careerList", careerList);

			//user 선택 전문분야
			List<String> userInterest = userDao.selectUserInterest(userNo); 
			proMap.put("userInterest", userInterest);

			//전체 전문분야 리스트
			List<InterestVo> interestList = userDao.selectInterestAll(); 
			proMap.put("interestList", interestList);
			
			//기본 주소 정보들
			List<String> provinceList = userDao.selectAddress();
			List<String> cityList = userDao.selectCity(splitAddress[0]);
			List<String> regionList = userDao.selectRegion(splitAddress[1]);

			//맵에 기본 데이터 넣기
			proMap.put("provinceList", provinceList);
			proMap.put("cityList", cityList);
			proMap.put("regionList", regionList);
		}
		
		return proMap;
	}

	public List<ExerciseVo> getExList(int trainerNo) {
		return  exerciseDao.getList(trainerNo);
	}
	public List<ExerciseVo> showList() {
		return  exerciseDao.showList();
	}

	public List<ExerciseVo> partList(int trainerNo) {
		return  exerciseDao.partList(trainerNo);
	}

	public ExerciseVo addExercise(ExerciseVo exVo) {
		exerciseDao.insert(exVo);
		int exNo = exVo.getExNo();
		return exerciseDao.selectByNo(exNo);
	}

	public Boolean deleteExercise(ExerciseVo exVo) {
		return exerciseDao.delete(exVo);
	}

	public int recordExercise(List<RecordVo> recordList) {
		return recordDao.insertRecordList(recordList);
	}

	public List<ExerciseVo> showExPart(ExerciseVo exVo) {
		return exerciseDao.showExPart(exVo);
	}

	public boolean addSchedule(ScheduleVo scheduleVo) {
		return scheduleDao.insert(scheduleVo);
	}

	public List<ScheduleVo> getScheduleList(int trainerNo) {
		return scheduleDao.getScheduleList(trainerNo);
	}

	public ScheduleVo getSchedule(ScheduleVo scheduleVo) {
		return scheduleDao.getSchedule(scheduleVo);
	}

	public boolean modifySchedule(ScheduleVo scheduleVo) {
		return scheduleDao.modifySchedule(scheduleVo);
	}

	public boolean deleteSchedule(ScheduleVo scheduleVo) {
		return scheduleDao.deleteSchedule(scheduleVo);
	}

	public boolean changeScheduleState(ScheduleVo scheduleVo) {
		return scheduleDao.changeScheduleState(scheduleVo);
	}

	public void deleteCareer(int careerNo) {
		userDao.deleteCareer(careerNo);
	}

	public List<PtVo> getTraineeList(int trainerNo) {
		System.out.println("service 트레이니 리스트 받아오기");

		List<PtVo> ptList = ptDao.selectTraineeList(trainerNo);

		//오늘 날짜
		int today = getToday();

		//pt진행상황 데이터 넣기
		for(PtVo ptVo: ptList) {
			System.out.println(ptVo.getIntEndDate() < today);
			if(ptVo.getIntEndDate() < today || ptVo.getRegCount() <= ptVo.getScheduleCount()) {
				ptVo.setProceed(false);
			}else {
				ptVo.setProceed(true);
			}
		}

		return ptList;
	}

	public Map<String, Object> getUserInfo(int ptNo) {
		System.out.println("service 트레이니 1개 받아오기");
		System.out.println("ptNo : "+ptNo);

		PtVo ptVo = ptDao.selectPtInfo(ptNo);

		List<InbodyVo> inbodyList = ptDao.selectInbodyList(ptNo);
		System.out.println("봅시다"+inbodyList);
		List<RecordVo> recordList = recordDao.getRecordList(ptNo);

		//오늘 날짜
		int today = getToday();

		//pt진행상황 데이터 넣기
		if(ptVo.getIntEndDate() < today || ptVo.getRegCount() < ptVo.getScheduleCount()) {
			ptVo.setProceed(false);
			System.out.println("끝");
		}else {
			ptVo.setProceed(true);
			System.out.println("아직 안끝");
		}

		//화면으로 보내줄 맵
		Map<String, Object> userInfo = new HashMap<>();
		userInfo.put("ptInfo", ptVo); //ptInfo
		userInfo.put("inbodyList", inbodyList);
		userInfo.put("recordList", recordList);

		return userInfo;
	}

	public UserVo getUserInfo(String keyword) {
		System.out.println("service 회원 검색");

		return ptDao.selectUserInfo(keyword);
	}

	public void addPt(int userNo, int period, int regCount, int trainerNo) {
		System.out.println("service pt 추가");

		Map<String, Integer> regMap = new HashMap<>();
		regMap.put("userNo", userNo);
		regMap.put("period", period);
		regMap.put("regCount", regCount);
		regMap.put("trainerNo", trainerNo);

		ptDao.insertPt(regMap);
	}

	public void modifyMemo(int ptNo, String memo) {
		System.out.println("service 메모 수정");

		Map<String, Object> memoMap = new HashMap<>();
		memoMap.put("ptNo", ptNo);
		memoMap.put("memo", memo);

		ptDao.updateMemo(memoMap);
	}

	public InbodyVo getInbodyInfo(int inbodyNo) {

		return ptDao.selectInbodyInfo(inbodyNo);
	}

	public InbodyVo saveInbody(int ptNo, float weight, float percentFat, float muscleMass, float bmi) {
		System.out.println("service 인바디 저장");

		InbodyVo inbodyVo = new InbodyVo(ptNo, weight, percentFat, muscleMass, bmi);

		ptDao.insertInbody(inbodyVo);

		String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		inbodyVo.setMeasureDate(today);

		return inbodyVo;
	}

	public void extendPt(int ptNo, int extendMonth, int extendCount) {
		System.out.println("service pt 연장");

		Map<String, Integer> extendMap = new HashMap<>();
		extendMap.put("ptNo", ptNo);
		extendMap.put("extendMonth", extendMonth);
		extendMap.put("extendCount", extendCount);

		ptDao.updatePt(extendMap);
	}

	public Map<String, Object> getUserInbodyList(int userNo) {
		System.out.println("service 개인회원 인바디리스트");

		Map<String, Object> inbodyInfo = new HashMap<>();
		inbodyInfo.put("inbodyList", ptDao.selectUserInbodyList(userNo));
		inbodyInfo.put("recentInbody", ptDao.selectRecentInbody(userNo));

		return inbodyInfo;
	}

	public Map<String, Object> summary(int userNo) {
		//평점, 리뷰갯수 vo에 담아오기
		SummaryVo summaryVo = scheduleDao.getReviewCount(userNo);

		//누적회원
		summaryVo.setCountAll(scheduleDao.countAll(userNo));

		//현재회원
		summaryVo.setCountCurrent(scheduleDao.countCurrent(userNo));

		//오늘 스케쥴 리스트
		List<ScheduleVo> scheduleList = scheduleDao.getTodaySchedule(userNo);

		Map<String, Object> summary = new HashMap<>();
		summary.put("summaryVo", summaryVo);
		summary.put("scheduleList", scheduleList);

		return summary;
	}

	public Map<String, Object> summaryNormal(int userNo) {

		List<ScheduleVo> reserveList = ptDao.selectReserveList(userNo);
		System.out.println(reserveList);

		Map<String, Object> summaryNormal = new HashMap<>();
		summaryNormal.put("ptVo", ptDao.summaryNormal(userNo));
		summaryNormal.put("nextPt", ptDao.nextPt(userNo));
		summaryNormal.put("reserveList", reserveList);

		return summaryNormal;
	}

	public Map<String, Object> getExRecord(int userNo) {

		List<ScheduleVo> dateList = exerciseDao.selectExDate(userNo);
		int scheduleNo = dateList.get(0).getScheduleNo();


		Map<String, Object> exMap = new HashMap<>();
		exMap.put("exRecordDate", dateList);
		exMap.put("exTitleList", exerciseDao.selectEx(scheduleNo));
		exMap.put("exSetList", exerciseDao.selectSet(scheduleNo));
		exMap.put("exPartList", exerciseDao.myPartList(userNo));
		exMap.put("exList", exerciseDao.myExList(userNo));

		return exMap;
	}

	public Map<String, Object> getThisRecord(int scheduleNo) {

		Map<String, Object> thisMap = new HashMap<>();
		thisMap.put("thisExList", exerciseDao.selectEx(scheduleNo));
		thisMap.put("thisSetList", exerciseDao.selectSet(scheduleNo));

		return thisMap;
	}

	public boolean getThisRecord(boolean invisible) {
		return false;
	}


	public List<ExGraphVo> getExGraph(int userNo, int exNo) {

		Map<String, Integer> map = new HashMap<>();
		map.put("userNo", userNo);
		map.put("exNo", exNo);

		return exerciseDao.selectGraphInfo(map);
	}

	//오늘 날짜 가져오기
	public int getToday() {

		String localDate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));

		return Integer.parseInt(localDate);
	}
}
