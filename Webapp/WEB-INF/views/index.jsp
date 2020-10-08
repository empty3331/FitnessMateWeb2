<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/image/favicon.ico"/>

    <title>FitnessMate</title>

    <!-- icon 사용을 위한 css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/fontawesome/all.css">

    <!-- 반드시 넣어야 하는 2가지 css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">

    <!-- 반드시 넣어야 하는 2가지 js -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/modal.js"></script>

    <!-- slide -->
    <link href="${pageContext.request.contextPath}/assets/js/swiper-4.2.6/dist/css/swiper.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/assets/js/swiper-4.2.6/dist/js/swiper.min.js"></script>

    <!-- 해당 페이지 css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main2.css">

    <!-- 지도js -->
    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
    <script type="text/javascript"
            src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=575e0fbd097917d59e7c28fe5976a11c&libraries=services,clusterer,drawing"></script>


</head>
<body>

    <c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
    <!-- header -->

    <div id="container">
        <section id="mainBanner">
            <div class="swiper-wrapper">
                <div class="swiper-slide"
                     style="background-image: url('${pageContext.request.contextPath}/assets/image/main-test-01.jpg')">
                </div>
                <div class="swiper-slide"
                     style="background-image: url('${pageContext.request.contextPath}/assets/image/main-test-02.jpg')">
                </div>
                <div class="swiper-slide"
                     style="background-image: url('${pageContext.request.contextPath}/assets/image/main-test-03.jpg')">
                </div>
            </div>
        </section>

        <div class="wrapper">
            <div id="searchKeywordForm" action="${pageContext.request.contextPath}/main" method="post">
                <ul class="search-condition clearfix">
                    <li class="local clearfix">
                        <h3 class="title">지역</h3>
                        <!--지역 고르기 -->
                        <select name="province">
                            <option value="">전체</option>
                            <c:forEach items="${addVo}" var="addVo">
                                <option>${addVo.province}</option>
                            </c:forEach>
                        </select>

                        <!--구 고르기 -->
                        <select name="city">
                        </select>

                        <!--동 고르기 -->
                        <select name="region">
                        </select>

                    </li>
                    <li class="gender">
                        <h3 class="title">성별</h3>
                        <div class="radio-wrapper clearfix">
                            <input type="radio" id="genderMale" name="gender" value="male">
                            <label for="genderMale">남성</label>
                            <input type="radio" id="genderFemale" name="gender" value="female">
                            <label for="genderFemale">여성</label>
                        </div>
                    </li>

                    <li class="field">
                        <h3 class="title">전문분야</h3>
                        <select name="field">
                            <option value="0">전체</option>
                            <c:forEach items="${fieldVo}" var="fieldVo">
                                <option value="${fieldVo.fieldNo}">${fieldVo.fieldName}</option>
                            </c:forEach>
                        </select>
                    </li>

                    <li class="keyword">
                        <h3 class="title">검색어</h3>
                        <input name="name" type="text" placeholder="검색어를 입력해주세요">
                    </li>

                </ul>
                <button type="submit" class="button key" id="searchBtn">검색</button>
                <!-- </form> -->
            </div>
            <!-- 검색-->


            <!-- 트레이너목록-->
            <ul class="search-list clearfix"></ul>
            <ul class="search-paging clearfix"></ul>
        </div> <!-- wrapper-->

    </div>
    <div class="modal-layer" id="profileModal">
        <div class="modal-wrapper">
            <button type="button" class="close-btn" onclick="forceHideModal('#profileModal')">X</button>
            <div class="label-wrapper clearfix">
                <button type="button" class="label-btn profile-btn on" data-tab="profile"
                        onclick="showTab($(this))">
                    프로필
                </button>
                <button type="button" class="label-btn review-btn" data-tab="review" onclick="showTab($(this))">리뷰
                </button>
                <button type="button" class="label-btn location-btn" data-tab="location" onclick="showTab($(this))">
                    위치
                </button>
            </div>
            <div class="modal-content">
                <div class="label-tab profile-wrapper on">
                    <div class="summary-wrapper clearfix">
                        <img src=""
                             class="profile-img">
                        <div class="summary">
                            <input type="hidden" name="no" value="" id="delNo">
                            <p class="name info"></p>
                            <p class="belong"></p>
                        </div>
                        <div class="score">
                            <p class="head">평점</p>
                            <p class="body socoreAvg"></p>
                        </div>
                        <div class="review">
                            <p class="head">리뷰수</p>
                            <p class="body reviewCount"></p>
                        </div>
                        <div class="contact">
                            <p class="head">연락처</p>
                            <p class="body contact"></p>
                        </div>
                    </div>
                    <div class="info-wrapper clearfix">
                        <div class="info">
                            <h3 class="title">나이</h3>
                            <p class="content age"></p>
                        </div>
                        <div class="info">
                            <h3 class="title">성별</h3>
                            <p class="content gender"></p>
                        </div>
                        <div class="info">
                            <h3 class="title">지역</h3>
                            <p class="content location"></p>
                        </div>
                        <div class="info">
                            <h3 class="title">트레이너 경력</h3>
                            <p class="content career"></p>
                        </div>


                    </div>
                    <div class="info-wrapper clearfix">
                        <div class="info">
                            <h3 class="title">연락처/sns</h3>
                            <p class="content phone"></p>
                        </div>
                    </div>
                    <div class="info-wrapper clearfix">
                        <div class="category-info">
                            <h3 class="title field">전문분야</h3>
                        </div>
                        <div class="award-info">
                            <h3 class="title">입상경력</h3>
                        </div>
                    </div>
                    <div class="comment-wrapper">
                        <h3 class="title">PT 운영 시간</h3>
                        <p class="content ptTimer"></p>
                    </div>
                    <div class="pay-wrapper">
                        <h3 class="title">비용</h3>
                        <p class="content price"></p>
                    </div>
                    <div class="comment-wrapper">
                        <h3 class="title">트레이너 메세지</h3>
                        <p class="content introduction"></p>
                    </div>
                </div>


                <div class="label-tab review-wrapper">


                    <!--로그인 유저 넘버 -->
                    <input type="hidden" id="loginUser" value="${authUser.userNo}">

                    <!--내 트레이너&1회이상 트레이닝 받았을시만 보임 -->
                    <div class="reviewWrite">
                    </div>
                    <ul class="review-list"></ul>
                    <ul class="review-paging clearfix"></ul>

                </div> <!-- 리뷰작성페이지 -->

                <!-- 지도 페이지 -->
                <div class="label-tab location-wrapper">
                    <div id="mapInfo"></div>
                    <br>
                    <div id="map" style="width:800px;height:500px;"></div>
                </div>
                <!-- 지도 페이지 -->

            </div>
        </div>
    </div><!-- 모달 -->
    <c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
    <script type="text/javascript">
        var swiper = new Swiper('#mainBanner', {
            loop: true,
            navigation: false,
            autoplay: {
                delay: 3000,
                disableOnInteraction: false
            }
        });


    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            searchTrainer(1);
            $("#searchBtn").on("click", function () {
                searchTrainer(1);
            });
        });

        ////////////////////////검색 관련/////////////////////////////


        //구 불러오기
        $("select[name='province']").on("change", function () {
            console.log("지역선택");
            $("select[name='city']").empty();
            $("select[name='region']").empty();

            var province = $(this).val();

            $.ajax({
                url: "${pageContext.request.contextPath }/search/getCity",
                type: "post",
                data: {province: province},

                dataType: "json",
                success: function (cityList) {
                    /*성공시 처리해야될 코드 작성*/
                    var cityStr = '<option value="" >전체</option>';
                    for (var i in cityList) {
                        cityStr += '<option>' + cityList[i].city + '</option>';

                    }
                    $("select[name='city']").append(cityStr);
                },
                error: function (XHR, status, error) {
                    console.error(status + " : " + error);
                }
            });
        });

        //동면리 불러오기
        $("select[name='city']").on("change", function () {
            console.log("도시선택");
            $("select[name='region']").empty();

            var city = $(this).val();

            $.ajax({
                url: "${pageContext.request.contextPath }/search/getRegion",
                type: "post",
                data: {city: city},

                dataType: "json",
                success: function (regionList) {
                    /*성공시 처리해야될 코드 작성*/
                    var regionStr = '<option value="">전체</option>';
                    for (var i in regionList) {
                        regionStr += '<option>' + regionList[i].region + '</option>';

                    }
                    $("select[name='region']").append(regionStr);
                },
                error: function (XHR, status, error) {
                    console.error(status + " : " + error);
                }
            });
        });

        ////////////////////////검색 관련/////////////////////////////

        ////////////////////////트레이너 모달 세부정보탭/////////////////////////////
        //트레이너 상세정보,별점 반영하기
        function showProfileModal(obj, userNo) {

            //트레이너 넘버 추출
            var no = userNo;
            console.log("no " + no);
            $("#delNo").val(no);

            //다른 버튼 on 제거
            $("#profileModal .label-wrapper .label-btn").removeClass("on");
            $("#profileModal .label-wrapper .profile-btn").addClass("on");
            //다른 탭 on 제거
            $("#profileModal .label-tab").removeClass("on");
            $("#profileModal .profile-wrapper").addClass("on");


            //데이터전송
            $.ajax({
                url: "${pageContext.request.contextPath }/search/trainerInfo",
                type: "post",
                //contentType : "application/json",
                data: {no: no},

                dataType: "json",
                success: function (vo) {

                    trainerField();//전문분야
                    trainerRecord();//수상경력
                    reviewInfo();//리뷰정보

                    var loca = vo.location.replace(/[|]/gi, ' ');//지역 사이의 | 지우기

                    //만나이 계산
                    var birthday = new Date(vo.birthDate);
                    var today = new Date();
                    var years = today.getFullYear() - birthday.getFullYear();
                    // Reset birthday to the current year.
                    birthday.setFullYear(today.getFullYear());

                    // If the user's birthday has not occurred yet this year, subtract 1.
                    if (today < birthday) {
                        years--;
                    }
                    //만나이 계산


                    //정보넣기
                    $(".name.info").html(vo.name); //이름
                    $(".belong").html(vo.company); //회사
                    $(".summary-wrapper .profile-img").attr("src", "${pageContext.request.contextPath}/upload/" + vo.profileImg)

                    //성별
                    if (vo.gender == 'female') {
                        $(".content.gender").html("여자");
                    } else {
                        $(".content.gender").html("남자");
                    }
                    $(".content.location").html(loca); //지역
                    $(".content.career").html(vo.career); //경력
                    $(".content.price").html(vo.price); //가격
                    $(".content.introduction").html(vo.introduction); //자기소개
                    $(".content.age").html("만" + years + "세");
                    $(".content.ptTimer").html(vo.workingHours); //자기소개
                    $("div.contact p.body").html(vo.phone);//연락처


                },
                error: function (XHR, status, error) {
                    console.error(status + " : " + error);
                }
            });

            showModal("#profileModal");
        }

        //전문분야 불러오기 함수
        function trainerField() {

            var fieldNo = $("#delNo").val();
            $(".category").remove();

            $.ajax({

                url: "${pageContext.request.contextPath }/search/fieldInfo",
                type: "post",
                //contentType : "application/json",
                data: {no: fieldNo},

                dataType: "json",
                success: function (fieldList) {


                    var fieldStr = '';
                    for (var i in fieldList) {

                        fieldStr += '<span class="category">' + fieldList[i].fieldName + '</span>';

                    }
                    $(".category-info").append(fieldStr);


                },
                error: function (XHR, status, error) {
                    console.error(status + " : " + error);
                }
            });
        }

        //수상경력 불러오기 함수
        function trainerRecord() {

            var recordNo = $("#delNo").val();
            $(".award").remove();

            $.ajax({

                url: "${pageContext.request.contextPath }/search/recordInfo",
                type: "post",
                //contentType : "application/json",
                data: {no: recordNo},

                dataType: "json",
                success: function (recordList) {
                    console.log(recordList);

                    var recordStr = '';
                    for (var i in recordList) {

                        recordStr += '<span class="award">' + recordList[i].recordInfo + '</span>';

                    }
                    $(".award-info").append(recordStr);


                },
                error: function (XHR, status, error) {
                    console.error(status + " : " + error);
                }
            });
        }

        //리뷰정보 불러오기 함수
        function reviewInfo() {

            var recordNo = $("#delNo").val();
            $(".award").remove();

            $.ajax({

                url: "${pageContext.request.contextPath }/search/reviewInfo",
                type: "post",
                //contentType : "application/json",
                data: {no: recordNo},

                dataType: "json",
                success: function (review) {
                    console.log("리뷰 불러오기");

                    var reviewStr = '';
                    for (var i in review) {

                        $(".body.socoreAvg").html(review[i].reviewAvg + "점");
                        $(".body.reviewCount").html(review[i].reviewCount + "개");
                    }

                },
                error: function (XHR, status, error) {
                    console.error(status + " : " + error);
                }
            });
        }

        ////////////////////////트레이너 모달 세부정보탭/////////////////////////////

        ////////////////////////트레이너 모달 리뷰탭/////////////////////////////

        //리뷰탭 클릭시
        $(".label-btn.review-btn").on("click", function () {

            //로그인 유저번호 추출
            var loginUser = "${authUser.userNo}";
            console.log("맨처음 로그인유저번호 추출" + loginUser);
            //트레이너 넘버 추출
            var trainerNo = $("#delNo").val();
            console.log("트레이너 넘버" + trainerNo);
            //페이지
            var page = 1;

            //리뷰목록
            reviewList(trainerNo, page);


            //로그인된 회원중 트레이너 본인이 아닐시에만 보이게
            if (loginUser != null && loginUser != '' && loginUser != trainerNo) {
                reviewWrite();//리뷰쓰기폼
                reviewup();//리뷰추가
            }


        });


        //리뷰목록
        function reviewList(trainerNo, page) {

            console.log("리뷰목록 트레이너 넘버" + trainerNo + page);

            var rVo = {
                trainerNo: trainerNo,
                page: page
            }

            console.log("확인용" + rVo);

            $.ajax({
                url: "${pageContext.request.contextPath}/search/reviewList",
                type: "post",
                contentType: "application/json",
                data: JSON.stringify(rVo),
                dataType: "json",
                success: function (reviewVo) {
                    var rvo = reviewVo.reveiwList;

                    console.log("됐냐" + trainerNo);
                    //리뷰리스트 불러오기
                    render(rvo);
                    //페이지 숫자
                    reviewPage(trainerNo, reviewVo);

                },
                error: function (XHR, status, error) {
                    console.error(status + " : " + error);
                }
            });
        }

        //리뷰페이징
        function reviewPage(trainerNo, reviewVo) {
            var paging = $("ul.review-paging");
            paging.empty();
            if (reviewVo.currPage === 1) {
                paging.append(
                    "<li class='off' onclick='reviewList(" + trainerNo + ",1);'>처음으로</li>"
                );
            } else {
                paging.append(
                    "<li onclick='reviewList(" + trainerNo + ",1)'>처음으로</li>"
                );
            }

            if (reviewVo.currPage <= reviewVo.pageNum) {
                paging.append(
                    "<li class='off' onclick='reviewList(" + trainerNo + "," + (reviewVo.beginPage - 10) + ")'>◀</li>"
                )
            } else {
                paging.append(
                    "<li onclick='reviewList(" + trainerNo + "," + (reviewVo.beginPage - 10) + ")'>◀</li>"
                )
            }

            for (i = reviewVo.beginPage; i <= reviewVo.endPage; i++) {
                if (i === reviewVo.currPage) {
                    paging.append(
                        "<li class='active' onclick='reviewList(" + trainerNo + "," + i + ")'>" + i + "</li>"
                    );
                } else {
                    paging.append(
                        "<li onclick='reviewList(" + trainerNo + "," + i + ")'>" + i + "</li>"
                    );
                }
            }


            if ((reviewVo.totalPage - reviewVo.beginPage) < reviewVo.pageNum) {
                paging.append(
                    "<li class='off' onclick='reviewList(" + trainerNo + "," + (reviewVo.endPage + 1) + ")'>▶</li>"
                );
            } else {
                paging.append(
                    "<li onclick='reviewList(" + trainerNo + "," + (reviewVo.endPage + 1) + ")'>▶</li>"
                );
            }

            if (reviewVo.currPage === reviewVo.totalPage) {
                paging.append(
                    "<li class='off' onclick='reviewList(" + trainerNo + "," + reviewVo.totalPage + ")'>마지막으로</li>"
                );
            } else {
                paging.append(
                    "<li onclick='reviewList(" + trainerNo + "," + reviewVo.totalPage + ")'>마지막으로</li>"
                );
            }

        }

        //클릭하면 펑션 실행되게
        $("ul.review-list").on("click", ".repageNum", function () {
            var trainerNo = $("#delNo").val();
            console.log("클릭인식");
            //페이지 숫자 추출
            var why = $(this).data("c");
            console.log(why);

            //목록 불러오기
            reviewList(trainerNo, why);
        });

        function searchTrainer(page) {
            //값 추출
            var searchVo = {
                province: $("[name='province']").val(),
                city: $("[name='city']").val(),
                region: $("[name='region']").val(),
                gender: $("[name='gender']:checked").val(),
                field: $("[name='field']").val(),
                name: $("[name='name']").val(),
                page: page
            }

            console.log(searchVo);

            $.ajax({
                url: "${pageContext.request.contextPath }/search",
                type: "post",
                contentType: "application/json",
                data: JSON.stringify(searchVo),
                success: function (result) {
                    var list = $("ul.search-list");
                    var paging = $("ul.search-paging");
                    var trainerList = result.trainerList;

                    list.empty();
                    paging.empty();

                    if (trainerList.length == 0) {
                        list.append(
                            "<li class='empty'></li>"
                        );
                    }

                    //트레이너 리스트 그리기
                    for (i = 0; i < trainerList.length; i++) {
                        var trainerLocation;
                        if (trainerList[i].company == null) {
                            trainerList[i].company = "";
                        }
                        if (trainerList[i].introduction == null) {
                            trainerList[i].introduction = "";
                        }
                        if (trainerList[i].location == null) {
                            trainerLocation = "";
                        } else {
                            trainerLocation = trainerList[i].location.replaceAll("|", " ");
                        }
                        list.append(
                            "<li class='search-result' onclick='showProfileModal($(this)," + trainerList[i].userNo + ")'>" +
                            "<div class='image-area' style='background-image: url(${pageContext.request.contextPath}/upload/" + trainerList[i].profileImg + ")'>" +
                            "</div>" +
                            "<div class='content-area'>" +
                            "<p class='name'>" + trainerList[i].name + "</p>" +
                            "<p class='gym'>" + trainerList[i].company + "</p>" +
                            "<p class='comment'>" + trainerList[i].introduction + "</p>" +
                            "<p class='location'>" + trainerLocation + "</p>" +
                            "<p class='score'></p>" +
                            "</div>" +
                            "</li>"
                        );
                    }

                    if (result.currPage === 1) {
                        paging.append(
                            "<li class='off' onclick='searchTrainer(1)'>처음으로</li>"
                        );
                    } else {
                        paging.append(
                            "<li onclick='searchTrainer(1)'>처음으로</li>"
                        );
                    }

                    if (result.currPage <= result.pageNum) {
                        paging.append(
                            "<li class='off' onclick='searchTrainer(" + (result.beginPage - 10) + ")'>◀</li>"
                        )
                    } else {
                        paging.append(
                            "<li onclick='searchTrainer(" + (result.beginPage - 10) + ")'>◀</li>"
                        )
                    }

                    for (i = result.beginPage; i <= result.endPage; i++) {
                        if (i === result.currPage) {
                            paging.append(
                                "<li class='active' onclick='searchTrainer(" + i + ")'>" + i + "</li>"
                            );
                        } else {
                            paging.append(
                                "<li onclick='searchTrainer(" + i + ")'>" + i + "</li>"
                            );
                        }
                    }


                    if ((result.totalPage - result.beginPage) < result.pageNum) {
                        paging.append(
                            "<li class='off' onclick='searchTrainer(" + (result.endPage + 1) + ")'>▶</li>"
                        );
                    } else {
                        paging.append(
                            "<li onclick='searchTrainer(" + (result.endPage + 1) + ")'>▶</li>"
                        );
                    }

                    if (result.currPage === result.totalPage) {
                        paging.append(
                            "<li class='off' onclick='searchTrainer(" + result.totalPage + ")'>마지막으로</li>"
                        );
                    } else {
                        paging.append(
                            "<li onclick='searchTrainer(" + result.totalPage + ")'>마지막으로</li>"
                        );
                    }

                },
                error: function (XHR, status, error) {
                    console.error(status + " : " + error);
                }
            });
        }


        //리뷰쓰기탭
        function reviewWrite() {
            var reviewNo = $("#delNo").val();
            var loginUser = $("#loginUser").val();


            $.ajax({

                url: "${pageContext.request.contextPath}/search/reviewWrite",
                type: "post",
                //contentType : "application/json",
                data: {no: loginUser},

                dataType: "json",
                success: function (reviewVo) {
                    $(".reviewWrite").empty();
                    var reviewStr = "";


                    var test = reviewVo.check_review;


                    if (reviewVo.trainerNo == reviewNo && reviewVo.scheduleCount >= 1 && test == 0) {


                        reviewStr += '<span>리뷰작성</span>';
                        reviewStr += '<div id="star_grade">';
                        reviewStr += '  <input type="hidden"  name="reviewScore" value="0">';
                        reviewStr += '  <i  class="fas fa-star" data-score="1"></i>';
                        reviewStr += '  <i  class="fas fa-star" data-score="2"></i>';
                        reviewStr += '  <i  class="fas fa-star" data-score="3"></i>';
                        reviewStr += '  <i  class="fas fa-star" data-score="4"></i>';
                        reviewStr += '  <i  class="fas fa-star" data-score="5"></i>';
                        reviewStr += '</div>';
                        reviewStr += '<textarea class="content review" name="content" placeholder="사용하시면서 달라진 만족도에 대한 후기를 남겨주세요(최소 10자 이상)"></textarea>';
                        reviewStr += '<div>';
                        reviewStr += '  <input  type="file" id="file"  name="file_name" class="image_inputType_file" >';
                        reviewStr += '</div>';
                        reviewStr += '<button class="button revW" type="submit">작성</button>';
                    }

                    $(".reviewWrite").append(reviewStr);

                },
                error: function (XHR, status, error) {
                    console.error(status + " : " + error);
                }
            });

        }


        function showTab(target) {
            var targetTab = target.attr("data-tab");


            //다른 버튼 on 제거
            $(".label-wrapper .label-btn").removeClass("on");
            //다른 탭 on 제거
            $(".label-tab").removeClass("on");

            //label에 on
            target.addClass("on");

            //tab에 on
            $("#profileModal").find("." + targetTab + "-wrapper").addClass("on");

        }

        //별점 선택
        $('.reviewWrite').on("click", "#star_grade i", function () {
            $(this).parent().children("i").removeClass("on");  /* 별점의 on 클래스 전부 제거 */
            $(this).addClass("on").prevAll("i").addClass("on"); /* 클릭한 별과, 그 앞 까지 별점에 on 클래스 추가 */
            var score = $(this).attr("data-score");
            $("input[name='reviewScore']").val(score);

        });

        //수정할 별점 선택
        $('.review-list').on("click", "#star_grade i", function () {
            $(this).parent().children("i").removeClass("on");  /* 별점의 on 클래스 전부 제거 */
            $(this).addClass("on").prevAll("i").addClass("on"); /* 클릭한 별과, 그 앞 까지 별점에 on 클래스 추가 */
            var score = $(this).attr("data-score");
            $("input[name='reviewScore']").val(score);

        });


        //pt넘버 추출위한 유저넘버
        var userNo = $("#loginUser").val();


        //리뷰추가:1.ptNo 추출>2.다른정보추출>3.리뷰추가
        function reviewup() {

            var promise =
                $.ajax({
                    url: "${pageContext.request.contextPath}/search/findPt",
                    type: "post",
                    //contentType : "application/json",
                    data: {userNo: userNo},
                    dataType: "json",
                });

            promise.done(successFunction);
            promise.fail(failFunction);

            //pt넘버 추출 성공한 경우
            function successFunction(ptNo) {

                //버튼 눌렀을 때 리뷰 추가
                $(".reviewWrite").on("click", ".button.revW", function () {
                    console.log("리뷰추가 버튼클릭")

                    var score = $("input[name='reviewScore']").val();

                    var score_t = $("input[name='reviewScore']").val() > 0;

                    if (score_t == false) {
                        alert("별점을 선택해주세요");
                        return false;
                    }

                    var content = $("[name = 'content']").val();

                    var reviewVo = {
                        score: score,
                        content: content,
                        ptNo: ptNo
                    }

                    $.ajax({

                        url: "${pageContext.request.contextPath}/search/reviewPlus",
                        type: "post",
                        contentType: "application/json",
                        data: JSON.stringify(reviewVo),


                        dataType: "json",
                        success: function (rVo) {
                            $(".reviewWrite").remove();
                            $("ul.review-list").empty();
                            var reviewVo = rVo.reveiwList;

                            render(reviewVo);

                            $("[name = 'content']").val("");
                            $("#star_grade i").removeClass("on");


                        },
                        error: function (XHR, status, error) {
                            console.error(status + " : " + error);
                        }
                    });
                });
                return console.log(ptNo);
            }

            //pt넘버 추출 실패한 경우
            function failFunction(ptNo) {
                if (ptNo.result != 'success')
                    var ptNo = "함수호출 fail";
                return console.log(ptNo);
            }
        }

        //리뷰 수정버튼
        $(".review-list").on("click", "#modifyRe", function () {
            console.log("수정");
            var reviewNo = $(this).data('modino');
            console.log("수정위한 리뷰넘버 추출" + reviewNo);
            var content = $("#contentModi-" + reviewNo).text();
            console.log("수정 전 원래 내용 추출" + content);
            var score = parseInt($("#scoreNo-" + reviewNo).val());
            console.log("화면에 보일 스코어 추출" + score);
            var order = $("#orderNo-" + reviewNo).val();
            console.log("글쓴이 자격 추출" + order);


            //수정할 새창 불러오기

            reviewStr = ""
            reviewStr += '<div id="star_grade">';
            reviewStr += '<input type="hidden"  name="reviewNo" value="' + reviewNo + '">';
            reviewStr += '<input type="hidden"  name="reviewScore" value="0">';

            if (order == 1) {
                for (var i = 0; i < score; i++) {
                    reviewStr += '  <i  class="fas fa-star on" data-score="' + (i + 1) + '"></i>';
                }

                for (var i = 0; i < 5 - score; i++) {
                    reviewStr += '  <i  class="fas fa-star" data-score="' + (i + 1 + score) + '"></i>';
                }
            }

            reviewStr += '</div>';
            reviewStr += '<textarea class="content review" name="contentRe" placeholder="">' + content + '</textarea>';
            reviewStr += '<div>';
            reviewStr += '<div class="clearfix review-btn-area">';
            reviewStr += '      <button type="button"  class="button" id="modifyCan">취소</button>';
            reviewStr += '      <button type="button"  class="button" id="modifyOk" >확인</button>';
            reviewStr += '</div>';


            $("#r-" + reviewNo).empty();
            $("#r-" + reviewNo).append(reviewStr);
        });


        //수정취소
        $(".review-list").on("click", "#modifyCan", function () {
            console.log("수정취소");

            $("ul.review-list").empty();

            var trainerNo = $("#delNo").val();
            console.log("트레이너 넘버" + trainerNo);
            var page = $("ul.review-paging").children("li.active").text();
            console.log("페이지" + page);


            reviewList(trainerNo, page);
        });

        //수정완료
        $(".review-list").on("click", "#modifyOk", function () {


            var reviewNo = $('[name="reviewNo"]').val();
            console.log("수정위한 리뷰넘버 추출" + reviewNo);
            var content = $('[name ="contentRe"]').val();
            console.log("수정위한 내용 추출" + content);
            var score = $("input[name='reviewScore']").val();
            console.log("수정위한 스코어 추출" + score);
            var page = $("ul.review-paging").children("li.active").text();

            var reviewVo = {
                reviewNo: reviewNo,
                content: content,
                score: score,
                page: page
            }

            $.ajax({

                url: "${pageContext.request.contextPath}/search/reviewModify",
                type: "post",
                contentType: "application/json",
                data: JSON.stringify(reviewVo),
                dataType: "json",
                success: function (rVo) {
                    $("ul.review-list").empty();
                    var reviewVo = rVo.reveiwList;

                    render(reviewVo);

                },
                error: function (XHR, status, error) {
                    console.error(status + " : " + error);
                }
            });

        });


        //리뷰(답글) 삭제
        $(".review-list").on("click", "#removeRe", function () {
            console.log("삭제");
            var reviewNo = $(this).data('reno');
            console.log("삭제위한 리뷰넘버 추출" + reviewNo);
            var reviewVo = {reviewNo: reviewNo}

            $.ajax({

                url: "${pageContext.request.contextPath}/search/reviewRemove",
                type: "post",
                contentType: "application/json",
                data: JSON.stringify(reviewVo),

                dataType: "json",
                success: function (rVo) {
                    $("ul.review-list").empty();
                    var reviewVo = rVo.reveiwList;

                    render(reviewVo);

                },
                error: function (XHR, status, error) {
                    console.error(status + " : " + error);
                }
            });
        });


        //답글 폼
        $(".review-list").on("click", "#reRe", function () {
            console.log("답글");
            var reviewNo = $(this).data('rere');
            console.log("답글위한 리뷰넘버 추출" + reviewNo);


            //답글할 새창 불러오기
            reviewStr = ""
            reviewStr += '<div class="trainerReview">';
            reviewStr += '<textarea class="content review" name="contentRe" placeholder=""></textarea>';
            reviewStr += '<div class="clearfix review-btn-area">';
            reviewStr += '      <button type="button"  class="button" id="modifyCan">취소</button>';
            reviewStr += '      <button type="button"  class="button" id="rereW" data-rerere="' + reviewNo + '" >확인</button>';
            reviewStr += '</div>';
            reviewStr += '</div>';

            $("#r-" + reviewNo).append(reviewStr);


        });


        //답글 작성버튼

        $(".review-list").on("click", "#rereW", function () {
            console.log("답글작성");
            var group_no = $(this).data('rerere');
            console.log("답글위한 리뷰넘버 추출" + group_no);
            var content = $('[name ="contentRe"]').val();
            console.log("답글위한 내용 추출" + content);
            var ptNo = $("#reptNo-" + group_no).val();
            console.log("답글위한 pt넘버 추출" + ptNo);
            var score = 0;

            var reviewVo = {
                group_no: group_no,
                score: score,
                content: content,
                ptNo: ptNo
            }

            $.ajax({

                url: "${pageContext.request.contextPath}/search/rereviewPlus",
                type: "post",
                contentType: "application/json",
                data: JSON.stringify(reviewVo),

                dataType: "json",
                success: function (rVo) {
                    console.log("답글추가");
                    $("ul.review-list").empty();
                    var reviewVo = rVo.reveiwList;

                    render(reviewVo);

                },
                error: function (XHR, status, error) {
                    console.error(status + " : " + error);
                }
            });


        });


        //리뷰목록 가지고 오기

        function render(reviewVo) {

            var reviewNo = $("#delNo").val();//트레이너 넘버 추출

            $("ul.review-list").empty();
            var reviewStr = "";
            var str = "<h3 class='title'>아직 작성된 리뷰가 없습니다.</h3>";

            $("ul.review-list").append(str);


            var loginUser = $("#loginUser").val();
            console.log("목록 로그인유저" + loginUser);


            for (var review of reviewVo) {


                if (review.order_no != 1) {
                    reviewStr += '<li class="review-line bg" id="r-' + review.reviewNo + '">';
                } else {
                    reviewStr += '<li class="review-line" id="r-' + review.reviewNo + '">';
                }

                reviewStr += '<input type="hidden" id="reptNo-' + review.reviewNo + '" value="' + review.ptNo + '">';
                reviewStr += '<input type="hidden" id="scoreNo-' + review.reviewNo + '" value="' + review.score + '">';
                reviewStr += '<input type="hidden" id="orderNo-' + review.reviewNo + '" value="' + review.order_no + '">';
                reviewStr += '  <div class="user-profile ff">';
                //회원이 쓴 리뷰의 경우
                if (review.order_no != 2) {
                    reviewStr += '    <img class="user-profile-img" src="${pageContext.request.contextPath}/upload/' + review.profileImg + '">';
                    reviewStr += '    <div class="user-profile-info">';
                    reviewStr += '      <div class="user-profile-name">' + review.name + '</div>';
                    reviewStr += '      <div class="user-profile-date">트레이닝- ' + review.scheduleCount + '회차</div>';
                    reviewStr += '      <div class="user-profile-date">' + review.regDate + '</div>';
                    reviewStr += '    </div>';


                    reviewStr += '    <div class="user-profile-star fd">';

                    //별점만들기
                    for (var i = 0; i < review.score; i++) {
                        reviewStr += '<i class="fas fa-star"></i>'
                    }
                    for (var i = 0; i < 5 - review.score; i++) {
                        reviewStr += '<i class="far fa-star"></i>'
                    }
                }

                //트레이너가 쓴 답변일 경우
                else {
                    reviewStr += '    <img class="user-profile-img" src="${pageContext.request.contextPath}/upload/' + review.trainerImg + '">';
                    reviewStr += '    <div class="user-profile-info">';
                    reviewStr += '      <div class="user-profile-name">' + review.trainerName + '</div>';
                    reviewStr += '      <div class="user-profile-date">' + review.regDate + '</div>';
                    reviewStr += '    </div>';
                }


                reviewStr += '    </div>';
                reviewStr += '  </div>';
                //

                reviewStr += '  <div class="box">';
                reviewStr += '    <div class="content" id="contentModi-' + review.reviewNo + '">' + review.content + '</div>';
                reviewStr += '  </div>';
                reviewStr += '  <div class="clearfix review-btn-area">';

                var writeUser = review.userNo;
                console.log("목록 리뷰쓴유저번호" + writeUser);
                var writeTrainer = review.trainerNo;
                console.log("목록 트레이너번호" + writeTrainer);

                //회원이 로그인한 경우
                if (writeUser == loginUser && review.order_no != 2) {
                    reviewStr += '      <button type="button"  data-reno="' + review.reviewNo + '" class="button" id="removeRe">삭제</button>';
                    reviewStr += '      <button type="button" data-modino="' + review.reviewNo + '" class="button" id="modifyRe">수정</button>';
                }

                //트레이너가 로그인한 경우
                if (reviewNo == loginUser && review.order_no != 2 && review.check_review < 2) {
                    reviewStr += '      <button type="button" data-rere="' + review.reviewNo + '" class="button" id="reRe" >답글</button> ';
                }

                //트레이가 단 답글
                if (writeTrainer == loginUser && writeUser != loginUser && review.order_no != 1) {
                    reviewStr += '      <button type="button"  data-reno="' + review.reviewNo + '" class="button" id="removeRe">삭제</button>';
                    reviewStr += '      <button type="button" data-modino="' + review.reviewNo + '" class="button" id="modifyRe">수정</button>';
                }


                reviewStr += '  </div>';
                reviewStr += ' </li>';


                $("ul.review-list").empty(str);

            }
            $("ul.review-list").append(reviewStr);

        }


        ////////////////////////트레이너 모달 리뷰탭/////////////////////////////

        ////////////////////////트레이너 모달 위치탭/////////////////////////////

        //지도
        $(".label-btn.location-btn").on("click", function () {
            //트레이너 넘버 추출
            var no = $("#delNo").val();
            console.log("지도no " + no);

            //데이터전송
            $.ajax({
                url: "${pageContext.request.contextPath}/search/trainerInfo",
                type: "post",
                //contentType : "application/json",
                data: {no: no},

                dataType: "json",
                success: function (vo) {

                    var loca = vo.location.replace(/[|]/gi, ' ');//지역 사이의 | 지우기

                    //정보확인
                    console.log("지도 " + vo.company);
                    console.log("지도 " + loca);

                    //////////////주소검색
                    // 주소로 좌표를 검색합니다

                    //직장이름 not null일 경우

                    if (vo.company != null) {
                        relayout();//지도 레이아웃위치 설정

                        var campanyLoca = loca + ' ' + vo.company;

                        // 키워드로 장소를 검색합니다
                        ps.keywordSearch(campanyLoca, placesSearchCB);

                        // 키워드 검색 완료 시 호출되는 콜백함수 입니다
                        function placesSearchCB(data, status, pagination) {
                            if (status === kakao.maps.services.Status.OK) {

                                // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
                                // LatLngBounds 객체에 좌표를 추가합니다
                                var bounds = new kakao.maps.LatLngBounds();

                                for (var i = 0; i < data.length; i++) {
                                    displayMarker(data[i]);
                                    bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
                                }

                                // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
                                map.setBounds(bounds);
                            }

                        }

                        //지도 마커표시 함수
                        function displayMarker(place) {

                            var coords = new kakao.maps.LatLng(place.y, place.x);

                            // 마커를 생성하고 지도에 표시합니다
                            var marker = new kakao.maps.Marker({
                                map: map,
                                position: coords
                            });
                            // 인포윈도우로 장소에 대한 설명을 표시합니다
                            var infowindow = new kakao.maps.InfoWindow({
                                content: '<div style="width:150px;text-align:center;padding:6px 0;">' + vo.company + '</div>'
                            });
                            infowindow.open(map, marker);
                            // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                            map.setCenter(coords);
                        }//지도 마커표시 함수
                        $("#mapInfo").empty();

                    } else {
                        relayout();//지도 레이아웃위치 설정

                        geocoder.addressSearch(loca, function (result, status) {
                            // 정상적으로 검색이 완료됐으면
                            if (status === kakao.maps.services.Status.OK) {
                                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                                // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                                map.setCenter(coords);
                            }
                        });
                    }
                },
                error: function (XHR, status, error) {
                    console.error(status + " : " + error);
                }
            });


        });

        //지도크기 설정
        //function resizeMap() {
        //var mapContainer = document.getElementById('map');
        //mapContainer.style.width = '800px';
        // mapContainer.style.height = '500px';
        //}

        //지도 나타내기
        var container = document.getElementById('map');
        var options = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567),
            level: 3
        };

        //지도 생성
        var map = new kakao.maps.Map(container, options);

        // 장소 검색 객체를 생성합니다
        var ps = new kakao.maps.services.Places();

        // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new kakao.maps.services.Geocoder();


        //모달창에 있는 지도는 레이아웃 재설정해줘야 함
        function relayout() {
            // 지도를 표시하는 div 크기를 변경한 이후 지도가 정상적으로 표출되지 않을 수도 있습니다
            // 크기를 변경한 이후에는 반드시  map.relayout 함수를 호출해야 합니다
            // window의 resize 이벤트에 의한 크기변경은 map.relayout 함수가 자동으로 호출됩니다
            map.relayout();

        }

        ////////////////////////트레이너 모달 위치탭/////////////////////////////


    </script>
</body>
</html>