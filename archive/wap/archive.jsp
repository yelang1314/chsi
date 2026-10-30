
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no,viewport-fit=cover">
    <meta name="format-detection" content="telephone=no" />
    <title>学信档案</title>
    <link rel="icon" href='https://t1.chei.com.cn/archive/favicon.ico' type="image/x-icon">
    <link rel="stylesheet" href='https://t1.chei.com.cn/archive/fonts/chsi-font.css' />
    <link rel="stylesheet" href='https://t3.chei.com.cn/archive/mobile/css/app.css?v=20250711' />
    <link rel="stylesheet" href='https://t1.chei.com.cn/common/ch/iconfont.css' />
    <link rel="stylesheet" href='https://t1.chei.com.cn/common/css/font/RareWords/RareWordsFonts.css' />
    <script src='https://t1.chei.com.cn/common/js/vue/2.5.6/vue.min.js'></script>
    <script src='https://t1.chei.com.cn/archive/mobile/js/vant1.47/vant.min.js'></script>
    <script src='https://t4.chei.com.cn/common/js/api-1.0.4.js'></script>
    <script src='https://t1.chei.com.cn/archive/mobile/js/vendors-1.0.0.js'></script>
    <script src='https://t2.chei.com.cn/archive/mobile/js/app-1.0.3.js'></script>
    <script src='https://t3.chei.com.cn/archive/mobile/js/lodash.min.js'></script>
    <script src='https://t4.chei.com.cn/archive/mobile/js/jweixin-1.6.0.js'></script>
    <style>
        .extra-wrap{
            display: flex;
            align-items: center;
        }
        .extra-wrap .red{
            margin-right: 5px;
            color: #e85759;
        }
        .vote-order-ul li{
            align-items: center;
        }
        .vote-order-ul .vue-checkbox{
            display: inline-block;
            margin-right: 10px;
            white-space: nowrap;
            position: relative;
            line-height: 1;
            vertical-align: middle;
            cursor: pointer;
            outline: 0;
        }
        .vote-order-ul .vue-checkbox .vue-checkbox-inner {
            display: inline-block;
            position: relative;
            width: .426rem;
            height: .426rem;
            top: 0;
            left: 0;
            background-color: #fff;
            border: 1px solid #969799;
            border-radius: 2px;
            transition: all .2s ease-in-out;
        }
        .vote-order-ul .vue-checkbox .checked-box-order {
            display: inline-block;
            position: relative;
            width: .426rem;
            height: .426rem;
            top: 0;
            left: 0;
            color: #fff;
            border-radius: 2px;
            text-align: center;
            background-color: #25b887;
            border: 1px solid #25b887;
            transition: all .2s ease-in-out;
        }
        .jy-vote .sub_sub_title{
            font-size: .373rem;
            margin-top: 0.45rem;
            font-weight: 700;
        }
        .checkbox-trans-list-item {
        transition: all 1s;
        display: inline-block;
        margin-right: 10px;
        }
        .checkbox-trans-list-enter, .checkbox-trans-list-leave-to{
        opacity: 0;
        transform: translateY(30px);
        }
        .checkbox-trans-list-leave-active {
        position: absolute;
        }
        .gxbys-vote .line-input{
            -webkit-appearance: none;
            border-radius:0;
        }
        /* 重写字体 */
        .nameFamily{
            font-family: Chsi,"rare-words-font";
        }
        .sur-input{
            /* width: 100%;            */
            margin-left:.267rem;
            padding: .133rem .267rem;
            font-size: .4rem;
            line-height: .56rem;
            border: 1px solid #dde5ed;
            box-sizing: border-box;
            border-radius: .16rem;
            -webkit-appearance: none;
        }
        .extra-wrap .sur-input{
            flex:1
        }
        .wap-vote-jz{
            border:1px solid #E8EAED;
        }
        .wap-vote-jz .jz-head{
            display:flex;
            background-color: #F7F8FA;
            border-bottom:1px solid #E8EAED;
            font-size: .373rem;
            line-height: 2.5;
        }
        .jy-vote .wap-vote-jz .jz-item{
            flex:1;
            text-align:center;
        }
        .jy-vote .wap-vote-jz .van-radio-group{
            display:flex;
            padding:0
        }
        .jy-vote .wap-vote-jz .van-radio-group .van-radio{
            flex:1;
            justify-content: center;
        }
        .jy-vote .wap-vote-jz p.sub_title{
            padding-left:0;
            padding-right:0;
            font-weight:400;
            font-size:0.347rem;
        }
        .jy-vote .wap-vote-jz p.shgl-vote{
        }
        .jy-vote .wap-vote-jz p.sub_title.extra-wrap{
            padding-right:.267rem;
        }
        .vote-vee .bg-des{
            padding: .373rem;
            background: #f7f9f9;
        }
        .shgl-vote .sm{
            padding:0.267rem;
            color:#666;
            line-height:1.8;
            font-size:.373rem;
        }
         .shgl-vote .sm p{
            text-indent:2em;
        }
        .shgl-vote .sm .textR{
            text-align:right;
        }
        .shgl-vote .wap-vote-jz .jz-head{
            line-height: 1.3;
            padding:0.267rem 0;
            font-weight:700;
        }
        .shgl-vote.jy-vote .wap-vote-jz p.sub_title{
            padding-left:0.267rem;
            padding-right:0.267rem;
        }
        .shgl-vote .wap-vote-jz{
            padding-bottom:0.32rem
        }
        .ques-checkbox div.van-checkbox__icon,
        .ques-checkbox .select-border .van-icon {
            width: 20px;
        }
        .checkbox-trans-list-item-2025 {
            margin-right: 0;
        }
        .jy-vote .select-border-qzsj {
            margin-top: 0;
            padding: 0.05rem 0.16rem;
            width: 2.2rem;
            margin: 0 0.16rem;
        }
        .jy-vote .select-border-qzsj-box .select-border-qzsj:first-child {
            width: 3.1rem;
        }
    </style>

<script>
    // 百度统计
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?ed4ddcd4078a486f1f5760a6c426b738";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>
<script>
    // 本地化：未登录直接访问档案页，跳转登录页
    if (document.cookie.indexOf('chsi_login=') === -1) {
        window.location.href = '/archive/login.jsp?redirect=/archive/wap/archive.jsp';
    }
</script>
</head>
<body>
    <div id="app" class="my-container" v-cloak>

<img src='https://t1.chei.com.cn/common/wap/images/share_xxda.jpg' width='0' height='0' style='position: absolute;top:-100px;left: 0'/>
<div class="my-header">
    <a href="/archive/wap/index.jsp" class="logo"></a>
    <a onclick='logoutFn(event);' class="go-out" id="goOut"  href='/archive/wap/index.jsp'><i class="iconfont" title="退出">&#xe66b;</i></a>
</div>
 <script type='text/javascript'>
    function logoutFn(event){
        var e = event ||window.event;
        if(!confirm('确定要退出吗？')){
            if(e && e.preventDefault) {
                e.preventDefault();
            } else {
                e.returnValue = false;
            }
            return false;
        }
        // 本地化：清除登录态后返回导航页
        document.cookie = "chsi_login=; path=/; expires=Thu, 01 Jan 1970 00:00:00 GMT";
        return true;
    };
    // 是否显示退出按钮，app里访问不显示
    function showLogout(){
        var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
        if (userAgent.indexOf("ChesiccApp") > -1) {
            document.getElementById('goOut').style.visibility="hidden";
        }
    }
    showLogout();
</script>
<div class="vote-part">
    <!-- 学职 -->
    <template v-if="xzData!=null && xzData.data!=null ">
        <template v-if="!xzData.data.finished">
            <a :href="xzData.data.surveyUrl" onmousedown="gaTrackerOutboundLink(this,'xzcp', 'click', 'wap_main');" target="_blank">
                <div class="card-list" >
                    <div class="card-left-img">
                        <img :src="'https://t3.chei.com.cn/archive/images/xzpt/'+xzImg" width="42" />
                    </div>
                    <h4 class="flex1 bt-text show-line2">{{xzData.data.title}}</h4>
                    <div class="go-btn">去测评</div>
                </div>
            </a>
        </template>
        <template v-else>
            <a href="https://xz.chsi.com.cn/psn/wap/psndefault.action" target="_blank">
                <div class="card-list" >
                    <div class="card-left-img">
                        <img src="https://t3.chei.com.cn/archive/images/xzpt/cpbg.png" width="42" />
                    </div>
                    <h4 class="flex1 bt-text show-line2">完成测评，查看我的测评报告</h4>
                    <div class="go-btn">查看</div>
                </div>
            </a>
        </template>
    </template>
    <!-- 满意度 -->
    <template v-if=" mydData!=null && mydData.data!=null">
        <template v-if="mydData.type==='zytj'">
            <a href="https://my.chsi.com.cn/zyzsk/wap/zytj/recommendhome?from=wap_main" target="_blank" onmousedown="gaTrackerOutboundLink(this,'zytj', 'click', 'wap_main');">
                <div class="card-list" >
                    <div class="flex1">
                        <div class="myd-top">
                            <h4 class="bt-text">专业推荐</h4>
                            <div class="myd-totle">累计投票<span>{{mydData.data.tjTotal}}</span></div>
                        </div>
                        <div class="sub-wrap">{{mydData.data.yxmc}}-{{mydData.data.zymc}}</div>
                    </div>
                    <div class="go-btn">去推荐</div>
                </div>
            </a>
        </template>
        <template v-else-if="mydData.type==='yxmyd'">
            <a href="https://my.chsi.com.cn/zyzsk/wap/yxmyd/schappraisal?from=wap_main" target="_blank" onmousedown="gaTrackerOutboundLink(this,'yxmyd', 'click', 'wap_main');">
                <div class="card-list" >
                    <div class="flex1">
                        <div class="myd-top">
                            <h4 class="bt-text">院校满意度</h4>
                            <div class="myd-totle">累计投票<span>{{mydData.data.tjTotal}}</span></div>
                        </div>
                        <div class="sub-wrap">{{mydData.data.yxmc}}-{{mydData.data.zymc}}</div>
                    </div>
                    <div class="go-btn">去评价</div>
                </div>
            </a>
        </template>
        <template v-else>
            <a href="https://my.chsi.com.cn/zyzsk/wap/zymyd/specappraisal?from=wap_main" target="_blank" onmousedown="gaTrackerOutboundLink(this,'zymyd', 'click', 'wap_main');">
                <div class="card-list" >
                    <div class="flex1">
                        <div class="myd-top">
                            <h4 class="bt-text">专业满意度</h4>
                            <div class="myd-totle">累计投票<span>{{mydData.data.tjTotal}}</span></div>
                        </div>
                        <div class="sub-wrap">{{mydData.data.yxmc}}-{{mydData.data.zymc}}</div>
                    </div>
                    <div class="go-btn">去评价</div>
                </div>
            </a>
        </template>
    </template>
    <!-- 新职业 -->
    <template v-if="xzyData.status===0 && xzyData.result!=null && xzyData.result.jobData !=null && xzyData.result.finished">
        <div class="card-list" >
            <div class="flex1">
                <a :href="xzyData.result.jobData.jobURL" target="_blank">
                    <h4 class="show-line1 bt-text">{{xzyData.result.jobData.jobName}}</h4>
                    <div class="sub-wrap">
                        <span class="xzy-xz">{{xzyData.result.jobData.lowMonthPay}}k-{{xzyData.result.jobData.highMonthPay}}k</span>
                        <span class="xzy-xl">{{xzyData.result.jobData.degreeName}}</span>
                    </div>
                </a>
            </div>
            <a  class="go-btn" href="https://job.ncss.cn/student/jobs/index.html"  target="_blank">更多职位</a>
        </div>
    </template>
    <!-- 动态问卷 -->



    <!--移动端-->
    <div id="vote_wap" style="display:none"></div>
    <script type="text/javascript">
        var position = 'wap_main';
        function getVoteInfo(){
            api.syncAjax('post', '/archive/survey/zswj/show.action',{data:{position:position}}).then(function(res){
                if(res.status==0 && res.result!=null){
                    var qqFrom='';//请求from
                    switch(position) {
                        case "wap_main":
                            qqFrom="main-wap";
                            break;
                        case "wap_xjxl":
                            qqFrom="gdjy_index_wap";
                            break;
                        case "wap_txjd":
                            qqFrom="archive_xjxx_wap";
                            break;
                        default:
                            qqFrom=  position;
                            break;
                    }
                    if (!(res.result.surveyOne == null || res.result.surveyOne == undefined || res.result.surveyOne == '')) {
                        var _url = '',_title='',_className='';
                        switch(res.result.surveyOne) {
                            case "xsgz":
                                _url = 'https://my.chsi.com.cn/archive/survey/xsgz/show.action?from='
                                _title='高校学生跟踪调查问卷';
                                _className='vote_bg_jygz';
                                break;
                            case "bysgzdc":
                                _url = 'https://my.chsi.com.cn/archive/survey/bygz/show.action?from='
                                _title='高校毕业生跟踪调查问卷';
                                _className='vote_bg_jygz';
                                break;
                            case "xyxxzk":
                                _url = 'https://my.chsi.com.cn/archive/survey/campus/index.action?from='
                                _title='高校校园学习状况调查';
                                _className='vote_bg_zxs';
                                break;
                            case "jycyfw":
                                _url = 'https://my.chsi.com.cn/archive/survey/cyfw/show.action?from='
                                _title='2026届高校毕业生就业创业服务调查';
                                _className='vote_bg_cyfw';
                                break;
                            case "jyqw":
                                _url = 'https://my.chsi.com.cn/archive/survey/jyqw/show.action?from='
                                _title='2027届高校毕业生就业意愿调查';
                                _className='vote_bg_jyqw';
                                break;
                            // 学职固定链接
                            case "xzcp":
                                //学职系统的测评
                                _url = "https://xz.chsi.com.cn/survey/index.action?from="
                                _title='测测哪种职业更适合自己？';
                                _className='vote_bg_xzcp';
                                break;
                             //学职-考证，学职-实习,仅需要banner图和链接，不需要文字
                            case "kzxz":
                                _url = "https://xz.chsi.com.cn/cp/survey/yhdy4/show.action?from="
                                _className='vote_bg_kzxz';
                                break;
                            case "zcsx":
                                _url = "https://xz.chsi.com.cn/cp/survey/yhdy3/show.action?from="
                                _className='vote_bg_zcsx';
                                break;
                            //满意度,仅需要banner图和链接，不需要文字
                            case "zytj":
                                //高考-专业推荐
                                _url = "https://my.chsi.com.cn/zyzsk/wap/zytj/recommendhome?from="
                                _className='vote_bg_zytj';
                                break;
                            case "zymyd":
                                //高考-专业满意度
                                _url = "https://my.chsi.com.cn/zyzsk/wap/zymyd/specappraisal?from="
                                _className='vote_bg_zymyd';
                                break;
                            case "yxmyd":
                                //高考-院校满意度
                                _url = "https://my.chsi.com.cn/zyzsk/wap/yxmyd/schappraisal?from="
                                _className='vote_bg_yxmyd';
                                break;
                            default:
                        }
                        _url = _url+qqFrom;
                        setVote(_url,_title,_className,res.result.surveyOne);
                    }
                    /*if (res.result.shgldc) {
                        //显示上海问卷
                        var _url = '',_title='',_className='';
                        _url = "https://my.chsi.com.cn/archive/survey/shgl/show.action?from="
                        _className='vote_bg_shgldc';
                        _url = _url+qqFrom;
                        setVote(_url,_title,_className,'shgldc');
                    }*/
                }
            });
        }
        /**
         * 显示调查问卷banner
         * url:链接
         * tit:问卷名称
         * cName:class类名
         */
        function setVote(url,tit,cName,type){
            var dom = document.getElementById("vote_wap");
            // 是否有文字，高考推荐类的没有，其他有
            var aInnerHTML = '';
            if(dom){
                if(tit){
                    // 非高考（专业推荐、满意度）
                    var ghead = '立即前往<i class="iconfont" title="立即前往">&#xe601;</i>';
                    if(tit=='高考志愿填报调查问卷'){
                        ghead = '填问卷，述感受，点亮高考生志愿路！';
                    }
                    aInnerHTML = '<h4 class="vote-left"><span class="vote-text">'+tit+'</span><span class="go-ahead">'+ghead+'</span></h4><div class="right-img"></div>';
                }
                var _html = '<a href="'+url+'" style="display:block" onmousedown="clickVoteGa(this, \''+type+'\')" class="vote-jy-part '+cName+'">'+aInnerHTML+'</a>';
                if(type == 'shgldc'){
                    // 追加显示
                    dom.innerHTML = dom.innerHTML + _html;
                }else{
                    dom.innerHTML = _html;
                }
                dom.style.display="block";
            }
        }
        function clickVoteGa(obj,type){
            if(type=='zcsx'|| type=='kzxz'){
                var _type = type+'_'+position;
                gaTrackerOutboundLink(obj,_type, 'click', position);
            }else{
                gaTrackerOutboundLink(obj,type, 'click', position);
            }
        }
        window.onload = function(){
            getVoteInfo();
        }
    </script>
</div>
<div class="menu-part">
    <van-row >
        <van-col span="8">
            <a href="/archive/wap/gdjy/index.jsp" class="menu-a">
                <span class="menu-img xjxl-img"></span><br/>
                高等教育信息
            </a>
        </van-col>
        <van-col span="8">
            <a href="https://my.chsi.com.cn/archive/bab/index.action" class="menu-a">
                <span class="menu-img zxyz-img"></span><br/>
                在线验证报告
            </a>
        </van-col>
        <van-col span="8">
            <a href="https://my.chsi.com.cn/archive/rzbg/index.action" class="menu-a">
                <span class="menu-img rzbg-img"></span><br/>
                学历学位认证<br/>与成绩验证
            </a>
        </van-col>
    </van-row>
    <van-row >
        <van-col span="8">
            <a href="https://my.chsi.com.cn/archive/gjhz/index.action" class="menu-a">
                <span class="menu-img gjhz-img"></span><br/>
                出国（境）报告<br/>发送
            </a>
        </van-col>
        <van-col span="8">
            <a href="https://my.chsi.com.cn/archive/wap/gdjy/xj/collate.action" class="menu-a">
                <span class="menu-img txjd-img"></span><br/>
                毕业证书图像<br/>校对
                <!-- <span class="hot-laber">优先</span> -->
            </a>
        </van-col>
        <van-col span="8">
            <a href="https://www.ncss.cn/" class="menu-a">
                <span class="menu-img xzy-img"></span><br/>
                就业
            </a>
        </van-col>
    </van-row>
    <van-row >
        <van-col span="8">
            <a href="https://my.chsi.com.cn/archive/survey/index.action" class="menu-a">
                <span class="menu-img myd-img"></span><br/>
                学校满意度
            </a>
        </van-col>
        <van-col span="8">
            <a href="https://xz.chsi.com.cn/survey/wap/index.action" class="menu-a">
                <span class="menu-img cp-img"></span><br/>
                个人测评
            </a>
        </van-col>
        <van-col span="8">
            <a href="https://my.chsi.com.cn/archive/gdjy/wzy/show.action" class="menu-a">
                <span class="menu-img sq-img"></span><br/>
                “双千”计划<br/>“微专业”
            </a>
        </van-col>
    </van-row>
</div>
<van-tabbar fixed z-index="1000" v-model="activeBottom" >
    <van-tabbar-item>
        <i class="iconfont" slot="icon" title="home">&#xe6d7;</i>
        <span>首页</span>
    </van-tabbar-item>
    <van-tabbar-item @click="goUrl('/archive/wap/gdjy/index.jsp')">
        <!-- <i class="iconfont" slot="icon" title="xjxl">&#xe6d9;</i> -->
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
    <van-tabbar-item @click="goUrl('/archive/wap/my.jsp')">
        <i class="iconfont" slot="icon" title="my">&#xe6d8;</i>
        <span>我的</span>
    </van-tabbar-item>
</van-tabbar>
<script type="text/javascript">
    const api2 = new API({
        resPage: false, //当为true时，不再返回轮询结果
        resType: 'json', //对请求结果的处理方式，默认：json，默认：json, 表示轮询结果格式为json
        taskUrl: "/archive/wap/rcd.action", //默认：''，注意：当为空时，则不会进入轮询
        pollingUrl: "/archive/asyn/progress.do", //默认：''，注意：当为空时，不会进入轮询
        pollingLimit: 10, // 请求的最大次数，默认：10次
        pollingDelay: 1000, // 正常轮询时，请求延迟毫秒数，默认：1000毫秒
        delayGaps: 300, // 轮询请求间隔递增毫秒数，默认：0毫秒（建议不要超过1000）
        retryLimit: 1, // 当发生错误时请求的最大次数，默认：1次
        retryAfter: 1000, //第一次发送请求毫秒数，默认：1000毫秒
        retryGaps: 300, // 发送请求的递增毫秒数,默认：300毫秒
    },{
        headers: { // 其他为axios的配置-设置headers
            "X-Requested-With": "XMLHttpRequest",
            "Content-Type": "application/x-www-form-urlencoded;charset=utf-8",
        },
        timeout: 60000,
    });
    var mixin = {
        data:function(){
            return {
                activeBottom: 0,
                xzData:{},//学职数据
                xzImg:'',//学职图片
                xzyData:{},//新职业数据
                mydData:{},//满意度数据
                sqNum:0,//待授权数量
                zwtjTimer:null,//获取职位推荐监控变量
            }
        },
        created:function(){
            this.init();
        },
        methods:{
            init:function(){
                this.getXzOrMyd();//获取学职或者满意度初始化数据
                this.getXzy(null);//获取新职业初始化数据
            },
            getXzOrMyd:function(){//学职测评返回数据
                var _this=this;
                api2.syncAjax('post', '/archive/wap/rcd.action').then(function(res){
                    if (res.flag) {//成功
                        if(res.data.type=='xzcp'){
                            _this.xzData = res.data;
                            if(!res.data.data.finished){
                                var imageUrl = res.data.data.imageUrl;
                                _this.xzImg =  imageUrl.substring(imageUrl.lastIndexOf('/')+1);
                            }
                        }else{
                            _this.mydData = res.data;
                        }
                    }
                });
            },
            getXzy:function(taskId){//新职业返回数据
                var _this=this;
                _this.closedTimer();
                api.syncAjax('post', '/archive/ncss/zwtj/query.action', {data:{taskId: taskId}}).then(function(res){
                    if (res.status===1) {
                        return;
                    }
                    if (res.result.finished) {
                        _this.xzyData = res;
                    } else {
                        _this.getXzyprogress(res.result.taskId);
                    }
                });
            },
            getXzyprogress:function(taskId){
                var _this =this;
                api.syncAjax('post', '/archive/asyn/progress.do',{ data:{taskId: taskId}}).then(function(res){
                    switch (res.state) {
                        case "wait":
                            _this.zwtjTimer = setTimeout(function () {
                                _this.getXzyprogress(taskId);
                            }, 3000);
                            break;
                        case "success":
                            _this.getXzy(taskId)
                            _this.closedTimer();
                            break;
                        default:
                            _this.closedTimer();
                    }
                }).catch(function(){
                });
            },
            closedTimer:function(){
                clearTimeout(this.zwtjTimer);
                this.zwtjTimer = null;
            },
            goUrl:function(url){
                window.location.href=url;
            }
        }
    }
</script>
    </div>
    <script>
        const dictionary1 = {
            zh_CN: {
                messages: {
                    required: ( field )=> "该题为必填项，请填写完整后再提交。",
                    numeric:function(name,a){
                        var text='必须为数字'
                        return text
                    },
                    between:function(name,a){
                        var text='请选择'+a[0]+'项。'
                        if(a[0]!=a[1]){
                            text='请选择'+a[0]+'~'+a[1]+'项。'
                        }
                        return text
                    }
                }
            }
        };
        Validator.updateDictionary(dictionary1);
    </script>
    <script>
    var myVue = new Vue({
            el: '#app',
            data:function(){
               return {
                activeBottom:0,
                topText:'学信档案' //标题文字
               }
            },
            mixins: typeof mixin != 'undefined' ? [mixin] : {},
            created:function(){
            },
            methods:{
                onClickLeft:function(){ //左上的返回按钮
                    history.back(-1);
                },
                goToIndex:function(){
                    window.location.href='https://my.chsi.com.cn/archive/wap/index.action';
                },
                getQueryString:function(name) {//获取地址栏参数
                    var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
                    var r = window.location.search.substr(1).match(reg);
                    if (r != null) {
                    return unescape(r[2]);
                    }
                    return null;
                },
                VoteGoToIndex:function(){//投票完成返回首页
                    var _from = this.getQueryString('from');
                    if(_from=='archive-dctp-wap'){
                        window.location.href='https://my.chsi.com.cn/archive/survey/index.action';
                    }else{
                        window.location.href='https://my.chsi.com.cn/archive/wap/index.action';
                    }
                },
                addCookie:function(name,value){ //设置cookie
                    var cookieString=name+"="+escape(value);
                    document.cookie=cookieString;
                    document.cookie.setSecure=true;//只允许在https环境下使用cookie
                },
                getCookie:function(name){
                    var strCookie=document.cookie;
                    var arrCookie=strCookie.split("; ");
                    for(var i=0;i<arrCookie.length;i++){
                        var arr=arrCookie[i].split("=");
                        if(arr[0]==name)return arr[1];
                    }
                    return "";
                },
                trimSpace:function(s){//去掉左右空格
                    return s.replace(/(^\s*)|(\s*$)/g, "");
                },
                showSfhyOrder:function(){
                    //展示身份核验方式的序号，动态组合显示方式一、二、三
                    var nodeList = document.getElementsByClassName('verify-list')[0].getElementsByClassName("verify-list-li");
                    var liLen = nodeList.length;
                    for(var i=0;i<liLen;i++){
                        nodeList[i].getElementsByTagName('div')[0].innerText = '方式 '+(i+1);
                    }
                },
                noticeFace :function(from, code, chinal){
                    var _this =this;
                    api.syncAjax('post', '/archive/gdjy/check/face/notice.action', {data:{from:from,chinal:chinal, code:code}}).then(function(res){
                        if (res.status==0) {
                            window.location.href = res.result;
                        }else{
                            _this.$toast(res.message);
                        }
                    });
                }
            }
        });
    </script>
<script type="text/javascript">
    //解决手机浏览器自带返回 没刷新问题
    (function() {
        var isPageHide = false;
        window.addEventListener('pageshow', function() {
          if (isPageHide) {
            var curUrl =window.location.href,
                curIndex=curUrl.substring(curUrl.indexOf('wap/')+4);
            if(curIndex=='my.jsp'){
                myVue.$data.activeBottom =4;
            }else{
                myVue.$data.activeBottom =0;
            }
          }
        });
        window.addEventListener('pagehide', function() {
          isPageHide = true;
        });
    })();

    //优化加载效果
    document.addEventListener('DOMContentLoaded', function() {
        // 页面内容已准备就绪
        // 调用支付宝小程序提供的通信方法，通知小程序隐藏加载中效果
        if (window.AlipayJSBridge) {
            AlipayJSBridge.call('hideLoading');
        } else {
            document.addEventListener('AlipayJSBridgeReady', function() {
            AlipayJSBridge.call('hideLoading');
            }, false);
        }
        // 学信网App
        if(window.ChesiccJsAPI){
            ChesiccJsAPI.dismissLoadingView();
        }
    });
</script>
</body>
</html>