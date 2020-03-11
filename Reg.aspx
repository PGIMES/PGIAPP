<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Reg.aspx.cs" Inherits="Reg" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>注册</title>
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
   <div id="allContainer" class="register-page-wrap normal-page-wrap ">         
 <header class="headimg"  style="display: block;"> 
  <img src="img/logo11.jpg" alt=""> 
 </header>
 <div class="form-normal"  style="display: block;"> 
  <ul class="tags-s1 d-box" id="tagsCategory" > 
   <li class="flex1 current"   style="background-color:#E39E25"><span class="txt">员工注册</span></li> 
  </ul> 
 
  
   <div id="formElementContainer" class="form-module"> 

    <dl class="form-item" > 
     <dd class="form-content"> 
      <div class="input-outer input-bgimgs to"> 
       <span class="icons i-name"></span> 
       <div class="input-inner"> 
        <input id="nameText" type="text" class="input-enter" name="name" validate="yes" vempty="yes" vemptyclip="请输入姓名！" placeholder="请输入您的姓名"> 
       </div> 
      </div> 
     </dd> 
    </dl> 
    <dl class="form-item" formele="element" element="emCode" effect="focus" employee="yes"> 
     <dd class="form-content"> 
      <div class="input-outer input-bgimgs to" element="emCode"> 
       <span class="icons i-staff-gl"></span> 
       <div class="input-inner"> 
        <input id="emCodeText" type="text" class="input-enter" name="emCode" validate="yes" vempty="yes" vemptyclip="请输入员工编码！" placeholder="请输入您的员工编码"> 
       </div> 
      </div> 
     </dd> 
    </dl> 
    <dl class="form-item" formele="element" element="mobile" effect="focus" employee="yes" unemployee="yes"> 
     <dd class="form-content"> 
      <div class="input-outer input-bgimgs to"> 
       <span class="icons i-name i-phone"></span> 
       <div class="input-inner"> 
        <input id="mobileText" type="text" class="input-enter" name="mobile" validate="yes" vempty="yes" vemptyclip="请输入手机号！" vmobile="yes" vmobileclip="手机号码错误！" placeholder="请输入您的手机号"> 
       </div> 
      </div> 
     </dd> 
    </dl> 
    <dl class="form-item" formele="element" element="password" effect="focus" employee="yes" unemployee="yes"> 
     <dd class="form-content"> 
      <div class="input-outer input-bgimgs to"> 
       <span class="icons i-locked-login"></span> 
       <div class="input-inner"> 
        <input id="passwordText" type="password" class="input-enter" name="password" validate="yes" vempty="yes" vemptyclip="请输入密码！" placeholder="请输入您的密码" autocomplete="new-password"> 
       </div> 
      </div> 
     </dd> 
    </dl> 
    <dl class="form-item" formele="element" element="rePassword" effect="focus" employee="yes" unemployee="yes"> 
     <dd class="form-content"> 
      <div class="input-outer input-bgimgs to"> 
       <span class="icons i-confirm"></span> 
       <div class="input-inner"> 
        <input id="rePasswordText" type="password" class="input-enter" name="rePassword" validate="yes" vsame="yes" targetid="passwordText" vsameclip="两次输入的密码不一致！" placeholder="确认密码" autocomplete="new-password" vempty="yes"> 
       </div> 
      </div> 
     </dd> 
    </dl> 
   </div> 
 
 </div>

 <div class="form-btns" module="bottom" style="display: block;"> 
  <a href="javascript:void(0)" id="registerBtn" class="btn btn-333" style="background-color:#E39E25">注册</a> 
  <a href="login.aspx" id="loginBtn" class="btn btn-333" style="background-color:#cccccc">已有账号，立即登录</a> 
 </div>
</div> 

    </form>
</body>
</html>
