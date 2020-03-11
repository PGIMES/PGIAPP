<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bhgp_deal_list.aspx.cs" Inherits="bhgp_deal_list" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title></title>


    <link href="/css/global.css?v=201802091428" rel="stylesheet" type="text/css">
    <link href="/css/iconfont.css?v=201802091429" rel="stylesheet" type="text/css">
    <link href="/css/login.css?v=201802091428" rel="stylesheet" type="text/css">
    <link href="/css/comm.css?v=201802091429" rel="stylesheet" type="text/css">
    <link href="/css/theme.css?v=201805162207" rel="stylesheet" type="text/css">

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager runat="server">
    </asp:ScriptManager>
    <div class="resume-setting-page normal-page-wrap"> 
        <div id="allContainer" class="menus-normal">
            <dl class="menus-module" style="background-color:#008083;height:66px;">                 
                <dt class="menus-title" style="background-color:#008083;height:66px">
                    <div  style="float:left;width:80%;border:0px solid #F00;">PGI产线作业-不合格品处置-待处理</div> 
                    <div style="float:left;width:18%;border:0px solid #000; text-align:right;"><%--<a href="/Index.aspx"><img src="/img/home.png" width="22px" height="22px" style="text-align:right;"></a>--%></div> 
                </dt> 
            </dl>
        </div> 
        <div class="row ">
            <div class="col-md-12">
                <asp:Label ID="lb_msg" runat="server" Text=""></asp:Label>
                <asp:GridView ID="GridView1" 
                    AllowMultiColumnSorting="True" AllowPaging="True"
                    AllowSorting="True" AutoGenerateColumns="False"
                    OnPageIndexChanging="GridView1_PageIndexChanging"
                    OnRowDataBound="GridView1_RowDataBound" Width="100%"
                    runat="server"
                    OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Font-Size="Small" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal">
                    <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                    <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下页" PreviousPageText="上页" />
                    <PagerStyle ForeColor="Black" BackColor="White" HorizontalAlign="Right" />
                    <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#EEEEEE" Font-Bold="false" ForeColor="Black" HorizontalAlign="Center" />

                    <Columns>                                
                        <asp:CommandField ButtonType="Button" SelectText="选择" ItemStyle-HorizontalAlign="Center"
                            ShowSelectButton="True" HeaderText="选择" >
                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                        </asp:CommandField>
                        <asp:BoundField DataField="workorder" HeaderText="单号" ReadOnly="True">
                            <HeaderStyle Wrap="True" />
                        </asp:BoundField>
                        <asp:BoundField DataField="pgino" HeaderText="当前产品" ReadOnly="True">
                            <HeaderStyle Wrap="True" />
                        </asp:BoundField>
                        <asp:BoundField DataField="qty" HeaderText="处置数量" ReadOnly="True">
                            <HeaderStyle Wrap="True" />
                        </asp:BoundField>  
                        <asp:BoundField DataField="off_qty" HeaderText="已处置数量" ReadOnly="True">
                            <HeaderStyle Wrap="True" />
                        </asp:BoundField>  
                       <%-- <asp:BoundField DataField="op" HeaderText="工序" ReadOnly="True">
                            <HeaderStyle Wrap="True" />
                        </asp:BoundField> --%>
                        <asp:BoundField DataField="emp_name" HeaderText="申请人" ReadOnly="True">
                            <HeaderStyle Wrap="True" />
                        </asp:BoundField> 
                    </Columns>
                    <SortedAscendingCellStyle BackColor="#F7F7F7" />
                    <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                    <SortedDescendingCellStyle BackColor="#E5E5E5" />
                    <SortedDescendingHeaderStyle BackColor="#242121" />
                </asp:GridView>
            </div>
        </div>



    </div>
    </form>
</body>
</html>
