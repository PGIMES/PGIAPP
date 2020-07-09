﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="prod_YZ_monitor.aspx.cs" Inherits="prod_YZ_monitor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>压铸生产监视</title>
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

        .span_space {
            padding-right: 20px;
        }

        .weui-badge-tr {
            border: 1px solid orange;
            background-color: transparent;
            color: orange;
        }

        .f-deepfont {
            color: blue;
        }

        .collapse li.js-show .weui-flex {
            opacity: 0.8;
        }

        .collapse .weui-flex {
            padding: 0px 10px 0px 10px;
        }
    </style>

    <script src="../js/zepto.min.js"></script>
    <script src="../js/zepto.weui.js"></script>
    <script src="../js/iscroll-lite.js"></script>

    <script>

        $(function () {

            //// var _index = window.localStorage.getItem("_tabindex");
            $('#t2').tab({
                defaultIndex: 0,// _index == null ? 0 : _index,
                activeClass: 'tab-green',
                onToggle: function (index) {
                    //console.log('index' + index);
                }
            })

            $('.collapse .js-category').click(function () {
                $parent = $(this).parent('li');
                if ($parent.hasClass('js-show')) {
                    $parent.removeClass('js-show');
                    $(this).children('i').removeClass('icon-35').addClass('icon-74');
                } else {
                    $parent.siblings().removeClass('js-show');
                    $parent.addClass('js-show');
                    $(this).children('i').removeClass('icon-74').addClass('icon-35');
                    $parent.siblings().find('i').removeClass('icon-35').addClass('icon-74');
                }
            });

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

            //$("#search").keyup(function () {
            //    so();
            //})

            $('#searchInput').bind('input propertychange', function () {

                var text = $("#searchInput").val().toUpperCase();
                $('.weui-cell').each(function () {
                    var $self = $(this);
                    var flag = $self.text().search(text)
                    if (flag > -1) {
                        $self.removeClass("hide"); $self.siblings('.weui-cells__title').addClass("hide");
                    } else {
                        $self.addClass("hide"); $self.siblings('.weui-cells__title').addClass("hide");

                    }
                });

                showBlockCount();
            });

        })
        //搜索
        //function so() {
        //    var val =  $("#search").val().toUpperCase();
        //    if (val != "") {
        //        $("a").addClass("hide");                
        //        $("a").filter("[title*='" + val + "']").removeClass("hide");
        //        $(".LH").addClass("hide");
        //    }
        //    else {
        //        $("a").removeClass("hide");
        //        $(".LH").removeClass("hide");
        //    }            
        //    showBlockCount()
        //}
        //显示数量
        function showBlockCount() {
            $(".weui-form-preview .weui-cells").each(function (i, item) {
                var rowcount = $(this).find("a:not(.hide)").length;
                // debugger;
                var obj = $(this).closest('li').children(".js-category").find("span");
                $(obj).text(rowcount);
                if (rowcount == 0) {
                    $(obj).addClass("bg-gray").removeClass("bg-blue")
                }
                else {
                    $(obj).addClass("bg-blue").removeClass("bg-gray")
                }
            });
            //组装件数量
            $(".zzj_body").each(function (i, item) {
                var rowcount = $(this).find("a:not(.hide)").length;
                // debugger;
                var obj = $(".zzj_head");//$(this).closest('li').children(".js-category").find("span").text(rowcount);
                $(obj).text(rowcount);
                if (rowcount == 0) {
                    $(obj).addClass("bg-gray").removeClass("bg-blue")
                }
                else {
                    $(obj).addClass("bg-blue").removeClass("bg-gray")
                }
            });

        }
        function cancel() {
            $('.weui-cell').removeClass("hide");
            $('.weui-cell').siblings('.weui-cells__title').removeClass("hide");
            showBlockCount();
        }

        function clear() {
            $('#searchInput').val('');
            $('.weui-cell').removeClass("hide");
            $('.weui-cell').siblings('.weui-cells__title').removeClass("hide");
            showBlockCount();
        }

        //组装件显示折叠
        function showorhide() {
            var ishide = $("#zzj").css("display");
            // alert(ishide);
            if (ishide == "none") {
                $("#zzj").show("fast")//;.removeClass("hide")
            }
            else {
                $("#zzj").hide()// ;.addClass("hide")
            }

        }
    </script>
</head>
<body ontouchstart>


    <div class="weui-pull-to-refresh__layer">
        <div class='weui-pull-to-refresh__arrow'></div>
        <div class='weui-pull-to-refresh__preloader'></div>
        <div class="down">下拉刷新</div>
        <div class="up">释放刷新</div>
        <div class="refresh">正在刷新</div>
    </div>

    <div class="weui-search-bar" id="searchBar">
        <form class="weui-search-bar__form" onkeydown="if(event.keyCode==13) return false;">
            <div class="weui-search-bar__box">
                <i class="weui-icon-search"></i>
                <input type="search" class="weui-search-bar__input" id="searchInput" placeholder="搜索"
                    required="">
                <a href="javascript:clear()" class="weui-icon-clear" id="searchClear"></a>
            </div>
            <label class="weui-search-bar__label" id="searchText">
                <i class="weui-icon-search"></i>
                <span>请输入查看的关键字</span>
            </label>
        </form>
        <a href="javascript:cancel()" class="weui-search-bar__cancel-btn" style="color: #09bb07" id="searchCancel">取消</a>
    </div>

    <form id="form1" runat="server">
        <div class="page">

            <div class="page__bd" id="t2" style="height: 100%;">
                <div class="weui-tab">

                    <div class="weui-tab__panel" style="background-color: lightgray">
                        <div id="tab1" class="weui-tab__content">

                            <%----生产中-----%>
                            <div class="weui-form-preview">
                                <%
                                    System.Data.DataTable dt_line = ViewState["dt_data_1"] as System.Data.DataTable;
                                    int rowscount = dt_line.Rows.Count;
                                %>
                                <ul class="collapse">
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title weui-flex__item"><i class="icon nav-icon icon-49"></i>生 产 中<span class="weui-badge  bg-<% =(rowscount==0?"gray":"blue") %> margin20-l" style="margin-right: 15px;"><% =rowscount %></span></div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells">
                                                <%
                                                    System.Data.DataView dataView = dt_line.DefaultView;
                                                    System.Data.DataTable dtLineDistinct = dataView.ToTable(true, "line");
                                                    foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                                    {  %>

                                                <% string line = drLine["line"].ToString(); %>
                                                <div class="weui-cells__title LH weui-flex__item" id="<%=line %>LH1">
                                                    <i class="icon nav-icon icon-22 color-success"></i><%=line %>
                                                    <span class="weui-badge bg-blue margin20-l zzj_head" style="margin-right: 15px;"><% =(ViewState["dt_data_1"] as System.Data.DataTable).Select("line='" + line + "'").Count() %></span>
                                                </div>

                                                <%                                                  
                                                    System.Data.DataTable dt = ViewState["dt_data_1"] as System.Data.DataTable;
                                                    foreach (System.Data.DataRow dr in dt.Select("line='" + line + "'"))
                                                    {
                                                        if (dr["ispartof"].ToString() == "部分" || dr["ispartof"].ToString() == "零箱返线")
                                                        {%>
                                                <a class="weui-cell weui-cell_access" href="prod_YZ_end_detail_v1.aspx?type=workorder_part&dh=<%=dr["workorder"] %>">
                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-blue"></span></div>
                                                    <div class="weui-cell__hd">
                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                    </div>
                                                    <div class="weui-cell__bd">
                                                        <span class="weui-form-preview__value" style="font-size: smaller">
                                                            <span class="padding10-r"><%=dr["equip_name"]%></span>
                                                            <span class="padding5-r"><%= dr["xmh"]%></span><span class="padding5-r"><%=dr["pn"] %></span><span class="padding5-r"><%= dr["pn_name"]%> </span>
                                                            <span class="weui-mark-rt- weui-badge  weui-badge-tr margin20-l" style="font-size: x-small;"><%=dr["ispartof"].ToString()%></span>
                                                        </span>
                                                        <span style="font-size: smaller">
                                                            <span class="">完工单号:<%=dr["workorder"] %></span>
                                                            <span>完工数量:<font class="f-blue"><%=dr["off_qty"] %></font>
                                                            </span>
                                                        </span>
                                                        <br />
                                                        <span style="font-size:smaller">
                                                            <span class="weui-agree__text ">
                                                                <%=dr["Emp_Name"] %>
                                                            </span>
                                                            <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}", dr["on_date"]) %> </span>
                                                            <span class="weui-agree__text">时长:<font class="f-deepfont"> <%=dr["times"] %></font>
                                                            </span>
                                                        </span>
                                                    </div>
                                                    <div class="weui-cell__ft">
                                                    </div>
                                                </a>

                                                <%    }
                                                else
                                                {  %>
                                                <a class="weui-cell weui-cell_access" href="javascript:void(0);">
                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-blue"></span></div>
                                                    <div class="weui-cell__hd">
                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                    </div>
                                                    <div class="weui-cell__bd">
                                                        <span class="weui-form-preview__value" style="font-size: smaller">
                                                            <span class="padding10-r"><%=dr["equip_name"]%></span>  <%=dr["mojuno"] %>
                                                            <br />
                                                            <span class="padding5-r"><%= dr["xmh"]%></span><span class="padding5-r"><%=dr["pn"] %></span><span class="padding5-r"><%= dr["pn_name"]%> </span>
                                                        </span>
                                                        <span class="weui-agree__text padding10-r" style="font-size: smaller"><%=dr["emp_name"]%></span>
                                                        <span class="weui-agree__text " style="font-size: smaller;"><%= string.Format("{0:MM-dd HH:mm}", dr["on_date"])%></span>
                                                        <%--时长<font class="f-deepfont"> <%= dr["times"]%></font> --%>
                                                    </div>
                                                    <%--<div class="weui-cell__ft">
                                                    </div>--%>
                                                </a>
                                                <%}
                                                        }
                                                    }%>
                                            </div>


                                        </div>
                                    </li>
                                </ul>
                            </div>


                            <%----待后处理-----%>
                            <div class="weui-form-preview">
                                <%
                                    dt_line = ViewState["dt_data_6"] as System.Data.DataTable;
                                    rowscount = dt_line.Rows.Count;
                                %>
                                <ul class="collapse">
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title weui-flex__item"><i class="icon nav-icon icon-49"></i>待后处理<span class="weui-badge  bg-<% =(rowscount==0?"gray":"blue") %> margin20-l" style="margin-right: 15px;"><% =rowscount %></span></div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells">
                                                <%
                                                    dataView = dt_line.DefaultView;
                                                    dtLineDistinct = dataView.ToTable(true, "line");
                                                    foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                                    {
                                                        string line = drLine["line"].ToString();

                                                %>
                                                <div class="weui-cells__title LH" id="<%=line %>LH6">
                                                    <i class="icon nav-icon icon-22 color-success"></i><%=line %>
                                                    <span class="weui-badge bg-blue margin20-l " style="margin-right: 15px;"><% =(ViewState["dt_data_6"] as System.Data.DataTable).Select("line='" + line + "'").Count() %></span>
                                                </div>
                                                <%                                                  
                                                    System.Data.DataTable dt = ViewState["dt_data_6"] as System.Data.DataTable;
                                                    foreach (System.Data.DataRow dr in dt.Select("line='" + line + "'"))
                                                    {
                                                        if (dr["ispartof"].ToString() != "部分")
                                                        { %>
                                                <a class="weui-cell  weui-cell_access" href="prod_end_detail_v2.aspx?type=workorder&dh=<%=dr["workorder"] %>">
                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-blue"></span></div>
                                                    <div class="weui-cell__hd">
                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                    </div>
                                                    <div class="weui-cell__bd f-black" style="font-size: smaller">
                                                        <span class="margin5-l">
                                                            <%=dr["pgino"] %> 
                                                        </span>
                                                        <span>
                                                            <%=dr["pn"] %>
                                                        </span>
                                                        <span class="margin10-l">完工单：<%=dr["workorder"] %>
                                                        </span>
                                                        <br />
                                                        <span>下线数：<font class="f-blue"><%=dr["off_qty"] %></font>
                                                        </span>
                                                        <span>合格数：<font class="f-blue"><%=dr["solve_qty"] %></font>
                                                        </span>
                                                        <span>NG数：<font class="f-blue"><%=dr["ng_qty"] %></font>
                                                        </span>
                                                        <span>待处理：<font class="f-blue"><%=dr["wait_qty"] %></font>
                                                        </span>
                                                        <br />
                                                        <span class="weui-agree__text span_space">
                                                            <%=dr["cellphone"] %><%=dr["Emp_Name"] %>
                                                        </span>
                                                        <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}", dr["on_date"]) %> </span>
                                                        <span class="weui-agree__text">时长:<font class="f-deepfont"> <%=dr["times"] %></font>
                                                        </span>

                                                    </div>
                                                    <div class="weui-cell__ft">
                                                    </div>
                                                </a>
                                                <% }
                                                    else {%>

                                                <a class="weui-cell  weui-cell_access " style="color: black" href="prod_qcc_part_detail.aspx?dh=<%=dr["workorder"] %>&type=0">
                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-blue"></span></div>
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
                                                        <span class="weui-badge  weui-badge-tr margin20-l" style="font-size: x-small;">部分</span>
                                                        <br />
                                                        <span class="span_space">完工单号:<%=dr["workorder"] %>
                                                        </span>
                                                        <span>已处理：<font class="f-blue"><%=dr["solve_qty"] %></font>
                                                        </span>

                                                        <br />
                                                        <span class="weui-agree__text span_space">
                                                            <%=dr["cellphone"] %><%=dr["Emp_Name"] %>
                                                        </span>
                                                        <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}", dr["on_date"]) %> </span>
                                                        <span class="weui-agree__text">时长:<font class="f-deepfont"> <%=dr["times"] %></font>
                                                        </span>
                                                    </div>
                                                    <div class="weui-cell__ft">
                                                    </div>
                                                </a>

                                                <%  }
                                                        }
                                                    }%>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>

                            <%----待终检-----%>
                            <div class="weui-form-preview">
                                <%
                                    dt_line = ViewState["dt_data_2"] as System.Data.DataTable;
                                    rowscount = dt_line.Rows.Count;
                                %>
                                <ul class="collapse">
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>待 终 检<span class="weui-badge  bg-<% =(rowscount==0?"gray":"blue") %> margin20-l" style="margin-right: 15px;"><% =rowscount %></span>
                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells">

                                                <%dataView = dt_line.DefaultView;
                                                    dtLineDistinct = dataView.ToTable(true, "line");
                                                    foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                                    {
                                                        string line = drLine["line"].ToString();
                                                %>
                                                <div class="weui-cells__title  LH" id="<%=line %>LH2"><i class="icon nav-icon icon-22 color-success"></i><%=line %><span class="weui-badge bg-blue  margin20-l " style="margin-right: 15px;"><% =(ViewState["dt_data_2"] as System.Data.DataTable).Select("line='" + line + "'").Count() %></span></div>
                                                <%                                                  
                                                    System.Data.DataTable dt = ViewState["dt_data_2"] as System.Data.DataTable;
                                                    foreach (System.Data.DataRow dr in dt.Select("line='" + line + "'"))
                                                    {
                                                        if (dr["ispartof"].ToString() != "部分")
                                                        { %>
                                                <a class="weui-cell  weui-cell_access " propline="<%=line %>LH2" title="<%=dr["pgino"] %>" style="color: black" href="prod_qcc_part_detail.aspx?dh=<%=dr["workorder"] %>&type=0&laiyuan=完工单号 %>">
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
                                                        <span>下线数：<font class="f-blue"><%=dr["off_qty"] %></font>
                                                        </span>
                                                        <span>合格数：<font class="f-blue"><%=dr["hege_qty"] %></font>
                                                        </span>
                                                        <span>NG数：<font class="f-blue"><%=dr["ng_qty"] %></font>
                                                        </span>
                                                        <span>待检数：<font class="f-blue"><%=dr["wait_qty"] %></font>
                                                        </span>
                                                        <br />
                                                        <span class="weui-agree__text span_space">
                                                            <%=dr["cellphone"] %><%=dr["Emp_Name"] %>
                                                        </span>
                                                        <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}",dr["on_date"]) %> </span>
                                                        <span class="weui-agree__text">时长:<font class="f-deepfont"> <%=dr["times"] %></font>
                                                        </span>
                                                    </div>
                                                    <div class="weui-cell__ft">
                                                    </div>
                                                </a>
                                                <% }
                                                    else {%>
                                                <a class="weui-cell  weui-cell_access " propline="<%=line %>LH2" title="<%=dr["pgino"] %>" style="color: black" href="prod_qcc_part_detail.aspx?dh=<%=dr["qc_dh"] %>&type=0">
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
                                                        <span class="weui-badge  weui-badge-tr margin20-l" style="font-size: x-small;">部分</span>
                                                        <br />
                                                        <span class="span_space">检验单:<%=dr["qc_dh"] %>
                                                        </span>
                                                        <span>已检数：<font class="f-blue"><%=dr["hege_qty"] %></font>
                                                        </span>

                                                        <br />
                                                        <span class="weui-agree__text span_space">
                                                            <%=dr["cellphone"] %><%=dr["Emp_Name"] %>
                                                        </span>
                                                        <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}",dr["on_date"]) %> </span>
                                                        <span class="weui-agree__text">时长:<font class="f-deepfont"> <%=dr["times"] %></font>
                                                        </span>
                                                    </div>
                                                    <div class="weui-cell__ft">
                                                    </div>
                                                </a>
                                                <% }
                                                        }
                                                    }%>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <%----待GP12-----%>
                            <div class="weui-form-preview">
                                <%
                                    dt_line = ViewState["dt_data_3"] as System.Data.DataTable;
                                    rowscount = dt_line.Rows.Count;
                                %>
                                <ul class="collapse">
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title weui-flex__item"><i class="icon nav-icon icon-49"></i>待 GP12<span class="weui-badge  bg-<% =(rowscount==0?"gray":"blue") %> margin20-l" style="margin-right: 15px;"><% =rowscount %></span></div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells">
                                                <%

                                                    dataView = dt_line.DefaultView;
                                                    dtLineDistinct = dataView.ToTable(true, "line");
                                                    foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                                    {
                                                        string line = drLine["line"].ToString();
                                                %>
                                                <div class="weui-cells__title  LH" id="<%=line %>LH3"><i class="icon nav-icon icon-22 color-success"></i><%=line %><span class="weui-badge  bg-blue margin20-l " style="margin-right: 15px;"><% =(ViewState["dt_data_3"] as System.Data.DataTable).Select("line='" + line + "'").Count() %></span></div>
                                                <%                                                  
                                                    System.Data.DataTable dt = ViewState["dt_data_3"] as System.Data.DataTable;
                                                    foreach (System.Data.DataRow dr in dt.Select("line='" + line + "'"))
                                                    {
                                                        if (dr["ispartof"].ToString() != "部分")
                                                        { %>
                                                <a class="weui-cell  weui-cell_access " propline="<%=line %>LH3" title="<%=dr["pgino"] %>" style="color: black" href="prod_qcc_part_detail.aspx?dh=<%=dr["workorder"] %>&type=9&laiyuan=<%=dr["laiyuan"].ToString()=="终检完待GP12"?"终检单号":"完工单号" %>">
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
                                                        <span class="span_space">
                                                            <%=dr["laiyuan"].ToString()=="终检完待GP12"?"终检单":"完工单" %>
                                                                ：<%=dr["workorder"] %>
                                                        </span>
                                                        <br />
                                                        <span>下线数：<font class="f-blue"><%=dr["off_qty"] %></font>
                                                        </span>
                                                        <span>合格数：<font class="f-blue"><%=dr["hege_qty"] %></font>
                                                        </span>
                                                        <span>NG数：<font class="f-blue"><%=dr["ng_qty"] %></font>
                                                        </span>
                                                        <span>待检数：<font class="f-blue"><%=dr["wait_qty"] %></font>
                                                        </span>
                                                        <br />
                                                        <span class="weui-agree__text span_space">
                                                            <%=dr["cellphone"] %><%=dr["Emp_Name"] %>
                                                        </span>
                                                        <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}",dr["on_date"]) %> </span>
                                                        <span class="weui-agree__text">时长:<font class="f-deepfont"> <%=dr["times"] %></font>
                                                        </span>
                                                    </div>
                                                    <div class="weui-cell__ft">
                                                    </div>
                                                </a>
                                                <% }
                                                    else {%>
                                                <a class="weui-cell  weui-cell_access " propline="<%=line %>LH3" title="<%=dr["pgino"] %>" style="color: black" href="prod_qcc_part_detail.aspx?dh=<%=dr["qc_dh"] %>&type=9">
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
                                                        <span class="weui-badge  weui-badge-tr  margin20-l" style="font-size: x-small;">部分</span>
                                                        <br />
                                                        <span class="span_space">检验单:<%=dr["qc_dh"] %>
                                                        </span>
                                                        <span>已检数：<font class="f-blue"><%=dr["hege_qty"] %></font>
                                                        </span>
                                                        <br />
                                                        <span class="weui-agree__text span_space">
                                                            <%=dr["cellphone"] %><%=dr["Emp_Name"] %>
                                                        </span>
                                                        <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}",dr["on_date"]) %> </span>
                                                        <span class="weui-agree__text">时长:<font class="f-deepfont"> <%=dr["times"] %></font>
                                                        </span>
                                                    </div>
                                                    <div class="weui-cell__ft">
                                                    </div>
                                                </a>
                                                <% }
                                                        }
                                                    }%>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <%----待入库-----%>
                            <div class="weui-form-preview">
                                <ul class="collapse">
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <%
                                                dt_line = ViewState["dt_data_4"] as System.Data.DataTable;
                                                rowscount = dt_line.Rows.Count;
                                            %>
                                            <div class="weui-cells__title  weui-flex__item"><i class="icon nav-icon icon-49"></i>待 入 库<span class="weui-badge  bg-<% =(rowscount==0?"gray":"blue") %> margin20-l " style="margin-right: 15px;"><% =rowscount %></span></div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells">
                                                <%                                          
                                                    dataView = dt_line.DefaultView;
                                                    dtLineDistinct = dataView.ToTable(true, "line");
                                                    foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                                    {
                                                        string line = drLine["line"].ToString();
                                                %>
                                                <div class="weui-cells__title LH" id="<%=line %>LH4"><i class="icon nav-icon icon-22 color-success "></i><%=line %><span class="weui-badge bg-blue margin20-l " style="margin-right: 15px;"><% =(ViewState["dt_data_4"] as System.Data.DataTable).Select("line='" + line + "'").Count() %></span></div>
                                                <%                                                  
                                                    System.Data.DataTable dt = ViewState["dt_data_4"] as System.Data.DataTable;
                                                    foreach (System.Data.DataRow dr in dt.Select("line='" + line + "'"))
                                                    {%>
                                                <a class="weui-cell  weui-cell_access " propline="<%=line %>LH4" title="<%=dr["pgino"] %>" style="color: black" href="<% =( dr["is_print"].ToString()=="未打印"?("/workorder/Ruku_Print.aspx?dh="+ dr["workorder"]):("/workorder/Ruku_hege.aspx?dh="+dr["is_print"]))+"&workshop="+_workshop+ "&ck=N" %>">
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
                                                        <span class="weui-badge   margin20-l  <%=dr["is_print"].ToString()=="未打印"?"weui-badge-tr":"hide"   %> " style="font-size: x-small;"><%=dr["is_print"] %></span>
                                                        <br />
                                                        <span class="span_space">
                                                            <%--完工单号--%>
                                                            <% if (dr["b_type"].ToString() == "0")
                                                                {%>
                                                            <span>完工</span>
                                                            <%}
                                                                else if (dr["b_type"].ToString() == "1")
                                                                {%>
                                                            <span>终检</span>
                                                            <%}
                                                                else if (dr["b_type"].ToString() == "2")
                                                                {%>
                                                            <span>GP12</span>
                                                            <%}%>
                                                            单号:<%=dr["workorder"] %>
                                                        </span>
                                                        <span>
                                                            <%--完工--%>
                                                            <% if (dr["b_type"].ToString() == "0")
                                                                {%>
                                                            <span>完工</span>
                                                            <%}
                                                                else if (dr["b_type"].ToString() == "1")
                                                                {%>
                                                            <span>终检</span>
                                                            <%}
                                                                else if (dr["b_type"].ToString() == "2")
                                                                {%>
                                                            <span>GP12</span>
                                                            <%}%>
                                                            数量:<font class="f-blue"><%=dr["qty"] %></font>
                                                        </span>
                                                        <br />
                                                        <span class="weui-agree__text span_space">
                                                            <%=dr["cellphone"] %><%=dr["Emp_Name"] %>
                                                        </span>
                                                        <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}",dr["off_date"]) %> </span>
                                                        <span class="weui-agree__text">时长:<font class="f-deepfont"> <%=dr["times"] %></font></span>

                                                    </div>
                                                    <div class="weui-cell__ft">
                                                    </div>
                                                </a>
                                                <% }
                                                    }%>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <%----入库完成(24小时)-----%>
                            <div class="weui-form-preview">
                                <%
                                    dt_line = ViewState["dt_data_5"] as System.Data.DataTable;
                                    rowscount = dt_line.Rows.Count;
                                %>
                                <ul class="collapse">
                                    <li>
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title weui-flex__item"><i class="icon nav-icon icon-49"></i>入库完成(24小时内)<span class="weui-badge  bg-<% =(rowscount==0?"gray":"blue") %> margin20-l " style="margin-right: 15px;"><% =rowscount %></span></div>
                                            <i class="icon icon-74"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells">
                                                <%                                          
                                                    dataView = dt_line.DefaultView;
                                                    dtLineDistinct = dataView.ToTable(true, "line");
                                                    foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                                    {
                                                        string line = drLine["line"].ToString();
                                                %>
                                                <div class="weui-cells__title LH" id="<%=line %>LH5"><i class="icon nav-icon icon-22 color-success"></i><%=line %><span class="weui-badge bg-blue margin20-l " style="margin-right: 15px;"><% =(ViewState["dt_data_5"] as System.Data.DataTable).Select("line='" + line + "'").Count() %></span></div>
                                                <%                                                  
                                                    System.Data.DataTable dt = ViewState["dt_data_5"] as System.Data.DataTable;
                                                    foreach (System.Data.DataRow dr in dt.Select("line='" + line + "'"))
                                                    {%>
                                                <a class="weui-cell  weui-cell_access " propline="<%=line %>LH5" title="<%=dr["pgino"] %>" style="color: black" href="prod_qcc_timeline_info_v3.aspx?dh=<%=dr["dh"] %>">
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

                                                            <span class="span_space">
                                                                <%--完工单号--%>
                                                                <% if (dr["b_type"].ToString() == "0")
                                                                    {%>
                                                                <span>完工单号:</span>
                                                                <%}
                                                                    else if (dr["b_type"].ToString() == "1")
                                                                    {%>
                                                                <span>终检单号:</span>
                                                                <%}
                                                                    else if (dr["b_type"].ToString() == "2")
                                                                    {%>
                                                                <span>GP12单号:</span>
                                                                <%}%>
                                                                <%=dr["workorder"] %>
                                                            </span>
                                                            <span>入库数量:<font class="f-blue"><%=dr["act_qty"] %></font>
                                                            </span>
                                                            <br />
                                                            <span class="weui-agree__text span_space">
                                                                <%=dr["cellphone"] %><%=dr["Emp_Name"] %>
                                                            </span>
                                                            <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}",dr["ruku_date_hg"]) %> </span>
                                                            <span class="weui-agree__text">时长:<font class="f-deepfont"> <%=dr["times"] %></font>
                                                            </span>
                                                    </div>
                                                    <div class="weui-cell__ft">
                                                    </div>
                                                </a>
                                                <% }
                                                    }%>
                                            </div>
                                        </div>
                                    </li>
                                </ul>

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
