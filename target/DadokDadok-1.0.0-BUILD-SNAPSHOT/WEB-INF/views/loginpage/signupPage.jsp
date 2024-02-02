<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Sign Up</title>
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
    </style>

</head>

<body>
<!-- ======= Top Bar ======= -->
<jsp:include page="/WEB-INF/views/topbar.jsp"/>
<!-- End Top Bar -->

<!-- ======= Header ======= -->
<jsp:include page="/WEB-INF/views/header.jsp"/>
<!-- End Header -->

<main id="main">

    <!-- ======= Breadcrumbs ======= -->
    <section id="breadcrumbs" class="breadcrumbs">
        <div class="container">

            <div class="d-flex justify-content-between align-items-center">
                <h2>Register</h2>
                <ol>
                    <li><a href="index.jsp">Home</a></li>
                    <li>register</li>
                </ol>
            </div>

        </div>
    </section><!-- End Breadcrumbs -->

    <!-- ======= 설정 섹션 시작 ======= -->
    <section id="sign-up" class="sign-up">
        <div class="container mt-5">
            <h2 class="mb-4">회원가입</h2>
            <form id="signupForm" action="/loginpage/signup" method="post" class="needs-validation" novalidate>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="Name" required>
                </div>

                <div class="form-group">
                    <label for="nickname">Nickname</label>
                    <input type="text" class="form-control" id="nickname" name="nickname" placeholder="Nickname"
                           required>
                </div>

                <label for="email">Email</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="*Email" required>
                <button type="button" id="checkEmail" class="btn btn-info btn-sm">이메일 중복 확인</button>
                <div id="emailFeedback" class="invalid-feedback" style="display: none;">
                    이메일이 이미 사용 중입니다.
                </div>
                <div id="emailFeedbackSuccess" class="valid-feedback" style="display: none;">
                    사용 가능한 이메일입니다.
                </div>
                <div id="emailInvalidFeedback" class="invalid-feedback" style="display: none;">
                    유효하지 않은 이메일 형식입니다.
                </div>


                <div class="form-group">
                    <br><br>
                    <label for="password">Password(반드시 8자 이상 특수문자를 포함해 주세요)</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Password"
                           required>
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword"
                           placeholder="Confirm Password" required>
                    <div id="passwordMatchFeedback" class="invalid-feedback" style="display: none;">
                        비밀번호가 일치하지 않습니다.
                    </div>
                </div>

                <div class="form-group">
                    <br><br>
                    <label for="addr1">Address</label>
                    <br>
                    <input class="form-control" style="width: 40%; display: inline;" placeholder="우편번호" name="zipcode" id="addr1" type="text" readonly="readonly"/>
                    <button type="button" class="btn btn-primary" onclick="execPostCode();"><i class="fa fa-search"></i> 우편번호 찾기</button>
                </div>

                <div class="form-group">
                    <input class="form-control" style="top: 5px;" placeholder="도로명 주소" name="address" id="addr2" type="text" readonly="readonly"/>
                </div>
                <div class="form-group">
                    <input class="form-control" placeholder="상세주소" name="detail_address" id="addr3" type="text"/>
                </div>

                <div class="form-group">
                    <br><br>
                    <label for="phoneNum">Phone(전화번호를 양식에 맞게 작성해주세요 예)010-0000-0000</label>
                    <input type="text" class="form-control" id="phoneNum" name="phoneNum" placeholder="Phone" required>
                </div>

                <div style="text-align: center;">
                    <button type="submit" class="btn btn-primary" id="signupButton">회원가입하기</button>
                </div>
            </form>
        </div>
    </section>
</main><!-- End #main -->

<!-- ======= Footer ======= -->
<jsp:include page="/WEB-INF/views/footer.jsp"/>
<!-- End Footer -->

<!-- Vendor JS Files -->
<script src="../resources/assets/vendor/aos/aos.js"></script>
<script src="../resources/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="../resources/assets/vendor/glightbox/js/glightbox.min.js"></script>
<script src="../resources/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
<script src="../resources/assets/vendor/swiper/swiper-bundle.min.js"></script>
<script src="../resources/assets/vendor/waypoints/noframework.waypoints.js"></script>
<script src="../resources/assets/vendor/php-email-form/validate.js"></script>

<!-- Daum 우편번호 서비스 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- Template Main JS File -->
<script src="../resources/assets/js/main.js"></script>

<script>
    $(document).ready(function () {
        // 이메일 형식 검사
        function validateEmail(email) {
            var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            return re.test(email);
        }

        function validatePassword(password) {
            var re = /^(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$/;
            return re.test(password);
        }

        // 비밀번호 일치 검사
        function matchPassword() {
            var password = $('#password').val();
            var confirmPassword = $('#confirmPassword').val();
            return password === confirmPassword;
        }

        $('#password, #confirmPassword').on('input', function () {
            var password = $('#password').val();
            if (!validatePassword(password)) {
                $('#signupButton').prop('disabled', true);
            } else if (!matchPassword()) {
                $('#passwordMatchFeedback').show();
                $('#signupButton').prop('disabled', true);
            } else {
                $('#passwordMatchFeedback').hide();
                $('#signupButton').prop('disabled', false);
            }
        });

        $('#email').on('input', function () {
            var email = $(this).val();
            if (!validateEmail(email)) {
                // 유효하지 않은 이메일 형식
                $('#emailInvalidFeedback').show();
                $('#signupButton').prop('disabled', true);
            } else {
                // 유효한 이메일 형식
                $('#emailInvalidFeedback').hide();
                $('#signupButton').prop('disabled', false);
            }
        });
        // 초기 상태에서 '회원가입하기' 버튼 비활성화
        $('#signupButton').prop('disabled', true);

        $('#checkEmail').click(function () {
            var email = $('#email').val();
            // Hide any previous feedback
            $('#emailFeedback').hide();
            $('#emailFeedbackSuccess').hide();

            $.ajax({
                url: '/loginpage/check-email',
                type: 'POST',
                data: {'email': email},
                success: function (response) {
                    // Show the appropriate message based on the response
                    if (response.exists) {
                        $('#emailFeedback').show();
                        $('#signupButton').prop('disabled', true); // 이메일 중복 시 버튼 비활성화
                    } else {
                        $('#emailFeedbackSuccess').show();
                        $('#signupButton').prop('disabled', false); // 이메일 사용 가능 시 버튼 활성화
                    }
                },
                error: function () {
                    // Handle errors here
                    alert('Error checking email');
                    $('#signupButton').prop('disabled', true); // 에러 발생 시 버튼 비활성화
                }
            });
        });

        // 회원가입 폼 제출 시 유효성 검사
        $('#signupForm').submit(function (event) {
            // 이메일 중복 검사 없이 폼 제출 시도 방지
            if ($('#signupButton').prop('disabled')) {
                event.preventDefault();
                alert('이메일 중복 확인이 필요합니다.');
            }
        });
    });
</script>
<script>
    // Daum 우편번호 찾기 함수
    function execPostCode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 도로명 주소 변수
                var fullRoadAddr = data.roadAddress;
                // 도로명 조합형 주소 변수
                var extraRoadAddr = '';

                // 법정동명이 있을 경우 추가
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우 추가
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 최종 주소 문자열 생성
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }

                // 우편번호와 주소 정보 입력 필드에 값 설정
                $('#addr1').val(data.zonecode);
                $('#addr2').val(fullRoadAddr); // addr2는 상세 주소를 입력받는 필드의 ID
            }
        }).open();
    }
</script>
<script>
    $(document).ready(function () {
        // 전화번호 유효성 검사 함수
        function validatePhoneNumber(phoneNumber) {
            var re = /^01[0-1,6-9]-[0-9]{3,4}-[0-9]{4}$/;
            return re.test(phoneNumber);
        }

        $('#phoneNum').on('input', function () {
            var phoneNumber = $(this).val();
            if (!validatePhoneNumber(phoneNumber)) {
                $(this).addClass('is-invalid'); // 유효하지 않은 경우 클래스 추가
            } else {
                $(this).removeClass('is-invalid'); // 유효한 경우 클래스 제거
            }
        });

        // 폼 제출 시 전화번호 유효성 검사
        $('#signupForm').submit(function (event) {
            var phoneNumber = $('#phoneNum').val();
            if (!validatePhoneNumber(phoneNumber)) {
                event.preventDefault(); // 폼 제출 방지
                alert('유효하지 않은 전화번호 형식입니다.');
            }
        });
    });
</script>

</body>
</html>