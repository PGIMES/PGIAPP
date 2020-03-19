<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MoJu_BX.aspx.cs" Inherits="MoJu_MoJu_BX" %>

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
        .textwidth2{
            padding-left:40px;
            padding-right:40px;
        }
          .textwidth3{
            padding-left:32px;
            padding-right:32px;
        }
        .textwidth4{
            padding-left:25px;
            padding-right:25px;
        }
        .textwidth5{
            padding-left:18px;
            padding-right:20px;
        }
        body {
    padding-top: 5px;
    padding-bottom: 10px;
}
        p{line-height:12px}
    </style>
    <script>
        function valid() {           
            if ($("select[id*='sbname']").val() == "") {
                alert("请选择【设备简称】.");
                return false;
            }
            if ($("#ddl_mojuno").val() == "") {
                alert("请选择【模具号】.");
                return false;
            }
            if ($("#ddl_gz").val() == "") {
                alert("请选择【故障类型】.");
                return false;
            }
            if ($("input[id*=bcmoci]").val() == "") {
                alert("请输入本次上机模次.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server">
        </asp:ScriptManager>
    <div class="resume-setting-page normal-page-wrap"> 
        <div id="allContainer" class="menus-normal">
            <dl class="menus-module" style="background-color:#008083;height:66px;"> 
                
                <dt class="menus-title" style="background-color:#008083;height:66px">
                    <div  style="float:left;width:80%;border:0px solid #F00;">PGI产线作业-模具报修</div> 
                    <div style="float:left;width:18%;border:0px solid #000; text-align:right;"><%--<a href="/Index.aspx"><img src="/img/home.png" width="22px" height="22px" style="text-align:right;"></a>--%></div> 
                </dt> 

         
            </dl>
        </div> 

        
        <div class="row ">
            <div class="col-md-12">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
            
                    <div class="input-group rowbr">
                        <span class="input-group-addon textwidth3">登入人</span>
                        <asp:TextBox ID="txt_empname" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                    </div>

                     <div class="input-group rowbr">
                        <span class="input-group-addon textwidth4">设备简称</span>
                        &nbsp;<asp:DropDownList ID="ddl_sbname" runat="server" class="form-control" Style="max-width: 100%" AutoPostBack="True" OnSelectedIndexChanged="ddl_sbname_SelectedIndexChanged"  ></asp:DropDownList>
                    </div>
                    
                    <div class="input-group rowbr">
                        <span class="input-group-addon textwidth3">模具号</span>
                        <asp:DropDownList ID="ddl_mojuno" runat="server" class="form-control" Style="max-width: 100%" AutoPostBack="true" OnSelectedIndexChanged="ddl_mojuno_SelectedIndexChanged" ></asp:DropDownList>
                    </div>

                    <div class="input-group rowbr">
                        <span class="input-group-addon textwidth4">是否停机</span>
                        <asp:DropDownList ID="Is_stop" runat="server" class="form-control" Style="max-width: 100%">
                            <asp:ListItem Selected="True" Value="N">否</asp:ListItem>
                            <asp:ListItem Value="Y">是</asp:ListItem>
                        </asp:DropDownList>
                    </div>


                     <div class="input-group rowbr">
                        <span class="input-group-addon textwidth4">故障类型</span>
                        <asp:DropDownList ID="ddl_gz" runat="server" class="form-control" Style="max-width: 100%"  ></asp:DropDownList>
                    </div>

                     <div class="input-group rowbr">
                        <span class="input-group-addon textwidth4">故障描述</span>
                         <asp:TextBox ID="txt_gz_ms" class="form-control"  Style="max-width: 100%" runat="server" TextMode="MultiLine"></asp:TextBox>
                    </div>


                     <div class="input-group rowbr">
                        <span class="input-group-addon textwidth6">本次上机模次</span>
                        <asp:TextBox ID="bcmoci" class="form-control"  Style="max-width: 100%" runat="server"></asp:TextBox>
                    </div>


                    <div class="input-group rowbr">
                        <span class="input-group-addon textwidth4">累计模次</span>
                        <asp:TextBox ID="txt_summoci" class="form-control" ReadOnly="true" Style="max-width: 100%" runat="server"></asp:TextBox>
                    </div>

                    <div class="input-group rowbr">
                        <span class="input-group-addon textwidth4">模具类型</span>
                        <asp:TextBox ID="txt_mojutype" class="form-control" ReadOnly="true" Style="max-width: 100%" runat="server"></asp:TextBox>
                    </div>

                    <div class="input-group rowbr">
                        <span class="input-group-addon textwidth3">零件号</span>
                        <asp:TextBox ID="txt_pn" class="form-control" ReadOnly="true" Style="max-width: 100%" runat="server"></asp:TextBox>
                    </div>

                    <div class="input-group rowbr">
                        <span class="input-group-addon textwidth2">模号</span>
                        <asp:TextBox ID="txt_mono" class="form-control" ReadOnly="true"  Style="max-width: 100%" runat="server"></asp:TextBox>
                    </div>

              

                   

                </ContentTemplate>
                </asp:UpdatePanel>  

                <div class="">
                    <asp:Button ID="btnsave" class="btn btn-primary btn-lg btn-block" BackColor="#428bca" style="padding:10px 16px" runat="server" 
                        Text="报修" OnClick="btnsave_Click" OnClientClick="return valid();" />
                </div>
            
            
            </div>
        </div>
       
    </div>
    </form>
</body>
</html>

