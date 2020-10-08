package com.javaex.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.javaex.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.MypageService;
import com.javaex.service.UserService;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	
	@Autowired
	private MypageService mypageService;
	
	@Autowired
	private UserService userService; 
	
    @RequestMapping("/schedule")
    public String schedule(HttpSession session, Model model) {
        UserVo user = (UserVo) session.getAttribute("authUser");

        if("trainer".equals(user.getUserType())) {
            List<PtVo> ptList  = mypageService.getTraineeList(user.getUserNo());
            model.addAttribute("ptList", ptList);
            List<ScheduleVo> scheduleList = mypageService.getScheduleList(user.getUserNo());
            model.addAttribute("scheduleList", scheduleList);
            
            //매 페이지마다 들어가는 상단 요약정보
            model.addAttribute("summary", mypageService.summary(user.getUserNo()));
            
            return "mypage/schedule";

        }else {
            return "error";
        }
    }
    
    @RequestMapping("/manageExercise")
    public String manageTraining(HttpSession session, Model model) {
        UserVo user = (UserVo) session.getAttribute("authUser");

        if("trainer".equals(user.getUserType())) {
            List<ExerciseVo> showList = mypageService.showList();
            int trainerNo = user.getUserNo();
            List<ExerciseVo> exList = mypageService.getExList(trainerNo);

            List<ScheduleVo> scheduleList = mypageService.getScheduleList(user.getUserNo());
            model.addAttribute("scheduleList", scheduleList);

            model.addAttribute("showList", showList);
            model.addAttribute("exList", exList);
            
            //매 페이지마다 들어가는 상단 요약정보
            model.addAttribute("summary", mypageService.summary(user.getUserNo()));
            return "mypage/manageExercise";
            
        }else {
            return "error";
        }
    }

    @ResponseBody
    @RequestMapping("/addExercise")
    public ExerciseVo addExercise(HttpSession session, @RequestBody ExerciseVo exVo) {
        UserVo user = (UserVo) session.getAttribute("authUser");
        exVo.setTrainerNo(user.getUserNo());
        return mypageService.addExercise(exVo);
    }

    @ResponseBody
    @RequestMapping("/showExPart")
    public List<ExerciseVo> showExPart(HttpSession session, @RequestBody ExerciseVo exVo) {
        UserVo user = (UserVo) session.getAttribute("authUser");
        exVo.setTrainerNo(user.getUserNo());
        return mypageService.showExPart(exVo);
    }

    @ResponseBody
    @RequestMapping("/deleteExercise")
    public boolean deleteExercise(HttpSession session, @RequestBody ExerciseVo exVo) {
        UserVo user = (UserVo) session.getAttribute("authUser");
        exVo.setTrainerNo(user.getUserNo());
        
        return mypageService.deleteExercise(exVo);
    }

    @RequestMapping("/profile")
    public String profile(HttpSession session, Model model) {

       	UserVo userVo = (UserVo)session.getAttribute("authUser");
       	
       	Map<String, Object> proMap = mypageService.getProfile(userVo.getUserType(), userVo.getUserNo());
       	
       	model.addAttribute("profile", proMap);
       	
       	if("trainer".equals(userVo.getUserType())) {
       		
            //매 페이지마다 들어가는 상단 요약정보
            model.addAttribute("summary", mypageService.summary(userVo.getUserNo()));
            List<ScheduleVo> scheduleList = mypageService.getScheduleList(userVo.getUserNo());
            model.addAttribute("scheduleList", scheduleList);


        }else {
            //매 페이지마다 들어가는 상단 요약정보 - 일반
        	model.addAttribute("summaryNormal", mypageService.summaryNormal(userVo.getUserNo()));
        }


       	return "mypage/profile";
    }
    
    @RequestMapping("/recordEx")
    public String recordEx(HttpSession session, Model model) {
        UserVo user = (UserVo) session.getAttribute("authUser");

        if("trainer".equals(user.getUserType())) {
            List<ExerciseVo> partList = mypageService.partList(user.getUserNo());

            model.addAttribute("partList", partList);
            
            //매 페이지마다 들어가는 상단 요약정보
            model.addAttribute("summary", mypageService.summary(user.getUserNo()));
            List<ScheduleVo> scheduleList = mypageService.getScheduleList(user.getUserNo());
            model.addAttribute("scheduleList", scheduleList);
        }else {
        }
    	
        return "mypage/recordEx";
    }

    
    //API controller
    @ResponseBody
    @RequestMapping("/addRecord")
    public int addRecord(@RequestBody List<RecordVo> recordList) {
        return mypageService.recordExercise(recordList);
    }

    //프로필 수정
    @RequestMapping("/modifyProfile")
    public String modifyProfile(@ModelAttribute UserVo vo,
								@ModelAttribute AddressVo address,
								@RequestParam(value="fieldNo", required=false) List<String> fieldList,
								@RequestParam(value="careerRecord", required=false) List<String> careerList,
								@RequestParam(value="birth", required=false) List<String> birthList) {
    	
    	userService.updateProfile(vo, address, fieldList, careerList, birthList);
    	
        return "redirect:/mypage/profile";
    }
    
    //스케쥴 추가
    @ResponseBody
    @RequestMapping("/addSchedule")
    public boolean addSchedule(@RequestBody ScheduleVo scheduleVo) {
        return mypageService.addSchedule(scheduleVo);
    }


    //단일 스케쥴 조회
    @ResponseBody
    @RequestMapping("/getSchedule")
    public ScheduleVo getSchedule(@RequestBody ScheduleVo scheduleVo, HttpSession session) {
        return mypageService.getSchedule(scheduleVo);
    }

    //스케쥴 변경
    @ResponseBody
    @RequestMapping("/modifySchedule")
    public boolean modifySchedule(@RequestBody ScheduleVo scheduleVo) {
        return mypageService.modifySchedule(scheduleVo);
    }

    //스케쥴 취소
    @ResponseBody
    @RequestMapping("/changeScheduleState")
    public boolean changeScheduleState(@RequestBody ScheduleVo scheduleVo) {
        return mypageService.changeScheduleState(scheduleVo);
    }

    //스케쥴 삭제
    @ResponseBody
    @RequestMapping("/deleteSchedule")
    public boolean deleteSchedule(@RequestBody ScheduleVo scheduleVo) {
        return mypageService.deleteSchedule(scheduleVo);
    }
    
    //스케쥴 경력사항
    @ResponseBody
    @RequestMapping("/deleteCareer")
    public boolean deleteCareer(int careerNo) {
    	mypageService.deleteCareer(careerNo);
    	
        return true;
    }

    @RequestMapping("/manageUser")
    public String manageUser(HttpSession session, Model model) {
        UserVo user = (UserVo) session.getAttribute("authUser");
        List<PtVo> ptList = mypageService.getTraineeList(user.getUserNo());

        if("trainer".equals(user.getUserType())) {
            model.addAttribute("ptList", ptList);

            //매 페이지마다 들어가는 상단 요약정보
            model.addAttribute("summary", mypageService.summary(user.getUserNo()));

        }else {
            return "error";
        }
        return "mypage/manageUser";
    }

    @RequestMapping("/inbodyRecord")
    public String inbodyRecord(HttpSession session, Model model) {
        System.out.println("마이페이지 인바디보기");
        UserVo user = (UserVo) session.getAttribute("authUser");

        if("normal".equals(user.getUserType())) {
            Map<String, Object> inbodyInfo= mypageService.getUserInbodyList(user.getUserNo());
            model.addAttribute("inbodyInfo", inbodyInfo);

            //매 페이지마다 들어가는 상단 요약정보
            model.addAttribute("summaryNormal", mypageService.summaryNormal(user.getUserNo()));

            return "mypage/userInbodyView";

        }else {
            System.out.println("트레이너는 여기 오면 안돼요");
            return "error";
        }
    }

    @RequestMapping("/exerciseRecord")
    public String exerciseRecord(HttpSession session, Model model) {
        System.out.println("마이페이지 운동기록 보기");
        UserVo user = (UserVo) session.getAttribute("authUser");

        if("normal".equals(user.getUserType())) {
            Map<String, Object> exMap = mypageService.getExRecord(user.getUserNo());
            model.addAttribute("exMap", exMap);

            //매 페이지마다 들어가는 상단 요약정보
            model.addAttribute("summaryNormal", mypageService.summaryNormal(user.getUserNo()));

            return "mypage/exerciseRecord";

        }else {
            System.out.println("트레이너는 여기 오면 안돼요");
            return "error";
        }
    }

    //API
    @ResponseBody
    @RequestMapping("/userInfo")
    public Map<String, Object> getUserInfo(int ptNo) {
        System.out.println("마이페이지 컨트롤러 ptInfo");

        return mypageService.getUserInfo(ptNo);
    }

    @ResponseBody
    @RequestMapping("/searchUser")
    public UserVo searchUser(String keyword) {
        System.out.println("마이페이지 컨트롤러 searchUser");

        return mypageService.getUserInfo(keyword);
    }

    @ResponseBody
    @RequestMapping("/addPt")
    public String addPt(int userNo, int period, int regCount, int trainerNo) {
        System.out.println("마이페이지 컨트롤러 pt등록");

        mypageService.addPt(userNo, period, regCount, trainerNo);

        return "success";
    }

    @ResponseBody
    @RequestMapping("/modifyMemo")
    public String modifyMemo(int ptNo, String memo) {
        System.out.println("마이페이지 컨트롤러 pt등록");

        mypageService.modifyMemo(ptNo, memo);

        return "success";
    }

    @ResponseBody
    @RequestMapping("getInbodyInfo")
    public InbodyVo getInbodyInfo(int inbodyNo) {
        System.out.println("마이페이지 컨트롤러 인바디 정보");

        return mypageService.getInbodyInfo(inbodyNo);
    }

    @ResponseBody
    @RequestMapping("/saveInbody")
    public InbodyVo saveInbody(int ptNo, float weight, float percentFat, float muscleMass, float bmi) {
        System.out.println("마이페이지 컨트롤러 인바디 저장");

        return mypageService.saveInbody(ptNo, weight, percentFat, muscleMass, bmi);
    }

    @ResponseBody
    @RequestMapping("/extendPt")
    public Map<String, Object> extendPt(int ptNo, int extendMonth, int extendCount) {
        System.out.println("마이페이지 컨트롤러 pt추가");

        mypageService.extendPt(ptNo, extendMonth, extendCount);

        //변경된 정보 가져오기
        return mypageService.getUserInfo(ptNo);
    }

    @ResponseBody
    @RequestMapping("/showExRecord")
    public Map<String, Object> showExRecord(int scheduleNo) {
        return mypageService.getThisRecord(scheduleNo);
    }


    @ResponseBody
    @RequestMapping("/showExGraph")
    public List<ExGraphVo> showExGraph(int userNo, int exNo) {
        return mypageService.getExGraph(userNo, exNo);
    }
}
