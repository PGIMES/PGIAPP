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
                                <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i> 要料中<asp:Label ID="Label1" runat="server" Text=""></asp:Label> 
                                   <%-- <asp:Label ID="Label1" runat="server" Text=""  style="display:none;"></asp:Label>
                                   <% string i1 = Label1.Text; Response.Write("<span class='weui-badge  bg-" + (i1 == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>" + i1 + "</span>"); %>   --%>
                                </div>
                                <div class="weui-cells" id="YLZ">
                                    <asp:Repeater runat="server" ID="list_go" EnableTheming="False" OnItemDataBound="list_go_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="weui-cells__title ">
                                                <i class="icon nav-icon icon-22 color-success"></i><%# Eval("line") %>
                                            </div>                                        
                                            <asp:Repeater runat="server" ID="list_go_dt" EnableTheming="False">
                                            <ItemTemplate>
                                                <a class="weui-cell weui-cell_access" 
                                                    href="SL.aspx?need_no=<%#Eval("need_no") %>&workshop=<%=_workshop %>">
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
                                                            <%# Eval("phone")+" "+Eval("emp_name")+" "+Eval("need_date")
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
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>

                            <%-----已送料----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i> 已送料<asp:Label ID="Label2" runat="server" Text=""></asp:Label> </div>
                                <div class="weui-cells" id="YL_WC">
                                    <asp:Repeater runat="server" ID="list_wc" EnableTheming="False" OnItemDataBound="list_wc_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="weui-cells__title ">
                                                <i class="icon nav-icon icon-22 color-success"></i><%# Eval("line") %>
                                            </div>                                        
                                            <asp:Repeater runat="server" ID="list_wc_dt" EnableTheming="False">
                                            <ItemTemplate>
                                                <a class="weui-cell weui-cell_access" 
                                                    href="Load_Material.aspx?lotno=<%#Eval("lot_no") %>&need_no=<%#Eval("need_no") %>&workshop=<%=_workshop %>&para=S">
                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-blue"></span></div>
                                                    <div class="weui-cell__hd">
                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                    </div>
                                                    <div class="weui-cell__bd"> <%-- f-gray--%>
                                                        <span class="weui-form-preview__value" style="font-size: smaller">
                                                            <%# Eval("workshop") + "/" + Eval("line") + "/" +Eval("location")  %>
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
                                                                   +" "+Eval("need_date")+ " " 
                                                             %>   
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

                            <%-----已退料----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i> 已退料<asp:Label ID="Label3" runat="server" Text=""></asp:Label> </div>
                                <div class="weui-cells" id="YL_RJ">
                                    <asp:Repeater runat="server" ID="list_rj" EnableTheming="False" OnItemDataBound="list_rj_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="weui-cells__title ">
                                                <i class="icon nav-icon icon-22 color-success"></i><%# Eval("line") %>
                                            </div>                                        
                                            <asp:Repeater runat="server" ID="list_rj_dt" EnableTheming="False">
                                            <ItemTemplate>
                                                <a class="weui-cell weui-cell_access" 
                                                    href="Load_Material.aspx?lotno=<%#Eval("lot_no") %>&need_no=<%#Eval("need_no") %>&workshop=<%=_workshop %>&para=T">
                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-danger"></span></div>
                                                    <div class="weui-cell__hd">
                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                    </div>
                                                    <div class="weui-cell__bd"> <%-- f-gray--%>
                                                        <span class="weui-form-preview__value" style="font-size: smaller">
                                                            <%# Eval("workshop") + "/" + Eval("line") + "/" +Eval("location")  %>
                                                        </span>
                                                    
                                                        <span class="weui-form-preview__value" style="font-size: smaller">
                                                            <%#   Eval("pgino")+","+Eval("pn") %><br />
                                                            <span class="padding5-r"><%# "Lot:"+Eval("lot_no").ToString()%></span>
                                                            已送:<font class="f-blue padding5-r"><%# Eval("feed_qty")%></font>
                                                            下料:<font class="f-blue padding5-r"><%# Eval("off_qty")%></font>
                                                            NG:<font class="f-blue padding5-r"><%# Eval("ng_qty")%></font>
                                                            已退:<font class="f-blue "><%# Eval("reject_qty")%></font>
                                                        </span>

                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                            <%# Eval("phone")+" "+Eval("emp_name")+" "+Eval("reject_date")+ " " 
                                                             %>   
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
                                <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i> 要料完成(24h内)<asp:Label ID="Label4" runat="server" Text=""></asp:Label> </div>
                                <div class="weui-cells" id="YL_END">
                                    <asp:Repeater runat="server" ID="list_end" EnableTheming="False" OnItemDataBound="list_end_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="weui-cells__title ">
                                                <i class="icon nav-icon icon-22 color-success"></i><%# Eval("line") %>
                                            </div>                                        
                                            <asp:Repeater runat="server" ID="list_end_dt" EnableTheming="False">
                                            <ItemTemplate>
                                                <%--<a class="weui-cell weui-cell_access" 
                                                    href="prod_wip_detail.aspx?need_no=<%# Eval("need_no")%>&ngqty=<%# Eval("ng_qty")%>&wipqty=<%# Eval("wip_qty")%>&type=lot&dh=<%#Eval("lot_no") %>&workshop=<%=_workshop %>&para=N">--%>
                                                <a class="weui-cell weui-cell_access" 
                                                    href="YL_Detail_Info.aspx?need_no=<%# Eval("need_no")%>">
                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                                    <div class="weui-cell__hd">
                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                    </div>
                                                    <div class="weui-cell__bd"> <%-- f-gray--%>
                                                        <span class="weui-form-preview__value" style="font-size: smaller">
                                                            <%# Eval("workshop") + "/" + Eval("line") + "/" +Eval("location")  %>
                                                        </span>
                                                    
                                                        <span class="weui-form-preview__value" style="font-size: smaller">
                                                            <%#   Eval("pgino")+","+Eval("pn")+","+Eval("act_qty") +"件" %>
                                                        </span>
                                                    

                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                            <%# Eval("phone")+" "+Eval("emp_name")
                                                                   +" "+Eval("b_on_m_date")+ " " 
                                                             %>   
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
                            <%-----要料中----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i> 要料中 <asp:Label ID="Label5" runat="server" Text=""></asp:Label></div>
                                <div class="weui-cells" id="YLZ_my">
                                    <asp:Repeater runat="server" ID="list_go_my" EnableTheming="False" OnItemDataBound="list_go_my_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="weui-cells__title ">
                                                <i class="icon nav-icon icon-22 color-success"></i><%# Eval("line") %>
                                            </div>                                        
                                            <asp:Repeater runat="server" ID="list_go_my_dt" EnableTheming="False">
                                            <ItemTemplate>
                                                <a class="weui-cell weui-cell_access" 
                                                    href="SL.aspx?need_no=<%#Eval("need_no") %>&workshop=<%=_workshop %>">
                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-green"></span></div>
                                                    <div class="weui-cell__hd">
                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                    </div>
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
                                                            <%# Eval("phone")+" "+Eval("emp_name")+" "+Eval("need_date")
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
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>

                            <%-----已送料----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i> 已送料<asp:Label ID="Label6" runat="server" Text=""></asp:Label> </div>
                                <div class="weui-cells" id="YL_WC_my">
                                    <asp:Repeater runat="server" ID="list_wc_my" EnableTheming="False" OnItemDataBound="list_wc_my_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="weui-cells__title ">
                                                <i class="icon nav-icon icon-22 color-success"></i><%# Eval("line") %>
                                            </div>                                        
                                            <asp:Repeater runat="server" ID="list_wc_my_dt" EnableTheming="False">
                                            <ItemTemplate>
                                                <a class="weui-cell weui-cell_access" 
                                                    href="Load_Material.aspx?lotno=<%#Eval("lot_no") %>&need_no=<%#Eval("need_no") %>&workshop=<%=_workshop %>&para=S">
                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-blue"></span></div>
                                                    <div class="weui-cell__hd">
                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                    </div>
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
                                                                    +" "+Eval("need_date")+ " " 
                                                             %>   
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

                            <%-----已退料----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i> 已退料<asp:Label ID="Label7" runat="server" Text=""></asp:Label> </div>
                                <div class="weui-cells" id="YL_RJ_my">
                                    <asp:Repeater runat="server" ID="list_rj_my" EnableTheming="False" OnItemDataBound="list_rj_my_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="weui-cells__title ">
                                                <i class="icon nav-icon icon-22 color-success"></i><%# Eval("line") %>
                                            </div>                                        
                                            <asp:Repeater runat="server" ID="list_rj_my_dt" EnableTheming="False">
                                            <ItemTemplate>
                                                <a class="weui-cell weui-cell_access" 
                                                    href="Load_Material.aspx?lotno=<%#Eval("lot_no") %>&need_no=<%#Eval("need_no") %>&workshop=<%=_workshop %>&para=T">
                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-danger"></span></div>
                                                    <div class="weui-cell__hd">
                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                    </div>
                                                    <div class="weui-cell__bd"> <%-- f-gray--%>
                                                        <span  class="weui-form-preview__value" style="font-size: smaller">
                                                            <%# Eval("workshop") + "/" + Eval("line") + "/" +Eval("location")  %>
                                                        </span>
                                                    
                                                       <span class="weui-form-preview__value" style="font-size: smaller">
                                                            <%#   Eval("pgino")+","+Eval("pn") %><br />
                                                            <span class="padding5-r"><%# "Lot:"+Eval("lot_no").ToString()%></span>
                                                            已送:<font class="f-blue padding5-r"><%# Eval("feed_qty")%></font>
                                                            下料:<font class="f-blue padding5-r"><%# Eval("off_qty")%></font>
                                                            NG:<font class="f-blue padding5-r"><%# Eval("ng_qty")%></font>
                                                            已退:<font class="f-blue "><%# Eval("reject_qty")%></font>
                                                        </span>

                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                            <%# Eval("phone")+" "+Eval("emp_name")+" "+Eval("reject_date")+ " " 
                                                             %>   
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
                                <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i> 要料完成(24h内)<asp:Label ID="Label8" runat="server" Text=""></asp:Label> </div>
                                <div class="weui-cells" id="YL_END_my">
                                    <asp:Repeater runat="server" ID="list_end_my" EnableTheming="False" OnItemDataBound="list_end_my_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="weui-cells__title ">
                                                <i class="icon nav-icon icon-22 color-success"></i><%# Eval("line") %>
                                            </div>                                        
                                            <asp:Repeater runat="server" ID="list_end_my_dt" EnableTheming="False">
                                            <ItemTemplate>
                                                <%--<a class="weui-cell weui-cell_access" 
                                                     href="prod_wip_detail.aspx?need_no=<%# Eval("need_no")%>&ngqty=<%# Eval("ng_qty")%>&wipqty=<%# Eval("wip_qty")%>&type=lot&dh=<%#Eval("lot_no") %>&workshop=<%=_workshop %>&para=N">--%>
                                                <a class="weui-cell weui-cell_access" 
                                                    href="YL_Detail_Info.aspx?need_no=<%# Eval("need_no")%>">
                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                                    <div class="weui-cell__hd">
                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                    </div>
                                                    <div class="weui-cell__bd"> <%-- f-gray--%>
                                                        <span class="weui-form-preview__value" style="font-size: smaller">
                                                            <%# Eval("workshop") + "/" + Eval("line") + "/" +Eval("location")  %>
                                                        </span>
                                                    
                                                        <span class="weui-form-preview__value" style="font-size: smaller">
                                                            <%#   Eval("pgino")+","+Eval("pn")+","+Eval("act_qty") +"件" %>
                                                        </span>
                                                    

                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                            <%# Eval("phone")+" "+Eval("emp_name")
                                                                   +" "+Eval("b_on_m_date")+ " " 
                                                             %>   
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
