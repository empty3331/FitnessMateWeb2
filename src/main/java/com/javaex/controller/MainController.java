 package com.javaex.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.javaex.vo.SearchVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.javaex.service.SearchService;
import com.javaex.vo.AddressVo;
import com.javaex.vo.InterestFieldVo;
import com.javaex.vo.UserVo;

 @Controller
public class MainController {
	
	@Autowired
	private SearchService searchService;
	

    @RequestMapping("/main")
    public String Main(Model model) {


		//지역 불러오기
		List<AddressVo> addVo = searchService.addProvince();
		//지역정보 받기
		model.addAttribute("addVo", addVo);

		//전문분야 불러오기
		List<InterestFieldVo> fieldVo = searchService.addField();
		//전문분야 받기
		model.addAttribute("fieldVo", fieldVo);

        return "index";
    }

    @ResponseBody
	@RequestMapping("/search")
	public Map<String, Object> search(@RequestBody SearchVo searchVo) {
		System.out.println(searchVo);
		return searchService.getTrainerListMap(searchVo);
	}
    
	@RequestMapping("/logout")
	public String logout(HttpSession session) {

		session.removeAttribute("authUser");
		session.invalidate();
		
		return "redirect:/main";
	}
	

}