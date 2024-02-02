<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
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

    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=feb6a3c31b035f2a61bd30ac29509330"></script>

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

    <!-- 이름 페이징 스크립트 -->
    <script>
        $(function() {
            $('.pages').click(function(e) {
                //e.preventDefault();
                var page = parseInt($(this).data('page'));
                //alert(page)
                if ($(this).text() === '다음 »') {
                    //page = parseInt($('.pages').last().data('page'));
                    location.href = "library_search_name?page=" + page + "&&keyword=" + '${keyword}'
                }
                if ($(this).text() === '« 이전') {
                    location.href = "library_search_name?page=" + page + "&&keyword=" + '${keyword}'
                }
                console.log('pages.click')
                $.ajax({
                    url: "library_search_name2",
                    data: {
                        page: page, //6
                        keyword: '${keyword}'
                    },
                    success: function(table) {
                        $('#result').html(table);
                    }
                });
            });
        });
    </script>
    <!-- 이름으로 검색 -->
        <script type="text/javascript">
            $(function() {
                $('#search_name').click(function(e) {
                    var page = parseInt($(this).data('page'));
                    //e.preventDefault();
                    console.log( $(this).text());

                    $.ajax({
                        url: "library_search_name",
                        data: {
                            page: $(this).text(),
                            keyword: '${keyword}'
                        },
                        success: function(table) {
                            $('#result').html(table);
                            $('#keyword').val('${keyword}');
                            alert(response);
                        },
                        error: function(error) {
                            console.error(error);
                        }
                    });
                });
            });
        </script>

        <!-- 지역으로 검색 -->
        <script type="text/javascript">
            $(function() { })
                function search_address() {
                    var page = parseInt($('#currentPage').val());
                    //e.preventDefault();
                    console.log( $(this).text());
                    var regionSelect = $('#regionSelect option:selected').val();
                    var categorySelect = $('#categorySelect option:selected').val();
                    console.log('Selected Region:', regionSelect);
                    console.log('Selected Category:', categorySelect);

                    // 폼에 추가 데이터를 넣고 폼 제출
                    var form = $('<form action="library_search_address" method="GET">' +
                        '<input type="hidden" name="page" value="' + page + '">' +
                        '<input type="hidden" name="regionSelect" value="' + regionSelect + '">' +
                        '<input type="hidden" name="categorySelect" value="' + categorySelect + '">' +
                        '</form>');
                    $('body').append(form);
                    form.submit();
                }
                    //var categorySelect3 = $('#categorySelect option:selected').val();
                    //alert(categorySelect3);
                    //검색 결과 서버로 전송
                    //$.ajax({
                    //    url: "library_search_address",
                    //    type: GET,
                    //    data: {
                    //        page: page,
                    //        regionSelect: regionSelect,
                    //        categorySelect: categorySelect
                    //    },
                    //    success: function(table) {
                    //        $('#result').html(table);
                    //        $('#regionSelect').val('${regionSelect}');
                    //        $('#categorySelect').val('${categorySelect}');
                    //        alert(response);
                    //    },
                    //    error: function(error) {
                    //        console.error(error);
                    //    }

        </script>

        <!-- 지역으로 검색 동적 카테고리 -->
        <script>
            $(function(){

            })

            function updateCategoryOptions() {
                var regionSelect = document.getElementById('regionSelect');
                var categorySelect =document.getElementById('categorySelect')

                // 기존 카테고리 옵션 제거
                while (categorySelect.options.length > 1) {
                    categorySelect.remove(1);
                }

                // 선택된 지역에 따라 카테고리 옵션 추가
                var selectedRegion = regionSelect.value;
                switch (selectedRegion) {
                    case '서울특별시':
                        addCategoryOption('종로구');
                        addCategoryOption('중구');
                        addCategoryOption('용산구');
                        addCategoryOption('성동구');
                        addCategoryOption('광진구');
                        addCategoryOption('동대문구');
                        addCategoryOption('중랑구');
                        addCategoryOption('성북구');
                        addCategoryOption('강북구');
                        addCategoryOption('도봉구');
                        addCategoryOption('노원구');
                        addCategoryOption('은평구');
                        addCategoryOption('서대문구');
                        addCategoryOption('마포구');
                        addCategoryOption('양천구');
                        addCategoryOption('강서구');
                        addCategoryOption('구로구');
                        addCategoryOption('금천구');
                        addCategoryOption('영등포구');
                        addCategoryOption('동작구');
                        addCategoryOption('관악구');
                        addCategoryOption('서초구');
                        addCategoryOption('강남구');
                        addCategoryOption('송파구');
                        addCategoryOption('강동구');
                        break;
                    case '부산광역시':
                        addCategoryOption('중구');
                        addCategoryOption('서구');
                        addCategoryOption('동구');
                        addCategoryOption('영도구');
                        addCategoryOption('부산진구');
                        addCategoryOption('동래구');
                        addCategoryOption('남구');
                        addCategoryOption('북구');
                        addCategoryOption('해운대구');
                        addCategoryOption('사하구');
                        addCategoryOption('금정구');
                        addCategoryOption('강서구');
                        addCategoryOption('연제구');
                        addCategoryOption('수영구');
                        addCategoryOption('사상구');
                        addCategoryOption('기장군');
                        break;
                    case '대구광역시':
                        addCategoryOption('중구');
                        addCategoryOption('동구');
                        addCategoryOption('서구');
                        addCategoryOption('남구');
                        addCategoryOption('북구');
                        addCategoryOption('수성구');
                        addCategoryOption('달서구');
                        addCategoryOption('달성군');
                        addCategoryOption('군위군');
                        break;
                    case '인천광역시':
                        addCategoryOption('증구');
                        addCategoryOption('동구');
                        addCategoryOption('미추홀구');
                        addCategoryOption('연수구');
                        addCategoryOption('남동구');
                        addCategoryOption('부평구');
                        addCategoryOption('계양구');
                        addCategoryOption('서구');
                        addCategoryOption('강화군');
                        addCategoryOption('옹진군');
                        break;
                    case '광주광역시':
                    	addCategoryOption('동구');
                    	addCategoryOption('서구');
                    	addCategoryOption('남구');
                    	addCategoryOption('북구');
                    	addCategoryOption('광산구');
                    	break;
                    case '대전광역시':
                        addCategoryOption('동구');
                        addCategoryOption('중구');
                        addCategoryOption('서구');
                        addCategoryOption('유성구');
                        addCategoryOption('대덕구');
                        break;
                    case '울산광역시':
                        addCategoryOption('중구');
                        addCategoryOption('남구');
                        addCategoryOption('동구');
                        addCategoryOption('북구');
                        addCategoryOption('울주구');
                        break;
                    case '세종특별자치시':
                        addCategoryOption('');
                        break;
                    case '경기도':
                        addCategoryOption('수원시');
                        addCategoryOption('용인시');
                        addCategoryOption('고양시');
                        addCategoryOption('화성시');
                        addCategoryOption('성남시');
                        addCategoryOption('부천시');
                        addCategoryOption('남양주시');
                        addCategoryOption('안산시');
                        addCategoryOption('평택시');
                        addCategoryOption('안양시');
                        addCategoryOption('시흥시');
                        addCategoryOption('파주시');
                        addCategoryOption('김포시');
                        addCategoryOption('의정부시');
                        addCategoryOption('광주시');
                        addCategoryOption('하남시');
                        addCategoryOption('광명시');
                        addCategoryOption('군포시');
                        addCategoryOption('양주시');
                        addCategoryOption('오산시');
                        addCategoryOption('이천시');
                        addCategoryOption('안성시');
                        addCategoryOption('구리시');
                        addCategoryOption('의왕시');
                        addCategoryOption('포천시');
                        addCategoryOption('양평군');
                        addCategoryOption('여주시');
                        addCategoryOption('동두천시');
                        addCategoryOption('과천시');
                        addCategoryOption('가평군');
                        addCategoryOption('연천군');
                        break;
                    case '강원특별자치도':
                        addCategoryOption('춘천시');
                        addCategoryOption('원주시');
                        addCategoryOption('강릉시');
                        addCategoryOption('동해시');
                        addCategoryOption('태백시');
                        addCategoryOption('속초시');
                        addCategoryOption('삼척시');
                        addCategoryOption('홍천군');
                        addCategoryOption('횡성군');
                        addCategoryOption('영월군');
                        addCategoryOption('평창군');
                        addCategoryOption('정선군');
                        addCategoryOption('철원군');
                        addCategoryOption('화천군');
                        addCategoryOption('양구군');
                        addCategoryOption('인제군');
                        addCategoryOption('고성군');
                        addCategoryOption('양양군');
                        break;
                    case '충청북도':
                        addCategoryOption('청주시');
                        addCategoryOption('충주시');
                        addCategoryOption('제천시');
                        addCategoryOption('보은군');
                        addCategoryOption('옥천군');
                        addCategoryOption('영동군');
                        addCategoryOption('증평군');
                        addCategoryOption('진천군');
                        addCategoryOption('괴산군');
                        addCategoryOption('음성군');
                        addCategoryOption('단양군');
                        break;
                    case '충청남도':
                        addCategoryOption('천안시');
                        addCategoryOption('공주시');
                        addCategoryOption('보령시');
                        addCategoryOption('아산시');
                        addCategoryOption('서산시');
                        addCategoryOption('논산시');
                        addCategoryOption('계룡시');
                        addCategoryOption('당진시');
                        addCategoryOption('금산군');
                        addCategoryOption('부여군');
                        addCategoryOption('서천군');
                        addCategoryOption('청양군');
                        addCategoryOption('홍성군');
                        addCategoryOption('예산군');
                        addCategoryOption('태안군');
                        break;
                    case '전라북도':
                        addCategoryOption('전주시');
                        addCategoryOption('군산시');
                        addCategoryOption('익산시');
                        addCategoryOption('정읍시');
                        addCategoryOption('남원시');
                        addCategoryOption('김제시');
                        addCategoryOption('완주군');
                        addCategoryOption('진안군');
                        addCategoryOption('무주군');
                        addCategoryOption('장수군');
                        addCategoryOption('임실군');
                        addCategoryOption('순창군');
                        addCategoryOption('고창군');
                        addCategoryOption('부안군');
                        break;
                    case '전라남도':
                        addCategoryOption('목포시');
                        addCategoryOption('여수시');
                        addCategoryOption('순천시');
                        addCategoryOption('나주시');
                        addCategoryOption('광양시');
                        addCategoryOption('담양군');
                        addCategoryOption('곡성군');
                        addCategoryOption('구례군');
                        addCategoryOption('고흥군');
                        addCategoryOption('보성군');
                        addCategoryOption('화순군');
                        addCategoryOption('장흥군');
                        addCategoryOption('강진군');
                        addCategoryOption('해남군');
                        addCategoryOption('영암군');
                        addCategoryOption('무안군');
                        addCategoryOption('함평군');
                        addCategoryOption('영광군');
                        addCategoryOption('장성군');
                        addCategoryOption('완도군');
                        addCategoryOption('진도군');
                        addCategoryOption('신안군');
                        break;
                    case '경상북도':
                        addCategoryOption('포항시');
                        addCategoryOption('경주시');
                        addCategoryOption('김천시');
                        addCategoryOption('안동시');
                        addCategoryOption('구미시');
                        addCategoryOption('영주시');
                        addCategoryOption('영천시');
                        addCategoryOption('상주시');
                        addCategoryOption('문경시');
                        addCategoryOption('경산시');
                        addCategoryOption('의성군');
                        addCategoryOption('청송군');
                        addCategoryOption('영양군');
                        addCategoryOption('영덕군');
                        addCategoryOption('청도군');
                        addCategoryOption('고령군');
                        addCategoryOption('성주군');
                        addCategoryOption('칠곡군');
                        addCategoryOption('예천군');
                        addCategoryOption('봉화군');
                        addCategoryOption('울진군');
                        addCategoryOption('울릉군');
                        break;
                    case '경상남도':
                        addCategoryOption('창원시');
                        addCategoryOption('진주시');
                        addCategoryOption('통영시');
                        addCategoryOption('사천시');
                        addCategoryOption('김해시');
                        addCategoryOption('밀양시');
                        addCategoryOption('거제시');
                        addCategoryOption('양산시');
                        addCategoryOption('의령군');
                        addCategoryOption('함안군');
                        addCategoryOption('창녕군');
                        addCategoryOption('고성군');
                        addCategoryOption('남해군');
                        addCategoryOption('하동군');
                        addCategoryOption('산청군');
                        addCategoryOption('함양군');
                        addCategoryOption('거창군');
                        addCategoryOption('합천군');
                        break;
                    case '제주특별자치도':
                        addCategoryOption('제주시');
                        addCategoryOption('서귀포시');
                        break;

                }
            }

            function addCategoryOption(category) {
                var categorySelect = document.getElementById('categorySelect');
                var option = document.createElement('option');
                option.text = category;
                categorySelect.add(option);
            }
        </script>


    <style>
        /*.container {*/
        /*    margin-top: 20px;*/
        /*}*/

        .container2 {
            display: flex;
            justify-content: center;
            /* 가로 중앙 정렬 */

        }

        .left-panel,
        .right-panel {
            flex: 1;
            border: 0px solid #ccc;
            padding: 20px;
        }

        .pages {
            margin: 5px;
        }
        .hidden-column {
            display: none;
        }
        .custom-width-15 {
            width: 15%;
        }
        .custom-width-30 {
            width: 30%;
        }
        .custom-width-40 {
            width: 40%;
        }

        #map {
            width: 100%;
            height: 500px;
        }
    </style>

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
                <h2>도서관 찾기</h2>
                <ol>
                    <li><a href="../mainpage/index">Home</a></li>
                    <li>Library</li>
                </ol>
            </div>
        </div>
    </section>
    <!-- End Breadcrumbs -->

    <div class="container">
        <div class="container2">
            <div class="left-panel">
                <!-- 좌측 패널의 내용 -->
                <div class="container mt-4">
                    <h4>이름으로 찾기</h4>
                    <!-- 검색창 -->
                    <form action="library_search_name" class="form-inline" id="searchForm">
                        <div class="form-group">
                            <input type = "hidden" name="page" id = "currentPage" value="1">
                            <input name = "keyword" id="keyword" type="search" class="form-control mr-2" placeholder="도서관명을 입력하세요" value="${keyword}" aria-label="Search">
                            <button type="submit" class="btn btn-primary" id="search_name">이름으로 검색</button>
                        </div>
                    </form>
                </div>

                <div class="container mt-4">
                    <h4>지역으로 찾기</h4>
                    <!-- 지역별 카테고리 검색창 -->
                    <!-- <form action="library_search_address" class="form-inline" id="searchForm2"> -->
                        <div class="form-group mr-2">
                            <select class="form-control" id="regionSelect" onchange="updateCategoryOptions()">
                                <option selected disabled>지역 선택</option>
                                <option value="서울특별시">서울특별시</option>
                                <option value="부산광역시">부산광역시</option>
                                <option value="대구광역시">대구광역시</option>
                                <option value="인천광역시">인천광역시</option>
                                <option value="광주광역시">광주광역시</option>
                                <option value="대전광역시">대전광역시</option>
                                <option value="울산광역시">울산광역시</option>
                                <option value="세종특별자치시">세종특별자치시</option>
                                <option value="경기도">경기도</option>
                                <option value="강원특별자치도">강원특별자치도</option>
                                <option value="충청북도">충청북도</option>
                                <option value="충청남도">충청남도</option>
                                <option value="전라북도">전라북도</option>
                                <option value="전라남도">전라남도</option>
                                <option value="경상북도">경상북도</option>
                                <option value="경상남도">경상남도</option>
                                <option value="제주특별자치도">제주특별자치도</option>
                            </select>
                        </div>
                        <div class="form-group mr-2">
                            <select class="form-control" id="categorySelect">
                                <option selected disabled>시/군/구 선택</option>
                                <!-- 여기에 추가적인 카테고리 옵션을 넣어주세요 -->
                            </select>
                        </div>
                        <button onclick="search_address()" type="button" class="btn btn-primary" >지역으로 검색</button>
                        <br><br>
                        📌 도서관명 또는 도서관 지역으로 정보를 검색할 수 있습니다.<br>
                        우측의 지도를 통해 조회 결과 최상단 도서관의 위치를 확인할 수 있습니다.
                <!-- </form> -->
                </div>

            </div>
            <div class="right-panel" id="map">
                <!-- 우측 패널의 내용 -->
                <h2>Right Panel</h2>
                <p>This is the content of the right panel.</p>
            </div>
        </div>
    </div>

    <!-- 맵을 표시할 영역 -->
    <script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };

    var map = new kakao.maps.Map(mapContainer, mapOption);

    // 마커가 표시될 위치입니다
    var markerPosition  = new kakao.maps.LatLng(33.450701, 126.570667);

    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        position: markerPosition
    });

    // 마커가 지도 위에 표시되도록 설정합니다
    marker.setMap(map);

    //var iwContent = '<div style="padding:5px;">Hello World!</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
    //    iwPosition = new kakao.maps.LatLng(33.450701, 126.570667); //인포윈도우 표시 위치입니다

    // 인포윈도우를 생성합니다
    var infowindow = new kakao.maps.InfoWindow({
        position : markerPosition,
        content : '<div style="width: 200px; padding:5px;">${list[0].lib_name}</div>', // 기본적으로 첫 번째 도서관의 이름을 출력하도록 설정
    });




    // 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
    infowindow.open(map, marker);



    // 마커 위치를 업데이트하는 함수
        function updateMarkerPosition() {
            var latitude = parseFloat(document.getElementById('latitude').innerText);
            var longitude = parseFloat(document.getElementById('longitude').innerText);

            // 마커 위치 업데이트
            var markerPosition = new kakao.maps.LatLng(latitude, longitude);
            marker.setPosition(markerPosition);

            // 지도 중심을 새 마커 위치로 업데이트
            map.setCenter(markerPosition);

            // 인포윈도우 위치 업데이트
            infowindow.setPosition(markerPosition);
        }

        // 문서가 로드된 후에 updateMarkerPosition 함수 호출
        $(document).ready(function() {
            updateMarkerPosition();
        });
    </script>



    <div class="container">
        <div id="result">
            <table class="table table-bordered table-striped">
                <thead class="thead-dark">
                    <tr>
                        <th class="custom-width-15">도서관코드</th>
                        <th class="custom-width-30">도서관명</th>
                        <th class="custom-width-40">도서관주소</th>
                        <th class="custom-width-15">도서관전화번호</th>
                        <th class="hidden-column">도서관위도</th>
                        <th class="hidden-column">도서관경도</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${list}" var="libraryVO">
                        <tr>
                            <td>${libraryVO.lib_code }</td>
                            <td><a href="library_one?lib_code=${libraryVO.lib_code }">${libraryVO.lib_name }</a></td>
                            <td>${libraryVO.lib_address }</td>
                            <td>${libraryVO.lib_tel }</td>
                            <td class="hidden-column"><span id="latitude">${libraryVO.lib_latitude}</span></td>
                            <td class="hidden-column"><span id="longitude">${libraryVO.lib_longitude}</span></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>



    <!-- 페이징 이전 다음 추가한 것-->
    <div class="pagination justify-content-center">
        <c:if test="${totalPage > 1}">
            <c:set var="startPage" value="${(page - 1) / 5 * 5 + 1}" />
            <c:set var="endPage" value="${startPage + 4}" />
            <c:if test="${endPage > totalPage}">
                <c:set var="endPage" value="${totalPage}" />
            </c:if>

            <!-- 이전 버튼 -->
            <c:if test="${startPage > 1}">
                <a href="#" class="pages" data-page="${startPage - 5}">&laquo; 이전</a>
            </c:if>

            <!-- 페이지 번호 -->
            <c:forEach begin="${startPage}" end="${endPage}" var="i">
                <a href="#" class="pages" data-page="${i}">${i}</a>
            </c:forEach>

            <!-- 다음 버튼 -->
            <c:if test="${endPage < totalPage}">
                <a href="#" class="pages" data-page="${endPage + 1}">다음 &raquo;</a>
            </c:if>
        </c:if>
    </div>
    <br><br>

    <div class="container mt-4" style="display: flex; justify-content: space-between;">
        <sec:authorize access="hasRole('ROLE_ADMIN')"> <!-- 관리자 계정만 볼 수 있음 -->
            <a href="library_admin" id="library_admin" class="btn btn-danger">도서 관리자 페이지</a>
        </sec:authorize>
        <a href="library_list3?page=1" class="btn btn-primary">전체 목록 보기</a>
    </div>
    <br><br><br>


    <!-- 변수 확인용 -->
    <!--<div class="container mt-2">
        <p>전체 도서관 수 : ${count } 개</p>
        <p>검색 도서관 수 : ${search_count } 개</p>
        <p>현재 페이지: ${page} P</p>
        <p>전체 페이지 수: ${totalPage} P</p>
        <p>시작 페이지: ${startPage} P</p>
        <p>끝 페이지: ${endPage} P</p>
        <br>
    </div>-->

    <!-- ======= Footer ======= -->
    <jsp:include page="/WEB-INF/views/footer.jsp"/>
    <!-- End Footer -->

</body>

</html>