







<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <title>学信档案</title>
    <meta name="keywords" content="学信档案，高等教育信息，学籍学历，图片校对">
    <meta name="description" content="“学信档案”是中国高等教育学生信息网（简称“学信网”）各类学生个人信息档案的总称，涉及全国高等教育学生信息数据库中各类学生的学籍、学历、招生录取、助学贷款等信息。">
    <meta http-equiv="x-dns-prefetch-control" content="on">
    <meta name="format-detection" content="telephone=no, email=no">
    <!-- 目的是为了用户在使用谷歌系浏览器时 跳转到机器人模块后 可以读取完整referer -->
    <meta name="referrer" content="no-referrer-when-downgrade">
    <link rel="dns-prefetch" href="//t1.chei.com.cn?v=1531374966451">
    <link rel="dns-prefetch" href="//t2.chei.com.cn?v=1531374966451">
    <link rel="dns-prefetch" href="//t3.chei.com.cn?v=1531374966451">
    <link rel="dns-prefetch" href="//t4.chei.com.cn?v=1531374966451">
    <link rel="icon" href="https://t1.chei.com.cn/archive/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href='https://t1.chei.com.cn/common/bootstrap3.3.5/css/bootstrap.min.css' />
    <link rel="stylesheet" href='https://t1.chei.com.cn/common/ch/iconfont.css' />
    <link rel="stylesheet" href='https://t1.chei.com.cn/archive/fonts/chsi-font.css'>
    <link rel="stylesheet" href='https://t1.chei.com.cn/archive/css/custom/archive.min.css?v=20260907' />
    <script src='https://t1.chei.com.cn/common/js/api-1.0.4.js'></script>
    <script src='https://t1.chei.com.cn/common/jquery/1.9.1/jquery.min.js'></script>
    <script src='https://t1.chei.com.cn/common/plugins/layer/layer.js' ></script>
    <script src='https://t3.chei.com.cn/archive/mobile/js/lodash.min.js' ></script>
    <script src='https://t1.chei.com.cn/common/js/vue/2.5.6/vue.min.js'></script>
    <script type="text/javascript" src='https://t1.chei.com.cn/common/js/axios/0.19.2/axios.min.js'></script>
    <script type="text/javascript" src='https://t1.chei.com.cn/common/js/qs.js'></script>
    <script src='https://t1.chei.com.cn/archive/js/vee-validate.2.0.0-rc.25.js'></script>
    <script src='https://t1.chei.com.cn/common/vue-plugins/iview4.6.1/js/iview.min.js'></script>
    <script>
        function addCookie(name,value,exdays,path){
            var cookieString=name+"="+escape(value);
            if(exdays){
                 var expirationDate = new Date();
                expirationDate.setTime(expirationDate.getTime()+(exdays*24*60*60*1000));
                cookieString+="; expires="+expirationDate.toUTCString()
            }
            if(path){
                cookieString+="; path=/"+path;
            }
            document.cookie=cookieString;
            document.cookie.setSecure=true;//只允许在https环境下使用cookie
        }
        function getCookie(name){
            var strCookie=document.cookie;
            var arrCookie=strCookie.split("; ");
            for(var i=0;i<arrCookie.length;i++){
                var arr=arrCookie[i].split("=");
                if(arr[0]==name)return arr[1];
            }
            return "";
        }
    </script>
    
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
    // 未登录拦截：无登录态 cookie 则跳转登录页（模拟官方登录拦截）
    if (document.cookie.indexOf("chsi_login=") === -1) {
        window.location.href = '/archive/login.jsp';
    }
    // 退出登录：清除登录态 cookie 并回到登录页
    function chsiLogout(){
        document.cookie = "chsi_login=; path=/; expires=Thu, 01 Jan 1970 00:00:00 GMT";
        try { localStorage.removeItem("chsi_user"); } catch(e) {}
        window.location.href = '/archive/login.jsp';
    }
</script>
</head>
<body>
    <style type="text/css">
    .webuploader-container .webuploader-pick{
        position: relative;
        display: inline-block;
        cursor: pointer;
        color: #fff;
        text-align: center;
         border-radius:0;
        overflow: hidden;
        padding: 0 30px;
        background: #25b887;
    }
    .pdf-show{
        float: left;
        display:inline-block;
        border: 1px solid #ccc;
        padding:0 10px;
        width:144px;
        height: 32px;
        margin-right:5px;
    }
    .pdf-show .item{
        display:inline-block;
        width:144px;
        text-overflow: ellipsis;
        overflow: hidden;
        white-space: nowrap;
    }
    .ctl-btn{
        vertical-align: 12px;
    }
    .main{
        position: relative;
    }
    .ch-robot{
        position: absolute;
        right: -60px;
        top: 0;
        display: block;
        width: 50px;
        height: 77px;
        margin-bottom: 10px;
        background: url('https://t4.chei.com.cn/common/images/help/jqr.png') no-repeat;
    }
    .ch-robot:hover{
        background-position: -52px 0;
        text-decoration: none;
    }
    /*专业变化入口*/
    a.zybh-rk-btn{
        display:block;
        padding:3px;
        margin: 10px 10px 20px;
        border-radius: 6px;
    }
    /*毕业论文查重*/
    a.lwcc-rk-btn{
        display:block;
        margin: 5px 10px 10px;
    }
</style>
    <div class="outer-layer">
        <div class="outer-layer-content">
            










<link rel="stylesheet" href="https://t1.chei.com.cn/common/css/animate.css"> 
<img src="https://t1.chei.com.cn/common/wap/images/share_xxda.jpg?v=1477569249589" width='0' height='0' style='position: absolute;top:-100px;left: 0'/>
<style type="text/css">
    .header-nav .header-nav-bg{
        height: 220px;
    }
    .header-nav dd{
        height: 212px;
    }
</style>
<div class="header">
    <div class="width1180 clearfix">
        <div class="logo"><a href="https://my.chsi.com.cn/archive/index.jsp" target="_parent" class="home"></a></div>
        <div class='homePage-nav' style="margin-left:28px;">
            <a href="https://my.chsi.com.cn/archive/index.action?trnd=33051090315937502697498413722759">首页</a>
        </div>
        <div id="nav-first" class='header-nav'>
            <dl id="gdjy-nav">    
                <dt>高等教育信息<span class="sanjiao"></span></dt>
                <dd style='display: none'></dd>
            </dl>
            <dl id="bab-nav">    
                <dt>在线验证报告<span class="sanjiao"></span></dt>
                <dd style='display: none'></dd>
            </dl>
            <dl id="rzbg-nav">    
                <dt>学历学位认证与成绩验证<span class="sanjiao"></span></dt>
                <dd style='display: none'></dd>
            </dl>
            <dl id="gjhz-nav">    
                <dt>出国（境）报告发送<span class="sanjiao"></span></dt>
                <dd style='display: none'></dd>
            </dl>
            <dl>    
                <dt id="vote-nav">调查/投票<span class="sanjiao" style="left:46px;"></span></dt>
                <dd style='display: none'></dd>
            </dl>
            <dl>    
                <dt id="xz-nav"><a href="https://xz.chsi.com.cn/survey/index.action" class="xz-link" target="_blank">职业测评</a></dt>
                <dd style='display: none'></dd>
            </dl>
            <dl>    
                <dt id="ncss-nav"><a href="https://www.ncss.cn/" onmousedown="gaTrackerOutboundLink(this,'ncssindex', 'click', 'frommenu')" target="_blank"  class="jy-link">就业</a></dt>
                <dd style='display: none'></dd>
            </dl>
            <div class="header-nav-bg" style="display:none;">&nbsp;</div>
        </div>
        
        <div class="nav-userinfo">
            
                <div class=" btn-group">
                    <div class="user dropdown-toggle" data-toggle="dropdown"><i class="iconfont" title="个人中心" style="margin-right:0">&#xe647;</i><span class="caret"></span>
                    </div>
                    <ul class="dropdown-menu" role="menu">
                      <li><a href="https://account.chsi.com.cn/account/account!show" target="_blank" ><i class="iconfont" title="账号">&#xe645;</i>账号</a>
                      </li>
                      
                      <li><a href='javascript:void(0)' onclick="chsiLogout()"><i class="iconfont" title="退出">&#xe695;</i>退出</a></li>
                    </ul>
                </div>
            
            
        </div>
    </div>
</div>
<div  class="sub_nav"> 
    <div id="nav-second" class="width1180 clearfix">                                
        <ul class="sub_nav_mian" style='display:none'>
            <li>学籍信息/图像校对</li>
            <li>学历信息</li>
            <li>学位信息</li>
            <li>考研信息</li>
        </ul>
        <ul class="sub_nav_mian" style='display:none'>
            <li>首页</li>
            <li>高等学籍</li>
            <li>高等学历</li>
            <li>学位</li>
            <li>协助申请</li>
        </ul>
        <ul class="sub_nav_mian" style='display:none'>
            <li>首页</li>
            <li>绑定报告</li>
        </ul>
        <ul class="sub_nav_mian" style='display:none'>
            <li>首页</li>
            <li>传输费用</li>
            <li>英文翻译</li>
        </ul>
        <ul class="sub_nav_mian" style='display:none'>
            <li>首页</li>
            <li>跟踪调查</li>
            <li onmousedown="gaTrackerOutboundLink(this,'jygz', 'click', 'survey_jygz_menu')">就业跟踪</li>
            <li>专业推荐</li>
            <li>专业满意度</li>
            <li>院校满意度</li>
        </ul> 
        <ul class="sub_nav_mian" style='display:none'>
            <li><a href="https://xz.chsi.com.cn/home.action" target="_blank">首页</a></li>
            <li><a href="https://xz.chsi.com.cn/speciality/index.action" target="_blank">专业洞察</a></li>
            <li><a href="https://xz.chsi.com.cn/survey/index.action" target="_blank">职业测评</a></li>
            <li><a href="https://xz.chsi.com.cn/occupation/index.action" target="_blank">职业探索</a></li>
            <li><a href="https://xz.chsi.com.cn/occucase/index.action" target="_blank">职业人物</a></li>
            <li><a href="https://xz.chsi.com.cn/jyzdk/index.action" target="_blank">就业指导课</a></li>
        </ul>
        <ul class="sub_nav_mian" style='display:none'>
            <li><a href="https://www.ncss.cn/" onmousedown="gaTrackerOutboundLink(this,'ncssindex', 'click', 'frommenu')" target="_blank">首页</a></li>
            <li><a href="https://job.ncss.cn/student/jobs/index.html" onmousedown="gaTrackerOutboundLink(this,'ncsszw', 'click', 'frommenu')" target="_blank">职位</a></li>
            <li><a href="https://job.ncss.cn/student/company/index.html" onmousedown="gaTrackerOutboundLink(this,'ncssqy', 'click', 'frommenu')" target="_blank">企业</a></li>
            <li><a href="https://job.ncss.cn/student/jobfair/index.html" onmousedown="gaTrackerOutboundLink(this,'ncsszph', 'click', 'frommenu')" target="_blank">招聘会</a></li>
        </ul>
    </div>
</div>

<script>
var SpathMy = 'https://my.chsi.com.cn/archive/';
var SpathGaoKao = 'https://my.chsi.com.cn/zyzsk/';
</script>
<script src='https://t2.chei.com.cn/archive/js/common/header-menu-1.1.10.js'></script>

            <div class='main'>
                
                <a href="https://my.chsi.com.cn/archive/survey/shgl/show.action" id="shgldcId" target="_blank" class="vote-shgldc-banner"></a>                
                



















    <div id="surveyPicInfo" class="vote_part">
    </div>
    <script type="text/javascript">
        var position = 'pc_main';
        var qqFrom = "";
        $(function () {
            if( null != position && position != undefined ) {
                initCanShowSurveyType();
            }
        });
        function initCanShowSurveyType() {
            $.ajax({
                url : 'https://my.chsi.com.cn/archive/survey/zswj/show.action',
                method : 'POST',
                data : {
                    position : position
                },
                dataType: "json",
                success : function (resultData) {
                    if ( resultData.status == 0 && resultData.result!=null) {
                        var res = resultData.result;
                        if (res.shgldc) {
                            //显示上海问卷
                            var _url = '/archive/survey/shgl/show.action?from='+position;
                            $("#shgldcId").attr('href',_url);
                            $("#shgldcId").show();
                        }
                        if (res.surveyOne == null || res.surveyOne == undefined || res.surveyOne == '') {
                            return;
                        }
                        showSurvey(res);
                    }
                }
            });
        }
        /**
         * 显示问卷
         *
         * @param res     问卷信息
         *
         */
        function showSurvey(res) {

            var vote1,vote2;
            vote1 = dealVoteType(res.surveyOne);
            vote2 = dealVoteType(res.surveyTwo);
            // 设置顶部的banner 包括图片和链接
            setVoteBanner(vote1,vote2);

            // 就业问卷弹窗判断
            if (res.jySurvey == null || res.jySurvey == undefined) {
                return;
            }
            // 增加判断res.key没有值直接不弹窗
            if (res.key == null || res.key == undefined || res.key == '') {
                return;
            }
            var showTc = getSurveyTc(res.key);
            // 是否有弹窗问卷显示，有  请求问卷内容显示在弹窗里，没有就结束
            if (showTc) {
                var ajaxVote = dealVoteType(res.jySurvey);
                var _form= getSurveyFrom(res.jySurvey,true);
                $.ajax({
                    url:ajaxVote.ajaxUrl,
                    type:'POST',
                    data:{
                        id:res.id,
                        from:_form
                    },
                    success:function(dataValue) {
                        gaTrackerOutboundLink('',ajaxVote.type, 'load',_form);
                        layer.open({
                            type: 1,
                            title: false,
                            area: ['1000px', '650px'],
                            closeBtn: 0,
                            shadeClose: false,
                            skin: 'zydc_layer',
                            content: '<span class="closeVoteBtn" onclick="closeVoteTc()"><i class="iconfont" title="关闭">&#xe65c;</i></span><div id="vote_tc_survey" data-key="'+res.key+'">'+dataValue+'</div>'
                        });
                    }
                });
            }

        }
        // 根据类型判断问卷，返回相应的链接和图片
        /**
         *  @param type   问卷类型
         *  @return {}
         *  @return {className}// className图样式
         *  @return {bannerLink}// banner图链接
         *  @return {ajaxUrl}// ajax请求问卷地址（就业问卷需要layer弹出来显示，发出的地址）
         */
        function dealVoteType(type){
            var _surveyName = "",//问卷名称
                _prefixUrl = "",//仅是前缀，ajax里需要补充index.action,a链接需要补充show.action
                _className = "",//className 背景图样式
                _isJywj = false;//是否是就业类型问卷，链接需要拼接
            switch (type) {
                //就业类问卷
                case "gxbysgzbya":
                case "gxbysgzbyb":
                case "gxbysgzgza":
                case "gxbysgzgzb":
                    _surveyName = "高校毕业生跟踪调查问卷";
                    _prefixUrl = "/archive/survey/"+type+"/";
                    _className = "vote_bg_jygz";
                    _isJywj = true;
                    break;
                case "xyxxzk":
                    _surveyName = "高校校园学习状况调查";
                    _prefixUrl = "/archive/survey/campus/";
                    _className = "vote_bg_zxs";
                    _isJywj = true;
                    break;
                case "bysgzdc":
                    _surveyName = "高校毕业生跟踪调查问卷";
                    _prefixUrl = "/archive/survey/bygz/";
                    _className = "vote_bg_jygz";
                    _isJywj = true;
                    break;
                case "xsgz":
                    _surveyName = "高校学生跟踪调查问卷";
                    _prefixUrl = "/archive/survey/xsgz/";
                    _className = "vote_bg_jygz";
                    _isJywj = true;
                    break;
                case "jycyfw":
                    _surveyName = "2026届高校毕业生就业创业服务调查";
                    _prefixUrl = "/archive/survey/cyfw/";
                    _className = "vote_bg_cyfw";
                    _isJywj = true;
                    break;
                case "jyqw":
                    _surveyName = "2027届高校毕业生就业意愿调查";
                    _prefixUrl = "/archive/survey/jyqw/";
                    _className = "vote_bg_jyqw";
                    _isJywj = true;
                    break;    
                //满意度和学职链接 ,仅需要banner图和链接
                case "zytj":
                    //高考-专业推荐
                    _prefixUrl = "/zyzsk/zytj/recommendContinue.action";
                    _className = "vote_bg_zytj";
                    break;
                case "zymyd":
                    //高考-专业满意度
                    _prefixUrl = "/zyzsk/myd/specAppraisalWelcome.action";
                    _className = "vote_bg_zymyd";
                    break;
                case "yxmyd":
                    //高考-院校满意度
                    _prefixUrl = "/zyzsk/myd/schAppraisalWelcome.action";
                    _className = "vote_bg_yxmyd";
                    break;
                case "xzcp":
                    //学职系统的测评
                    _prefixUrl = "https://xz.chsi.com.cn/survey/index.action";
                    _className = "vote_bg_xzcp";
                    break;
                case "kzxz":
                    _prefixUrl = "https://xz.chsi.com.cn/cp/survey/yhdy4/show.action"
                    _className='vote_bg_kzxz';
                    break;
                case "zcsx":
                    _prefixUrl = "https://xz.chsi.com.cn/cp/survey/yhdy3/show.action"
                    _className='vote_bg_zcsx';
                    break;
                default:
            }
            var obj={
                className:_className,
                bannerLink:_prefixUrl,
                ajaxUrl:'',
                name:_surveyName,
                type:type
            }
            if(_isJywj){
                if(type=='xyxxzk'){
                    // 只有在校生问卷链接特殊，其他遵从一下规律
                    obj.ajaxUrl = _prefixUrl+'show.action';
                    obj.bannerLink = _prefixUrl+'index.action';
                }else{
                    obj.ajaxUrl = _prefixUrl+'index.action';
                    obj.bannerLink = _prefixUrl+'show.action';
                }
            }
            // 仅banner链接的from  弹窗一定是false
            obj.bannerLink = obj.bannerLink+"?from="+getSurveyFrom(type,false);
            return obj;
        }
        // 设置顶部问卷banner条-图片和链接
        function setVoteBanner(vote1,vote2){
            var tempHtml = '';
            tempHtml = '<a href="'+vote1.bannerLink+'" onmousedown="clickVoteGa(this,\''+vote1.type+'\')" target="_blank" class="'+vote1.className+'">'+vote1.name+'</a><a href="'+vote2.bannerLink+'" target="_blank"  onmousedown="clickVoteGa(this,\''+vote2.type+'\')"  class="'+vote2.className+'">'+vote2.name+'</a>';
            if($('#surveyPicInfo').length>0){
                $('#surveyPicInfo').addClass('vote_part_show').html(tempHtml);
            }            
        }
        function getSurveyFrom(type,showTc) {
            if ( position == "pc_main") {
                return showTc ? "archive-main-tc" : "archive-main";
            }
            if ( position == "pc_xj") {
                return type == "xyxxzk" ? "A" : "archive-xjxx";
            }
            if ( position == "pc_xl" ) {
                return "archive-xlxx";
            }
            if ( position == "pc_xlbab") {
                if(qqFrom){
                    return showTc ? qqFrom : qqFrom+'-banner';
                }else{
                    return showTc ? 'archive-xlbabtc' : 'archive-xlbab-banner';
                }
            }
        }
        function getSurveyTc(cookieName){
            // 是否显示弹窗【变量】逻辑开始（仅在首页和在线验证有此判断） ，key是cookie的name  如果没值  显示弹窗，
            var showTc =false;//默认先不显示
            if(cookieName){
                //就业类问卷才有cookieName，其他（满意度、学职）无
                var wjCookTc=getCookie(cookieName);
                if(!wjCookTc){
                    // 没值：1、设置值；2、显示弹窗。(有值的话，不显示弹窗)

                    showTc =true;
                }
            }
            return showTc;
        }
        function closeVoteTc(reloadFlag){
            // 关闭的话，增加cookie
            var cookieName = '';
            if(document.getElementById('vote_tc_survey')){
                cookieName = document.getElementById('vote_tc_survey').getAttribute('data-key');
            }
            if(cookieName){
                addCookie(cookieName,'true',7,'archive');
            }
            layer.closeAll();
            if(reloadFlag){
                window.location.reload();
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
        
    </script>

<div class="main-index clearfix">
    <div class="m-left index-left">
        <div class="index-main border-shadow ">
            <ul class="clearfix main-entry">
                <li class="i-m-top clearfix">
                    <div class="i-m-l"><span class="c-img"></span></div>
                    <div class="i-m-r">
                        <span>高等教育信息</span><br/>
                        <a href="https://my.chsi.com.cn/archive/gdjy/xj/show.action">学籍</a>　<a href="https://my.chsi.com.cn/archive/gdjy/xl/show.action">学历</a>　<a href="https://my.chsi.com.cn/archive/gdjy/xw/show.action">学位</a>
                    </div>
                </li>
                <li class="i-m-top clearfix">
                    <div class="i-m-l"><span class="c-img zxyz"></span></div>
                    <div class="i-m-r">
                        <span>在线验证报告</span><br/>
                        <a href="https://my.chsi.com.cn/archive/bab/index.action">查看</a>　<a href="https://my.chsi.com.cn/archive/bab/index.action">申请</a>
                    </div>
                </li>
                <li class="i-m-top clearfix">
                    <div class="i-m-l"><span class="c-img xlrz"></span></div>
                    <div class="i-m-r">
                        <span>学历学位认证与成绩验证</span><br/>
                        <a href="https://my.chsi.com.cn/archive/rzbg/index.action">查看</a>
                    </div>
                </li>
                <li class="i-m-top clearfix">
                    <div class="i-m-l i-m-l4"><span class="c-img gjhz"></span></div>
                    <div class="i-m-r">
                        出国（境）报告发送<br/>
                        <a href="https://my.chsi.com.cn/archive/gjhz/index.action">查看</a>　<a href="https://my.chsi.com.cn/archive/gjhz/apply.action">发送报告</a>　<a href="https://my.chsi.com.cn/archive/gjhz/foreign/index.action">翻译件</a>
                    </div>
                </li>
                <li class="i-m-top i-m-no-right clearfix">
                    <div class="i-m-l i-m-l6"><span class="c-img txjd"></span></div>
                    <div class="i-m-r">
                        毕业证书图像校对<br/>
                        <a href="https://my.chsi.com.cn/archive/gdjy/xj/show.action">校对</a>
                    </div>
                </li>
                <li class="i-m-bom clearfix">
                    <div class="i-m-l i-m-l4"><span class="c-img ncss"></span></div>
                    <div class="i-m-r">
                        就业<br/>
                        <a href="https://www.ncss.cn/" onmousedown="gaTrackerOutboundLink(this,'ncssindex', 'click', 'fromIndexMenu')"  target="_blank">求职招聘</a>
                    </div>
                </li>
                <li class="i-m-bom clearfix">
                    <div class="i-m-l i-m-l5"><span class="c-img vote"></span></div>
                    <div class="i-m-r">
                        学校满意度<br/>
                        <a href="https://my.chsi.com.cn/archive/survey/index.action">参与投票</a>
                    </div>
                </li>
                <li class="i-m-bom clearfix">
                    <div class="i-m-l i-m-l4"><span class="c-img xzpt"></span></div>
                    <div class="i-m-r">
                        个人测评<br/>
                        <a href="https://xz.chsi.com.cn/survey/index.action" target="_blank">进入</a>
                    </div>
                </li>
                <li class="i-m-bom clearfix">
                    <div class="i-m-l i-m-l4 main-sqjh"><span class="c-img sqjh"></span><span id="sqNum" class="sq-num" style="display: none;"></span></div>
                    <div class="i-m-r">
                        “双千” 计划 “微专业”<br/>
                        <a href="https://my.chsi.com.cn/archive/gdjy/wzy/show.action">查看</a>　<a href="https://my.chsi.com.cn/archive/bab/wzy/show.action">查看备案表</a>
                    </div>
                </li>
            </ul>
        </div>
    </div>
    <div class="m-right index-right border-shadow marginB0" id="xzpt_survey"></div>
    <div class="clearFloat"></div>
</div>







<div id="zwtjContainer" class="ncss-container border-shadow marginB0" style="display: none;">
    <div class="ncss-tit">
        你想求职吗？这里有适合你的职位
        <div class="right">　
            <a href="javascript:;" id="nextPage">换一批</a>　|　<a href="https://job.ncss.cn/student/jobs/index.html" onmousedown="gaTrackerOutboundLink(this,'ncsszw', 'click', 'fromzwtj')" target="_blank">更多</a>
        </div>
    </div>
    <img class="ncss-loading" src="https://t1.chei.com.cn/common/images/loading-dot.gif" style="display: none;">
    <div id="zwtjContainerInfo" class="ncss-list clearfix">

    </div>
</div>
<script type="text/javascript">
    var offset = 1,isChangFlag = true,zwtjTimer = null;
    queryZw(null);
    $(function(){
        $("#nextPage").click(function () {
            if(isChangFlag){
                isChangFlag = false;
                queryZw(null);
            }
            return false;
        });
    });

    function queryZw(taskId) {
        //TODO 此处需要增加loading效果
        $(".ncss-loading").show();
        closedTimer();
        $.ajax({
            url : 'https://my.chsi.com.cn/archive/ncss/zwtj/query.action',
            method : 'GET',
            data : {
                offset : offset,
                taskId : taskId
            },
            dataType: "json",
            success : function (resultData) {
                if (resultData.status === 1) {
                    $("#zwtjContainer").hide();
                    closedTimer();
                    return;
                }
                if (resultData.result.finished) {
                    isChangFlag = true;
                    offset = resultData.result.offset + 1;
                    closedTimer();
                    $(".ncss-loading").hide();
                    var jobData = resultData.result.jobData;
                    if ( null == jobData || null == jobData.jobs ) {
                        $("#zwtjContainerInfo").html("");
                        $("#zwtjContainer").hide();
                        return;
                    }
                    var jobArr = jobData.jobs;
                    var temp = "";
                    for (var i = 0; i < jobArr.length; i++) {
                        var job = jobArr[i];
                        temp += "<a href='"+job.jobURL +"'  onmousedown=\"gaTrackerOutboundLink(this,'ncsszw', 'click', 'fromzwtj')\"   target='_blank'>";
                        temp += "<dl> <dt class='img-box'>";
                        if ( job.recLogoURL =="" || job.recLogoURL==null ) {
                            temp += "<img class='job-icon'  src='https://t1.chei.com.cn/ncss/student/img/job/com-head.jpg'>";
                        } else {
                            temp += "<img src='"+job.recLogoURL+"'>";
                        }
                        temp += "</dt><dd><h4>"+job.jobName+"</h4>";
                        temp += "<p class'company-type'>"+job.lowMonthPay+"K-"+job.highMonthPay+"K&ensp;/&ensp;"+job.degreeName+"</p></dd></dl></a>";
                    }
                    $("#zwtjContainerInfo").html(temp);
                    $("#zwtjContainer").show();
                } else {
                    getQueryProgress(resultData.result.taskId);
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown){
                closedTimer();
            }
        });
    }
    function getQueryProgress(taskId) {
        $.ajax({
            url: 'https://my.chsi.com.cn/archive/asyn/progress.do',
            type: 'POST',
            data: {
                taskId: taskId
            },
            dataType:'json',
            success: function (data) {
                switch (data.state) {
                    case "wait":
                        zwtjTimer = setTimeout(function () {
                            getQueryProgress(taskId);
                        }, 3000);
                        break;
                    case "success":
                        queryZw(taskId);
                        closedTimer();
                        break;
                    default:
                        closedTimer();
                }
            },
            error: function(){
                closedTimer();
            }
        });
    }
    function closedTimer(){
        clearTimeout(zwtjTimer);
        zwtjTimer = null;
    }
</script>
<script type="text/javascript">
        $(function(){
            rcdSurvey();
        });
        function rcdSurvey() {
            $.ajax({
                url:'/archive/survey/xzpt/rcd.action',
                type:'POST',
                success:function(dataValue) {
                    $('#xzpt_survey').html(dataValue);
                }
            });
        }
    </script>

            </div>
        </div>
    </div>
    







<div class="footer">
    <a href="https://www.chsi.com.cn/" target="_blank">学信网</a>　|　<a href="https://my.chsi.com.cn/archive/help/index.action" target="_blank">帮助中心</a>　|　Copyright © 2003-2026 学信网 All Rights Reserved<br/>
    <a href="https://beian.miit.gov.cn" target="_blank">京ICP备19004913号-1</a>　<a href="https://www.beian.gov.cn/portal/registerSystemInfo?recordcode=11010202009747" target="_blank" ><img src='https://t3.chei.com.cn/chsi/images/jgwab.svg' style="vertical-align: middle;margin-bottom: 2px;margin-left: 8px;" /> 京公网安备11010202009747号</a>
</div>    
    <div id="loader"></div>
<script type="text/javascript" src='https://t1.chei.com.cn/common/plugins/validation/jquery.validate.min.js'></script>
<script type="text/javascript" src='https://t2.chei.com.cn/archive/js/jquery/jquery.form.js'></script>
<script type="text/javascript" src='https://t1.chei.com.cn/common/bootstrap3.3.5/js/bootstrap.min.js'></script>
<script type="text/javascript" src='https://t1.chei.com.cn/common/bootstrap-datetimepicker-v3/bootstrap-datetimepicker.min.js'></script>
<script type="text/javascript" src='https://t1.chei.com.cn/common/ch/browser/not-ie.min.js'></script>
<link rel="stylesheet" href='https://t2.chei.com.cn/archive/js/webuploader/webuploader.css' />
<script src='https://t4.chei.com.cn/archive/js/webuploader/webuploader.js'></script>

</body>
</html>