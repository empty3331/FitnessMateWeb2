<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<header id="header">
    <div class="wrapper clearfix">
        <h1 class="logo">
            <a href="${pageContext.request.contextPath}/main">
                <img src="${pageContext.request.contextPath}/assets/image/logoC.png" title="logo" alt="logo">
            </a>
        </h1>
        <nav id="nav">
        </nav>
        <div class="btn-area clearfix">
        	<c:choose>
        		<c:when test="${empty authUser}">
		            <a href="#none" class="button main" id="btn_loginModal">로그인</a>
                    <a href="${pageContext.request.contextPath}/user/signUpStart" class="button sub">회원가입</a>
	            </c:when>
				<c:otherwise>
		            <a href="${pageContext.request.contextPath}/logout" class="button main" id="btn_logout">로그아웃</a>
                    <c:choose>
                        <c:when test="${authUser.userType eq 'trainer'}">
                            <a href="${pageContext.request.contextPath}/mypage/schedule" class="button sub">마이페이지</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/mypage/inbodyRecord" class="button sub">마이페이지</a>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>

<!-- 모달임미다 -->
    <div class="modal-layer" id="loginModal">
        <div class="modal-wrapper">
            <div class="modal-content">
                <p>로그인</p>
            </div>
            <div class="modal-btn-area">
                <table>
                    <colgroup>
                      <col style="width: 100px;">
                      <col style="">
                  	</colgroup>
                    <tr>
                        <th><label for="userId">아이디</label></th>
                        <td><input id="userId" type="text" name="id" value="id03"></td>
                    </tr>
                    <tr>
                        <th><label for="userPw">패스워드</label></th>
                        <td><input id="userPw" type="password" name="password" value="1234"></td>   
						<!-- 테스트하려고 아이디 비번 박아놈!!! JS에서 주석 풀어주세요 -->
                    </tr> 
                    <tr>
	                    <td colspan="2" colspan="2">
	                        <span class="errMsg">아이디 또는 비번을 확인해 주세요.</span>
	                    </td>
                    </tr> 
                </table>
                <button type="button" class="modal-cancel" onclick="forceHideModal('#loginModal')">취소</button>
                <button type="button" class="modal-confirm" id="btn_login">로그인</button>
            </div>
        </div>
    </div>

    
    
<script type="text/javascript">

	$("#btn_loginModal").on("click", function(){
	    // 이벤트 초기화
	    event.preventDefault();
	
	    // input 초기화
	    $("#userId").val("");
	    $("#userPw").val("");
	    $(".errMsg").hide();
	
	    showModal("#loginModal");
	});
	
	/* 모달-로그인버튼 */
	$("#btn_login").on("click", function(){

		console.log("로그인");
		
		var userId = $("#userId").val();
		var userPw = $("#userPw").val();
	    
		$.ajax({
			
			url : "${pageContext.request.contextPath}/user/login",		
			type : "post",
			data : {userId: userId, userPw: userPw},

			dataType : "json",
			success : function(result){
				console.log(result);
				
				/*성공시 처리해야될 코드 작성*/
				if(result){
					forceHideModal('#loginModal');

					location.reload(true);
					
				}else {
					$(".errMsg").show();
				}
				
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			} 
		})
	});
	

</script>