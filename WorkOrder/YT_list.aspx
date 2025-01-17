﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="YT_list.aspx.cs" Inherits="WorkOrder_YL_list_new" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>要汤监视</title>
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

            $('#searchInput').bind('input propertychange', function () {

                var text = $("#searchInput").val();
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
            $('.weui-cell').siblings('.weui-cells__title').removeClass("hide");
            showBlockCount();
        }

        function clear() {
            $('#searchInput').val('');
            $('.weui-cell').removeClass("hide");
            $('.weui-cell').siblings('.weui-cells__title').removeClass("hide");
            showBlockCount();
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
                            要汤监视
                        </div>
                        <div href="#tab2" class="weui-navbar__item">
                            我的要汤
                        </div>
                    </div>

                    <div class="weui-tab__panel" style="background-color:lightgray">
                        <%--=======所有工单-----%>
                        <div id="tab1" class="weui-tab__content">
                            <%-----要汤预警----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i> 要汤预警
                                    <span class="weui-badge  bg-<% =(count0==0?"gray":"blue") %>"><% =count0 %></span>
                                </div>
                                <div class="weui-cells" id="YLYJ">
                                    <asp:Repeater runat="server" ID="list_pre" EnableTheming="False" OnItemDataBound="list_pre_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="weui-cells__title ">
                                                <i class="icon nav-icon icon-22 color-success"></i><%# Eval("cl") %>
                                            </div>                                        
                                            <asp:Repeater runat="server" ID="list_pre_dt" EnableTheming="False">
                                            <ItemTemplate>
                                                <a class="weui-cell weui-cell_access">
                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-yellow"></span></div>
                                                    <div class="weui-cell__hd">
                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                    </div>
                                                    <div class="weui-cell__bd">
                                                        <span class="weui-form-preview__value" style="font-size: smaller">
                                                            <%# "<font color=#10AEFF>"+Eval("yzj_no")+"</font>"+Eval("yzj_name")
                                                                    +","+Eval("cl")+","+Eval("bwl_weight_toal")+"kg" %>
                                                        </span>
                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                            <%# Eval("phone")+" "+Eval("emp_name")+" "+Eval("act_date","{0:MM-dd HH:mm}")%>  
                                                             <span style="color:#10AEFF;">
                                                                 <%# Eval("times_type") %><%# Eval("times") %>
                                                             </span>
                                                        </span>
                                                        <br />
                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                            <%# Eval("pgino")+","+Eval("pn")+",<font color=#10AEFF>已用"+Eval("qty_xiaohao")+"kg</font>"
                                                                    +","+ (Convert.ToSingle(Eval("rate").ToString())*100).ToString()+"%" %>  
                                                        </span>
                                                    </div>
                                                    <%--<div class="weui-cell__ft">
                                                    </div>--%>
                                                </a>
                                            </ItemTemplate>
                                            </asp:Repeater>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>

                            <%-----要料中----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i> 要汤中
                                    <span class="weui-badge  bg-<% =(count1==0?"gray":"blue") %>"><% =count1 %></span>
                                </div>
                                <div class="weui-cells" id="YLZ">
                                    <asp:Repeater runat="server" ID="list_go" EnableTheming="False" OnItemDataBound="list_go_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="weui-cells__title ">
                                                <i class="icon nav-icon icon-22 color-success"></i><%# Eval("cl") %>
                                            </div>                                        
                                            <asp:Repeater runat="server" ID="list_go_dt" EnableTheming="False">
                                            <ItemTemplate>
                                                <a class="weui-cell weui-cell_access" href="ST.aspx?need_t_no=<%#Eval("need_t_no") %>&workshop=<%=_workshop %>">
                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-green"></span></div>
                                                    <div class="weui-cell__hd">
                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                    </div>
                                                    <div class="weui-cell__bd">
                                                        <%--<span class="weui-form-preview__value" style="font-size: smaller">
                                                            <%# Eval("workshop") + "/" + Eval("line") + "/" +Eval("location")  %>
                                                        </span>--%>
                                                    
                                                        <span class="weui-form-preview__value" style="font-size: smaller">
                                                            <%# "<font color=#10AEFF>"+Eval("yzj_no")+"</font>"+Eval("yzj_name")+","+Eval("pgino")
                                                                    +","+Eval("cl")+",<font color=#10AEFF>"+Eval("need_qty")+"kg</font>" %>
                                                            <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("type").ToString()=="部分"?"red":"#10AEFF"%>;
                                                                 font-size: x-small; color: white; 
                                                                 display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                                <%#Eval("type") %>
                                                            </span>
                                                        </span>
                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                            <%# Eval("phone")+" "+Eval("emp_name")+" "+Eval("need_date","{0:MM-dd HH:mm}")%>  
                                                             <span style="color:<%# Eval("times_type").ToString()=="还差"?"#10AEFF":(Eval("times_type").ToString()=="超时"?"red":"#999999") %>;">
                                                                 <%# Eval("times_type") %><%# Eval("times") %>
                                                             </span>
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

                            <%-----要料完成----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i> 要汤完成(24h内)
                                    <span class="weui-badge  bg-<% =(count2==0?"gray":"blue") %>"><% =count2 %></span>
                                </div>
                                <div class="weui-cells" id="YL_END">
                                    <asp:Repeater runat="server" ID="list_end" EnableTheming="False" OnItemDataBound="list_end_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="weui-cells__title ">
                                                <i class="icon nav-icon icon-22 color-success"></i><%# Eval("cl") %>
                                            </div>                                        
                                            <asp:Repeater runat="server" ID="list_end_dt" EnableTheming="False">
                                            <ItemTemplate>
                                                <a class="weui-cell weui-cell_access" href="YT_Detail_Info.aspx?need_t_no=<%# Eval("need_t_no")%>">
                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                                    <div class="weui-cell__hd">
                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                    </div>
                                                    <div class="weui-cell__bd"> 
                                                        <%--<span class="weui-form-preview__value" style="font-size: smaller">
                                                            <%# Eval("workshop") + "/" + Eval("line") + "/" +Eval("location")  %>
                                                        </span>--%>
                                                    
                                                        <span class="weui-form-preview__value" style="font-size: smaller">
                                                            <%#  "<font color=#10AEFF>"+Eval("yzj_no")+"</font>"+Eval("yzj_name")+","+Eval("pgino")+","+Eval("cl") %>
                                                            <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("type").ToString()=="部分"?"red":"#10AEFF"%>;
                                                                 font-size: x-small; color: white; 
                                                                 display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                                <%#Eval("type") %>
                                                            </span>
                                                        </span>
                                                        <span class="weui-form-preview__value" style="font-size: smaller;display:<%# Eval("status").ToString()=="1"?"block":"none"%>;">
                                                            <%#   Eval("zyb")+","+Eval("lot_no")+",<font color=#10AEFF>"+Eval("act_qty")+"kg</font>" %>
                                                        </span>
                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                            <%# Eval("phone")+" "+Eval("emp_name")+" "+Eval("end_date","{0:MM-dd HH:mm}") %>   
                                                            <span style="color:<%# Eval("times_type").ToString()=="还差"?"#10AEFF":(Eval("times_type").ToString()=="超时"?"red":"#999999") %>;">
                                                                 <%# Eval("times_type") %><%# Eval("times") %>
                                                             </span>
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
                        <%--=======我的工单-----%>
                        <div id="tab2" class="weui-tab__content">
                            <%-----要汤预警----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i> 要汤预警
                                    <span class="weui-badge  bg-<% =(count0_my==0?"gray":"blue") %>"><% =count0_my %></span>
                                </div>
                                <div class="weui-cells" id="YLYJ_My">
                                    <asp:Repeater runat="server" ID="list_pre_my" EnableTheming="False" OnItemDataBound="list_pre_my_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="weui-cells__title ">
                                                <i class="icon nav-icon icon-22 color-success"></i><%# Eval("cl") %>
                                            </div>                                        
                                            <asp:Repeater runat="server" ID="list_pre_my_dt" EnableTheming="False">
                                            <ItemTemplate>
                                                <a class="weui-cell weui-cell_access">
                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-yellow"></span></div>
                                                    <div class="weui-cell__hd">
                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                    </div>
                                                    <div class="weui-cell__bd">
                                                        <span class="weui-form-preview__value" style="font-size: smaller">
                                                            <%# "<font color=#10AEFF>"+Eval("yzj_no")+"</font>"+Eval("yzj_name")
                                                                    +","+Eval("cl")+","+Eval("bwl_weight_toal")+"kg" %>
                                                        </span>
                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                            <%# Eval("phone")+" "+Eval("emp_name")+" "+Eval("act_date","{0:MM-dd HH:mm}")%>  
                                                             <span style="color:#10AEFF;">
                                                                 <%# Eval("times_type") %><%# Eval("times") %>
                                                             </span>
                                                        </span>
                                                        <br />
                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                            <%# Eval("pgino")+","+Eval("pn")+",<font color=#10AEFF>已用"+Eval("qty_xiaohao")+"kg</font>"
                                                                    +","+ (Convert.ToSingle(Eval("rate").ToString())*100).ToString()+"%" %>  
                                                        </span>
                                                    </div>
                                                    <%--<div class="weui-cell__ft">
                                                    </div>--%>
                                                </a>
                                            </ItemTemplate>
                                            </asp:Repeater>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>

                            <%-----要料中----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i> 要汤中 
                                    <span class="weui-badge  bg-<% =(count1_my==0?"gray":"blue") %>"><% =count1_my %></span>
                                </div>
                                <div class="weui-cells" id="YLZ_my">
                                    <asp:Repeater runat="server" ID="list_go_my" EnableTheming="False" OnItemDataBound="list_go_my_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="weui-cells__title ">
                                                <i class="icon nav-icon icon-22 color-success"></i><%# Eval("cl") %>
                                            </div>                                        
                                            <asp:Repeater runat="server" ID="list_go_my_dt" EnableTheming="False">
                                            <ItemTemplate>
                                                <a class="weui-cell weui-cell_access" href="ST.aspx?need_t_no=<%#Eval("need_t_no") %>&workshop=<%=_workshop %>">
                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-green"></span></div>
                                                    <div class="weui-cell__hd">
                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                    </div>
                                                    <div class="weui-cell__bd">
                                                        <%--<span  class="weui-form-preview__value" style="font-size: smaller">
                                                            <%# Eval("workshop") + "/" + Eval("line") + "/" +Eval("location")  %>
                                                        </span>--%>
                                                    
                                                        <span class="weui-form-preview__value" style="font-size: smaller">
                                                            <%# "<font color=#10AEFF>"+Eval("yzj_no")+"</font>"+Eval("yzj_name")+","+Eval("pgino")
                                                                    +","+Eval("cl")+",<font color=#10AEFF>"+Eval("need_qty")+"kg</font>"  %>
                                                            <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("type").ToString()=="部分"?"red":"#10AEFF"%>;
                                                                 font-size: x-small; color: white; 
                                                                 display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                                <%#Eval("type") %>
                                                            </span>
                                                        </span>
                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                            <%# Eval("phone")+" "+Eval("emp_name")+" "+Eval("need_date","{0:MM-dd HH:mm}")%>  
                                                             <span style="color:<%# Eval("times_type").ToString()=="还差"?"#10AEFF":(Eval("times_type").ToString()=="超时"?"red":"#999999") %>;">
                                                                 <%# Eval("times_type") %><%# Eval("times") %>
                                                             </span>
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

                            <%-----要料完成----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i> 要汤完成(24h内)
                                    <span class="weui-badge  bg-<% =(count2_my==0?"gray":"blue") %>"><% =count2_my %></span>
                                </div>
                                <div class="weui-cells" id="YL_END_my">
                                    <asp:Repeater runat="server" ID="list_end_my" EnableTheming="False" OnItemDataBound="list_end_my_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="weui-cells__title ">
                                                <i class="icon nav-icon icon-22 color-success"></i><%# Eval("cl") %>
                                            </div>                                        
                                            <asp:Repeater runat="server" ID="list_end_my_dt" EnableTheming="False">
                                            <ItemTemplate>
                                                <a class="weui-cell weui-cell_access" href="YT_Detail_Info.aspx?need_t_no=<%# Eval("need_t_no")%>">                                                 
                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                                    <div class="weui-cell__hd">
                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                    </div>
                                                    <div class="weui-cell__bd"> <%-- f-gray--%>
                                                        <%--<span class="weui-form-preview__value" style="font-size: smaller">
                                                            <%# Eval("workshop") + "/" + Eval("line") + "/" +Eval("location")  %>
                                                        </span>--%>
                                                    
                                                        <span class="weui-form-preview__value" style="font-size: smaller">
                                                            <%# "<font color=#10AEFF>"+Eval("yzj_no")+"</font>"+Eval("yzj_name")+","+Eval("pgino")+","+Eval("cl") %>
                                                            <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("type").ToString()=="部分"?"red":"#10AEFF"%>;
                                                                 font-size: x-small; color: white; 
                                                                 display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                                <%#Eval("type") %>
                                                            </span>
                                                        </span>
                                                        <span class="weui-form-preview__value" style="font-size: smaller;">
                                                            <%#   Eval("zyb")+","+Eval("lot_no")+",<font color=#10AEFF>"+Eval("act_qty")+"kg</font>" %>
                                                        </span>
                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                            <%# Eval("phone")+" "+Eval("emp_name")+" "+Eval("end_date","{0:MM-dd HH:mm}")+ " " %>   
                                                            <span style="color:<%# Eval("times_type").ToString()=="还差"?"#10AEFF":(Eval("times_type").ToString()=="超时"?"red":"#999999") %>;">
                                                                 <%# Eval("times_type") %><%# Eval("times") %>
                                                             </span>
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
