﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="YL_list_new.aspx.cs" Inherits="WorkOrder_YL_list_new" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>生产要料监视</title>
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
    </style>
    <script src="../js/zepto.min.js"></script>
    <script src="../js/zepto.weui.js"></script>
    <script src="../js/iscroll-lite.js"></script>
    <script>
        $(function () {

            $('#t1,#t2').tab({
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

            pj_hide();

           $('#searchInput').bind('input propertychange', function () {
               //$(".js-category").css("display", "none");

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
                        $self.removeClass("hide"); $parent.children('.js-category').css("display", "none"); //$self.siblings('.weui-cells__title').addClass("hide");
                    } else {
                        $self.addClass("hide"); $parent.children('.js-category').css("display", "none"); //$self.siblings('.weui-cells__title').addClass("hide");

                    }
                });

                showBlockCount();
            });

        });

        function pj_hide() {
            $("ul li").find("#line_s").each(function () {
                if ("配件" != $(this).text()) {
                    $(this).parent().parent().parent().siblings().removeClass('js-show');
                    $(this).parent().parent().parent().addClass('js-show');
                    $(this).parent().parent().children('i').removeClass('icon-74').addClass('icon-35');
                    $(this).parent().parent().siblings().find('i').removeClass('icon-35').addClass('icon-74');
                } else {
                    $(this).parent().parent().parent().removeClass('js-show');
                    $(this).parent().parent().parent().children('i').removeClass('icon-35').addClass('icon-74');
                }
            });
        }

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
            $(".js-category").css("display", "");

            $('.weui-cell').removeClass("hide");
            $('.weui-cell').siblings('.weui-cells__title').removeClass("hide");
            showBlockCount();
            pj_hide();
        }

        function clear() {
            $(".js-category").css("display", "");

            $('#searchInput').val('');
            $('.weui-cell').removeClass("hide");
            $('.weui-cell').siblings('.weui-cells__title').removeClass("hide");
            showBlockCount();
            pj_hide();
        }
    </script>
     <script>
         function deal_rej(lot_no, need_no, reject_where) {
             if (reject_where == "线边库") {
                window.location.href = "Load_Material.aspx?lotno=" + lot_no + "&need_no=" + need_no + "&workshop=<%=_workshop %>&para=T"
             }
             if (reject_where == "仓库") {
                 window.location.href = "Sure_Material.aspx?lotno=" + lot_no + "&need_no=" + need_no + "&workshop=<%=_workshop %>"
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
                            要料监视
                        </div>
                        <div href="#tab2" class="weui-navbar__item">
                            我的要料
                        </div>
                    </div>

                    <div class="weui-tab__panel" style="background-color:lightgray">
                        <%--=======所有工单-----%>
                        <div id="tab1" class="weui-tab__content">
                            <%-----要料中----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i> 要料中<%--<asp:Label ID="Label1" runat="server" Text=""></asp:Label>--%> 
                                    <span class="weui-badge  bg-<% =(count1==0?"gray":"blue") %>"><% =count1 %></span>
                                </div>
                                <div class="weui-cells" id="YLZ">
                                    <asp:Repeater runat="server" ID="list_go" EnableTheming="False" OnItemDataBound="list_go_ItemDataBound">
                                        <ItemTemplate>
                                             <ul class="collapse">
                                                <li style="margin-top:0px;margin-bottom:0px">
                                                    <div class="weui-flex js-category">
                                                        <div class="weui-cells__title  weui-flex__item">
                                                            <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("line") %></span>
                                                            <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                        </div>
                                                        <i class="icon icon-74"></i>
                                                    </div>
                                                    <div class="page-category js-categoryInner">
                                                        <div class="weui-cells"> <%--id="_99_my"--%>
                                                            <asp:Repeater runat="server" ID="list_go_dt" EnableTheming="False">
                                                                <ItemTemplate>
                                                                    <a class="weui-cell weui-cell_access" 
                                                                        href="SL.aspx?need_no=<%#Eval("need_no") %>&workshop=<%=_workshop %>">
                                                                        <div class="weui-mark-vip"><span class="weui-mark-lt bg-green"></span></div>
                                                                        <%--<div class="weui-cell__hd">
                                                                            <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                        </div>--%>
                                                                        <div class="weui-cell__bd">
                                                                            <span class="weui-form-preview__value" style="font-size: smaller">
                                                                                <%# Eval("workshop") + "/" + Eval("line") + "/" +Eval("location")  %>
                                                                            </span>
                                                    
                                                                            <span class="weui-form-preview__value" style="font-size: smaller">
                                                                                <%#   Eval("pgino")+","+Eval("pn")+","+Eval("need_qty") +"件" %>

                                                                                <span class="weui-mark-rt- weui-badge" 
                                                                                style="background-color: <%# Eval("type").ToString()=="部分"?"red":"#10AEFF"%>;
                                                                                     font-size: x-small; color: white; 
                                                                                     display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                                                    <%#Eval("type") %>
                                                                                </span>
                                                                            </span>
                                                    

                                                                            <span class="weui-agree__text" style="font-size: smaller">
                                                                                <%# Eval("phone")+" "+Eval("emp_name")+" "+Eval("need_date","{0:MM-dd HH:mm}")
                                                                                        /*+" <font class='f-blue'>"+Eval("need_date")+ "</font>" */
                                                                                 %>  
                                                                                 <span style="color:<%# Eval("times_type").ToString()=="还差"?"#10AEFF":(Eval("times_type").ToString()=="超时"?"red":"#999999") %>;">
                                                                                     <%# Eval("times_type") %><%# Eval("times") %>
                                                                                 </span>
                                                                               <%-- <span style="color:<%# Eval("sj_c").ToString()=="1"?"#10AEFF":(Eval("sj_c").ToString()=="2"?"red":"#999999") %>;"><%#Eval("need_date") %></span>--%>
                                                                            </span>

                                                                        </div>
                                                                        <div class="weui-cell__ft">
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

                            <%-----已送料----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i> 已送料<%--<asp:Label ID="Label2" runat="server" Text=""></asp:Label>--%> 
                                    <span class="weui-badge  bg-<% =(count2==0?"gray":"blue") %>"><% =count2 %></span>
                                </div>
                                <div class="weui-cells" id="YL_WC">
                                    <asp:Repeater runat="server" ID="list_wc" EnableTheming="False" OnItemDataBound="list_wc_ItemDataBound">
                                        <ItemTemplate>
                                            <ul class="collapse">
                                                <li style="margin-top:0px;margin-bottom:0px">
                                                    <div class="weui-flex js-category">
                                                        <div class="weui-cells__title  weui-flex__item">
                                                            <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("line") %></span>
                                                            <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                        </div>
                                                        <i class="icon icon-74"></i>
                                                    </div>
                                                    <div class="page-category js-categoryInner">
                                                        <div class="weui-cells">
                                                            <asp:Repeater runat="server" ID="list_wc_dt" EnableTheming="False">
                                                                <ItemTemplate>
                                                                    <a class="weui-cell weui-cell_access" 
                                                                        href="Load_Material.aspx?lotno=<%#Eval("lot_no") %>&need_no=<%#Eval("need_no") %>&workshop=<%=_workshop %>&para=S">
                                                                        <div class="weui-mark-vip"><span class="weui-mark-lt bg-blue"></span></div>
                                                                        <%--<div class="weui-cell__hd">
                                                                            <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                        </div>--%>
                                                                        <div class="weui-cell__bd"> <%-- f-gray--%>
                                                                            <span class="weui-form-preview__value" style="font-size: smaller">
                                                                                <%--<%# Eval("workshop") + "/" + Eval("line") + "/" +Eval("location")  %>--%>
                                                                                <%# Eval("location") %>
                                                                                <span class="f-blue" style="font-weight:800">
                                                                                     <%# Eval("lot_no") %>
                                                                                 </span>
                                                                            </span>
                                                    
                                                                            <span class="weui-form-preview__value" style="font-size: smaller">
                                                                                <%#   Eval("pgino")+","+Eval("pn")+","+Eval("act_qty") +"件" %>

                                                                                <span class="weui-mark-rt- weui-badge" 
                                                                                style="background-color: <%# Eval("type").ToString()=="部分"?"red":"#10AEFF"%>;
                                                                                     font-size: x-small; color: white; 
                                                                                     display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                                                    <%#Eval("type") %>
                                                                                </span>
                                                                            </span>
                                                    

                                                                            <span class="weui-agree__text" style="font-size: smaller">
                                                                                <%# Eval("phone")+" "+Eval("emp_name")
                                                                                       +" "+Eval("need_date","{0:MM-dd HH:mm}")+ " " 
                                                                                 %>   
                                                                                <span style="color:<%# Eval("times_type").ToString()=="Y"?"red":"#10AEFF" %>;">
                                                                                     时长:<%# Eval("times") %>
                                                                                 </span>
                                                                            </span>

                                                                        </div>
                                                                        <div class="weui-cell__ft">
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

                            <%-----已退料----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i> 已退料<%--<asp:Label ID="Label3" runat="server" Text=""></asp:Label> --%>
                                    <span class="weui-badge  bg-<% =(count3==0?"gray":"blue") %>"><% =count3 %></span>
                                </div>
                                <div class="weui-cells" id="YL_RJ">
                                    <asp:Repeater runat="server" ID="list_rj" EnableTheming="False" OnItemDataBound="list_rj_ItemDataBound">
                                        <ItemTemplate>
                                            <ul class="collapse">
                                                <li style="margin-top:0px;margin-bottom:0px">
                                                    <div class="weui-flex js-category">
                                                        <div class="weui-cells__title  weui-flex__item">
                                                            <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("line") %></span>
                                                            <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                        </div>
                                                        <i class="icon icon-74"></i>
                                                    </div>
                                                    <div class="page-category js-categoryInner">
                                                        <div class="weui-cells">
                                                            <asp:Repeater runat="server" ID="list_rj_dt" EnableTheming="False">
                                                                <ItemTemplate>
                                                                    <%--<a class="weui-cell weui-cell_access" 
                                                                        href="Load_Material.aspx?lotno=<%#Eval("lot_no") %>&need_no=<%#Eval("need_no") %>&workshop=<%=_workshop %>&para=T">--%>
                                                                    <a class="weui-cell weui-cell_access"  onclick=deal_rej('<%# Eval("lot_no") %>','<%# Eval("need_no") %>','<%# Eval("reject_where") %>') >
                                                                        <div class="weui-mark-vip"><span class="weui-mark-lt bg-danger"></span></div>
                                                                        <%--<div class="weui-cell__hd">
                                                                            <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                        </div>--%>
                                                                        <div class="weui-cell__bd"> <%-- f-gray--%>
                                                                            <span class="weui-form-preview__value" style="font-size: smaller">
                                                                                <%# Eval("workshop") + "/" + Eval("line") + "/" +Eval("location")  %>
                                                                            </span>
                                                    
                                                                            <span class="weui-form-preview__value" style="font-size: smaller">
                                                                                <%#   Eval("pgino")+","+Eval("pn") %>
                                                                                <span class="weui-mark-rt- weui-badge  weui-badge-tr" 
                                                                                    style="
                                                                                        font-size: x-small; color: <%# Eval("reject_where").ToString()=="仓库"?"#07c160":"#10AEFF"%>; 
                                                                                        display:<%# Eval("reject_where").ToString()=="仓库"?"inline-block":"none"%>; ">
                                                                                    <%# "退"+Eval("reject_where") %>
                                                                                </span>
                                                                                <br />
                                                                                <span class="padding5-r"><%# "Lot:"+Eval("lot_no").ToString()%></span>
                                                                                已送:<font class="f-blue padding5-r"><%# Eval("feed_qty")%></font>
                                                                                下料:<font class="f-blue padding5-r"><%# Eval("off_qty")%></font>
                                                                                NG:<font class="f-blue padding5-r"><%# Eval("ng_qty")%></font>
                                                                                已退:<font class="f-blue "><%# Eval("reject_qty")%></font>
                                                                            </span>

                                                                            <span class="weui-agree__text" style="font-size: smaller">
                                                                                <%# Eval("phone")+" "+Eval("emp_name")+" "+Eval("reject_date","{0:MM-dd HH:mm}")+ " " 
                                                                                 %>     
                                                                                <span style="color:#10AEFF">
                                                                                     时长:<%# Eval("times") %>
                                                                                 </span>
                                                                            </span>

                                                                        </div>
                                                                        <div class="weui-cell__ft">
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

                            <%-----要料完成----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i> 要料完成(24h内)<%--<asp:Label ID="Label4" runat="server" Text=""></asp:Label> --%>
                                    <span class="weui-badge  bg-<% =(count4==0?"gray":"blue") %>"><% =count4 %></span>
                                </div>
                                <div class="weui-cells" id="YL_END">
                                    <asp:Repeater runat="server" ID="list_end" EnableTheming="False" OnItemDataBound="list_end_ItemDataBound">
                                        <ItemTemplate>
                                            <ul class="collapse">
                                                <li style="margin-top:0px;margin-bottom:0px">
                                                    <div class="weui-flex js-category">
                                                        <div class="weui-cells__title  weui-flex__item">
                                                            <i class="icon nav-icon icon-22 color-success"></i><span id="line_s1"><%# Eval("line") %></span>
                                                            <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                        </div>
                                                        <i class="icon icon-74"></i>
                                                    </div>
                                                    <div class="page-category js-categoryInner">
                                                        <div class="weui-cells">
                                                            <asp:Repeater runat="server" ID="list_end_dt" EnableTheming="False">
                                                                <ItemTemplate>
                                                                    <%--<a class="weui-cell weui-cell_access" 
                                                                        href="prod_wip_detail.aspx?need_no=<%# Eval("need_no")%>&ngqty=<%# Eval("ng_qty")%>&wipqty=<%# Eval("wip_qty")%>&type=lot&dh=<%#Eval("lot_no") %>&workshop=<%=_workshop %>&para=N">--%>
                                                                    <a class="weui-cell weui-cell_access" 
                                                                        href="YL_Detail_Info.aspx?need_no=<%# Eval("need_no")%>">
                                                                        <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                                                        <%--<div class="weui-cell__hd">
                                                                            <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                        </div>--%>
                                                                        <div class="weui-cell__bd"> <%-- f-gray--%>
                                                                            <span class="weui-form-preview__value" style="font-size: smaller">
                                                                                <%# Eval("workshop") + "/" + Eval("line") + "/" +Eval("location")  %>
                                                                            </span>
                                                    
                                                                            <span class="weui-form-preview__value" style="font-size: smaller">
                                                                                <%#   Eval("pgino")+","+Eval("pn")+","+Eval("act_qty") +"件" %>
                                                                            </span>
                                                    

                                                                            <span class="weui-agree__text" style="font-size: smaller">
                                                                                <%# Eval("phone")+" "+Eval("emp_name")
                                                                                       +" "+Eval("b_on_m_date","{0:MM-dd HH:mm}")+ " " 
                                                                                 %>   
                                                                            </span>

                                                                        </div>
                                                                        <div class="weui-cell__ft">
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

                        </div>
                        <%--=======我的工单-----%>
                        <div id="tab2" class="weui-tab__content">
                            <%-----要料中----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i> 要料中 <%--<asp:Label ID="Label5" runat="server" Text=""></asp:Label>--%>
                                    <span class="weui-badge  bg-<% =(count5==0?"gray":"blue") %>"><% =count5 %></span>
                                </div>
                                <div class="weui-cells" id="YLZ_my">
                                    <asp:Repeater runat="server" ID="list_go_my" EnableTheming="False" OnItemDataBound="list_go_my_ItemDataBound">
                                        <ItemTemplate>  
                                            <ul class="collapse">
                                                <li style="margin-top:0px;margin-bottom:0px">
                                                    <div class="weui-flex js-category">
                                                        <div class="weui-cells__title  weui-flex__item">
                                                            <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("line") %></span>
                                                            <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                        </div>
                                                        <i class="icon icon-74"></i>
                                                    </div>
                                                    <div class="page-category js-categoryInner">
                                                        <div class="weui-cells">                                    
                                                            <asp:Repeater runat="server" ID="list_go_my_dt" EnableTheming="False">
                                                                <ItemTemplate>
                                                                    <a class="weui-cell weui-cell_access" 
                                                                        href="SL.aspx?need_no=<%#Eval("need_no") %>&workshop=<%=_workshop %>">
                                                                        <div class="weui-mark-vip"><span class="weui-mark-lt bg-green"></span></div>
                                                                        <%--<div class="weui-cell__hd">
                                                                            <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                        </div>--%>
                                                                        <div class="weui-cell__bd">
                                                                            <span  class="weui-form-preview__value" style="font-size: smaller">
                                                                                <%# Eval("workshop") + "/" + Eval("line") + "/" +Eval("location")  %>
                                                                            </span>
                                                    
                                                                            <span  class="weui-form-preview__value" style="font-size: smaller">
                                                                                <%#   Eval("pgino")+","+Eval("pn")+","+Eval("need_qty") +"件" %>

                                                                                <span class="weui-mark-rt- weui-badge" 
                                                                                style="background-color: <%# Eval("type").ToString()=="部分"?"red":"#10AEFF"%>;
                                                                                     font-size: x-small; color: white; 
                                                                                     display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                                                    <%#Eval("type") %>
                                                                                </span>
                                                                            </span>
                                                    

                                                                            <span class="weui-agree__text" style="font-size: smaller">
                                                                                <%# Eval("phone")+" "+Eval("emp_name")+" "+Eval("need_date","{0:MM-dd HH:mm}")
                                                                                        /*+" <font class='f-blue'>"+Eval("need_date")+ "</font>" */
                                                                                 %>   
                                                                                <span style="color:<%# Eval("times_type").ToString()=="还差"?"#10AEFF":(Eval("times_type").ToString()=="超时"?"red":"#999999") %>;">
                                                                                     <%# Eval("times_type") %><%# Eval("times") %>
                                                                                 </span>
                                                                                <%--<span style="color:<%# Eval("sj_c").ToString()=="1"?"#10AEFF":(Eval("sj_c").ToString()=="2"?"red":"#999999") %>;"><%#Eval("need_date") %></span>--%>
                                                                            </span>

                                                                        </div>
                                                                        <div class="weui-cell__ft">
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

                            <%-----已送料----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i> 已送料<%--<asp:Label ID="Label6" runat="server" Text=""></asp:Label>--%> 
                                    <span class="weui-badge  bg-<% =(count6==0?"gray":"blue") %>"><% =count6 %></span>
                                </div>
                                <div class="weui-cells" id="YL_WC_my">
                                    <asp:Repeater runat="server" ID="list_wc_my" EnableTheming="False" OnItemDataBound="list_wc_my_ItemDataBound">
                                        <ItemTemplate>
                                            <ul class="collapse">
                                                <li style="margin-top:0px;margin-bottom:0px">
                                                    <div class="weui-flex js-category">
                                                        <div class="weui-cells__title  weui-flex__item">
                                                            <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("line") %></span>
                                                            <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                        </div>
                                                        <i class="icon icon-74"></i>
                                                    </div>
                                                    <div class="page-category js-categoryInner">
                                                        <div class="weui-cells">                                        
                                                            <asp:Repeater runat="server" ID="list_wc_my_dt" EnableTheming="False">
                                                                <ItemTemplate>
                                                                    <a class="weui-cell weui-cell_access" 
                                                                        href="Load_Material.aspx?lotno=<%#Eval("lot_no") %>&need_no=<%#Eval("need_no") %>&workshop=<%=_workshop %>&para=S">
                                                                        <div class="weui-mark-vip"><span class="weui-mark-lt bg-blue"></span></div>
                                                                        <%--<div class="weui-cell__hd">
                                                                            <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                        </div>--%>
                                                                        <div class="weui-cell__bd"> <%-- f-gray--%>
                                                                            <span  class="weui-form-preview__value" style="font-size: smaller">
                                                                                <%# Eval("workshop") + "/" + Eval("line") + "/" +Eval("location")  %>
                                                                            </span>
                                                    
                                                                            <span  class="weui-form-preview__value" style="font-size: smaller">
                                                                                <%#   Eval("pgino")+","+Eval("pn")+","+Eval("act_qty") +"件" %>

                                                                                <span class="weui-mark-rt- weui-badge" 
                                                                                style="background-color: <%# Eval("type").ToString()=="部分"?"red":"#10AEFF"%>;
                                                                                     font-size: x-small; color: white; 
                                                                                     display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                                                    <%#Eval("type") %>
                                                                                </span>
                                                                            </span>
                                                    

                                                                            <span class="weui-agree__text" style="font-size: smaller">
                                                                                <%# Eval("phone")+" "+Eval("emp_name")
                                                                                        +" "+Eval("need_date","{0:MM-dd HH:mm}")+ " " 
                                                                                 %>     
                                                                                <span  style="color:<%# Eval("times_type").ToString()=="Y"?"red":"#10AEFF" %>;">
                                                                                     时长:<%# Eval("times") %>
                                                                                 </span>
                                                                            </span>

                                                                        </div>
                                                                        <div class="weui-cell__ft">
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

                            <%-----已退料----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i> 已退料<%--<asp:Label ID="Label7" runat="server" Text=""></asp:Label>--%> 
                                    <span class="weui-badge  bg-<% =(count7==0?"gray":"blue") %>"><% =count7 %></span>
                                </div>
                                <div class="weui-cells" id="YL_RJ_my">
                                    <asp:Repeater runat="server" ID="list_rj_my" EnableTheming="False" OnItemDataBound="list_rj_my_ItemDataBound">
                                        <ItemTemplate>
                                            <ul class="collapse">
                                                <li style="margin-top:0px;margin-bottom:0px">
                                                    <div class="weui-flex js-category">
                                                        <div class="weui-cells__title  weui-flex__item">
                                                            <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("line") %></span>
                                                            <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                        </div>
                                                        <i class="icon icon-74"></i>
                                                    </div>
                                                    <div class="page-category js-categoryInner">
                                                        <div class="weui-cells">                                        
                                                            <asp:Repeater runat="server" ID="list_rj_my_dt" EnableTheming="False">
                                                                <ItemTemplate>
                                                                    <%--<a class="weui-cell weui-cell_access" 
                                                                        href="Load_Material.aspx?lotno=<%#Eval("lot_no") %>&need_no=<%#Eval("need_no") %>&workshop=<%=_workshop %>&para=T">--%>
                                                                    <a class="weui-cell weui-cell_access"  onclick=deal_rej('<%# Eval("lot_no") %>','<%# Eval("need_no") %>','<%# Eval("reject_where") %>') >
                                                                        <div class="weui-mark-vip"><span class="weui-mark-lt bg-danger"></span></div>
                                                                        <%--<div class="weui-cell__hd">
                                                                            <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                        </div>--%>
                                                                        <div class="weui-cell__bd"> <%-- f-gray--%>
                                                                            <span  class="weui-form-preview__value" style="font-size: smaller">
                                                                                <%# Eval("workshop") + "/" + Eval("line") + "/" +Eval("location")  %>
                                                                            </span>
                                                    
                                                                           <span class="weui-form-preview__value" style="font-size: smaller">
                                                                                <%#   Eval("pgino")+","+Eval("pn") %>
                                                                                <span class="weui-mark-rt- weui-badge  weui-badge-tr" 
                                                                                    style="
                                                                                        font-size: x-small; color: <%# Eval("reject_where").ToString()=="仓库"?"#07c160":"#10AEFF"%>; 
                                                                                        display:<%# Eval("reject_where").ToString()=="仓库"?"inline-block":"none"%>; ">
                                                                                    <%# "退"+Eval("reject_where") %>
                                                                                </span>
                                                                                <br />
                                                                                <span class="padding5-r"><%# "Lot:"+Eval("lot_no").ToString()%></span>
                                                                                已送:<font class="f-blue padding5-r"><%# Eval("feed_qty")%></font>
                                                                                下料:<font class="f-blue padding5-r"><%# Eval("off_qty")%></font>
                                                                                NG:<font class="f-blue padding5-r"><%# Eval("ng_qty")%></font>
                                                                                已退:<font class="f-blue "><%# Eval("reject_qty")%></font>
                                                                            </span>

                                                                            <span class="weui-agree__text" style="font-size: smaller">
                                                                                <%# Eval("phone")+" "+Eval("emp_name")+" "+Eval("reject_date","{0:MM-dd HH:mm}")+ " " 
                                                                                 %>     
                                                                                <span style="color:#10AEFF">
                                                                                     时长:<%# Eval("times") %>
                                                                                 </span>
                                                                            </span>

                                                                        </div>
                                                                        <div class="weui-cell__ft">
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

                            <%-----要料完成----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i> 要料完成(24h内)<%--<asp:Label ID="Label8" runat="server" Text=""></asp:Label>--%> 
                                    <span class="weui-badge  bg-<% =(count8==0?"gray":"blue") %>"><% =count8 %></span>
                                </div>
                                <div class="weui-cells" id="YL_END_my">
                                    <asp:Repeater runat="server" ID="list_end_my" EnableTheming="False" OnItemDataBound="list_end_my_ItemDataBound">
                                        <ItemTemplate>
                                            <ul class="collapse">
                                                <li style="margin-top:0px;margin-bottom:0px">
                                                    <div class="weui-flex js-category">
                                                        <div class="weui-cells__title  weui-flex__item">
                                                            <i class="icon nav-icon icon-22 color-success"></i><span id="line_s1"><%# Eval("line") %></span>
                                                            <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                        </div>
                                                        <i class="icon icon-74"></i>
                                                    </div>
                                                    <div class="page-category js-categoryInner">
                                                        <div class="weui-cells">                                        
                                                            <asp:Repeater runat="server" ID="list_end_my_dt" EnableTheming="False">
                                                                <ItemTemplate>
                                                                    <%--<a class="weui-cell weui-cell_access" 
                                                                         href="prod_wip_detail.aspx?need_no=<%# Eval("need_no")%>&ngqty=<%# Eval("ng_qty")%>&wipqty=<%# Eval("wip_qty")%>&type=lot&dh=<%#Eval("lot_no") %>&workshop=<%=_workshop %>&para=N">--%>
                                                                    <a class="weui-cell weui-cell_access" 
                                                                        href="YL_Detail_Info.aspx?need_no=<%# Eval("need_no")%>">
                                                                        <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                                                        <%--<div class="weui-cell__hd">
                                                                            <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                        </div>--%>
                                                                        <div class="weui-cell__bd"> <%-- f-gray--%>
                                                                            <span class="weui-form-preview__value" style="font-size: smaller">
                                                                                <%# Eval("workshop") + "/" + Eval("line") + "/" +Eval("location")  %>
                                                                            </span>
                                                    
                                                                            <span class="weui-form-preview__value" style="font-size: smaller">
                                                                                <%#   Eval("pgino")+","+Eval("pn")+","+Eval("act_qty") +"件" %>
                                                                            </span>
                                                    

                                                                            <span class="weui-agree__text" style="font-size: smaller">
                                                                                <%# Eval("phone")+" "+Eval("emp_name")
                                                                                       +" "+Eval("b_on_m_date","{0:MM-dd HH:mm}")+ " " 
                                                                                 %>   
                                                                            </span>

                                                                        </div>
                                                                        <div class="weui-cell__ft">
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
