<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<script type="text/javascript" src="/js/jquery-3.6.0.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.19.2/axios.js"
	integrity="sha512-VGxuOMLdTe8EmBucQ5vYNoYDTGijqUsStF6eM7P3vA/cM1pqOwSBv/uxw94PhhJJn795NlOeKBkECQZ1gIzp6A=="
	crossorigin="anonymous"></script>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Quixlab - Bootstrap Admin Dashboard Template by
	Themefisher.com</title>
<!-- Favicon icon -->
<link rel="icon" type="image/png" sizes="16x16"
	href="${pageContext.request.contextPath}/images/favicon.png">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.5.0/css/all.css"
	integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU"
	crossorigin="anonymous">
<link href="${pageContext.request.contextPath}/css/style.css"
	rel="stylesheet">

</head>
<style>
.intext {
	width: 100%;
	padding-left: 0.5rem;
	padding: 0.5rem;
}

.incorrect-message {
	display: none;
}

.correct-message {
	display: none;
}

.unoverlap-message {
	display: none;
}

.overlap-message {
	display: none;
}

.email-input.unoverlap ~.unoverlap-message {
	color: blue;
	font-size: 16;
	display: block;
	font-size: 13px;
	margin: 0.3rem;
}

.email-input.overlap ~.overlap-message {
	color: red;
	font-size: 16;
	display: block;
	font-size: 13px;
	margin: 0.3rem;
}

.id-input.unoverlap ~.unoverlap-message {
	color: blue;
	font-size: 16;
	display: block;
	font-size: 13px;
	margin: 0.3rem;
}

.id-input.overlap ~.overlap-message {
	color: red;
	font-size: 16;
	display: block;
	font-size: 13px;
	margin: 0.3rem;
}

.intext.correct ~.correct-message {
	color: blue;
	font-size: 16;
	display: block;
	font-size: 13px;
	margin: 0.3rem;
}

.intext.incorrect ~.incorrect-message {
	color: red;
	font-size: 16;
	display: block;
	font-size: 13px;
	margin: 0.3rem;
}

.inemail.correct ~.correct-message {
	color: blue;
	font-size: 16;
	display: block;
	font-size: 13px;
	margin: 0.3rem;
}

.inemail.incorrect ~.incorrect-message {
	color: red;
	font-size: 16;
	display: block;
	font-size: 13px;
	margin: 0.3rem;
}

.inid.correct ~.correct-message {
	color: blue;
	font-size: 16;
	display: block;
	font-size: 13px;
	margin: 0.3rem;
}

.inid.incorrect ~.incorrect-message {
	color: red;
	font-size: 16;
	display: block;
	font-size: 13px;
	margin: 0.3rem;
}
</style>
<script type="text/javascript">
	function checkName() {
		var regex = /[가-힣]{2,7}/g;
		var nameTag = document.getElementById("name");

		var isName = regex.test(nameTag.value);
		nameTag.classList.remove("correct");
		nameTag.classList.remove("incorrect");

		if (!isName) {
			nameTag.classList.add("incorrect");
			return false;
		} else {
			nameTag.classList.add("correct");
			return true;
		}
	}
	function checkId() {
		var regex = /^[a-zA-Z]+[a-zA-Z0-9]{5,30}$/g;
		var idTag = document.getElementById("id");
		var isId = regex.test(idTag.value);
		idTag.classList.remove("correct");
		idTag.classList.remove("incorrect");
		if (!isId) {
			idTag.classList.add("incorrect");
			return false;
		} else {
			idTag.classList.add("correct");
			var input = document.querySelector(".id-input");
			input.classList.remove("overlap");
			input.classList.remove("unoverlap");
			var member_id = input.value;
			axios(
					{
						url : "${pageContext.request.contextPath}/member_rest/overlap_id.do?member_id="
								+ member_id,
						method : "get"
					}).then(function(response) {
				console.log("리스폰트 데이터 : " + response.data);
				if (!response.data) {
					input.classList.add("unoverlap");
					return true;
				} else {
					input.classList.add("overlap");
					return false;
				}
			})
		}
	}
	function checkCheckId() {
		var unoverlap = document.querySelector(".id-input.unoverlap");
		var checkId = document.querySelector(".inid.correct");
		console.log("중복" + unoverlap);
		console.log("체크" + checkEmail);
		if (unoverlap != null && checkId != null) {
			return true;
		} else {
			return false;
		}
	}

	function checkEmail() {
		var regex = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/gi;
		var mailTag = document.getElementById("email");

		var isMail = regex.test(mailTag.value);

		mailTag.classList.remove("incorrect");
		mailTag.classList.remove("correct");

		if (!isMail) {
			mailTag.classList.add("incorrect");
			return false;
		} else {
			mailTag.classList.add("correct");
			var input = document.querySelector(".email-input");
			input.classList.remove("overlap");
			input.classList.remove("unoverlap");
			var member_email = input.value;
			//axios를 이용하여 비동기 통신을 보낸다
			//      		axios({옵션}).then(성공코드).catch(오류코드);
			axios(
					{
						url : "${pageContext.request.contextPath}/member_rest/overlap_email.do?member_email="
								+ member_email,
						method : "get"
					}).then(function(response) {
				console.log("리스폰트 데이터" + response.data);
				if (!response.data) { //결과 없음 : 사용 가능한 이름
					input.classList.add("unoverlap");
					return true;
				} else { //결과 있음 : 사용 불가능한 이름
					input.classList.add("overlap");
				}
			});
			return false;
		}
	}

	function checkCheckEmail() {
		var unoverlap = document.querySelector(".email-input.unoverlap");
		var checkEmail = document.querySelector(".inemail.correct");
		console.log("중복" + unoverlap);
		console.log("체크" + checkEmail);
		if (unoverlap != null && checkEmail != null) {
			return true;
		} else {
			return false;
		}
	}
	//isValid의 결과에 따라서 입력창에 correct / incorrect 클래스를 추가
	//비밀번호를 검사하는 함수 : 반드시 true 또는 false를 반환해야 checkForm에서 사용이 가능하다
	function checkPwd() {

		var regex1 = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
		var pwTag = document.getElementById("pw");
		var isPw1 = regex1.test(pwTag.value);
		pwTag.classList.remove("correct");
		pwTag.classList.remove("incorrect");
		if (!isPw1) {
			pwTag.classList.add("incorrect");
			return false;
		} else {
			pwTag.classList.add("correct");
			return true;
		}
	}
	function checkCheckPw() {
		var pwTag = document.getElementById("pw");
		var checkPwTag = document.getElementById("checkPw");
		checkPwTag.classList.remove("correct");
		checkPwTag.classList.remove("incorrect");
		if (pwTag.value === checkPwTag.value) {
			checkPwTag.classList.add("correct");
		} else {
			checkPwTag.classList.add("incorrect");
		}
		return pwTag.value === checkPwTag.value;
	}
	function checkAddr1() {
		var regex = /[가-힣]{1,200}/g;
		var nameTag = document.getElementById("addr1");

		var isName = regex.test(nameTag.value);
		nameTag.classList.remove("correct");
		nameTag.classList.remove("incorrect");

		if (!isName) {
			nameTag.classList.add("incorrect");
			return false;
		} else {
			nameTag.classList.add("correct");
			return true;
		}
	}
	function checkAddr2() {
		var regex = /[가-힣]{1,200}/g;
		var nameTag = document.getElementById("addr2");

		var isName = regex.test(nameTag.value);
		nameTag.classList.remove("correct");
		nameTag.classList.remove("incorrect");

		if (!isName) {
			nameTag.classList.add("incorrect");
			return false;
		} else {
			nameTag.classList.add("correct");
			return true;
		}
	}
	function checkPhone() {
		var regExp = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/;
		var phoneTag = document.getElementById("phone");
		var isPhone = regExp.test(phoneTag.value);
		phoneTag.classList.remove("correct");
		phoneTag.classList.remove("incorrect");

		if (!isPhone) {
			phoneTag.classList.add("incorrect");
			return false;
		} else {
			phoneTag.classList.add("correct");
			return true;
		}
	}

	function checkForm1() {
		console.log("이름" + checkName());
		console.log("비밀번호" + checkPwd());
		console.log("아이디" + checkCheckId());
		console.log("이메일" + checkCheckEmail());
		console.log("아이디" + checkPhone());
		console.log("주소1" + checkAddr1());
		console.log("주소2" + checkAddr2());
		if (!checkCheckId() || !checkName() || !checkCheckEmail()
				|| !checkPwd() || !checkCheckPw() || !checkAddr1()
				|| !checkAddr2() || !checkPhone()) {
			return false;
		} else {

			return true;
		}
	}
</script>
</script>
<body class="h-100">

	<!--*******************
        Preloader start
    ********************-->
	<div id="preloader">
		<div class="loader">
			<svg class="circular" viewBox="25 25 50 50">
                <circle class="path" cx="50" cy="50" r="20" fill="none"
					stroke-width="3" stroke-miterlimit="10" />
            </svg>
		</div>
	</div>
	<!--*******************
        Preloader end
    ********************-->





	<div class="login-form-bg h-100">
		<div class="container h-100">
			<div class="row justify-content-center h-100">
				<div class="col-xl-6">
					<div class="form-input-content">
						<div class="card login-form mb-0">
							<div class="card-body pt-5">

								<a class="text-center">
									<h4>일정 관리 시스템</h4>
								</a>

								<form class="mt-5 mb-5 login-input"
									action="${pageContext.request.contextPath}/user/insertUserInfo.do"
									method="post" name="f" onsubmit="return checkForm1();">
									<div class="form-group row">
										<div class="col-sm-6 mb-3 mb-sm-0">
											<input type="text"
												class="form-control form-control-user id-input inid" id="id"
												name="member_id" placeholder="아이디를 입력해주세요"
												oninput="checkId();"> <span class="correct-message">올바른
												아이디 형식입니다</span> <span class="incorrect-message">영문자로 시작하는
												영문자 또는 숫자 6~20자 </span> <span class="overlap-message">중복된
												아이디가 있습니다.</span> <span class="unoverlap-message" id="unoverlap">사용
												가능한 아이디입니다.</span>
										</div>
										<div class="col-sm-6">
											<input type="text"
												class="form-control form-control-user intext" id="name"
												name="member_name" oninput="checkName();"
												placeholder="이름을 입력해주세요"> <span
												class="correct-message">올바른 이름 형식입니다</span> <span
												class="incorrect-message">이름은 한글 2~7자로 구성하세요</span>

										</div>
									</div>
									<div class="form-group">
										<input type="email"
											class="form-control form-control-user email-input inemail"
											maxlength="300" id="email" oninput="checkEmail();"
											name="member_email" placeholder="이메일을 입력해주세요"> <span
											class="correct-message" id="checkEmail">올바른 이메일 형식입니다</span>
										<span class="incorrect-message">부적절한 이메일 형식입니다.</span> <span
											class="overlap-message">중복된 이메일이 있습니다.</span> <span
											class="unoverlap-message">사용 가능한 이메일입니다.</span>
									</div>
									<div class="form-group row">
										<div class="col-sm-6 mb-3 mb-sm-0">
											<input type="password"
												class="form-control form-control-user intext"
												name="member_pw" id="pw" oninput="checkPwd();"
												placeholder="비밀번호를 입력해주세요"> <span
												class="correct-message">올바른 비밀번호 형식입니다</span> <span
												class="incorrect-message">8 ~ 16자 영문, 숫자, 특수문자를 최소
												한가지씩 조합</span>
										</div>
										<div class="col-sm-6">
											<input type="password"
												class="form-control form-control-user intext"
												name="member_pw2" id="checkPw" oninput="checkCheckPw();"
												placeholder="비밀번호 확인"> <span class="correct-message">비밀번호가
												일치합니다.</span> <span class="incorrect-message">비밀번호가 불일치합니다.</span>
										</div>
									</div>
									<div class="form-group">
										<input type="text"
											class="form-control form-control-user intext" id="addr1"
											name = "addr1" oninput="checkAddr1();" placeholder="기본주소를 입력해주세요">
										<span class="correct-message">올바른 주소 형식입니다</span> <span
											class="incorrect-message">1글자 이상의 한글로 입력해주세요</span>
									</div>
									<div class="form-group">
										<input type="text" class="form-control form-control intext "
											oninput="checkAddr2();" name="addr2" id="addr2"
											placeholder="상세주소를 입력해주세요"> <span
											class="correct-message">올바른 주소 형식입니다</span> <span
											class="incorrect-message">1글자 이상의 한글로 입력해주세요</span>
									</div>
									<div class="form-group row">
										<div class="col-sm-6 mb-3 mb-sm-0">
											<input type="text"
												class="form-control form-control-user intext" id="phone"
												oninput="checkPhone();" name="member_phone"
												placeholder="휴대폰번호를 입력해주세요"><span
												class="correct-message">올바른 전화번호 형식입니다</span> <span
												class="incorrect-message">01x-xxxx-xxxx형식으로 입력해주세요</span>
										</div>
									</div>

									<div class="form-group">
										<label class="radio-inline mr-3"> <input type="radio"
											name="member_auth" value="staff" checked="checked">
											평직원
										</label> <label class="radio-inline mr-3"> <input type="radio"
											name="member_auth" value="leader"> 팀장
										</label>
									</div>
									<button class="btn login-form__btn submit w-100" type="submit">회원가입
										승인 대기</button>
								</form>
								<p class="mt-5 login-form__footer">
									계정이 있다면 <a
										href="${pageContexxt.request.contextPath}/member/login.do"
										class="text-primary">로그인 </a>
								</p>
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--**********************************
        Scripts
    ***********************************-->
	<script
		src="${pageContext.request.contextPath}/plugins/common/common.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/custom.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/settings.js"></script>
	<script src="${pageContext.request.contextPath}/js/gleek.js"></script>
	<script src="${pageContext.request.contextPath}/js/styleSwitcher.js"></script>
</body>
</html>
