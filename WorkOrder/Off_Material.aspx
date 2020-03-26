<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Off_Material.aspx.cs" Inherits="Off_Material" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>生产下线</title>
     <%--<script type="text/javascript" src="/js/jquery-3.0.0.min.js"></script>
    <script type="text/javascript" src="/js/jquery.form.min.js"></script>
    <script type="text/javascript" src="/js/json2.min.js"></script>
    <script type="text/javascript" src="/js/jweixin-1.2.0.js"></script>
    <script id="commonJsScript" type="text/javascript" src="/js/common.js?v=201810311922" ></script>
    <script type="text/javascript" src="/js/jquery.weixintools.js?v=201809201357"></script>--%>

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
        .textwidth2{
            padding-right:40px;
        }
        
        
    </style>
    <script>
        function valid() {
            if ($("#txt_qty").val() == "" || $("#txt_qty").val() == "0") {
                layer.alert("请输入处置数量.");
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
        <%--<div id="allContainer" class="menus-normal">
            <dl class="menus-module" style="background-color:#008083;height:66px;"> 
                
                <dt class="menus-title" style="background-color:#008083;height:66px">
                    <div  style="float:left;width:80%;border:0px solid #F00;">PGI产线作业-生产下线</div> 
                    <div style="float:left;width:18%;border:0px solid #000; text-align:right;"></div> 
                </dt> 

         
            </dl>
        </div> --%>

        
        <div class="row ">
            <div class="col-md-12">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
            
                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth1">当前岗位</span>
                    <asp:TextBox ID="txt_location" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                </div>

                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth2">登入人</span>
                    <asp:TextBox ID="txt_emp" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                </div>
              
                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth1" >当前产品</span>
                    <asp:TextBox ID="txt_xmh" class="form-control" ReadOnly="true" Style="max-width: 100%" runat="server"></asp:TextBox>
                </div>
               

                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth1">下料数量</span>
                    <asp:TextBox ID="txt_qty" class="form-control" type='number'  Style="max-width: 100%" runat="server"></asp:TextBox><%--AutoPostBack="True" OnTextChanged="txt_qty_TextChanged"--%>  
                </div>
                <div>
                   <asp:GridView ID="GridView1" 
                        AllowMultiColumnSorting="True" AllowPaging="True"
                        AllowSorting="True" AutoGenerateColumns="False"
                        OnPageIndexChanging="GridView1_PageIndexChanging"
                        runat="server" Font-Size="Small" Width="96%" style="margin-left:2%; margin-right:2%;" PageSize="5">
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <PagerSettings FirstPageText="首页" LastPageText="尾页"
                            Mode="NextPreviousFirstLast" NextPageText="下页" PreviousPageText="上页" />
                        <PagerStyle ForeColor="Red" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <EditRowStyle BackColor="#999999" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <HeaderStyle BackColor="#428bca" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />

                        <Columns>  
                            <asp:BoundField DataField="lot_no" HeaderText="Lot No" ReadOnly="True" ItemStyle-Width="20%">
                                <HeaderStyle Wrap="True" />
                            </asp:BoundField> 
                            <asp:BoundField DataField="qty" HeaderText="已上料数" ReadOnly="True" ItemStyle-Width="20%">
                                <HeaderStyle Wrap="True" />
                            </asp:BoundField> 
                            <asp:BoundField DataField="go_qty" HeaderText="生产中" ReadOnly="True" ItemStyle-Width="15%">
                                <HeaderStyle Wrap="True" />
                            </asp:BoundField>  
                            <asp:BoundField DataField="off_qty" HeaderText="已下料数" ReadOnly="True" ItemStyle-Width="20%">
                                <HeaderStyle Wrap="True" />
                            </asp:BoundField> 
                            <asp:BoundField DataField="bhg_qty" HeaderText="不合格申请数" ReadOnly="True" ItemStyle-Width="25%">
                                <HeaderStyle Wrap="True" />
                            </asp:BoundField>   
                        </Columns>
                    </asp:GridView>

                </div>

                </ContentTemplate>
            </asp:UpdatePanel>
                <div class="">
                    <asp:Button ID="btnsave" class="btn btn-primary btn-lg btn-block" BackColor="#428bca" style="padding:10px 16px" runat="server" Text="下线" OnClick="btnsave_Click" OnClientClick="return valid();" />
                </div>
            
           
            </div>
        </div>
       
    </div>
    </form>
</body>
</html>

