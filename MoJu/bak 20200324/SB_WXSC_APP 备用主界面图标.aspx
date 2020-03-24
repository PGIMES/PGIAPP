<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SB_WXSC_APP 备用主界面图标.aspx.cs" Inherits="MoJu_SB_WXSC_APP" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>设备报修统计</title>
    <link rel="stylesheet" href="/css/weui.css"/>
    <link rel="stylesheet" href="/css/weuix.css"/>
    
    <script src="/js/zepto.min.js"></script>
    <script src="/js/zepto.weui.js"></script>
    <script src="/js/f2.min.js"></script>
    <style>
        .weui-table td, .weui-table th, table td, table th{
            padding:5px;
            line-height:12px;
        }
        .td1{
            text-align:right;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <%--<div style="text-align:center;"><h3>设备报修统计</h3></div>--%>
        <asp:Label ID="lb_msg" runat="server" Text=""></asp:Label>
        <asp:GridView ID="GridView1" 
            AllowMultiColumnSorting="True" AllowPaging="True"
            AllowSorting="True" AutoGenerateColumns="False"
            OnPageIndexChanging="GridView1_PageIndexChanging"
            OnRowDataBound="GridView1_RowDataBound" Width="100%" PageSize="10"
            runat="server" Font-Size="Small" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal">
            <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
            <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下页" PreviousPageText="上页" />
            <PagerStyle ForeColor="Black" BackColor="White" HorizontalAlign="Right" />
            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#EEEEEE" Font-Bold="false" ForeColor="Black" />

            <Columns>     
                <asp:BoundField DataField="workshop" HeaderText="车间" ReadOnly="True">
                    <HeaderStyle Wrap="True" Width="25%" HorizontalAlign="left" />
                </asp:BoundField>
                <asp:BoundField DataField="sc_day" HeaderText="本日" ReadOnly="True">
                    <HeaderStyle Wrap="True" Width="25%" CssClass="td1"  />
                    <ItemStyle CssClass="td1" />
                </asp:BoundField>
                <asp:BoundField DataField="sc_week" HeaderText="本周" ReadOnly="True">
                    <HeaderStyle Wrap="True" Width="25%" CssClass="td1" />
                    <ItemStyle CssClass="td1" />
                </asp:BoundField>  
                <asp:BoundField DataField="sc_month" HeaderText="本月" ReadOnly="True">
                    <HeaderStyle Wrap="True" Width="25%" CssClass="td1" />
                    <ItemStyle CssClass="td1" />
                </asp:BoundField>  
            </Columns>
            <SortedAscendingCellStyle BackColor="#F7F7F7" />
            <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
            <SortedDescendingCellStyle BackColor="#E5E5E5" />
            <SortedDescendingHeaderStyle BackColor="#242121" />
        </asp:GridView>

        <input id="btn_workshop" type="button" value="分车间" class="weui-btn weui-btn_mini weui-btn_primary" />
        <input id="btn_workshop_all" type="button" value="全部车间" class="weui-btn weui-btn_mini weui-btn_default" />


        <div class="page-bd-15">
            <canvas id="myChart" height="260" style="width:95%;"></canvas>
            <script>

                

                $(document).ready(function () {
                    $.ajax({
                        type: "post",
                        url: "SB_WX_Chart_APP.aspx/init",
                        data: "{'type':'day'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                        success: function (data) {
                            var obj = eval(data.d);
                            data_day = obj[0].json_day;
                        }

                    });

                    $.ajax({
                        type: "post",
                        url: "SB_WX_Chart_APP.aspx/init",
                        data: "{'type':'week_month'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                        success: function (data) {
                            var obj = eval(data.d);
                            data_week = obj[0].json_week;
                            data_month = obj[0].json_month;
                        }

                    });

                });


            </script>
        </div>

        <input id="btn_day" type="button" value="近12日" class="weui-btn weui-btn_mini weui-btn_primary" />
        <input id="btn_week" type="button" value="近12周" class="weui-btn weui-btn_mini weui-btn_default" />
        <input id="btn_month" type="button" value="近12月" class="weui-btn weui-btn_mini weui-btn_default" />
    </div>
    </form>
</body>
</html>
