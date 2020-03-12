<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Emp_Login.aspx.cs" Inherits="Emp_Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">

     <%--<script type="text/javascript" src="/js/jquery-3.0.0.min.js"></script>
    <script type="text/javascript" src="/js/jquery.form.min.js"></script>
    <script type="text/javascript" src="/js/json2.min.js"></script>
    <script type="text/javascript" src="/js/jweixin-1.2.0.js"></script>
    <script id="commonJsScript" type="text/javascript" src="/js/common.js?v=201810311922" ></script>
    <script type="text/javascript" src="/js/jquery.weixintools.js?v=201809201357"></script>--%>

     <link href="/Content/bootstrap.min.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <script src="/Content/laydate/laydate.js"></script>
    <script src="/Content/layer/mobile/layer.js"></script>

    <link href="/css/global.css?v=201802091428" rel="stylesheet" type="text/css">
    <link href="/css/iconfont.css?v=201802091429" rel="stylesheet" type="text/css">
    <link href="/css/login.css?v=201802091428" rel="stylesheet" type="text/css">
    <link href="/css/comm.css?v=201802091429" rel="stylesheet" type="text/css">
    <link href="/css/theme.css?v=201805162207" rel="stylesheet" type="text/css">

     <style>
        .rowbr{
            margin-bottom:5px;
        }
        .textwidth1{
            padding-right:25px;
        }        
        .textwidth2{
            padding-right:40px;
        }
        
        #cbl_position label{
            font-weight:normal;
        }
        
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager runat="server">
    </asp:ScriptManager>
    <div class="resume-setting-page normal-page-wrap"> 
        <div id="allContainer" class="menus-normal">
            <dl class="menus-module" style="background-color:#008083;height:66px;"> 
                
                <dt class="menus-title" style="background-color:#008083;height:66px">
                    <div style="float:left;width:80%;border:0px solid #F00;">PGI产线作业-员工上下岗操作</div> 
                    <div style="float:left;width:18%;border:0px solid #000; text-align:right;"><%--<a href="/Index.aspx"><img src="/img/home.png" width="22px" height="22px" style="text-align:right;"></a>--%></div> 
                </dt> 
         
            </dl>
        </div> 

        
        <div class="row ">
            <div class="col-md-12">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
            
                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth2">登入人</span>
                    <asp:TextBox ID="txt_emp" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                    <asp:TextBox ID="domain" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server" Visible="false"></asp:TextBox>
                </div>

                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth2">物料号</span>
                    <asp:DropDownList ID="ddl_part" runat="server" class="form-control" Style="max-width: 100%" OnTextChanged="ddl_part_TextChanged" AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:TextBox ID="txt_part" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server" Visible="false"></asp:TextBox>
                   
                </div>
              
                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth1">当前岗位</span>
                    <asp:CheckBoxList ID="cbl_position" runat="server" class="form-control" Style="max-width: 100%" RepeatDirection="Horizontal" RepeatColumns="1"></asp:CheckBoxList>
                </div>  

            </ContentTemplate>
            </asp:UpdatePanel>

            <div class="">
                    <asp:Button ID="btn_sure" class="btn btn-primary btn-lg btn-block" BackColor="#428bca" style="padding:10px 16px" runat="server" Text="上岗确认" 
                        OnClick="btn_sure_Click"/>
            </div>
            
           
            </div>
        </div>
       
    </div>
    </form>
</body>
</html>
