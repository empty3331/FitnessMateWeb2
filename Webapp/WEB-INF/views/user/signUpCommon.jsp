<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>FitnessMate</title>

    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/image/favicon.ico"/>

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


    <!-- dropzone -->
    <script src="${pageContext.request.contextPath}/assets/js/dropzone/dropzone.js"></script>
    <link href="${pageContext.request.contextPath}/assets/js/dropzone/dropzone.css" rel="stylesheet">

    <script src="${pageContext.request.contextPath}/assets/js/cropper/cropper.min.js"></script>
    <link href="${pageContext.request.contextPath}/assets/js/cropper/cropper.min.css" rel="stylesheet">

    <script src="${pageContext.request.contextPath}/assets/js/canvas-blob/canvas-toBlob.js"></script>

    <!-- 해당 페이지 css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/signUp.css">
	
</head>
<body>

    <c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
    <!-- header가 필요한 페이지에서 사용 -->

    <div id="container">
        <div class="wrapper">
            <form action="${pageContext.request.contextPath}/user/signUp" method="post" enctype="multipart/form-data" id="signInfoForm">
                <h3 class="title">기본정보 입력</h3>
                <div class="input-wrapper id-wrapper clearfix">
                    <p>아이디</p>
                    <input type="text" name="userId" placeholder="id">
                    <button type="button" class="button sub" id="idCheck">중복 확인</button>
                    <p class="errMsg">이미 사용 중인 아이디 입니다.</p>
                    <p class="emtMsg">사용 불가한 아이디 입니다.</p>
                    <p class="okMsg">사용 가능한 아이디 입니다.</p>
                </div>
                <div class="input-wrapper">
                    <p>비밀번호</p>
                    <input type="password" id="pw" name="password" placeholder="********">
                </div>
                <div class="input-wrapper">
                    <p>비밀번호 확인</p>
                    <input type="password" id="pwCheck" placeholder="********">
                </div>
                <div class="input-wrapper">
                    <p>이름</p>
                    <input type="text" name="name" placeholder="김이름">
                </div>
                <div class="input-wrapper">
                    <p>연락처 / SNS</p>
                    <input type="text" name="phone" placeholder="010-0000-1111/ID">
                </div>
                <div class="input-wrapper radio-wrapper">
                    <p>성별</p>
                    <input type="radio" id="male" name="gender" value="male">
                    <label for="male">남</label>
                    <input type="radio" id="female" name="gender" value="female">
                    <label for="female">여</label>
                </div>
                <div class="input-wrapper dropzone-outer-wrapper">
                    <p>프로필 이미지</p>
                    <div class="clearfix dropzone-inner-wrapper">
                        <div class="profile-img dropzone-wrapper">
                        </div>
                        <button type="button" class="button change-btn">이미지 추가</button>
                        <input type="hidden" name="profileImg" value="">
                    </div>
                </div>
                <input type="hidden" name="userType" value="${param.userType}">

                <c:choose>
                    <c:when test="${param.userType eq 'trainer'}">
                        <button type="submit" class="button main">다음</button>
                    </c:when>
                    <c:otherwise>
                        <button type="submit" class="button main">완료</button>
                    </c:otherwise>
                </c:choose>
            </form>
        </div>

    </div>

    <c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
    <!-- footer가 필요한 페이지에서 사용 -->


</body>

<script type="text/javascript">
	//아이디 중복체크 변수 선언
	var uniqueId = false;

    $(document).ready(function (){
       $(".errMsg").hide();
       $(".okMsg").hide();
       $(".emtMsg").hide();

        bindDropZone($(".dropzone-wrapper"));

        $(".change-btn").on("click", function(){
            $(this).siblings(".dropzone-wrapper").click();
        });
    })


    // 아이디 체크
    $("#idCheck").on("click", function(){
        // 데이터 받아와서 확인하기
        var newId = $("input[name='userId']").val();
		console.log("newId: "+newId);
		
		$.ajax({
			
			url : "${pageContext.request.contextPath}/user/idCheck",		
			type : "post",
			data : {newId: newId},

			dataType : "json",
			success : function(result){
				console.log(result);
				
				/*성공시 처리해야될 코드 작성*/
				if(result == false){
					//중복 아이디인 경우
			        $(".errMsg").show();
			        $(".emtMsg").hide();
			        $(".okMsg").hide();
				} else{
					if(newId == ""){
						//공란인경우
				        $(".errMsg").hide();
						$(".emtMsg").show();
				        $(".okMsg").hide();
					}else {
					//사용가능한 아이디인 경우
					$(".errMsg").hide();
					$(".emtMsg").hide();
			        $(".okMsg").show();
			        uniqueId = true;
					}
				}
				
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			} 
		})

    });
    
    $("button.main").on("submit", function(){

		//아이디를 입력해 주세요
		if($("input[name='userId']").val() == ""){
			alert("아이디를 입력해주세요");
			return false;
		}
		
		// 아이디 중복체크를 해주세요
		if(uniqueId == false){
			alert("아이디 중복체크를 해주세요");
			return false;
		}
		
		//패스워드를 입력해 주세요
		if($("#pw").val() == ""){
			alert("패스워드를 입력해주세요");
			return false;
		}
		
		//이름을 입력해 주세요
		if($("input[name='name']").val() == ""){
			alert("이름 입력해주세요");
			return false;
		}

		//패스워드가 일치하지 않습니다
		if($("#pw").val() != $("#pwCheck").val()){
			alert("패스워드가 일치하지 않습니다");
			return false;
		}
		
	});

    //crop and upload
    function bindDropZone(target) {
        target.dropzone({
            autoProcessQueue: true,
            url: "${pageContext.request.contextPath}/upload/image",
            previewTemplate: "<img class='dropzone-previews' alt='' title=''>",
            parallelUploads: 1000,
            acceptedFiles: ".jpeg,.jpg,.png,.gif,.JPEG,.JPG,.PNG,.GIF",
            success: function (file) {
                var fileName = file.xhr.responseText.replace(/\"/gi, "");
                var imageUrl = "${pageContext.request.contextPath}/upload/"+fileName;
                var last = target.find(".dropzone-previews").last();
                target.siblings("input[name='profileImg']").val(fileName);
                last.attr("src", imageUrl);
                last.siblings('.dropzone-previews').remove();
            },
            transformFile: function (file, done) {
                var myDropZone = this;

                // Create the image editor overlay
                var editor = document.createElement('div');
                editor.classList.add('crop-wrapper');


                // Create the confirm button
                var confirm = document.createElement('button');


                confirm.classList.add('confirm');
                confirm.textContent = '확인';
                confirm.addEventListener('click', function () {

                    // Get the canvas with image data from Cropper.js
                    var canvas = cropper.getCroppedCanvas({
                        width: 320,
                        height: 240
                    });


                    // Turn the canvas into a Blob (file object without a name)
                    canvas.toBlob(function (blob) {

                        // Update the image thumbnail with the new image data
                        myDropZone.createThumbnail(
                            blob,
                            myDropZone.options.thumbnailWidth,
                            myDropZone.options.thumbnailHeight,
                            myDropZone.options.thumbnailMethod,
                            false,
                            function (dataURL) {

                                // Update the Dropzone file thumbnail
                                myDropZone.emit('thumbnail', file, dataURL);

                                // Return modified file to dropzone
                                done(blob);
                            }
                        );

                    }, file.type);

                    // Remove the editor from view
                    editor.parentNode.removeChild(editor);
                });
                editor.appendChild(confirm);

                // Create the cancel button
                var cancel = document.createElement('button');
                var thisPreview = target.find('.dropzone-previews').last();

                cancel.classList.add('cancel');
                cancel.textContent = '취소';
                cancel.addEventListener('click', function () {
                    // Remove the editor from view
                    thisPreview.remove();
                    document.body.removeChild(editor);
                });
                editor.appendChild(cancel);

                // Load the image
                var image = new Image();
                image.src = URL.createObjectURL(file);
                editor.appendChild(image);

                // Append the editor to the page
                document.body.appendChild(editor);

                // Create Cropper.js and pass image
                var cropper = new Cropper(image, {
                    aspectRatio: 1 / 1,
                    zoomOnWheel: false,
                    autoCropArea: 0.5,
                    viewMode: 2,
                    minCanvasWidth: 200
                });
            }

        });
    }
    
</script>
</html>