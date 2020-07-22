<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Ruku_bcp_list_ck.aspx.cs" Inherits="WorkOrder_Ruku_bcp_list_ck" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><%=Request["workshop"] %>生产监视</title>
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

            $('.collapse2 .js-category2').click(function () {
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
                    //$.post("../php/page.php", { "page": 1, "pagesize": 8, ajax: 2 }, function (rs) {
                    //    $("#rank-list").html(tpl(document.getElementById('tpl').innerHTML, rs));
                    //}, 'json')
                    window.location.reload();
                    $(document.body).pullToRefreshDone();
                }
            });

           

            $('#searchInput').bind('input propertychange', function () {

                var text = $("#searchInput").val().toUpperCase();
                $('.weui-cell').each(function () {
                    var $self = $(this);
                    var flag = $self.text().search(text)
                    if (flag > -1) {
                        $self.removeClass("hide");
                        $self.siblings('.weui-cells__title').addClass("hide");
                       // $self.closest('li').children(".js-category").css("display", "none");//js-category
                    } else {
                        $self.addClass("hide");
                        $self.siblings('.weui-cells__title').addClass("hide");
                       // $self.closest('li').children(".js-category").css("display", "none");//js-category
                    }
                    
                    $self.closest('li .LH').children(".js-category2").css("display", "none");//js-category
                });


                showBlockCount();

                $(".a_body").css("display", "");//显示内容 a
            });

        })
        //显示数量
        function showBlockCount() {
            $(".weui-form-preview").each(function (i, item) {//>.weui-cells
                //var rowcount = $(this).find("a:not(.hide)").length;
                //// debugger;
                //var obj = $(item).prev().children().last();
                //$(obj).text(rowcount);
                //if (rowcount == 0) {
                //    $(obj).addClass("bg-gray").removeClass("bg-blue")
                //}
                //else {
                //    $(obj).addClass("bg-blue").removeClass("bg-gray")
                //}
            });
        }

        function cancel() {
            //$('.weui-cell').removeClass("hide");
            //$('.weui-cell').siblings('.weui-cells__title').removeClass("hide");
             
            //$('ul li ul li').children(".js-category2").css("display", "")
            showBlockCount();
        }

        function clear() {
            $('#searchInput').val('');
            //$('.weui-cell').removeClass("hide");
            //$('.weui-cell').siblings('.weui-cells__title').removeClass("hide");
            //$('ul li ul li').children(".js-category2").css("display", "")
            showBlockCount();
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
                <span>请输入查看的关键字</span>
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
                                    System.Data.DataTable dt_line = ViewState["dt_data"] as System.Data.DataTable;
                                    System.Data.DataView dataView = dt_line.DefaultView;
                                    System.Data.DataTable dtLineDistinct = dataView.ToTable(true, "line");
                                    System.Data.DataTable dtLineDistinct_2 = dataView.ToTable(true, "line","pgino");
                                    foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                    {
                                        string line = drLine["line"].ToString();
                                        int rowscount = dt_line.Select("line='" + line + "'").Count();
                                        int rowscount_2 = dtLineDistinct_2.Select("line='" + line + "'").Count();
                                        string Avg_ss_2=string.Format("{0:N0}",Convert.ToDecimal(dt_line.Compute("Avg(minss)"
                                            ,"line='" + line + "'"))/60);
                                %>
                                <ul class="collapse">
                                    <li>
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>
                                                <%=line+",产品数"+rowscount_2+",<font class=f-blue>Lot"+rowscount
                                                        +"</font>,<font class=f-orange>时长"+Avg_ss_2+"h</font>" %>
                                               <%-- <span class="weui-badge  bg-<% =(rowscount==0?"gray":"blue") %> margin20-l " 
                                                    style="margin-right: 15px;"><% =rowscount %></span>--%>
                                            </div>
                                            <i class="icon icon-74"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells">
                                                <%                                          
                                                    System.Data.DataTable dtLineDistinct_p = dataView.ToTable(true,"line", "pgino", "pn");
                                                    foreach (System.Data.DataRow drpgino in dtLineDistinct_p.Rows)
                                                    {
                                                        string pgino = drpgino["pgino"].ToString();
                                                        string pn = drpgino["pn"].ToString();
                                                        int rowscount_p = dt_line.Select("line='" + line + "'and pgino='" + pgino 
                                                            + "'and pn='" + pn + "'").Count();
                                                        if (rowscount_p <= 0) continue;
                                                        string sum_qty=dt_line.Compute("Sum(act_qty)"
                                                            ,"line='" + line + "'and pgino='" + pgino + "'and pn='" + pn + "'").ToString();
                                                        string Avg_ss=string.Format("{0:N0}",Convert.ToDecimal(dt_line.Compute("Avg(minss)"
                                                            ,"line='" + line + "'and pgino='" + pgino + "'and pn='" + pn + "'"))/60);
                                                %>
                                                <ul class="collapse2 ">
                                                    <li class=" LH " style="margin-top: 0px; margin-bottom: 0px">
                                                        <div class="weui-flex js-category2 " onclick="showorhide(this);">
                                                            <div class="weui-cells__title weui-flex__item LH" id="<%=pgino %>LH5">
                                                                <i class="icon nav-icon icon-22 color-success"></i>
                                                                <%=pgino+"," +pn +","+sum_qty+"件,"+rowscount_p+"托,时长"+Avg_ss+"h"%>
                                                                <%--<span class="weui-badge bg-blue margin20-l " style="margin-right: 15px;">
                                                                    <% =rowscount_p %>
                                                                </span>--%>
                                                            </div>
                                                            <i class="icon icon-74 right"></i>
                                                        </div>
                                                        <div class="page-category js-categoryInner a_body" style="display: none">
                                                            <%                                                  
                                                                foreach (System.Data.DataRow dr in 
                                                                    dt_line.Select("line='" + line + "'and pgino='" + pgino 
                                                                    + "'and pn='" + pn + "'"))
                                                                { 
                                                                    %>
                                                            <a class="weui-cell  weui-cell_access " style="color: black">
                                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                                                <div class="weui-cell__hd">
                                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                </div>
                                                                <div class="weui-cell__bd " style="font-size: smaller">
                                                                    <%=dr["workorder"]+","+dr["act_qty"]+"件,"+dr["loc_hg"]
                                                                        +","+string.Format("{0:MM-dd HH:mm}",dr["create_date"])%> 
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
                                                                    <%--<span class="margin10-r">
                                                                        <%=dr["workorder"] %> 
                                                                    </span>
                                                                    <span class="margin10-r">
                                                                        <%=dr["act_qty"] %>件
                                                                    </span>
                                                                    <span class="margin10-r">
                                                                        <%=dr["loc_hg"] %>
                                                                    </span>
                                                                    <br />
                                                                    <span class="margin10-r">
                                                                        <%=string.Format("{0:MM-dd HH:mm}",dr["create_date"]) %>
                                                                    </span>
                                                                    <span class="margin10-r">
                                                                        时长: <font class="f-blue"><%=dr["times"] %></font>
                                                                    </span>--%>
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