<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>		
	.class-regist{
		cursor: pointer;
	}
	/* .kh-container{
	    height: auto !important; 
	} */
</style>

<script type="text/javascript">
	$(function(){
		$(".class-regist").each(function() {
	        var lectureCode = $(this).parent().parent().find(".lecture-code").text();
	        var btn = $(this);

	        $.ajax({
	            url: "/rest/registration/check",
	            method: "post",
	            data: {lectureCode: lectureCode},
	            success: function(response) {
	                if (response.checked) {
	                    // 이미 수강신청이 완료된 경우
	                    $(btn).removeClass("class-regist link link-animation");
	                    $(btn).off("click");
	                    $(btn).css("cursor", "not-allowed").css("text-decoration-line", "none"); // 클릭할 수 없도록 커서 스타일 변경
	                    $(btn).attr("title", "이미 수강신청 완료"); // 마우스 오버 시 메시지 표시
	                }
	                // 수강신청 상태가 아닐 경우에는 기본 상태를 유지
	            }
	        });
	    });
		
		function loadCheck() {
			 Swal.fire({
                 icon: 'success',
                 iconColor: "#6695C4",
                 title: '성적 저장 완료.',
                 showConfirmButton: false,
                 timer: 1500         
        		 });
		};				
});
</script>

<c:if test="${sessionScope.createdRank == '학생'}">
<script type="text/javascript">
	// (회원전용) 강의명을 누르면 수강 신청 처리를 수행	
	$(function(){
		$(".class-regist").on("click",function(e){
			var lectureCode = $(this).parent().parent().find(".lecture-code").text();
			var btn = this;
			e.stopPropagation();
			$.ajax({
				url: "/rest/registration/regist",
				method: "post",
				data: {lectureCode : lectureCode},
				success: function(response){
					if(response.checked){						
						// 너의 수강신청목록에 이거 넣었어 라는 문구 출력
						/* window.alert("수강 신청 완료!"); */
	                    loadCheck();
						$(btn).removeClass("class-regist link link-animation");
						$(btn).off("click");
	                    $(btn).css("cursor", "not-allowed").css("text-decoration-line", "none"); // 클릭할 수 없도록 커서 스타일 변경
	                    $(btn).attr("title", "이미 수강신청 완료"); // 마우스 오버 시 메시지 표시
					}
					$(btn).parent().parent().find(".lecture-count").text(response.count);
				}
			});
		});
		
		function loadCheck() {
			 Swal.fire({
                icon: 'success',
                iconColor: "#6695C4",
                title: '수강 신청 완료.',
                showConfirmButton: false,
                timer: 1500         
       		 });
		};			
		
	});
</script>
</c:if>

<%-- createdUser = ${sessionScope.createdUser} , 
createdRank = ${sessionScope.createdRank}
	
<a href="regist" class="btn btn-neutral">이동</a> --%>

<div class="container w-1000 my-50">
	<div class="row center">
		<h1>강의 목록</h1>
	</div>

	<div class="row center">
		<form action="list" method="get" autocomplete="off">
			<!-- 검색창 --> 
			<select class="field" name="column">
			<option value="department_name" <c:if test="${param.column == 'department_name'}">selected</c:if>>전공(학과)</option>
			<option value="member_name" <c:if test="${param.column == 'member_name'}">selected</c:if>>교수명</option>
			<option value="lecture_type" <c:if test="${param.column == 'lecture_type'}">selected</c:if>>분류</option>
			<option value="lecture_name" <c:if test="${param.column == 'lecture_name'}">selected</c:if>>강의명</option>
		</select>
		<input class="field" type="search" name="keyword" value="${param.keyword}">
			<button class="btn btn-neutral">검색</button>
		</form>
	</div>
	
 
	<div class="row center">
		<c:choose>
			<%-- 결과가 없을 때 --%>
			<c:when test="${lectureList.isEmpty()}">
				<h2>결과가 존재하지 않습니다</h2>
			</c:when>
			<%-- 결과가 있을 때 --%>
			<c:otherwise>
				<!-- 결과 화면 -->
				<!-- <div class="right">
					<i class="fa-brands fa-slack red"></i> 강의명 클릭시 상세 정보 페이지로 이동
				</div>	 -->			
				<table class="table table-horizontal table-hover">
					<thead>
						<tr>
							<th>전공(학과)</th>
							<th>교수명</th>
							<th>분류</th>
							<th>강의명</th>
							<th>강의코드</th>
							<th>강의시간</th>
							<th>강의실</th>
							<th>수강인원</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody class="center">					
						<c:forEach var="lectureMemberVO" items="${lectureList}">
						<tr onclick="location.href='/lecture/detail?lectureCode=${lectureMemberVO.lectureCode}&&goWhere=regist1'" style="cursor: pointer;">
							<td>${lectureMemberVO.departmentName}</td>
							<td>${lectureMemberVO.memberName}</td>
							<td>${lectureMemberVO.lectureType}</td>
							<td>${lectureMemberVO.lectureName}</td>
							<td class="lecture-code">${lectureMemberVO.lectureCode}</td>
							<td>${lectureMemberVO.lectureDay} ${lectureMemberVO.lectureTime} (${lectureMemberVO.lectureDuration}시간)</td>
							<td>${lectureMemberVO.lectureRoom}</td>
							<td>
								<span class="lecture-count">${lectureMemberVO.lectureRegist}</span>
								/${lectureMemberVO.lectureCount}
							</td>		
							<td class="">
								<a href="#" class="link link-animation class-regist">수강신청</a>
							</td>					
						</tr>					
						</c:forEach>
					</tbody>
				</table>
			</c:otherwise>
		</c:choose>
	</div>
</div>

<%-- navigator.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/navigator.jsp"></jsp:include>


<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
	
