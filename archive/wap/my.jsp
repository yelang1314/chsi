<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no,viewport-fit=cover">
    <meta name="format-detection" content="telephone=no" />
    <title>我的</title>
    <link rel="icon" href='https://t1.chei.com.cn/archive/favicon.ico' type="image/x-icon">
    <link rel="stylesheet" href='https://t1.chei.com.cn/archive/fonts/chsi-font.css' />
    <link rel="stylesheet" href='https://t3.chei.com.cn/archive/mobile/css/app.css?v=20250711' />
    <link rel="stylesheet" href='https://t1.chei.com.cn/common/ch/iconfont.css' />
    <link rel="stylesheet" href='https://t1.chei.com.cn/common/css/font/RareWords/RareWordsFonts.css' />
    <script src='https://t1.chei.com.cn/common/js/vue/2.5.6/vue.min.js'></script>
    <script src='https://t1.chei.com.cn/archive/mobile/js/vant1.47/vant.min.js'></script>
    <script src='https://t1.chei.com.cn/archive/mobile/js/vendors-1.0.0.js'></script>
    <script src='https://t3.chei.com.cn/archive/mobile/js/app-1.0.0.js'></script>
</head>
<body style="font-size: 12px;">
    <div id="app" class="my-container">
        <div class="green-header van-nav-bar van-hairline--bottom" style="z-index: 1;">
            <div class="van-nav-bar__left" onclick="history.back()"><i class="van-icon van-icon-arrow-left van-nav-bar__arrow"></i><!----><!----></div>
            <div class="van-ellipsis van-nav-bar__title">我的</div>
            <div class="van-nav-bar__right"><!----></div>
        </div>
        <div class="personal-page">
            <div class="logo"></div>
            <a onclick="logoutFn(event);" href="/archive/wap/index.jsp"><button class="my-btn van-button van-button--primary van-button--normal"><span class="van-button__text">退出</span></button></a>
        </div>
        <van-tabbar fixed z-index="1000" v-model="activeBottom">
            <van-tabbar-item @click="goUrl('/archive/wap/index.jsp')">
                <i class="iconfont" slot="icon" title="home">&#xe6d7;</i>
                <span>首页</span>
            </van-tabbar-item>
            <van-tabbar-item @click="goUrl('/archive/wap/gdjy/index.jsp')">
                <img src="https://t1.chei.com.cn/archive/images/xj/xjxlxw.svg" style="height:.613rem;margin: -0.04rem 0 0.04rem;" slot="icon" />
                <span>学籍学历学位</span>
            </van-tabbar-item>
            <van-tabbar-item @click="goUrl('https://xz.chsi.com.cn/survey/wap/index.action')">
                <i class="iconfont" slot="icon" title="cp">&#xe6d6;</i>
                <span>个人测评</span>
            </van-tabbar-item>
            <van-tabbar-item @click="goUrl('https://www.ncss.cn/')">
                <i class="iconfont" slot="icon" title="zp">&#xe6da;</i>
                <span>求职招聘</span>
            </van-tabbar-item>
            <van-tabbar-item>
                <i class="iconfont" slot="icon" title="my">&#xe6d8;</i>
                <span>我的</span>
            </van-tabbar-item>
        </van-tabbar>
    </div>
    <script type="text/javascript">
        function logoutFn(event){
            var e = event || window.event;
            if(!confirm('确定要退出吗？')){
                if(e && e.preventDefault) { e.preventDefault(); }
                else { e.returnValue = false; }
                return false;
            }
            // 本地化：清除登录态
            document.cookie = "chsi_login=; path=/; expires=Thu, 01 Jan 1970 00:00:00 GMT";
            try { localStorage.removeItem("chsi_user"); } catch(err) {}
            return true;
        }
    </script>
    <script>
        var myVue = new Vue({
            el: '#app',
            data: function(){
                return {
                    activeBottom: 4,
                    topText: '学信档案'
                }
            },
            mixins: typeof mixin != 'undefined' ? [mixin] : {},
            methods: {
                goToIndex: function(){
                    window.location.href = '/archive/wap/index.jsp';
                },
                goUrl: function(url){
                    window.location.href = url;
                }
            }
        });
    </script>
    <script type="text/javascript">
        // 解决手机浏览器自带返回 没刷新问题
        (function() {
            var isPageHide = false;
            window.addEventListener('pageshow', function() {
                if (isPageHide) {
                    var curUrl = window.location.href,
                        curIndex = curUrl.substring(curUrl.indexOf('wap/') + 4);
                    if (curIndex == 'my.jsp') {
                        myVue.$data.activeBottom = 4;
                    } else {
                        myVue.$data.activeBottom = 0;
                    }
                }
            });
            window.addEventListener('pagehide', function() {
                isPageHide = true;
            });
        })();
    </script>
</body>
</html>
