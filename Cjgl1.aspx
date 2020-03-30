<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Cjgl1.aspx.cs" Inherits="Cjgl1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	
    <title><%=_workshop %></title>
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

   <%-- <script type="text/javascript">
        function getQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = decodeURI(window.location.search).substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
        var workshop = getQueryString("workshop");
        //alert(workshop);
    </script>--%>
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

  <%--  <div class="headimg" module="headerImg"> 
        <img src="img/logo11.jpg"> 
    </div> --%>
        
     <dd id="btn1" class="menus-item"  > 
      <a href="/workorder/Emp_Login.aspx?workshop=<%=_workshop %>"> <span class="mi-info logo"></span> <span class="mi-info txt">上岗</span> <span class="mi-info check txt"></span> </a> 
     </dd> 
     <dd id="btn1_1" class="menus-item"  > 
      <a href="/workorder/Emp_Login_list_new.aspx?workshop=<%=_workshop %>"> <span class="mi-info logo"></span> <span class="mi-info txt">上岗监视</span> <span class="mi-info check txt"></span> </a> 
     </dd> 
     <%-- <dd id="btn2" class="menus-item"  > 
      <a href="/workorder/Emp_Login.aspx?workshop=<%=_workshop %>"> <span class="mi-info logo"></span> <span class="mi-info txt">下岗</span> <span class="mi-info check txt"></span> </a> 
     </dd> --%>
         <dd id="btn3" class="menus-item"  > 
      <a href="/workorder/YL.aspx?workshop=<%=_workshop %>"> <span class="mi-info logo"></span> <span class="mi-info txt">要料</span> <span class="mi-info check txt"></span> </a> 
     </dd> 
          <dd id="btn4" class="menus-item"  > 
      <a href="/workorder/YL_list_new.aspx?workshop=<%=_workshop %>"> <span class="mi-info logo"></span> <span class="mi-info txt">要料监视</span> <span class="mi-info check txt"></span> </a> 
     </dd> 
     <dd id="btn5" class="menus-item"  > 
      <a href="/workorder/Load_Material.aspx?workshop=<%=_workshop %>"> <span class="mi-info logo"></span> <span class="mi-info txt">生产上料</span> <span class="mi-info check txt"></span> </a> 
     </dd> 
         <dd id="btn10" class="menus-item"  > 
      <a href="/workorder/bhgp_deal.aspx?workshop=<%=_workshop %>"> <span class="mi-info logo"></span> <span class="mi-info txt">不合格处置</span> <span class="mi-info check txt"></span> </a> 
     </dd> 
      <dd id="btn11" class="menus-item"  > 
      <a href="/workorder/bhgp_deal_list_new.aspx?workshop=<%=_workshop %>"> <span class="mi-info logo"></span> <span class="mi-info txt">不合格监视</span> <span class="mi-info check txt"></span> </a> 
     </dd> 
     <dd id="btn6" class="menus-item"  > 
      <a href="/workorder/Off_Material.aspx?workshop=<%=_workshop %>"> <span class="mi-info logo"></span> <span class="mi-info txt">生产完成</span> <span class="mi-info check txt"></span> </a> 
     </dd> 
         <dd id="btn7" class="menus-item"  > 
      <a href="/workorder/prod_end_list.aspx?workshop=<%=_workshop %>"> <span class="mi-info logo"></span> <span class="mi-info txt">生产完成监视</span> <span class="mi-info check txt"></span> </a> 
     </dd> 
         <dd id="btn8" class="menus-item"  > 
      <a href="#"> <span class="mi-info logo"></span> <span class="mi-info txt">终检完成</span> <span class="mi-info check txt"></span> </a> 
     </dd> 
         <dd id="btn9" class="menus-item"  > 
      <a href="#"> <span class="mi-info logo"></span> <span class="mi-info txt">终检完成监视</span> <span class="mi-info check txt"></span> </a> 
     </dd> 
       
         <dd id="btn12" class="menus-item"  > 
      <a href="javascript:void(0);"> <span class="mi-info logo"></span> <span class="mi-info txt">报表查看</span> <span class="mi-info check txt"></span> </a> 
     </dd> 
    </dl>
   </div> 
  </div>
    </form>
</body>
</html>
