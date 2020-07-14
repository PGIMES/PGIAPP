<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Adjust_list.aspx.cs" Inherits="Adjust_list" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>盘盈亏监视</title>

    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <script src="/Content/layer/layer.js"></script>

    <link href="../css/weui.css" rel="stylesheet" />
    <link href="../css/weuix.css" rel="stylesheet" />
    <script src="../js/zepto.min.js"></script>
    <script src="../js/zepto.weui.js"></script>
    <script src="../js/iscroll-lite.js"></script>

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
    </style>
    <script>
         $(function () {
             $('#t2').tab({
                 defaultIndex: 0,
                 activeClass: 'tab-green',
                 onToggle: function (index) {
                     console.log('index' + index);
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

                 var text = $("#searchInput").val();
                 $('.weui-cell').each(function () {
                     var $self = $(this);
                     var flag = $self.text().search(text)
                     if (flag > -1) {
                         $self.removeClass("hide"); //$self.siblings('.weui-cells__title').addClass("hide");
                     } else {
                         $self.addClass("hide"); //$self.siblings('.weui-cells__title').addClass("hide");

                     }
                 });

                 showBlockCount();
             });
         });
         //显示数量
         function showBlockCount() {
             $(".weui-form-preview>.weui-cells").each(function (i, item) {
                 var rowcount = $(this).find("a:not(.hide)").length;
                 // debugger;
                 var obj = $(item).prev().children().last();
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
             //$('.weui-cell').siblings('.weui-cells__title').removeClass("hide");
             showBlockCount();
         }

         function clear() {
             $('#searchInput').val('');
             $('.weui-cell').removeClass("hide");
             //$('.weui-cell').siblings('.weui-cells__title').removeClass("hide");
             showBlockCount();
         }
    </script>
    <script>
        function deal(stepid, formno) {
            //alert(stepid);
            if (stepid == "0001") {
                window.location.href = "/Adjust_Apply.aspx?stepid=" + stepid + "&formno=" + formno;
            } else {
                window.location.href = "/Adjust_sign.aspx?stepid=" + stepid + "&formno=" + formno;
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
                            盘盈亏监视
                        </div>
                        <div href="#tab2" class="weui-navbar__item">
                            我的盘盈亏
                        </div>
                    </div>

                    <div class="weui-tab__panel" style="background-color:lightgray">
                        <%--=======盘盈亏监视-----%>
                        <div id="tab1" class="weui-tab__content">

                            <div class="weui-form-preview">
                                <div class="weui-cells__title  ">
                                    <i class="icon nav-icon icon-49"></i>退回申请
                                    <span class="weui-badge  bg-<% =(count_01==0?"gray":"blue") %>"><% =count_01 %></span>
                                </div>
                                <div class="weui-cells" id="_01">
                                    <asp:Repeater runat="server" ID="list_01" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("formno") %>')>
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                        <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                        <%# "单号"+Eval("formno") %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("pgino") + "," + Eval("pn")   %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("lot_no")+ "," + Eval("adj_qty")+"件"   %>
                                                        <span class="weui-mark-rt- weui-badge weui-badge-tr" 
                                                            style="font-size: x-small; color: <%# Eval("adj_result").ToString()=="盘亏"?"red":"#07c160"%>; ">
                                                            <%#Eval("adj_result") %>
                                                        </span>
                                                    </span>
                                                    <span class="weui-agree__text" style="font-size: smaller">
                                                        <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
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

                            <div class="weui-form-preview">
                                <div class="weui-cells__title  ">
                                    <i class="icon nav-icon icon-49"></i>待审核
                                    <span class="weui-badge  bg-<% =(count_02==0?"gray":"blue") %>"><% =count_02 %></span>
                                </div>
                                <div class="weui-cells" id="_02">
                                    <asp:Repeater runat="server" ID="list_02" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("formno") %>')>
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                        <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                        <%# "单号"+Eval("formno") %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("pgino") + "," + Eval("pn")   %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("lot_no")+ "," + Eval("adj_qty")+"件"   %>
                                                        <span class="weui-mark-rt- weui-badge weui-badge-tr" 
                                                            style="font-size: x-small; color: <%# Eval("adj_result").ToString()=="盘亏"?"red":"#07c160"%>; ">
                                                            <%#Eval("adj_result") %>
                                                        </span>
                                                    </span>
                                                    <span class="weui-agree__text" style="font-size: smaller">
                                                        <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
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

                            <div class="weui-form-preview">
                                <div class="weui-cells__title  ">
                                    <i class="icon nav-icon icon-49"></i>待批准
                                    <span class="weui-badge  bg-<% =(count_03==0?"gray":"blue") %>"><% =count_03 %></span>
                                </div>
                                <div class="weui-cells" id="_03">
                                    <asp:Repeater runat="server" ID="list_03" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("formno") %>')>
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                        <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                        <%# "单号"+Eval("formno") %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("pgino") + "," + Eval("pn")   %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("lot_no")+ "," + Eval("adj_qty")+"件"   %>
                                                        <span class="weui-mark-rt- weui-badge weui-badge-tr" 
                                                            style="font-size: x-small; color: <%# Eval("adj_result").ToString()=="盘亏"?"red":"#07c160"%>; ">
                                                            <%#Eval("adj_result") %>
                                                        </span>
                                                    </span>
                                                    <span class="weui-agree__text" style="font-size: smaller">
                                                        <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
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
                            
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  ">
                                    <i class="icon nav-icon icon-49"></i>已完成(1周内)
                                    <span class="weui-badge  bg-<% =(count_99==0?"gray":"blue") %>"><% =count_99 %></span>
                                </div>
                                <div class="weui-cells" id="_99">
                                    <asp:Repeater runat="server" ID="list_99" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("formno") %>')>
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-green"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                        <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                        <%# "单号"+Eval("formno") %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("pgino") + "," + Eval("pn")   %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("lot_no")+ "," + Eval("adj_qty")+"件"   %>
                                                        <span class="weui-mark-rt- weui-badge weui-badge-tr" 
                                                            style="font-size: x-small; color: <%# Eval("adj_result").ToString()=="盘亏"?"red":"#07c160"%>; ">
                                                            <%#Eval("adj_result") %>
                                                        </span>
                                                    </span>
                                                    <span class="weui-agree__text" style="font-size: smaller">
                                                        <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
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

                        </div>
                        <%--=======我的盘盈亏-----%>
                        <div id="tab2" class="weui-tab__content">

                            <div class="weui-form-preview">
                                <div class="weui-cells__title  ">
                                    <i class="icon nav-icon icon-49"></i>退回申请
                                    <span class="weui-badge  bg-<% =(count_01_my==0?"gray":"blue") %>"><% =count_01_my %></span>
                                </div>
                                <div class="weui-cells" id="_01_my">
                                    <asp:Repeater runat="server" ID="list_01_my" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("formno") %>')>
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                        <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                        <%# "单号"+Eval("formno") %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("pgino") + "," + Eval("pn")   %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("lot_no")+ "," + Eval("adj_qty")+"件"   %>
                                                        <span class="weui-mark-rt- weui-badge weui-badge-tr" 
                                                            style="font-size: x-small; color: <%# Eval("adj_result").ToString()=="盘亏"?"red":"#07c160"%>; ">
                                                            <%#Eval("adj_result") %>
                                                        </span>
                                                    </span>
                                                    <span class="weui-agree__text" style="font-size: smaller">
                                                        <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
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

                            <div class="weui-form-preview">
                                <div class="weui-cells__title  ">
                                    <i class="icon nav-icon icon-49"></i>待审核
                                    <span class="weui-badge  bg-<% =(count_02_my==0?"gray":"blue") %>"><% =count_02_my %></span>
                                </div>
                                <div class="weui-cells" id="_02_my">
                                    <asp:Repeater runat="server" ID="list_02_my" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("formno") %>')>
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                        <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                        <%# "单号"+Eval("formno") %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("pgino") + "," + Eval("pn")   %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("lot_no")+ "," + Eval("adj_qty")+"件"   %>
                                                        <span class="weui-mark-rt- weui-badge weui-badge-tr" 
                                                            style="font-size: x-small; color: <%# Eval("adj_result").ToString()=="盘亏"?"red":"#07c160"%>; ">
                                                            <%#Eval("adj_result") %>
                                                        </span>
                                                    </span>
                                                    <span class="weui-agree__text" style="font-size: smaller">
                                                        <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
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

                            <div class="weui-form-preview">
                                <div class="weui-cells__title  ">
                                    <i class="icon nav-icon icon-49"></i>待批准
                                    <span class="weui-badge  bg-<% =(count_03_my==0?"gray":"blue") %>"><% =count_03_my %></span>
                                </div>
                                <div class="weui-cells" id="_03_my">
                                    <asp:Repeater runat="server" ID="list_03_my" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("formno") %>')>
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                        <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                        <%# "单号"+Eval("formno") %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("pgino") + "," + Eval("pn")   %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("lot_no")+ "," + Eval("adj_qty")+"件"   %>
                                                        <span class="weui-mark-rt- weui-badge weui-badge-tr" 
                                                            style="font-size: x-small; color: <%# Eval("adj_result").ToString()=="盘亏"?"red":"#07c160"%>; ">
                                                            <%#Eval("adj_result") %>
                                                        </span>
                                                    </span>
                                                    <span class="weui-agree__text" style="font-size: smaller">
                                                        <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
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
                            
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  ">
                                    <i class="icon nav-icon icon-49"></i>已完成(1周内)
                                    <span class="weui-badge  bg-<% =(count_99_my==0?"gray":"blue") %>"><% =count_99_my %></span>
                                </div>
                                <div class="weui-cells" id="_99_my">
                                    <asp:Repeater runat="server" ID="list_99_my" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("formno") %>')>
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-green"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                        <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                        <%# "单号"+Eval("formno") %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("pgino") + "," + Eval("pn")   %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("lot_no")+ "," + Eval("adj_qty")+"件"   %>
                                                        <span class="weui-mark-rt- weui-badge weui-badge-tr" 
                                                            style="font-size: x-small; color: <%# Eval("adj_result").ToString()=="盘亏"?"red":"#07c160"%>; ">
                                                            <%#Eval("adj_result") %>
                                                        </span>
                                                    </span>
                                                    <span class="weui-agree__text" style="font-size: smaller">
                                                        <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
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
