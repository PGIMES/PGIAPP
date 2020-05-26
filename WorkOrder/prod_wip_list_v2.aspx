<%@ Page Language="C#" AutoEventWireup="true" CodeFile="prod_wip_list_v2.aspx.cs" Inherits="prod_wip_list_v2" %>
 
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>生产监视</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0" />
    <link rel="stylesheet" href="../css/weui.css" />
    <link rel="stylesheet" href="../css/weuix.css?v=1.2" />
    <style>
        .weui-mark-lt {
            color: #fff;
            display: block;
            font-size: 0.775em !important;
            left: -2.5em;
            height: 1em;
            line-height: 1em !important;
            position: relative;
            text-align: center;
            top: 0.25em;
            transform: rotate(-45deg);
            width: 3.375em;
            padding: 0.125em;
        }

        table td {
            padding-bottom: 0px;
            padding-top: 0px;
            border: 0px hidden white;
        }
        .span_space{
            padding-right:20px
        }
    </style>

    <script src="../js/zepto.min.js"></script>
    <script src="../js/zepto.weui.js"></script>
    <script src="../js/iscroll-lite.js"></script>

    <script>

        $(function () {

           //// var _index = window.localStorage.getItem("_tabindex");
            $('#t2').tab({
                defaultIndex:0,// _index == null ? 0 : _index,
                activeClass: 'tab-green',
                onToggle: function (index) {
                    //console.log('index' + index);
                }
            })

            $(document.body).pullToRefresh({
                distance: 10,
                onRefresh: function () {
                    //$.post("../php/page.php", { "page": 1, "pagesize": 8, ajax: 2 }, function (rs) {
                    //    $("#rank-list").html(tpl(document.getElementById('tpl').innerHTML, rs));
                    //}, 'json')
                    window.location.reload();
                    $(document.body).pullToRefreshDone();
                }
            });


        })

 
    </script>
</head>
<body ontouchstart >
   

    <div class="weui-pull-to-refresh__layer">
        <div class='weui-pull-to-refresh__arrow'></div>
        <div class='weui-pull-to-refresh__preloader'></div>
        <div class="down">下拉刷新</div>
        <div class="up">释放刷新</div>
        <div class="refresh">正在刷新</div>
    </div>
    <form id="form1" runat="server">
        <div class="page">
            <div class="page__bd" id="t2" style="height: 100%;">
                <div class="weui-tab">
                    <%--<div class="weui-navbar hide">
                        <div href="#tab1" class="weui-navbar__item weui-bar__item_on">
                            生产监视
                        </div>
                        <div href="#tab2" class="weui-navbar__item">
                            我的生产
                        </div>
                    </div>--%>

                    <div class="weui-tab__panel" style="background-color: lightgray">
                        <%--==生产监视==--%>
                        <div id="tab1" class="weui-tab__content">
                            <%----生产中-----%>
                             <div class="weui-form-preview">
                                <div class="weui-cells__title "><i class="icon nav-icon icon-49"></i> 生 产 中<asp:Label ID="Label1" runat="server" Text=""></asp:Label></div>
                                <div class="weui-cells" >                                    
                                     <%
                                         System.Data.DataTable dt_line = ViewState["dt_data_1"] as System.Data.DataTable;
                                         System.Data.DataView dataView = dt_line.DefaultView;
                                         System.Data.DataTable dtLineDistinct = dataView.ToTable(true,"line");
                                         foreach(System.Data.DataRow drLine in dtLineDistinct.Rows)
                                         {
                                            string line = drLine["line"].ToString();
                                          %>
                                            <div class="weui-cells__title "><i class="icon nav-icon icon-22 color-success"></i><%=line %></div>                                               
                                             <%                                                  
                                                 System.Data.DataTable dt = ViewState["dt_data_1"] as System.Data.DataTable;                                                
                                                 foreach(System.Data.DataRow dr in dt.Select("line='" + line + "'")) {
                                                     if (dr["ispartof"].ToString() == "部分")
                                                     { %> 
                                                    <a class="weui-cell  weui-cell_access" href="prod_end_detail.aspx?type=workorder_part&dh=<%=dr["need_no"] %>">
                                                        <div class="weui-mark-vip"><span class="weui-mark-lt bg-blue"></span></div>
                                                        <div class="weui-cell__hd">
                                                            <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                        </div>
                                                        <div class="weui-cell__bd f-black" style="font-size: smaller">
                                                            <span class="span_space">
                                                                <font color="blue"><%=dr["part"] %></font>
                                                            </span>
                                                            <span>
                                                                <%=dr["part_desc"] %>
                                                            </span> 
                                                            <br />
                                                            <span class="span_space">完工单号:<%=dr["need_no"] %>
                                                            </span>
                                                            <span>完工数量:<font color="blue"><%=dr["qty"] %></font>
                                                            </span>
                                                            <br />
                                                            <span class="weui-agree__text span_space">
                                                                <%=dr["Emp_Name"] %>
                                                            </span>
                                                            <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}",dr["on_date"]) %> </span>
                                                            <span class="weui-agree__text">时长:<font class="f-blue"> <%=dr[ "times"] %></font>
                                                            </span>
                                                        </div>
                                                        <div class="weui-cell__ft">
                                                            <span class="weui-mark-rt- weui-badge bg-blue " style=" font-size: x-small; ">部分</span>
                                                        </div>
                                                    </a>
                                                <% } else {%>                                                    
                                                    <a class="weui-cell weui-cell_access"  href="prod_wip_detail.aspx?need_no=<%=dr["need_no"]%>&ngqty=<%=dr["ng_qty"]%>&wipqty=<%=dr["wip_qty"]%>&type=lot&dh=<%=dr["lot_no"] %>&workshop=<%=_workshop %>&para=Y">
                                                        <div class="weui-mark-vip"><span class="weui-mark-lt bg-blue"></span></div>
                                                        <div class="weui-cell__hd">
                                                            <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                        </div>
                                                        <div class="weui-cell__bd">
                                                            <span class="weui-form-preview__value" style="font-size: smaller">
                                                                <span class="padding10-r"><%=dr["part"]%></span>  <%=dr["part_desc"] %><br />
                                                                <span class="padding5-r"><%= "Lot：" + dr["lot_no"].ToString()%></span>
                                                                上料:<font class="f-blue padding5-r"><%=dr["qty"]%></font>
                                                                下料:<font class="f-blue padding5-r"><%=dr["off_qty"]%></font>
                                                                NG:<font class="f-blue padding5-r"><%=dr["ng_qty"]%></font>
                                                                在制:<font class="f-blue "><%=dr["wip_qty"]%></font>
                                                            </span>
                                                            <span class="weui-agree__text padding10-r" style="font-size: smaller"><%=dr["emp_name"]%></span>
                                                            <span class="weui-agree__text " style="font-size: smaller;"><%= " " + string.Format("{0:MM-dd HH:mm}",dr["on_date"] ) + " " + dr["times"]%> </span>
                                                        </div>
                                                        <div class="weui-cell__ft">
                                                        </div>
                                                    </a>
                                        <% }} }%>                                                
                                        
                                </div>
                            </div> 
                            <%----待终检-----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title "><i class="icon nav-icon icon-49"></i> 待 终 检<asp:Label ID="Label2" runat="server" Text=""></asp:Label></div>
                                <div class="weui-cells">
                                    <%
                                         dt_line = ViewState["dt_data_2"] as System.Data.DataTable;
                                         dataView = dt_line.DefaultView;
                                         dtLineDistinct = dataView.ToTable(true,"line");
                                         foreach(System.Data.DataRow drLine in dtLineDistinct.Rows)
                                         {
                                            string line = drLine["line"].ToString();
                                          %>
                                            <div class="weui-cells__title "><i class="icon nav-icon icon-22 color-success"></i><%=line %></div>
                                            <%                                                  
                                                 System.Data.DataTable dt = ViewState["dt_data_2"] as System.Data.DataTable;                                                
                                                 foreach(System.Data.DataRow dr in dt.Select("line='" + line + "'")) {
                                                     if (dr["ispartof"].ToString() != "部分")
                                                     { %> 
                                                    <a class="weui-cell  weui-cell_access " style="color: black" href="javacript:void(0)">
                                                        <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
                                                        <div class="weui-cell__hd">
                                                            <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                        </div>
                                                        <div class="weui-cell__bd " style="font-size: smaller">
                                                            <span class="span_space">
                                                                <%=dr["pgino"] %> 
                                                            </span>
                                                            <span>
                                                                <%=dr["pn"] %>
                                                            </span>
                                                            <span class="span_space">完工单：<%=dr["workorder"] %>
                                                            </span>
                                                            <br />                                                            
                                                            <span>下线数：<font color="blue"><%=dr["off_qty"] %></font>
                                                            </span>
                                                            <span>合格数：<font color="blue"><%=dr["hege_qty"] %></font>
                                                            </span>
                                                            <span>NG数：<font color="blue"><%=dr["ng_qty"] %></font>
                                                            </span>
                                                            <span>待检数：<font color="blue"><%=dr["wait_qty"] %></font>
                                                            </span>
                                                            <br />
                                                            <span class="weui-agree__text span_space">
                                                               <%=dr["cellphone"] %><%=dr["Emp_Name"] %>
                                                            </span>
                                                            <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}",dr["on_date"]) %> </span>
                                                            <span class="weui-agree__text">时长:<font class="f-blue"> <%=dr["times"] %></font>
                                                            </span>
                                                        </div>
                                                        <div class="weui-cell__ft">
                                                        </div>
                                                    </a>
                                                <% } else {%> 
                                                    <a class="weui-cell  weui-cell_access " style="color: black" href="javacript:void(0)">
                                                        <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
                                                        <div class="weui-cell__hd">
                                                            <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                        </div>
                                                        <div class="weui-cell__bd " style="font-size: smaller">
                                                            <span class="span_space">
                                                                <%=dr["pgino"] %> 
                                                            </span>
                                                            <span>
                                                                <%=dr["pn"] %>
                                                            </span>                                                                                                                        
                                                            <br />                                                            
                                                            <span class="span_space">检验单:<%=dr["qc_dh"] %>
                                                            </span> 
                                                            <span>已检数：<font color="blue"><%=dr["hege_qty"] %></font>
                                                            </span>
                                                            
                                                            <br />
                                                            <span class="weui-agree__text span_space">
                                                               <%=dr["cellphone"] %><%=dr["Emp_Name"] %>
                                                            </span>
                                                            <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}",dr["on_date"]) %> </span>
                                                            <%--<span class="weui-agree__text">时长:<font class="f-blue"> <%=dr["times"] %></font>
                                                            </span>--%>
                                                        </div>
                                                        <div class="weui-cell__ft">
                                                            <span class="weui-mark-rt- weui-badge bg-blue " style=" font-size: x-small; ">部分</span>
                                                        </div>
                                                    </a>
                                    <% }} }%> 
                                </div>
                            </div> 
                            <%----待GP12-----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title "><i class="icon nav-icon icon-49"></i> 待 GP12 <asp:Label ID="Label5" runat="server" Text=""></asp:Label></div>
                                <div class="weui-cells">
                                    <%
                                         dt_line = ViewState["dt_data_3"] as System.Data.DataTable;
                                         dataView = dt_line.DefaultView;
                                         dtLineDistinct = dataView.ToTable(true,"line");
                                         foreach(System.Data.DataRow drLine in dtLineDistinct.Rows)
                                         {
                                            string line = drLine["line"].ToString();
                                          %>
                                            <div class="weui-cells__title "><i class="icon nav-icon icon-22 color-success"></i><%=line %></div>
                                            <%                                                  
                                                 System.Data.DataTable dt = ViewState["dt_data_2"] as System.Data.DataTable;                                                
                                                 foreach(System.Data.DataRow dr in dt.Select("line='" + line + "'")) {
                                                     if (dr["ispartof"].ToString() != "部分")
                                                     { %> 
                                                    <a class="weui-cell  weui-cell_access " style="color: black" href="javacript:void(0)">
                                                        <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
                                                        <div class="weui-cell__hd">
                                                            <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                        </div>
                                                        <div class="weui-cell__bd " style="font-size: smaller">
                                                            <span class="span_space">
                                                                <%=dr["pgino"] %> 
                                                            </span>
                                                            <span>
                                                                <%=dr["pn"] %>
                                                            </span>
                                                            <span class="span_space">完工单：<%=dr["workorder"] %>
                                                            </span>
                                                            <br />                                                            
                                                            <span>下线数：<font color="blue"><%=dr["off_qty"] %></font>
                                                            </span>
                                                            <span>合格数：<font color="blue"><%=dr["hege_qty"] %></font>
                                                            </span>
                                                            <span>NG数：<font color="blue"><%=dr["ng_qty"] %></font>
                                                            </span>
                                                            <span>待检数：<font color="blue"><%=dr["wait_qty"] %></font>
                                                            </span>
                                                            <br />
                                                            <span class="weui-agree__text span_space">
                                                               <%=dr["cellphone"] %><%=dr["Emp_Name"] %>
                                                            </span>
                                                            <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}",dr["on_date"]) %> </span>
                                                            <span class="weui-agree__text">时长:<font class="f-blue"> <%=dr["times"] %></font>
                                                            </span>
                                                        </div>
                                                        <div class="weui-cell__ft">
                                                        </div>
                                                    </a>
                                                <% } else {%> 
                                                    <a class="weui-cell  weui-cell_access " style="color: black" href="javacript:void(0)">
                                                        <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
                                                        <div class="weui-cell__hd">
                                                            <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                        </div>
                                                        <div class="weui-cell__bd " style="font-size: smaller">
                                                            <span class="span_space">
                                                                <%=dr["pgino"] %> 
                                                            </span>
                                                            <span>
                                                                <%=dr["pn"] %>
                                                            </span>                                                                                                                        
                                                            <br />                                                           
                                                            <span class="span_space">检验单:<%=dr["qc_dh"] %>
                                                            </span> 
                                                            <span>已检数：<font color="blue"><%=dr["hege_qty"] %></font>
                                                            </span>                                                             
                                                            <br />
                                                            <span class="weui-agree__text span_space">
                                                               <%=dr["cellphone"] %><%=dr["Emp_Name"] %>
                                                            </span>
                                                            <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}",dr["on_date"]) %> </span>
                                                            <%--<span class="weui-agree__text">时长:<font class="f-blue"> <%=dr["times"] %></font>
                                                            </span>--%>
                                                        </div>
                                                        <div class="weui-cell__ft">
                                                            <span class="weui-mark-rt- weui-badge bg-blue " style=" font-size: x-small; ">部分</span>
                                                        </div>
                                                    </a>
                                    <% }} }%> 
                                </div>
                            </div>
                            <%----待入库-----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title "><i class="icon nav-icon icon-49"></i> 待 入 库<asp:Label ID="Label6" runat="server" Text=""></asp:Label></div>
                                <div class="weui-cells">
                                    <asp:Repeater ID="DataList4_line" runat="server" OnItemDataBound="DataList4_line_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="weui-cells__title "><i class="icon nav-icon icon-22 color-success"></i><%#((string)Container.DataItem) %></div>
                                            <asp:Repeater ID="DataList4" runat="server">
                                                <ItemTemplate><%-- prod_end_detail.aspx?type=workorder&dh=<%#Eval("workorder") %>--%>
                                                    <a class="weui-cell  weui-cell_access " style="color: black" href="<%# (Eval("is_print").ToString()=="未打印"?("/workorder/Ruku_Print.aspx?dh="+ Eval("workorder")):("/workorder/Ruku_hege.aspx?dh="+ Eval("is_print")))+"&workshop="+_workshop %>" + "&ck=N">
                                                        <div class="weui-mark-vip"><span class="weui-mark-lt bg-green"></span></div>
                                                        <div class="weui-cell__hd">
                                                            <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                        </div>
                                                        <div class="weui-cell__bd " style="font-size: smaller">

                                                            <span class="span_space">
                                                                <%# DataBinder.Eval(Container.DataItem, "pgino") %> 
                                                            </span>
                                                            <span>
                                                                <%# DataBinder.Eval(Container.DataItem, "pn") %>
                                                            </span>
                                                             
                                                            <br />
                                                            <span class="span_space">完工单号:<%# DataBinder.Eval(Container.DataItem, "workorder") %>
                                                            </span>
                                                            <span>完工数量:<font color="blue"><%# DataBinder.Eval(Container.DataItem, "qty") %></font>
                                                            </span>
                                                            <br />
                                                            <span class="weui-agree__text span_space">
                                                                <%#Eval("cellphone") %><%# DataBinder.Eval(Container.DataItem, "Emp_Name") %>
                                                            </span>
                                                            <span class="weui-agree__text"><%# DataBinder.Eval(Container.DataItem, "off_date","{0:MM-dd HH:mm}") %> </span>
                                                            <span class="weui-agree__text">时长:<font class="f-blue"> <%# DataBinder.Eval(Container.DataItem, "times") %></font></span>                                                            
                                                            <span class="weui-badge <%# Eval("is_print").ToString()=="未打印"?"bg-blue":"hide"   %> " style=" font-size: x-small; "><%#Eval("is_print") %></span>
                                                        </div>
                                                        <div class="weui-cell__ft">
                                                        </div>
                                                    </a>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                            <%----入库完成(24小时)-----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title "><i class="icon nav-icon icon-49"></i> 入库完成(24小时内)<asp:Label ID="Label7" runat="server" Text=""></asp:Label></div>
                                <div class="weui-cells">
                                    <asp:Repeater ID="DataList5_line" runat="server" OnItemDataBound="DataList5_line_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="weui-cells__title "><i class="icon nav-icon icon-22 color-success"></i><%#((string)Container.DataItem) %></div>
                                            <asp:Repeater ID="DataList5" runat="server">
                                                <ItemTemplate>
                                                    <a class="weui-cell  weui-cell_access " style="color: black" href="javacript:void(0)">
                                                        <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                                        <div class="weui-cell__hd">
                                                            <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                        </div>
                                                        <div class="weui-cell__bd " style="font-size: smaller">

                                                            <span class="span_space">
                                                                <%# DataBinder.Eval(Container.DataItem, "pgino") %> 
                                                            </span>
                                                            <span>
                                                                <%# DataBinder.Eval(Container.DataItem, "pn") %>
                                                            </span>
                                                            <span class="span_space">入库单号:<%# DataBinder.Eval(Container.DataItem, "dh") %>
                                                            <br />
                                                            
                                                            <span class="span_space">完工单号:<%# DataBinder.Eval(Container.DataItem, "workorder") %>
                                                            </span>
                                                            <span>入库数量:<font color="blue"><%# DataBinder.Eval(Container.DataItem, "act_qty") %></font>
                                                            </span>
                                                            <br />
                                                            <span class="weui-agree__text span_space">
                                                                <%#Eval("cellphone") %><%# DataBinder.Eval(Container.DataItem, "Emp_Name") %>
                                                            </span>
                                                            <span class="weui-agree__text"><%# DataBinder.Eval(Container.DataItem, "ruku_date_hg","{0:MM-dd HH:mm}") %> </span>
                                                            <%--<span class="weui-agree__text">时长:<font class="f-blue"> <%# DataBinder.Eval(Container.DataItem, "times") %></font>--%>
                                                            </span>
                                                        </div>
                                                        <div class="weui-cell__ft">
                                                        </div>
                                                    </a>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>


                        <%--==我的工单==--%>
                        <div id="tab2" class="weui-tab__content">
                            <%----部分完成-----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title "><i class="icon nav-icon icon-49"></i> 部分完成<asp:Label ID="Label3" runat="server" Text=""></asp:Label></div>
                                <div class="weui-cells"  >
                                    <asp:Repeater ID="DataList1_line_my" runat="server" OnItemDataBound="DataList1_line_my_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="weui-cells__title "><i class="icon nav-icon icon-22 color-success"></i><%#((string)Container.DataItem) %></div>
                                    <asp:Repeater ID="DataList1_my" runat="server">
                                        <ItemTemplate>
                                            <a class="weui-cell   weui-cell_access " href="prod_end_detail.aspx?type=workorder&dh=<%#Eval("workorder_part") %>">
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-yellow"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd f-black" style="font-size: smaller">
                                                    <span class="span_space">
                                                        <font color="blue"><%# DataBinder.Eval(Container.DataItem, "pgino") %></font>
                                                    </span>
                                                    <span>
                                                        <%# DataBinder.Eval(Container.DataItem, "pn") %>
                                                    </span>
                                                    <br />
                                                    <span class="span_space">完工单号:<%# DataBinder.Eval(Container.DataItem, "workorder_part") %>
                                                    </span>
                                                    <span>完工数量:<font color="blue"><%# DataBinder.Eval(Container.DataItem, "qty") %></font>
                                                    </span>
                                                    <br />
                                                    <span class="weui-agree__text span_space">
                                                        <%# DataBinder.Eval(Container.DataItem, "EmpName") %>
                                                    </span>
                                                    <span class="weui-agree__text">时长:<font class="f-blue"> <%# DataBinder.Eval(Container.DataItem, "times") %></font>
                                                    </span>
                                                </div>
                                                <div class="weui-cell__ft">                                                    
                                                </div>
                                            </a>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    </ItemTemplate>
                                    </asp:Repeater>  
                                </div>
                            </div>
                            <%----已完成-----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title "><i class="icon nav-icon icon-49"></i> 生产完成(24小时内)<asp:Label ID="Label4" runat="server" Text=""></asp:Label></div>
                                <div class="weui-cells"  >
                                    <asp:Repeater ID="DataList2_line_my" runat="server" OnItemDataBound="DataList2_line_my_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="weui-cells__title "><i class="icon nav-icon icon-22  color-success"></i><%#((string)Container.DataItem) %></div>
                                    <asp:Repeater ID="DataList2_my"  runat="server"  >
                                        <ItemTemplate>
                                            <a class="weui-cell  weui-cell_access   " href="prod_end_detail.aspx?type=workorder&dh=<%#Eval("workorder") %>">
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd " style="font-size: smaller">
                                                    <span class="span_space">
                                                         <%# DataBinder.Eval(Container.DataItem, "pgino") %>
                                                    </span>
                                                    <span>
                                                        <%# DataBinder.Eval(Container.DataItem, "pn") %>
                                                    </span>
                                                    <br />
                                                    <span class="span_space">完工单号:<%# DataBinder.Eval(Container.DataItem, "workorder") %>
                                                    </span>
                                                    <span>完工数量:<font color="blue"><%# DataBinder.Eval(Container.DataItem, "qty") %></font>
                                                    </span>
                                                    <br />
                                                    <span class="weui-agree__text span_space">
                                                        <%# DataBinder.Eval(Container.DataItem, "EmpName") %>
                                                    </span>
                                                    <span class="weui-agree__text">时长:<font class="f-blue"> <%# DataBinder.Eval(Container.DataItem, "times") %></font>
                                                    </span>
                                                </div>
                                                <div class="weui-cell__ft">                                                    
                                                </div>
                                            </a>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                            </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        

        <div class="weui-footer weui-footer_fixed-bottom">
            <p class="weui-footer__text"><%=WeiXin.GetCookie("workcode") +((LoginUser)WeiXin.GetJsonCookie()).UserName %></p>
        </div>
        <script>
            $(function () {
                $('.weui-navbar__item').on('click', function () {
                    $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
                    $($(this).attr("href")).show().siblings('.weui-tab__content').hide();
                });

            });</script>
    </form>
</body>
</html>
