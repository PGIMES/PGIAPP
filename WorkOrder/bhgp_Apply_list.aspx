<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bhgp_Apply_list.aspx.cs" Inherits="WorkOrder_bhgp_Apply_list" %>

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
                            不合格监视
                        </div>
                        <div href="#tab2" class="weui-navbar__item">
                            我的不合格
                        </div>
                    </div>

                    <div class="weui-tab__panel" style="background-color:lightgray">
                        <%--=======不合格监视-----%>
                        <div id="tab1" class="weui-tab__content">
                            <asp:Repeater ID="list_go" runat="server" EnableTheming="False" OnItemDataBound="list_go_ItemDataBound">
                                <ItemTemplate>
                                    <div class="weui-form-preview">
                                        <div class="weui-cells__title  ">
                                            <i class="icon nav-icon icon-49"></i><%# Eval("stepname") %>
                                            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                                        </div>
                                        <div class="weui-cells" id="YLZ">
                                            <asp:Repeater runat="server" ID="re_go" EnableTheming="False">
                                                <ItemTemplate>
                                                    <a class="weui-cell weui-cell_access" 
                                                            href="bhgp_deal_new.aspx?workorder=<%#Eval("workorder") %>&workshop=<%=_workshop %>">
                                                        <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
                                                        <div class="weui-cell__hd">
                                                            <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                        </div>
                                                        <div class="weui-cell__bd">
                                                            <span>
                                                                <%# Eval("pgino") + "," + Eval("pn") + "," +Eval("op") + "" +Eval("op_descr")  %>
                                                            </span>
                                                            <span class="weui-form-preview__value" style="font-size: smaller">
                                                                <%# Eval("reason_code") + "" + Eval("reason") + "," +Eval("sy_qty")+"件" %>
                                                                <span class="weui-mark-rt- weui-badge" 
                                                                    style="background-color: <%# Eval("type").ToString()=="部分"?"red":"#10AEFF"%>;
                                                                     font-size: x-small; color: white; 
                                                                     display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                                    <%#Eval("type") %>
                                                                </span>
                                                            </span>
                                                             <span class="weui-agree__text" style="font-size: smaller">
                                                                 <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长: <font class='f-blue'>"+Eval("times")+"</font>"%>   
                                                             </span>
                                                        </div>
                                                    </a>

                                                </ItemTemplate>
                                            </asp:Repeater>
                                       
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                           
                        </div>
                        <%--=======我的不合格-----%>
                        <div id="tab2" class="weui-tab__content">
                            <%-----上岗中----%>
                            <%--<div class="weui-form-preview">
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
                            </div>--%>

                            <%-----已下岗本月----%>
                            <%--<div class="weui-form-preview">
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
                            </div>--%>

                             <%-----已下岗上月----%>
                            <%--<div class="weui-form-preview">
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
                            </div>--%>

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
