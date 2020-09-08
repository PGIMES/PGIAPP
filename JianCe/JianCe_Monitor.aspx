<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JianCe_Monitor.aspx.cs" Inherits="JianCe_Monitor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><%=Request["workshop"] %>检测监视</title>
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
            padding: 0px 10px 0px 10px;
        }

        .bg-orange {
            background-color: orange;
        }

        .weui-cells__title {
            padding-left: 0px;
            padding-right: 0px;
            color: #696969;
        }
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
                distance: 50,
                onRefresh: function () {
                    //$.post("../php/page.php", { "page": 1, "pagesize": 8, ajax: 2 }, function (rs) {
                    //    $("#rank-list").html(tpl(document.getElementById('tpl').innerHTML, rs));
                    //}, 'json')
                    window.location.reload();
                    $(document.body).pullToRefreshDone();
                }
            });

            //$("#search").keyup(function () {
            //    so();
            //})
            //showBlockCount();

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
        //搜索
        //function so() {
        //    var val =  $("#search").val().toUpperCase();
        //    if (val != "") {
        //        $("a").addClass("hide");                
        //        $("a").filter("[title*='" + val + "']").removeClass("hide");
        //        $(".LH").addClass("hide");
        //    }
        //    else {
        //        $("a").removeClass("hide");
        //        $(".LH").removeClass("hide");
        //    }            
        //    showBlockCount()
        //}
        //显示数量
        function showBlockCount() {
            $(".weui-form-preview .weui-cells").each(function (i, item) {
                var rowcount = $(this).find("a:not(.hide)").length;                 
                var iDuoci = $(this).find("a:not(.hide).duoci").length;
                var i2H = $(this).find("a:not(.hide).chaoshi").length;
                 
                var obj = $(this).closest('li').children(".js-category").find("span").first(); //蓝标题span
                var objDuo = $(this).closest('li').children(".js-category").find("span").eq(1); //黄标题span
                var objChao = $(this).closest('li').children(".js-category").find("span").eq(2); //第三个

                $(obj).text(rowcount);
                $(objDuo).text("多" + iDuoci);
                $(objChao).text("超" + i2H);

                if (rowcount == 0) {
                    $(obj).addClass("bg-gray").removeClass("bg-blue")
                }
                else {
                    $(obj).addClass("bg-blue").removeClass("bg-gray")
                }
                //多次
                if (iDuoci == 0) {
                    $(objDuo).addClass("bg-gray").removeClass("bg-orange")
                }
                else {
                    $(objDuo).addClass("bg-orange").removeClass("bg-gray")
                }
                //超时
                if (i2H == 0) {
                    $(objChao).addClass("bg-gray").removeClass("bg-orange")
                }
                else {
                    $(objChao).addClass("bg-orange").removeClass("bg-gray")
                }
            });
             


        }
        function cancel() {
            $('.weui-cell').removeClass("hide");
            $('.weui-cell').siblings('.weui-cells__title').removeClass("hide");

            $('ul li ul li').children(".js-category2").css("display", "")

            //配件特殊处理
            if ($('div.peijian').siblings().css("display") != "none")
            { $('div.peijian ').click(); }

            showBlockCount();
        }

        function clear() {
            $('#searchInput').val('');
            $('.weui-cell').removeClass("hide");
            $('.weui-cell').siblings('.weui-cells__title').removeClass("hide");
            $('ul li ul li').children(".js-category2").css("display", "")

            //配件特殊处理
            if ($('div.peijian').siblings().css("display") != "none")
            { $('div.peijian ').click(); }
            showBlockCount();
        }

        //组装件显示折叠
        function showorhide(obj) {
            var divLineBody = $(obj)[0].nextElementSibling;
            var ishide = $(divLineBody).css("display");
            // alert(ishide);
            if (ishide == "none") {
                $(divLineBody).show("fast")//;.removeClass("hide")
                // $(obj).find(".icon-74").removeClass(".icon-74").addClass(".icon-35")
            }
            else {
                $(divLineBody).hide()// ;.addClass("hide")
                // $(obj).find(".icon-35").removeClass(".icon-35").addClass(".icon-74")
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
开发中....
    <div class="weui-search-bar" id="searchBar">
        <form class="weui-search-bar__form" onkeydown="if(event.keyCode==13) return false;">
            <div class="weui-search-bar__box">
                <i class="weui-icon-search"></i>
                <input type="search" class="weui-search-bar__input" id="searchInput" placeholder="搜索"
                    required="">
                <a href="javascript:clear()" class="weui-icon-clear" id="searchClear"></a>
            </div>
            <label class="weui-search-bar__label" id="searchText">
                <i class="weui-icon-search"></i>
                <span>请输入查看的关键字</span>
            </label>
        </form>
        <a href="javascript:cancel()" class="weui-search-bar__cancel-btn" style="color: #09bb07" id="searchCancel">取消</a>
    </div>
    
    <form id="form1" runat="server">
<%--        <div class="page">

            <div class="page__bd" id="t2" style="height: 100%;">
                <div class="weui-tab">
                    <div class="weui-tab__panel" style="background-color: lightgray">
                        <div id="tab1" class="weui-tab__content">
                            <%--检测申请 --%>
                            <div class="weui-form-preview">                                 
                                <ul class="collapse">
                                    <li class="js-show">
                                        <a class="weui-flex js-category" href="/jiaju/jiaju_apply.aspx?formno=&workshop=<% =_workshop %>">
                                            <div class="weui-cells__title weui-flex__item">
                                                <i class="icon nav-icon icon-41"></i>检测申请  
                                            </div>
                                            <span class="f12">进入</span><i class="icon icon-108"></i>
                                        </a>
                                    </li>
                                </ul>
                            </div>                             
                                            
                            <%----申 请 中  -----%>
                            <div class="weui-form-preview">
                                <%
                                    System.Data.DataTable dt_line = ViewState["dt_data_1"] as System.Data.DataTable;
                                    int rowscount = dt_line.Rows.Count;
                                    string line;
                                %>
                                <ul class="collapse">
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i> 申 请 中                                                
                                                <span class="weui-badge  bg-<% =(rowscount==0?"gray":"blue") %> margin20-l"><% =rowscount %></span>
                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells">
                                                <%
                                                    System.Data.DataView dataView = dt_line.DefaultView;
                                                    System.Data.DataTable dtLineDistinct = dataView.ToTable(true, "line");
                                                    System.Data.DataRow[] dtrowswip;
                                                    //foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                                    //{
                                                    //    line = drLine["line"].ToString();
                                                    //    dtrowswip = dt_line.Select("");
                                                %>
                                                <%--<ul class="collapse2  ">
                                                    <li class=" LH " style="margin-top: 0px; margin-bottom: 0px">
                                                        <div class="weui-flex js-category2" onclick="showorhide(this);">
                                                            <div class="weui-cells__title LH weui-flex__item">
                                                                <i class="icon nav-icon icon-22 color-success"></i><%= line %>
                                                                <span class="weui-badge bg-<% =(dtrowswip.Length==0?"gray":"blue") %>  margin20-l  "><% =dtrowswip.Length %></span>
                                                            </div>
                                                            <i class="icon icon-74"></i>
                                                        </div>
                                                        <div class="page-category js-categoryInner a_body">
                                                            <div>--%>
                                                <%                                                  
                                                    
                                                    foreach (System.Data.DataRow dr in dt_line.Rows)
                                                    {%>
                                                <a class="weui-cell  weui-cell_access" href="<%=dr["href"] %>">
                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-blue"><%=(Convert.ToInt16(dr["ng_count"])>0?"多次":"")%> <%=Convert.ToInt16(dr["timesMinute"])>120?"超时":"" %></span></div>
                                                    <div class="weui-cell__hd">
                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                    </div>
                                                    <div class="weui-cell__bd f-black" style="font-size: smaller">
                                                        <span class="span_space">
                                                            <%=dr["formno"] %>
                                                        </span>
                                                        <span>
                                                            <%=dr["sb_code"] %>
                                                        </span>
                                                        <span>
                                                            <%=dr["sb_desc"] %>
                                                        </span><% if (Convert.ToInt16(dr["ng_count"]) >= 1)
                                                                   { %>
                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr   margin10-l" style="font-size: x-small;"><%=Convert.ToInt16(dr["ng_count"])+1%></span>
                                                        <%} %>
                                                        <br />
                                                        <span class=""><%=dr["on_pgino"] %></span>
                                                        <span><%=dr["on_pn"] %></span>
                                                        <span><%=dr["on_jiaju_name"] %></span>
                                                        <br />
                                                        <span class="weui-agree__text span_space">
                                                            <%=dr["Emp_Name"] %>
                                                        </span>
                                                        <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}", dr["create_date"]) %> </span>
                                                        <span class="weui-agree__text">时长:<font class="f-deepfont"> <%=dr["times"] %></font>
                                                        </span>
                                                    </div>
                                                    <div class="weui-cell__ft">
                                                    </div>
                                                </a>
                                                <%}%>
                                                <%--      </div>
                                                        </div>
                                                    </li>
                                                </ul>
                                                <%  }%>--%>
                                            </div>

                                        </div>
                                    </li>
                                </ul>
                            </div>


                            <%----待检中-----%>
                            <div class="weui-form-preview">
                                <%
                                    dt_line = ViewState["dt_data_2"] as System.Data.DataTable;
                                    rowscount = dt_line.Rows.Count;
                                %>
                                <ul class="collapse">
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>待 检 中
                                                <span class="weui-badge  bg-<% =(rowscount==0?"gray":"blue") %>  margin20-l"><% =rowscount %></span>

                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells">

                                                <%                                                  

                                                    foreach (System.Data.DataRow dr in dt_line.Rows)
                                                    {%>
                                                <a class="weui-cell  weui-cell_access" href="<%=dr["href"] %>">
                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-yellow"><%=(Convert.ToInt16(dr["ng_count"])>0?"多次":"")%> <%=Convert.ToInt16(dr["timesMinute"])>120?"超时":"" %></span></div>
                                                    <div class="weui-cell__hd">
                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                    </div>
                                                    <div class="weui-cell__bd f-black" style="font-size: smaller">
                                                        <span class="span_space">
                                                            <%=dr["formno"] %>
                                                        </span>
                                                        <span>
                                                            <%=dr["sb_code"] %>
                                                        </span>
                                                        <span>
                                                            <%=dr["sb_desc"] %>
                                                        </span><% if (Convert.ToInt16(dr["ng_count"]) >= 1)
                                                                   { %>
                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr   margin10-l" style="font-size: x-small;"><%=Convert.ToInt16(dr["ng_count"])+1%></span>
                                                        <%} %>
                                                        <br />
                                                        <span class=""><%=dr["on_pgino"] %></span>
                                                        <span><%=dr["on_pn"] %></span>
                                                        <span><%=dr["on_jiaju_name"] %></span>
                                                        <br />
                                                        <span class="weui-agree__text span_space">
                                                            <%=dr["Emp_Name"] %>
                                                        </span>
                                                        <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}", dr["create_date"]) %> </span>
                                                        <span class="weui-agree__text">时长:<font class="f-deepfont"> <%=dr["times"] %></font>
                                                        </span>
                                                    </div>
                                                    <div class="weui-cell__ft">
                                                    </div>
                                                </a>

                                                <% }
                                                %>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <%----检测中-----%>
                            <div class="weui-form-preview">
                                <%
                                    dt_line = ViewState["dt_data_3"] as System.Data.DataTable;
                                    rowscount = dt_line.Rows.Count;

                                %>
                                <ul class="collapse">
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i> 检 测 中                                                
                                                <span class="weui-badge  bg-<% =(rowscount==0?"gray":"blue") %> margin20-l"><% =rowscount %></span>

                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells">

                                                <%                                                  

                                                    foreach (System.Data.DataRow dr in dt_line.Rows)
                                                    { %>
                                                <a class="weui-cell  weui-cell_access" href="<%=dr["href"] %>">
                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-green"><%=(Convert.ToInt16(dr["ng_count"])>0?"多次":"")%> <%=Convert.ToInt16(dr["timesMinute"])>120?"超时":"" %></span></div>
                                                    <div class="weui-cell__hd">
                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                    </div>
                                                    <div class="weui-cell__bd f-black" style="font-size: smaller">
                                                        <span class="span_space">
                                                            <%=dr["formno"] %>
                                                        </span>
                                                        <span>
                                                            <%=dr["sb_code"] %>
                                                        </span>
                                                        <span>
                                                            <%=dr["sb_desc"] %>
                                                        </span><% if (Convert.ToInt16(dr["ng_count"]) >= 1)
                                                                   { %>
                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr   margin10-l" style="font-size: x-small;"><%=Convert.ToInt16(dr["ng_count"])+1%></span>
                                                        <%} %>
                                                        <br />
                                                        <span class=""><%=dr["on_pgino"] %></span>
                                                        <span><%=dr["on_pn"] %></span>
                                                        <span><%=dr["on_jiaju_name"] %></span>
                                                        <br />
                                                        <span class="weui-agree__text span_space">
                                                            <%=dr["Emp_Name"] %>
                                                        </span>
                                                        <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}", dr["create_date"]) %> </span>
                                                        <span class="weui-agree__text">时长:<font class="f-deepfont"> <%=dr["times"] %></font>
                                                        </span>
                                                    </div>
                                                    <div class="weui-cell__ft">
                                                    </div>
                                                </a>


                                                <%}%>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>


                            <%----检测完成（20H内）-----%>
                            <div class="weui-form-preview">
                                <ul class="collapse">
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <%
                                                dt_line = ViewState["dt_data_4"] as System.Data.DataTable;
                                                rowscount = dt_line.Rows.Count;
                                                int rowsTwo = dt_line.Select("ng_count>0").Length;
                                                int rows2H = dt_line.Select("timesMinute>120").Length;
                                            %>
                                            <div class="weui-cells__title  weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>检测完成（20小时内）                                                 
                                                <span class="weui-badge  bg-<% =(rowscount==0?"gray":"blue") %> margin10-l " ><% =rowscount %></span>
                                                <span class="weui-badge  bg-<% =(rowsTwo==0?"gray":"orange") %> margin10-l " ><% =rowsTwo %></span>
                                                <span class="weui-badge  bg-<% =(rows2H==0?"gray":"orange") %> margin10-l " ><% =rows2H %></span>
                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells">
                                                <%                                          
                                                    dataView = dt_line.DefaultView;
                                                    dtLineDistinct = dataView.ToTable(true, "line");

                                                    foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                                    {
                                                        line = drLine["line"].ToString();
                                                        int intblue = dt_line.Select("line='" + line + "'").Count();
                                                        int intorange = dt_line.Select("line='" + line + "' and ng_count>0").Count();
                                                        int intred = dt_line.Select("line='" + line + "' and timesMinute>120").Count();
                                                %>
                                                <ul class="collapse2 ">
                                                    <li class=" LH " style="margin-top: 0px; margin-bottom: 0px">
                                                        <div class="weui-flex js-category2 " onclick="showorhide(this);">
                                                            <div class="weui-cells__title  weui-flex__item LH">
                                                                <i class="icon nav-icon icon-22 color-success "></i><%=line %>
                                                                <span class="weui-badge <% =(intblue==0?"bg-gray":"bg-blue") %> margin20-l " ><% =intblue %></span>
                                                                <span class="weui-badge <% =(intorange==0?"bg-gray":"bg-orange") %> margin20-l " ><% =intorange %></span>
                                                                <span class="weui-badge <% =(intred==0?"bg-gray":"bg-orange") %> margin20-l " ><% =intred %></span>
                                                            </div>
                                                            <i class="icon icon-74 right"></i>
                                                        </div>
                                                        <div class="page-category js-categoryInner a_body" style="display: none">
                                                            <%                                                  

                                                                foreach (System.Data.DataRow dr in dt_line.Select("line='" + line + "'"))
                                                                {%>
                                                            <a class="weui-cell  weui-cell_access <%=(Convert.ToInt16(dr["ng_count"])>0?"duoci":"")%> <%=Convert.ToInt16(dr["timesMinute"])>120?"chaoshi":"" %>" href="<%=dr["href"] %>">
                                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"><%=(Convert.ToInt16(dr["ng_count"])>0?"多次":"")%> <%=Convert.ToInt16(dr["timesMinute"])>120?"超时":"" %></span></div>
                                                                <div class="weui-cell__hd">
                                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                </div>
                                                                <div class="weui-cell__bd f-black" style="font-size: smaller">
                                                                    <span class="span_space">
                                                                        <%=dr["formno"] %>
                                                                    </span>
                                                                    <span>
                                                                        <%=dr["sb_code"] %>
                                                                    </span>
                                                                    <span>
                                                                        <%=dr["sb_desc"] %>
                                                                    </span><% if (Convert.ToInt16(dr["ng_count"]) >= 1)
                                                                               { %>
                                                                    <span class="weui-mark-rt- weui-badge  weui-badge-tr   margin10-l" style="font-size: x-small;"><%=Convert.ToInt16(dr["ng_count"])+1%></span>
                                                                    <%} %>
                                                                    <br />
                                                                    <span class=""><%=dr["on_pgino"] %></span>
                                                                    <span><%=dr["on_pn"] %></span>
                                                                    <span><%=dr["on_jiaju_name"] %></span>
                                                                    <br />
                                                                    <span class="weui-agree__text span_space">
                                                                        <%=dr["Emp_Name"] %>
                                                                    </span>
                                                                    <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}", dr["create_date"]) %> </span>
                                                                    <span class="weui-agree__text">时长:<font class="<%=Convert.ToInt16(dr["timesMinute"])>120?"f-red":"f-deepfont" %>"> <%=dr["times"] %></font>
                                                                    </span>
                                                                </div>
                                                                <div class="weui-cell__ft">
                                                                </div>
                                                            </a>
                                                            <% }%>
                                                        </div>
                                                    </li>
                                                </ul>
                                                <%  }%>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>



                        </div>
                    </div>
                </div>
            </div>
        </div>--%>


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
