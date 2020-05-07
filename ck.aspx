<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ck.aspx.cs" Inherits="ck" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <title>仓库</title>
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

        <div class="page-bd">
            <div class="weui-cells">
                <a class="weui-cell weui-cell_access" href="/workorder/YL_list_ck.aspx">
                    <div class="weui-cell__hd">
                        <i class="fa fa-cubes margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>要料监视</p>
                    </div>
                    <div class="weui-cell__ft">
                        <asp:Label ID="Label1" runat="server" Text="" style="display:none;"></asp:Label>
                        <% string i1 = Label1.Text; Response.Write("<span class='weui-badge  bg-" + (i1 == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>" + i1 + "</span>"); %> 
                    </div>
                </a>
                <a class="weui-cell weui-cell_access" href="/workorder/CKSH.aspx">
                    <div class="weui-cell__hd">
                        <i class="fa fa-random margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>仓库接收</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/workorder/bhgp_Apply_list_ck.aspx">
                    <div class="weui-cell__hd">
                        <i class="fa fa-bookmark-o margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>不合格监视</p>
                    </div>
                    <div class="weui-cell__ft">
                        <asp:Label ID="Label2" runat="server" Text="" style="display:none;"></asp:Label>
                        <% string i2 = Label2.Text; Response.Write("<span class='weui-badge  bg-" + (i2 == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>" + i2 + "</span>"); %> 
                    </div>
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
