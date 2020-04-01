<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BXMonitor.aspx.cs" Inherits="MoJu_BXMonitor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>模修监视</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0" />
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
    <%--<link href="../css/font-awesome.min.css" rel="stylesheet" />--%>
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
                            所有工单
                        </div>
                        <div href="#tab2" class="weui-navbar__item">
                            我的工单
                        </div>
                    </div>

                    <div class="weui-tab__panel" style="background-color:lightgray">
      <%--=====所有工单================================================--%>
                         <%----已报修-----%>
                        <div id="tab1" class="weui-tab__content">
                            <div class="weui-form-preview">
                                <div class="weui-cells__title "><i class="icon nav-icon icon-49"></i> 已报修</div>
                                <div class="weui-cells" style="font-size: ">
                                    <asp:Repeater runat="server" ID="listBX" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" href="BXAction.aspx?dh=<%#Eval("bx_dh") %>">
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-danger"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                    <span class="weui-form-preview__label"><%#Eval("bx_dh").ToString()%></span>
                                                    <span><%#Eval("bx_sbname") + " " +Eval("bx_moju_no") %></span>
                                                    <span class="weui-mark-rt- weui-badge" style="background-color: <%# Eval("level").ToString()=="一级"?"#10AEFF":"#FA5151"%>; font-size: x-small; color: white"><%#Eval("level") %></span>
                                                    <span class="weui-form-preview__value"><%# Eval("moju_repair")+" "+Eval("bx_gz_type")+" "+Eval("bx_gz_desc")%></span>
                                                    <span class="weui-agree__text" style="font-size: smaller"><%#Eval("cellphone")+" "+Eval("bx_name")+" "+Eval("bx_date","{0:MM-dd HH:mm}") +  " 时长: <font class='f-blue'>"+Eval("bx_shichang")+"</font>" %>  </span>

                                                </div>
                                                <div class="weui-cell__ft">
                                                </div>
                                            </a>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                            
                            <%-----维修中----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i> 维修中 </div>
                                <div class="weui-cells" id="WXZ">
                                    <asp:Repeater runat="server" ID="listWX" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" href="BXAction.aspx?dh=<%#Eval("bx_dh") %>">
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                    <label class="weui-form-preview__label"><%#Eval("bx_dh").ToString()%></label>
                                                    <span><%#Eval("bx_sbname") + " " +Eval("bx_moju_no")  %></span>
                                                    <span class="weui-mark-rt- weui-badge" style="background-color: <%# Eval("level").ToString()=="一级"?"#10AEFF":"#FA5151"%>; font-size: x-small; color: white"><%#Eval("level") %></span>
                                                    <span class="weui-form-preview__value"><%#   Eval("moju_repair")+" "+Eval("bx_gz_type")+" "+Eval("bx_gz_desc")%></span>
                                                    <span class="weui-agree__text" style="font-size: smaller"><%#Eval("cellphone")+" "+Eval("bx_name")+" "+Eval("bx_date","{0:MM-dd HH:mm}")+  " 时长: <font class='f-blue'>"+Eval("bx_shichang")+"</font>"%>   </span>

                                                </div>
                                                <div class="weui-cell__ft">
                                                </div>
                                            </a>

                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                          
                            <%-----生产确认----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title "><i class="icon nav-icon icon-49"></i> 生产确认 </div>
                                <div class="weui-cells" id="QR">
                                    <asp:Repeater runat="server" ID="listQR" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" href="BXAction.aspx?dh=<%#Eval("bx_dh") %>">
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-blue"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                    <label class="weui-form-preview__label"><%#Eval("bx_dh").ToString()%></label>
                                                    <span><%#Eval("bx_sbname") + " " + Eval("bx_moju_no")%></span>
                                                    <span class="weui-mark-rt- weui-badge" style="background-color: <%# Eval("level").ToString()=="一级"?"#10AEFF":"#FA5151"%>; font-size: x-small; color: white"><%#Eval("level") %></span>
                                                    <span class="weui-form-preview__value"><%# Eval("moju_repair") +" "+Eval("bx_gz_type")+" "+Eval("bx_gz_desc")%></span>
                                                    <span class="weui-agree__text" style="font-size: smaller"><%#Eval("cellphone")+" "+Eval("wx_name")+" "+Eval("bx_date","{0:MM-dd HH:mm}")+  " 时长: <font class='f-blue'>"+Eval("bx_shichang")+"</font>"%></span>

                                                </div>
                                                <div class="weui-cell__ft">
                                                </div>
                                            </a>

                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                            <%-----确认完成----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title "><i class="icon nav-icon icon-49"></i> 已完成(24小时内) </div>
                                <div class="weui-cells" id="WC">
                                   
                                    <asp:Repeater runat="server" ID="listWC" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" href="BXAction.aspx?dh=<%#Eval("bx_dh") %>">
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd f-gray">
                                                    <label class="weui-form-preview__label"><%# Right(Eval("bx_dh").ToString(),7)%></label>
                                                    <span><%#Eval("bx_sbname") + " " + Eval("bx_moju_no")%></span>
                                                    <span class="weui-mark-rt- weui-badge" style="background-color: <%# Eval("level").ToString()=="一级"?"#10AEFF":"#FA5151"%>; font-size:x-small; color: white"><%#Eval("level") %></span>
                                                    <span class="weui-form-preview__value"><%# Eval("moju_repair")+" "+Eval("bx_gz_type")+" "+Eval("bx_gz_desc")%></span>
                                                    <span class="weui-agree__text" style="font-size: smaller"><%#Eval("cellphone")+" "+Eval("bx_name")+" "+Eval("bx_date","{0:MM-dd HH:mm}")+  " 时长: <font class='f-blue'>"+Eval("bx_shichang")+"</font>"%></span>

                                                </div>
                                                <div class="weui-cell__ft">
                                                </div>
                                            </a>

                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
          
                        </div>
 <%--=====end所有工单================================================--%>
                        <%--=======我的工单-----%>
                        <div id="tab2" class="weui-tab__content">
                            <div class="weui-form-preview">
                                <div class="weui-cells__title "><i class="icon nav-icon icon-49"></i> 已报修</div>
                                <div class="weui-cells" style="font-size: ">
                                    <asp:Repeater runat="server" ID="listBXmy" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" href="BXAction.aspx?dh=<%#Eval("bx_dh") %>">
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-danger"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                    <span class="weui-form-preview__label"><%#Eval("bx_dh").ToString()%></span>
                                                    <span><%#Eval("bx_sbname") + " " + Eval("bx_moju_no") %></span>
                                                    <span class="weui-mark-rt- weui-badge" style="background-color: <%# Eval("level").ToString()=="一级"?"#10AEFF":"#FA5151"%>; font-size: x-small; color: white"><%#Eval("level") %></span>
                                                    <span class="weui-form-preview__value"><%#  Eval("moju_repair")+" "+  Eval("bx_gz_type")+" "+Eval("bx_gz_desc")%></span>
                                                    <span class="weui-agree__text" style="font-size: smaller"><%#Eval("cellphone")+" "+Eval("bx_name")+" "+Eval("bx_date","{0:MM-dd HH:mm}") +  " 时长: <font class='f-blue'>"+Eval("bx_shichang")+"</font>" %>  </span>

                                                </div>
                                                <div class="weui-cell__ft">
                                                </div>
                                            </a>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                            
                            <%-----维修中----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  "><i class="icon nav-icon icon-49"></i> 维修中 </div>
                                <div class="weui-cells" id="WXZmy">
                                    <asp:Repeater runat="server" ID="listWXmy" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" href="BXAction.aspx?dh=<%#Eval("bx_dh") %>">
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                    <label class="weui-form-preview__label"><%#Eval("bx_dh").ToString()%></label>
                                                    <span><%#Eval("bx_sbname")+" "+ Eval("bx_moju_no")  %></span>
                                                    <span class="weui-mark-rt- weui-badge" style="background-color: <%# Eval("level").ToString()=="一级"?"#10AEFF":"#FA5151"%>; font-size: x-small; color: white"><%#Eval("level") %></span>
                                                    <span class="weui-form-preview__value"><%#  Eval("moju_repair")+" "+Eval("bx_gz_type")+" "+Eval("bx_gz_desc")%></span>
                                                    <span class="weui-agree__text" style="font-size: smaller"><%#Eval("cellphone")+" "+Eval("bx_name")+" "+Eval("bx_date","{0:MM-dd HH:mm}")+  " 时长: <font class='f-blue'>"+Eval("bx_shichang")+"</font>"%>   </span>

                                                </div>
                                                <div class="weui-cell__ft">
                                                </div>
                                            </a>

                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                          
                            <%-----生产确认----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title "><i class="icon nav-icon icon-49"></i> 生产确认 </div>
                                <div class="weui-cells" id="QRmy">
                                    <asp:Repeater runat="server" ID="listQRmy" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" href="BXAction.aspx?dh=<%#Eval("bx_dh") %>">
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-blue"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                    <label class="weui-form-preview__label"><%#Eval("bx_dh").ToString()%></label>
                                                    <span><%#Eval("bx_sbname") + " " + Eval("bx_moju_no")%></span>
                                                    <span class="weui-mark-rt- weui-badge" style="background-color: <%# Eval("level").ToString()=="一级"?"#10AEFF":"#FA5151"%>; font-size: x-small; color: white"><%#Eval("level") %></span>
                                                    <span class="weui-form-preview__value"><%# Eval("moju_repair")+" "+Eval("bx_gz_type")+" "+Eval("bx_gz_desc")%></span>
                                                    <span class="weui-agree__text" style="font-size: smaller"><%#Eval("cellphone")+" "+Eval("wx_name")+" "+Eval("bx_date","{0:MM-dd HH:mm}")+  " 时长: <font class='f-blue'>"+Eval("bx_shichang")+"</font>"%></span>

                                                </div>
                                                <div class="weui-cell__ft">
                                                </div>
                                            </a>

                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                            <%-----确认完成----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title "><i class="icon nav-icon icon-49"></i> 已完成(24小时内) </div>
                                <div class="weui-cells" id="WCmy">
                                   
                                    <asp:Repeater runat="server" ID="listWCmy" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" href="BXAction.aspx?dh=<%#Eval("bx_dh") %>">
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd f-gray">
                                                    <label class="weui-form-preview__label"><%# Right(Eval("bx_dh").ToString(),7)%></label>
                                                    <span><%#Eval("bx_sbname") + " " + Eval("bx_moju_no")%></span>
                                                    <span class="weui-mark-rt- weui-badge" style="background-color: <%# Eval("level").ToString()=="一级"?"#10AEFF":"#FA5151"%>; font-size:x-small; color: white"><%#Eval("level") %></span>
                                                    <span class="weui-form-preview__value"><%#  Eval("moju_repair")+" "+Eval("bx_gz_type")+" "+Eval("bx_gz_desc")%></span>
                                                    <span class="weui-agree__text" style="font-size: smaller"><%#Eval("cellphone")+" "+Eval("bx_name")+" "+Eval("bx_date","{0:MM-dd HH:mm}")+  " 时长:<font class='f-blue'> "+Eval("bx_shichang")+"</font>"%></span>

                                                </div>
                                                <div class="weui-cell__ft">
                                                </div>
                                            </a>

                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                        <div id="tab22" class="weui-tab__content">
                            <%---发起人的工单----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title   ">发起人的工单 </div>
                                <div class="weui-cells" id="myorder">
                                    <asp:Repeater runat="server" ID="listMyOrder" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" href="BXAction.aspx?dh=<%#Eval("bx_dh") %>">
                                            <div class="weui-cell__hd">
                                                <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                            </div>
                                            <div class="weui-cell__bd">
                                                <label class="weui-form-preview__label"><%#Eval("bx_dh").ToString()%></label>
                                                <span><%#Eval("bx_sbname") + " " + Eval("bx_moju_type")%></span>
                                                <span class="weui-mark-rt- weui-badge"  style="background-color:<%# Eval("level").ToString()=="一级"?"#10AEFF":"#FA5151"%>;font-size:x-small;color:white  "><%#Eval("level") %></span>
                                                <span class="weui-form-preview__value"><%#Eval("bx_gz_type")+" "+Eval("bx_gz_desc")%></span>
                                                <span class="weui-agree__text"  style="font-size:smaller "><%#Eval("cellphone")+" "+Eval("bx_name")+" "+Eval("bx_date","{0:MM-dd HH:mm}")+  " 时长: "+Eval("bx_shichang")%> </span>
                                                 
                                            </div>
                                            <div class="weui-cell__ft">                                                
                                            </div>
                                        </a>                                    

                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                             </div>
                            <%-----已分配的工单----%>
                            <div class="weui-form-preview">
                                <div class="weui-cells__title   ">已分配的工单 </div>
                                <div class="weui-cells" id="mywork">
                                    <asp:Repeater runat="server" ID="listMyWork" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" href="BXAction.aspx?dh=<%#Eval("bx_dh") %>">
                                            <div class="weui-cell__hd">
                                                <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                            </div>
                                            <div class="weui-cell__bd">
                                                <label class="weui-form-preview__label"><%#Eval("bx_dh").ToString()%></label>
                                                <span><%#Eval("bx_sbname") + " " + Eval("bx_moju_type")%></span>
                                                <span class="weui-mark-rt- weui-badge"  style="background-color:<%# Eval("level").ToString()=="一级"?"#10AEFF":"#FA5151"%>;font-size:x-small;color:white  "><%#Eval("level") %></span>
                                                <span class="weui-form-preview__value"><%#Eval("bx_gz_type")+" "+Eval("bx_gz_desc")%></span>
                                                <span class="weui-agree__text"  style="font-size:smaller "><%#Eval("cellphone")+" "+Eval("bx_name")+" "+Eval("bx_date","{0:MM-dd HH:mm}")+  " 时长: "+Eval("bx_shichang")%> </span>
                                                
                                            </div>
                                            <div class="weui-cell__ft">                                                
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

            });</script>
    </form>
</body>
</html>
