<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9bdfa0d98e7c6b1949b387b6e48e0de3&libraries=services"></script>
</head>
<body>
	
	<style>
	
		#content{
			height: auto;
			width: 1200px;
			margin-left: auto;
			margin-right: auto;
		}
		h2 {
			text-align: center;
		}
		table {
			margin-top: 20px;
			margin-left: auto;
			margin-right: auto;
			width: 800px;
			height: auto;
			
		}
		tr, td {
			padding-top: 15px;
			/* padding-bottom: 5px; */
			font-size: 16px;
		}
		tr {
			width: auto;
			border: 1px solid black;
		}
		td {
			padding: 13px 0;
			padding-left: 10px;
			/* padding-left: 10px; */
			border-bottom: 1px solid #cbcbcb;
		}
		table tr td:first-child {
	        width: 150px;
	        font-weight: bold;
    	}
		table tr td:nth-child(2) {
	        color: #525252;
    	}
    	#listbtn-container {
	        text-align: right;
	        margin-top: 10px;
	        width: 800px; /* 부모 컨테이너의 너비를 설정 */
	        margin-left: auto;
	        margin-right: auto;
	    }
    	#listbtn {
    		background-color: #f5f5f5;
		    color: #525252;
		    border: 1px solid grey;
		    padding: 5px 10px;
		    border-radius: 5px;
		    /* float: right; */
    	}
    	#hr-container {
    		text-align: center;
    	}
    	hr {
    		height: 1px;
    		text-align: center;
    		width: 800px;
    		color: #cbcbcb;
    		margin: 20px auto;
    	}
    	#pre_next_table td:first-child{
    		background-color: #f5f5f5;
    	}
	</style>
	
	<script>
		function list() {
			window.location.replace('parking');
		}
	</script>
		
	
	<h2>서울시 공영주차장 상세정보</h2>
		<table>
			<tr>
				<td>이름</td>
				<td>${seoul_parking_view.p_name }</td>
			</tr>
			<tr>
				<td>주소</td>
				<td>${seoul_parking_view.p_address }</td>
			</tr>
			<tr>
				<td>종류</td>
				<td>${seoul_parking_view.p_kind_name }</td>
			</tr>
			<tr>
				<td>운영</td>
				<td>${seoul_parking_view.p_management_name }</td>
			</tr>
			<tr>
				<td>유/무료</td>
				<td>${seoul_parking_view.p_paid_and_free_name }</td>
			</tr>
			<tr>
				<td>야간 운영</td>
				<td>${seoul_parking_view.p_free_night }</td>
			</tr>
			<tr>
				<td>운영</td>
				<td>${seoul_parking_view.p_management_name }</td>
			</tr>
			<tr>
				<td>주차 가능 대수</td>
				<td>${seoul_parking_view.p_total_space }대</td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td>
					<c:choose>
						<c:when test="${seoul_parking_view.p_tel == null }">
							전화번호 없음
						</c:when>
						<c:otherwise>
							${seoul_parking_view.p_tel }
						</c:otherwise>
					</c:choose>
					
				</td>
			</tr>
			<tr>
				<td>운영시간</td>
				<td>
					<c:choose>
						<c:when test="${seoul_parking_view.p_week_open_time eq 0}">
						</c:when>
						<c:otherwise>
							평일 : ${seoul_parking_view.p_week_open_time }~
							${seoul_parking_view.p_week_end_time } <br />
							주말 및 공휴일 : ${seoul_parking_view.p_weekend_open_time }~
							${seoul_parking_view.p_weekend_end_time }
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td>기본 시간 / 기본 요금</td>
				<td>${seoul_parking_view.p_default_time_min}분 / ${seoul_parking_view.p_default_price }원</td>
			</tr>
			<tr>
				<td>추가 시간 / 추가 요금</td>
				<td>${seoul_parking_view.p_add_price_min }분 / ${seoul_parking_view.p_add_price }원</td>
			</tr>
			<tr>
			    <td>약도</td>
			    <td>
			        <div id="mapContainer" style="width:500px;height:350px;"></div>
			        <div id="noMapMessage" style="display:none;">약도없음</div>
			        <script>
			            var mapContainer = document.getElementById('mapContainer'); // 지도를 표시할 div 
			            var noMapMessage = document.getElementById('noMapMessage'); // 약도없음 메시지를 표시할 div
			            var latitude = ${seoul_parking_view.p_latitude};
			            var hardness = ${seoul_parking_view.p_hardness};
			            
			            if (latitude == null || hardness == null) {
			                // latitude 또는 hardness가 null이면 약도없음 표시
			                noMapMessage.style.display = 'block';
			            } else {
			                var mapOption = { 
			                    center: new kakao.maps.LatLng(latitude, hardness), // 지도의 중심좌표
			                    level: 3 // 지도의 확대 레벨
			                };
			                
			                var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
			                
			                // 마커가 표시될 위치입니다 
			                var markerPosition  = new kakao.maps.LatLng(latitude, hardness); 
			                
			                // 마커를 생성합니다
			                var marker = new kakao.maps.Marker({
			                    position: markerPosition
			                });
			                
			                // 마커가 지도 위에 표시되도록 설정합니다
			                marker.setMap(map);
			                
			                // 아래 코드는 지도 위의 마커를 제거하는 코드입니다
			                // marker.setMap(null);    
			            }
			        </script>
			    </td>
			</tr>



		</table>
		<div id="hr-container">
			<hr />
		</div>
		
		<div>
			<table id="pre_next_table">
				<tr>
					<td>이전글</td>
					<td>${seoul_parking_view.p_name }</td>
				</tr>
				<tr>
					<td>다음글</td>
					<td>다음글</td>
				</tr>
			</table>
		</div>		
		
		<div id="hr-container">
			<hr />
		</div>
		
		
		<div id="listbtn-container">
			<button id="listbtn" onclick="list();">목록</button>
		</div>
</body>
</html>
 