<%@ Page Language="C#" AutoEventWireup="true" CodeFile="workshop.aspx.cs" Inherits="workshop" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<title>车间</title>

 <script type="text/javascript" src="js/jquery-3.0.0.min.js"></script>
<script type="text/javascript" src="js/jquery.form.min.js"></script>
<script type="text/javascript" src="js/json2.min.js"></script>
<script type="text/javascript" src="js/jweixin-1.2.0.js"></script>
<script id="commonJsScript" type="text/javascript" src="js/common.js?v=201810311922" ></script>
<script type="text/javascript" src="js/jquery.weixintools.js?v=201809201357"></script>

<link href="css/global.css?v=201802091428" rel="stylesheet" type="text/css">
<link href="css/iconfont.css?v=201802091429" rel="stylesheet" type="text/css">
<link href="css/login.css?v=201802091428" rel="stylesheet" type="text/css">
<link href="css/comm.css?v=201802091429" rel="stylesheet" type="text/css">
<link href="css/theme.css?v=201805162207" rel="stylesheet" type="text/css">


    <meta name="layout" content="main"/>
</head>
<body>
    <form id="form1" runat="server">
   <div class="resume-setting-page normal-page-wrap"> 
   <div id="allContainer" class="menus-normal">
    <dl class="menus-module" style=""> 
       
    <%-- <dt class="menus-title" style="background-color:#008083;height:35px">
         <div  style="float:left;width:49%;border:0px solid #F00;">MES</div> 
         <div style="float:left;width:49%;border:0px solid #000; text-align:right;"><a href="Index.aspx"><img src="img/home.png" width="22px" height="22px" style="text-align:right;"></a></div> 
     </dt> --%>

    <%--<div class="headimg" module="headerImg"> 
        <img src="img/logo11.jpg"> 
    </div> --%>
    <dd id="btn1" class="menus-item"  > 
      <a href="#"> <span class="mi-info logo"></span> <span class="mi-info txt">一车间</span> <span class="mi-info check txt"></span> </a> 
     </dd> 
    <dd id="btn2" class="menus-item"  > 
      <a href="/Cjgl1.aspx?workshop=二车间"> <span class="mi-info logo"></span> <span class="mi-info txt">二车间</span> <span class="mi-info check txt"></span> </a> 
     </dd> 
    <dd id="btn3" class="menus-item"  > 
      <a href="#"> <span class="mi-info logo"></span> <span class="mi-info txt">三车间</span> <span class="mi-info check txt"></span> </a> 
     </dd>
    <dd id="btn4" class="menus-item"  > 
      <a href="#"> <span class="mi-info logo"></span> <span class="mi-info txt">四车间</span> <span class="mi-info check txt"></span> </a> 
     </dd>

    </dl>
   </div> 
  </div>
    </form>
</body>
</html>
