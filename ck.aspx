<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ck.aspx.cs" Inherits="ck" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <title>仓库</title>
    <script type="text/javascript" src="js/jquery-3.0.0.min.js"></script>
    <script type="text/javascript" src="js/jquery.form.min.js"></script>
    <script type="text/javascript" src="js/json2.min.js"></script>
    <script type="text/javascript" src="js/jweixin-1.2.0.js"></script>
    <script id="commonJsScript" type="text/javascript" src="js/common.js?v=201810311922"></script>
    <script type="text/javascript" src="js/jquery.weixintools.js?v=201809201357"></script>
    <link href="/css/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" />


    <link href="css/global.css?v=201802091428" rel="stylesheet" type="text/css">
    <link href="css/iconfont.css?v=201802091429" rel="stylesheet" type="text/css">
    <link href="css/login.css?v=201802091428" rel="stylesheet" type="text/css">
    <link href="css/comm.css?v=201802091429" rel="stylesheet" type="text/css">
    <link href="css/theme.css?v=201805162207" rel="stylesheet" type="text/css">

    <style>
        .weui-cells {
            margin-top: 0px;
        }
        .padding-r{
            padding-right:10px;
            color:#03a9f4;
        }
    </style>
    <meta name="layout" content="main" />

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
                    
                    <dd id="btn4" class="menus-item">
                        <a href="/workorder/YL_list_ck.aspx">
                            <span class="mi-info txt"><i class="fa fa-cubes padding-r"></i>要料监视<asp:Label ID="Label1" runat="server" Text=""></asp:Label></span> 
                            <span class="mi-info check txt"></span>
                        </a>
                    </dd>
                    
                    <dd id="btn2" class="menus-item">
                        <a href="/workorder/CKSH.aspx">
                            <span class="mi-info txt"><i class="fa fa-random padding-r"></i>仓库接收</span> 
                            <span class="mi-info check txt"></span>
                        </a>
                    </dd>
                    
                    <dd id="btn11" class="menus-item">
                        <a href="/workorder/bhgp_Apply_list_ck.aspx">
                            <span class="mi-info txt"><i class="fa fa-bookmark-o padding-r"></i>不合格监视<asp:Label ID="Label2" runat="server" Text=""></asp:Label></span> 
                            <span class="mi-info check txt"></span>
                        </a>
                    </dd>
                </dl>
            </div>
        </div>
    </form>
</body>
</html>
