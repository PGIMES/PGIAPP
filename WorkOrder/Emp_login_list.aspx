<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Emp_Login_list.aspx.cs" Inherits="WorkOrder_Emp_Login_list" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>上岗监视</title>

    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <link href="/Content/bootstrap.min.css" rel="stylesheet" />
    <script src="/scripts/bootstrap.min.js"></script>

    <link href="/css/global.css?v=201802091428" rel="stylesheet" type="text/css" />
    <link href="/css/iconfont.css?v=201802091429" rel="stylesheet" type="text/css"/>
    <link href="/css/login.css?v=201802091428" rel="stylesheet" type="text/css"/>
    <link href="/css/comm.css?v=201802091429" rel="stylesheet" type="text/css"/>
    <link href="/css/theme.css?v=201805162207" rel="stylesheet" type="text/css"/>
    <style>
        .nav-tabs>li.active>a, .nav-tabs>li.active>a:hover, .nav-tabs>li.active>a:focus{
            border:unset;
            background-color:transparent;
            border-bottom:2px solid #07c160;
            color:#07c160;
        }
    </style>

    
</head>
<body>
    <form id="form1" runat="server">
    <div class="resume-setting-page normal-page-wrap"> 
	   
        <ul class="nav nav-tabs col-xs-12">
	       <li class="active col-xs-6"><a href="#tab1" data-toggle="tab">上岗监视</a></li>
	       <li class=" col-xs-6"><a href="#tab2" data-toggle="tab">我的上岗</a></li>
        </ul>
        <div class="tab-content">
		    <div class="tab-pane active" id="tab1" style="margin-left:8px;margin-right:8px;">		
                
                <asp:DataList ID="DataList1_M" RepeatColumns="1" runat="server" Width="100%" HorizontalAlign="Center" OnItemDataBound="DataList1_M_ItemDataBound" >
                    <ItemTemplate>
                        <h4><%# DataBinder.Eval(Container.DataItem, "line") %></h4>
                        <asp:DataList ID="DataList1" RepeatColumns="1" runat="server" Width="100%" HorizontalAlign="Center" >
                            <ItemTemplate>
                                <table border="0" width="100%" align="center"style="border-bottom:1px solid gray;">
                                    <tr>
                                        <td width="100%" colspan="2">
                                                <font style="font-weight:800;"><%# DataBinder.Eval(Container.DataItem, "location") %></font>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td width="50%">
                                            <font color="blue"><%# DataBinder.Eval(Container.DataItem, "phone") %></font>
                                        </td>
                                        <td width="50%">
                                           <%# DataBinder.Eval(Container.DataItem, "emp_name") %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="50%">
                                            <font color="blue"><%# DataBinder.Eval(Container.DataItem, "on_date") %></font>
                                        </td>
                                        <td width="50%">
                                           时长:<%# DataBinder.Eval(Container.DataItem, "times") %>
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:DataList>
                    </ItemTemplate>
                </asp:DataList>
                
			    
		    </div>
		    <div class="tab-pane" id="tab2">
                <div class="page-header" style="margin:15px 0 15px">
                    <h4><%--上岗中--%>
                        <small><asp:Label ID="Label2" runat="server" Text="上岗中"></asp:Label></small>
                    </h4>
                </div>	    
                <asp:DataList ID="DataList2" RepeatColumns="1" runat="server" Width="100%" HorizontalAlign="Center" >
                    <ItemTemplate>
                        <table border="0" width="100%" align="center"style="border-bottom:1px solid gray;">
                            <tr>
                                <td width="100%" colspan="2">
                                        <font style="font-weight:800;"><%# DataBinder.Eval(Container.DataItem, "location") %></font>
                                </td>
                            </tr>
                             <tr>
                                <td width="50%">
                                    <font color="blue"><%# DataBinder.Eval(Container.DataItem, "phone") %></font>
                                </td>
                                <td width="50%">
                                   <%# DataBinder.Eval(Container.DataItem, "emp_name") %>
                                </td>
                            </tr>
                            <tr>
                                <td width="50%">
                                    <font color="blue"><%# DataBinder.Eval(Container.DataItem, "on_date") %></font>
                                </td>
                                <td width="50%">
                                   时长:<%# DataBinder.Eval(Container.DataItem, "times") %>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>

                <div class="page-header" style="margin:15px 0 15px">
                    <h4><%--已下岗本月--%>
                        <small><asp:Label ID="Label3" runat="server" Text="已下岗本月"></asp:Label></small>
                    </h4>
                </div>	  
                <asp:DataList ID="DataList3" RepeatColumns="1" runat="server" Width="100%" HorizontalAlign="Center" >
                    <ItemTemplate>
                        <table border="0" width="100%" align="center"style="border-bottom:1px solid gray;"> 
                            <tr>
                                <td width="100%" colspan="2">
                                        <font style="font-weight:800;"><%# DataBinder.Eval(Container.DataItem, "location") %></font>
                                </td>
                            </tr>
                             <tr>
                                <td width="50%">
                                    <%# DataBinder.Eval(Container.DataItem, "phone") %>
                                </td>
                                <td width="50%">
                                   <%# DataBinder.Eval(Container.DataItem, "emp_name") %>
                                </td>
                            </tr>
                            <tr>
                                <td width="50%">
                                    <font color="blue"><%# DataBinder.Eval(Container.DataItem, "on_date") %></font>
                                </td>
                                <td width="50%">
                                   时长:<%# DataBinder.Eval(Container.DataItem, "times") %>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>

                 <div class="page-header" style="margin:15px 0 15px">
                    <h4><%--已下岗上月--%>
                        <small><asp:Label ID="Label4" runat="server" Text="已下岗上月"></asp:Label></small>
                    </h4>
                </div>	  
                <asp:DataList ID="DataList4" RepeatColumns="1" runat="server" Width="100%" HorizontalAlign="Center" >
                    <ItemTemplate>
                        <table border="0" width="100%" align="center"style="border-bottom:1px solid gray;"> 
                            <tr>
                                <td width="100%" colspan="2">
                                        <font style="font-weight:800;"><%# DataBinder.Eval(Container.DataItem, "location") %></font>
                                </td>
                            </tr>
                             <tr>
                                <td width="50%">
                                    <%# DataBinder.Eval(Container.DataItem, "phone") %>
                                </td>
                                <td width="50%">
                                   <%# DataBinder.Eval(Container.DataItem, "emp_name") %>
                                </td>
                            </tr>
                            <tr>
                                <td width="50%">
                                    <font color="blue"><%# DataBinder.Eval(Container.DataItem, "on_date") %></font>
                                </td>
                                <td width="50%">
                                   时长:<%# DataBinder.Eval(Container.DataItem, "times") %>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>

		    </div>
	    </div>

    </div>
    </form>
</body>
</html>
