<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SL.aspx.cs" Inherits="WorkOrder_SL" %>

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
            padding-right:53px;
        }        
        .textwidth2{
            padding-right:40px;
        }
        .textwidth3{
            padding-right:67px;
        } 
        .textwidth4{
            padding-right:25px;
        } 
        .textwidth5{
            padding-right:53px;
        } 
        
        
    </style>

</head>
<body>
    <form id="form1" runat="server">
    <div class="resume-setting-page normal-page-wrap"> 
        <div id="allContainer" class="menus-normal">
            <dl class="menus-module" style="background-color:#008083;height:66px;"> 
                
                <dt class="menus-title" style="background-color:#008083;height:66px">
                    <div  style="float:left;width:80%;border:0px solid #F00;">PGI产线作业-仓库送料</div> 
                    <div style="float:left;width:18%;border:0px solid #000; text-align:right;"><%--<a href="/workorder/bhgp_deal_list.aspx"><img src="/img/home.png" width="22px" height="22px" style="text-align:right;"></a>--%></div> 
                </dt> 

         
            </dl>
        </div> 

        <div class="row ">
            <div class="col-md-12">
                <asp:TextBox ID="emp_code_name" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server" Visible="false"></asp:TextBox>

                <div class="input-group rowbr">
                    <span class="input-group-addon">要求送到时间</span>
                    <asp:TextBox ID="need_date" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                    <asp:TextBox ID="need_no" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server" Visible="false"></asp:TextBox>
                </div>

                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth1">要料人</span>
                    <asp:TextBox ID="yl_emp" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                </div>

                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth4">要料人时间</span>
                    <asp:TextBox ID="req_date" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                </div>

                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth3">车间</span>
                    <asp:TextBox ID="workshop" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                </div>

                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth1">生产线</span>
                    <asp:TextBox ID="line" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                </div>

                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth1">物料号</span>
                    <asp:TextBox ID="pgino" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                </div>

                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth1">零件号</span>
                    <asp:TextBox ID="pn" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                </div>

                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth2">要料数量</span>
                    <asp:TextBox ID="need_qty" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                </div>

                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth2">已送数量</span>
                    <asp:TextBox ID="act_qty" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                </div>

                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth2">剩余数量</span>
                    <asp:TextBox ID="sy_qty" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                </div>

                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth5">Lot No</span>
                    <asp:TextBox ID="lot_no" class="form-control" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                </div>

                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth3">数量</span>
                    <asp:TextBox ID="qty" class="form-control" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                </div>

                <div class="input-group-addon">
                    <asp:Button ID="btn_sl" class="btn btn-primary btn-lg" BackColor="#428bca" style="padding:10px 16px" runat="server" 
                        Text="送&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;料" OnClick="btn_sl_Click" OnClientClick="return valid_next();"/> 
                     <asp:Button ID="btn_cancel" class="btn btn-primary btn-lg" BackColor="#428bca" style="padding:10px 16px" runat="server" 
                        Text="取消送料" OnClick="btn_cancel_Click"/>
                </div>


            </div>
        </div>

    </div>
    </form>
</body>
</html>
