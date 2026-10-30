














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
        var _loc = window.location.pathname + window.location.search;
        window.location.href = '/archive/login.jsp?redirect=' + encodeURIComponent(_loc);
    }
</script>
</head>

<body>

    <div id="app" class="my-container" v-cloak>

         



























<img src='https://t1.chei.com.cn/common/wap/images/share_xxda.jpg' width='0' height='0' style='position: absolute;top:-100px;left: 0'/>

<van-nav-bar

  class="white-header"  

  :title="whiteTit"

  border=false

  left-text=""

  left-arrow

  @click-left="onClickLeft"

></van-nav-bar>

<template v-if="resultJson.status===0">

    <div class="padding16 xj-index chsi-font">

        <div class='top-card xl-top-card'>

          <van-row>

            <van-col span="5">

              <div class="img-div">

                <img v-if="resultJson.result.xl.hasXlPic" :src="'/archive/photo/xlpic.do?pid='+resultJson.result.xl.id+'&v='+(resultJson.result.xl.xlPicVer||'')" />

                <template v-else >    

                <img src="https://t4.chei.com.cn/archive/images/common/no-photo.png" @click="showTips" />

                <span class="red-tips-icon" @click="showTips"></span>

                </template>

              </div>

            </van-col>

            <van-col span="19">

              <h5 class="nameFamily">{{resultJson.result.xl.xm}}</h5>

              <p v-if="resultJson.result.type!='zk'">{{resultJson.result.xl.xb}}　{{resultJson.result.xl.csrq}}</p>

            </van-col>

          </van-row>

          <div class="top-bottom-img">

            <div class="yxmc-wrap">

                <div class="yxmc">{{resultJson.result.xl.yxmc}}</div>

                <div class="cc xl-cc-lable">{{resultJson.result.xl.cc}}</div>

            </div>                    

            <div class="des">{{resultJson.result.xl.zymc}}<template v-if="resultJson.result.xl.xxxs">　|　{{resultJson.result.xl.xxxs}}</template></div>

          </div>

          <span class="xlzms" v-if="resultJson.result.xl.xlzms">学历证明书</span>

        </div>

        <div class="xj-c">          

            <ul class="gdjy-view-ul xl-view">

                <template v-if="resultJson.result.type=='ypcwk'">

                    <li>

                        <div class="left">入学日期</div>

                        <div class="right">{{resultJson.result.xl.rxrq}}</div>

                    </li>

                    <li>

                        <div class="left">毕（结）业日期</div>

                        <div class="right">{{resultJson.result.xl.byrq}}</div>

                    </li>

                    <li>

                        <div class="left">学历类别</div>

                        <div class="right">{{resultJson.result.xl.xllb}}</div>

                    </li>

                    <li>

                        <div class="left">学制</div>

                        <div class="right">{{resultJson.result.xl.xz}}</div>

                    </li>

                    <li>

                        <div class="left">毕（结）业</div>

                        <div class="right">{{resultJson.result.xl.bjyjl}}</div>

                    </li>

                    <template v-if="resultJson.result.xl.xlzms">

                        <li>

                            <div class="left">证书编号</div>

                            <div class="right">{{resultJson.result.xl.zsbh}}</div>

                        </li>                

                        <li>

                            <div class="left">补证学校</div>

                            <div class="right">{{resultJson.result.xl.fzyxmc}}</div>

                        </li>

                        <li>

                            <div class="left">补证编号</div>

                            <div class="right">{{resultJson.result.xl.fzzsbh}}</div>

                        </li>

                        <li>

                            <div class="left">补证日期</div>

                            <div class="right">{{resultJson.result.xl.fzrq}}</div>

                        </li>

                        <li>

                            <div class="left">校（院）长姓名</div>

                            <div class="right">{{resultJson.result.xl.xzm}}</div>

                        </li>

                    </template>

                    <template v-else>

                        <li>

                            <div class="left">校（院）长姓名</div>

                            <div class="right">{{resultJson.result.xl.xzm}}</div>

                        </li>

                        <li>

                            <div class="left">证书编号</div>

                            <div class="right">{{resultJson.result.xl.zsbh}}</div>

                        </li>

                    </template>

                </template>

                <template v-if="resultJson.result.type=='lhlxs'">

                    <li>

                        <div class="left">国籍</div>

                        <div class="right">{{resultJson.result.xl.mz}}</div>

                    </li>

                    <li>

                        <div class="left">入学日期</div>

                        <div class="right">{{resultJson.result.xl.rxrq}}</div>

                    </li>

                    <li>

                        <div class="left">毕（结）业日期</div>

                        <div class="right">{{resultJson.result.xl.byrq}}</div>

                    </li>

                    <li>

                        <div class="left">学历类别</div>

                        <div class="right">{{resultJson.result.xl.xllb}}</div>

                    </li>

                    <li>

                        <div class="left">学制</div>

                        <div class="right">{{resultJson.result.xl.xz}}</div>

                    </li>

                    <li>

                        <div class="left">毕（结）业</div>

                        <div class="right">{{resultJson.result.xl.bjyjl}}</div>

                    </li>

                    <template v-if="resultJson.result.xl.xlzms">

                        <li>

                            <div class="left">证书编号</div>

                            <div class="right">{{resultJson.result.xl.zsbh}}</div>

                        </li>                

                        <li>

                            <div class="left">补证学校</div>

                            <div class="right">{{resultJson.result.xl.fzyxmc}}</div>

                        </li>

                        <li>

                            <div class="left">补证编号</div>

                            <div class="right">{{resultJson.result.xl.fzzsbh}}</div>

                        </li>

                        <li>

                            <div class="left">补证日期</div>

                            <div class="right">{{resultJson.result.xl.fzrq}}</div>

                        </li>

                        <li>

                            <div class="left">校（院）长姓名</div>

                            <div class="right">{{resultJson.result.xl.xzm}}</div>

                        </li>

                    </template>

                    <template v-else>

                        <li>

                            <div class="left">校（院）长姓名</div>

                            <div class="right">{{resultJson.result.xl.xzm}}</div>

                        </li>

                        <li>

                            <div class="left">证书编号</div>

                            <div class="right">{{resultJson.result.xl.zsbh}}</div>

                        </li>

                    </template>

                </template>

                <template v-if="resultJson.result.type=='xlwp'">

                    <li>

                        <div class="left">证件号码</div>

                        <div class="right">{{resultJson.result.xl.zjhm}}</div>

                    </li>

                    <li>

                        <div class="left">入学日期</div>

                        <div class="right">{{resultJson.result.xl.rxrq}}</div>

                    </li>

                    <li>

                        <div class="left">毕（结）业日期</div>

                        <div class="right">{{resultJson.result.xl.byrq}}</div>

                    </li>

                    <li>

                        <div class="left">学历类别</div>

                        <div class="right">{{resultJson.result.xl.xllb}}</div>

                    </li>

                    <li>

                        <div class="left">学制</div>

                        <div class="right">{{resultJson.result.xl.xz}}</div>

                    </li>

                    <li>

                        <div class="left">毕（结）业</div>

                        <div class="right">{{resultJson.result.xl.bjyjl}}</div>

                    </li>

                    <li>

                        <div class="left">证书编号</div>

                        <div class="right">{{resultJson.result.xl.zsbh}}</div>

                    </li>

                    <template v-if="resultJson.result.xl.xlzms">              

                        <li>

                            <div class="left">补证学校</div>

                            <div class="right">{{resultJson.result.xl.fzyxmc}}</div>

                        </li>

                        <li>

                            <div class="left">补证编号</div>

                            <div class="right">{{resultJson.result.xl.fzzsbh}}</div>

                        </li>

                        <li>

                            <div class="left">补证日期</div>

                            <div class="right">{{resultJson.result.xl.fzrq}}</div>

                        </li>

                    </template>

                </template>

                <template v-if="resultJson.result.type=='zk'">

                    <li>

                        <div class="left">证件号码</div>

                        <div class="right">{{resultJson.result.xl.zjhm}}</div>

                    </li>

                    <li>

                        <div class="left">毕（结）业日期</div>

                        <div class="right">{{resultJson.result.xl.byrq}}</div>

                    </li>

                    <li>

                        <div class="left">学历类别</div>

                        <div class="right">{{resultJson.result.xl.xllb}}</div>

                    </li>

                    <li>

                        <div class="left">毕（结）业</div>

                        <div class="right">{{resultJson.result.xl.bjyjl}}</div>

                    </li>

                    <li>

                        <div class="left">证书编号</div>

                        <div class="right">{{resultJson.result.xl.zsbh}}</div>

                    </li>

                    <template v-if="resultJson.result.xl.xlzms">              

                        <li>

                            <div class="left">补证学校</div>

                            <div class="right">{{resultJson.result.xl.fzyxmc}}</div>

                        </li>

                        <li>

                            <div class="left">补证编号</div>

                            <div class="right">{{resultJson.result.xl.fzzsbh}}</div>

                        </li>

                        <li>

                            <div class="left">补证日期</div>

                            <div class="right">{{resultJson.result.xl.fzrq}}</div>

                        </li>

                    </template>

                </template>

                <template v-if="resultJson.result.hasXlfzzy">

                    <li><div class="fx-tit">辅修专业</div></li>

                    <template v-for="fxItem,keyIndex in resultJson.result.xlfyzyList">

                        <li >

                            <div class="left">辅修学校</div>

                            <div class="right">{{fxItem.yxmc}}</div>

                        </li>

                        <li>

                            <div class="left">辅修专业</div>

                            <div class="right">{{fxItem.zymc}}</div>

                        </li>

                        <li :class="{'fx-border':keyIndex+1!=resultJson.result.xlfyzyList.length}">

                            <div class="left">起止日期</div>

                            <div class="right">{{fxItem.rxrq}}至{{fxItem.byrq}}</div>

                        </li>

                    </template>                  

                </template>

            </ul>

        </div>

        <div style="padding: 0 12px 16px;">

            <van-button class="my-btn" type="primary" block @click="goReport">查看验证报告</van-button>

        </div>

    </div>    

</template>

<template v-else>

    <div class="status-kong">

        <div class="status-img status-fail"></div>

        <p class="des">{{resultJson.message}}</p>

    </div>

</template>

<script>

      var mixin = {

        data:function(){

            return {

                whiteTit:'高等学历',

                resultJson:{status:-1,result:null,message:''}

            }

        },

        mounted:function(){

        },

        methods:{initAfterData:function(){

            },

            showTips:function(){

                this.$dialog.alert({

                  title: '没有照片',

                  message: '没有照片？请联系就读院校学籍学历管理部门协助处理！',

                  confirmButtonText:'知道了'

                });



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
            var _this=this;
            var _id=(window.location.search.match(/[?&]id=([^&]+)/)||[])[1]||'';
            api.syncAjax('get','/api/gdjy/detail?type=xl&id='+encodeURIComponent(_id)).then(function(res){
                _this.resultJson=res;
                _this.initAfterData();
            });
        },

            methods:{

                onClickLeft:function(){ //左上的返回按钮

                    history.back(-1);

                },

                goToIndex:function(){

                    window.location.href='/archive/wap/index.jsp';

                },

                goReport:function(){ //查看在线验证报告

                    var _id=(window.location.search.match(/[?&]id=([^&]+)/)||[])[1]||'';

                    window.location.href='/archive/wap/gdjy/show.jsp?type=xl&id='+encodeURIComponent(_id);

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