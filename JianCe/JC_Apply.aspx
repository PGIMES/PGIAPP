<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JC_Apply.aspx.cs" Inherits="JC_Apply" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>检测</title>

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
        #div_op .weui-cell:before{
            border-top:none;
        }
        #div_op .weui-cells:before{
            border-top:none;
        }
    </style>
    <script>
        $(document).ready(function () {
            //$("#sb_desc").attr("readonly", "readonly");

        });

        $(function () {
            sm_sb();

            $('.collapse .js-category').click(function () {
                $parent = $(this).parent('li');
                if ($parent.hasClass('js-show')) {
                    $parent.removeClass('js-show');
                    $(this).children('i').removeClass('icon-35').addClass('icon-74');
                } else {
                    $parent.siblings().removeClass('js-show');
                    $parent.addClass('js-show');
                    $(this).children('i').removeClass('icon-74').addClass('icon-35');
                    $parent.siblings().find('i').removeClass('icon-35').addClass('icon-74');
                }
            });
            
            //$("#btn_save2").click(function(){
                
            //});

            //$("#btn_sign_0").click(function () {
            //});
            
        });


        function valid() {
            //if ($("#sb_code").val() == "") {
            //    layer.alert("请输入【设备】.");
            //    return false;
            //}
            //if ($("#on_pgino").val() == "") {
            //    layer.alert("请输入换上夹具【物料号】.");
            //    return false;
            //}
            //if ($("#on_pgino_no").val() == "") {
            //    layer.alert("请输入换上夹具【夹具号】.");
            //    return false;
            //}

            return true;
        }

    </script>
</head>
<body>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>  
    <form id="form1" runat="server">
    <asp:ScriptManager runat="server">
    </asp:ScriptManager>
        <asp:TextBox ID="emp_code_name" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="display:none;"></asp:TextBox>
        <asp:TextBox ID="domain" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="display:none;"></asp:TextBox>
        <asp:TextBox ID="dh" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="display:none;"></asp:TextBox>
        <asp:TextBox ID="stepid" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="display:none;"></asp:TextBox>

        开发中。。。。

    </form>
</body>
</html>
