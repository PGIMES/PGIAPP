<%@ Page Language="C#" AutoEventWireup="true" CodeFile="prod_wip_list.aspx.cs" Inherits="prod_wip_list" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>生产监视</title>
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

            //var _index = window.localStorage.getItem("_tabindex");
            //alert(_index);
            $('#t1').tab({
                defaultIndex:0,// _index == null ? 0 : _index,
                activeClass: 'tab-green',
                onToggle: function (index) {
                   // console.log('index' + index);                     
                    window.localStorage.setItem("_tabindex",index);
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
<body ontouchstart  >
    <div class="weui-pull-to-refresh__layer">
        <div class='weui-pull-to-refresh__arrow'></div>
        <div class='weui-pull-to-refresh__preloader'></div>
        <div class="down">下拉刷新</div>
        <div class="up">释放刷新</div>
        <div class="refresh">正在刷新</div>
    </div>
     
    <form id="form1" runat="server">         
        <div class="page">
            <div class="page__bd" id="t1" style="height: 100%;">
                <div class="weui-tab">
                    <div class="weui-navbar">
                        <div href="#tab1" class="weui-navbar__item weui-bar__item_on">
                            生产监视
                        </div>
                        <div href="#tab2" class="weui-navbar__item">
                            我的生产
                        </div>
                    </div>
                    <div class="weui-tab__panel" style="background-color:lightgray">
                        <%--=======监视-----%>                         
                        <div id="tab1" class="weui-tab__content">                             
                            <asp:Repeater ID="list_line" runat="server"  OnItemDataBound="list_go_ItemDataBound">
                                <ItemTemplate>
                                    <div class="weui-form-preview">
                                        <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i><%# Eval("line") %> </div>
                                        <div class="weui-cells" id="YLZ">                                            
                                            <asp:Repeater runat="server" ID="re_go" EnableTheming="False">
                                                <ItemTemplate>
                                                    <a class="weui-cell weui-cell_access"  href="prod_wip_detail.aspx?need_no=<%# Eval("need_no")%>&ngqty=<%# Eval("ng_qty")%>&wipqty=<%# Eval("wip_qty")%>&type=lot&dh=<%#Eval("lot_no") %>&workshop=<%=_workshop %>&para=Y">
                                                        <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
                                                        <div class="weui-cell__hd">
                                                            <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                        </div>
                                                        <div class="weui-cell__bd">
                                                            <span class="weui-form-preview__value" style="font-size: smaller">
                                                                <span class="padding10-r"><%# Eval("part")%></span>  <%#   Eval("part_desc") %><br />
                                                                <span class="padding5-r"><%# "Lot："+Eval("lot_no").ToString()%></span>
                                                                上料:<font class="f-blue padding5-r"><%# Eval("qty")%></font>
                                                                下料:<font class="f-blue padding5-r"><%# Eval("off_qty")%></font>
                                                                NG:<font class="f-blue padding5-r"><%# Eval("ng_qty")%></font>
                                                                在制:<font class="f-blue "><%# Eval("wip_qty")%></font>
                                                            </span>
                                                            <span class="weui-agree__text padding10-r" style="font-size: smaller"><%# Eval("cellphone") %><%# Eval("emp_name")%></span>
                                                            <span class="weui-agree__text " style="font-size: smaller;"><%# " "+Eval("on_date","{0:MM-dd HH:mm}")+ " "+ Eval("times")%> </span>
                                                        </div>
                                                        <div class="weui-cell__ft">
                                                        </div>
                                                    </a>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <%--=======我的-----%>
                        <div id="tab2" class="weui-tab__content">
                            <asp:Repeater ID="list_line_my" runat="server"  OnItemDataBound="list_go_my_ItemDataBound">
                                <ItemTemplate>
                                    <div class="weui-form-preview">
                                        <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i><%# ((string)Container.DataItem)%> </div>
                                        <div class="weui-cells" id="YLZ">                                            
                                            <asp:Repeater runat="server" ID="re_go_my" EnableTheming="False">
                                                <ItemTemplate>
                                                    <a class="weui-cell weui-cell_access"  href="prod_wip_detail.aspx?need_no=<%# Eval("need_no")%>&ngqty=<%# Eval("ng_qty")%>&wipqty=<%# Eval("wip_qty")%>&type=lot&dh=<%#Eval("lot_no") %>&workshop=<%=_workshop %>&para=Y">
                                                        <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
                                                        <div class="weui-cell__hd">
                                                            <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                        </div>
                                                        <div class="weui-cell__bd">
                                                            <span class="weui-form-preview__value" style="font-size: smaller">
                                                                <span  class="padding10-r"><%# Eval("part")%></span>  <%#   Eval("part_desc") %><br />
                                                                <span  class="padding5-r"><%# "Lot："+Eval("lot_no").ToString()%></span>  
                                                                上料:<font class="f-blue padding5-r"><%# Eval("qty")%></font>
                                                                下料:<font class="f-blue padding5-r"><%# Eval("off_qty")%></font>
                                                                NG:<font class="f-blue padding5-r"><%# Eval("ng_qty")%></font>
                                                                在制:<font class="f-blue "><%# Eval("wip_qty")%></font>
                                                            </span>
                                                            <span class="weui-agree__text padding10-r" style="font-size: smaller;"><%# Eval("cellphone") %><%# Eval("emp_name")%></span>
                                                            <span class="weui-agree__text " style="font-size: smaller;"><%# " "+Eval("on_date","{0:MM-dd HH:mm}")+ " "+  Eval("times")%> </span>
                                                        </div>
                                                        <div class="weui-cell__ft">
                                                        </div>
                                                    </a>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                             
                         
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
            });
        </script>
    </form>
</body>
</html>
