<%@ Page Language="C#" Title="模具报修" AutoEventWireup="true" CodeFile="MoJu.aspx.cs" Inherits="MoJu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	

 <script type="text/javascript" src="js/jquery-3.0.0.min.js"></script>
<script type="text/javascript" src="js/jquery.form.min.js"></script>
<script type="text/javascript" src="js/json2.min.js"></script>
<script type="text/javascript" src="js/jweixin-1.2.0.js"></script>
<script id="commonJsScript" type="text/javascript" src="js/common.js?v=201810311922" ></script>
<script type="text/javascript" src="js/jquery.weixintools.js?v=201809201357"></script>

 

<link href="/css/global.css?v=201802091428" rel="stylesheet" type="text/css">
<link href="/css/iconfont.css?v=201802091429" rel="stylesheet" type="text/css">
<link href="/css/login.css?v=201802091428" rel="stylesheet" type="text/css">
<link href="/css/comm.css?v=201802091429" rel="stylesheet" type="text/css">
<link href="/css/theme.css?v=201805162207" rel="stylesheet" type="text/css">

    <script>
        $(document).ready(function () {
            //$.ajax({
            //    type: "post",
            //    url: "Dbsx.aspx/init",
            //    data: "{}",
            //    contentType: "application/json; charset=utf-8",
            //    dataType: "json",
            //    async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
            //    success: function (data) {
            //        var obj = eval(data.d);
            //        var appp_ng = obj[0].appp_ng;//不合格品处置数量
            //        $("#span_ng").text("不合格品处置(" + appp_ng + ")");

            //        //layer.alert(obj[0].re_flag, function (index) { location.reload(); })
            //        return;
            //    }

            //});
        });

    </script>
    <meta name="layout" content="main"/>
</head>
<body>
    <form id="form1" runat="server">
    <div class="resume-setting-page normal-page-wrap"> 
        <div id="allContainer" class="menus-normal">
        <dl class="menus-module" style=""> 
       
            <dt class="menus-title" style="background-color:#155097;height:35px">
                <div  style="float:left;width:49%;border:0px solid #F00;">模具报修</div> 
                <div style="float:left;width:49%;border:0px solid #000; text-align:right;"><%--<a href="Index.aspx"><img src="img/home.png" width="22px" height="22px" style="text-align:right;"></a>--%></div> 
            </dt> 
        
            <dd id="btn1" class="menus-item"  > 
                <a href="/MoJu/MoJuBX.aspx"> <span class="mi-info logo"></span> <span id="span_ng" class="mi-info txt">模具报修</span> <span class="mi-info check txt">进入</span> </a> 
            </dd> 
            <dd id="btn2" class="menus-item"  > 
                <a href="javascript:void(0);"> <span class="mi-info logo"></span> <span class="mi-info txt">故障监视</span> <span class="mi-info check txt">进入</span> </a> 
            </dd> 
            <dd id="btn3" class="menus-item"  > 
                <a href="javascript:void(0);"> <span class="mi-info logo"></span> <span class="mi-info txt">报修查询</span> <span class="mi-info check txt">进入</span> </a> 
            </dd> 
             <dd id="btn3" class="menus-item"  > 
                <a href="javascript:void(0);"> <span class="mi-info logo"></span> <span class="mi-info txt">报修统计</span> <span class="mi-info check txt">进入</span> </a> 
            </dd> 
        </dl>
        </div> 
    </div>
    </form>
</body>
</html>
