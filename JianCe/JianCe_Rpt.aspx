<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JianCe_Rpt.aspx.cs" Inherits="JianCe_JianCe_Rpt" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>检测报告</title>
    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <script src="/Content/layer/layer.js"></script>

    <link href="/css/weui.css" rel="stylesheet" />
    <link href="/css/weuix.css" rel="stylesheet" />
    <script src="/js/zepto.min.js"></script>
    <script src="/js/zepto.weui.js"></script>
    <style>
        .weui-cell{
            padding:4px 15px; 
        }
        .f_gray{
            color:gray;
        }
        .weui-btn + .weui-btn{
            margin-top:0px;
        }
        .weui-cells:after{
            border:none;
        }
        .weui-form-preview:after{
            border:none;
        }
    </style>
    <script>
        $(document).ready(function () {

        });

        $(function () {

        });
        function deal(Extension, filepath) {
            //alert(Extension);

            //获取当前网址，如： http://localhost:8083/myproj/view/my.jsp

            var curWwwPath = window.document.location.href;

            //获取主机地址之后的目录，如： myproj/view/my.jsp

            var pathName = window.document.location.pathname;

            var pos = curWwwPath.indexOf(pathName);

            //获取主机地址，如： http://localhost:8083

            var localhostPaht = curWwwPath.substring(0, pos);

            if (Extension == ".pdf" ) {
                window.location.href = localhostPaht + "/pdfview/web/viewer.html?file=" + encodeURIComponent(filepath) + "#page=1";
            } else {
                window.open(localhostPaht + filepath);
            }


        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager runat="server">
    </asp:ScriptManager>

        <asp:Repeater runat="server" ID="listBxInfo">
            <ItemTemplate>
                <div class="weui-cells"><%--href="/pdfview/web/viewer.html?file=<%#  HttpUtility.UrlEncode( Eval("filepath").ToString()) %>#page=1"--%>
                  <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("Extension") %>','<%# Eval("filepath") %>')>
                    <div class="weui-cell__bd">
                        <p><%# Eval("filename") %></p>
                    </div>
                    <div class="weui-cell__ft">
                        <%# Eval("num") %>
                    </div>
                  </a>
                </div>
            </ItemTemplate>
        </asp:Repeater>

    </form>
</body>
</html>



                            <%--<%# Eval("num")+","+ Eval("filename") %>--%>
                            <%--<div class="weui-flex">
                              <div><%# Eval("num")%></div>
                              <div class="weui-flex__item padding10-l"><%# Eval("filename")%></div>
                              <div>weui</div>
                            </div>--%>
