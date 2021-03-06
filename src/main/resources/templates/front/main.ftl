<#include "../parts/security.ftl">
<!DOCTYPE html>
<html>
<head>
    <title>VoiceTM</title>
    <!-- for-mobile-apps -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="Coming Soon Widget Responsive, Login form web template, Sign up Web Templates, Flat Web Templates, Login signup Responsive web template, Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
    <!-- //for-mobile-apps -->
    <link href='//fonts.googleapis.com/css?family=Audiowide' rel='stylesheet' type='text/css'>
    <link href='//fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
    <link href='//fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic' rel='stylesheet' type='text/css'>
    <link href="/static/css/jquery.classycountdown.css" rel="stylesheet" type="text/css">
    <link href="/static/css/style.css" rel="stylesheet" type="text/css" media="all" />

</head>
<body>
<div class="content">
    <h1>Coming Soon</h1>
    <div class="main">
        <div id="countdown9" class="ClassyCountdownDemo"></div>

        <!-- Partially video streaming -->
        <!--video autoplay="autoplay" controls>
            <source src="/videos/a3ccbad4-1d9e-42ec-a5be-735d1753c4fe.Mambo No 5 - Just Dance Summer Party - Wii Workouts (youtubemp4.to).mp4" type="video/mp4">
        </video-->
    </div>
    <p class="copy_rights">&copy; 2019 VoiceTM. All Rights Reserved | Design by Shagy</p>
</div>
<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/jquery.knob.js"></script>
<script src="/static/js/jquery.throttle.js"></script>
<script src="/static/js/jquery.classycountdown.js"></script>
<script>
    $(document).ready(function() {
        $('#countdown9').ClassyCountdown({
            end: '1383468325',
            now: '1380501323',
            labels: true,
            style: {
                element: "",
                textResponsive: .5,
                days: {
                    gauge: {
                        thickness: .10,
                        bgColor: "rgba(0,0,0,0)",
                        fgColor: "#1abc9c",
                        lineCap: 'round'
                    },
                    textCSS: 'font-weight:300; color:#fff;'
                },
                hours: {
                    gauge: {
                        thickness: .10,
                        bgColor: "rgba(0,0,0,0)",
                        fgColor: "#05BEF6",
                        lineCap: 'round'
                    },
                    textCSS: ' font-weight:300; color:#fff;'
                },
                minutes: {
                    gauge: {
                        thickness: .10,
                        bgColor: "rgba(0,0,0,0)",
                        fgColor: "#8e44ad",
                        lineCap: 'round'
                    },
                    textCSS: ' font-weight:300; color:#fff;'
                },
                seconds: {
                    gauge: {
                        thickness: .10,
                        bgColor: "rgba(0,0,0,0)",
                        fgColor: "#f39c12",
                        lineCap: 'round'
                    },
                    textCSS: ' font-weight:300; color:#fff;'
                }

            },
            onEndCallback: function() {
                console.log("Time out!");
            }
        });
    });
</script>
</body>
</html>