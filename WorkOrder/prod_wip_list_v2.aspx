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

            $("#search").keyup(function () {
                so();
            })

           // showlinesCount();
        })

        function so() {
            var val =  $("#search").val().toUpperCase();
            if (val != "") {
                $("a").addClass("hide");                
                $("a").filter("[title*='" + val + "']").removeClass("hide");
                $(".LH").filter().addClass("hide");
            }
            else {
                $("a").removeClass("hide");
            }
        }

        //function showlinesCount() {
        //    $(".LH").each(function () {
        //        alert($(this).attr("id"));
        //    });
        //}

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
                    <div class="weui-search-bar">
                        <input type="search" class="search-input" id="search" placeholder="关键字:项目号"/><button onclick="so();" class="weui-btn weui-btn_mini weui-btn_primary"><i class="icon icon-4"></i></button>
                    </div>
                    <div class="weui-tab__panel" style="background-color: lightgray">
                        <%--==生产监视==--%>
                        <div id="tab1" class="weui-tab__content">
                            <%----生产中-----%>
                             <div class="weui-form-preview">
                                <%
                                    System.Data.DataTable dt_line = ViewState["dt_data_1"] as System.Data.DataTable;
                                    int rowscount = dt_line.Rows.Count;
                                %>
                                <div class="weui-cells__title "><i class="icon nav-icon icon-49"></i> 生 产 中<span class="weui-badge  bg-<% =(rowscount==0?"gray":"blue") %> margin20-l " style="margin-right: 15px;"><% =rowscount %></span></div>
                                <div class="weui-cells" >                                    
                                     <%
                                         System.Data.DataView dataView = dt_line.DefaultView;
                                         System.Data.DataTable dtLineDistinct = dataView.ToTable(true,"line");
                                         foreach(System.Data.DataRow drLine in dtLineDistinct.Rows)
                                         {
                                            string line = drLine["line"].ToString();

                                      %>
                                            <div class="weui-cells__title LH" id="1<%=line %>"><i class="icon nav-icon icon-22 color-success"></i><%=line %>
                                                <span class="weui-badge  bg-blue margin20-l " style="margin-right: 15px;"><% =(ViewState["dt_data_1"] as System.Data.DataTable).Select("line='" + line + "'").Count() %></span></div>                                               
                                             <%                                                  
                                                 System.Data.DataTable dt = ViewState["dt_data_1"] as System.Data.DataTable;                                                
                                                 foreach(System.Data.DataRow dr in dt.Select("line='" + line + "'")) {
                                                     if (dr["ispartof"].ToString() == "部分")
                                                     { %> 
                                                    <a class="weui-cell  weui-cell_access" prop-line="1<%=line %>" title="<%=dr["part"] %>" href="prod_end_detail.aspx?type=workorder_part&dh=<%=dr["need_no"] %>">
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
                                                            <span class="weui-mark-rt- weui-badge bg-blue margin20-l" style=" font-size: x-small; ">部分</span>
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
                                                        </div>
                                                    </a>
                                                <% } else {%>                                                    
                                                    <a class="weui-cell weui-cell_access" line="<%=line %>"  title="<%=dr["part"] %>" href="prod_wip_detail.aspx?need_no=<%=dr["need_no"]%>&ngqty=<%=dr["ng_qty"]%>&wipqty=<%=dr["wip_qty"]%>&type=lot&dh=<%=dr["lot_no"] %>&workshop=<%=_workshop %>&para=Y">
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
                            <%
                                dt_line = ViewState["dt_data_2"] as System.Data.DataTable;
                                rowscount = dt_line.Rows.Count;
                                %>
                                
                                <div class="weui-cells__title "><i class="icon nav-icon icon-49"></i> 待 终 检<span class="weui-badge  bg-<% =(rowscount==0?"gray":"blue") %> margin20-l " style="margin-right: 15px;"><% =rowscount %></span></div>
                                <div class="weui-cells">
                                   
                                         <%dataView = dt_line.DefaultView;
                                         dtLineDistinct = dataView.ToTable(true,"line");
                                         foreach(System.Data.DataRow drLine in dtLineDistinct.Rows)
                                         {
                                            string line = drLine["line"].ToString();
                                          %>
                                            <div class="weui-cells__title  LH"><i class="icon nav-icon icon-22 color-success"></i><%=line %><span class="weui-badge  bg-blue margin20-l " style="margin-right: 15px;"><% =(ViewState["dt_data_2"] as System.Data.DataTable).Select("line='" + line + "'").Count() %></span></div>
                                            <%                                                  
                                                 System.Data.DataTable dt = ViewState["dt_data_2"] as System.Data.DataTable;                                                
                                                 foreach(System.Data.DataRow dr in dt.Select("line='" + line + "'")) {
                                                     if (dr["ispartof"].ToString() != "部分")
                                                     { %> 
                                                    <a class="weui-cell  weui-cell_access " title="<%=dr["pgino"] %>" style="color: black" href="prod_qcc_wait_detail.aspx?dh=<%=dr["workorder"] %>&type=0&ngqty=<%=dr["ng_qty"] %>&waitqty=<%=dr["wait_qty"] %>">
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
                                                    <a class="weui-cell  weui-cell_access "  title="<%=dr["pgino"] %>"  style="color: black" href="prod_qcc_part_detail.aspx?dh=<%=dr["qc_dh"] %>&type=0">
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
                                                            <span class="weui-badge bg-blue margin20-l" style=" font-size: x-small; ">部分</span>                                                                                                                      
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
                                                            <span class="weui-agree__text">时长:<font class="f-blue"> <%=dr["times"] %></font>
                                                            </span>
                                                        </div>
                                                        <div class="weui-cell__ft">
                                                           
                                                        </div>
                                                    </a>
                                    <% }} }%> 
                                </div>
                            </div> 
                            <%----待GP12-----%>
                            <div class="weui-form-preview">
                                <%
                                dt_line = ViewState["dt_data_3"] as System.Data.DataTable;
                                rowscount = dt_line.Rows.Count;
                                %>
                                <div class="weui-cells__title "><i class="icon nav-icon icon-49"></i> 待 GP12<span class="weui-badge  bg-<% =(rowscount==0?"gray":"blue") %> margin20-l " style="margin-right: 15px;"><% =rowscount %></span></div>
                                <div class="weui-cells">
                                    <%
                                          
                                         dataView = dt_line.DefaultView;
                                         dtLineDistinct = dataView.ToTable(true,"line");
                                         foreach(System.Data.DataRow drLine in dtLineDistinct.Rows)
                                         {
                                            string line = drLine["line"].ToString();
                                          %>
                                            <div class="weui-cells__title  LH"><i class="icon nav-icon icon-22 color-success"></i><%=line %><span class="weui-badge  bg-blue margin20-l " style="margin-right: 15px;"><% =(ViewState["dt_data_3"] as System.Data.DataTable).Select("line='" + line + "'").Count() %></span></div>
                                            <%                                                  
                                                 System.Data.DataTable dt = ViewState["dt_data_3"] as System.Data.DataTable;                                                
                                                 foreach(System.Data.DataRow dr in dt.Select("line='" + line + "'")) {
                                                     if (dr["ispartof"].ToString() != "部分")
                                                     { %> 
                                                    <a class="weui-cell  weui-cell_access "  title="<%=dr["pgino"] %>"  style="color: black" href="prod_qcc_wait_detail.aspx?dh=<%=dr["workorder"] %>&type=9&ngqty=<%=dr["ng_qty"] %>&waitqty=<%=dr["wait_qty"] %>">
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
                                                    <a class="weui-cell  weui-cell_access "  title="<%=dr["pgino"] %>"  style="color: black" href="prod_qcc_part_detail.aspx?dh=<%=dr["qc_dh"] %>&type=9">
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
                                                            <span class="weui-badge bg-blue  margin20-l" style=" font-size: x-small; ">部分</span>                                                                                                                      
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
                                                            <span class="weui-agree__text">时长:<font class="f-blue"> <%=dr["times"] %></font>
                                                            </span>
                                                        </div>
                                                        <div class="weui-cell__ft">
                                                            
                                                        </div>
                                                    </a>
                                    <% }} }%> 
                                </div>
                            </div>
                            <%----待入库-----%>
                            <div class="weui-form-preview">
                                 <%
                                dt_line = ViewState["dt_data_4"] as System.Data.DataTable;
                                rowscount = dt_line.Rows.Count;
                                %>
                                <div class="weui-cells__title "><i class="icon nav-icon icon-49"></i> 待 入 库<span class="weui-badge  bg-<% =(rowscount==0?"gray":"blue") %> margin20-l " style="margin-right: 15px;"><% =rowscount %></span></div>
                                <div class="weui-cells">
                                    <%                                          
                                         dataView = dt_line.DefaultView;
                                         dtLineDistinct = dataView.ToTable(true,"line");
                                         foreach(System.Data.DataRow drLine in dtLineDistinct.Rows)
                                         {
                                            string line = drLine["line"].ToString();
                                          %>
                                            <div class="weui-cells__title LH"><i class="icon nav-icon icon-22 color-success "></i><%=line %><span class="weui-badge  bg-blue margin20-l " style="margin-right: 15px;"><% =(ViewState["dt_data_4"] as System.Data.DataTable).Select("line='" + line + "'").Count() %></span></div>
                                            <%                                                  
                                                System.Data.DataTable dt = ViewState["dt_data_4"] as System.Data.DataTable;
                                                foreach(System.Data.DataRow dr in dt.Select("line='" + line + "'"))
                                                {%>
                                                    <a class="weui-cell  weui-cell_access "  title="<%=dr["pgino"] %>"  style="color: black" href="<% =( dr["is_print"].ToString()=="未打印"?("/workorder/Ruku_Print.aspx?dh="+ dr["workorder"]):("/workorder/Ruku_hege.aspx?dh="+dr["is_print"]))+"&workshop="+_workshop+ "&ck=N" %>" >
                                                        <div class="weui-mark-vip"><span class="weui-mark-lt bg-green"></span></div>
                                                        <div class="weui-cell__hd">
                                                            <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                        </div>
                                                        <div class="weui-cell__bd " style="font-size: smaller">

                                                            <span class="span_space">
                                                                <%=dr["pgino"] %> 
                                                            </span>
                                                            <span>
                                                                <%=dr["pn"]%>
                                                            </span>
                                                             <span class="weui-badge   margin20-l  <%=dr["is_print"].ToString()=="未打印"?"bg-blue":"hide"   %> " style=" font-size: x-small; "><%=dr["is_print"] %></span>
                                                            <br />
                                                            <span class="span_space">完工单号:<%=dr["workorder"] %>
                                                            </span>
                                                            <span>完工数量:<font color="blue"><%=dr["qty"] %></font>
                                                            </span>
                                                            <br />
                                                            <span class="weui-agree__text span_space">
                                                                <%=dr["cellphone"] %><%=dr["Emp_Name"] %>
                                                            </span>
                                                            <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}",dr["off_date"]) %> </span>
                                                            <span class="weui-agree__text">时长:<font class="f-blue"> <%=dr["times"] %></font></span>                                                            
                                                            
                                                        </div>
                                                        <div class="weui-cell__ft">
                                                        </div>
                                                    </a>
                                                <% } }%> 
                                </div>
                            </div>
                            <%----入库完成(24小时)-----%>
                            <div class="weui-form-preview">
                                <%
                                dt_line = ViewState["dt_data_5"] as System.Data.DataTable;
                                rowscount = dt_line.Rows.Count;
                                %>
                                <div class="weui-cells__title "><i class="icon nav-icon icon-49"></i> 入库完成(24小时内)<span class="weui-badge  bg-<% =(rowscount==0?"gray":"blue") %> margin20-l " style="margin-right: 15px;"><% =rowscount %></span></div>
                                <div class="weui-cells">
                                    <%                                          
                                         dataView = dt_line.DefaultView;
                                         dtLineDistinct = dataView.ToTable(true,"line");
                                         foreach(System.Data.DataRow drLine in dtLineDistinct.Rows)
                                         {
                                            string line = drLine["line"].ToString();
                                          %>
                                            <div class="weui-cells__title "><i class="icon nav-icon icon-22 color-success"></i><%=line %><span class="weui-badge  bg-blue margin20-l " style="margin-right: 15px;"><% =(ViewState["dt_data_5"] as System.Data.DataTable).Select("line='" + line + "'").Count() %></span></div>
                                             <%                                                  
                                                System.Data.DataTable dt = ViewState["dt_data_5"] as System.Data.DataTable;
                                                foreach(System.Data.DataRow dr in dt.Select("line='" + line + "'"))
                                                {%>
                                                    <a class="weui-cell  weui-cell_access "  title="<%=dr["pgino"] %>"  style="color: black" href="prod_qcc_timeline_info.aspx?dh=<%=dr["dh"] %>">
                                                        <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
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
                                                            <span class="span_space">入库单号:<%=dr["dh"] %>
                                                            <br />
                                                            
                                                            <span class="span_space">完工单号:<%=dr["workorder"] %>
                                                            </span>
                                                            <span>入库数量:<font color="blue"><%=dr["act_qty"] %></font>
                                                            </span>
                                                            <br />
                                                            <span class="weui-agree__text span_space">
                                                                <%=dr["cellphone"] %><%=dr["Emp_Name"] %>
                                                            </span>
                                                            <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}",dr["ruku_date_hg"]) %> </span>
                                                            <span class="weui-agree__text">时长:<font class="f-blue"> <%=dr["times"] %></font>
                                                            </span>
                                                        </div>
                                                        <div class="weui-cell__ft">
                                                        </div>
                                                    </a>
                                                 <% } }%> 
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
