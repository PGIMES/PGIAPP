<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bhgp_Apply_wk_V1.aspx.cs" Inherits="bhgp_Apply_wk_V1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>不合格处理</title>
    
    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <script src="/Content/layer/layer.js"></script>

    <link href="../css/weui.css" rel="stylesheet" />
    <link href="../css/weuix.css" rel="stylesheet" />
    <script src="../js/zepto.min.js"></script>
    <script src="../js/zepto.weui.js"></script>
    <style>
        .weui-cell{
            padding:4px 15px;
        }
        #UpdatePanel1 .weui-cell:before{
            border-top:none;
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
            <a class="weui-cell weui-cell_access" 
                href="/workorder/bhgp_Apply_V1.aspx?workorder=<%#Eval("workorder") %> &workorder_f=<%#Eval("workorder_f") %>&workshop=<%=_workshop %>">
                <%--<div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>--%>
                <div class="weui-cell__hd">
                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                </div>
                <div class="weui-cell__bd">
                     <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                        <%# "单号"+Eval("workorder") %>
                        <span style="display:<%# Eval("workorder_f").ToString()!=""?"inline-block":"none"%>; ">
                            <%# " 分单号" + Eval("workorder_f") %>
                        </span>
                    </span>
                    <span class="weui-form-preview__value" style="font-size: smaller">
                        <%# Eval("cur_qty")+"件" %>
                        <span class="weui-mark-rt- weui-badge" 
                            style="background-color: <%# Eval("result").ToString()=="返工"?"red":"#10AEFF"%>;
                                font-size: x-small; color: white; 
                                display:<%# (Eval("result").ToString()=="返工" || Eval("result").ToString()=="分选")?"inline-block":"none"%>; ">
                            <%#Eval("result") %>
                        </span>
                    </span>
                </div>
                <div class="weui-cell__ft">
                </div>
            </a>
        </ItemTemplate>
    </asp:Repeater>
            
    </form>
</body>
</html>
