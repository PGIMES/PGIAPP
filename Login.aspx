<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>登录</title>
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	

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
    <div class="login-page-wrap normal-page-wrap " >       
 <header class="headimg" id="bannerImgModule" style="display:bolck"> 
  <img src="img/logo11.jpg" > 
  <div class="login-notice">
    首次登录请先注册 
  </div> 
 </header>
 <div class="form-normal" > 
   <dl class="form-item" effect="focus" style="display:block"> 
    <dd class="form-content"> 
     <div class="input-outer input-bgimgs to"> 
      <span class="icons i-name i-phone"></span> 
      <div class="input-inner"> 
       <input type="text" name="mobile" class="input-enter" validate="yes" vempty="yes" vemptyclip="请输入手机号！" vmobile="yes" placeholder="请输入您的手机号"> 
      </div> 
     </div> 
    </dd> 
   </dl> 
   <dl class="form-item" effect="focus" style="display:block"> 
    <dd class="form-content"> 
     <div class="input-outer input-bgimgs to"> 
      <span class="icons i-confirm"></span> 
      <div class="input-inner"> 
       <input type="password" name="password" class="input-enter" validate="yes" vempty="yes" vemptyclip="请输入密码" placeholder="请输入密码" autocomplete="new-password"> 
      </div> 
     </div> 
    </dd> 
   </dl> 
 </div>
 <div class="form-btns"> 
  <a href="index.aspx" id="loginBtn" class="btn btn-333" style="background-color:#E39E25">登录</a> 
  <div class="btnbox-s2 clear" id="otherBtn"> 
   <a href="reg.aspx" id="registBtn" class="btn-s2 flex1">注册</a> 
   
  </div> 
 </div>
</div> 


    </form>
</body>
</html>
