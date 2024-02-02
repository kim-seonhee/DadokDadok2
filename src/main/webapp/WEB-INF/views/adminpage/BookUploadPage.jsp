<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>도서관 관리자 페이지</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>

    <!-- Include Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <!-- Optional JavaScript; choose one of the two! -->
    <!-- Option 1: jQuery and Bootstrap Bundle (includes Popper) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>


    <!-- Favicons -->
    <link href="../resources/assets/img/favicon.png" rel="icon">
    <link href="../resources/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Muli:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
          rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="../resources/assets/vendor/animate.css/animate.min.css" rel="stylesheet">
    <link href="../resources/assets/vendor/aos/aos.css" rel="stylesheet">
    <link href="../resources/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="../resources/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="../resources/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="../resources/assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
    <link href="../resources/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

    <!-- Template Main CSS File -->
    <link href="../resources/assets/css/style.css" rel="stylesheet">

    <style>
        .logo-link {
            display: flex;
            align-items: center;
            text-decoration: none; /* 링크 밑줄 제거 */
        }

        .logo-image {
            max-width: 300px; /* 로고 이미지 크기 조정 */
            height: auto; /* 이미지 높이 자동 조절 */
        }

        .logo-text {
            font-size: 24px; /* 로고 텍스트 크기 */
            font-weight: bold; /* 글씨 굵게 */
            color: #333; /* 글씨 색상 */
            /*margin-left: 5px; !* 이미지와 텍스트 간격 *!*/
        }

        .form-signin {
            width: 100%;
            max-width: 330px;
            padding: 15px;
            margin: auto;
        }

        .library-item.selected {
            background-color: #f0f0f0;
            color: #333;
            font-weight: bold;
        }

        .loading {
            display: none;
            position: fixed; /* 화면에 고정 */
            top: 50%; /* 상단에서 50% 위치 */
            left: 50%; /* 좌측에서 50% 위치 */
            transform: translate(-50%, -50%); /* 정확히 중앙에 위치하도록 조정 */
            z-index: 9999; /* 다른 요소들 위에 표시 */
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
            <h2>Admin Upload</h2>
            <ol>
                <li><a href="/mainpage/index">Home</a></li>
                <li>Upload</li>
            </ol>
        </div>

    </div>
</section><!-- End Breadcrumbs -->

<div class="container mt-5">
    <h2 class="mb-4">도서 데이터 업로드</h2>

    <!-- 추천 문구 추가 -->
    <p class="text-info">도서관을 선택하고 업로드 진행해 주세요</p>

    <br>

    <!-- Library Search Form -->
    <div class="library-search">
        <h3>도서관 검색</h3>
        <form id="librarySearchForm">
            <div class="form-group">
                <label for="librarySearchInput">도서관 이름 또는 코드:</label>
                <input type="text" class="form-control" id="librarySearchInput"
                       placeholder="Enter library name or code">
            </div>
            <button type="submit" class="btn btn-primary">검색</button>
        </form>
    </div>

    <!-- Search Results -->
    <div id="librarySearchResults"></div>
    <br>
    <hr>
    <br>


    <!-- 엑셀 파일 업로드 폼 -->
    <form id="excelUploadForm" enctype="multipart/form-data">
        <div class="form-group">
            <label for="excelFileUpload">엑셀 파일 업로드:</label>
            <input type="file" class="form-control-file" id="excelFileUpload" name="excelFile">
        </div>
        <button type="submit" class="btn btn-primary">업로드</button>
    </form>


    <hr>

    <!-- CSV 파일 업로드 폼 -->
    <form id="csvUploadForm" enctype="multipart/form-data">
        <div class="form-group">
            <label for="csvFileUpload">CSV 파일 업로드:</label>
            <input type="file" class="form-control-file" id="csvFileUpload" name="csvFile">
        </div>
        <button type="submit" class="btn btn-primary">업로드</button>
    </form>

    <br>

    <!-- 로딩 인디케이터 -->
    <div class="loading" style="display: none;">
        <div class="d-flex justify-content-center">
            <div class="spinner-border" role="status">
                <span class="sr-only"></span>
            </div>
            <span id="loadingSeconds">0</span>
        </div>
    </div>

    <!-- 업로드 폼 하단에 파일 업로드 이력 테이블 추가 -->
    <div id="uploadHistory" class="mt-5">
        <h3>업로드 이력</h3>

        <!-- 도서 수 정보를 표시할 섹션 -->
        <div id="bookCount">
            <table class="table">
                <tbody id="bookCountBody">
                <!-- 여기에 도서 수 정보가 삽입됩니다 -->
                </tbody>
            </table>
        </div>

        <table class="table">
            <thead>
            <tr>
                <th>파일명</th>
                <th>업로드 날짜</th>
                <th>파일 크기</th>
                <th>파일 형식</th>
            </tr>
            </thead>
            <tbody id="uploadHistoryBody">
            <!-- 여기에 업로드 이력이 삽입됩니다 -->
            </tbody>
        </table>
    </div>
</div>


<!-- ======= Footer ======= -->
<jsp:include page="/WEB-INF/views/footer.jsp"/>
<!-- End Footer -->

<script>
    $(document).ready(function () {
        $('#librarySearchForm').on('submit', function (e) {
            e.preventDefault();
            var searchQuery = $('#librarySearchInput').val();

            $.ajax({
                type: 'GET',
                url: '/adminpage/BookUploadPage/librarySearch', // 서버 엔드포인트 경로를 지정합니다.
                data: {libraries: searchQuery},
                success: function (response) {
                    $('#librarySearchResults').empty(); // 이전 결과를 비웁니다.

                    if (response && response.length > 0) {
                        var resultsHtml = '<ul class="list-group">';
                        $.each(response, function (index, library) {
                            resultsHtml += '<li class="list-group-item library-item" data-lib-code="' + library.lib_code + '">' +
                                library.lib_name + ' (' + library.lib_code + ')</li>';
                        });
                        resultsHtml += '</ul>';
                        $('#librarySearchResults').html(resultsHtml);

                        // 도서관 목록 항목에 클릭 이벤트 추가
                        $('.library-item').on('click', function () {
                            selectedLibraryCode = $(this).data('lib-code');

                            // 선택된 도서관 표시 (옵션)
                            $('.library-item').removeClass('selected');
                            $(this).addClass('selected');

                            // 선택된 도서관 코드를 콘솔에 출력 (디버깅용)
                            console.log('Selected Library Code:', selectedLibraryCode);
                        });
                    } else {
                        $('#librarySearchResults').html('<p>검색 결과가 없습니다.</p>');
                    }
                },
                error: function () {
                    alert('도서관 검색에 실패했습니다.');
                }
            });
        });
    });

</script>

<script>
    // 초 수를 표시할 변수 선언
    var secondsCounter = 0;
    var interval;
    var selectedLibraryCode = null;

    $(document).ready(function () {
        // 엑셀 파일 업로드 처리
        $('#excelUploadForm').on('submit', function (e) {
            e.preventDefault();
            if (!selectedLibraryCode) {
                alert('도서관을 선택해주세요.');
                return;
            }
            var formData = new FormData(this);
            formData.append('file', $('#excelFileUpload')[0].files[0]);
            ajaxFileUpload('/adminpage/BookUploadPage/Excelupload', formData);
        });

        // CSV 파일 업로드 처리
        $('#csvUploadForm').on('submit', function (e) {
            e.preventDefault();
            if (!selectedLibraryCode) {
                alert('도서관을 선택해주세요.');
                return;
            }
            var formData = new FormData(this);
            formData.append('file', $('#csvFileUpload')[0].files[0]);
            ajaxFileUpload('/adminpage/BookUploadPage/CSVupload', formData);
        });

        // AJAX 파일 업로드 함수
        function ajaxFileUpload(url, formData) {
            // 로딩 인디케이터 및 초 카운터를 초기화합니다.
            $('.loading').show();
            secondsCounter = 0;
            clearInterval(interval);

            // 초 카운터를 시작합니다.
            interval = setInterval(function () {
                secondsCounter++;
                $('#loadingSeconds').text(secondsCounter); // 초 수를 업데이트합니다.
                $('.loading span').text('Loading... ' + secondsCounter + 's');
            }, 1000);

            formData.append('lib_code', selectedLibraryCode);

            $.ajax({
                type: 'POST',
                url: url,
                data: formData,
                contentType: false,
                processData: false,
                beforeSend: function () {
                    // 로딩 인디케이터 및 초 카운터를 보여줍니다.
                    $('.loading').show();
                },
                complete: function () {
                    // 로딩 인디케이터 및 초 카운터를 숨깁니다.
                    $('.loading').hide();
                    clearInterval(interval);
                },
                success: function (response) {
                    alert('파일이 성공적으로 업로드되었습니다.');
                    //화면 리로드
                    location.reload();
                },
                error: function (response) {
                    alert('파일 업로드에 실패했습니다.');
                }
            });
        }

        function fetchUploadHistory() {
            // 도서 및 도서관 개수 정보를 가져오는 AJAX 요청
            $.ajax({
                url: '/adminpage/BookUploadPage/AllBooksCount',
                type: 'GET',
                dataType: 'json',
                success: function(countData) {
                    var countsHtml = '<tr>' +
                        '<th>도서 총 개수</th>' +
                        '<td>' + countData.booksCount + '</td>' +
                        '<th>도서/도서관 총 개수</th>' +
                        '<td>' + countData.booksLibrariesCount + '</td>' +
                        '</tr>';

                    // 업로드 이력 테이블의 thead에 정보 추가
                    $('#bookCountBody').append(countsHtml);
                },
                error: function() {
                    alert('도서 및 도서관 개수를 불러오는데 실패했습니다.');
                }
            });

            // 업로드 이력 정보를 가져오는 AJAX 요청
            $.ajax({
                url: '/adminpage/BookUploadPage/UploadHistory',
                type: 'GET',
                dataType: 'json',
                success: function (data) {
                    var historyHtml = '';
                    $.each(data, function (index, history) {
                        historyHtml += '<tr>' +
                            '<td>' + history.file_name + '</td>' +
                            '<td>' + formatDate(history.upload_date) + '</td>' +
                            '<td>' + history.file_size + '</td>' +
                            '<td>' + history.file_type + '</td>' +
                            '</tr>';
                    });
                    $('#uploadHistoryBody').html(historyHtml);
                },
                error: function () {
                    alert('업로드 이력을 불러오는데 실패했습니다.');
                }
            });
        }



        // 페이지 로드 시 업로드 이력 가져오기
        fetchUploadHistory();

        function formatDate(timestamp) {
            var date = new Date(timestamp);
            var year = date.getFullYear();
            var month = ('0' + (date.getMonth() + 1)).slice(-2);
            var day = ('0' + date.getDate()).slice(-2);
            var hours = ('0' + date.getHours()).slice(-2);
            var minutes = ('0' + date.getMinutes()).slice(-2);
            var seconds = ('0' + date.getSeconds()).slice(-2);

            return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
        }
    });
</script>

</body>
</html>
