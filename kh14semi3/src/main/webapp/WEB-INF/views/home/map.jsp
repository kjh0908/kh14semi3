<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> <!-- hearder 추가 -->

<!-- google font cdn -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<style>
.kakao-map{
   	position: relative;
	width: 100%;
	height: 100%;
	/* width: 100%; */
	/* height: 84.3vh; */
	z-index: 1;
	margin: auto;
	padding: auto;
}
.btn{
	position: absolute;
	z-index: 5;
	flex-direction: column;
}
.omega{
	position: absolute;
	z-index: 5;
	background-color: rgba(255, 255, 255, 0.9);
}
.underline{
	border-bottom: 1px solid;
	border-top: none;
    border-left: none;
    border-right: none;
    padding-left: 0;
    padding-right: 0;
    border-radius: 0;
}
.btn-map{
	margin-bottom: 5px;
}

.btn-map.red i {
    color: red;
}

.btn-map.black i {
    color: black;
}
</style>
     
<!--카카오 맵-->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7d514f39f1a90b1f9acaf2ac1526268a"></script>
	 
<!--자바스크립트 코드 작성 영역-->
<script type="text/javascript">
$(function(){
	//지도를 생성하기 위해 태그를 선택한다
	var container = document.querySelector('.kakao-map');

	//카카오 지도에 대한 옵션 객체를 생성한다
	//- center:지도의 중심
	//- level:지도의 확대수준(1~15)
	var options = {
		center: new kakao.maps.LatLng(37.533826, 126.896837),
		level: 3
	};

	//태그와 옵션을 이용하여 카카오 지도를 생성한다
    //(window.)자유롭게 접근 가능하도록 window 탑재
	window.kakaoMap = new kakao.maps.Map(container, options);
	kakaoMap.setLevel(3);
    var marker;
    
    var imageSrc = "/images/education.png", // 마커 이미지 넣는 곳
    imageSize = new kakao.maps.Size(64, 69),
    imageOption = { offset: new kakao.maps.Point(27, 69) };
    // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
    //(추가)위치정보가 담긴 버튼들을 누르면 해당 위치로 지도를 이동
	
    function loadMapList(map){
        var lat, lng;
        $("btn-map").removeClass("red").addClass("black");
        switch(map) {
          case 'jongRo':
            lat = 37.5679;
            lng = 126.983;
            kakaoMap.setLevel(3);
            $(".jongRo").removeClass("black").addClass("red");
            $(".jongRo i").removeClass("black").addClass("red");
            break;
          case 'dangSan':
            lat = 37.533826;
            lng = 126.896837;
            kakaoMap.setLevel(3);
            $(".dangSan").removeClass("black").addClass("red");
            $(".dangSan i").removeClass("black").addClass("red");
            break;
          case 'gangNam':
            lat = 37.499;
            lng = 127.0328;
            kakaoMap.setLevel(3);
            $(".gangNam").removeClass("black").addClass("red");
            $(".gangNam i").removeClass("black").addClass("red");
            break;
          default:
            lat = 37.533826;
            lng = 126.896837;
            kakaoMap.setLevel(3);
            $(".dangSan").removeClass("black").addClass("red");
            $(".dangSan i").removeClass("black").addClass("red");
            break;
        }
        
        var location = new kakao.maps.LatLng(lat, lng);
        kakaoMap.setCenter(location);
        if (window.kakaoMapMarker) {
          kakaoMapMarker.setMap(null);
          kakaoMapMarker = null;
        }
        
        window.kakaoMapMarker = new kakao.maps.Marker({
            position: location,
            image: markerImage
          });
          kakaoMapMarker.setMap(kakaoMap);
        }

        var params = new URLSearchParams(location.search);
        var map = params.get("mapW");

      loadMapList(map);
    $(".btn-map").click(function(){ 
      //this == 클릭당한 버튼
      var lat = $(this).attr("data-lat");//버튼에 써있는 위도 정보 읽기
      var lng = $(this).attr("data-lng");//버튼에 써있는 경도 정보 읽기
      $(".btn-map").removeClass("red").addClass("black");
      $(".btn-map i").removeClass("red").addClass("black");
      $(this).removeClass("black").addClass("red");
      $(this).find('i').removeClass("black").addClass("red");
      //지도를 이동하는 코드
      var location = new kakao.maps.LatLng(lat, lng);
      kakaoMap.setLevel(3);
      kakaoMap.setCenter(location);

      // 마커(Marker) 생성
      // 지도에 단 하나의 마커를 계속 관리해야 하므로 window에 탑재
      // 이렇게 하여 마커 생성 전에 기존에 있는 마커를 제거할 수 있따
      if(window.kakaoMapMarker){//만약에 window.kakaoMapMarker가 있다면
        kakaoMapMarker.setMap(null);//연결된 지도를 없애고
        kakaoMapMarker=null;//값을 제거해라(할당 해제)
      }

      window.kakaoMapMarker = new kakao.maps.Marker({
        position:location,
        image: markerImage
      });
      //마커에 지도를 설정
      kakaoMapMarker.setMap(kakaoMap);

    });
    
});
</script>
   

<div class="container omega px-10 mx-20 my-20">
		<div class=" center">
			<h3 class="my-0 underline">캠퍼스 정보</h3>
		</div>
		<div class="mt-10 center">
			<a href="#" data-lat="37.499" data-lng="127.0328" class="link link-animation black btn-map gangNam">
				강남 캠퍼스 
				<i class="fa-solid fa-location-arrow black"></i>
			</a>
		</div>
		<div class=" center">
			<a href="#" data-lat="37.5679" data-lng="126.983" class="link link-animation black btn-map jongRo">
				종로 캠퍼스
				<i class="fa-solid fa-location-arrow black"></i>
			</a>
		</div>
		<div class=" center">
			<a href="#"  data-lat="37.533826" data-lng="126.896837" class="link link-animation black btn-map dangSan">
				당산 캠퍼스
				<i class="fa-solid fa-location-arrow black"></i>
			</a>
		</div>
	</div>
	
	<!-- <div class="flex-box"> -->
		<div class="kakao-map"></div>
	<!-- </div> -->	



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> <!-- footer 추가 -->
