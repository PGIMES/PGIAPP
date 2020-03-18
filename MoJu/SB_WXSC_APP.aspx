<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SB_WXSC_APP.aspx.cs" Inherits="MoJu_SB_WXSC_APP" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="lb_msg" runat="server" Text=""></asp:Label>
        <asp:GridView ID="GridView1" 
            AllowMultiColumnSorting="True" AllowPaging="True"
            AllowSorting="True" AutoGenerateColumns="False"
            OnPageIndexChanging="GridView1_PageIndexChanging"
            OnRowDataBound="GridView1_RowDataBound" Width="100%"
            runat="server" Font-Size="Small" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal">
            <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
            <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下页" PreviousPageText="上页" />
            <PagerStyle ForeColor="Black" BackColor="White" HorizontalAlign="Right" />
            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#EEEEEE" Font-Bold="false" ForeColor="Black" HorizontalAlign="left" />

            <Columns>     
                <asp:BoundField DataField="workshop" HeaderText="车间" ReadOnly="True">
                    <HeaderStyle Wrap="True" Width="25%" />
                </asp:BoundField>
                <asp:BoundField DataField="sc_day" HeaderText="本日" ReadOnly="True">
                    <HeaderStyle Wrap="True" Width="25%" />
                </asp:BoundField>
                <asp:BoundField DataField="sc_week" HeaderText="本周" ReadOnly="True">
                    <HeaderStyle Wrap="True" Width="25%" />
                </asp:BoundField>  
                <asp:BoundField DataField="sc_month" HeaderText="本月" ReadOnly="True">
                    <HeaderStyle Wrap="True" Width="25%" />
                </asp:BoundField>  
            </Columns>
            <SortedAscendingCellStyle BackColor="#F7F7F7" />
            <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
            <SortedDescendingCellStyle BackColor="#E5E5E5" />
            <SortedDescendingHeaderStyle BackColor="#242121" />
        </asp:GridView>
    </div>
    </form>
</body>
</html>
