﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bhgp_Apply_list_ZL.aspx.cs" Inherits="WorkOrder_bhgp_Apply_list_V1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>不合格监视</title>
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
         .weui-badge-tr {
            border: 1px solid ;
            background-color: transparent;
        }
        .collapse li.js-show .weui-flex {
            opacity: 0.8;
        }
        .collapse .weui-flex {     
            padding:0px 10px 0px 10px; 
                 
        }
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
                    if (this.id == "_01") {
                        $(obj).addClass("bg-red").removeClass("bg-gray");
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
                    window.location.href = "/workorder/bhgp_Apply_V1.aspx?workorder=" + workorder + "&workorder_f=" + workorder_f + "&workshop=" + workshop;
                } else if (stepid == "9998") {//--待入库
                    window.location.href = "/workorder/CKSH.aspx?workorder_f=" + workorder_f + "&dh=" + workorder_gl + "&workshop=" + workshop + "&ck=Z";
                }
                else {
                    window.location.href = "/workorder/bhgp_sign_V1.aspx?stepid=" + stepid + "&workorder=" + workorder + "&workorder_f=" + workorder_f + "&workshop=" + workshop;
                }
            }
            if (workshop == "三车间") {
                if (stepid == "0002") {//--检验处置
                    window.location.href = "/workorder/bhgp_Apply_yz.aspx?workorder=" + workorder + "&workorder_f=" + workorder_f + "&workshop=" + workshop;
                } else if (stepid == "9998") {//--待入库
                    window.location.href = "/workorder/CKSH.aspx?workorder_f=" + workorder_f + "&dh=" + workorder_gl + "&workshop=" + workshop + "&ck=Z";
                }
                else {
                    window.location.href = "/workorder/bhgp_sign_yz.aspx?stepid=" + stepid + "&workorder=" + workorder + "&workorder_f=" + workorder_f + "&workshop=" + workshop;
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
        <div class="page">
            <div class="page__bd" id="t2" style="height: 100%;">
                <div class="weui-tab">
                    <div class="weui-navbar">
                        <div href="#tab1" class="weui-navbar__item weui-bar__item_on">
                            不合格监视
                        </div>
                        <div href="#tab2" class="weui-navbar__item">
                            我的不合格
                        </div>
                    </div>

                    <div class="weui-tab__panel" style="background-color:lightgray">
                        <%--=======不合格监视-----%>
                        <div id="tab1" class="weui-tab__content">
                            
                            <div class="weui-form-preview">
                                <ul class="collapse">
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title fl weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>检验处置
                                                <span class="weui-badge  bg-<% =(count_02==0?"gray":"blue") %>"><% =count_02 %></span>
                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells select" id="_02">
                                                <asp:Repeater runat="server" ID="list_02_line" EnableTheming="False" OnItemDataBound="list_02_line_ItemDataBound">
                                                    <ItemTemplate>
                                                        <ul class="collapse">
                                                            <li style="margin-top:0px;margin-bottom:0px">
                                                                <div class="weui-flex js-category line" onclick="showorhide(this);">
                                                                    <div class="weui-cells__title  weui-flex__item">
                                                                        <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("workshop") %></span>
                                                                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                                    </div>
                                                                    <i class="icon icon-74"></i>
                                                                </div>
                                                                <div class="page-category js-categoryInner lined" style="display:none;">
                                                                    <div class="weui-cells">
                                                                        <asp:Repeater runat="server" ID="list_02" EnableTheming="False">
                                                                            <ItemTemplate>
                                                                                <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>','<%# Eval("workshop") %>')>
                                                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
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
                                                                                            <span class="weui-mark-rt- weui-badge weui-badge-tr" 
                                                                                                style="
                                                                                                    font-size: x-small; color: <%# Eval("result_rs").ToString()=="无法判定"?"#F7CF07":"#10AEFF"%>; 
                                                                                                    display:<%# (Eval("result_rs").ToString()=="无法判定")?"inline-block":"none"%>; ">
                                                                                                <%#Eval("result_rs") %>
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
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title fl weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>质量工程师
                                                <span class="weui-badge  bg-<% =(count_03==0?"gray":"blue") %>"><% =count_03 %></span>
                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells select" id="_03">
                                                <asp:Repeater runat="server" ID="list_03_line" EnableTheming="False" OnItemDataBound="list_03_line_ItemDataBound">
                                                    <ItemTemplate>
                                                        <ul class="collapse">
                                                            <li style="margin-top:0px;margin-bottom:0px">
                                                                <div class="weui-flex js-category line" onclick="showorhide(this);">
                                                                    <div class="weui-cells__title  weui-flex__item">
                                                                        <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("workshop") %></span>
                                                                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                                    </div>
                                                                    <i class="icon icon-74"></i>
                                                                </div>
                                                                <div class="page-category js-categoryInner lined" style="display:none;">
                                                                    <div class="weui-cells">
                                                                        <asp:Repeater runat="server" ID="list_03" EnableTheming="False">
                                                                            <ItemTemplate>
                                                                                <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>','<%# Eval("workshop") %>')>
                                                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
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
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title fl weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>质量经理
                                                <span class="weui-badge  bg-<% =(count_04==0?"gray":"blue") %>"><% =count_04 %></span>
                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells select" id="_04">
                                                <asp:Repeater runat="server" ID="list_04_line" EnableTheming="False" OnItemDataBound="list_04_line_ItemDataBound">
                                                    <ItemTemplate>
                                                        <ul class="collapse">
                                                            <li style="margin-top:0px;margin-bottom:0px">
                                                                <div class="weui-flex js-category line" onclick="showorhide(this);">
                                                                    <div class="weui-cells__title  weui-flex__item">
                                                                        <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("workshop") %></span>
                                                                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                                    </div>
                                                                    <i class="icon icon-74"></i>
                                                                </div>
                                                                <div class="page-category js-categoryInner lined" style="display:none;">
                                                                    <div class="weui-cells">
                                                                        <asp:Repeater runat="server" ID="list_04" EnableTheming="False">
                                                                            <ItemTemplate>
                                                                                <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>','<%# Eval("workshop") %>')>
                                                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
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
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title fl weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>总经理
                                                <span class="weui-badge  bg-<% =(count_05==0?"gray":"blue") %>"><% =count_05 %></span>
                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells select" id="_05">
                                                <asp:Repeater runat="server" ID="list_05_line" EnableTheming="False" OnItemDataBound="list_05_line_ItemDataBound">
                                                    <ItemTemplate>
                                                        <ul class="collapse">
                                                            <li style="margin-top:0px;margin-bottom:0px">
                                                                <div class="weui-flex js-category line" onclick="showorhide(this);">
                                                                    <div class="weui-cells__title  weui-flex__item">
                                                                        <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("workshop") %></span>
                                                                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                                    </div>
                                                                    <i class="icon icon-74"></i>
                                                                </div>
                                                                <div class="page-category js-categoryInner lined" style="display:none;">
                                                                    <div class="weui-cells">
                                                                        <asp:Repeater runat="server" ID="list_05" EnableTheming="False">
                                                                            <ItemTemplate>
                                                                                <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>','<%# Eval("workshop") %>')>
                                                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
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
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title fl weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>需返工/挑选
                                                <span class="weui-badge  bg-<% =(count_01==0?"gray":"red") %>"><% =count_01 %></span>
                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells select" id="_01">
                                                <asp:Repeater runat="server" ID="list_01_line" EnableTheming="False" OnItemDataBound="list_01_line_ItemDataBound">
                                                    <ItemTemplate>
                                                        <ul class="collapse">
                                                            <li style="margin-top:0px;margin-bottom:0px">
                                                                <div class="weui-flex js-category line" onclick="showorhide(this);">
                                                                    <div class="weui-cells__title  weui-flex__item">
                                                                        <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("workshop") %></span>
                                                                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                                    </div>
                                                                    <i class="icon icon-74"></i>
                                                                </div>
                                                                <div class="page-category js-categoryInner lined" style="display:none;">
                                                                    <div class="weui-cells">
                                                                        <asp:Repeater runat="server" ID="list_01" EnableTheming="False">
                                                                            <ItemTemplate>
                                                                                <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>','<%# Eval("workshop") %>')>
                                                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-danger"></span></div>
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
                                                                                            <span class="weui-mark-rt- weui-badge  weui-badge-tr" 
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
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title fl weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>待入库
                                                <span class="weui-badge  bg-<% =(count_98==0?"gray":"blue") %>"><% =count_98 %></span>
                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells select" id="_98">
                                                <asp:Repeater runat="server" ID="list_98_line" EnableTheming="False" OnItemDataBound="list_98_line_ItemDataBound">
                                                    <ItemTemplate>
                                                        <ul class="collapse">
                                                            <li style="margin-top:0px;margin-bottom:0px">
                                                                <div class="weui-flex js-category line" onclick="showorhide(this);">
                                                                    <div class="weui-cells__title  weui-flex__item">
                                                                        <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("workshop") %></span>
                                                                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                                    </div>
                                                                    <i class="icon icon-74"></i>
                                                                </div>
                                                                <div class="page-category js-categoryInner lined" style="display:none;">
                                                                    <div class="weui-cells">
                                                                        <asp:Repeater runat="server" ID="list_98" EnableTheming="False">
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
                                                <i class="icon nav-icon icon-49"></i>已入库(24h内)
                                                <span class="weui-badge  bg-<% =(count_99==0?"gray":"blue") %>"><% =count_99 %></span>
                                            </div>
                                            <i class="icon icon-74"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells select" id="_99">
                                                <asp:Repeater runat="server" ID="list_99_line" EnableTheming="False" OnItemDataBound="list_99_line_ItemDataBound">
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
                                                                        <asp:Repeater runat="server" ID="list_99" EnableTheming="False">
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
                                                           
                        </div>
                        <%--=======我的不合格-----%>
                        <div id="tab2" class="weui-tab__content">
                            
                            <div class="weui-form-preview">
                                <ul class="collapse">
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title fl weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>检验处置
                                                <span class="weui-badge  bg-<% =(count_02_my==0?"gray":"blue") %>"><% =count_02_my %></span>
                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells select" id="_02_my">
                                                <asp:Repeater runat="server" ID="list_02_line_my" EnableTheming="False" OnItemDataBound="list_02_line_my_ItemDataBound">
                                                    <ItemTemplate>
                                                        <ul class="collapse">
                                                            <li style="margin-top:0px;margin-bottom:0px">
                                                                <div class="weui-flex js-category" onclick="showorhide(this);">
                                                                    <div class="weui-cells__title  weui-flex__item">
                                                                        <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("workshop") %></span>
                                                                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                                    </div>
                                                                    <i class="icon icon-74"></i>
                                                                </div>
                                                                <div class="page-category js-categoryInner" style="display: none">
                                                                    <div class="weui-cells">  
                                                                        <asp:Repeater runat="server" ID="list_02_my" EnableTheming="False">
                                                                            <ItemTemplate>
                                                                                <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>','<%# Eval("workshop") %>')>
                                                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
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
                                                                                            <span class="weui-mark-rt- weui-badge weui-badge-tr" 
                                                                                                style="
                                                                                                    font-size: x-small; color: <%# Eval("result_rs").ToString()=="无法判定"?"#F7CF07":"#10AEFF"%>; 
                                                                                                    display:<%# (Eval("result_rs").ToString()=="无法判定")?"inline-block":"none"%>; ">
                                                                                                <%#Eval("result_rs") %>
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
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title fl weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>质量工程师
                                                <span class="weui-badge  bg-<% =(count_03_my==0?"gray":"blue") %>"><% =count_03_my %></span>
                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells select" id="_03_my">
                                                <asp:Repeater runat="server" ID="list_03_line_my" EnableTheming="False" OnItemDataBound="list_03_line_my_ItemDataBound">
                                                    <ItemTemplate>
                                                        <ul class="collapse">
                                                            <li style="margin-top:0px;margin-bottom:0px">
                                                                <div class="weui-flex js-category" onclick="showorhide(this);">
                                                                    <div class="weui-cells__title  weui-flex__item">
                                                                        <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("workshop") %></span>
                                                                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                                    </div>
                                                                    <i class="icon icon-74"></i>
                                                                </div>
                                                                <div class="page-category js-categoryInner" style="display: none">
                                                                    <div class="weui-cells">
                                                                        <asp:Repeater runat="server" ID="list_03_my" EnableTheming="False">
                                                                            <ItemTemplate>
                                                                                <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>','<%# Eval("workshop") %>')>
                                                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
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
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title fl weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>质量经理
                                                <span class="weui-badge  bg-<% =(count_04_my==0?"gray":"blue") %>"><% =count_04_my %></span>
                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells select" id="_04_my">
                                                <asp:Repeater runat="server" ID="list_04_line_my" EnableTheming="False" OnItemDataBound="list_04_line_my_ItemDataBound">
                                                    <ItemTemplate>
                                                        <ul class="collapse">
                                                            <li style="margin-top:0px;margin-bottom:0px">
                                                                <div class="weui-flex js-category" onclick="showorhide(this);">
                                                                    <div class="weui-cells__title  weui-flex__item">
                                                                        <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("workshop") %></span>
                                                                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                                    </div>
                                                                    <i class="icon icon-74"></i>
                                                                </div>
                                                                <div class="page-category js-categoryInner" style="display: none">
                                                                    <div class="weui-cells">
                                                                        <asp:Repeater runat="server" ID="list_04_my" EnableTheming="False">
                                                                            <ItemTemplate>
                                                                                <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>','<%# Eval("workshop") %>')>
                                                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
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
                                                                                            <span class="weui-mark-rt- weui-badge  weui-badge-tr" 
                                                                                                style="
                                                                                                    font-size: x-small; color: <%# Eval("type").ToString()=="部分"?"#F7CF07":"#10AEFF"%>; 
                                                                                                    display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                                                                <%#Eval("type") %>
                                                                                            </span>
                                                                                            <span class="weui-mark-rt- weui-badge  weui-badge-tr" 
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
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title fl weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>总经理
                                                <span class="weui-badge  bg-<% =(count_05_my==0?"gray":"blue") %>"><% =count_05_my %></span>
                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells select" id="_05_my">
                                                <asp:Repeater runat="server" ID="list_05_line_my" EnableTheming="False" OnItemDataBound="list_05_line_my_ItemDataBound">
                                                    <ItemTemplate>
                                                        <ul class="collapse">
                                                            <li style="margin-top:0px;margin-bottom:0px">
                                                                <div class="weui-flex js-category" onclick="showorhide(this);">
                                                                    <div class="weui-cells__title  weui-flex__item">
                                                                        <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("workshop") %></span>
                                                                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                                    </div>
                                                                    <i class="icon icon-74"></i>
                                                                </div>
                                                                <div class="page-category js-categoryInner" style="display: none">
                                                                    <div class="weui-cells">
                                                                        <asp:Repeater runat="server" ID="list_05_my" EnableTheming="False">
                                                                            <ItemTemplate>
                                                                                <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>','<%# Eval("workshop") %>')>
                                                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
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
                                                                                            <span class="weui-mark-rt- weui-badge  weui-badge-tr" 
                                                                                                style="
                                                                                                    font-size: x-small; color: <%# Eval("type").ToString()=="部分"?"#F7CF07":"#10AEFF"%>;
                                                                                                    display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                                                                <%#Eval("type") %>
                                                                                            </span>
                                                                                            <span class="weui-mark-rt- weui-badge  weui-badge-tr" 
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
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title fl weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>需返工/挑选
                                                <span class="weui-badge  bg-<% =(count_01_my==0?"gray":"red") %>"><% =count_01_my %></span>
                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells select" id="_01_my">
                                                <asp:Repeater runat="server" ID="list_01_line_my" EnableTheming="False" OnItemDataBound="list_01_line_my_ItemDataBound">
                                                    <ItemTemplate>
                                                        <ul class="collapse">
                                                            <li style="margin-top:0px;margin-bottom:0px">
                                                                <div class="weui-flex js-category" onclick="showorhide(this);">
                                                                    <div class="weui-cells__title  weui-flex__item">
                                                                        <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("workshop") %></span>
                                                                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                                    </div>
                                                                    <i class="icon icon-74"></i>
                                                                </div>
                                                                <div class="page-category js-categoryInner" style="display: none">
                                                                    <div class="weui-cells">
                                                                        <asp:Repeater runat="server" ID="list_01_my" EnableTheming="False">
                                                                            <ItemTemplate>
                                                                                <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>','<%# Eval("workshop") %>')>
                                                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-danger"></span></div>
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
                                                                                            <span class="weui-mark-rt- weui-badge  weui-badge-tr" 
                                                                                                style="
                                                                                                    font-size: x-small; color: <%# Eval("type").ToString()=="部分"?"#F7CF07":"#10AEFF"%>; 
                                                                                                    display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                                                                <%#Eval("type") %>
                                                                                            </span>
                                                                                            <span class="weui-mark-rt- weui-badge  weui-badge-tr" 
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
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title fl weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>待入库
                                                <span class="weui-badge  bg-<% =(count_98_my==0?"gray":"blue") %>"><% =count_98_my %></span>
                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells select" id="_98_my">
                                                <asp:Repeater runat="server" ID="list_98_line_my" EnableTheming="False" OnItemDataBound="list_98_line_my_ItemDataBound">
                                                    <ItemTemplate>
                                                        <ul class="collapse">
                                                            <li style="margin-top:0px;margin-bottom:0px">
                                                                <div class="weui-flex js-category" onclick="showorhide(this);">
                                                                    <div class="weui-cells__title  weui-flex__item">
                                                                        <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("workshop") %></span>
                                                                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                                    </div>
                                                                    <i class="icon icon-74"></i>
                                                                </div>
                                                                <div class="page-category js-categoryInner" style="display: none">
                                                                    <div class="weui-cells">
                                                                        <asp:Repeater runat="server" ID="list_98_my" EnableTheming="False">
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
                                                                                            <span class="weui-mark-rt- weui-badge   weui-badge-tr" 
                                                                                                style="
                                                                                                    font-size: x-small; color: <%# Eval("type").ToString()=="部分"?"#F7CF07":"#10AEFF"%>; 
                                                                                                    display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                                                                <%#Eval("type") %>
                                                                                            </span>
                                                                                            <span class="weui-mark-rt- weui-badge  weui-badge-tr" 
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
                                                <i class="icon nav-icon icon-49"></i>已入库(24h内)
                                                <span class="weui-badge  bg-<% =(count_99_my==0?"gray":"blue") %>"><% =count_99_my %></span>
                                            </div>
                                            <i class="icon icon-74"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells select" id="_99_my">
                                                <asp:Repeater runat="server" ID="list_99_line_my" EnableTheming="False" OnItemDataBound="list_99_line_my_ItemDataBound">
                                                    <ItemTemplate>
                                                        <ul class="collapse">
                                                            <li style="margin-top:0px;margin-bottom:0px">
                                                                <div class="weui-flex js-category" onclick="showorhide(this);">
                                                                    <div class="weui-cells__title  weui-flex__item">
                                                                        <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("line") %></span>
                                                                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                                    </div>
                                                                    <i class="icon icon-74"></i>
                                                                </div>
                                                                <div class="page-category js-categoryInner" style="display: none">
                                                                    <div class="weui-cells">    
                                                                        <asp:Repeater runat="server" ID="list_99_my" EnableTheming="False">
                                                                            <ItemTemplate>
                                                                                <a class="weui-cell weui-cell_access" 
                                                                                    onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>'),'<%# Eval("workorder_gl") %>','<%# Eval("workshop") %>')>
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

                        </div>

                    </div>
                </div>
            </div>
        </div>

        <div class="weui-footer weui-footer_fixed-bottom">
            <%--<p class="weui-footer__links">
                <a href="../index.html" class="weui-footer__link">WeUI首页</a>
            </p>--%>
            <p class="weui-footer__text"><%=WeiXin.GetCookie("workcode") +((LoginUser)WeiXin.GetJsonCookie()).UserName %></p>
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
