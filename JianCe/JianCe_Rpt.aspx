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
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager runat="server">
    </asp:ScriptManager>

        <asp:Repeater runat="server" ID="listBxInfo">
            <ItemTemplate>
                <div class="weui-cells">
                  <a class="weui-cell weui-cell_access" href="/pdfview/web/viewer.html?file=<%#  HttpUtility.UrlEncode( Eval("filepath").ToString()) %>#page=1">
                    <div class="weui-cell__bd">
                      <p><%# Eval("filename") %></p>
                    </div>
                    <div class="weui-cell__ft">
                    </div>
                  </a>
                </div>
            </ItemTemplate>
        </asp:Repeater>

    </form>
</body>
</html>
