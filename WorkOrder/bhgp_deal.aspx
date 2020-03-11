<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bhgp_deal.aspx.cs" Inherits="bhgp_deal" %>

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
        
        
    </style>
    <script>
        function valid() {
            if ($("#b_source").val() == "") {
                alert("请选择是【来源】.");
                return false;
            }
            if ($("input[id*=qty]").val() == "") {
                alert("请输入处置数量.");
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
                    <div  style="float:left;width:80%;border:0px solid #F00;">PGI产线作业-不合格品处置申请</div> 
                    <div style="float:left;width:18%;border:0px solid #000; text-align:right;"><%--<a href="/Index.aspx"><img src="/img/home.png" width="22px" height="22px" style="text-align:right;"></a>--%></div> 
                </dt> 

         
            </dl>
        </div> 

        
        <div class="row ">
            <div class="col-md-12">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
            
                    <div class="input-group rowbr">
                        <span class="input-group-addon textwidth1">登入人</span>
                        <asp:TextBox ID="emp_code_name" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                    </div>

                    <div class="input-group rowbr">
                        <span class="input-group-addon textwidth2" >单号</span>
                        <asp:TextBox ID="workorder" class="form-control" placeholder="请输入不合格品处置单号" Style="max-width: 100%" runat="server"></asp:TextBox>
                    </div>
                    <div class="input-group rowbr">
                        <span class="input-group-addon">当前产品</span>
                        <asp:DropDownList ID="pgino" runat="server" class="form-control" Style="max-width: 100%" AutoPostBack="true" OnSelectedIndexChanged="pgino_SelectedIndexChanged"></asp:DropDownList>
                    </div>
                
                    <div class="input-group rowbr">
                        <span class="input-group-addon textwidth2">来源</span>
                         <%--<span class="form-control">
                            <label class="checkbox-inline">
                                <input type="radio" name="b_source" id="b_source1" value="生产现场" runat="server">生产现场
                            </label>
                            <label class="checkbox-inline">
                                <input type="radio" name="b_source" id="b_source2" value="线边库" runat="server">线边库
                            </label>
                            <label class="checkbox-inline">
                                <input type="radio" name="b_source" id="b_source3" value="终检" runat="server">终检
                            </label>
                        </span>--%>
                        
                        <asp:DropDownList ID="b_source" runat="server" class="form-control" Style="max-width: 100%" ></asp:DropDownList>
                    </div>

                    <div class="input-group rowbr">
                        <span class="input-group-addon textwidth2">工序</span>
                        <%--<asp:TextBox ID="op" class="form-control" placeholder="请输入工序" Style="max-width: 100%" runat="server"></asp:TextBox>--%>
                        <asp:DropDownList ID="op" runat="server" class="form-control" Style="max-width: 100%"></asp:DropDownList>
                    </div>

                    <div class="input-group rowbr">
                        <span class="input-group-addon">处置数量</span>
                        <asp:TextBox ID="qty" class="form-control" placeholder="请输入处置数量" Style="max-width: 100%" runat="server"></asp:TextBox>
                    </div>

                </ContentTemplate>
                </asp:UpdatePanel>  

                <div class="">
                    <asp:Button ID="btnsave" class="btn btn-primary btn-lg btn-block" BackColor="#428bca" style="padding:10px 16px" runat="server" 
                        Text="提交" OnClick="btnsave_Click" OnClientClick="return valid();" />
                </div>
            
            
            </div>
        </div>
       
    </div>
    </form>
</body>
</html>
