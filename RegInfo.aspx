<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegInfo.aspx.cs" Inherits="RegInfo" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>注册</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <script type="text/javascript" src="js/jquery-3.0.0.min.js"></script>
    <script type="text/javascript" src="js/jquery.form.min.js"></script>
    
    <script id="commonJsScript" type="text/javascript" src="js/common.js?v=201810311922"></script>
    <script type="text/javascript" src="js/jquery.weixintools.js?v=201809201357"></script>

    <link href="css/global.css?v=201802091428" rel="stylesheet" type="text/css">
    <link href="css/iconfont.css?v=201802091429" rel="stylesheet" type="text/css">
    <link href="css/login.css?v=201802091428" rel="stylesheet" type="text/css">
    <link href="css/comm.css?v=201802091429" rel="stylesheet" type="text/css">
    <link href="css/theme.css?v=201805162207" rel="stylesheet" type="text/css">
    <meta name="layout" content="main" />
    <script>
        function valid() {
            if ($("#workcode").val() == "") {
                alert("请输入五位工号（5位数字 如 02067）");
                return false;
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="allContainer" class="register-page-wrap normal-page-wrap ">
            <header class="headimg" style="display: block;">
                <img src="img/logo11.jpg" alt="" hidden="hidden">
            </header>
            <div class="form-normal" style="display: block;">
                <ul class="tags-s1 d-box" id="tagsCategory">
                    <li class="flex1 current" style="background-color: #E39E25"><span class="txt">员工信息完善</span></li>
                </ul>

                <div id="formElementContainer" class="form-module">

                    <dl class="form-item">
                        <dd class="form-content">
                            <div class="input-outer input-bgimgs to">
                                <span class="icons i-name"></span>
                                <div class="input-inner">
                                     <asp:textbox id="wxuserid" runat="server"   class="input-enter" name="name" validate="yes" vempty="yes" vemptyclip="请输入姓名！" placeholder="请输入您的姓名" readonly="true"></asp:textbox>
                                </div>
                            </div>
                        </dd>
                    </dl>
                    <dl class="form-item" formele="element" element="emCode" effect="focus" employee="yes">
                        <dd class="form-content">
                            <div class="input-outer input-bgimgs to" element="emCode">
                                <span class="icons i-staff-gl"></span>
                                <div class="input-inner">
                                     <asp:textbox id="workcode" runat="server" type="number" AutoPostBack="true" OnTextChanged="workcode_TextChanged" class="input-enter" name="emCode" validate="yes" vempty="yes" vemptyclip="请输入工号！" placeholder="请输入工号"></asp:textbox>
                                </div>
                            </div>
                        </dd>
                    </dl>
                    <dl class="form-item" formele="element" element="emCode" effect="focus" employee="yes">
                        <dd class="form-content">
                            <div class="input-outer input-bgimgs to" element="emCode">
                                <span class="icons i-staff-gl"></span>
                                <div class="input-inner">
                                     <asp:textbox id="name" runat="server"  ReadOnly="true"  AutoPostBack="true" OnTextChanged="workcode_TextChanged" class="input-enter" name="emCode" validate="yes" vempty="yes" vemptyclip="！" placeholder="姓名"></asp:textbox>
                                </div>
                            </div>
                        </dd>
                    </dl>
                    <dl class="form-item" formele="element" element="emCode" effect="focus" employee="yes">
                        <dd class="form-content">
                            <asp:button ID="registerBtn" runat="server" class="btn " style="background-color: #E39E25;height:40px;width:100%" Text="确 定" OnClientClick="return valid();" OnClick="registerBtn_Click"></asp:button>
                        </dd>
                    </dl>
                </div>
            </div>
            
        </div>

    </form>
</body>
</html>
