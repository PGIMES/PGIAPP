﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Ruku_ycl_list_ck.aspx.cs" Inherits="Ruku_ycl_list_ck" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>原材料库</title>
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

        .span_space {
            padding-right: 20px;
        }

        .weui-badge-tr {
            border: 1px solid orange;
            background-color: transparent;
            color: orange;
        }

        .f-deepfont {
            color: blue;
        }
        .collapse li.js-show .weui-flex {
            opacity: 0.8;
        }
        .collapse .weui-flex {     
            padding:0px 10px 0px 10px; 
                 
        }
        .bg-orange{background-color:orange}
        .weui-cells__title{padding-left:0px;padding-right:0px;color:#696969}
    </style>

    <script src="../js/zepto.min.js"></script>
    <script src="../js/zepto.weui.js"></script>
    <script src="../js/iscroll-lite.js"></script>

    <script>

        $(function () {

            //// var _index = window.localStorage.getItem("_tabindex");
            $('#t2').tab({
                defaultIndex: 0,// _index == null ? 0 : _index,
                activeClass: 'tab-green',
                onToggle: function (index) {
                    //console.log('index' + index);
                }
            })

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
                distance: 20,
                onRefresh: function () {
                    window.location.reload();
                    $(document.body).pullToRefreshDone();
                }
            });

            $('#searchInput').bind('input propertychange', function () {

                var text = $("#searchInput").val();
                $('.select').each(function () {
                    var $self = $(this);

                    $parent = $self.parents('li');
                    $parent.siblings().removeClass('js-show');
                    $parent.addClass('js-show');
                    $(this).children('i').removeClass('icon-74').addClass('icon-35');
                    $parent.siblings().find('i').removeClass('icon-35').addClass('icon-74');



                    var flag = $self.text().search(text)
                    if (flag > -1) {
                        $self.removeClass("hide");
                    } else {
                        $self.addClass("hide"); 
                    }
                });


                $(".line_par").css("display", "none");
            });


        });

        function cancel() {
            $(".line_par").css("display", "");

            $('.select').removeClass("hide");
        }

        function clear() {
            $(".line_par").css("display", "");

            $('#searchInput').val('');
            $('.select').removeClass("hide");
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
</head>
<body ontouchstart >
   

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
                <span>请输入查看的物料号、零件号</span>
            </label>
        </form>
        <a href="javascript:cancel()" class="weui-search-bar__cancel-btn" style="color:#09bb07" id="searchCancel">取消</a>
    </div>

    <form id="form1" runat="server">
        <div class="page">
            
            <div class="page__bd" id="t2" style="height: 100%;">
                <div class="weui-tab">
                    
                    <div class="weui-tab__panel" style="background-color: lightgray">                         
                        <div id="tab1" class="weui-tab__content">

                            <div class="weui-form-preview">
                                <%
                                    foreach (System.Data.DataRow drLine in dt_line.Rows)
                                    {
                                %>
                                <ul class="collapse">
                                    <li> <%--class="js-show"--%>
                                        <div class="weui-flex js-category line_par">
                                            <div class="weui-cells__title weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>
                                                <%= drLine["line"] %>

                                                <span class="weui-badge  bg-<% =(drLine["cps"].ToString()=="0"?"gray":"blue") %> margin10-l ">
                                                    <% =drLine["cps"]+"个" %>
                                                </span>   
                                                <span class="weui-badge  bg-<% =(drLine["sum_ts"].ToString()=="0"?"gray":"blue") %> margin10-l ">
                                                    <% =drLine["sum_ts"]+"托" %>
                                                </span>
                                                <span class="weui-badge  bg-<% =(drLine["avg_hhs"].ToString()=="0"?"gray":"orange") %> margin10-l ">
                                                    <% =(Convert.ToInt32(drLine["avg_hhs"])/24).ToString()+"天" %>
                                                </span>
                                            </div>
                                            <%--<i class="icon icon-35"></i>--%>
                                            <i class="icon icon-74 right"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells">
                                                <%                                          
                                                    foreach (System.Data.DataRow drpgino in dt_pgino.Select("line='" + drLine["line"].ToString() + "'"))
                                                    {
                                                %>
                                                <ul class="collapse select">
                                                    <li  style="margin-top: 0px; margin-bottom: 0px">
                                                        <div class="weui-flex js-category " onclick="showorhide(this);">
                                                            <div class="weui-cells__title weui-flex__item LH" id="<%=drpgino["pgino"] %>LH5">
                                                                <i class="icon nav-icon icon-22 color-success"></i>
                                                                <%= drpgino["pgino"]+","+drpgino["pn"] %>
                                                                <br />
                                                                <span style="padding-left:20px;">
                                                                   
                                                                <% if (Convert.ToSingle(drpgino["ts"]) >= 8) {%>
                                                                    <font class="f-red"><%=drpgino["ts"]+"托" %></font>
                                                                        <%}  %>
                                                                    <% else if (Convert.ToSingle(drpgino["ts"]) >= 4) {%>
                                                                    <font class="f-blue"><%=drpgino["ts"]+"托" %></font>
                                                                        <%}  %>
                                                                    <% else {%>
                                                                        <%=drpgino["ts"]+"托" %>
                                                                        <%}  %>

                                                                    <%= ","+Convert.ToSingle(drpgino["sum_qty"]).ToString()+"件"%>
                                                                    
                                                                     <%= ","%>

                                                                     <% if (Convert.ToInt32(drpgino["min_hhs"]) == Convert.ToInt32(drpgino["max_hhs"])) {%>
                                                                    -
                                                                        <%}  %>
                                                                    <% else if (Convert.ToInt32(drpgino["min_hhs"]) >= 120) {%>
                                                                    <font class="f-red"><%=drpgino["min_hhs"]+"h" %></font>
                                                                        <%}  %>
                                                                    <% else if (Convert.ToInt32(drpgino["min_hhs"]) >= 72) {%>
                                                                    <font class="f-blue"><%=drpgino["min_hhs"]+"h" %></font>
                                                                        <%}  %>
                                                                    <% else {%>
                                                                        <%=drpgino["min_hhs"]+"h" %>
                                                                        <%}  %>
                                                                     <%= ","%>
                                                                    <% if (Convert.ToInt32(drpgino["max_hhs"]) >= 120) {%>
                                                                    <font class="f-red"><%=drpgino["max_hhs"]+"h" %></font>
                                                                        <%}  %>
                                                                    <% else if (Convert.ToInt32(drpgino["max_hhs"]) >= 72) {%>
                                                                    <font class="f-blue"><%=drpgino["max_hhs"]+"h" %></font>
                                                                        <%}  %>
                                                                    <% else {%>
                                                                        <%=drpgino["max_hhs"]+"h" %>
                                                                        <%}  %>                                                                    
                                                                     <%= ",可用"%>                                                                    
                                                                    <font class="<% if (Convert.ToSingle(drpgino["day_s"]) >= 5) { Response.Write("f-red"); }
                                                                        else if (Convert.ToSingle(drpgino["day_s"]) >= 3) { Response.Write("f-blue"); }
                                                                         %>"><%=Convert.ToSingle(drpgino["day_s"]).ToString()+"天" %></font>
                                                                   
                                                                </span>
                                                                
                                                            </div>
                                                            <i class="icon icon-74 right"></i>
                                                        </div>
                                                        <div class="page-category js-categoryInner a_body" style="display: none">
                                                            <%                                                  
                                                                foreach (System.Data.DataRow dr in dt_detail.Select("line='" +  drLine["line"].ToString() 
                                                                    + "'and pgino='" +  drpgino["pgino"].ToString() + "'and pn='" +  drpgino["pn"].ToString() + "'"))
                                                                { 
                                                                    %>
                                                            <a class="weui-cell  weui-cell_access " style="color: black">
                                                                <%--<div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>--%>
                                                                <div class="weui-cell__hd">
                                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                </div>
                                                                <div class="weui-cell__bd " style="font-size: smaller">
                                                                    <%=dr["ld_ref"]+","+Convert.ToSingle(dr["qty"]).ToString()+"件,"+dr["ld_loc"]
                                                                        +","+string.Format("{0:MM-dd }",dr["ld_date"])%> 
                                                                    时长: 
                                                                    <% if (Convert.ToInt32(dr["hhs"]) >= 120) {%>
                                                                    <font class="f-red"><%=dr["times"] %></font>
                                                                        <%}  %>
                                                                    <% else if (Convert.ToInt32(dr["hhs"]) >= 72) {%>
                                                                    <font class="f-blue"><%=dr["times"] %></font>
                                                                        <%}  %>
                                                                    <% else {%>
                                                                        <%=dr["times"] %>
                                                                        <%}  %>
                                                                </div>
                                                            </a>
                                                            <% }%>
                                                        </div>
                                                    </li>
                                                </ul>
                                                <% 
                                                    }%>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                                <%  
                                    }%>
                            </div>
                            

                        </div>                         
                    </div>
                </div>
            </div>
        </div>
        

        <%--<div class="weui-footer weui-footer_fixed-bottom">
            <p class="weui-footer__text"><%=WeiXin.GetCookie("workcode") +((LoginUser)WeiXin.GetJsonCookie()).UserName %></p>
        </div>--%>
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