package com.javaex.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.UserService;
import com.javaex.vo.AddressVo;
import com.javaex.vo.InterestVo;
import com.javaex.vo.UserVo;


@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService; 

    @RequestMapping("/signUpStart")
    public String signUpStart() {
    	System.out.println("/signUpStart");

        return "user/signUp";

    }
 
    @RequestMapping("/signUpForm")
    public String signUpForm() {
    	System.out.println("/signUpForm");
    	
        return "user/signUpCommon";
    }

    @RequestMapping("/signUp")
    public String signUp(@ModelAttribute UserVo vo,
    					Model model) {
    	System.out.println("/signUp");

    	if(userService.checkSignUp(vo)) {
			vo = userService.signUp(vo);
			System.out.println("가입시켜요");
		} else {
			System.out.println("가입하지마");
		}

    	model.addAttribute("vo", vo);
    	
    	
    	if(vo.getUserType().equals("trainer")) {
    		List<String> provinceList = userService.getAddress();
    		model.addAttribute("provinceList", provinceList);
    		
    		List<InterestVo> interestList = userService.getInterestList();
    		model.addAttribute("interestList", interestList);
    		
    		return "user/signUpServe";
    		
    	}else {
    		
    		return "user/signUpComplete";
    	}
    }
    
    @RequestMapping("/signUpComplete")
    public String signUpComplete(@ModelAttribute UserVo vo,
    							@ModelAttribute AddressVo address,
    							@RequestParam("fieldNo") List<String> fieldList,
    							@RequestParam("careerRecord") List<String> careerList,
    							@RequestParam("birth") List<String> birthList,
    							Model model) {
    	System.out.println("/signUpComplete");
    	System.out.println(vo);
    	
    	userService.updateProfile(vo, address, fieldList, careerList, birthList);
    	
    	model.addAttribute("vo", vo);
    	
    	return "user/signUpComplete";
    }
    

  //API controller
    @ResponseBody
    @RequestMapping("/idCheck")
    public boolean idCheck(String newId) {
    	System.out.println("/idCheck");
    	
    	int sameId = userService.idCheck(newId);
		boolean result = false;
		
		if(sameId == 0) {
			result = true;
		}
		
		return result;
    }
    
    @ResponseBody
    @RequestMapping("/getCity")
    public List<String> getCity(String thisProvince) {
    	System.out.println("/getCity");
    	
    	List<String> cityList = userService.getCityList(thisProvince);
		
		return cityList;
    }
    
    @ResponseBody
    @RequestMapping("/getRegion")
    public List<String> getRegion(String thisCity) {
    	System.out.println("/getCity");
    	
    	List<String> regionList = userService.getRegionList(thisCity);
		
		return regionList;
    }
    
    @ResponseBody
    @RequestMapping("/login")
    public boolean login(String userId, String userPw, HttpSession session) {
    	System.out.println("/login");
    	
    	UserVo authUser = userService.login(userId, userPw);
    	
    	if(authUser != null) { //로그인 성공 시
    		session.setAttribute("authUser", authUser);
    		
    		return true;
    	} else{ //로그인 실패 시
    		
    		return false;
    	}
    }
    
    @ResponseBody
    @RequestMapping("/deleteCareer")
    public String deleteCareer(int careerNo) {
    	System.out.println("/deleteCareer");
    	
    	userService.deleteCareer(careerNo);
    	
    	return "";
    }
}
