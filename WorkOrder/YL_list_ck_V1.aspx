<%@ Page Language="C#" AutoEventWireup="true" CodeFile="YL_list_ck_V1.aspx.cs" Inherits="WorkOrder_YL_list_ck_V1" %>

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

                $(".lined").show("fast");

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
                        $self.removeClass("hide");
                    } else {
                        $self.addClass("hide");

                    }
                });

                $(".line").css("display", "none");

                showBlockCount();
            });
        });
        //显示数量
        function showBlockCount() {
            $(".select").each(function (i, item) {
                var rowcount = $(this).find("a:not(.hide)").length;
                // debugger;
                var obj = $(item).parent().prev().children().children('span');
                $(obj).text(rowcount);
                if (rowcount == 0) {
                    $(obj).addClass("bg-gray").removeClass("bg-blue").removeClass("bg-orange");
                }
                else {
                    if (this.id == "_wc_2" || this.id == "_wc_3" || this.id == "_wc_4"
                        || this.id == "_rj_2" || this.id == "_rj_3" || this.id == "_rj_4") {
                        $(obj).addClass("bg-orange").removeClass("bg-gray");
                    } else {
                        $(obj).addClass("bg-blue").removeClass("bg-gray");
                    }
                }
            });
        }

        function cancel() {
            $('.weui-cell').removeClass("hide");
            $(".lined").hide(); $(".line").css("display", "");
            showBlockCount();

            $('.weui-cell').each(function () {
                var $self = $(this);
                $parent = $self.parents('li');
                $parent.removeClass('js-show');
                $(this).children('i').removeClass('icon-35').addClass('icon-74');
            });
        }

        function clear() {
            $('#searchInput').val('');
            $('.weui-cell').removeClass("hide");
            $(".lined").hide(); $(".line").css("display", "");
            showBlockCount();

            $('.weui-cell').each(function () {
                var $self = $(this);
                $parent = $self.parents('li');
                $parent.removeClass('js-show');
                $(this).children('i').removeClass('icon-35').addClass('icon-74');
            });
        }
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
    <script>
        function deal_rej(lot_no, need_no, reject_where, workshop) {
            if (reject_where == "线边库") {
                window.location.href = "Load_Material.aspx?lotno=" + lot_no + "&need_no=" + need_no + "&workshop=" + workshop + "&para=T"
            }
            if (reject_where == "仓库") {
                window.location.href = "Sure_Material.aspx?lotno=" + lot_no + "&need_no=" + need_no + "&workshop=" + workshop
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
        
        <%----二车间 要料中-----%>
        <div class="weui-form-preview">
            <ul class="collapse">
                <li>
                    <div class="weui-flex js-category">
                        <div class="weui-cells__title fl weui-flex__item">
                            <i class="icon nav-icon icon-49"></i>二车间 要料中
                            <span class="weui-badge  bg-<% =(count_go_2==0?"gray":"blue") %>"><% =count_go_2 %></span>
                        </div>
                        <i class="icon icon-74"></i>
                    </div>
                    <div class="page-category js-categoryInner">
                        <div class="weui-cells select" id="_go_2">
                            <asp:Repeater runat="server" ID="list_go_2_line" EnableTheming="False" OnItemDataBound="list_go_2_line_ItemDataBound">
                                <ItemTemplate>
                                    <ul class="collapse">
                                        <li style="margin-top:0px;margin-bottom:0px">
                                            <div class="weui-flex js-category line" onclick="showorhide(this);">
                                                <div class="weui-cells__title  weui-flex__item">
                                                    <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("line_a") %></span>
                                                    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                </div>
                                                <i class="icon icon-74"></i>
                                            </div>
                                            <div class="page-category js-categoryInner lined" style="display: none">
                                                <div class="weui-cells"> 
                                                    <asp:Repeater runat="server" ID="list_go_2" EnableTheming="False">
                                                        <ItemTemplate>
                                                            <a class="weui-cell weui-cell_access" 
                                                                href="SL.aspx?need_no=<%#Eval("need_no") %>&workshop=<%# Eval("workshop") %>">
                                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-green"></span></div>
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

        <div class="weui-form-preview">
            <ul class="collapse">
                <li>
                    <div class="weui-flex js-category">
                        <div class="weui-cells__title fl weui-flex__item">
                            <i class="icon nav-icon icon-49"></i>二车间 已送料
                            <span class="weui-badge  bg-<% =(count_wc_2==0?"gray":"orange") %>"><% =count_wc_2 %></span>
                        </div>
                        <i class="icon icon-74"></i>
                    </div>
                    <div class="page-category js-categoryInner">
                        <div class="weui-cells select" id="_wc_2">
                            <asp:Repeater runat="server" ID="list_wc_2_line" EnableTheming="False" OnItemDataBound="list_wc_2_line_ItemDataBound">
                                <ItemTemplate>
                                    <ul class="collapse">
                                        <li style="margin-top:0px;margin-bottom:0px">
                                            <div class="weui-flex js-category line" onclick="showorhide(this);">
                                                <div class="weui-cells__title  weui-flex__item">
                                                    <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("line") %></span>
                                                    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                </div>
                                                <i class="icon icon-74"></i>
                                            </div>
                                            <div class="page-category js-categoryInner lined" style="display: none">
                                                <div class="weui-cells"> 
                                                    <asp:Repeater runat="server" ID="list_wc_2" EnableTheming="False">
                                                        <ItemTemplate>
                                                            <a class="weui-cell weui-cell_access" 
                                                                href="Load_Material.aspx?lotno=<%#Eval("lot_no") %>&need_no=<%#Eval("need_no") %>&workshop=<%#Eval("workshop") %>&para=S">
                                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-blue"></span></div>
                                                                <div class="weui-cell__bd">
                                                                    <span class="weui-form-preview__value" style="font-size: smaller">
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
                                                                        <%# Eval("phone")+" "+Eval("emp_name")+" "+Eval("need_date","{0:MM-dd HH:mm}")+ " " %>   
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
                </li>
            </ul>
        </div>       

        <div class="weui-form-preview">
            <ul class="collapse">
                <li>
                    <div class="weui-flex js-category">
                        <div class="weui-cells__title fl weui-flex__item">
                            <i class="icon nav-icon icon-49"></i>二车间 已退料
                            <span class="weui-badge  bg-<% =(count_rj_2==0?"gray":"orange") %>"><% =count_rj_2 %></span>
                        </div>
                        <i class="icon icon-74"></i>
                    </div>
                    <div class="page-category js-categoryInner">
                        <div class="weui-cells select" id="_rj_2">
                            <asp:Repeater runat="server" ID="list_rj_2_line" EnableTheming="False" OnItemDataBound="list_rj_2_line_ItemDataBound">
                                <ItemTemplate>
                                    <ul class="collapse">
                                        <li style="margin-top:0px;margin-bottom:0px">
                                            <div class="weui-flex js-category line" onclick="showorhide(this);">
                                                <div class="weui-cells__title  weui-flex__item">
                                                    <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("line") %></span>
                                                    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                </div>
                                                <i class="icon icon-74"></i>
                                            </div>
                                            <div class="page-category js-categoryInner lined" style="display: none">
                                                <div class="weui-cells"> 
                                                    <asp:Repeater runat="server" ID="list_rj_2" EnableTheming="False">
                                                        <ItemTemplate>
                                                            <a class="weui-cell weui-cell_access"  onclick=deal_rej('<%# Eval("lot_no") %>','<%# Eval("need_no") %>','<%# Eval("reject_where") %>','<%# Eval("workshop") %>') >
                                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-danger"></span></div>
                                                                <div class="weui-cell__bd">
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
                </li>
            </ul>
        </div>        

        <div class="weui-form-preview">
            <ul class="collapse">
                <li>
                    <div class="weui-flex js-category">
                        <div class="weui-cells__title fl weui-flex__item">
                            <i class="icon nav-icon icon-49"></i>二车间 要料完成(24h内)
                            <span class="weui-badge  bg-<% =(count_end_2==0?"gray":"blue") %>"><% =count_end_2 %></span>
                        </div>
                        <i class="icon icon-74"></i>
                    </div>
                    <div class="page-category js-categoryInner">
                        <div class="weui-cells select" id="_end_2">
                            <asp:Repeater runat="server" ID="list_end_2_line" EnableTheming="False" OnItemDataBound="list_end_2_line_ItemDataBound">
                                <ItemTemplate>
                                    <ul class="collapse">
                                        <li style="margin-top:0px;margin-bottom:0px">
                                            <div class="weui-flex js-category line" onclick="showorhide(this);">
                                                <div class="weui-cells__title  weui-flex__item">
                                                    <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("line") %></span>
                                                    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                </div>
                                                <i class="icon icon-74"></i>
                                            </div>
                                            <div class="page-category js-categoryInner lined" style="display: none">
                                                <div class="weui-cells"> 
                                                    <asp:Repeater runat="server" ID="list_end_2" EnableTheming="False">
                                                        <ItemTemplate>
                                                            <a class="weui-cell weui-cell_access" 
                                                                href="YL_Detail_Info.aspx?need_no=<%# Eval("need_no")%>">
                                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                                                <div class="weui-cell__bd">
                                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                                        <%# Eval("workshop") + "/" + Eval("line") + "/" +Eval("location")  %>
                                                                    </span>
                                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                                        <%#   Eval("pgino")+","+Eval("pn")+","+Eval("act_qty") +"件" %>
                                                                    </span>
                                                                    <span class="weui-agree__text" style="font-size: smaller">
                                                                        <%# Eval("phone")+" "+Eval("emp_name")+" "+Eval("b_on_m_date","{0:MM-dd HH:mm}")+ " " %>   
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
                </li>
            </ul>
        </div>                             
        
        
        <%----三车间 要料中-----%>
        <div class="weui-form-preview">
            <ul class="collapse">
                <li>
                    <div class="weui-flex js-category">
                        <div class="weui-cells__title fl weui-flex__item">
                            <i class="icon nav-icon icon-49"></i>三车间 要料中
                            <span class="weui-badge  bg-<% =(count_go_3==0?"gray":"blue") %>"><% =count_go_3 %></span>
                        </div>
                        <i class="icon icon-74"></i>
                    </div>
                    <div class="page-category js-categoryInner">
                        <div class="weui-cells select" id="_go_3">
                            <asp:Repeater runat="server" ID="list_go_3_line" EnableTheming="False" OnItemDataBound="list_go_3_line_ItemDataBound">
                                <ItemTemplate>
                                    <ul class="collapse">
                                        <li style="margin-top:0px;margin-bottom:0px">
                                            <div class="weui-flex js-category line" onclick="showorhide(this);">
                                                <div class="weui-cells__title  weui-flex__item">
                                                    <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("line_a") %></span>
                                                    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                </div>
                                                <i class="icon icon-74"></i>
                                            </div>
                                            <div class="page-category js-categoryInner lined" style="display: none">
                                                <div class="weui-cells"> 
                                                    <asp:Repeater runat="server" ID="list_go_3" EnableTheming="False">
                                                        <ItemTemplate>
                                                            <a class="weui-cell weui-cell_access" 
                                                                href="SL.aspx?need_no=<%#Eval("need_no") %>&workshop=<%# Eval("workshop") %>">
                                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-green"></span></div>
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

        <div class="weui-form-preview">
            <ul class="collapse">
                <li>
                    <div class="weui-flex js-category">
                        <div class="weui-cells__title fl weui-flex__item">
                            <i class="icon nav-icon icon-49"></i>三车间 已送料
                            <span class="weui-badge  bg-<% =(count_wc_3==0?"gray":"orange") %>"><% =count_wc_3 %></span>
                        </div>
                        <i class="icon icon-74"></i>
                    </div>
                    <div class="page-category js-categoryInner">
                        <div class="weui-cells select" id="_wc_3">
                            <asp:Repeater runat="server" ID="list_wc_3_line" EnableTheming="False" OnItemDataBound="list_wc_3_line_ItemDataBound">
                                <ItemTemplate>
                                    <ul class="collapse">
                                        <li style="margin-top:0px;margin-bottom:0px">
                                            <div class="weui-flex js-category line" onclick="showorhide(this);">
                                                <div class="weui-cells__title  weui-flex__item">
                                                    <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("line") %></span>
                                                    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                </div>
                                                <i class="icon icon-74"></i>
                                            </div>
                                            <div class="page-category js-categoryInner lined" style="display: none">
                                                <div class="weui-cells"> 
                                                    <asp:Repeater runat="server" ID="list_wc_3" EnableTheming="False">
                                                        <ItemTemplate>
                                                            <a class="weui-cell weui-cell_access" 
                                                                href="Load_Material.aspx?lotno=<%#Eval("lot_no") %>&need_no=<%#Eval("need_no") %>&workshop=<%#Eval("workshop") %>&para=S">
                                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-blue"></span></div>
                                                                <div class="weui-cell__bd">
                                                                    <span class="weui-form-preview__value" style="font-size: smaller">
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
                                                                        <%# Eval("phone")+" "+Eval("emp_name")+" "+Eval("need_date","{0:MM-dd HH:mm}")+ " " %>   
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
                </li>
            </ul>
        </div>         

        <div class="weui-form-preview">
            <ul class="collapse">
                <li>
                    <div class="weui-flex js-category">
                        <div class="weui-cells__title fl weui-flex__item">
                            <i class="icon nav-icon icon-49"></i>三车间 已退料
                            <span class="weui-badge  bg-<% =(count_rj_3==0?"gray":"orange") %>"><% =count_rj_3 %></span>
                        </div>
                        <i class="icon icon-74"></i>
                    </div>
                    <div class="page-category js-categoryInner">
                        <div class="weui-cells select" id="_rj_3">
                            <asp:Repeater runat="server" ID="list_rj_3_line" EnableTheming="False" OnItemDataBound="list_rj_3_line_ItemDataBound">
                                <ItemTemplate>
                                    <ul class="collapse">
                                        <li style="margin-top:0px;margin-bottom:0px">
                                            <div class="weui-flex js-category line" onclick="showorhide(this);">
                                                <div class="weui-cells__title  weui-flex__item">
                                                    <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("line") %></span>
                                                    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                </div>
                                                <i class="icon icon-74"></i>
                                            </div>
                                            <div class="page-category js-categoryInner lined" style="display: none">
                                                <div class="weui-cells"> 
                                                    <asp:Repeater runat="server" ID="list_rj_3" EnableTheming="False">
                                                        <ItemTemplate>
                                                            <a class="weui-cell weui-cell_access"  onclick=deal_rej('<%# Eval("lot_no") %>','<%# Eval("need_no") %>','<%# Eval("reject_where") %>','<%# Eval("workshop") %>') >
                                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-danger"></span></div>
                                                                <div class="weui-cell__bd">
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
                </li>
            </ul>
        </div>           

        <div class="weui-form-preview">
            <ul class="collapse">
                <li>
                    <div class="weui-flex js-category">
                        <div class="weui-cells__title fl weui-flex__item">
                            <i class="icon nav-icon icon-49"></i>三车间 要料完成(24h内)
                            <span class="weui-badge  bg-<% =(count_end_3==0?"gray":"blue") %>"><% =count_end_3 %></span>
                        </div>
                        <i class="icon icon-74"></i>
                    </div>
                    <div class="page-category js-categoryInner">
                        <div class="weui-cells select" id="_end_3">
                            <asp:Repeater runat="server" ID="list_end_3_line" EnableTheming="False" OnItemDataBound="list_end_3_line_ItemDataBound">
                                <ItemTemplate>
                                    <ul class="collapse">
                                        <li style="margin-top:0px;margin-bottom:0px">
                                            <div class="weui-flex js-category line" onclick="showorhide(this);">
                                                <div class="weui-cells__title  weui-flex__item">
                                                    <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("line") %></span>
                                                    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                </div>
                                                <i class="icon icon-74"></i>
                                            </div>
                                            <div class="page-category js-categoryInner lined" style="display: none">
                                                <div class="weui-cells"> 
                                                    <asp:Repeater runat="server" ID="list_end_3" EnableTheming="False">
                                                        <ItemTemplate>
                                                            <a class="weui-cell weui-cell_access" 
                                                                href="YL_Detail_Info.aspx?need_no=<%# Eval("need_no")%>">
                                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                                                <div class="weui-cell__bd">
                                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                                        <%# Eval("workshop") + "/" + Eval("line") + "/" +Eval("location")  %>
                                                                    </span>
                                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                                        <%#   Eval("pgino")+","+Eval("pn")+","+Eval("act_qty") +"件" %>
                                                                    </span>
                                                                    <span class="weui-agree__text" style="font-size: smaller">
                                                                        <%# Eval("phone")+" "+Eval("emp_name")+" "+Eval("b_on_m_date","{0:MM-dd HH:mm}")+ " " %>   
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
                </li>
            </ul>
        </div>     
        
        <%----四车间 要料中-----%>
        <div class="weui-form-preview">
            <ul class="collapse">
                <li>
                    <div class="weui-flex js-category">
                        <div class="weui-cells__title fl weui-flex__item">
                            <i class="icon nav-icon icon-49"></i>四车间 要料中
                            <span class="weui-badge  bg-<% =(count_go_4==0?"gray":"blue") %>"><% =count_go_4 %></span>
                        </div>
                        <i class="icon icon-74"></i>
                    </div>
                    <div class="page-category js-categoryInner">
                        <div class="weui-cells select" id="_go_4">
                            <asp:Repeater runat="server" ID="list_go_4_line" EnableTheming="False" OnItemDataBound="list_go_4_line_ItemDataBound">
                                <ItemTemplate>
                                    <ul class="collapse">
                                        <li style="margin-top:0px;margin-bottom:0px">
                                            <div class="weui-flex js-category line" onclick="showorhide(this);">
                                                <div class="weui-cells__title  weui-flex__item">
                                                    <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("line_a") %></span>
                                                    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                </div>
                                                <i class="icon icon-74"></i>
                                            </div>
                                            <div class="page-category js-categoryInner lined" style="display: none">
                                                <div class="weui-cells"> 
                                                    <asp:Repeater runat="server" ID="list_go_4" EnableTheming="False">
                                                        <ItemTemplate>
                                                            <a class="weui-cell weui-cell_access" 
                                                                href="SL.aspx?need_no=<%#Eval("need_no") %>&workshop=<%# Eval("workshop") %>">
                                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-green"></span></div>
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

        <div class="weui-form-preview">
            <ul class="collapse">
                <li>
                    <div class="weui-flex js-category">
                        <div class="weui-cells__title fl weui-flex__item">
                            <i class="icon nav-icon icon-49"></i>四车间 已送料
                            <span class="weui-badge  bg-<% =(count_wc_4==0?"gray":"orange") %>"><% =count_wc_4 %></span>
                        </div>
                        <i class="icon icon-74"></i>
                    </div>
                    <div class="page-category js-categoryInner">
                        <div class="weui-cells select" id="_wc_4">
                            <asp:Repeater runat="server" ID="list_wc_4_line" EnableTheming="False" OnItemDataBound="list_wc_4_line_ItemDataBound">
                                <ItemTemplate>
                                    <ul class="collapse">
                                        <li style="margin-top:0px;margin-bottom:0px">
                                            <div class="weui-flex js-category line" onclick="showorhide(this);">
                                                <div class="weui-cells__title  weui-flex__item">
                                                    <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("line") %></span>
                                                    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                </div>
                                                <i class="icon icon-74"></i>
                                            </div>
                                            <div class="page-category js-categoryInner lined" style="display: none">
                                                <div class="weui-cells"> 
                                                    <asp:Repeater runat="server" ID="list_wc_4" EnableTheming="False">
                                                        <ItemTemplate>
                                                            <a class="weui-cell weui-cell_access" 
                                                                href="Load_Material.aspx?lotno=<%#Eval("lot_no") %>&need_no=<%#Eval("need_no") %>&workshop=<%#Eval("workshop") %>&para=S">
                                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-blue"></span></div>
                                                                <div class="weui-cell__bd">
                                                                    <span class="weui-form-preview__value" style="font-size: smaller">
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
                                                                        <%# Eval("phone")+" "+Eval("emp_name")+" "+Eval("need_date","{0:MM-dd HH:mm}")+ " " %>   
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
                </li>
            </ul>
        </div>         

        <div class="weui-form-preview">
            <ul class="collapse">
                <li>
                    <div class="weui-flex js-category">
                        <div class="weui-cells__title fl weui-flex__item">
                            <i class="icon nav-icon icon-49"></i>四车间 已退料
                            <span class="weui-badge  bg-<% =(count_rj_4==0?"gray":"orange") %>"><% =count_rj_4 %></span>
                        </div>
                        <i class="icon icon-74"></i>
                    </div>
                    <div class="page-category js-categoryInner">
                        <div class="weui-cells select" id="_rj_4">
                            <asp:Repeater runat="server" ID="list_rj_4_line" EnableTheming="False" OnItemDataBound="list_rj_4_line_ItemDataBound">
                                <ItemTemplate>
                                    <ul class="collapse">
                                        <li style="margin-top:0px;margin-bottom:0px">
                                            <div class="weui-flex js-category line" onclick="showorhide(this);">
                                                <div class="weui-cells__title  weui-flex__item">
                                                    <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("line") %></span>
                                                    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                </div>
                                                <i class="icon icon-74"></i>
                                            </div>
                                            <div class="page-category js-categoryInner lined" style="display: none">
                                                <div class="weui-cells"> 
                                                    <asp:Repeater runat="server" ID="list_rj_4" EnableTheming="False">
                                                        <ItemTemplate>
                                                            <a class="weui-cell weui-cell_access"  onclick=deal_rej('<%# Eval("lot_no") %>','<%# Eval("need_no") %>','<%# Eval("reject_where") %>','<%# Eval("workshop") %>') >
                                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-danger"></span></div>
                                                                <div class="weui-cell__bd">
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
                </li>
            </ul>
        </div>             

        <div class="weui-form-preview">
            <ul class="collapse">
                <li>
                    <div class="weui-flex js-category">
                        <div class="weui-cells__title fl weui-flex__item">
                            <i class="icon nav-icon icon-49"></i>四车间 要料完成(24h内)
                            <span class="weui-badge  bg-<% =(count_end_4==0?"gray":"blue") %>"><% =count_end_4 %></span>
                        </div>
                        <i class="icon icon-74"></i>
                    </div>
                    <div class="page-category js-categoryInner">
                        <div class="weui-cells select" id="_end_4">
                            <asp:Repeater runat="server" ID="list_end_4_line" EnableTheming="False" OnItemDataBound="list_end_4_line_ItemDataBound">
                                <ItemTemplate>
                                    <ul class="collapse">
                                        <li style="margin-top:0px;margin-bottom:0px">
                                            <div class="weui-flex js-category line" onclick="showorhide(this);">
                                                <div class="weui-cells__title  weui-flex__item">
                                                    <i class="icon nav-icon icon-22 color-success"></i><span id="line_s"><%# Eval("line") %></span>
                                                    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                </div>
                                                <i class="icon icon-74"></i>
                                            </div>
                                            <div class="page-category js-categoryInner lined" style="display: none">
                                                <div class="weui-cells"> 
                                                    <asp:Repeater runat="server" ID="list_end_4" EnableTheming="False">
                                                        <ItemTemplate>
                                                            <a class="weui-cell weui-cell_access" 
                                                                href="YL_Detail_Info.aspx?need_no=<%# Eval("need_no")%>">
                                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                                                <div class="weui-cell__bd">
                                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                                        <%# Eval("workshop") + "/" + Eval("line") + "/" +Eval("location")  %>
                                                                    </span>
                                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                                        <%#   Eval("pgino")+","+Eval("pn")+","+Eval("act_qty") +"件" %>
                                                                    </span>
                                                                    <span class="weui-agree__text" style="font-size: smaller">
                                                                        <%# Eval("phone")+" "+Eval("emp_name")+" "+Eval("b_on_m_date","{0:MM-dd HH:mm}")+ " " %>   
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
                </li>
            </ul>
        </div>                

        <div class="weui-footer weui-footer_fixed-bottom">
            <%--<p class="weui-footer__links">
                <a href="../index.html" class="weui-footer__link">WeUI首页</a>
            </p>--%>
            <%--<p class="weui-footer__text"><%=WeiXin.GetCookie("workcode") +((LoginUser)WeiXin.GetJsonCookie()).UserName %></p>--%>
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
