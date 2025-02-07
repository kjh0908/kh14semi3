<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>


<link rel="stylesheet" type="text/css" href="/editor/editor.css">
<script src="/editor/editor.js"></script>


<form action="write" method="post" autocomplete="off">

	<div class="container w-800 my-50">
		<div class="row center">
			<h1>게시글 작성</h1>
			<p>욕설 또는 무분별한 광고, 비방은 예고 없이 삭제될 수 있습니다</p>
		</div>
		
		<div class="row">
			<label>제목 <i class="fa-solid fa-asterisk fa-fade red"></i></label> <input
				type="text" name="boardTitle" class="field w-100" required>
		
			
		</div>
		<div class="row">
			<label>내용 <i class="fa-solid fa-asterisk fa-fade red"></i></label> 
			<textarea name="boardContent" class="field w-800" required rows="10"
				cols="80"></textarea>
			
		</div>
		<div class="row">
			<button type="submit" class="btn btn-positive w-100 mt-30">작성하기</button>
		</div>
		<div class="row">
			<a href="/board/list" class="btn btn-neutral w-100" >
                   <i class="fa-solid fa-arrow-rotate-left"></i> 뒤로가기</a>
		</div>
	</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>