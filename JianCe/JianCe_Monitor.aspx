<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JianCe_Monitor.aspx.cs" Inherits="JianCe_Monitor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>检测监视</title>
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
                        //$self.closest('li').children(".js-category").css("display", "none"); 
                    } else {
                        $self.addClass("hide");
                        $self.siblings('.weui-cells__title').addClass("hide");
                        //$self.closest('li').children(".js-category").css("display", "none"); 
                    }

                    $self.closest('li').children(".js-category2").css("display", "none"); 
                });


                showBlockCount();
                $(".maxHour").addClass("hide");//隐藏
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
                var row1 = $(this).find("a:not(.hide)").length;
                var row2 = $(this).find("a:not(.hide) :contains('紧急')").length;
                var row3 = $(this).find("a:not(.hide) :contains('部分')").length;//部分
                var row4 = $(this).find("a:not(.hide) :contains('NG')").length;//NG

                var obj1 = $(this).closest('li').children(".js-category").find("span").first(); //蓝标题span
                var obj2 = $(this).closest('li').children(".js-category").find("span").eq(1); //黄标题span
                var obj3 = $(this).closest('li').children(".js-category").find("span.Part"); //第三个 
                var obj4 = $(this).closest('li').children(".js-category").find("span.NG"); //NG 

                $(obj1).text(row1);
                $(obj2).text("急"+row2);
                $(obj3).text("部"+row3);
                $(obj4).text("NG" + row4);

                if (row1 == 0) {
                    $(obj1).addClass("bg-gray").removeClass("bg-blue")
                }
                else {
                    $(obj1).addClass("bg-blue").removeClass("bg-gray")
                }
                //急
                if (row2 == 0) {
                    $(obj2).addClass("bg-gray").removeClass("bg-red")
                }
                else {
                    $(obj2).addClass("bg-red").removeClass("bg-gray")
                }
                // 部分
                if (row3 == 0) {
                    $(obj3).addClass("bg-gray").removeClass("bg-orange")
                }
                else {
                    $(obj3).addClass("bg-orange").removeClass("bg-gray")
                }
                // NG
                if (row4 == 0) {
                    $(obj4).addClass("bg-gray").removeClass("bg-red")
                }
                else {
                    $(obj4).addClass("bg-red").removeClass("bg-gray")
                }
            });



        }
        function cancel() {
            $('.weui-cell').removeClass("hide");
            $('.weui-cell').siblings('.weui-cells__title').removeClass("hide");

            $('ul li ul li').children(".js-category2").css("display", "")

            ////配件特殊处理
            //if ($('div.peijian').siblings().css("display") != "none")
            //{ $('div.peijian ').click(); }

            showBlockCount();
            $(".maxHour").removeClass("hide");//show
        }

        function clear() {
            $('#searchInput').val('');
            $('.weui-cell').removeClass("hide");
            $('.weui-cell').siblings('.weui-cells__title').removeClass("hide");
            $('ul li ul li').children(".js-category2").css("display", "")

            ////配件特殊处理
            //if ($('div.peijian').siblings().css("display") != "none")
            //{ $('div.peijian ').click(); }
            showBlockCount();
            $(".maxHour").removeClass("hide");//show
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
        <div class="page">

            <div class="page__bd" id="t2" style="height: 100%;">
                <div class="weui-tab">
                    <div class="weui-tab__panel" style="background-color: lightgray">
                        <div id="tab1" class="weui-tab__content">
                            <%--检测申请--%>
                            <div class="weui-form-preview">
                                <ul class="collapse">
                                    <li class="js-show">
                                        <a class="weui-flex js-category" href="/jiance/jc_apply.aspx?dh=">
                                            <div class="weui-cells__title weui-flex__item">
                                                <i class="icon nav-icon icon-41"></i>检测申请  
                                            </div>
                                            <span class="f12">进入</span><i class="icon icon-108"></i>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                            <%
                                var exp = "";
                                System.Data.DataTable dt_line ;
                                int rowsCnt1 ;
                                int rowsCnt2;
                                string rowsCnt3;
                                string sj_type;
                            %>
                            <%----申 请 中  ---%>
                            <div class="weui-form-preview">
                                <%
                                    dt_line = ViewState["dt_data_1"] as System.Data.DataTable;
                                    rowsCnt1 = dt_line.Rows.Count;
                                    rowsCnt2 = dt_line.Select("priority='紧急'").Length;
                                    rowsCnt3 = dt_line.Compute("max(timesHours)","").ToString();
                                %>
                                <ul class="collapse">
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>申 请 中                                                
                                                <span class="weui-badge  bg-<% =(rowsCnt1==0?"gray":"blue") %> margin15-l"><% =rowsCnt1 %></span>                                                 
                                                <span class="weui-badge  bg-<% =(rowsCnt2==0?"gray":"red") %> margin15-l">急<% =rowsCnt2 %></span>
                                                <div class="weui-badge bg-<% =(rowsCnt3==""?"gray":"orange") %> margin15-l maxHour" style="margin-right: 15px;"><% =rowsCnt3 %>h</div>
                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells">
                                                <%
                                                    System.Data.DataView dataView = dt_line.DefaultView;
                                                    System.Data.DataTable dtLineDistinct = dataView.ToTable(true, "workshop", "apl_qty", "pri_qty", "timesHours");
                                                    foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                                    {
                                                        sj_type = drLine["workshop"].ToString();//申请以workshop来分组
                                                        var apl_qty = drLine["apl_qty"].ToString();
                                                        var pri_qty = drLine["pri_qty"].ToString();
                                                        var timesHours = drLine["timesHours"].ToString() + "h";
                                                %>
                                                <ul class="collapse2  ">
                                                    <li style="margin-top: 0px; margin-bottom: 0px">
                                                        <div class="weui-flex js-category2" onclick="showorhide(this);">
                                                            <div class="weui-cells__title LH weui-flex__item">
                                                                <i class="icon nav-icon icon-22 color-success"></i><%= sj_type %>
                                                                <span class="weui-badge bg-<% =(apl_qty=="0"?"gray":"blue") %>  margin10-l  "><% =apl_qty %></span>
                                                                <span class="weui-badge bg-<% =(pri_qty=="0"?"gray":"red") %>  margin10-l  ">急<% =pri_qty %></span>
                                                                <span class="weui-badge bg-orange  margin20-l  "><% =timesHours %></span>
                                                            </div>
                                                            <i class="icon icon-74"></i>
                                                        </div>
                                                        <div class="page-category js-categoryInner a_body" style="display:none">
                                                            <div>
                                                                <%  
                                                                    foreach (System.Data.DataRow dr in dt_line.Select("workshop='" + sj_type + "'"))
                                                                    {%>
                                                                <a class="weui-cell  weui-cell_access" href="<%=dr["href"] %>">
                                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-blue"></span></div>
                                                                    <div class="weui-cell__hd">
                                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                    </div>
                                                                    <div class="weui-cell__bd f-black" style="font-size: smaller">
                                                                        <span>
                                                                            <%=dr["dh"].ToString() %>
                                                                        </span>
                                                                        <span>
                                                                            <%=dr["sj_type"].ToString() %>
                                                                        </span>
                                                                        <span>
                                                                            <%=dr["line"].ToString() %> <%="op"+dr["op"].ToString() %>
                                                                        </span>
                                                                        <br />
                                                                        <span><%=dr["xmh"] %></span>
                                                                        <span><%=dr["ljh"] %></span>
                                                                        <span class="f-blue"><%=dr["sj_qty"].ToString()%></span>件
                                                                        <span ><%=dr["location"].ToString()%></span>
                                                                        <% if (dr["priority"].ToString() == "紧急")
                                                                            { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr  b-red f-red   margin10-l" style="font-size: x-small;">紧急</span>
                                                                        <%} %>
                                                                        <br />
                                                                        <span class="weui-agree__text span_space">
                                                                            <%=dr["tel"].ToString()+dr["Emp_Name"].ToString() %>
                                                                        </span>
                                                                        <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}", dr["create_date"]) %> </span>
                                                                        <span class="weui-agree__text">时长:<font class="<%=dr["timesColor"] %>"> <%=dr["times"] %></font>
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
                                                <%  }%>
                                            </div>

                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <div style="border:0px red solid;background-color:white">
                            <%----待检中-机加----%>
                            <div class="weui-form-preview">
                                <%
                                    exp = "sys like '%机加实验室%'";
                                    dt_line = ViewState["dt_data_2"] as System.Data.DataTable;
                                    rowsCnt1 = dt_line.Select(exp).Length;
                                    rowsCnt2 = dt_line.Select(exp+" and priority='紧急'").Length;
                                    rowsCnt3 = dt_line.Compute("max(timesHours)",exp).ToString();

                                %>
                                <ul class="collapse">
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>机加 待检中
                                                <span class="weui-badge  bg-<% =(rowsCnt1==0?"gray":"blue") %> margin15-l"><% =rowsCnt1 %></span>
                                                <span class="weui-badge  bg-<% =(rowsCnt2==0?"gray":"red") %> margin15-l">急<% =rowsCnt2 %></span>
                                                <div class="weui-badge bg-<% =(rowsCnt3==""?"gray":"orange") %> margin15-l maxHour" style="margin-right: 15px;"><% =rowsCnt3 %>h</div>
                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells">
                                                <%
                                                    dataView = dt_line.DefaultView;
                                                    dataView.RowFilter = exp;
                                                    dtLineDistinct = dataView.ToTable(true, "sj_type", "apl_qty", "pri_qty", "timesHours");
                                                    foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                                    {
                                                        sj_type = drLine["sj_type"].ToString();
                                                        var apl_qty = drLine["apl_qty"].ToString();
                                                        var pri_qty = drLine["pri_qty"].ToString();
                                                        var timesHours = drLine["timesHours"].ToString() + "h";
                                                %>
                                                <ul class="collapse2  ">
                                                    <li style="margin-top: 0px; margin-bottom: 0px">
                                                        <div class="weui-flex js-category2" onclick="showorhide(this);">
                                                            <div class="weui-cells__title LH weui-flex__item">
                                                                <i class="icon nav-icon icon-22 color-success"></i><%= sj_type %>
                                                                <span class="weui-badge bg-<% =(apl_qty=="0"?"gray":"blue") %>  margin10-l  "><% =apl_qty %></span>
                                                                <span class="weui-badge bg-<% =(pri_qty=="0"?"gray":"red") %>  margin10-l  ">急<% =pri_qty %></span>
                                                                <span class="weui-badge bg-orange  margin20-l  "><% =timesHours %></span>
                                                            </div>
                                                            <i class="icon icon-74"></i>
                                                        </div>
                                                        <div class="page-category js-categoryInner a_body" style="display: none">
                                                            <div>
                                                                <%                                                  

                                                                    foreach (System.Data.DataRow dr in dt_line.Select("sj_type='" + sj_type + "'"))
                                                                    {%>
                                                                <a class="weui-cell  weui-cell_access " href="<%=dr["href"] %>">
                                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-orange"></span></div>
                                                                    <div class="weui-cell__hd">
                                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                    </div>
                                                                    <div class="weui-cell__bd f-black" style="font-size: smaller">
                                                                        <span>
                                                                            <%=dr["dh"].ToString() %>
                                                                        </span>
                                                                        <span>
                                                                            <%=dr["workshop"].ToString() %>
                                                                        </span>
                                                                        <span>
                                                                            <%=dr["line"].ToString() %> <%="op"+dr["op"].ToString() %>
                                                                        </span>
                                                                        <br />
                                                                        <span class=""><%=dr["xmh"] %></span>
                                                                        <span><%=dr["ljh"] %></span>
                                                                        <span class="f-blue"><%=dr["sj_qty"].ToString()+"" %></span>件
                                                                        <span ><%=dr["location"].ToString()%></span>
                                                                        <% if (dr["priority"].ToString() == "紧急")
                                                                            { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr  b-red f-red   margin10-l" style="font-size: x-small;">紧急</span>
                                                                        <%} %>
                                                                        <br />
                                                                        <span class="weui-agree__text span_space">
                                                                            <%=dr["tel"].ToString()+dr["Emp_Name"].ToString() %>
                                                                        </span>
                                                                        <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}", dr["apply_date"]) %> </span>
                                                                        <span class="weui-agree__text">时长:<span class="<%=dr["timesColor"] %>"> <%=dr["times"] %></span>
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
                                                <%  }%>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <%----检测中-机加----%>
                            <div class="weui-form-preview">
                                <%
                                    exp = "sys like '%机加实验室%'";
                                    dt_line = ViewState["dt_data_3"] as System.Data.DataTable;
                                    rowsCnt1 = dt_line.Select(exp).Length;
                                    rowsCnt2 = dt_line.Select(exp+" and priority='紧急'").Length;
                                    rowsCnt3 = dt_line.Compute("max(timesHours)",exp).ToString();
                                    var rowspart = dt_line.Select(exp+" and ispart='部分'").Length;
                                %>
                                <ul class="collapse">
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>机加 检测中                                                
                                                <span class="weui-badge  bg-<% =(rowsCnt1==0?"gray":"blue") %> margin15-l"><% =rowsCnt1 %></span>                                                
                                                <span class="weui-badge  bg-<% =(rowsCnt2==0?"gray":"red") %> margin15-l">急<% =rowsCnt2 %></span>
                                                <span class="weui-badge bg-<% =(rowspart==0?"gray":"orange") %> margin15-l Part" >部<% =rowspart %></span>
                                                <div class="weui-badge bg-<% =(rowsCnt3==""?"gray":"orange") %> margin15-l maxHour" ><% =rowsCnt3 %>h</div>
                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells">
                                                <%
                                                    dataView = dt_line.DefaultView;
                                                    dataView.RowFilter = exp;
                                                    dtLineDistinct = dataView.ToTable(true, "sj_type", "apl_qty", "pri_qty", "timesHours");
                                                    foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                                    {
                                                        sj_type = drLine["sj_type"].ToString();
                                                        var apl_qty = drLine["apl_qty"].ToString();
                                                        var pri_qty = drLine["pri_qty"].ToString();
                                                        var timesHours = drLine["timesHours"].ToString() + "h";
                                                        var rowspartLine = dt_line.Select(exp+" and ispart='部分' and sj_type='"+sj_type+"'").Length;
                                                %>
                                                <ul class="collapse2  ">
                                                    <li style="margin-top: 0px; margin-bottom: 0px">
                                                        <div class="weui-flex js-category2" onclick="showorhide(this);">
                                                            <div class="weui-cells__title LH weui-flex__item">
                                                                <i class="icon nav-icon icon-22 color-success"></i><%= sj_type %>
                                                                <span class="weui-badge bg-<% =(apl_qty=="0"?"gray":"blue") %>  margin10-l  "><% =apl_qty %></span>                                                                
                                                                <span class="weui-badge bg-<% =(pri_qty=="0"?"gray":"red") %>  margin10-l  ">急<% =pri_qty %></span>
                                                                <span class="weui-badge bg-<% =(rowspartLine==0?"gray":"orange") %> margin15-l maxHour" >部<% =rowspartLine %></span>
                                                                <span class="weui-badge bg-orange  margin20-l  "><% =timesHours %></span>
                                                            </div>
                                                            <i class="icon icon-74"></i>
                                                        </div>
                                                        <div class="page-category js-categoryInner a_body"  style="display: none">
                                                            <div>
                                                                <%                                                  

                                                                    foreach (System.Data.DataRow dr in dt_line.Select(exp+" and sj_type='" + sj_type + "'"))
                                                                    {%>
                                                                <a class="weui-cell  weui-cell_access" href="<%=dr["href"] %>">
                                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-blue"></span></div>
                                                                    <div class="weui-cell__hd">
                                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                    </div>
                                                                    <div class="weui-cell__bd f-black" style="font-size: smaller">
                                                                        <span>
                                                                            <%=dr["dh"].ToString() %>
                                                                        </span>
                                                                        <span>
                                                                            <%=dr["workshop"].ToString() %>
                                                                        </span>
                                                                        <span>
                                                                            <%=dr["line"].ToString() %> <%="op"+dr["op"].ToString() %>
                                                                        </span>
                                                                        <br />
                                                                        <span class=""><%=dr["xmh"] %></span>
                                                                        <span><%=dr["ljh"] %></span>
                                                                        <span class="f-blue"><%=dr["sj_qty"].ToString() %></span>件
                                                                        <span ><%=dr["location"].ToString()%></span>
                                                                        <% if (dr["ispart"].ToString() == "部分")
                                                                            { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr  " style="font-size: x-small;">部分</span>
                                                                        <%}; %>
                                                                        <% if (dr["priority"].ToString() == "紧急")
                                                                            { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr  b-red f-red " style="font-size: x-small;">紧急</span>
                                                                        <%}; %>
                                                                        
                                                                        <br />
                                                                        <span class="weui-agree__text span_space">
                                                                            <%=dr["tel"].ToString()+dr["JC_Emp_Name"].ToString() %>
                                                                        </span>
                                                                        <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}", dr["jc_start_date"]) %> </span>
                                                                        <span class="weui-agree__text">时长:<span class="<%=dr["timesColor"] %>"> <%=dr["times"] %></span>
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
                                                <%  }%>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <%----待取回-机加----%>
                            <div class="weui-form-preview">
                                <%  var sys = "机加";
                                    exp = "sys like '%"+sys+"%'";
                                    dt_line = ViewState["dt_data_4"] as System.Data.DataTable;
                                    rowsCnt1 = dt_line.Select(exp).Length;
                                    rowsCnt2 = dt_line.Select(exp+"and priority='紧急'").Length;
                                    rowsCnt3 = dt_line.Compute("max(timesHours)",exp).ToString();
                                    var rowsNg = dt_line.Select(exp+" and jcResult='NG'").Length;
                                    var rowsNK = dt_line.Select(exp+" and jcResult='超内控'").Length;
                                %>
                                <ul class="collapse">
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i><% =sys %> 待取回                                                
                                                <span class="weui-badge  bg-<% =(rowsCnt1==0?"gray":"blue") %> margin15-l"><% =rowsCnt1 %></span>
                                                <span class="weui-badge  bg-<% =(rowsCnt2==0?"gray":"red") %> margin15-l">急<% =rowsCnt2 %></span>
                                                <span class="weui-badge  bg-<% =((rowsNg+rowsNK)==0?"gray":"red") %> margin15-l NG ">NG<% =rowsNg %>+<% =rowsNK %></span>
                                                <div class="weui-badge bg-<% =(rowsCnt3==""?"gray":"orange") %> margin15-l maxHour"  ><% =rowsCnt3 %>h</div>

                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells">
                                                <%
                                                    dataView = dt_line.DefaultView;
                                                    dataView.RowFilter = exp;
                                                    dtLineDistinct = dataView.ToTable(true, "sj_type", "apl_qty", "pri_qty", "timesHours");
                                                    foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                                    {
                                                        sj_type = drLine["sj_type"].ToString();
                                                        var apl_qty = drLine["apl_qty"].ToString();
                                                        var pri_qty = drLine["pri_qty"].ToString();
                                                        var timesHours = drLine["timesHours"].ToString() + "h";
                                                        var rowsNgLine = dt_line.Select(exp+" and jcResult='NG' and sj_type='"+sj_type+"'").Length;
                                                        var rowsNKLine = dt_line.Select(exp+" and jcResult='超内控' and sj_type='"+sj_type+"'").Length;
                                                %>
                                                <ul class="collapse2  ">
                                                    <li style="margin-top: 0px; margin-bottom: 0px">
                                                        <div class="weui-flex js-category2" onclick="showorhide(this);">
                                                            <div class="weui-cells__title LH weui-flex__item">
                                                                <i class="icon nav-icon icon-22 color-success"></i><%= sj_type %>
                                                                <span class="weui-badge bg-<% =(apl_qty=="0"?"gray":"blue") %>  margin10-l  "><% =apl_qty %></span>
                                                                <span class="weui-badge bg-<% =(pri_qty=="0"?"gray":"red") %>  margin10-l  ">急<% =pri_qty %></span>
                                                                <span class="weui-badge bg-<% =((rowsNgLine+rowsNKLine)==0?"gray":"red") %>  margin10-l ">NG<% =rowsNgLine.ToString() %>+<% =rowsNKLine.ToString() %></span>
                                                                <span class="weui-badge bg-orange  margin20-l  "><% =timesHours %></span>
                                                            </div>
                                                            <i class="icon icon-74"></i>
                                                        </div>
                                                        <div class="page-category js-categoryInner a_body"  style="display: none">
                                                            <div>
                                                                <%                                                  

                                                                    foreach (System.Data.DataRow dr in dt_line.Select(exp+" and sj_type='" + sj_type + "'"))
                                                                    {%>
                                                                <a class="weui-cell  weui-cell_access" href="<%=dr["href"] %>">
                                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-green"><%=dr["jcResult"].ToString() %></span></div>
                                                                    <div class="weui-cell__hd">
                                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                    </div>
                                                                    <div class="weui-cell__bd f-black" style="font-size: smaller">
                                                                        <span>
                                                                            <%=dr["dh"].ToString() %>
                                                                        </span>
                                                                        <span>
                                                                            <%=dr["workshop"].ToString() %>
                                                                        </span>
                                                                        <span>
                                                                            <%=dr["line"].ToString() %> <%="op"+dr["op"].ToString() %>
                                                                        </span>
                                                                        <br />
                                                                        <span><%=dr["xmh"] %></span>
                                                                        <span><%=dr["ljh"] %></span>
                                                                        <span class="f-blue"><%=dr["sj_qty"].ToString() %></span>件
                                                                        <span ><%=dr["location"].ToString()%></span>
                                                                        <% if (dr["priority"].ToString() == "紧急")
                                                                            { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr  b-red f-red" style="font-size: x-small;">紧急</span>
                                                                        <%} %>
                                                                         <% if (dr["jcResult"].ToString() == "NG")  { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr  b-red f-red" style="font-size: x-small;">NG</span>
                                                                        <%}  else if (dr["jcResult"].ToString() == "超内控")  { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr  b-red f-red" style="font-size: x-small;">内控</span>
                                                                        <%} %>
                                                                        <br />
                                                                        <span class="weui-agree__text span_space">
                                                                            <%=dr["tel"].ToString()+dr["Emp_Name"].ToString() %>
                                                                        </span>
                                                                        <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}", dr["rpt_confirm_date"]) %> </span>
                                                                        <span class="weui-agree__text">时长:<span class="<%=dr["timesColor"] %>"> <%=dr["times"] %></span>
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
                                                <%  }%>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
</div><div style="border:0px red solid;background-color:white">
                            <%----待检中-Equator----%>
                            <div class="weui-form-preview">
                                <%
                                    exp = "sys like '%Equator%'";
                                    dt_line = ViewState["dt_data_2"] as System.Data.DataTable;
                                    rowsCnt1 = dt_line.Select(exp).Length;
                                    rowsCnt2 = dt_line.Select(exp+" and priority='紧急'").Length;
                                    rowsCnt3 = dt_line.Compute("max(timesHours)",exp).ToString();

                                %>
                                <ul class="collapse">
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>Equator 待检中
                                                <span class="weui-badge  bg-<% =(rowsCnt1==0?"gray":"blue") %> margin15-l"><% =rowsCnt1 %></span>
                                                <span class="weui-badge  bg-<% =(rowsCnt2==0?"gray":"red") %> margin15-l">急<% =rowsCnt2 %></span>
                                                <div class="weui-badge bg-<% =(rowsCnt3==""?"gray":"orange") %> margin15-l maxHour" style="margin-right: 15px;"><% =rowsCnt3 %>h</div>
                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells">
                                                <%
                                                    dataView = dt_line.DefaultView;
                                                    dataView.RowFilter = exp;
                                                    dtLineDistinct = dataView.ToTable(true, "sj_type", "apl_qty", "pri_qty", "timesHours");
                                                    foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                                    {
                                                        sj_type = drLine["sj_type"].ToString();
                                                        var apl_qty = drLine["apl_qty"].ToString();
                                                        var pri_qty = drLine["pri_qty"].ToString();
                                                        var timesHours = drLine["timesHours"].ToString() + "h";
                                                %>
                                                <ul class="collapse2  ">
                                                    <li style="margin-top: 0px; margin-bottom: 0px">
                                                        <div class="weui-flex js-category2" onclick="showorhide(this);">
                                                            <div class="weui-cells__title LH weui-flex__item">
                                                                <i class="icon nav-icon icon-22 color-success"></i><%= sj_type %>
                                                                <span class="weui-badge bg-<% =(apl_qty=="0"?"gray":"blue") %>  margin10-l  "><% =apl_qty %></span>
                                                                <span class="weui-badge bg-<% =(pri_qty=="0"?"gray":"red") %>  margin10-l  ">急<% =pri_qty %></span>
                                                                <span class="weui-badge bg-orange  margin20-l  "><% =timesHours %></span>
                                                            </div>
                                                            <i class="icon icon-74"></i>
                                                        </div>
                                                        <div class="page-category js-categoryInner a_body" style="display: none">
                                                            <div>
                                                                <%                                                  

                                                                    foreach (System.Data.DataRow dr in dt_line.Select("sj_type='" + sj_type + "'"))
                                                                    {%>
                                                                <a class="weui-cell  weui-cell_access " href="<%=dr["href"] %>">
                                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-orange"></span></div>
                                                                    <div class="weui-cell__hd">
                                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                    </div>
                                                                    <div class="weui-cell__bd f-black" style="font-size: smaller">
                                                                        <span>
                                                                            <%=dr["dh"].ToString() %>
                                                                        </span>
                                                                        <span>
                                                                            <%=dr["workshop"].ToString() %>
                                                                        </span>
                                                                        <span>
                                                                            <%=dr["line"].ToString() %> <%="op"+dr["op"].ToString() %>
                                                                        </span>
                                                                        <br />
                                                                        <span class=""><%=dr["xmh"] %></span>
                                                                        <span><%=dr["ljh"] %></span>
                                                                        <span class="f-blue"><%=dr["sj_qty"].ToString()+"" %></span>件
                                                                        <span ><%=dr["location"].ToString()%></span>
                                                                        <% if (dr["priority"].ToString() == "紧急")
                                                                            { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr  b-red f-red   margin10-l" style="font-size: x-small;">紧急</span>
                                                                        <%} %>
                                                                        <br />
                                                                        <span class="weui-agree__text span_space">
                                                                            <%=dr["tel"].ToString()+dr["Emp_Name"].ToString() %>
                                                                        </span>
                                                                        <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}", dr["apply_date"]) %> </span>
                                                                        <span class="weui-agree__text">时长:<span class="<%=dr["timesColor"] %>"> <%=dr["times"] %></span>
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
                                                <%  }%>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <%----检测中-Equator----%>
                            <div class="weui-form-preview">
                                <%
                                    exp = "sys like '%Equator%'";
                                    dt_line = ViewState["dt_data_3"] as System.Data.DataTable;
                                    rowsCnt1 = dt_line.Select(exp).Length;
                                    rowsCnt2 = dt_line.Select(exp+" and priority='紧急'").Length;
                                    rowsCnt3 = dt_line.Compute("max(timesHours)",exp).ToString();
                                    rowspart = dt_line.Select(exp+" and ispart='部分'").Length;
                                %>
                                <ul class="collapse">
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>Equator 检测中                                                
                                                <span class="weui-badge  bg-<% =(rowsCnt1==0?"gray":"blue") %> margin15-l"><% =rowsCnt1 %></span>                                                
                                                <span class="weui-badge  bg-<% =(rowsCnt2==0?"gray":"red") %> margin15-l">急<% =rowsCnt2 %></span>
                                                <span class="weui-badge bg-<% =(rowspart==0?"gray":"orange") %> margin15-l Part" >部<% =rowspart %></span>
                                                <div class="weui-badge bg-<% =(rowsCnt3==""?"gray":"orange") %> margin15-l maxHour" ><% =rowsCnt3 %>h</div>
                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells">
                                                <%
                                                    dataView = dt_line.DefaultView;
                                                    dataView.RowFilter = exp;
                                                    dtLineDistinct = dataView.ToTable(true, "sj_type", "apl_qty", "pri_qty", "timesHours");
                                                    foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                                    {
                                                        sj_type = drLine["sj_type"].ToString();
                                                        var apl_qty = drLine["apl_qty"].ToString();
                                                        var pri_qty = drLine["pri_qty"].ToString();
                                                        var timesHours = drLine["timesHours"].ToString() + "h";
                                                        var rowspartLine = dt_line.Select(exp+" and ispart='部分' and sj_type='"+sj_type+"'").Length;
                                                %>
                                                <ul class="collapse2  ">
                                                    <li style="margin-top: 0px; margin-bottom: 0px">
                                                        <div class="weui-flex js-category2" onclick="showorhide(this);">
                                                            <div class="weui-cells__title LH weui-flex__item">
                                                                <i class="icon nav-icon icon-22 color-success"></i><%= sj_type %>
                                                                <span class="weui-badge bg-<% =(apl_qty=="0"?"gray":"blue") %>  margin10-l  "><% =apl_qty %></span>                                                                
                                                                <span class="weui-badge bg-<% =(pri_qty=="0"?"gray":"red") %>  margin10-l  ">急<% =pri_qty %></span>
                                                                <span class="weui-badge bg-<% =(rowspartLine==0?"gray":"orange") %> margin15-l maxHour" >部<% =rowspartLine %></span>
                                                                <span class="weui-badge bg-orange  margin20-l  "><% =timesHours %></span>
                                                            </div>
                                                            <i class="icon icon-74"></i>
                                                        </div>
                                                        <div class="page-category js-categoryInner a_body"  style="display: none">
                                                            <div>
                                                                <%                                                  

                                                                    foreach (System.Data.DataRow dr in dt_line.Select(exp+" and sj_type='" + sj_type + "'"))
                                                                    {%>
                                                                <a class="weui-cell  weui-cell_access" href="<%=dr["href"] %>">
                                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-blue"></span></div>
                                                                    <div class="weui-cell__hd">
                                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                    </div>
                                                                    <div class="weui-cell__bd f-black" style="font-size: smaller">
                                                                        <span>
                                                                            <%=dr["dh"].ToString() %>
                                                                        </span>
                                                                        <span>
                                                                            <%=dr["workshop"].ToString() %>
                                                                        </span>
                                                                        <span>
                                                                            <%=dr["line"].ToString() %> <%="op"+dr["op"].ToString() %>
                                                                        </span>
                                                                        <br />
                                                                        <span class=""><%=dr["xmh"] %></span>
                                                                        <span><%=dr["ljh"] %></span>
                                                                        <span class="f-blue"><%=dr["sj_qty"].ToString() %></span>件
                                                                        <span ><%=dr["location"].ToString()%></span>
                                                                        <% if (dr["ispart"].ToString() == "部分")
                                                                            { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr  " style="font-size: x-small;">部分</span>
                                                                        <%}; %>
                                                                        <% if (dr["priority"].ToString() == "紧急")
                                                                            { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr  b-red f-red " style="font-size: x-small;">紧急</span>
                                                                        <%}; %>
                                                                        
                                                                        <br />
                                                                        <span class="weui-agree__text span_space">
                                                                            <%=dr["tel"].ToString()+dr["JC_Emp_Name"].ToString() %>
                                                                        </span>
                                                                        <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}", dr["jc_start_date"]) %> </span>
                                                                        <span class="weui-agree__text">时长:<span class="<%=dr["timesColor"] %>"> <%=dr["times"] %></span>
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
                                                <%  }%>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <%----待取回-Equator----%>
                            <div class="weui-form-preview">
                                <%  sys = "Equator";
                                    exp = "sys like '%"+sys+"%'";
                                    dt_line = ViewState["dt_data_4"] as System.Data.DataTable;
                                    rowsCnt1 = dt_line.Select(exp).Length;
                                    rowsCnt2 = dt_line.Select(exp+"and priority='紧急'").Length;
                                    rowsCnt3 = dt_line.Compute("max(timesHours)",exp).ToString();
                                    rowsNg = dt_line.Select(exp+" and jcResult='NG'").Length;
                                    rowsNK = dt_line.Select(exp+" and jcResult='超内控'").Length;
                                %>
                                <ul class="collapse">
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i><% =sys %> 待取回                                                
                                                <span class="weui-badge  bg-<% =(rowsCnt1==0?"gray":"blue") %> margin15-l"><% =rowsCnt1 %></span>
                                                <span class="weui-badge  bg-<% =(rowsCnt2==0?"gray":"red") %> margin15-l">急<% =rowsCnt2 %></span>
                                                <span class="weui-badge  bg-<% =((rowsNg+rowsNK)==0?"gray":"red") %> margin15-l NG ">NG<% =rowsNg %>+<% =rowsNK %></span>
                                                <div class="weui-badge bg-<% =(rowsCnt3==""?"gray":"orange") %> margin15-l maxHour"  ><% =rowsCnt3 %>h</div>

                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells">
                                                <%
                                                    dataView = dt_line.DefaultView;
                                                    dataView.RowFilter = exp;
                                                    dtLineDistinct = dataView.ToTable(true, "sj_type", "apl_qty", "pri_qty", "timesHours");
                                                    foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                                    {
                                                        sj_type = drLine["sj_type"].ToString();
                                                        var apl_qty = drLine["apl_qty"].ToString();
                                                        var pri_qty = drLine["pri_qty"].ToString();
                                                        var timesHours = drLine["timesHours"].ToString() + "h";
                                                        var rowsNgLine = dt_line.Select(exp+" and jcResult='NG' and sj_type='"+sj_type+"'").Length;
                                                        var rowsNKLine = dt_line.Select(exp+" and jcResult='超内控' and sj_type='"+sj_type+"'").Length;
                                                %>
                                                <ul class="collapse2  ">
                                                    <li style="margin-top: 0px; margin-bottom: 0px">
                                                        <div class="weui-flex js-category2" onclick="showorhide(this);">
                                                            <div class="weui-cells__title LH weui-flex__item">
                                                                <i class="icon nav-icon icon-22 color-success"></i><%= sj_type %>
                                                                <span class="weui-badge bg-<% =(apl_qty=="0"?"gray":"blue") %>  margin10-l  "><% =apl_qty %></span>
                                                                <span class="weui-badge bg-<% =(pri_qty=="0"?"gray":"red") %>  margin10-l  ">急<% =pri_qty %></span>
                                                                <span class="weui-badge bg-<% =((rowsNgLine+rowsNKLine)==0?"gray":"red") %>  margin10-l ">NG<% =rowsNgLine.ToString() %>+<% =rowsNKLine.ToString() %></span>
                                                                <span class="weui-badge bg-orange  margin20-l  "><% =timesHours %></span>
                                                            </div>
                                                            <i class="icon icon-74"></i>
                                                        </div>
                                                        <div class="page-category js-categoryInner a_body"  style="display: none">
                                                            <div>
                                                                <%                                                  

                                                                    foreach (System.Data.DataRow dr in dt_line.Select(exp+" and sj_type='" + sj_type + "'"))
                                                                    {%>
                                                                <a class="weui-cell  weui-cell_access" href="<%=dr["href"] %>">
                                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-green"><%=dr["jcResult"].ToString() %></span></div>
                                                                    <div class="weui-cell__hd">
                                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                    </div>
                                                                    <div class="weui-cell__bd f-black" style="font-size: smaller">
                                                                        <span>
                                                                            <%=dr["dh"].ToString() %>
                                                                        </span>
                                                                        <span>
                                                                            <%=dr["workshop"].ToString() %>
                                                                        </span>
                                                                        <span>
                                                                            <%=dr["line"].ToString() %> <%="op"+dr["op"].ToString() %>
                                                                        </span>
                                                                        <br />
                                                                        <span><%=dr["xmh"] %></span>
                                                                        <span><%=dr["ljh"] %></span>
                                                                        <span class="f-blue"><%=dr["sj_qty"].ToString() %></span>件
                                                                        <span ><%=dr["location"].ToString()%></span>
                                                                        <% if (dr["priority"].ToString() == "紧急")
                                                                            { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr  b-red f-red" style="font-size: x-small;">紧急</span>
                                                                        <%} %>
                                                                         <% if (dr["jcResult"].ToString() == "NG")  { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr  b-red f-red" style="font-size: x-small;">NG</span>
                                                                        <%} else if (dr["jcResult"].ToString() == "超内控")  { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr  b-red f-red" style="font-size: x-small;">内控</span>
                                                                        <%} %>
                                                                        <br />
                                                                        <span class="weui-agree__text span_space">
                                                                            <%=dr["tel"].ToString()+dr["Emp_Name"].ToString() %>
                                                                        </span>
                                                                        <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}", dr["rpt_confirm_date"]) %> </span>
                                                                        <span class="weui-agree__text">时长:<span class="<%=dr["timesColor"] %>"> <%=dr["times"] %></span>
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
                                                <%  }%>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
   </div> <div style="border:0px red solid;background-color:white">
                            <%----待检中-压铸----%>
                            <div class="weui-form-preview">
                                <%
                                    exp = "sys like '%压铸实验室%'";
                                    dt_line = ViewState["dt_data_2"] as System.Data.DataTable;
                                    rowsCnt1 = dt_line.Select(exp).Length;
                                    rowsCnt2 = dt_line.Select(exp+" and priority='紧急'").Length;
                                    rowsCnt3 = dt_line.Compute("max(timesHours)",exp).ToString();

                                %>
                                <ul class="collapse">
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>压铸 待检中
                                                <span class="weui-badge  bg-<% =(rowsCnt1==0?"gray":"blue") %> margin15-l"><% =rowsCnt1 %></span>
                                                <span class="weui-badge  bg-<% =(rowsCnt2==0?"gray":"red") %> margin15-l">急<% =rowsCnt2 %></span>
                                                <div class="weui-badge bg-<% =(rowsCnt3==""?"gray":"orange") %> margin15-l maxHour" style="margin-right: 15px;"><% =rowsCnt3 %>h</div>
                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells">
                                                <%
                                                    dataView = dt_line.DefaultView;
                                                    dataView.RowFilter = exp;
                                                    dtLineDistinct = dataView.ToTable(true, "sj_type", "apl_qty", "pri_qty", "timesHours");
                                                    foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                                    {
                                                        sj_type = drLine["sj_type"].ToString();
                                                        var apl_qty = drLine["apl_qty"].ToString();
                                                        var pri_qty = drLine["pri_qty"].ToString();
                                                        var timesHours = drLine["timesHours"].ToString() + "h";
                                                %>
                                                <ul class="collapse2  ">
                                                    <li style="margin-top: 0px; margin-bottom: 0px">
                                                        <div class="weui-flex js-category2" onclick="showorhide(this);">
                                                            <div class="weui-cells__title LH weui-flex__item">
                                                                <i class="icon nav-icon icon-22 color-success"></i><%= sj_type %>
                                                                <span class="weui-badge bg-<% =(apl_qty=="0"?"gray":"blue") %>  margin10-l  "><% =apl_qty %></span>
                                                                <span class="weui-badge bg-<% =(pri_qty=="0"?"gray":"red") %>  margin10-l  ">急<% =pri_qty %></span>
                                                                <span class="weui-badge bg-orange  margin20-l  "><% =timesHours %></span>
                                                            </div>
                                                            <i class="icon icon-74"></i>
                                                        </div>
                                                        <div class="page-category js-categoryInner a_body" style="display: none">
                                                            <div>
                                                                <%                                                  

                                                                    foreach (System.Data.DataRow dr in dt_line.Select("sj_type='" + sj_type + "'"))
                                                                    {%>
                                                                <a class="weui-cell  weui-cell_access " href="<%=dr["href"] %>">
                                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-orange"></span></div>
                                                                    <div class="weui-cell__hd">
                                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                    </div>
                                                                    <div class="weui-cell__bd f-black" style="font-size: smaller">
                                                                        <span>
                                                                            <%=dr["dh"].ToString() %>
                                                                        </span>
                                                                        <span>
                                                                            <%=dr["workshop"].ToString() %>
                                                                        </span>
                                                                        <span>
                                                                            <%=dr["line"].ToString() %> <%="op"+dr["op"].ToString() %>
                                                                        </span>
                                                                        <br />
                                                                        <span class=""><%=dr["xmh"] %></span>
                                                                        <span><%=dr["ljh"] %></span>
                                                                        <span class="f-blue"><%=dr["sj_qty"].ToString()+"" %></span>件
                                                                        <span ><%=dr["location"].ToString()%></span>
                                                                        <% if (dr["priority"].ToString() == "紧急")
                                                                            { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr  b-red f-red   margin10-l" style="font-size: x-small;">紧急</span>
                                                                        <%} %>
                                                                        <br />
                                                                        <span class="weui-agree__text span_space">
                                                                            <%=dr["tel"].ToString()+dr["Emp_Name"].ToString() %>
                                                                        </span>
                                                                        <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}", dr["apply_date"]) %> </span>
                                                                        <span class="weui-agree__text">时长:<span class="<%=dr["timesColor"] %>"> <%=dr["times"] %></span>
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
                                                <%  }%>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <%----检测中-压铸----%>
                            <div class="weui-form-preview">
                                <%
                                    exp = "sys like '%压铸实验室%'";
                                    dt_line = ViewState["dt_data_3"] as System.Data.DataTable;
                                    rowsCnt1 = dt_line.Select(exp).Length;
                                    rowsCnt2 = dt_line.Select(exp+" and priority='紧急'").Length;
                                    rowsCnt3 = dt_line.Compute("max(timesHours)",exp).ToString();
                                    rowspart = dt_line.Select(exp+" and ispart='部分'").Length;
                                %>
                                <ul class="collapse">
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>压铸 检测中                                                
                                                <span class="weui-badge  bg-<% =(rowsCnt1==0?"gray":"blue") %> margin15-l"><% =rowsCnt1 %></span>                                                
                                                <span class="weui-badge  bg-<% =(rowsCnt2==0?"gray":"red") %> margin15-l">急<% =rowsCnt2 %></span>
                                                <span class="weui-badge bg-<% =(rowspart==0?"gray":"orange") %> margin15-l Part" >部<% =rowspart %></span>
                                                <div class="weui-badge bg-<% =(rowsCnt3==""?"gray":"orange") %> margin15-l maxHour" ><% =rowsCnt3 %>h</div>
                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells">
                                                <%
                                                    dataView = dt_line.DefaultView;
                                                    dataView.RowFilter = exp;
                                                    dtLineDistinct = dataView.ToTable(true, "sj_type", "apl_qty", "pri_qty", "timesHours");
                                                    foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                                    {
                                                        sj_type = drLine["sj_type"].ToString();
                                                        var apl_qty = drLine["apl_qty"].ToString();
                                                        var pri_qty = drLine["pri_qty"].ToString();
                                                        var timesHours = drLine["timesHours"].ToString() + "h";
                                                        var rowspartLine = dt_line.Select(exp+" and ispart='部分' and sj_type='"+sj_type+"'").Length;
                                                %>
                                                <ul class="collapse2  ">
                                                    <li style="margin-top: 0px; margin-bottom: 0px">
                                                        <div class="weui-flex js-category2" onclick="showorhide(this);">
                                                            <div class="weui-cells__title LH weui-flex__item">
                                                                <i class="icon nav-icon icon-22 color-success"></i><%= sj_type %>
                                                                <span class="weui-badge bg-<% =(apl_qty=="0"?"gray":"blue") %>  margin10-l  "><% =apl_qty %></span>                                                                
                                                                <span class="weui-badge bg-<% =(pri_qty=="0"?"gray":"red") %>  margin10-l  ">急<% =pri_qty %></span>
                                                                <span class="weui-badge bg-<% =(rowspartLine==0?"gray":"orange") %> margin15-l maxHour" >部<% =rowspartLine %></span>
                                                                <span class="weui-badge bg-orange  margin20-l  "><% =timesHours %></span>
                                                            </div>
                                                            <i class="icon icon-74"></i>
                                                        </div>
                                                        <div class="page-category js-categoryInner a_body"  style="display: none">
                                                            <div>
                                                                <%                                                  

                                                                    foreach (System.Data.DataRow dr in dt_line.Select(exp+" and sj_type='" + sj_type + "'"))
                                                                    {%>
                                                                <a class="weui-cell  weui-cell_access" href="<%=dr["href"] %>">
                                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-blue"></span></div>
                                                                    <div class="weui-cell__hd">
                                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                    </div>
                                                                    <div class="weui-cell__bd f-black" style="font-size: smaller">
                                                                        <span>
                                                                            <%=dr["dh"].ToString() %>
                                                                        </span>
                                                                        <span>
                                                                            <%=dr["workshop"].ToString() %>
                                                                        </span>
                                                                        <span>
                                                                            <%=dr["line"].ToString() %> <%="op"+dr["op"].ToString() %>
                                                                        </span>
                                                                        <br />
                                                                        <span class=""><%=dr["xmh"] %></span>
                                                                        <span><%=dr["ljh"] %></span>
                                                                        <span class="f-blue"><%=dr["sj_qty"].ToString() %></span>件
                                                                        <span ><%=dr["location"].ToString()%></span>
                                                                        <% if (dr["ispart"].ToString() == "部分")
                                                                            { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr  " style="font-size: x-small;">部分</span>
                                                                        <%}; %>
                                                                        <% if (dr["priority"].ToString() == "紧急")
                                                                            { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr  b-red f-red " style="font-size: x-small;">紧急</span>
                                                                        <%}; %>
                                                                        
                                                                        <br />
                                                                        <span class="weui-agree__text span_space">
                                                                            <%=dr["tel"].ToString()+dr["JC_Emp_Name"].ToString() %>
                                                                        </span>
                                                                        <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}", dr["jc_start_date"]) %> </span>
                                                                        <span class="weui-agree__text">时长:<span class="<%=dr["timesColor"] %>"> <%=dr["times"] %></span>
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
                                                <%  }%>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <%----待取回-压铸----%>
                            <div class="weui-form-preview">
                                <%  sys = "压铸";
                                    exp = "sys like '%"+sys+"%'";
                                    dt_line = ViewState["dt_data_4"] as System.Data.DataTable;
                                    rowsCnt1 = dt_line.Select(exp).Length;
                                    rowsCnt2 = dt_line.Select(exp+"and priority='紧急'").Length;
                                    rowsCnt3 = dt_line.Compute("max(timesHours)",exp).ToString();
                                    rowsNg = dt_line.Select(exp+" and jcResult='NG'").Length;
                                    rowsNK = dt_line.Select(exp+" and jcResult='超内控'").Length;
                                %>
                                <ul class="collapse">
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i><% =sys %> 待取回                                                
                                                <span class="weui-badge  bg-<% =(rowsCnt1==0?"gray":"blue") %> margin15-l"><% =rowsCnt1 %></span>
                                                <span class="weui-badge  bg-<% =(rowsCnt2==0?"gray":"red") %> margin15-l">急<% =rowsCnt2 %></span>
                                                <span class="weui-badge  bg-<% =((rowsNg+rowsNK)==0?"gray":"red") %> margin15-l NG ">NG<% =rowsNg %>+<% =rowsNK %></span>
                                                <div class="weui-badge bg-<% =(rowsCnt3==""?"gray":"orange") %> margin15-l maxHour"  ><% =rowsCnt3 %>h</div>

                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells">
                                                <%
                                                    dataView = dt_line.DefaultView;
                                                    dataView.RowFilter = exp;
                                                    dtLineDistinct = dataView.ToTable(true, "sj_type", "apl_qty", "pri_qty", "timesHours");
                                                    foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                                    {
                                                        sj_type = drLine["sj_type"].ToString();
                                                        var apl_qty = drLine["apl_qty"].ToString();
                                                        var pri_qty = drLine["pri_qty"].ToString();
                                                        var timesHours = drLine["timesHours"].ToString() + "h";
                                                        var rowsNgLine = dt_line.Select(exp+" and jcResult='NG' and sj_type='"+sj_type+"'").Length;
                                                        var rowsNKLine = dt_line.Select(exp+" and jcResult='超内控' and sj_type='"+sj_type+"'").Length;
                                                %>
                                                <ul class="collapse2  ">
                                                    <li style="margin-top: 0px; margin-bottom: 0px">
                                                        <div class="weui-flex js-category2" onclick="showorhide(this);">
                                                            <div class="weui-cells__title LH weui-flex__item">
                                                                <i class="icon nav-icon icon-22 color-success"></i><%= sj_type %>
                                                                <span class="weui-badge bg-<% =(apl_qty=="0"?"gray":"blue") %>  margin10-l  "><% =apl_qty %></span>
                                                                <span class="weui-badge bg-<% =(pri_qty=="0"?"gray":"red") %>  margin10-l  ">急<% =pri_qty %></span>
                                                                <span class="weui-badge bg-<% =((rowsNgLine+rowsNKLine)==0?"gray":"red") %>  margin10-l ">NG<% =rowsNgLine.ToString() %>+<% =rowsNKLine.ToString() %></span>
                                                                <span class="weui-badge bg-orange  margin20-l  "><% =timesHours %></span>
                                                            </div>
                                                            <i class="icon icon-74"></i>
                                                        </div>
                                                        <div class="page-category js-categoryInner a_body"  style="display: none">
                                                            <div>
                                                                <%                                                  

                                                                    foreach (System.Data.DataRow dr in dt_line.Select(exp+" and sj_type='" + sj_type + "'"))
                                                                    {%>
                                                                <a class="weui-cell  weui-cell_access" href="<%=dr["href"] %>">
                                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-green"><%=dr["jcResult"].ToString() %></span></div>
                                                                    <div class="weui-cell__hd">
                                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                    </div>
                                                                    <div class="weui-cell__bd f-black" style="font-size: smaller">
                                                                        <span>
                                                                            <%=dr["dh"].ToString() %>
                                                                        </span>
                                                                        <span>
                                                                            <%=dr["workshop"].ToString() %>
                                                                        </span>
                                                                        <span>
                                                                            <%=dr["line"].ToString() %> <%="op"+dr["op"].ToString() %>
                                                                        </span>
                                                                        <br />
                                                                        <span><%=dr["xmh"] %></span>
                                                                        <span><%=dr["ljh"] %></span>
                                                                        <span class="f-blue"><%=dr["sj_qty"].ToString() %></span>件
                                                                        <span ><%=dr["location"].ToString()%></span>
                                                                        <% if (dr["priority"].ToString() == "紧急")
                                                                            { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr  b-red f-red" style="font-size: x-small;">紧急</span>
                                                                        <%} %>
                                                                         <% if (dr["jcResult"].ToString() == "NG")  { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr  b-red f-red" style="font-size: x-small;">NG</span>
                                                                        <%} else if (dr["jcResult"].ToString() == "超内控")  { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr  b-red f-red" style="font-size: x-small;">内控</span>
                                                                        <%} %>
                                                                        <br />
                                                                        <span class="weui-agree__text span_space">
                                                                            <%=dr["tel"].ToString()+dr["Emp_Name"].ToString() %>
                                                                        </span>
                                                                        <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}", dr["rpt_confirm_date"]) %> </span>
                                                                        <span class="weui-agree__text">时长:<span class="<%=dr["timesColor"] %>"> <%=dr["times"] %></span>
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
                                                <%  }%>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
       </div><div style="border:0px red solid;background-color:white">
                            <%----检测完成（24H内）-机加----%>
                            <div class="weui-form-preview">
                                <ul class="collapse">
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <%
                                                exp = " sys like '%机加实验室%' ";
                                                dt_line = ViewState["dt_data_9"] as System.Data.DataTable;
                                                rowsCnt1 = dt_line.Select(exp).Length;
                                                rowsCnt2 = dt_line.Select(exp+" and priority='紧急'").Length;
                                                rowsCnt3 = dt_line.Compute("max(timesHours)",exp).ToString();
                                                rowsNg = dt_line.Select(exp+" and jcResult='NG'").Length;
                                                rowsNK = dt_line.Select(exp+" and jcResult='超内控'").Length;
                                            %>
                                            <div class="weui-cells__title  weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>机加 检测完成（24小时内）                                                 
                                                <span class="weui-badge  bg-<% =(rowsCnt1==0?"gray":"blue") %> margin5-l"><% =rowsCnt1 %></span>
                                                <span class="weui-badge  bg-<% =(rowsCnt2==0?"gray":"red") %> margin5-l">急<% =rowsCnt2 %></span>
                                                <span class="weui-badge  bg-<% =((rowsNg+rowsNK)==0?"gray":"red") %> margin5-l NG">NG<% =rowsNg.ToString() %>+<% =rowsNK.ToString() %></span>
                                                <%--<div class="weui-badge bg-orange margin15-l maxHour" style="margin-right: 15px;"><% =rowsCnt3 %>H</div>--%>
                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells">
                                                <%
                                                    dataView = dt_line.DefaultView;
                                                    dataView.RowFilter = exp;
                                                    dtLineDistinct = dataView.ToTable(true, "sj_type", "apl_qty", "pri_qty", "timesHours");
                                                    foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                                    {
                                                        sj_type = drLine["sj_type"].ToString();
                                                        var apl_qty = drLine["apl_qty"].ToString();
                                                        var pri_qty = drLine["pri_qty"].ToString();
                                                        var timesHours = drLine["timesHours"].ToString() + "h";
                                                        var rowsNgLine = dt_line.Select(exp+" and jcResult='NG' and sj_type='"+sj_type+"'").Length;
                                                        var rowsNKLine = dt_line.Select(exp+" and jcResult='超内控' and sj_type='"+sj_type+"'").Length;
                                                %>
                                                <ul class="collapse2  ">
                                                    <li style="margin-top: 0px; margin-bottom: 0px">
                                                        <div class="weui-flex js-category2" onclick="showorhide(this);">
                                                            <div class="weui-cells__title LH weui-flex__item">
                                                                <i class="icon nav-icon icon-22 color-success"></i><%= sj_type %>
                                                                <span class="weui-badge bg-<% =(apl_qty=="0"?"gray":"blue") %>  margin10-l  "><% =apl_qty %></span>
                                                                <span class="weui-badge bg-<% =(pri_qty=="0"?"gray":"red") %>  margin10-l  ">急<% =pri_qty %></span>
                                                                <span class="weui-badge bg-<% =((rowsNgLine+rowsNKLine)==0?"gray":"red") %>  margin10-l  ">NG<% =rowsNgLine.ToString() %>+<% =rowsNKLine.ToString() %></span>
                                                                <span class="weui-badge bg-orange  margin20-l  "><% =timesHours %></span>
                                                            </div>
                                                            <i class="icon icon-74"></i>
                                                        </div>
                                                        <div class="page-category js-categoryInner a_body" style="display: none">
                                                            <div>
                                                                <%                                                  

                                                                    foreach (System.Data.DataRow dr in dt_line.Select(exp+" and sj_type='" + sj_type + "'"))
                                                                    {%>
                                                                <a class="weui-cell  weui-cell_access" href="<%=dr["href"] %>">
                                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"><%=dr["jcResult"].ToString()%></span></div>
                                                                    <div class="weui-cell__hd">
                                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                    </div>
                                                                    <div class="weui-cell__bd f-black" style="font-size: smaller">
                                                                        <span>
                                                                            <%=dr["dh"].ToString() %>
                                                                        </span>
                                                                        <span>
                                                                            <%=dr["workshop"].ToString() %>
                                                                        </span>
                                                                        <span>
                                                                            <%=dr["line"].ToString() %> <%="op"+dr["op"].ToString() %>
                                                                        </span>
                                                                        <br />
                                                                        <span><%=dr["xmh"] %></span>
                                                                        <span><%=dr["ljh"] %></span>
                                                                        <span class="f-blue"><%=dr["sj_qty"].ToString()%></span>件
                                                                        <span ><%=dr["location"].ToString()%></span>
                                                                        <% if (dr["priority"].ToString() == "紧急")
                                                                            { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr b-red f-red" style="font-size: x-small;">紧急</span>
                                                                        <%} %>
                                                                        <% if (dr["jcResult"].ToString().ToUpper() == "NG")
                                                                            { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr b-red f-red" style="font-size: x-small;">NG</span>
                                                                        <%} else if (dr["jcResult"].ToString().ToUpper() == "超内控")
                                                                            { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr b-red f-red" style="font-size: x-small;">内控</span>
                                                                        <%} %>
                                                                        <br />
                                                                        <span class="weui-agree__text span_space">
                                                                            <%=dr["tel"].ToString()+dr["Emp_Name"].ToString() %>
                                                                        </span>
                                                                        <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}", dr["apply_date"]) %> </span>
                                                                        <span class="weui-agree__text">时长:<span class="f-deepfont"> <%=dr["times"] %></span>
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
                                                <%  }%>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <%----检测完成（24H内）-Equator----%>
                            <div class="weui-form-preview">
                                <ul class="collapse">
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <%
                                                exp = " sys like '%Equator%' ";
                                                dt_line = ViewState["dt_data_9"] as System.Data.DataTable;
                                                rowsCnt1 = dt_line.Select(exp).Length;
                                                rowsCnt2 = dt_line.Select(exp+" and priority='紧急'").Length;
                                                rowsCnt3 = dt_line.Compute("max(timesHours)",exp).ToString();
                                                rowsNg = dt_line.Select(exp+" and jcResult='NG'").Length;
                                                rowsNK = dt_line.Select(exp+" and jcResult='超内控'").Length;
                                            %>
                                            <div class="weui-cells__title  weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>Equator 检测完成（24小时内）                                                 
                                                <span class="weui-badge  bg-<% =(rowsCnt1==0?"gray":"blue") %> margin5-l"><% =rowsCnt1 %></span>
                                                <span class="weui-badge  bg-<% =(rowsCnt2==0?"gray":"red") %> margin5-l">急<% =rowsCnt2 %></span>
                                                <span class="weui-badge  bg-<% =((rowsNg+rowsNK)==0?"gray":"red") %> margin5-l NG">NG<% =rowsNg.ToString() %>+<% =rowsNK.ToString() %></span>
                                                <%--<div class="weui-badge bg-orange margin15-l maxHour" style="margin-right: 15px;"><% =rowsCnt3 %>H</div>--%>
                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells">
                                                <%
                                                    dataView = dt_line.DefaultView;
                                                    dataView.RowFilter = exp;
                                                    dtLineDistinct = dataView.ToTable(true, "sj_type", "apl_qty", "pri_qty", "timesHours");
                                                    foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                                    {
                                                        sj_type = drLine["sj_type"].ToString();
                                                        var apl_qty = drLine["apl_qty"].ToString();
                                                        var pri_qty = drLine["pri_qty"].ToString();
                                                        var timesHours = drLine["timesHours"].ToString() + "h";
                                                        var rowsNgLine = dt_line.Select(exp+" and jcResult='NG' and sj_type='"+sj_type+"'").Length;
                                                        var rowsNKLine = dt_line.Select(exp+" and jcResult='超内控' and sj_type='"+sj_type+"'").Length;
                                                %>
                                                <ul class="collapse2  ">
                                                    <li style="margin-top: 0px; margin-bottom: 0px">
                                                        <div class="weui-flex js-category2" onclick="showorhide(this);">
                                                            <div class="weui-cells__title LH weui-flex__item">
                                                                <i class="icon nav-icon icon-22 color-success"></i><%= sj_type %>
                                                                <span class="weui-badge bg-<% =(apl_qty=="0"?"gray":"blue") %>  margin10-l  "><% =apl_qty %></span>
                                                                <span class="weui-badge bg-<% =(pri_qty=="0"?"gray":"red") %>  margin10-l  ">急<% =pri_qty %></span>
                                                                <span class="weui-badge bg-<% =((rowsNgLine+rowsNKLine)==0?"gray":"red") %>  margin10-l  ">NG<% =rowsNgLine.ToString() %>+<% =rowsNKLine.ToString() %></span>
                                                                <span class="weui-badge bg-orange  margin20-l  "><% =timesHours %></span>
                                                            </div>
                                                            <i class="icon icon-74"></i>
                                                        </div>
                                                        <div class="page-category js-categoryInner a_body" style="display: none">
                                                            <div>
                                                                <%                                                  

                                                                    foreach (System.Data.DataRow dr in dt_line.Select(exp+" and sj_type='" + sj_type + "'"))
                                                                    {%>
                                                                <a class="weui-cell  weui-cell_access" href="<%=dr["href"] %>">
                                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"><%=dr["jcResult"].ToString()%></span></div>
                                                                    <div class="weui-cell__hd">
                                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                    </div>
                                                                    <div class="weui-cell__bd f-black" style="font-size: smaller">
                                                                        <span>
                                                                            <%=dr["dh"].ToString() %>
                                                                        </span>
                                                                        <span>
                                                                            <%=dr["workshop"].ToString() %>
                                                                        </span>
                                                                        <span>
                                                                            <%=dr["line"].ToString() %> <%="op"+dr["op"].ToString() %>
                                                                        </span>
                                                                        <br />
                                                                        <span><%=dr["xmh"] %></span>
                                                                        <span><%=dr["ljh"] %></span>
                                                                        <span class="f-blue"><%=dr["sj_qty"].ToString()%></span>件
                                                                        <span ><%=dr["location"].ToString()%></span>
                                                                        <% if (dr["priority"].ToString() == "紧急")
                                                                            { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr b-red f-red" style="font-size: x-small;">紧急</span>
                                                                        <%} %>
                                                                        <% if (dr["jcResult"].ToString().ToUpper() == "NG")
                                                                            { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr b-red f-red" style="font-size: x-small;">NG</span>
                                                                        <%} else if (dr["jcResult"].ToString().ToUpper() == "超内控")
                                                                            { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr b-red f-red" style="font-size: x-small;">内控</span>
                                                                        <%} %>
                                                                        <br />
                                                                        <span class="weui-agree__text span_space">
                                                                            <%=dr["tel"].ToString()+dr["Emp_Name"].ToString() %>
                                                                        </span>
                                                                        <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}", dr["apply_date"]) %> </span>
                                                                        <span class="weui-agree__text">时长:<span class="f-deepfont"> <%=dr["times"] %></span>
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
                                                <%  }%>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <%----检测完成（24H内）-压铸----%>
                            <div class="weui-form-preview">
                                <ul class="collapse">
                                    <li class="js-show">
                                        <div class="weui-flex js-category">
                                            <%
                                                exp = " sys like '%压铸实验室%' ";
                                                dt_line = ViewState["dt_data_9"] as System.Data.DataTable;
                                                rowsCnt1 = dt_line.Select(exp).Length;
                                                rowsCnt2 = dt_line.Select(exp+" and priority='紧急'").Length;
                                                rowsCnt3 = dt_line.Compute("max(timesHours)",exp).ToString();
                                                rowsNg = dt_line.Select(exp+" and jcResult='NG'").Length;
                                                rowsNK = dt_line.Select(exp+" and jcResult='超内控'").Length;
                                            %>
                                            <div class="weui-cells__title  weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>压铸 检测完成（24小时内）                                                 
                                                <span class="weui-badge  bg-<% =(rowsCnt1==0?"gray":"blue") %> margin5-l"><% =rowsCnt1 %></span>
                                                <span class="weui-badge  bg-<% =(rowsCnt2==0?"gray":"red") %> margin5-l">急<% =rowsCnt2 %></span>
                                                <span class="weui-badge  bg-<% =((rowsNg+rowsNK)==0?"gray":"red") %> margin5-l NG">NG<% =rowsNg.ToString() %>+<% =rowsNK.ToString() %></span>
                                                <%--<div class="weui-badge bg-orange margin15-l maxHour" style="margin-right: 15px;"><% =rowsCnt3 %>H</div>--%>
                                            </div>
                                            <i class="icon icon-35"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells">
                                                <%
                                                    dataView = dt_line.DefaultView;
                                                    dataView.RowFilter = exp;
                                                    dtLineDistinct = dataView.ToTable(true, "sj_type", "apl_qty", "pri_qty", "timesHours");
                                                    foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                                    {
                                                        sj_type = drLine["sj_type"].ToString();
                                                        var apl_qty = drLine["apl_qty"].ToString();
                                                        var pri_qty = drLine["pri_qty"].ToString();
                                                        var timesHours = drLine["timesHours"].ToString() + "h";
                                                        var rowsNgLine = dt_line.Select(exp+" and jcResult='NG' and sj_type='"+sj_type+"'").Length;
                                                        var rowsNKLine = dt_line.Select(exp+" and jcResult='超内控' and sj_type='"+sj_type+"'").Length;
                                                %>
                                                <ul class="collapse2  ">
                                                    <li style="margin-top: 0px; margin-bottom: 0px">
                                                        <div class="weui-flex js-category2" onclick="showorhide(this);">
                                                            <div class="weui-cells__title LH weui-flex__item">
                                                                <i class="icon nav-icon icon-22 color-success"></i><%= sj_type %>
                                                                <span class="weui-badge bg-<% =(apl_qty=="0"?"gray":"blue") %>  margin10-l  "><% =apl_qty %></span>
                                                                <span class="weui-badge bg-<% =(pri_qty=="0"?"gray":"red") %>  margin10-l  ">急<% =pri_qty %></span>
                                                                <span class="weui-badge bg-<% =((rowsNgLine+rowsNKLine)==0?"gray":"red") %>  margin10-l  ">NG<% =rowsNgLine.ToString() %>+<% =rowsNKLine.ToString() %></span>
                                                                <span class="weui-badge bg-orange  margin20-l  "><% =timesHours %></span>
                                                            </div>
                                                            <i class="icon icon-74"></i>
                                                        </div>
                                                        <div class="page-category js-categoryInner a_body" style="display: none">
                                                            <div>
                                                                <%                                                  

                                                                    foreach (System.Data.DataRow dr in dt_line.Select(exp+" and sj_type='" + sj_type + "'"))
                                                                    {%>
                                                                <a class="weui-cell  weui-cell_access" href="<%=dr["href"] %>">
                                                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"><%=dr["jcResult"].ToString()%></span></div>
                                                                    <div class="weui-cell__hd">
                                                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                    </div>
                                                                    <div class="weui-cell__bd f-black" style="font-size: smaller">
                                                                        <span>
                                                                            <%=dr["dh"].ToString() %>
                                                                        </span>
                                                                        <span>
                                                                            <%=dr["workshop"].ToString() %>
                                                                        </span>
                                                                        <span>
                                                                            <%=dr["line"].ToString() %> <%="op"+dr["op"].ToString() %>
                                                                        </span>
                                                                        <br />
                                                                        <span><%=dr["xmh"] %></span>
                                                                        <span><%=dr["ljh"] %></span>
                                                                        <span class="f-blue"><%=dr["sj_qty"].ToString()%></span>件
                                                                        <span ><%=dr["location"].ToString()%></span>
                                                                        <% if (dr["priority"].ToString() == "紧急")
                                                                            { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr b-red f-red" style="font-size: x-small;">紧急</span>
                                                                        <%} %>
                                                                        <% if (dr["jcResult"].ToString().ToUpper() == "NG")
                                                                            { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr b-red f-red" style="font-size: x-small;">NG</span>
                                                                        <%} else if (dr["jcResult"].ToString().ToUpper() == "超内控")
                                                                            { %>
                                                                        <span class="weui-mark-rt- weui-badge  weui-badge-tr b-red f-red" style="font-size: x-small;">内控</span>
                                                                        <%} %>
                                                                        <br />
                                                                        <span class="weui-agree__text span_space">
                                                                            <%=dr["tel"].ToString()+dr["Emp_Name"].ToString() %>
                                                                        </span>
                                                                        <span class="weui-agree__text"><%=string.Format("{0:MM-dd HH:mm}", dr["apply_date"]) %> </span>
                                                                        <span class="weui-agree__text">时长:<span class="f-deepfont"> <%=dr["times"] %></span>
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
