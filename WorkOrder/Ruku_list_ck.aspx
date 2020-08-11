<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Ruku_list_ck.aspx.cs" Inherits="WorkOrder_Ruku_list_ck" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>入库监视</title>
     <link rel="stylesheet" href="../css/weui.css" />
    <link rel="stylesheet" href="../css/weuix.css" />
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
        .collapse li.js-show .weui-flex {
            opacity: 0.8;
        }
        .collapse .weui-flex {     
            padding:0px 10px 0px 10px; 
                 
        }
        .bg-orange{background-color:orange}
        .fl{padding-left:0px;padding-right:0px;}/*color:#696969*/
    </style>
    <script src="../js/zepto.min.js"></script>
    <script src="../js/zepto.weui.js"></script>
    <script src="../js/iscroll-lite.js"></script>
    <script>
        $(function () {

            $('#t2').tab({
                defaultIndex: 0,
                activeClass: 'tab-green',
                onToggle: function (index) {
                    console.log('index' + index);
                }
            });

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

            $('#searchInput').bind('input propertychange', function () {

                $(".lined").show("fast");

                var text = $("#searchInput").val();
                $('.weui-cell').each(function () {
                    var $self = $(this);

                    $parent = $self.parents('li');
                    $parent.siblings().removeClass('js-show');
                    $parent.addClass('js-show');
                    $(this).children('i').removeClass('icon-74').addClass('icon-35');
                    $parent.siblings().find('i').removeClass('icon-35').addClass('icon-74');

                    var flag = $self.text().search(text);
                    if (flag > -1) {
                        $self.removeClass("hide");
                    } else {
                        $self.addClass("hide");

                    }
                });

                $(".line").css("display", "none");

                showBlockCount();
            });
        });
        //显示数量
        function showBlockCount() {
            $(".select").each(function (i, item) {
                var rowcount = $(this).find("a:not(.hide)").length;
                // debugger;
                var obj = $(item).parent().prev().children().children('span');
                $(obj).text(rowcount);
                if (rowcount == 0) {
                    $(obj).addClass("bg-gray").removeClass("bg-blue");
                }
                else {
                    if (this.id == "_98_2" || this.id == "_98_3" || this.id == "_98_4"
                        || this.id == "_99_2" || this.id == "_99_3" || this.id == "_99_4") {
                        $(obj).addClass("bg-orange").removeClass("bg-gray");
                    } else {
                        $(obj).addClass("bg-blue").removeClass("bg-gray");
                    }
                }
            });
        }

        function cancel() {
            $('.weui-cell').removeClass("hide");
            $(".lined").hide(); $(".line").css("display", "");
            showBlockCount();
        }

        function clear() {
            $('#searchInput').val('');
            $('.weui-cell').removeClass("hide");
            $(".lined").hide(); $(".line").css("display", "");
            showBlockCount();
        }
        //显示折叠
        function showorhide(obj) {
            var divLineBody = $(obj)[0].nextElementSibling;
            var ishide = $(divLineBody).css("display");
            if (ishide == "none") {
                $(divLineBody).show("fast");
            }
            else {
                $(divLineBody).hide();
            }
        }
    </script>
    <script>
        function deal(stepid, workorder, workorder_f, workorder_gl, workshop) {
            //alert(stepid);

            if (workshop == "二车间" || workshop == "四车间") {
                if (stepid == "0002") {//--检验处置
                    window.location.href = "/workorder/bhgp_Apply_V1.aspx?workorder=" + workorder + "&workorder_f=" + workorder_f + "&workshop=" + workshop+"&para_ck=<%=_para_ck %>";
                } else if (stepid == "9998") {//--待入库
                    window.location.href = "/workorder/CKSH.aspx?workorder_f=" + workorder_f + "&dh=" + workorder_gl + "&workshop=" + workshop+"&para_ck=<%=_para_ck %>";
                }
                else {
                    window.location.href = "/workorder/bhgp_sign_V1.aspx?stepid=" + stepid + "&workorder=" + workorder + "&workorder_f=" + workorder_f + "&workshop=" + workshop+"&para_ck=<%=_para_ck %>";
                }
            }
            if (workshop == "三车间") {
                if (stepid == "0002") {//--检验处置
                    window.location.href = "/workorder/bhgp_Apply_yz.aspx?workorder=" + workorder + "&workorder_f=" + workorder_f + "&workshop=" + workshop+"&para_ck=<%=_para_ck %>";
                } else if (stepid == "9998") {//--待入库
                    window.location.href = "/workorder/CKSH.aspx?workorder_f=" + workorder_f + "&dh=" + workorder_gl + "&workshop=" + workshop+"&para_ck=<%=_para_ck %>";
                }
                else {
                    window.location.href = "/workorder/bhgp_sign_yz.aspx?stepid=" + stepid + "&workorder=" + workorder + "&workorder_f=" + workorder_f + "&workshop=" + workshop+"&para_ck=<%=_para_ck %>";
                }
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
                <input type="search" class="weui-search-bar__input" id="searchInput"  placeholder="搜索"
                        required="">
                <a href="javascript:clear()" class="weui-icon-clear" id="searchClear"></a>
            </div>
            <label class="weui-search-bar__label" id="searchText">
                <i class="weui-icon-search"></i>
                <span>请输入查看的关键字</span>
            </label>
        </form>
        <a href="javascript:cancel()" class="weui-search-bar__cancel-btn" style="color:#09bb07" id="searchCancel">取消</a>
    </div>
     
    <form id="form1" runat="server">
        <%----待入库-----%>
        <div class="weui-form-preview">
            <ul class="collapse">
                <li class="js-show">
                    <div class="weui-flex js-category">
                        <%
                            System.Data.DataTable dt_line = ViewState["dt_data_2"] as System.Data.DataTable;
                            int rowscount = dt_line.Rows.Count;                                                 
                        %>
                        <div class="weui-cells__title fl  weui-flex__item">
                            <i class="icon nav-icon icon-49"></i>二车间 待入库                                                 
                            <span class="weui-badge  bg-<% =(rowscount==0?"gray":"blue") %> margin20-l " style="margin-right: 15px;"><% =rowscount %></span>
                        </div>
                        <i class="icon icon-35"></i>
                    </div>
                    <div class="page-category js-categoryInner">
                        <div class="weui-cells select">
                            <%                                          
                                System.Data.DataView dataView = dt_line.DefaultView;
                                System.Data.DataTable dtLineDistinct = dataView.ToTable(true, "line");

                                foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                {
                                    string line = drLine["line"].ToString();
                            %>
                            <ul class="collapse">
                                <li style="margin-top:0px;margin-bottom:0px">
                                    <div class="weui-flex js-category line" onclick="showorhide(this);">
                                        <div class="weui-cells__title  weui-flex__item LH" id="<%=line %>LH4">
                                            <i class="icon nav-icon icon-22 color-success "></i><%=line %>
                                            <span class="weui-badge bg-blue margin20-l " style="margin-right: 15px;">
                                                <% =(ViewState["dt_data_2"] as System.Data.DataTable).Select("line='" + line + "'").Count() %>
                                            </span>
                                        </div>
                                        <i class="icon icon-74 right"></i>
                                    </div>
                                    <div class="page-category js-categoryInner lined" style="display: none">
                                        <div class="weui-cells">
                                        <%                                                  
                                            System.Data.DataTable dt = ViewState["dt_data_2"] as System.Data.DataTable;
                                            foreach (System.Data.DataRow dr in dt.Select("line='" + line + "'"))
                                            {%>
                                            <a class="weui-cell  weui-cell_access " style="color: black" href="<% =( dr["is_print"].ToString()=="未打印"?("/workorder/Ruku_Print.aspx?dh="+ dr["workorder"]):("/workorder/Ruku_hege.aspx?dh="+dr["is_print"]))+"&workshop=二车间&ck=N" %>">
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
                                                        <span>完工单:</span>
                                                        <%}
                                                            else if (dr["b_type"].ToString() == "1"||dr["b_type"].ToString() == "99")
                                                            {%>
                                                        <span>终检单:</span>
                                                        <%}
                                                            else if (dr["b_type"].ToString() == "2")
                                                            {%>
                                                        <span>GP12单:</span>
                                                        <%}%>
                                                        <%=dr["workorder"] %>
                                                    </span>
                                                    <span>                                                                        
                                                        <span>数量:</span>                                                                        
                                                        <font class="f-blue"><%=dr["qty"] %></font>
                                                    </span>
                                                    <br />
                                                    <span class="weui-agree__text span_space">
                                                        <%=dr["cellphone"] %><%=dr["Emp_Name"] %>
                                                    </span>
                                                    <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}",dr["off_date"]) %> </span>
                                                    <span class="weui-agree__text">时长:<font class="<%= Convert.ToInt16(dr["times"].ToString().Replace(":",""))>200?"f-red":"f-deepfont" %>"> <%=dr["times"] %></font></span>

                                                </div>
                                                <div class="weui-cell__ft">
                                                </div>
                                            </a>
                                        <% }%>                                            
                                        </div>
                                    </div>
                                </li>
                            </ul>
                            <%  }%>
                        </div>
                    </div>
                </li>
            </ul>
        </div>

        <div class="weui-form-preview">
            <ul class="collapse">
                <li class="js-show">
                    <div class="weui-flex js-category">
                        <%
                           dt_line = ViewState["dt_data_3"] as System.Data.DataTable;
                            rowscount = dt_line.Rows.Count;                                                 
                        %>
                        <div class="weui-cells__title fl weui-flex__item">
                            <i class="icon nav-icon icon-49"></i>三车间 待入库                                                 
                            <span class="weui-badge  bg-<% =(rowscount==0?"gray":"blue") %> margin20-l " style="margin-right: 15px;"><% =rowscount %></span>
                        </div>
                        <i class="icon icon-35"></i>
                    </div>
                    <div class="page-category js-categoryInner">
                        <div class="weui-cells select">
                            <%                                          
                                dataView = dt_line.DefaultView;
                                dtLineDistinct = dataView.ToTable(true, "line");

                                foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                {
                                    string line = drLine["line"].ToString();
                            %>
                            <ul class="collapse">
                                <li style="margin-top:0px;margin-bottom:0px">
                                    <div class="weui-flex js-category line" onclick="showorhide(this);">
                                        <div class="weui-cells__title  weui-flex__item LH" id="<%=line %>LH4">
                                            <i class="icon nav-icon icon-22 color-success "></i><%=line %>
                                            <span class="weui-badge bg-blue margin20-l " style="margin-right: 15px;">
                                                <% =(ViewState["dt_data_3"] as System.Data.DataTable).Select("line='" + line + "'").Count() %>
                                            </span>
                                        </div>
                                        <i class="icon icon-74 right"></i>
                                    </div>
                                    <div class="page-category js-categoryInner lined" style="display: none">
                                        <div class="weui-cells">
                                        <%                                                  
                                            System.Data.DataTable dt = ViewState["dt_data_3"] as System.Data.DataTable;
                                            foreach (System.Data.DataRow dr in dt.Select("line='" + line + "'"))
                                            {%>
                                            <a class="weui-cell  weui-cell_access " style="color: black" href="<% =dr["href"] %>" >
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
                                                        <span>
                                                            <%if (dr["b_type"].ToString() == "0" || dr["b_type"].ToString() == "3")
                                                            {%>完工<% }
                                                            else if (dr["b_type"].ToString() == "1"||dr["b_type"].ToString() == "99")
                                                            {%>终检<%}
                                                            else if (dr["b_type"].ToString() == "2")
                                                            {%>GP12<%}
                                                            else if (dr["b_type"].ToString() == "4")
                                                            {%>后处理<%}%>单:
                                                        </span><%=dr["workorder"] %> 
                                                    </span>
                                                    <span>
                                                        数量:<font class="f-blue"><%=dr["qty"] %></font>
                                                    </span>
                                                    <br />
                                                    <span class="weui-agree__text span_space">
                                                        <%=dr["cellphone"] %><%=dr["Emp_Name"] %>
                                                    </span>
                                                    <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}",dr["off_date"]) %> </span>
                                                    <span class="weui-agree__text">时长:<font class="<%= Convert.ToInt32(dr["times"].ToString().Replace(":",""))>200?"f-red":"f-deepfont" %>"> <%=dr["times"] %></font></span>

                                                </div>
                                                <div class="weui-cell__ft">
                                                </div>
                                            </a>
                                        <% }%>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                            <%  }%>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
                
        <div class="weui-form-preview">
            <ul class="collapse">
                <li class="js-show">
                    <div class="weui-flex js-category">
                        <%
                           dt_line = ViewState["dt_data_4"] as System.Data.DataTable;
                            rowscount = dt_line.Rows.Count;                                                 
                        %>
                        <div class="weui-cells__title fl  weui-flex__item">
                            <i class="icon nav-icon icon-49"></i>四车间 待入库                                                 
                            <span class="weui-badge  bg-<% =(rowscount==0?"gray":"blue") %> margin20-l " style="margin-right: 15px;"><% =rowscount %></span>
                        </div>
                        <i class="icon icon-35"></i>
                    </div>
                    <div class="page-category js-categoryInner">
                        <div class="weui-cells select">
                            <%                                          
                                dataView = dt_line.DefaultView;
                                dtLineDistinct = dataView.ToTable(true, "line");

                                foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                {
                                    string line = drLine["line"].ToString();
                            %>
                            <ul class="collapse">
                                <li style="margin-top:0px;margin-bottom:0px">
                                    <div class="weui-flex js-category line" onclick="showorhide(this);">
                                        <div class="weui-cells__title  weui-flex__item LH" id="<%=line %>LH4">
                                            <i class="icon nav-icon icon-22 color-success "></i><%=line %>
                                            <span class="weui-badge bg-blue margin20-l " style="margin-right: 15px;">
                                                <% =(ViewState["dt_data_4"] as System.Data.DataTable).Select("line='" + line + "'").Count() %>
                                            </span>
                                        </div>
                                        <i class="icon icon-74 right"></i>
                                    </div>
                                    <div class="page-category js-categoryInner lined" style="display: none">
                                        <div class="weui-cells">
                                        <%                                                  
                                            System.Data.DataTable dt = ViewState["dt_data_4"] as System.Data.DataTable;
                                            foreach (System.Data.DataRow dr in dt.Select("line='" + line + "'"))
                                            {%>
                                            <a class="weui-cell  weui-cell_access " style="color: black" href="<% =( dr["is_print"].ToString()=="未打印"?("/workorder/Ruku_Print.aspx?dh="+ dr["workorder"]):("/workorder/Ruku_hege.aspx?dh="+dr["is_print"]))+"&workshop=四车间&ck=N" %>">
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
                                                        <span>完工单:</span>
                                                        <%}
                                                            else if (dr["b_type"].ToString() == "1"||dr["b_type"].ToString() == "99")
                                                            {%>
                                                        <span>终检单:</span>
                                                        <%}
                                                            else if (dr["b_type"].ToString() == "2")
                                                            {%>
                                                        <span>GP12单:</span>
                                                        <%}%>
                                                        <%=dr["workorder"] %>
                                                    </span>
                                                    <span>                                                                        
                                                        <span>数量:</span>                                                                        
                                                        <font class="f-blue"><%=dr["qty"] %></font>
                                                    </span>
                                                    <br />
                                                    <span class="weui-agree__text span_space">
                                                        <%=dr["cellphone"] %><%=dr["Emp_Name"] %>
                                                    </span>
                                                    <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}",dr["off_date"]) %> </span>
                                                    <span class="weui-agree__text">时长:<font class="<%= Convert.ToInt16(dr["times"].ToString().Replace(":",""))>200?"f-red":"f-deepfont" %>"> <%=dr["times"] %></font></span>

                                                </div>
                                                <div class="weui-cell__ft">
                                                </div>
                                            </a>
                                        <% }%>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                            <%  }%>
                        </div>
                    </div>
                </li>
            </ul>
        </div>

        <%----不合格待入库-----%>
        <div class="weui-form-preview">
            <ul class="collapse">
                <li class="js-show">
                    <div class="weui-flex js-category">
                        <div class="weui-cells__title fl weui-flex__item">
                            <i class="icon nav-icon icon-49"></i>二车间 不合格 待入库
                            <span class="weui-badge  bg-<% =(count_98_2==0?"gray":"orange") %>"><% =count_98_2 %></span>
                        </div>
                        <i class="icon icon-35"></i>
                    </div>
                    <div class="page-category js-categoryInner">
                        <div class="weui-cells select" id="_98_2">
                            <asp:Repeater runat="server" ID="list_98_2" EnableTheming="False">
                                <ItemTemplate>
                                    <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>','<%# Eval("workshop") %>')>
                                        <div class="weui-mark-vip"><span class="weui-mark-lt bg-green"></span></div>
                                        <div class="weui-cell__hd">
                                            <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                        </div>
                                        <div class="weui-cell__bd">
                                                <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                <%# "单号"+Eval("workorder") %>
                                                <span style="display:<%# Eval("workorder_f").ToString()!=""?"inline-block":"none"%>; ">
                                                    <%# " 分单号" + Eval("workorder_f") %>
                                                </span>
                                                <span style="display:<%# Eval("workorder_f_a").ToString()!=""?"inline-block":"none"%>; ">
                                                    <%# " 父单号" + Eval("workorder_f_a") %>
                                                </span>
                                                <span style="display:<%# (Eval("stepid").ToString()=="9998" || Eval("stepid").ToString()=="9999")?"inline-block":"none"%>; ">
                                                    <%# " 关联单号" + Eval("workorder_gl") %>
                                                </span>
                                            </span>
                                            <span class="weui-form-preview__value" style="font-size: smaller">
                                                <%# Eval("pgino") + "," + Eval("pn") + "," +Eval("op") + "" +Eval("op_descr")  %>
                                            </span>
                                            <span class="weui-form-preview__value" style="font-size: smaller">
                                                <span style="display:<%# Eval("reason_code").ToString()!=""?"inline-block":"none"%>;"><%# Eval("reason_code") + "" + Eval("reason") + "," %></span>
                                                <%# Eval("cur_qty")+"件" %>
                                                <span class="weui-mark-rt- weui-badge weui-badge-tr" 
                                                    style="
                                                        font-size: x-small; color: <%# Eval("type").ToString()=="部分"?"#F7CF07":"#10AEFF"%>;
                                                        display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                    <%#Eval("type") %>
                                                </span>
                                                <span class="weui-mark-rt- weui-badge weui-badge-tr" 
                                                    style="
                                                        font-size: x-small; color: <%# Eval("result").ToString()=="返工"?"red":"#10AEFF"%>; 
                                                        display:<%# (Eval("result").ToString()=="返工" || Eval("result").ToString()=="分选")?"inline-block":"none"%>; ">
                                                    <%#Eval("result") %>
                                                </span>
                                            </span>
                                                <span class="weui-agree__text" style="font-size: smaller">
                                                    <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
                                                    <%-- <font class='f-blue'>"+Eval("times")+"</font>--%>
                                                    <span style="color:<%# Eval("is_chao_time").ToString()=="Y"?"red":"#10AEFF" %>;">
                                                        <%# Eval("times") %>
                                                    </span>
                                                </span>
                                        </div>
                                    </a>

                                </ItemTemplate>
                            </asp:Repeater>
                                       
                        </div>
                    </div>
                </li>
            </ul>
        </div>

        <div class="weui-form-preview">
            <ul class="collapse">
                <li class="js-show">
                    <div class="weui-flex js-category">
                        <div class="weui-cells__title fl weui-flex__item">
                            <i class="icon nav-icon icon-49"></i>三车间 不合格 待入库
                            <span class="weui-badge  bg-<% =(count_98_3==0?"gray":"orange") %>"><% =count_98_3 %></span>
                        </div>
                        <i class="icon icon-35"></i>
                    </div>
                    <div class="page-category js-categoryInner">
                        <div class="weui-cells select" id="_98_3">
                            <asp:Repeater runat="server" ID="list_98_3" EnableTheming="False">
                                <ItemTemplate>
                                    <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>','<%# Eval("workshop") %>')>
                                        <div class="weui-mark-vip"><span class="weui-mark-lt bg-green"></span></div>
                                        <div class="weui-cell__hd">
                                            <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                        </div>
                                        <div class="weui-cell__bd">
                                                <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                <%# "单号"+Eval("workorder") %>
                                                <span style="display:<%# Eval("workorder_f").ToString()!=""?"inline-block":"none"%>; ">
                                                    <%# " 分单号" + Eval("workorder_f") %>
                                                </span>
                                                <span style="display:<%# Eval("workorder_f_a").ToString()!=""?"inline-block":"none"%>; ">
                                                    <%# " 父单号" + Eval("workorder_f_a") %>
                                                </span>
                                                <span style="display:<%# (Eval("stepid").ToString()=="9998" || Eval("stepid").ToString()=="9999")?"inline-block":"none"%>; ">
                                                    <%# " 关联单号" + Eval("workorder_gl") %>
                                                </span>
                                            </span>
                                            <span class="weui-form-preview__value" style="font-size: smaller">
                                                <%# Eval("pgino") + "," + Eval("pn") + "," +Eval("op") + "" +Eval("op_descr")  %>
                                            </span>
                                            <span class="weui-form-preview__value" style="font-size: smaller">
                                                <span style="display:<%# Eval("reason_code").ToString()!=""?"inline-block":"none"%>;"><%# Eval("reason_code") + "" + Eval("reason") + "," %></span>
                                                <%# Eval("cur_qty")+"件" %>
                                                <span class="weui-mark-rt- weui-badge weui-badge-tr" 
                                                    style="
                                                        font-size: x-small; color: <%# Eval("type").ToString()=="部分"?"#F7CF07":"#10AEFF"%>;
                                                        display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                    <%#Eval("type") %>
                                                </span>
                                                <span class="weui-mark-rt- weui-badge weui-badge-tr" 
                                                    style="
                                                        font-size: x-small; color: <%# Eval("result").ToString()=="返工"?"red":"#10AEFF"%>; 
                                                        display:<%# (Eval("result").ToString()=="返工" || Eval("result").ToString()=="分选")?"inline-block":"none"%>; ">
                                                    <%#Eval("result") %>
                                                </span>
                                            </span>
                                                <span class="weui-agree__text" style="font-size: smaller">
                                                    <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
                                                    <%-- <font class='f-blue'>"+Eval("times")+"</font>--%>
                                                    <span style="color:<%# Eval("is_chao_time").ToString()=="Y"?"red":"#10AEFF" %>;">
                                                        <%# Eval("times") %>
                                                    </span>
                                                </span>
                                        </div>
                                    </a>

                                </ItemTemplate>
                            </asp:Repeater>
                                       
                        </div>
                    </div>
                </li>
            </ul>
        </div>
        
        <div class="weui-form-preview">
            <ul class="collapse">
                <li class="js-show">
                    <div class="weui-flex js-category">
                        <div class="weui-cells__title fl weui-flex__item">
                            <i class="icon nav-icon icon-49"></i>四车间 不合格 待入库
                            <span class="weui-badge  bg-<% =(count_98_4==0?"gray":"orange") %>"><% =count_98_4 %></span>
                        </div>
                        <i class="icon icon-35"></i>
                    </div>
                    <div class="page-category js-categoryInner">
                        <div class="weui-cells select" id="_98_4">
                            <asp:Repeater runat="server" ID="list_98_4" EnableTheming="False">
                                <ItemTemplate>
                                    <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>','<%# Eval("workshop") %>')>
                                        <div class="weui-mark-vip"><span class="weui-mark-lt bg-green"></span></div>
                                        <div class="weui-cell__hd">
                                            <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                        </div>
                                        <div class="weui-cell__bd">
                                                <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                <%# "单号"+Eval("workorder") %>
                                                <span style="display:<%# Eval("workorder_f").ToString()!=""?"inline-block":"none"%>; ">
                                                    <%# " 分单号" + Eval("workorder_f") %>
                                                </span>
                                                <span style="display:<%# Eval("workorder_f_a").ToString()!=""?"inline-block":"none"%>; ">
                                                    <%# " 父单号" + Eval("workorder_f_a") %>
                                                </span>
                                                <span style="display:<%# (Eval("stepid").ToString()=="9998" || Eval("stepid").ToString()=="9999")?"inline-block":"none"%>; ">
                                                    <%# " 关联单号" + Eval("workorder_gl") %>
                                                </span>
                                            </span>
                                            <span class="weui-form-preview__value" style="font-size: smaller">
                                                <%# Eval("pgino") + "," + Eval("pn") + "," +Eval("op") + "" +Eval("op_descr")  %>
                                            </span>
                                            <span class="weui-form-preview__value" style="font-size: smaller">
                                                <span style="display:<%# Eval("reason_code").ToString()!=""?"inline-block":"none"%>;"><%# Eval("reason_code") + "" + Eval("reason") + "," %></span>
                                                <%# Eval("cur_qty")+"件" %>
                                                <span class="weui-mark-rt- weui-badge weui-badge-tr" 
                                                    style="
                                                        font-size: x-small; color: <%# Eval("type").ToString()=="部分"?"#F7CF07":"#10AEFF"%>;
                                                        display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                    <%#Eval("type") %>
                                                </span>
                                                <span class="weui-mark-rt- weui-badge weui-badge-tr" 
                                                    style="
                                                        font-size: x-small; color: <%# Eval("result").ToString()=="返工"?"red":"#10AEFF"%>; 
                                                        display:<%# (Eval("result").ToString()=="返工" || Eval("result").ToString()=="分选")?"inline-block":"none"%>; ">
                                                    <%#Eval("result") %>
                                                </span>
                                            </span>
                                                <span class="weui-agree__text" style="font-size: smaller">
                                                    <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
                                                    <%-- <font class='f-blue'>"+Eval("times")+"</font>--%>
                                                    <span style="color:<%# Eval("is_chao_time").ToString()=="Y"?"red":"#10AEFF" %>;">
                                                        <%# Eval("times") %>
                                                    </span>
                                                </span>
                                        </div>
                                    </a>

                                </ItemTemplate>
                            </asp:Repeater>
                                       
                        </div>
                    </div>
                </li>
            </ul>
        </div>
        
        <%----已入库(24h内)-----%>
        <div class="weui-form-preview">
            <%
                dt_line = ViewState["dt_data_end_2"] as System.Data.DataTable;
                rowscount = dt_line.Rows.Count;
            %>
            <ul class="collapse">
                <li>
                    <div class="weui-flex js-category">
                        <div class="weui-cells__title fl weui-flex__item">
                            <i class="icon nav-icon icon-49"></i>二车间 已入库(24小时内)
                            <span class="weui-badge  bg-<% =(rowscount==0?"gray":"blue") %> margin20-l " style="margin-right: 15px;">
                                <% =rowscount %>
                            </span>
                        </div>
                        <i class="icon icon-74"></i>
                    </div>
                    <div class="page-category js-categoryInner">
                        <div class="weui-cells select">
                            <%                                          
                                dataView = dt_line.DefaultView;
                                dtLineDistinct = dataView.ToTable(true, "line");
                                foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                {
                                    string line = drLine["line"].ToString();
                            %>
                            <ul class="collapse">
                                <li style="margin-top:0px;margin-bottom:0px">
                                    <div class="weui-flex js-category line " onclick="showorhide(this);">
                                        <div class="weui-cells__title weui-flex__item LH" id="<%=line %>LH5">
                                            <i class="icon nav-icon icon-22 color-success"></i><%=line %>
                                            <span class="weui-badge bg-blue margin20-l " style="margin-right: 15px;">
                                                <% =(ViewState["dt_data_end_2"] as System.Data.DataTable).Select("line='" + line + "'").Count() %>
                                            </span>
                                        </div>
                                        <i class="icon icon-74 right"></i>
                                    </div>
                                    <div class="page-category js-categoryInner lined" style="display: none">
                                        <div class="weui-cells">
                                        <%                                                  
                                            System.Data.DataTable dt = ViewState["dt_data_end_2"] as System.Data.DataTable;
                                            foreach (System.Data.DataRow dr in dt.Select("line='" + line + "'"))
                                            { %>
                                        <a class="weui-cell  weui-cell_access " style="color: black" 
                                            href="prod_qcc_timeline_info_v3.aspx?dh=<%=dr["dh"] %>">
                                            <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                            <div class="weui-cell__hd">
                                                <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                            </div>
                                            <div class="weui-cell__bd " style="font-size: smaller">
                                                <span class="margin10-r">
                                                    <%=dr["pgino"] %> 
                                                </span>
                                                <span class="margin10-r">
                                                    <%=dr["pn"] %>
                                                </span>
                                                <span>入库单:<%=dr["dh"] %><br />
                                                </span>
                                                <span class="margin20-r">
                                                    <% if (dr["b_type"].ToString() == "0")
                                                        {%>
                                                    <span>完工单:</span>
                                                    <%}
                                                        else if (dr["b_type"].ToString() == "1"||dr["b_type"].ToString() == "99")
                                                        {%>
                                                    <span>终检单:</span>
                                                    <%}
                                                        else if (dr["b_type"].ToString() == "2")
                                                        {%>
                                                    <span>GP12单:</span>
                                                    <%}%>
                                                    <%=dr["workorder"] %>
                                                </span>
                                                <span>数量: <font class="f-blue"><%=dr["act_qty"] %></font></span>
                                                <br />
                                                <span class="weui-agree__text span_space">
                                                    <%=dr["cellphone"] %><%=dr["Emp_Name"] %>
                                                </span>
                                                <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}",dr["ruku_date_hg"]) %> </span>
                                                <span class="weui-agree__text">时长:<font class="f-deepfont"> <%=dr["times"] %></font></span>

                                            </div>
                                            <div class="weui-cell__ft">
                                            </div>
                                        </a>
                                        <% }%>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                            <% 
                                }%>
                        </div>
                    </div>
                </li>
            </ul>

        </div>
        
        <div class="weui-form-preview">
            <%
                dt_line = ViewState["dt_data_end_3"] as System.Data.DataTable;
                rowscount = dt_line.Rows.Count;
            %>
            <ul class="collapse">
                <li>
                    <div class="weui-flex js-category">
                        <div class="weui-cells__title fl weui-flex__item">
                            <i class="icon nav-icon icon-49"></i>三车间 已入库(24小时内)
                            <span class="weui-badge  bg-<% =(rowscount==0?"gray":"blue") %> margin20-l " style="margin-right: 15px;">
                                <% =rowscount %>
                            </span>
                        </div>
                        <i class="icon icon-74"></i>
                    </div>
                    <div class="page-category js-categoryInner">
                        <div class="weui-cells select">
                            <%                                          
                                dataView = dt_line.DefaultView;
                                dtLineDistinct = dataView.ToTable(true, "line");
                                foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                {
                                    string line = drLine["line"].ToString();
                            %>
                            <ul class="collapse">
                                <li style="margin-top:0px;margin-bottom:0px">
                                    <div class="weui-flex js-category line " onclick="showorhide(this);">
                                        <div class="weui-cells__title weui-flex__item LH" id="<%=line %>LH5">
                                            <i class="icon nav-icon icon-22 color-success"></i><%=line %>
                                            <span class="weui-badge bg-blue margin20-l " style="margin-right: 15px;">
                                                <% =(ViewState["dt_data_end_3"] as System.Data.DataTable).Select("line='" + line + "'").Count() %>
                                            </span>
                                        </div>
                                        <i class="icon icon-74 right"></i>
                                    </div>
                                    <div class="page-category js-categoryInner lined" style="display: none">
                                        <div class="weui-cells">
                                        <%                                                  
                                            System.Data.DataTable dt = ViewState["dt_data_end_3"] as System.Data.DataTable;
                                            foreach (System.Data.DataRow dr in dt.Select("line='" + line + "'"))
                                            { %>
                                        <a class="weui-cell  weui-cell_access " style="color: black" 
                                            href="prod_qcc_timeline_info_yz.aspx?dh=<%=dr["dh"].ToString()==""?dr["workorder"]:dr["dh"] %>">
                                            <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                            <div class="weui-cell__hd">
                                                <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                            </div>
                                            <div class="weui-cell__bd " style="font-size: smaller">
                                                <span class="margin10-r">
                                                    <%=dr["pgino"] %> 
                                                </span>
                                                <span class="margin10-r">
                                                    <%=dr["pn"] %>
                                                </span>
                                                <br />
                                                <span>入库单:<%=dr["dh"] %>
                                                </span>
                                                <span class="margin20-r">
                                                    <% if (dr["b_type"].ToString() == "0")
                                                        {%>
                                                    <span>完工单:</span>
                                                    <%}
                                                        else if (dr["b_type"].ToString() == "1")
                                                        {%>
                                                    <span>终检单:</span>
                                                    <%}
                                                        else if (dr["b_type"].ToString() == "2")
                                                        {%>
                                                    <span>GP12单:</span>
                                                    <%}%>
                                                    <%=dr["workorder"] %>
                                                </span>
                                                <span>入库数量: <font class="f-blue"><%=dr["act_qty"] %></font></span>
                                                <br />
                                                <span class="weui-agree__text span_space">
                                                    <%=dr["cellphone"] %><%=dr["Emp_Name"] %>
                                                </span>
                                                <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}",dr["ruku_date_hg"]) %> </span>
                                                <span class="weui-agree__text">时长:<font class="f-deepfont"> <%=dr["times"] %></font></span>
                                            </div>
                                            <div class="weui-cell__ft">
                                            </div>
                                        </a>
                                        <% }%>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                            <% 
                                }%>
                        </div>
                    </div>
                </li>
            </ul>

        </div>
                
        <div class="weui-form-preview">
            <%
                dt_line = ViewState["dt_data_end_4"] as System.Data.DataTable;
                rowscount = dt_line.Rows.Count;
            %>
            <ul class="collapse">
                <li>
                    <div class="weui-flex js-category">
                        <div class="weui-cells__title fl weui-flex__item">
                            <i class="icon nav-icon icon-49"></i>四车间 已入库(24小时内)
                            <span class="weui-badge  bg-<% =(rowscount==0?"gray":"blue") %> margin20-l " style="margin-right: 15px;">
                                <% =rowscount %>
                            </span>
                        </div>
                        <i class="icon icon-74"></i>
                    </div>
                    <div class="page-category js-categoryInner">
                        <div class="weui-cells select">
                            <%                                          
                                dataView = dt_line.DefaultView;
                                dtLineDistinct = dataView.ToTable(true, "line");
                                foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                {
                                    string line = drLine["line"].ToString();
                            %>
                            <ul class="collapse">
                                <li style="margin-top:0px;margin-bottom:0px">
                                    <div class="weui-flex js-category line " onclick="showorhide(this);">
                                        <div class="weui-cells__title weui-flex__item LH" id="<%=line %>LH5">
                                            <i class="icon nav-icon icon-22 color-success"></i><%=line %>
                                            <span class="weui-badge bg-blue margin20-l " style="margin-right: 15px;">
                                                <% =(ViewState["dt_data_end_4"] as System.Data.DataTable).Select("line='" + line + "'").Count() %>
                                            </span>
                                        </div>
                                        <i class="icon icon-74 right"></i>
                                    </div>
                                    <div class="page-category js-categoryInner lined" style="display: none">
                                        <div class="weui-cells">
                                        <%                                                  
                                            System.Data.DataTable dt = ViewState["dt_data_end_4"] as System.Data.DataTable;
                                            foreach (System.Data.DataRow dr in dt.Select("line='" + line + "'"))
                                            { %>
                                        <a class="weui-cell  weui-cell_access " style="color: black" 
                                            href="prod_qcc_timeline_info_v3.aspx?dh=<%=dr["dh"] %>">
                                            <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                            <div class="weui-cell__hd">
                                                <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                            </div>
                                            <div class="weui-cell__bd " style="font-size: smaller">
                                                <span class="margin10-r">
                                                    <%=dr["pgino"] %> 
                                                </span>
                                                <span class="margin10-r">
                                                    <%=dr["pn"] %>
                                                </span>
                                                <span>入库单:<%=dr["dh"] %><br />
                                                </span>
                                                <span class="margin20-r">
                                                    <% if (dr["b_type"].ToString() == "0")
                                                        {%>
                                                    <span>完工单:</span>
                                                    <%}
                                                        else if (dr["b_type"].ToString() == "1"||dr["b_type"].ToString() == "99")
                                                        {%>
                                                    <span>终检单:</span>
                                                    <%}
                                                        else if (dr["b_type"].ToString() == "2")
                                                        {%>
                                                    <span>GP12单:</span>
                                                    <%}%>
                                                    <%=dr["workorder"] %>
                                                </span>
                                                <span>数量: <font class="f-blue"><%=dr["act_qty"] %></font></span>
                                                <br />
                                                <span class="weui-agree__text span_space">
                                                    <%=dr["cellphone"] %><%=dr["Emp_Name"] %>
                                                </span>
                                                <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}",dr["ruku_date_hg"]) %> </span>
                                                <span class="weui-agree__text">时长:<font class="f-deepfont"> <%=dr["times"] %></font></span>

                                            </div>
                                            <div class="weui-cell__ft">
                                            </div>
                                        </a>
                                        <% }%>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                            <% 
                                }%>
                        </div>
                    </div>
                </li>
            </ul>

        </div>


        <%----不合格已入库(24h内)-----%>
        <div class="weui-form-preview">
            <ul class="collapse">
                <li>
                    <div class="weui-flex js-category">
                        <div class="weui-cells__title fl weui-flex__item">
                            <i class="icon nav-icon icon-49"></i>二车间 不合格 已入库(24h内)
                            <span class="weui-badge  bg-<% =(count_99_2==0?"gray":"orange") %>"><% =count_99_2 %></span>
                        </div>
                        <i class="icon icon-74"></i>
                    </div>
                    <div class="page-category js-categoryInner">
                        <div class="weui-cells select" id="_99_2">
                            <asp:Repeater runat="server" ID="list_99_2_line" EnableTheming="False" OnItemDataBound="list_99_2_line_ItemDataBound">
                                <ItemTemplate>
                                    <ul class="collapse">
                                        <li style="margin-top:0px;margin-bottom:0px">
                                            <div class="weui-flex js-category line" onclick="showorhide(this);">
                                                <div class="weui-cells__title  weui-flex__item">
                                                    <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("line") %></span>
                                                    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                </div>
                                                <i class="icon icon-74"></i>
                                            </div>
                                            <div class="page-category js-categoryInner lined" style="display: none">
                                                <div class="weui-cells">     
                                                    <asp:Repeater runat="server" ID="list_99_2" EnableTheming="False">
                                                        <ItemTemplate>
                                                            <a class="weui-cell weui-cell_access" 
                                                                onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>','<%# Eval("workshop") %>')>
                                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                                                <div class="weui-cell__hd">
                                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                </div>
                                                                <div class="weui-cell__bd">
                                                                        <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                                        <%# "单号"+Eval("workorder") %>
                                                                        <span style="display:<%# Eval("workorder_f").ToString()!=""?"inline-block":"none"%>; ">
                                                                            <%# " 分单号" + Eval("workorder_f") %>
                                                                        </span>
                                                                        <span style="display:<%# Eval("workorder_f_a").ToString()!=""?"inline-block":"none"%>; ">
                                                                            <%# " 父单号" + Eval("workorder_f_a") %>
                                                                        </span>
                                                                        <span style="display:<%# (Eval("stepid").ToString()=="9998" || Eval("stepid").ToString()=="9999")?"inline-block":"none"%>; ">
                                                                            <%# " 关联单号" + Eval("workorder_gl") %>
                                                                        </span>
                                                                    </span>
                                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                                        <%# Eval("pgino") + "," + Eval("pn") + "," +Eval("op") + "" +Eval("op_descr")  %>
                                                                    </span>
                                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                                        <span style="display:<%# Eval("reason_code").ToString()!=""?"inline-block":"none"%>;"><%# Eval("reason_code") + "" + Eval("reason") + "," %></span>
                                                                        <%# Eval("cur_qty")+"件" %>
                                                                        <span class="weui-mark-rt- weui-badge weui-badge-tr" 
                                                                            style="
                                                                                font-size: x-small; color: <%# Eval("type").ToString()=="部分"?"#F7CF07":"#10AEFF"%>; 
                                                                                display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                                            <%#Eval("type") %>
                                                                        </span>
                                                                        <span class="weui-mark-rt- weui-badge weui-badge-tr" 
                                                                            style="
                                                                                font-size: x-small; color: <%# Eval("result").ToString()=="返工"?"red":"#10AEFF"%>; 
                                                                                display:<%# (Eval("result").ToString()=="返工" || Eval("result").ToString()=="分选")?"inline-block":"none"%>; ">
                                                                            <%#Eval("result") %>
                                                                        </span>
                                                                    </span>
                                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                                            <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
                                                                            <%-- <font class='f-blue'>"+Eval("times")+"</font>--%>
                                                                            <span style="color:<%# Eval("is_chao_time").ToString()=="Y"?"red":"#10AEFF" %>;">
                                                                                <%# Eval("times") %>
                                                                            </span>
                                                                        </span>
                                                                </div>
                                                            </a>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>                
                    </div>
                </li>
            </ul>
                                
        </div>
        
        <div class="weui-form-preview">
            <ul class="collapse">
                <li>
                    <div class="weui-flex js-category">
                        <div class="weui-cells__title fl weui-flex__item">
                            <i class="icon nav-icon icon-49"></i>三车间 不合格 已入库(24h内)
                            <span class="weui-badge  bg-<% =(count_99_3==0?"gray":"orange") %>"><% =count_99_3 %></span>
                        </div>
                        <i class="icon icon-74"></i>
                    </div>
                    <div class="page-category js-categoryInner">
                        <div class="weui-cells select" id="_99_3">
                            <asp:Repeater runat="server" ID="list_99_3_line" EnableTheming="False" OnItemDataBound="list_99_3_line_ItemDataBound">
                                <ItemTemplate>
                                    <ul class="collapse">
                                        <li style="margin-top:0px;margin-bottom:0px">
                                            <div class="weui-flex js-category line" onclick="showorhide(this);">
                                                <div class="weui-cells__title  weui-flex__item">
                                                    <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("line") %></span>
                                                    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                </div>
                                                <i class="icon icon-74"></i>
                                            </div>
                                            <div class="page-category js-categoryInner lined" style="display: none">
                                                <div class="weui-cells">     
                                                    <asp:Repeater runat="server" ID="list_99_3" EnableTheming="False">
                                                        <ItemTemplate>
                                                            <a class="weui-cell weui-cell_access" 
                                                                onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>','<%# Eval("workshop") %>')>
                                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                                                <div class="weui-cell__hd">
                                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                </div>
                                                                <div class="weui-cell__bd">
                                                                        <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                                        <%# "单号"+Eval("workorder") %>
                                                                        <span style="display:<%# Eval("workorder_f").ToString()!=""?"inline-block":"none"%>; ">
                                                                            <%# " 分单号" + Eval("workorder_f") %>
                                                                        </span>
                                                                        <span style="display:<%# Eval("workorder_f_a").ToString()!=""?"inline-block":"none"%>; ">
                                                                            <%# " 父单号" + Eval("workorder_f_a") %>
                                                                        </span>
                                                                        <span style="display:<%# (Eval("stepid").ToString()=="9998" || Eval("stepid").ToString()=="9999")?"inline-block":"none"%>; ">
                                                                            <%# " 关联单号" + Eval("workorder_gl") %>
                                                                        </span>
                                                                    </span>
                                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                                        <%# Eval("pgino") + "," + Eval("pn") + "," +Eval("op") + "" +Eval("op_descr")  %>
                                                                    </span>
                                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                                        <span style="display:<%# Eval("reason_code").ToString()!=""?"inline-block":"none"%>;"><%# Eval("reason_code") + "" + Eval("reason") + "," %></span>
                                                                        <%# Eval("cur_qty")+"件" %>
                                                                        <span class="weui-mark-rt- weui-badge weui-badge-tr" 
                                                                            style="
                                                                                font-size: x-small; color: <%# Eval("type").ToString()=="部分"?"#F7CF07":"#10AEFF"%>; 
                                                                                display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                                            <%#Eval("type") %>
                                                                        </span>
                                                                        <span class="weui-mark-rt- weui-badge weui-badge-tr" 
                                                                            style="
                                                                                font-size: x-small; color: <%# Eval("result").ToString()=="返工"?"red":"#10AEFF"%>; 
                                                                                display:<%# (Eval("result").ToString()=="返工" || Eval("result").ToString()=="分选")?"inline-block":"none"%>; ">
                                                                            <%#Eval("result") %>
                                                                        </span>
                                                                    </span>
                                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                                            <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
                                                                            <%-- <font class='f-blue'>"+Eval("times")+"</font>--%>
                                                                            <span style="color:<%# Eval("is_chao_time").ToString()=="Y"?"red":"#10AEFF" %>;">
                                                                                <%# Eval("times") %>
                                                                            </span>
                                                                        </span>
                                                                </div>
                                                            </a>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>                
                    </div>
                </li>
            </ul>
                                
        </div>
        
        <div class="weui-form-preview">
            <ul class="collapse">
                <li>
                    <div class="weui-flex js-category">
                        <div class="weui-cells__title fl weui-flex__item">
                            <i class="icon nav-icon icon-49"></i>四车间 不合格 已入库(24h内)
                            <span class="weui-badge  bg-<% =(count_99_4==0?"gray":"orange") %>"><% =count_99_4 %></span>
                        </div>
                        <i class="icon icon-74"></i>
                    </div>
                    <div class="page-category js-categoryInner">
                        <div class="weui-cells select" id="_99_4">
                            <asp:Repeater runat="server" ID="list_99_4_line" EnableTheming="False" OnItemDataBound="list_99_4_line_ItemDataBound">
                                <ItemTemplate>
                                    <ul class="collapse">
                                        <li style="margin-top:0px;margin-bottom:0px">
                                            <div class="weui-flex js-category line" onclick="showorhide(this);">
                                                <div class="weui-cells__title  weui-flex__item">
                                                    <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("line") %></span>
                                                    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                </div>
                                                <i class="icon icon-74"></i>
                                            </div>
                                            <div class="page-category js-categoryInner lined" style="display: none">
                                                <div class="weui-cells">     
                                                    <asp:Repeater runat="server" ID="list_99_4" EnableTheming="False">
                                                        <ItemTemplate>
                                                            <a class="weui-cell weui-cell_access" 
                                                                onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>','<%# Eval("workshop") %>')>
                                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                                                <div class="weui-cell__hd">
                                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                </div>
                                                                <div class="weui-cell__bd">
                                                                        <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                                        <%# "单号"+Eval("workorder") %>
                                                                        <span style="display:<%# Eval("workorder_f").ToString()!=""?"inline-block":"none"%>; ">
                                                                            <%# " 分单号" + Eval("workorder_f") %>
                                                                        </span>
                                                                        <span style="display:<%# Eval("workorder_f_a").ToString()!=""?"inline-block":"none"%>; ">
                                                                            <%# " 父单号" + Eval("workorder_f_a") %>
                                                                        </span>
                                                                        <span style="display:<%# (Eval("stepid").ToString()=="9998" || Eval("stepid").ToString()=="9999")?"inline-block":"none"%>; ">
                                                                            <%# " 关联单号" + Eval("workorder_gl") %>
                                                                        </span>
                                                                    </span>
                                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                                        <%# Eval("pgino") + "," + Eval("pn") + "," +Eval("op") + "" +Eval("op_descr")  %>
                                                                    </span>
                                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                                        <span style="display:<%# Eval("reason_code").ToString()!=""?"inline-block":"none"%>;"><%# Eval("reason_code") + "" + Eval("reason") + "," %></span>
                                                                        <%# Eval("cur_qty")+"件" %>
                                                                        <span class="weui-mark-rt- weui-badge weui-badge-tr" 
                                                                            style="
                                                                                font-size: x-small; color: <%# Eval("type").ToString()=="部分"?"#F7CF07":"#10AEFF"%>; 
                                                                                display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                                            <%#Eval("type") %>
                                                                        </span>
                                                                        <span class="weui-mark-rt- weui-badge weui-badge-tr" 
                                                                            style="
                                                                                font-size: x-small; color: <%# Eval("result").ToString()=="返工"?"red":"#10AEFF"%>; 
                                                                                display:<%# (Eval("result").ToString()=="返工" || Eval("result").ToString()=="分选")?"inline-block":"none"%>; ">
                                                                            <%#Eval("result") %>
                                                                        </span>
                                                                    </span>
                                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                                            <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
                                                                            <%-- <font class='f-blue'>"+Eval("times")+"</font>--%>
                                                                            <span style="color:<%# Eval("is_chao_time").ToString()=="Y"?"red":"#10AEFF" %>;">
                                                                                <%# Eval("times") %>
                                                                            </span>
                                                                        </span>
                                                                </div>
                                                            </a>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>                
                    </div>
                </li>
            </ul>
                                
        </div>

        <div class="weui-footer weui-footer_fixed-bottom">
            <%--<p class="weui-footer__text"><%=WeiXin.GetCookie("workcode") +((LoginUser)WeiXin.GetJsonCookie()).UserName %></p>--%>
        </div>
        <script>
            $(function () {
                $('.weui-navbar__item').on('click', function () {
                    $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
                    $($(this).attr("href")).show().siblings('.weui-tab__content').hide();
                });

            });
        </script>
    </form>


</body>
</html>
