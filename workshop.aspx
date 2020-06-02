<%@ Page Language="C#" AutoEventWireup="true" CodeFile="workshop.aspx.cs" Inherits="workshop" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<title>车间</title>
    <link href="/css/weui.css" rel="stylesheet" />
    <link href="/css/weuix.css" rel="stylesheet" />
    <script src="/js/jquery-3.0.0.min.js"></script>
    <link href="/css/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" />
    <style>
        .weui-cells {
            margin-top: 0px;
            line-height: 2.5;
        }
        .weui-cell:before {
            left: 0px;
                     
        }
        .weui-cell{
            padding:10px 20px;  
        }
        i{ color:#03a9f4}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-bd">
            <div class="weui-cells">
                <%--<a class="weui-cell weui-cell_access" href="#">
                    <div class="weui-cell__hd">
                        <i class="fa fa-cog margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>一车间<span class="f12">（未开放）</span></p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>--%>
                <a class="weui-cell weui-cell_access" href="/Cjgl1.aspx?workshop=二车间">
                    <div class="weui-cell__hd">
                        <i class="fa fa-cog margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>二车间</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/Cjgl_three.aspx?workshop=三车间">
                    <div class="weui-cell__hd">
                        <i class="fa fa-cog margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>三车间</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/Cjgl1.aspx?workshop=四车间">
                    <div class="weui-cell__hd">
                        <i class="fa fa-cog margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>四车间</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/ck.aspx">
                    <div class="weui-cell__hd">
                        <i class="fa fa-home margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>仓库</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="javascript:void(0);">
                    <div class="weui-cell__hd">
                        <i class="fa fa-search margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>单据查询<span class="f12">（未开放）</span></p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
            </div>
        </div>
        <div id="errmsg"class="f14"></div>  
        <div class="weui-footer weui-footer_fixed-bottom">
            <p class="weui-footer__text">
                <% =WeiXin.GetCookie("workcode")==""?"获取信息失败":WeiXin.GetCookie("workcode") +((LoginUser)WeiXin.GetJsonCookie()).UserName %>
            </p>
        </div>
    </form>
</body>
</html>
