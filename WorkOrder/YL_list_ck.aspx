<%@ Page Language="C#" AutoEventWireup="true" CodeFile="YL_list_ck.aspx.cs" Inherits="WorkOrder_YL_list_ck" %>

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
                                          
        <asp:Repeater runat="server" ID="list_go" EnableTheming="False" OnItemDataBound="list_go_ItemDataBound">
            <ItemTemplate>
                <div style="padding-top:1px;background-color:lightgray;"><%--为了头顶上有一段灰色的--%>
                    <div class="weui-form-preview">
                        <div class="weui-cells__title  ">
                            <i class="icon nav-icon icon-49"></i><%# Eval("workshop") %> 要料中
                            <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                        </div>  
                        <div class="weui-cells" id="YLZ">                             
                            <asp:Repeater runat="server" ID="list_go_dt" EnableTheming="False">
                                <ItemTemplate>
                                    <a class="weui-cell weui-cell_access" 
                                        href="SL.aspx?need_no=<%#Eval("need_no") %>&workshop=<%#Eval("workshop") %>">
                                        <div class="weui-mark-vip"><span class="weui-mark-lt bg-green"></span></div>
                                        <div class="weui-cell__hd">
                                            <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                        </div>
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
                                                <%# Eval("phone")+" "+Eval("emp_name")+" "+Eval("need_date") %>  
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
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
                       

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
