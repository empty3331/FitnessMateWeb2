package com.javaex.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.SearchService;
import com.javaex.vo.ReviewVo;
import com.javaex.vo.UserVo;

@Controller
public class SearchController {

    @Autowired
    private SearchService searchService;

    //주소(구) 가져오기
    @ResponseBody
    @RequestMapping("/search/getCity")
    public List<Object> getCity(@RequestParam("province") String province) {
        List<Object> pro = searchService.addCity(province);

        return pro;
    }

    //주소(동) 가져오기
    @ResponseBody
    @RequestMapping("/search/getRegion")
    public List<Object> getRegion(@RequestParam("city") String city) {
        List<Object> reg = searchService.addRegion(city);

        return reg;
    }


    // 트레이너 세부정보 불러오기
    @ResponseBody
    @RequestMapping("/search/trainerInfo")
    public UserVo trainerInfo(@RequestParam("no") int no) {
        UserVo uVo = searchService.trainerInfo(no);

        return uVo;

    }

    // 트레이너 세부정보 불러오기(전문분야)
    @ResponseBody
    @RequestMapping("/search/fieldInfo")
    public List<Object> fieldInfo(@RequestParam("no") int no) {

        List<Object> uVo = searchService.fieldInfo(no);
        return uVo;

    }

    // 트레이너 세부정보 불러오기(수상경력)
    @ResponseBody
    @RequestMapping("/search/recordInfo")
    public List<Object> recordInfo(@RequestParam("no") int no) {

        List<Object> uVo = searchService.recordInfo(no);
        return uVo;

    }


    //트레이너 세부정보 불러오기(리뷰)
    @ResponseBody
    @RequestMapping("/search/reviewInfo")
    public List<Object> reviewInfo(@RequestParam("no") int no) {
        List<Object> uVo = searchService.reviewInfo(no);

        return uVo;

    }


    //리뷰정보 불러오기/////////////////////////////////////////////////////////////////////////
    // 리뷰목록 불러오기
    @ResponseBody
    @RequestMapping("/search/reviewList")
    public Map<String, Object> reviewList(@RequestBody ReviewVo reviewVo) {
    	
    	System.out.println("컨트롤러"+reviewVo);
    	

        return searchService.reviewList(reviewVo);

    }

//    @ResponseBody
//    @RequestMapping("/search/reviewPage")
//    public int reviewPage(@RequestParam("trainerNo") int trainerNo) {
//        // 페이지 정보불러오기
//        Map<String, Integer> r = searchService.reviewCount(trainerNo);
//
//        int count = r.get("count");
//
//        return count;
//    }


    // 리뷰작성 가능한 사람인지 확인
    @ResponseBody
    @RequestMapping("/search/reviewWrite")
    public ReviewVo reviewWrite(@RequestParam("no") int no) {
        ReviewVo reviewVo = searchService.reviewWrite(no);
        
        System.out.println("리뷰 작성 가능한 사람인가?"+reviewVo);
        return reviewVo;

    }

    // 리뷰 추가위해 pt넘버 불러오기
    @ResponseBody
    @RequestMapping("/search/findPt")
    public int findPt(@RequestParam("userNo") int userNo) {
        System.out.println("controller:/search/findPt");
        int ptNo = searchService.findPt(userNo);

        System.out.println("컨트롤러 pt" + ptNo);

        return ptNo;
    }

    // 리뷰추가
    @ResponseBody
    @RequestMapping("/search/reviewPlus")
    public Map<String, Object> reviewPlus(@RequestBody ReviewVo reviewVo) {
        System.out.println("controller:/search/reviewPlus");
        System.out.println("리뷰추가파람확인" + reviewVo);
        Map<String, Object> rVo = searchService.reviewPlus(reviewVo);
        
        System.out.println("리뷰추가 확인"+rVo);

        return rVo;
    }

    // 답글추가
    @ResponseBody
    @RequestMapping("/search/rereviewPlus")
    public Map<String, Object> rereviewPlus(@RequestBody ReviewVo reviewVo) {
        System.out.println("controller:/search/rereviewPlus");
        System.out.println("파람확인" + reviewVo);
        Map<String, Object> rVo = searchService.rereviewPlus(reviewVo);
        System.out.println("답글 컨트롤러" + reviewVo);

        return rVo;
    }


    // 리뷰수정
    @ResponseBody
    @RequestMapping("/search/reviewModify")
    public Map<String, Object> reviewModify(@RequestBody ReviewVo reviewVo) {
        System.out.println("controller:/search/reviewModify");
        System.out.println("파람확인" +reviewVo);
        Map<String, Object> rVo = searchService.reviewModify(reviewVo);

        System.out.println("리뷰수정정보 제대로 가지고 와지나 확인" + rVo);

        return rVo;
    }

    //리뷰(답글) 삭제
    @ResponseBody
    @RequestMapping("/search/reviewRemove")
    public Map<String, Object> reviewReRemove(@RequestBody ReviewVo reviewVo) {
        System.out.println("controller:/search/reviewRemove");
        System.out.println("리뷰넘버 확인" + reviewVo);
        Map<String, Object> remove = searchService.reviewReRemove(reviewVo);
        
        

        return remove;
    }
    
 

}
