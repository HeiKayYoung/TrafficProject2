<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
			font-size: 16px;
		}
		tr {
			width: auto;
			border: 1px solid black;
		}
		td {
			padding: 13px 0;
			padding-left: 10px;
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
	        width: 800px; 
	        margin-left: auto;
	        margin-right: auto;
	    }
    	#listbtn {
    		background-color: #f5f5f5;
		    color: #525252;
		    border: 1px solid grey;
		    padding: 5px 10px;
		    border-radius: 5px;
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
    	#charger {
    		width: 250px;
    		height: 200px;
    	}
	</style>
	
	<script>
		function list() {
			window.location.replace('electric_charge');
		}
	</script>
		
	
	<h2>서울시 전기차 충전소 상세정보</h2>
		<table>
			<tr>
				<td>이름</td>
				<td>${ec_view.ec_charge }</td>
			</tr>
			<tr>
				<td>주소</td>
				<td>${ec_view.ec_address }</td>
			</tr>
			<tr>
				<td>시설구분</td>
				<td>${ec_view.ec_charge_parking }</td>
			</tr>
			<tr>
				<td>충전기 타입</td>
				<td id="charger">
				    <c:choose>
				        <c:when test="${ec_view.ec_charge_type eq 'DC콤보'}">
				            <img alt="DC콤보_충전기" src="resources/img/dc_combo.png"><br />
				            ${ec_view.ec_charge_type}
				        </c:when>
				    </c:choose>
				</td>

			</tr>
			<tr>
				<td>충전기 용량</td>
				<td>${ec_view.ec_kw }</td>
			</tr>
			<tr>
				<td>충전기 갯수</td>
				<td>${ec_view.ec_charge_id }개</td>
			</tr>
			<tr>
				<td>운영 시간</td>
				<td>${ec_view.ec_time }</td>
			</tr>
			<tr>
			    <td>약도</td>
			    <td>
			    	<div id="map" style="width:500px;height:350px;"></div>
			    	
				    <script>
					    var mapContainer = document.getElementById('map');
					    var mapOption = {
					        center: new kakao.maps.LatLng(33.450701, 126.570667),
					        level: 3
					    };
					
					    var map = new kakao.maps.Map(mapContainer, mapOption);
					
					    var geocoder = new kakao.maps.services.Geocoder();
					
					    var address = '${ec_view.ec_address}';
					    
					    geocoder.addressSearch(address, function(result, status) {
					        if (status === kakao.maps.services.Status.OK) {
					            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
					
					            var marker = new kakao.maps.Marker({
					                map: map,
					                position: coords
					            });
					
					            var infowindow = new kakao.maps.InfoWindow({
					                content: '<div style="width:auto;text-align:center;padding:6px 0;">${ec_view.ec_charge}</div>'
					            });
					            infowindow.open(map, marker);
					
					            map.setCenter(coords);
					        }
					    });
					</script>
				</td>
			</tr>



		</table>
		<div id="hr-container">
			<hr />
		</div>
		<div id="listbtn-container">
			<button id="listbtn" onclick="list();">목록</button>
		</div>
		
		
		
</body>
</html>
 