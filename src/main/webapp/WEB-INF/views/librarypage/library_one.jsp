<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.multi.mini6.librarypage.vo.LibraryVO" %>

<html>
<head>
<meta charset="UTF-8">
    <title>다독다독 도서관 정보</title>
    <!-- 부트스트랩 및 자바스크립트 CDN -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=feb6a3c31b035f2a61bd30ac29509330&libraries=services"></script>

    <!-- Favicons -->
    <link href="../../../resources/assets/img/favicon.png" rel="icon">
    <link href="../../../resources/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Muli:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
          rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="../../../resources/assets/vendor/animate.css/animate.min.css" rel="stylesheet">
    <link href="../../../resources/assets/vendor/aos/aos.css" rel="stylesheet">
    <link href="../../../resources/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../../resources/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="../../../resources/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="../../../resources/assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
    <link href="../../../resources/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

    <!-- jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- Template Main CSS File -->
    <link href="../../../resources/assets/css/style.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet">


    <script type="text/javascript">
        // URL에서 파라미터 값을 가져오는 함수
        function getParameterByName(name, url) {
            if (!url) url = window.location.href;
            name = name.replace(/[\[\]]/g, '\\$&');
            var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
                results = regex.exec(url);
            if (!results) return null;
            if (!results[2]) return '';
            return decodeURIComponent(results[2].replace(/\+/g, ' '));
        }

        $(function() {
            $('#isbnSearch').click(function(e) {
                e.preventDefault(); // 폼 제출 방지
                // 입력된 ISBN 값을 가져옵니다.
                var isbn = $('#bookName').val();

                // 현재 페이지 URL에서 lib_code를 추출합니다.
                var libCode = getParameterByName('lib_code');

                // 실제 API 호출 주소와 키를 적절히 설정합니다.
                var apiUrl = "https://data4library.kr/api/bookExist";
                var authKey = "66bc011815c930ce9aea4fd77457d0b260cf3f15d673ae40221351dc126bc127";

                console.log("ISBN:", isbn);
                console.log("Library Code:", libCode);

                $.ajax({
                    url: apiUrl,
                    data: {
                        authKey: authKey,
                        libCode: libCode,
                        isbn13: isbn,
                        format: "json"
                    },
                    dataType: "json",
                    success: function(response) {
                        console.log("API Response:", response);
                        console.log("API response.response:",  response.response);
                        console.log("API response.response.result:", response.response.result);
                        // API 응답 결과를 가지고 원하는 형태로 표시합니다.
                        if (response && response.response && response.response.result) {
                            var result = response.response.result;
                            var request = response.response.request;
                            var hasBook = result.hasBook === "Y" ? "네" : "아니오";
                            var loanAvailable = result.loanAvailable === "Y" ? "네" : "아니오";
                              console.log("hasBook : " + hasBook);
                              console.log("loanAvailable : " + loanAvailable);
                              console.log(response.response.request);
                              console.log(response.response.request.isbn13);

                            // 결과를 화면에 출력
                            var resultHtml = '<p>ISBN: ' +request.isbn13 +'</p><p>도서관 코드: ' + request.libCode + '</p><p>소장 여부: ' +hasBook + '</p><p>대출 가능 여부: ' +loanAvailable +'</p>';
                            $('#result2').html(resultHtml); // 결과를 result2에 표시
                        } else {
                            $('#result2').html("<p>검색 결과가 없습니다.</p>");
                        }
                    },
                    error: function(error) {
                        console.error("API 호출 중 오류 발생:", error);
                        $('#result2').html("<p>오류가 발생했습니다. 다시 시도해주세요.</p>");
                    }
                });
            });
        });
    </script>


    <style>

        /* Some basic custom styles */
        /*.container {*/
        /*        margin-top: 20px;*/
        /*    }*/
        .container2 {
            display : flex;
            justify-content: center; /* 가로 중앙 정렬 */

        }
        #map {
            margin: 0 auto; /* 가로 중앙 정렬 */
            width: 50%;
            height: 350px;
        }
        .custom-width-15 {
            width: 15%;
        }

    </style>

<%
    LibraryVO libraryVO = (LibraryVO) request.getAttribute("bag");
%>

</head>
<body>
<!-- ======= Top Bar ======= -->
<jsp:include page="/WEB-INF/views/topbar.jsp"/>
<!-- End Top Bar -->

<!-- ======= Header ======= -->
<jsp:include page="/WEB-INF/views/header.jsp"/>
<!-- End Header -->
<!-- ======= Breadcrumbs ======= -->
<section id="breadcrumbs" class="breadcrumbs">
    <div class="container">

        <div class="d-flex justify-content-between align-items-center">
            <h2>도서관</h2>
            <ol>
                <li><a href="../mainpage/index">Home</a></li>
                <li>Library</li>
            </ol>
        </div>

    </div>
</section>
<!-- End Breadcrumbs -->

<div class="container">
    <div class="container mt-5 text-center">

        <h3>${bag.lib_name}</h3>
        <br>
    </div>

    <div id="map" style="width:50%;height:350px;"></div>
    <br>

    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=feb6a3c31b035f2a61bd30ac29509330"></script>
    <script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(${bag.lib_latitude}, ${bag.lib_longitude}), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };

    var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

    // 마커가 표시될 위치입니다
    var markerPosition  = new kakao.maps.LatLng(${bag.lib_latitude}, ${bag.lib_longitude});

    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        position: markerPosition
    });

    // 마커가 지도 위에 표시되도록 설정합니다
    marker.setMap(map);

    // 아래 코드는 지도 위의 마커를 제거하는 코드입니다
    // marker.setMap(null);

    var iwContent = '<div style="padding:5px;">${bag.lib_name}</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
        iwPosition = new kakao.maps.LatLng(${bag.lib_latitude}, ${bag.lib_longitude}), //인포윈도우 표시 위치입니다
        iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

    // 인포윈도우를 생성하고 지도에 표시합니다
    var infowindow = new kakao.maps.InfoWindow({
        map: map, // 인포윈도우가 표시될 지도
        position : iwPosition,
        content : iwContent,
        removable : iwRemoveable
    });

    </script>

    <div id="result">
        <table class="table table-bordered">
            <tr>
                <td class="custom-width-15"><strong>주소</strong></td>
                <td>${bag.lib_address }</td>
            </tr>
            <tr>
                <td><strong>전화번호</strong></td>
                <td>${bag.lib_tel }</td>
            </tr>
            <tr>
                <td><strong>FAX번호</strong></td>
                <td>${bag.lib_fax }</td>
            </tr>
            <tr>
                <td><strong>홈페이지</strong></td>
                <td><a href="${bag.lib_homepage}" target="_blank">${bag.lib_homepage}</a></td>
            </tr>
            <tr>
                <td><strong>휴관일</strong></td>
                <td>${bag.lib_closed}</td>
            </tr>
            <tr>
                <td><strong>운영시간</strong></td>
                <td>${bag.lib_operating_time}</td>
            </tr>
            <tr>
                <td><strong>단행본수</strong></td>
                <td>${bag.lib_bookcount}</td>
            </tr>
        </table>
    </div>

    <div class="row justify-content-center text-center">
        <div class="col-6">
            <a href="library_list3" class="btn btn-primary btn-block">도서관 목록 보기</a>
        </div>
    </div>
    <br><br><hr><br><br>
    <div class="container mt-5 text-center">
        <h4>도서 소장/대출 여부 검색</h4>
        <br>
        찾고자 하는 책 isbn을 입력하세요.
        <br><br>
        <div class="row justify-content-center">
            <div class="col-md-6 text-center mx-auto">
                <input type="text" id="bookName" name="bookName" class="form-control" placeholder="책 검색" required >
                <br>
                <button id="isbnSearch" type="submit" class="btn btn-primary">검색</button>
            </div>
        </div>
        <br>
        <div id="result2">
            검색 버튼을 누르면 검색 결과가 표시됩니다.<br>
            정보 제공을 하지 않는 도서관의 결과는 표시되지 않으며, 데이터는 1일 단위로 갱신됩니다.
        </div>
    </div>

</div>

<br><br><br>
<!-- ======= Footer ======= -->
<jsp:include page="/WEB-INF/views/footer.jsp"/>
<!-- End Footer -->

</body>
</html>
