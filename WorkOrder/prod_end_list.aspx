<%@ Page Language="C#" AutoEventWireup="true" CodeFile="prod_end_list.aspx.cs" Inherits="prod_end_list" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>生产完成监视</title>
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
        .span_space{
            padding-right:20px
        }
    </style>

    <script src="../js/zepto.min.js"></script>
    <script src="../js/zepto.weui.js"></script>
    <script src="../js/iscroll-lite.js"></script>

    <script>

        $(function () {

           // var _index = window.localStorage.getItem("_tabindex");
            $('#t2').tab({
                defaultIndex:0,// _index == null ? 0 : _index,
                activeClass: 'tab-green',
                onToggle: function (index) {
                    //console.log('index' + index);
                }
            })

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
<body ontouchstart >
   

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
                            所有工单
                        </div>
                        <div href="#tab2" class="weui-navbar__item">
                            我的工单
                        </div>
                    </div>

                    <div class="weui-tab__panel" style="background-color: lightgray">
                        <%--==完成工单==--%>
                        <div id="tab1" class="weui-tab__content">
                            <%----部分完成-----%>
                             <div class="weui-form-preview">
                                <div class="weui-cells__title "><i class="icon nav-icon icon-49"></i> 部分完成<asp:Label ID="Label1" runat="server" Text=""></asp:Label></div>
                                <div class="weui-cells" >
                                    <asp:Repeater ID="DataList1_line" runat="server" OnItemDataBound="DataList1_line_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="weui-cells__title "><i class="icon nav-icon icon-22 color-success"></i><%#((string)Container.DataItem) %></div>
                                            <asp:Repeater ID="DataList1" runat="server">
                                                <ItemTemplate>
                                                    <a class="weui-cell  weui-cell_access" href="prod_end_detail.aspx?type=workorder_part&dh=<%#Eval("workorder_part") %>">
                                                        <div class="weui-mark-vip"><span class="weui-mark-lt bg-yellow"></span></div>
                                                        <div class="weui-cell__hd">
                                                            <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                        </div>
                                                        <div class="weui-cell__bd f-black" style="font-size: smaller">
                                                            <span class="span_space">
                                                                <font color="blue"><%# DataBinder.Eval(Container.DataItem, "pgino") %></font>
                                                            </span>
                                                            <span>
                                                                <%# DataBinder.Eval(Container.DataItem, "pn") %>
                                                            </span>
                                                            <br />
                                                            <span class="span_space">完工单号:<%# DataBinder.Eval(Container.DataItem, "workorder_part") %>
                                                            </span>
                                                            <span>完工数量:<font color="blue"><%# DataBinder.Eval(Container.DataItem, "qty") %></font>
                                                            </span>
                                                            <br />
                                                            <span class="weui-agree__text span_space">
                                                                <%# DataBinder.Eval(Container.DataItem, "EmpName") %>
                                                            </span>
                                                            <span class="weui-agree__text"><%# DataBinder.Eval(Container.DataItem, "endtime","{0:MM-dd HH:mm}") %> </span>
                                                            <span class="weui-agree__text">时长:<font class="f-blue"> <%# DataBinder.Eval(Container.DataItem, "times") %></font>
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
                            <%----已完成-----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title "><i class="icon nav-icon icon-49"></i> 生产完成(24小时内)<asp:Label ID="Label2" runat="server" Text=""></asp:Label></div>
                                <div class="weui-cells">
                                    <asp:Repeater ID="DataList2_line" runat="server" OnItemDataBound="DataList2_line_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="weui-cells__title "><i class="icon nav-icon icon-22 color-success"></i><%#((string)Container.DataItem) %></div>
                                            <asp:Repeater ID="DataList2" runat="server">
                                                <ItemTemplate>
                                                    <a class="weui-cell  weui-cell_access " style="color: black" href="prod_end_detail.aspx?type=workorder&dh=<%#Eval("workorder") %>">
                                                        <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                                        <div class="weui-cell__hd">
                                                            <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                        </div>
                                                        <div class="weui-cell__bd " style="font-size: smaller">

                                                            <span class="span_space">
                                                                <%# DataBinder.Eval(Container.DataItem, "pgino") %> 
                                                            </span>
                                                            <span>
                                                                <%# DataBinder.Eval(Container.DataItem, "pn") %>
                                                            </span>
                                                            <br />
                                                            <span class="span_space">完工单号:<%# DataBinder.Eval(Container.DataItem, "workorder") %>
                                                            </span>
                                                            <span>完工数量:<font color="blue"><%# DataBinder.Eval(Container.DataItem, "qty") %></font>
                                                            </span>
                                                            <br />
                                                            <span class="weui-agree__text span_space">
                                                                <%# DataBinder.Eval(Container.DataItem, "EmpName") %>
                                                            </span>
                                                            <span class="weui-agree__text"><%# DataBinder.Eval(Container.DataItem, "endtime","{0:MM-dd HH:mm}") %> </span>
                                                            <span class="weui-agree__text">时长:<font class="f-blue"> <%# DataBinder.Eval(Container.DataItem, "times") %></font>
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
                        <%--==我的工单==--%>
                        <div id="tab2" class="weui-tab__content">
                            <%----部分完成-----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title "><i class="icon nav-icon icon-49"></i> 部分完成<asp:Label ID="Label3" runat="server" Text=""></asp:Label></div>
                                <div class="weui-cells"  >
                                    <asp:Repeater ID="DataList3_line" runat="server" OnItemDataBound="DataList3_line_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="weui-cells__title "><i class="icon nav-icon icon-22 color-success"></i><%#((string)Container.DataItem) %></div>
                                    <asp:Repeater ID="DataList3" runat="server">
                                        <ItemTemplate>
                                            <a class="weui-cell   weui-cell_access " href="prod_end_detail.aspx?type=workorder&dh=<%#Eval("workorder_part") %>">
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-yellow"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd f-black" style="font-size: smaller">
                                                    <span class="span_space">
                                                        <font color="blue"><%# DataBinder.Eval(Container.DataItem, "pgino") %></font>
                                                    </span>
                                                    <span>
                                                        <%# DataBinder.Eval(Container.DataItem, "pn") %>
                                                    </span>
                                                    <br />
                                                    <span class="span_space">完工单号:<%# DataBinder.Eval(Container.DataItem, "workorder_part") %>
                                                    </span>
                                                    <span>完工数量:<font color="blue"><%# DataBinder.Eval(Container.DataItem, "qty") %></font>
                                                    </span>
                                                    <br />
                                                    <span class="weui-agree__text span_space">
                                                        <%# DataBinder.Eval(Container.DataItem, "EmpName") %>
                                                    </span>
                                                    <span class="weui-agree__text">时长:<font class="f-blue"> <%# DataBinder.Eval(Container.DataItem, "times") %></font>
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
                            <%----已完成-----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title "><i class="icon nav-icon icon-49"></i> 生产完成(24小时内)<asp:Label ID="Label4" runat="server" Text=""></asp:Label></div>
                                <div class="weui-cells"  >
                                    <asp:Repeater ID="DataList4_line" runat="server" OnItemDataBound="DataList4_line_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="weui-cells__title "><i class="icon nav-icon icon-22  color-success"></i><%#((string)Container.DataItem) %></div>
                                    <asp:Repeater ID="DataList4"  runat="server"  >
                                        <ItemTemplate>
                                            <a class="weui-cell  weui-cell_access   " href="prod_end_detail.aspx?type=workorder&dh=<%#Eval("workorder") %>">
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd " style="font-size: smaller">
                                                    <span class="span_space">
                                                         <%# DataBinder.Eval(Container.DataItem, "pgino") %>
                                                    </span>
                                                    <span>
                                                        <%# DataBinder.Eval(Container.DataItem, "pn") %>
                                                    </span>
                                                    <br />
                                                    <span class="span_space">完工单号:<%# DataBinder.Eval(Container.DataItem, "workorder") %>
                                                    </span>
                                                    <span>完工数量:<font color="blue"><%# DataBinder.Eval(Container.DataItem, "qty") %></font>
                                                    </span>
                                                    <br />
                                                    <span class="weui-agree__text span_space">
                                                        <%# DataBinder.Eval(Container.DataItem, "EmpName") %>
                                                    </span>
                                                    <span class="weui-agree__text">时长:<font class="f-blue"> <%# DataBinder.Eval(Container.DataItem, "times") %></font>
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
