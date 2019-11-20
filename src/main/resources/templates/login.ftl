<!DOCTYPE html>
<html lang="en">
<head>
    <title>Karaoke Portal Login</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!--===============================================================================================-->
    <link rel="icon" type="image/png" href="/static/images/icons/favicon.ico"/>
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="/static/vendor/bootstrap/css/bootstrap.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="/static/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="/static/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="/static/vendor/animate/animate.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="/static/vendor/css-hamburgers/hamburgers.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="/static/vendor/animsition/css/animsition.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="/static/vendor/select2/select2.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="/static/vendor/daterangepicker/daterangepicker.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="/static/css/util.css">
    <link rel="stylesheet" type="text/css" href="/static/css/main.css">
    <!--===============================================================================================-->
</head>
<body>

<div class="limiter">
    <div class="container-login100" style="background-image: url('/static/images/bg-01.jpg');">
        <div class="wrap-login100 p-l-110 p-r-110 p-t-62 p-b-33">
            <form action="/login" method="post" class="login100-form validate-form flex-sb flex-w">
                <input type="hidden" name="_csrf" value="${_csrf.token}" />
					<span class="login100-form-title p-b-53">
						Karaoke Portal
					</span>

                <!--a href="#" class="btn-face m-b-20">
                    <i class="fa fa-facebook-official"></i>
                    Facebook
                </a>

                <a href="#" class="btn-google m-b-20">
                    <img src="/static/images/icons/icon-google.png" alt="GOOGLE">
                    Google
                </a-->

                <div class="p-t-31 p-b-9">
						<span class="txt1">
							Username
						</span>
                </div>
                <div class="wrap-input100 validate-input" data-validate = "Username is required">
                    <input class="input100" type="text" name="username" >
                    <span class="focus-input100"></span>
                </div>

                <div class="p-t-13 p-b-9">
						<span class="txt1">
							Password
						</span>

                    <!--a href="#" class="txt2 bo1 m-l-5">
                        Forgot?
                    </a-->
                </div>
                <div class="wrap-input100 validate-input" data-validate = "Password is required">
                    <input class="input100" type="password" name="password" >
                    <span class="focus-input100"></span>
                </div>

                <div class="container-login100-form-btn m-t-17">
                    <button type="submit" class="login100-form-btn">
                        Sign In
                    </button>
                </div>

                <!--div class="w-full text-center p-t-55">
						<span class="txt2">
							Not a member?
						</span>

                    <a href="#" class="txt2 bo1">
                        Sign up now
                    </a>
                </div-->
            </form>
        </div>
    </div>
</div>


<div id="dropDownSelect1"></div>

<!--===============================================================================================-->
<script src="/static/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
<script src="/static/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
<script src="/static/vendor/bootstrap/js/popper.js"></script>
<script src="/static/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
<script src="/static/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
<script src="/static/vendor/daterangepicker/moment.min.js"></script>
<script src="/static/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
<script src="/static/vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
<script src="/static/js/main.js"></script>

</body>
</html>