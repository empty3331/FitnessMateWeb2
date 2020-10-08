package com.javaex.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.javaex.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.SearchDao;

@Service
public class SearchService {

    @Autowired
    private SearchDao searchDao;

    //지역목록 불러오기
    public List<AddressVo> addProvince() {
        List<AddressVo> addVo = searchDao.provinceList();
        return addVo;
    }

    //구목록 불러오기
    public List<Object> addCity(String province) {
        List<Object> cityList = searchDao.cityList(province);
        return cityList;
    }

    //동목록 불러오기
    public List<Object> addRegion(String city) {
        List<Object> regionList = searchDao.regionList(city);
        return regionList;
    }

    //전문분야 불러오기
    public List<InterestFieldVo> addField() {
        List<InterestFieldVo> fieldVo = searchDao.fieldList();
        return fieldVo;
    }

    //트레이너 리스트 불러오기
    public Map<String, Object> getTrainerListMap(SearchVo searchVo) {

        // 지역 정보 담기
        String location = "";
        if (searchVo.getRegion() != null && !searchVo.getRegion().equals("")) {
            location = searchVo.getProvince() + "|" + searchVo.getCity() + "|" + searchVo.getRegion();
        } else if (searchVo.getCity() != null && !searchVo.getCity().equals("")) {
            location = searchVo.getProvince() + "|" + searchVo.getCity();
        } else {
            location = searchVo.getProvince();
        }
        searchVo.setLocation(location);

        int pageView = 8; //한 페이지에 표시할 게시물 수
        int pageNum = 5; //화면 하단에 표시할 페이지 최대 갯수
        int currPage = searchVo.getPage() > 0 ? searchVo.getPage() : 1;
        int totalPage = (searchDao.getTrainerCount(searchVo)-1)/pageView + 1;
        int _currPage = (currPage - 1)/pageNum;
        int beginPage = _currPage*pageNum+1;
        int endPage = Math.min(_currPage * pageNum + pageNum, totalPage);

        searchVo.setPage(currPage);
        searchVo.setPageView(pageView);




        List<UserVo> trainerList = searchDao.getTrainerList(searchVo);

        Map<String, Object> trainerListMap = new HashMap<String, Object>();

        trainerListMap.put("pageNum", pageNum);
        trainerListMap.put("currPage", currPage);
        trainerListMap.put("totalPage", totalPage);
        trainerListMap.put("beginPage", beginPage);
        trainerListMap.put("endPage", endPage);
        trainerListMap.put("trainerList", trainerList);

        return trainerListMap;
    }


    //////////////////////////////////////////////////////////

    //트레이너 세부정보 가져오기
    public UserVo trainerInfo(int no) {

        UserVo uVo = searchDao.readTrainer(no);

        return uVo;
    }


    public List<Object> fieldInfo(int no) {

        List<Object> uVo = searchDao.userField(no);

        return uVo;
    }

    public List<Object> recordInfo(int no) {
        List<Object> uVo = searchDao.userRecord(no);
        return uVo;
    }


    public List<Object> reviewInfo(int no) {
        List<Object> uVo = searchDao.reviewInfo(no);
        return uVo;
    }


    //////////////////////////////////////////////////////////

    //리뷰 목록 가져오기
    public Map<String, Object> reviewList(ReviewVo reviewVo) {

        
        int pageView = 4; //한 페이지에 표시할 게시물 수
        int pageNum = 5; //화면 하단에 표시할 페이지 최대 갯수
        int currPage = reviewVo.getPage() > 0 ? reviewVo.getPage() : 1;
        int totalPage = (searchDao.reviewCount(reviewVo.getTrainerNo() )-1)/pageView + 1;
        int _currPage = (currPage - 1)/pageNum;
        int beginPage = _currPage*pageNum+1;
        int endPage = Math.min(_currPage * pageNum + pageNum, totalPage);

        reviewVo.setPage(currPage);
        reviewVo.setPageView(pageView);


        List<ReviewVo> reveiwList = searchDao.reviewList(reviewVo);
        
        System.out.println("리뷰리스트 "+reveiwList);
        
        
        Map<String, Object> reveiwListMap = new HashMap<String, Object>();

        reveiwListMap.put("pageNum", pageNum);
        reveiwListMap.put("currPage", currPage);
        reveiwListMap.put("totalPage", totalPage);
        reveiwListMap.put("beginPage", beginPage);
        reveiwListMap.put("endPage", endPage);
        reveiwListMap.put("reveiwList", reveiwList);
        
        System.out.println("맵 "+reveiwListMap);
        
        return reveiwListMap;
    }

    // 페이지 정보
    public Map<String, Integer> reviewCount(int trainerNo) {
        Map<String, Integer> cMap = new HashMap<>();
        cMap.put("countAll", searchDao.reviewCount(trainerNo));
        cMap.put("count", (int) Math.ceil(cMap.get("countAll") / 4.0));

        return cMap;
    }


    // 리뷰작성자격 확인
    public ReviewVo reviewWrite(int no) {
        System.out.println("SearchService:reviewWrite");
        
        //스케쥴카운트 체크
        ReviewVo reviewVo = searchDao.reviewWrite(no);
        
        System.out.println("정보 불러와지나 체크"+reviewVo.getScheduleCount());
        
        
               return reviewVo;
    }


    //리뷰 추가
    public Map<String, Object> reviewPlus(ReviewVo reviewVo) {
        System.out.println("SearchService:reviewPlus");

        
        System.out.println("서비스 보 확인" + reviewVo);

        searchDao.reviewPlus(reviewVo);

        int reviewNo = reviewVo.getReviewNo();
        System.out.println("리뷰추가 리뷰넘버 추출"+reviewNo);

        
        ReviewVo vo = searchDao.reviewOne(reviewVo.getReviewNo());
        System.out.println("리뷰리스트 "+vo);

        
        int pageView = 4; //한 페이지에 표시할 게시물 수
        int pageNum = 5; //화면 하단에 표시할 페이지 최대 갯수
        int currPage = reviewVo.getPage() > 0 ? reviewVo.getPage() : 1;
        int totalPage = (searchDao.reviewCount(reviewVo.getTrainerNo() )-1)/pageView + 1;
        int _currPage = (currPage - 1)/pageNum;
        int beginPage = _currPage*pageNum+1;
        int endPage = Math.min(_currPage * pageNum + pageNum, totalPage);

        vo.setPage(currPage);
        vo.setPageView(pageView);
        
        List<ReviewVo> rVo = searchDao.reviewList(vo);
        System.out.println("리뷰리스트2 "+rVo);
        
        
        Map<String, Object> reveiwListMap = new HashMap<String, Object>();

        reveiwListMap.put("pageNum", pageNum);
        reveiwListMap.put("currPage", currPage);
        reveiwListMap.put("totalPage", totalPage);
        reveiwListMap.put("beginPage", beginPage);
        reveiwListMap.put("endPage", endPage);
        reveiwListMap.put("reveiwList", rVo);
        
        System.out.println("맵 "+reveiwListMap);

        return reveiwListMap;
    }

    //답글추가
    public Map<String, Object> rereviewPlus(ReviewVo reviewVo) {
        System.out.println("SearchService:rereviewPlus");
     System.out.println("서비스 보 확인" + reviewVo);

        searchDao.rereviewPlus(reviewVo);

        int reviewNo = reviewVo.getReviewNo();
        System.out.println("리뷰넘버 추출 확인" + reviewNo);
        
        ReviewVo vo = searchDao.reviewOne(reviewNo);
        
      //리뷰 쓴것 체크
        searchDao.checkReview(vo.getPtNo());
        
        int pageView = 4; //한 페이지에 표시할 게시물 수
        int pageNum = 5; //화면 하단에 표시할 페이지 최대 갯수
        int currPage = reviewVo.getPage() > 0 ? reviewVo.getPage() : 1;
        int totalPage = (searchDao.reviewCount(reviewVo.getTrainerNo() )-1)/pageView + 1;
        int _currPage = (currPage - 1)/pageNum;
        int beginPage = _currPage*pageNum+1;
        int endPage = Math.min(_currPage * pageNum + pageNum, totalPage);

        vo.setPage(currPage);
        vo.setPageView(pageView);
        
        List<ReviewVo> rVo = searchDao.reviewList(vo);
        System.out.println("리뷰리스트2 "+rVo);
        
        
        Map<String, Object> reveiwListMap = new HashMap<String, Object>();

        reveiwListMap.put("pageNum", pageNum);
        reveiwListMap.put("currPage", currPage);
        reveiwListMap.put("totalPage", totalPage);
        reveiwListMap.put("beginPage", beginPage);
        reveiwListMap.put("endPage", endPage);
        reveiwListMap.put("reveiwList", rVo);
        
        System.out.println("맵 "+reveiwListMap);

        return reveiwListMap;
    }

    // 리뷰수정
    public Map<String, Object> reviewModify(ReviewVo reviewVo) {
        System.out.println("SearchService:reviewPlus");

       
        searchDao.reviewModify(reviewVo);
        System.out.println("수정내용 확인" + reviewVo);

        ReviewVo vo = searchDao.reviewOne(reviewVo.getReviewNo());
        System.out.println("리뷰리스트 "+vo);

        
        
        int pageView = 4; //한 페이지에 표시할 게시물 수
        int pageNum = 5; //화면 하단에 표시할 페이지 최대 갯수
        int currPage = reviewVo.getPage() > 0 ? reviewVo.getPage() : 1;
        int totalPage = (searchDao.reviewCount(reviewVo.getTrainerNo() )-1)/pageView + 1;
        int _currPage = (currPage - 1)/pageNum;
        int beginPage = _currPage*pageNum+1;
        int endPage = Math.min(_currPage * pageNum + pageNum, totalPage);

        vo.setPage(currPage);
        vo.setPageView(pageView);
        
        List<ReviewVo> rVo = searchDao.reviewList(vo);
        System.out.println("리뷰리스트2 "+rVo);
        
        
        Map<String, Object> reveiwListMap = new HashMap<String, Object>();

        reveiwListMap.put("pageNum", pageNum);
        reveiwListMap.put("currPage", currPage);
        reveiwListMap.put("totalPage", totalPage);
        reveiwListMap.put("beginPage", beginPage);
        reveiwListMap.put("endPage", endPage);
        reveiwListMap.put("reveiwList", rVo);
        
        System.out.println("맵 "+reveiwListMap);

        return reveiwListMap;
    }

    //리뷰 추가위해 pt넘버 불러오기
    public int findPt(int userNo) {
        System.out.println("SearchService:findPt");

        int ptNo = searchDao.findPt(userNo);

        return ptNo;
    }

    //리뷰(답글)삭제
    public Map<String, Object> reviewReRemove(ReviewVo reviewVo) {
        System.out.println("SearchService:reviewRemove");

        ReviewVo vo = searchDao.reviewRemove(reviewVo);
        int order = vo.getOrder_no();
        System.out.println("오더"+order);
        
        if(order == 1) {
        searchDao.reviewRemove2(vo);}
        if(order ==2 ) {
        searchDao.reviewRemove3(reviewVo,vo.getPtNo());
        }
        
        System.out.println("받아와지나 확인"+vo);
        
        
        int pageView = 4; //한 페이지에 표시할 게시물 수
        int pageNum = 5; //화면 하단에 표시할 페이지 최대 갯수
        int currPage = reviewVo.getPage() > 0 ? reviewVo.getPage() : 1;
        int totalPage = (searchDao.reviewCount(reviewVo.getTrainerNo() )-1)/pageView + 1;
        int _currPage = (currPage - 1)/pageNum;
        int beginPage = _currPage*pageNum+1;
        int endPage = Math.min(_currPage * pageNum + pageNum, totalPage);

        vo.setPage(currPage);
        vo.setPageView(pageView);
        
        List<ReviewVo> rVo = searchDao.reviewList(vo);
        System.out.println("리뷰리스트2 "+rVo);
        
        
        Map<String, Object> reveiwListMap = new HashMap<String, Object>();

        reveiwListMap.put("pageNum", pageNum);
        reveiwListMap.put("currPage", currPage);
        reveiwListMap.put("totalPage", totalPage);
        reveiwListMap.put("beginPage", beginPage);
        reveiwListMap.put("endPage", endPage);
        reveiwListMap.put("reveiwList", rVo);
        
        System.out.println("맵 "+reveiwListMap);

        return reveiwListMap;
        

    }

    

}
