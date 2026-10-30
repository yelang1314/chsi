
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
    // 本地化：未登录直接访问，跳转登录页
    if (document.cookie.indexOf('chsi_login=') === -1) {
        window.location.href = '/archive/login.jsp?redirect=/archive/wap/gdjy/index.jsp';
    }
</script>
</head>
<body>
    <div id="app" class="my-container" v-cloak>
<van-nav-bar
  class="green-header"  
  :title="typeof(greenTit)=='undefined'?'':greenTit"
  left-text=""
  left-arrow
  @click-left="onClickLeft"
></van-nav-bar>
<div v-if="resultJson.status===0" class="vote-part">
    <!--移动端-->
    <div id="vote_wap" style="display:none"></div>
    <script type="text/javascript">
        var position = 'wap_xjxl';
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
<div v-if="showLoading" style="display: flex;justify-content: center;padding: 1rem;"  >
    <van-loading  size="1rem" vertical></van-loading>
</div>
<div class="padding16 xjxl-list chsi-font" v-cloak v-if="resultJson.status===0">
    <van-row class="list-tit">
      <van-col span="8" class="l">学籍信息 <template v-if="resultJson.xj.amount>0">({{resultJson.xj.amount}})</template>
      </van-col>
      <van-col span="16" class="r">还有学籍没有显示出来？<a href="javascript:;" @click="findXj">尝试绑定</a>
      </van-col>
    </van-row>
    <template v-if="resultJson.xj.amount>0">   
        <template v-for="(item,index) in resultJson.xj.dataList">
            <div class="xj list-card">
                <a :href="'/archive/wap/gdjy/xj/detail.jsp?id='+item.id">
                    <div class="yxmc-wrap">
                        <div class="yxmc">{{item.yxmc}}</div>
                        <div class="cc">{{item.cc}}</div>
                    </div>                    
                    <div class="des">{{item.zymc}}　|　{{item.xxxs}}</div>
                </a>       
            </div>           
        </template>
    </template>
    <template v-else>
        <div class="no-data">
            <h4>没有找到您的学籍信息 <a href="https://www.chsi.com.cn/help/cxfw.jsp" target="_blank"><i class="iconfont" title="查看">&#xe63b;</i></a></h4>
            <div class="find-xjxl" :class="{'find-xjxl-show':noXjUp }"> 
                <van-row class="find-list">
                    <van-col span="2">
                      <span>1</span>
                    </van-col>
                    <van-col span="16" class="paddL2">
                       有学籍但是没显示出来
                    </van-col>
                    <van-col span="6" class="list-link">
                      <a href="javascript:;" @click="findXj">自行绑定</a>
                    </van-col>
                </van-row> 
                <van-row class="find-list">
                    <van-col span="2" >
                        <span>2</span>
                    </van-col>
                    <van-col span="22" class="paddL2">
                        确认您实名注册时提供的姓名和证件号码是否与学校注册信息一致，若不一致，请分情况处理。
                        <van-row class="find-list-smzc">                        
                            <van-col span="18">
                              <p>姓名</p>
                              <h5>{{resultJson.xj.xm}}</h5>
                            </van-col>
                            <van-col span="6" class="list-link paddT11">
                              <a href="https://account.chsi.com.cn/account/account!editinfo" target="_blank">修改</a>
                            </van-col>
                        </van-row>
                        <van-row>
                            <van-col span="18">
                                <p>证件号码</p>
                                <h5>{{resultJson.xj.zjhm}}</h5>
                            </van-col>
                            <van-col span="6" class="list-link paddT11">
                                <a href="https://account.chsi.com.cn/account/preregister.action?from=my-noxlarch" target="_blank">重新注册</a>
                            </van-col>
                        </van-row>
                    </van-col>
                </van-row>
                <van-row class="find-list">
                    <van-col span="2">
                        <span>3</span>
                    </van-col>
                    <van-col span="22" class="paddL2">
                        若不能确定学校注册信息，请与就读院校学籍学历管理部门老师联系。
                    </van-col>
                </van-row>
            </div>
            <div class="find-xjxl-bottom" @click="noXjUp=!noXjUp">                
                <template v-if="noXjUp">
                    收起 <i class="iconfont" title="收起">&#xe602;</i>
                </template>
                 <template v-else>
                    <span class="colorGreen">查看解决办法 <i class="iconfont" title="展开">&#xe600;</i></span>
                </template>                
            </div>
        </div>
    </template>
    <van-row class="list-tit">
        <van-col span="8" class="l">学历信息 <template v-if="resultJson.xl.amount>0">({{resultJson.xl.amount}})</template>
        </van-col>
        <van-col span="16" class="r">还有学历没有显示出来？<a href="javascript:;" @click="findXl">尝试绑定</a>
        </van-col>
    </van-row>
    <template v-if="resultJson.xl.amount>0"> 
        <template v-for="(item,index) in resultJson.xl.dataList">
            <div class="xl list-card" >
                <a :href="'/archive/wap/gdjy/xl/detail.jsp?id='+item.id">
                    <div class="yxmc-wrap">
                        <div class="yxmc">{{item.yxmc}}</div>
                        <div class="cc">{{item.cc}}</div>
                    </div>                    
                    <div class="des">{{item.zymc}}<template v-if="item.xxxs">　|　{{item.xxxs}}</template></div>
                </a>
                <span class="xlzms" v-if="item.xlzms">学历证明书</span>             
            </div>
        </template>
    </template>
    <template v-else>
        <div class="no-data">
            <h4>没有找到您的学历信息 <a href="https://www.chsi.com.cn/help/cxfw.jsp" target="_blank"><i class="iconfont" title="查看">&#xe63b;</i></a></h4>
            <div class="find-xjxl" :class="{'find-xjxl-show':noXlUp }"> 
                <van-row class="find-list">
                    <van-col span="2">
                      <span>1</span>
                    </van-col>
                    <van-col span="16" class="paddL2">
                       有学历但是没显示出来
                    </van-col>
                    <van-col span="6" class="list-link">
                      <a href="javascript:;" @click="findXl">自行绑定</a>
                    </van-col>
                </van-row> 
                <van-row class="find-list">
                    <van-col span="2" >
                        <span>2</span>
                    </van-col>
                    <van-col span="22" class="paddL2">
                        确认您实名注册时提供的姓名和证件号码是否与学校注册信息一致，若不一致，请分情况处理。
                        <van-row class="find-list-smzc">    
                            <van-col span="18">
                              <p>姓名</p>
                              <h5>{{resultJson.xl.xm}}</h5>
                            </van-col>
                            <van-col span="6" class="list-link paddT11">
                              <a href="https://account.chsi.com.cn/account/account!editinfo" target="_blank">修改</a>
                            </van-col>                            
                        </van-row>
                        <van-row>
                            <van-col span="18">
                              <p>证件号码</p>
                              <h5>{{resultJson.xl.zjhm}}</h5>
                            </van-col>
                            <van-col span="6" class="list-link paddT11">
                              <a href="https://account.chsi.com.cn/account/preregister.action?from=my-noxlarch" target="_blank">重新注册</a>
                            </van-col>
                        </van-row>
                    </van-col>
                </van-row>
                <van-row class="find-list">
                    <van-col span="2">
                        <span>3</span>
                    </van-col>
                    <van-col span="22" class="paddL2">
                        若不能确定学校注册信息，请与就读院校学籍学历管理部门老师联系。
                    </van-col>
                </van-row>
            </div>
            <div class="find-xjxl-bottom" @click="noXlUp=!noXlUp">               
                <template v-if="noXlUp">
                    收起 <i class="iconfont" title="收起">&#xe602;</i>
                </template>
                <template v-else>
                    <span class="colorGreen">查看解决办法 <i class="iconfont" title="展开">&#xe600;</i></span>
                </template>                
            </div>
        </div>
    </template>
    <van-row class="list-tit">
        <van-col span="8" class="l">学位信息 <template v-if="resultJson.xw.amount>0">({{resultJson.xw.amount}})</template>
        </van-col>
        <van-col span="16" class="r">还有学位没有显示出来？<a href="javascript:;" @click="findXw">尝试绑定</a>
        </van-col>
    </van-row>
    <template v-if="resultJson.xw.amount>0"> 
        <template v-for="(item,index) in resultJson.xw.dataList">
            <div class="xw list-card">
                <a :href="'https://my.chsi.com.cn/archive/wap/gdjy/xw/detail.action?id='+item.id">
                    <div class="yxmc-wrap">
                        <div class="yxmc">{{item.xwsydw}}</div>
                        <div class="cc">{{item.cc}}</div>
                    </div>                    
                    <div class="des">{{item.xwlb}}</div>                   
                </a>        
            </div>
            <div class="list-card no-pic" v-else>
                <span class="error-pic"></span>档案信息加载失败
            </div>
        </template>
    </template>
    <template v-else>
        <div class="no-data">
            <h4 style="padding: 0 .3rem;">您还未绑定学位信息，可以使用“尝试绑定学位”功能绑定您的学位 <a href="https://www.chsi.com.cn/help/cxfw.jsp" target="_blank"><i class="iconfont" title="查看">&#xe63b;</i></a></h4>
            <div class="find-xjxl" :class="{'find-xjxl-show':noXwUp }"> 
                <van-row class="find-list">
                    <van-col span="2">
                      <span>1</span>
                    </van-col>
                    <van-col span="22" class="paddL2">
                        本系统提供社会查询的学位证书数据来源于相关学位授予单位经所在省（自治区、直辖市）学位委员会办公室报国务院学位委员会办公室备案的学位授予数据。
                    </van-col>
                </van-row> 
                <van-row class="find-list">
                    <van-col span="2" >
                        <span>2</span>
                    </van-col>
                    <van-col span="22" class="paddL2">
                        请确保注册账号的“姓名”及“证件号码”无误，且对应的学位信息属于本系统<a href='https://www.chsi.com.cn/help/cxfw.jsp' target="_blank">查询范围</a>，若您未成功绑定学位信息，请与有关学位授予单位的学位管理部门联系核实。
                    </van-col>
                </van-row>
                <van-row class="find-list">
                    <van-col span="2">
                        <span>3</span>
                    </van-col>
                    <van-col span="22" class="paddL2">
                        经核实后属学位授予信息漏报、错报的，由学位授予单位依照“学位授予信息补报、修改流程”更正相关内容。本网站无权修改任何数据。
                    </van-col>
                </van-row>
            </div>
            <div class="find-xjxl-bottom" @click="noXwUp=!noXwUp">               
                <template v-if="noXwUp">
                    收起 <i class="iconfont" title="收起">&#xe602;</i>
                </template>
                <template v-else>
                    <span class="colorGreen">提示信息 <i class="iconfont" title="展开">&#xe600;</i></span>
                </template>                
            </div>
        </div>
    </template>
    <van-row class="list-tit">
      <van-col span="24" class="l">考研信息 <template v-if="resultJson.ky.amount>0">({{resultJson.ky.amount}})</template>
      </van-col>
    </van-row>
    <template v-if="resultJson.ky.amount>0">
        <template v-for="item in resultJson.ky.dataList">
            <a :href="'https://my.chsi.com.cn/archive/wap/gdjy/ky/detail.action?id='+item.id" > 
                <div class="ky list-card" >
                    <div class="yxmc">{{item.yxmc}}</div>
                    <div class="des">{{item.lqnf}}年</div> 
                </div>
            </a>
        </template>
    </template>
    <template v-else>
        <div class="no-data list-card">
            <div class="yxmc">您没有考研信息！</div>
            <div class="des">您目前没有考研信息，系统提供2006年以来入学的硕士研究生报名和成绩数据。</div>
        </div>
    </template>
<van-popup v-model="xj.flag" class="width90 xj-bind-model">
  <div class="my-dialog">
    <span class="close" @click="closeBind('xj')"><van-icon name="cross"></van-icon></span>
    <h3>学籍绑定</h3>
    <div class="error-tip" v-if="xj.errorObj.flag">{{xj.errorObj.errorMsg}}　<template v-if="xj.errorObj.limitNum>0">您还可尝试 {{xj.errorObj.limitNum}} 次</template></div>
      <div class="dialog-mian bind-main" >
        <van-cell-group>
          <van-field
            v-model="xj.xh"
            required
            clearable
            label="学号"
            placeholder="请输入学号"
          >
          </van-field>
          <van-field
            v-model="xj.yxmc"
            required
            clearable
            label="学校名称"
            placeholder="请输入学校名称"
          >
          </van-field>
          <van-field
            v-model="xj.rxnf"
            required
            clearable
            label="入学年份"
            name="入学年份" 
            placeholder="必须为4位数字"
          >
          </van-field>
          <van-field
            v-model="xj.cc"
            required
            clearable
            label="层次"
            readonly
            @click="bindCc.flag = true"
            placeholder="请选择层次"
          >
          </van-field>
        </van-cell-group>
        <ul>
          <li><i class="iconfont">&#xe6b0;</i>本功能用于查找、绑定<a href="https://www.chsi.com.cn/help/cxfw.jsp" target="_blank">学籍查询范围</a>内无法根据实名注册信息自动匹配的学籍。</li>
          <li><i class="iconfont">&#xe6b0;</i>您只有5次机会，请确认输入的内容与本人的学籍信息完全一致。</li>
          <li><i class="iconfont">&#xe6b0;</i>如果查不到本人的学籍，请联系就读院校学籍管理部门。</li>
          <li><i class="iconfont">&#xe6b0;</i>如果不知道学号，请联系就读院校学籍管理部门。</li>
        </ul>
        </div>
        <van-row class="dialog-bottom">
          <van-col span="11"><van-button type="default" @click="closeBind('xj')">取消</van-button></van-col>
          <van-col span="11"  offset="2"><van-button :loading='xjBindBtnStatus'  @click="findXjSubmit" type="primary">确认</van-button></van-col>
        </van-row>
  </div> 
</van-popup>
<van-popup class="width100-model" v-model="bindCc.flag" position="bottom">
  <van-picker  
    show-toolbar
    title="层次"
    :columns="bindCc.columns"
    @cancel="bindCc.flag=false"
    @confirm="bindCcConfirm"
  >
  </van-picker>
</van-popup>
<van-popup v-model="xl.flag" class="width90 xj-bind-model">
  <div class="my-dialog">
    <span class="close" @click="closeBind('xl')"><van-icon name="cross"></van-icon></span>
    <h3>学历绑定</h3>
    <div class="error-tip" v-if="xl.errorObj.flag">{{xl.errorObj.errorMsg}}　<template v-if="xl.errorObj.limitNum>0">您还可尝试 {{xl.errorObj.limitNum}} 次</template></div>
      <div class="dialog-mian bind-main" >
        <van-cell-group>
          <van-field
            v-model="xl.zsbh"
            required
            clearable
            label="证书编号"
            placeholder="请输入证书编号"
          >
          </van-field>
          <van-field
            v-model="xl.bynf"
            required
            clearable
            label="毕业年份"
            placeholder="请选择毕业年份"
            readonly
            @click="bindBynf.flag = true"
          >
          </van-field>
          <van-field
            v-model="xl.yxmc"
            required
            clearable
            label="学校名称"
            placeholder="请输入学校名称"
          >
          </van-field>
        </van-cell-group>
        <ul>
          <li><i class="iconfont">&#xe6b0;</i>学信档案会根据您的实名注册信息自动尝试绑定学历（<a href="https://www.chsi.com.cn/help/cxfw.jsp" target="_blank">学历查询范围</a>）。</li>
          <li><i class="iconfont">&#xe6b0;</i>若您的实名注册信息正确，但仍有学历没有显示出来，可以在此尝试自行绑定。</li>
          <li><i class="iconfont">&#xe6b0;</i>请确认输入的内容与您本人的学历证书完全一致。早期证书上可能有多个编号（学校编号、证书编号或流水号），可以都尝试一下。</li>
          <li><i class="iconfont">&#xe6b0;</i>如果仍然无法绑定您的学历，请联系就读院校学籍管理部门。</li>
        </ul>
        </div>
        <van-row class="dialog-bottom">
          <van-col span="11"><van-button type="default"  @click="closeBind('xl')">取消</van-button></van-col>
          <van-col span="11"  offset="2"><van-button :loading='xlBindBtnStatus' @click="findXlSubmit" type="primary">确认</van-button></van-col>
        </van-row>
  </div> 
</van-popup>
<van-popup class="width100-model" v-model="bindCc.flag" position="bottom">
  <van-picker  
    show-toolbar
    title="层次"
    :columns="bindCc.columns"
    @cancel="bindCc.flag=false"
    @confirm="bindCcConfirm"
  >
  </van-picker>
</van-popup>
<van-popup class="width100-model" v-model="bindBynf.flag" position="bottom">
  <van-picker  
    show-toolbar
    title="毕业年份"
    :columns="bindBynf.columns"
    @cancel="bindBynf.flag=false"
    @confirm="bindBynfConfirm"
  >
  </van-picker>
</van-popup>
<van-popup v-model="xw.flag" class="width90 xj-bind-model">
  <div class="my-dialog">
    <span class="close" @click="closeBind('xw')"><van-icon name="cross"></van-icon></span>
    <h3>学位绑定</h3>
    <div class="error-tip" v-if="xw.showErrMsg">
      <div style="text-align:left;line-height:1.66;padding:0.427rem">
        学位信息绑定不成功，可能有以下几个问题：<br/>
        1. 2008年9月1日之前获取的学位证书，建议申请学位认证。<br/>
        2. 2008年9月1日以来获取的学位证书，建议咨询学位授予单位。
      </div>
    </div>
    <div class="dialog-mian bind-main" >
      <van-cell-group>
        <van-field
          v-model="xw.zsbh"
          required
          clearable
          label="证书编号"
          placeholder="请输入证书编号"
        >
        </van-field>
      </van-cell-group>
      <ul>
        <li><i class="iconfont">&#xe6b0;</i>请确认输入的内容与您本人的学位证书完全一致，且对应的学位信息应属于本系统<a href='https://www.chsi.com.cn/help/cxfw.jsp' class="cxfw" target="_blank">查询范围</a>。</li>
        <li><i class="iconfont">&#xe6b0;</i>如果仍然无法绑定您的学位，请联系学位授予单位。</li>
      </ul>
      </div>
      <van-row class="dialog-bottom">
        <van-col span="11"><van-button type="default"  @click="closeBind('xw')">取消</van-button></van-col>
        <van-col span="11"  offset="2"><van-button :loading='xw.bindBtnStatus' @click="findXwSubmit" type="primary">确认</van-button></van-col>
      </van-row>
  </div> 
</van-popup>
<van-dialog
    v-model="showZxsTipsFlag"
>
  <div class="dialog-tip-div">
    <h3>没有学籍</h3>
    系统没有找到您的在校生学籍信息，有可能是因为您注册时填写的姓名和证件号码两项与学校上报的学籍注册数据不相同导致的。<br/><br/>
    1、查看您注册时填写的姓名和证件号码信息 <a href="https://account.chsi.com.cn/account/account!show" target="_blank">点击查看</a><br/>
    2、姓名和证件号码无误，我还有学籍没显示出来 <a href="javascript:;" @click="findXj" >找找看？</a>
  </div>
</van-dialog>
</div>
<script>
      var mixin = {
        data:function(){
            return {
                activeBottom:0,
                noXjUp:false,//没有学籍，展开处理办法
                noXlUp:false,//没有学历，展开处理办法
                noXwUp:false,//没有学位，展开处理办法
                greenTit:'高等教育信息',
                xj:{ //学籍找找看相关数据
                  flag:false,
                  xh:'',
                  yxmc:'',
                  rxnf:'',
                  cc:'',
                  errorObj:{
                    flag:false,
                    errorMsg:'',
                    limitNum:0
                  }
                },
                xjBindBtnStatus:false, //学籍绑定提交按钮是否有loading效果
                xjBindBtnClick:true,//防止点击过快
                xlBindBtnStatus:false, //学历绑定提交按钮是否有loading效果
                xlBindBtnClick:true,//防止点击过快
                xl:{ //学历找找看相关数据
                  flag:false,
                  zsbh:'',
                  bynf:'',
                  yxmc:'',
                  errorObj:{
                    flag:false,
                    errorMsg:'',
                    limitNum:0
                  }
                },
                bindCc:{
                  flag:false,
                  columns:['博士研究生','硕士研究生','本科','专科','第二学士学位']
                },
                bindBynf:{
                  flag:false,
                  columns:[]
                },
                showZxsTipsFlag:false,//在校生弹层
                resultJson:{},
                xw:{ //学位找找看相关数据
                  flag:false,
                  zsbh:'',
                  errorObj:{
                    flag:false,
                    errorMsg:'',
                    limitNum:0
                  },
                  showErrMsg:false,
                  bindBtnStatus:false, //学位绑定提交按钮是否有loading效果
                  bindBtnClick:true,//防止点击过快
                  showLoading:false
                }
            }
        },
        created:function(){ 
            this.getData(); 
        },
        methods:{
            getData:function(){
                const api2 = new API({
                    resPage: false, //当为true时，不再返回轮询结果
                    resType: 'json', //对请求结果的处理方式，默认：json，默认：json, 表示轮询结果格式为json
                    taskUrl: "/archive/gdjy/search.action", //默认：''，注意：当为空时，则不会进入轮询
                    pollingUrl: "/archive/asyn/progress.do", //默认：''，注意：当为空时，不会进入轮询
                    pollingLimit: 20, // 请求的最大次数，默认：10次
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
                var _this = this;
                _this.showLoading = true; //loading效果
                api2.syncAjax('post', '/archive/wap/gdjy/search.action').then(function(res){
                    _this.showLoading = false;
                    if(res.flag){
                        if(res.data.limit){
                            // 限制访问了
                            window.location.href="https://my.chsi.com.cn/archive/gdjy/check/show.action?from=w-xjxl";
                        }else{
                            _this.resultJson = res.data;
                            _this.resultJson.status = 0;
                            if(_this.resultJson.xj.showZxsTips){ //在校生没有学籍第一次登陆进来提示框
                                _this.showZxsTipsFlag =true;
                            } 
                            // 本地化修复：等 vote_wap 渲染完成后再拉取问卷 banner，
                            // 避免 window.onload 与 Vue 渲染的时序竞争导致 setVote 找不到 dom
                            _this.$nextTick(function(){
                                if(typeof getVoteInfo === 'function'){ getVoteInfo(); }
                            });
                        }
                    }else{
                        _this.$dialog.alert({
                            title: '提示',
                            message: res.errorMessage?res.errorMessage:res.msg,
                            confirmButtonText: '确定'
                        }).then(() => {
                            window.location.reload();
                        });
                    }
                }).catch(function(error){
                    _this.showLoading = false;
                    _this.$dialog.alert({
                        title: '提示',
                        message: '请刷新重试!',
                        confirmButtonText: '确定'
                    }).then(() => {
                        window.location.reload();
                    });
                });
            },
            findXj:function(){ //学籍找找看
                this.showZxsTipsFlag =false;//可能从在校生提示进来，所以关闭那个在校生找学籍的提示层
                this.xj.flag=true;
            },
            findXl:function(){    //学历找找看            
                if(this.bindBynf.columns.length==0){ //初始化年份
                    var nowYear =new Date().getFullYear();
                    for(var i=2001;i<=nowYear;i++){
                        this.bindBynf.columns.push(i);
                    }
                }
                this.xl.flag=true;
            },
            findXw:function(){ //学位找找看
                this.xw.flag=true;   
                this.xw.zsbh='';
                this.xw.errorObj.flag =false;  
                this.xw.showErrMsg=false;                     
            },
            closeBind:function(type){ //关闭绑定弹层，清除数据
                if(type=='xj'){
                    this.xj.flag=false;
                    this.xj.xh='';
                    this.xj.yxmc='';
                    this.xj.rxnf='';
                    this.xj.cc='';
                    this.xl.errorObj.flag =false;
                }
                if(type=='xl'){
                    this.xl.flag=false;
                    this.xl.zsbh='';
                    this.xl.bynf='';
                    this.xl.yxmc='';
                    this.xl.errorObj.flag =false;               
                }
                if(type=='xw'){
                    this.xw.flag=false;
                    this.xw.zsbh='';
                    this.xw.errorObj.flag =false;  
                    this.xw.showErrMsg=false;             
                }
            },
            findXjSubmit:function(){ //学籍找找看提交
                var _this =this,
                    xh = this.trimSpace(this.xj.xh),
                    yxmc = this.trimSpace(this.xj.yxmc),
                    rxnf = this.trimSpace(this.xj.rxnf),
                    cc = this.trimSpace(this.xj.cc);
                if(xh==""){
                    this.$toast('学号不能为空');
                    return;
                }
                if(yxmc==""){
                    this.$toast('学校名称不能为空');
                    return;
                }
                if(yxmc.length<4){
                    this.$toast('学校名称的长度不能小于4');
                    return;
                }
                if(yxmc.length>30){
                    this.$toast('学校名称不能超过30个字符长度');
                    return;
                }
                if(rxnf==""){
                    this.$toast('入学年份不能为空');
                    return;
                }
                if(!(rxnf.length==4 && /^[0-9]+$/.test(rxnf))){
                    this.$toast('请输入有效的年份信息，如：2018');
                    return;
                }
                if(cc==""){
                    this.$toast('请选择层次');
                    return;
                }
                var postData = {
                    xh:xh,//学号
                    yxmc:yxmc,//院校名称
                    rxnf:rxnf,//入学年份
                    cc:cc//层级
                };
                if(_this.xjBindBtnClick){
                    _this.xjBindBtnClick = false;
                    setTimeout(function(){ 
                        _this.xjBindBtnClick = true;
                    }, 5000); 
                    _this.xjBindBtnStatus = true; //按钮loading效果
                    api.syncAjax('post', '/archive/wap/gdjy/xj/bindxj.action', { data: postData }).then(function(res){
                        _this.xj.errorObj.flag =false;
                        _this.xjBindBtnStatus = false; //按钮loading效果
                        if (res.status==0) {
                            _this.$toast('绑定成功');
                            setTimeout(function(){
                                window.location.reload();
                            },1000)
                        }else{
                            if(res.result.isParamError){
                                var msg ='';
                                if(res.result.cc && res.result.cc.length>0){
                                    msg = res.result.cc;
                                }
                                if(res.result.rxnf && res.result.rxnf.length>0){
                                    msg = res.result.rxnf;
                                }
                                if(res.result.yxmc && res.result.yxmc.length>0){
                                    msg = res.result.yxmc;
                                }
                                if(res.result.xh && res.result.xh.length>0){
                                    msg = res.result.xh;
                                }
                                _this.$toast(msg);
                            }else{
                                _this.xj.errorObj={
                                    flag:true,
                                    errorMsg:res.result.errorMsg,
                                    limitNum:res.result.limitNum
                                }
                            }
                        } 
                    });               
                }else{
                    this.$toast('操作过于频繁，请稍后再试');
                }
            },
            findXlSubmit:function(){ //学历找找看提交
                var _this =this,
                    zsbh = this.trimSpace(this.xl.zsbh),
                    // bynf = this.trimSpace(this.xl.bynf),
                    bynf = this.xl.bynf,
                    yxmc = this.trimSpace(this.xl.yxmc);
                if(zsbh==""){
                    this.$toast('证书编号不能为空');
                    return;
                }
                if(bynf==""){
                    this.$toast('毕业年份不能为空');
                    return;
                }
                if(yxmc==""){
                    this.$toast('学校名称不能为空');
                    return;
                }
                if(yxmc.length<4){
                    this.$toast('学校名称的长度不能小于4');
                    return;
                }
                if(yxmc.length>30){
                    this.$toast('学校名称不能超过30个字符长度');
                    return;
                }
                var postData = {
                    zsbh:zsbh,//证书编号
                    yxmc:yxmc,//院校名称
                    bynf:bynf,//毕业年份
                };
                if(_this.xlBindBtnClick){
                    _this.xlBindBtnClick = false;
                    setTimeout(function(){  //防止快速多次点击
                        _this.xlBindBtnClick = true;
                    }, 5000); 
                    _this.xlBindBtnStatus = true; //按钮loading效果
                    api.syncAjax('post', '/archive/wap/gdjy/xl/bindxl.action', { data: postData }).then(function(res){
                        _this.xl.errorObj.flag =false;
                        _this.xlBindBtnStatus = false; //按钮loading效果
                        if (res.status==0) {
                            _this.$toast('绑定成功');
                            setTimeout(function(){
                                window.location.reload();
                            },1000)
                        }else{
                            if(res.result.isParamError){
                                _this.$toast('输入参数有误');
                                var msg ='';
                                if(res.result.yxmc && res.result.yxmc.length>0){
                                    msg = res.result.yxmc;
                                }
                                if(res.result.bynf && res.result.bynf.length>0){
                                    msg = res.result.bynf;
                                }
                                if(res.result.zsbh && res.result.zsbh.length>0){
                                    msg = res.result.zsbh;
                                }
                                _this.$toast(msg);
                            }else{
                                _this.xl.errorObj={
                                    flag:true,
                                    errorMsg:res.result.errorMsg,
                                    limitNum:res.result.limitNum
                                }
                            }
                        } 
                    });      
                }else{
                    this.$toast('操作过于频繁，请稍后再试');
                }          
            },
            findXwSubmit:function(){ //学位找找看提交
                var _this =this,
                    zsbh = this.trimSpace(this.xw.zsbh);
                _this.xw.showErrMsg =false;  
                if(zsbh==""){
                    this.$toast('证书编号不能为空');
                    return;
                }
                if(zsbh.length > 20){
                    this.$toast('证书编号长度不能大于20');
                    return;
                }
                var postData = {
                    zsbh:zsbh,//证书编号
                    'cprmcsrf':"32983113ed413a5f485febbf90050661"
                };
                if(_this.xw.bindBtnClick){
                    _this.xw.bindBtnClick = false;
                    setTimeout(function(){  //防止快速多次点击
                        _this.xw.bindBtnClick = true;
                    }, 5000); 
                    _this.xw.bindBtnStatus = true; //按钮loading效果
                    api.syncAjax('post', '/archive/gdjy/xw/bind.action', { data: postData }).then(function(res){
                        _this.xl.errorObj.flag =false;
                        _this.xw.bindBtnStatus = false; //按钮loading效果
                        if (res.status==0) {
                            if(res.result.bindResult==0||res.result.bindResult==2){
                                _this.$toast('绑定成功');
                                setTimeout(function(){
                                    window.location.reload();
                                },1000)
                            }else{
                                if(res.result.bindResult==4){                                
                                    _this.xw.showErrMsg =true;
                                }else{
                                    _this.$toast(res.result.message);
                                }
                            }
                        }else{
                            _this.$toast(res.message);
                        } 
                    });      
                }else{
                    this.$toast('操作过于频繁，请稍后再试');
                }          
            },
            bindCcConfirm:function(picker, value, index) {
                this.xj.cc=picker;
                this.bindCc.flag=false;
            },
            bindBynfConfirm:function(picker, value, index) {
                this.xl.bynf=picker;
                this.bindBynf.flag=false;
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
                    window.location.href='/archive/wap/index.jsp';
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
                        window.location.href='/archive/wap/index.jsp';
                    }else{
                        window.location.href='/archive/wap/index.jsp';
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