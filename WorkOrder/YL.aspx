<%@ Page Language="C#" AutoEventWireup="true" CodeFile="YL.aspx.cs" Inherits="YL" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title></title>

    <link href="/Content/bootstrap.min.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <script src="/Content/laydate/laydate.js"></script>
    <script src="/Content/layer/layer.js"></script>

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
        /*.textwidth2{
            padding-right:40px;
        }*/
        
        
    </style>
    <script>
        function valid() {
            //if ($("#b_source").val() == "") {
            //    layer.alert("请选择是【来源】.");
            //    return false;
            //}
            //if ($("input[id*=qty]").val() == "") {
            //    layer.alert("请输入处置数量.");
            //    return false;
            //}
            //return true;
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
                    <div  style="float:left;width:80%;border:0px solid #F00;">PGI产线作业-生产要料</div> 
                    <div style="float:left;width:18%;border:0px solid #000; text-align:right;"><%--<a href="/Index.aspx"><img src="/img/home.png" width="22px" height="22px" style="text-align:right;"></a>--%></div> 
                </dt> 

         
            </dl>
        </div> 

        
        <div class="row ">
            <div class="col-md-12">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
            
                    <div class="input-group rowbr">
                        <span class="input-group-addon textwidth1">物料号</span>
                        <span style="float:left; width:90%">
                            <asp:TextBox ID="pgino" class="form-control" placeholder="请输入不合格品处置单号" Style="max-width: 100%" runat="server"></asp:TextBox>
                        </span>
                        <span style="float:left; width:10%">
                            <img id="img_sm" src="../img/fdj.gif" style="padding-top:10px;" />
                        </span>
                    </div>

                    <div class="input-group rowbr">
                        <span class="input-group-addon textwidth1" >零件号</span>                       
                        <asp:TextBox ID="pn" class="form-control" placeholder="" ReadOnly="true" Style="max-width: 100%" runat="server"></asp:TextBox>
                    </div>

                    <div class="input-group rowbr">
                        <span class="input-group-addon " >物料名称</span>                       
                        <asp:TextBox ID="descr" class="form-control" placeholder="" ReadOnly="true" Style="max-width: 100%" runat="server"></asp:TextBox>
                    </div>

                    <div class="input-group rowbr">
                        <span class="input-group-addon">要料数量</span>
                        <asp:TextBox ID="qty" class="form-control" placeholder="请输入要料数量" Style="max-width: 100%" runat="server"></asp:TextBox>
                    </div>

                    <div class="input-group rowbr">
                        <span class="input-group-addon">送到时间</span>
                        <asp:TextBox ID="TextBox1" class="form-control" placeholder="请输入送到时间" Style="max-width: 100%" runat="server"
                            onclick="laydate({format: 'YYYY/MM/DD hh:mm',istime:true,start:laydate.now(),min:laydate.now()});" ></asp:TextBox>
                    </div>
                    
                    <div class="input-group rowbr">
                        <span class="input-group-addon">送到时间2</span>
                        
                    </div>

                </ContentTemplate>
                </asp:UpdatePanel>  

                <div class="">
                    <asp:Button ID="btnsave" class="btn btn-primary btn-lg btn-block" BackColor="#428bca" style="padding:10px 16px" runat="server" 
                        Text="确认" OnClick="btnsave_Click" OnClientClick="return valid();" />
                </div>
            
            
            </div>
        </div>
       
    </div>
    </form>
</body>
</html>
