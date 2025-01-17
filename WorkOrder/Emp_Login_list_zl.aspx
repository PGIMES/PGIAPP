﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Emp_Login_list_zl.aspx.cs" Inherits="WorkOrder_Emp_Login_list_zl" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title><%=Request["workshop"] %>上岗监视</title>
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
        .fl{padding-left:0px;padding-right:0px;}/*color:#696969*/
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

        });

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

</head>
<body ontouchstart>
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
                    <div class="weui-navbar">
                        <div href="#tab1" class="weui-navbar__item weui-bar__item_on">
                            上岗监视
                        </div>
                        <div href="#tab2" class="weui-navbar__item">
                            我的上岗
                        </div>
                    </div>

                    <div class="weui-tab__panel" style="background-color:#e5e5e5">
                        <%--=======上岗监视-----%>
                        <div id="tab1" class="weui-tab__content">
                            <asp:Repeater ID="list_go_workshop" runat="server" EnableTheming="False" OnItemDataBound="list_go_workshop_ItemDataBound">
                                <ItemTemplate>
                                    <div class="weui-form-preview">
                                        <ul class="collapse">
                                            <li>
                                                <div class="weui-flex js-category">
                                                    <div class="weui-cells__title fl weui-flex__item">
                                                        <i class="icon nav-icon icon-49"></i><%# Eval("workshop") %>
                                                        <span class='weui-badge' 
                                                            style="background-color:<%# Eval("count_zl").ToString()=="0"?"lightgray":"orange" %>; color:white;">
                                                            质<%# Eval("count_zl") %>
                                                        </span>
                                                    </div>
                                                    <i class="icon icon-74"></i>
                                                </div>
                                                <div class="page-category js-categoryInner">
                                                    <div class="weui-cells" id="YLZ">
                                                        <asp:Repeater ID="list_go" runat="server" EnableTheming="False" OnItemDataBound="list_go_ItemDataBound">
                                                            <ItemTemplate>
                                                                    <ul class="collapse">
                                                                        <li style="margin-top:0px;margin-bottom:0px">
                                                                            <div class="weui-flex js-category" onclick="showorhide(this);">
                                                                                <div class="weui-cells__title  weui-flex__item">
                                                                                    <i class="icon nav-icon icon-22 color-success"></i><%# Eval("line") %>
                                                                                    <span class='weui-badge' 
                                                                                        style="background-color:<%# Eval("count_zl").ToString()=="0"?"lightgray":"orange" %>; color:white;">
                                                                                        质<%# Eval("count_zl") %>
                                                                                    </span>
                                                                                </div>
                                                                                <i class="icon icon-74"></i>
                                                                            </div>
                                                                            <div class="page-category js-categoryInner" style="display: none">
                                                                                <div class="weui-cells" id="YLZ">
                                                                                    <asp:Repeater runat="server" ID="re_go" EnableTheming="False">
                                                                                        <ItemTemplate>
                                                                                            <a class="weui-cell weui-cell_access">
                                                                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                                                                                <div class="weui-cell__hd">
                                                                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                                                </div>
                                                                                                <div class="weui-cell__bd">
                                                                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                                                                        <%# Eval("location") + "," + Eval("phone") + "," +Eval("emp_name")  %>
                                                                                                    </span>
                                                                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                                                                            <%# Eval("on_date","{0:MM-dd HH:mm}")+  " 时长: " %>  
                                                                                                            <span style="color:<%# Eval("times_type").ToString()=="Y"?"red":"#10AEFF" %>;">
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
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <%--=======我的上岗-----%>
                        <div id="tab2" class="weui-tab__content">
                            <%-----上岗中----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i> 上岗中 </div>
                                <div class="weui-cells" id="YLZ_my">
                                    <asp:Repeater runat="server" ID="list_go_my" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" 
                                                href="Emp_Login.aspx?workshop=<%=_workshop %>">
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("location") + "," + Eval("phone") + "," +Eval("emp_name")  %>
                                                    </span>
                                                     <span class="weui-agree__text" style="font-size: smaller">
                                                         <%# Eval("on_date","{0:MM-dd HH:mm}")+  " 时长: <font class='f-blue'>"+Eval("times")+"</font>"%>   
                                                     </span>
                                                </div>
                                                <div class="weui-cell__ft">
                                                </div>
                                            </a>

                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>

                            <%-----已下岗本月----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i> 已下岗本月 </div>
                                <div class="weui-cells" id="YL_WC_my">
                                    <asp:Repeater runat="server" ID="list_wc_my" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access">
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd  f-gray">
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("location") + "," + Eval("phone") + "," +Eval("emp_name")  %>
                                                    </span>
                                                     <span class="weui-agree__text" style="font-size: smaller">
                                                         <%# Eval("on_date","{0:MM-dd HH:mm}")+  " 时长: "+Eval("times")+""%>   
                                                     </span>
                                                </div>
                                            </a>

                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>

                             <%-----已下岗上月----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i> 已下岗上月 </div>
                                <div class="weui-cells" id="YL_WC_last_my">
                                    <asp:Repeater runat="server" ID="list_wc_last_my" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access">
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd  f-gray">
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("location") + "," + Eval("phone") + "," +Eval("emp_name")  %>
                                                    </span>
                                                     <span class="weui-agree__text" style="font-size: smaller">
                                                         <%# Eval("on_date","{0:MM-dd HH:mm}")+  " 时长: "+Eval("times")+""%>   
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
