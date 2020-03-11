<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
</head>
<body>
    <form id="form1" runat="server">
    <div class="personal-page normal-page-wrap">  
 
   <div class="headimg" module="headerImg"> 
    <img src="img/logo11.jpg"> 
   </div> 
   <div class="guide-menus-box"> 
    <ul class="menus-box clear">  
     <li id="accountBtn" class="menu"> <a href="ggcx.aspx"> <span class="icons i-menu-account" style="background-color:#E39E25"></span> <span class="txt">公共查询</span> </a> </li> 
     <li id="resumeBtn" class="menu"> <a href="cjgl.aspx"> <span class="icons i-menu-resume" style="background-color:#008083"></span> <span class="txt">业务系统</span> </a> </li> 
     <!-- 开发中 -->  
     <li id="historyBtn" class="menu"> <a href="Dbsx.aspx"> <span class="icons i-menu-crate" style="background-color:#155097"></span> <span class="txt">待办事项</span> </a> </li> 
     <!--开发中--> 
     <li id="deliverHisBtn" class="menu"> <a href="javascript:void(0);"> <span class="icons i-menu-deliver" style="background-color:#cccccc"></span> <span class="txt">开发中</span> </a> </li>  
     <!--开发中--> 
     <li id="rankRuleRtn" class="menu" > <a href="javascript:void(0);"> <span class="icons i-menu-ruler" style="background-color:#cccccc"></span> <span class="txt">开发中</span> </a> </li> 
     <!--开发中--> 
     <li id="recommendRuleRtn" class="menu" > <a href="javascript:void(0);"> <span class="icons i-menu-internal" style="background-color:#cccccc"></span> <span class="txt">开发中</span> </a> </li> 
     <!--开发中--> 
     <li id="userDefinedBtn1" class="menu" > <a href="javascript:void(0);"> <span class="icons i-menu-crate" style="background-color:#cccccc"></span> <span class="txt">开发中</span> </a> </li> 
     <!--开发中--> 
     <li id="userDefinedBtn2" class="menu" > <a href="javascript:void(0);"> <span class="icons i-menu-faver" style="background-color:#cccccc"></span> <span class="txt">开发中</span> </a> </li> 
     <!--开发中--> 
     <li id="userDefinedBtn3" class="menu" style="display:none;"> <a href="javascript:void(0);"> <span class="icons i-menu-userDefined3"></span> <span class="txt">L{userDefinedBtn3}</span> </a> </li> 
     <!--开发中 -->  
    </ul> 
   </div> 
  </div> 
  
    </form>
</body>
</html>
