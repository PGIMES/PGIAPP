<%@ Page Language="C#" AutoEventWireup="true" CodeFile="YL_list.aspx.cs" Inherits="WorkOrder_YL_list" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>生产要料监视</title>

    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <link href="/Content/bootstrap.min.css" rel="stylesheet" />
    <script src="/scripts/bootstrap.min.js"></script>

    <link href="/css/global.css?v=201802091428" rel="stylesheet" type="text/css" />
    <link href="/css/iconfont.css?v=201802091429" rel="stylesheet" type="text/css"/>
    <link href="/css/login.css?v=201802091428" rel="stylesheet" type="text/css"/>
    <link href="/css/comm.css?v=201802091429" rel="stylesheet" type="text/css"/>
    <link href="/css/theme.css?v=201805162207" rel="stylesheet" type="text/css"/>

    <script>
        function deal(need_no) {
            //alert(need_no);
            window.location.href = "/workorder/SL.aspx?need_no=" + need_no+"&workshop=<%=_workshop %>";
        }
        function deal_load_material() {
            //alert(need_no);
            window.location.href = "/workorder/Load_Material.aspx?need_no=" + need_no + "&workshop=<%=_workshop %>";
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="resume-setting-page normal-page-wrap"> 
        <%--<div id="allContainer" class="menus-normal">
            <dl class="menus-module" style="background-color:#008083;height:66px;">                 
                <dt class="menus-title" style="background-color:#008083;height:66px">
                    <div  style="float:left;width:80%;border:0px solid #F00;">PGI产线作业-生产要料监视</div> 
                    <div style="float:left;width:18%;border:0px solid #000; text-align:right;"></div> 
                </dt> 
            </dl>
        </div>--%> 
       
		    
        <div class="page-header" style="margin:15px 0 15px">
            <h4><%--要料中--%>
                <small><asp:Label ID="Label1" runat="server" Text="要料中"></asp:Label></small>
            </h4>
        </div>	    
        <asp:DataList ID="DataList1" RepeatColumns="1" runat="server" Width="100%" HorizontalAlign="Center" >
            <ItemTemplate>
                <table border="0" width="100%" align="center"style="border-bottom:1px solid gray;"  onclick=deal('<%# DataBinder.Eval(Container.DataItem, "need_no") %>')>
                    <tr>
                        <td width="40%">
                                <font style="font-weight:800;"><%# DataBinder.Eval(Container.DataItem, "need_date") %></font>
                        </td>
                        <td width="40%">
                            要料人:<%# DataBinder.Eval(Container.DataItem, "emp_code") %><%# DataBinder.Eval(Container.DataItem, "emp_name") %>
                        </td>
                        <td width="10%" rowspan="3" >
                            <img src="/img/arrow_large_right.png" />
                        </td>
                    </tr>
                    <tr>
                        <td width="40%">
                            <font color="blue"><%# DataBinder.Eval(Container.DataItem, "pgino") %></font>
                        </td>
                        <td width="40%">
                            <%# DataBinder.Eval(Container.DataItem, "pn") %>
                        </td>
                    </tr>
                    <tr>
                        <td width="40%">
                            <%# DataBinder.Eval(Container.DataItem, "need_no") %>
                        </td>
                        <td width="40%">
                            要料数量:<font color="blue"><%# DataBinder.Eval(Container.DataItem, "need_qty") %></font>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList>

        <div class="page-header" style="margin:15px 0 15px">
            <h4><%--部分送料中--%>
                <small><asp:Label ID="Label2" runat="server" Text="部分送料中"></asp:Label></small>
            </h4>
        </div>	    
        <asp:DataList ID="DataList2" RepeatColumns="1" runat="server" Width="100%" HorizontalAlign="Center" >
            <ItemTemplate>
                <table border="0" width="100%" align="center"style="border-bottom:1px solid gray;"  onclick=deal('<%# DataBinder.Eval(Container.DataItem, "need_no") %>')>
                    <tr>
                        <td width="40%">
                                <font style="font-weight:800;"><%# DataBinder.Eval(Container.DataItem, "need_date") %></font>
                        </td>
                        <td width="40%">
                            要料人:<%# DataBinder.Eval(Container.DataItem, "emp_code") %><%# DataBinder.Eval(Container.DataItem, "emp_name") %>
                        </td>
                        <td width="10%" rowspan="3" >
                            <img src="/img/arrow_large_right.png" />
                        </td>
                    </tr>
                    <tr>
                        <td width="40%">
                            <font color="blue"><%# DataBinder.Eval(Container.DataItem, "pgino") %></font>
                        </td>
                        <td width="40%">
                            <%# DataBinder.Eval(Container.DataItem, "pn") %>
                        </td>
                    </tr>
                    <tr>
                        <td width="40%">
                            <%# DataBinder.Eval(Container.DataItem, "need_no") %>
                        </td>
                        <td width="40%">
                            要料数量:<%# DataBinder.Eval(Container.DataItem, "need_qty") %><br />
                            已送数量:<%# DataBinder.Eval(Container.DataItem, "act_qty") %><br />
                            剩余数量:<font color="red"><%# DataBinder.Eval(Container.DataItem, "sy_qty") %></font><br />
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList>

        <div class="page-header" style="margin:15px 0 15px">
            <h4><%--已送料--%>
                <small><asp:Label ID="Label3" runat="server" Text="已送料"></asp:Label></small>
            </h4>
        </div>	    
        <asp:DataList ID="DataList3" RepeatColumns="1" runat="server" Width="100%" HorizontalAlign="Center" >
            <ItemTemplate>
                <table border="0" width="100%" align="center"style="border-bottom:1px solid gray;"  onclick=deal_load_material('<%# DataBinder.Eval(Container.DataItem, "need_no") %>')>
                    <tr>
                        <td width="40%">
                                <font style="font-weight:800;"><%# DataBinder.Eval(Container.DataItem, "need_date") %></font>
                        </td>
                        <td width="40%">
                            要料人:<%# DataBinder.Eval(Container.DataItem, "emp_code") %><%# DataBinder.Eval(Container.DataItem, "emp_name") %>
                        </td>
                        <td width="10%" rowspan="3" >
                            <img src="/img/arrow_large_right.png" />
                        </td>
                    </tr>
                    <tr>
                        <td width="40%">
                            <font color="blue"><%# DataBinder.Eval(Container.DataItem, "pgino") %></font>
                        </td>
                        <td width="40%">
                            <%# DataBinder.Eval(Container.DataItem, "pn") %>
                        </td>
                    </tr>
                    <tr>
                        <td width="40%">
                            <%# DataBinder.Eval(Container.DataItem, "need_no") %>
                        </td>
                        <td width="40%">
                            要料数量:<%# DataBinder.Eval(Container.DataItem, "need_qty") %><br />
                            已送数量:<%# DataBinder.Eval(Container.DataItem, "act_qty") %><br />
                            取消数量:<font color="blue"><%# DataBinder.Eval(Container.DataItem, "qx_qty") %></font>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList>
			    
		    
	   

    </div>
    </form>
</body>
</html>
