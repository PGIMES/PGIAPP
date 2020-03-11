<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bhgp_deal_list_new.aspx.cs" Inherits="bhgp_deal_list_new" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title></title>
    
    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <link href="/Content/bootstrap.min.css" rel="stylesheet" />
    <script src="/scripts/bootstrap.min.js"></script>

    <link href="/css/global.css?v=201802091428" rel="stylesheet" type="text/css" />
    <link href="/css/iconfont.css?v=201802091429" rel="stylesheet" type="text/css"/>
    <link href="/css/login.css?v=201802091428" rel="stylesheet" type="text/css"/>
    <link href="/css/comm.css?v=201802091429" rel="stylesheet" type="text/css"/>
    <link href="/css/theme.css?v=201805162207" rel="stylesheet" type="text/css"/>

    <script>
        function deal(workorder) {
            //alert(workorder);
            window.location.href = "/workorder/bhgp_deal_result.aspx?workorder=" + workorder + "&next=N";    
        }
    </script>
    
</head>
<body>
    <form id="form1" runat="server">
    <div class="resume-setting-page normal-page-wrap"> 
        <div id="allContainer" class="menus-normal">
            <dl class="menus-module" style="background-color:#008083;height:66px;">                 
                <dt class="menus-title" style="background-color:#008083;height:66px">
                    <div  style="float:left;width:80%;border:0px solid #F00;">PGI产线作业-不合格品处置-待处理2</div> 
                    <div style="float:left;width:18%;border:0px solid #000; text-align:right;"><%--<a href="/Index.aspx"><img src="/img/home.png" width="22px" height="22px" style="text-align:right;"></a>--%></div> 
                </dt> 
            </dl>
        </div> 
        <%--<div class="row ">
            <div class="col-md-12">
                
            </div>
        </div>--%>

        <ul class="nav nav-tabs col-xs-12">
	       <li class="active col-xs-6"><a href="#tab1" data-toggle="tab">待处理</a></li>
	       <li class=" col-xs-6"><a href="#tab2" data-toggle="tab">已完成</a></li>
        </ul>
        <div class="tab-content">
		    <div class="tab-pane active" id="tab1" style="margin-left:8px;margin-right:8px;">		
                <div class="page-header" style="margin:15px 0 15px">
                    <h4><%--待处理--%>
                        <small><asp:Label ID="Label1" runat="server" Text="未处理"></asp:Label></small>
                    </h4>
                </div>	    
                <asp:DataList ID="DataList1" RepeatColumns="1" runat="server" Width="100%" HorizontalAlign="Center" >
                    <ItemTemplate>
                        <table border="0" width="100%" align="center"style="border-bottom:1px solid gray;"  onclick=deal('<%# DataBinder.Eval(Container.DataItem, "workorder") %>')>
                            <tr>
                                <td width="25%">
                                    <%--<a href='/workorder/bhgp_deal_result.aspx?workorder=<%# DataBinder.Eval(Container.DataItem, "workorder") %>&next=N'>
                                        <font style="font-weight:800;"><%# DataBinder.Eval(Container.DataItem, "workorder") %></font>
                                    </a>--%>
                                        <font style="font-weight:800;"><%# DataBinder.Eval(Container.DataItem, "workorder") %></font>
                                </td>
                                <td width="25%">
                                    <%# DataBinder.Eval(Container.DataItem, "pgino") %>
                                </td>
                                <td width="40%" >
                                    <%# DataBinder.Eval(Container.DataItem, "pn") %>
                                </td>
                                <td width="10%" rowspan="3" >
                                    <img src="/img/arrow_large_right.png" />
                                </td>
                            </tr>
                            <tr>
                                <td width="45%" colspan="2" >
                                    处置数量
                                    <font color="blue"><%# DataBinder.Eval(Container.DataItem, "qty") %></font>
                                </td>
                                <td width="45%" >
                                    已处置数量
                                    <font color="blue"><%# DataBinder.Eval(Container.DataItem, "off_qty") %></font>
                                </td>
                            </tr>
                            <tr style="color:#999">
                                <td width="90%" colspan="3" >
                                    工序<%# DataBinder.Eval(Container.DataItem, "op") %>-
                                    <%# DataBinder.Eval(Container.DataItem, "op_descr") %>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>

                <div class="page-header" style="margin:15px 0 15px">
                    <h4><%--待处理--%>
                        <small><asp:Label ID="Label2" runat="server" Text="处理中"></asp:Label></small>
                    </h4>
                </div>	    
                <asp:DataList ID="DataList2" RepeatColumns="1" runat="server" Width="100%" HorizontalAlign="Center" >
                    <ItemTemplate>
                        <table border="0" width="100%" align="center"style="border-bottom:1px solid gray;"  onclick=deal('<%# DataBinder.Eval(Container.DataItem, "workorder") %>')>
                            <tr>
                                <td width="25%">
                                    <%--<a href='/workorder/bhgp_deal_result.aspx?workorder=<%# DataBinder.Eval(Container.DataItem, "workorder") %>&next=N'>
                                        <font style="font-weight:800;"><%# DataBinder.Eval(Container.DataItem, "workorder") %></font>
                                    </a>--%>
                                        <font style="font-weight:800;"><%# DataBinder.Eval(Container.DataItem, "workorder") %></font>
                                </td>
                                <td width="25%">
                                    <%# DataBinder.Eval(Container.DataItem, "pgino") %>
                                </td>
                                <td width="40%" >
                                    <%# DataBinder.Eval(Container.DataItem, "pn") %>
                                </td>
                                <td width="10%" rowspan="3" >
                                    <img src="/img/arrow_large_right.png" />
                                </td>
                            </tr>
                            <tr>
                                <td width="45%" colspan="2" >
                                    处置数量
                                    <font color="blue"><%# DataBinder.Eval(Container.DataItem, "qty") %></font>
                                </td>
                                <td width="45%" >
                                    已处置数量
                                    <font color="blue"><%# DataBinder.Eval(Container.DataItem, "off_qty") %></font>
                                </td>
                            </tr>
                            <tr style="color:#999">
                                <td width="90%" colspan="3" >
                                    工序<%# DataBinder.Eval(Container.DataItem, "op") %>-
                                    <%# DataBinder.Eval(Container.DataItem, "op_descr") %>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>
			    
		    </div>
		    <div class="tab-pane" id="tab2">
			    <p> 我是已完成    
		    </div>
		    <div class="tab-pane" id="tab2">
			    <p> 我是已完成 </p>
		    </div>
	    </div>

    </div>
    </form>
</body>
</html>
