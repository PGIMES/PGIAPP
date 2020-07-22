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
                var ipart = $(this).find("a:not(.hide) :contains('部分')").length;

                var obj = $(this).closest('li').children(".js-category").find("span").first(); //蓝标题span
                var objpart = $(this).closest('li').children(".js-category").find("span").eq(1); //黄标题span
                 

                $(obj).text(rowcount-ipart);
                $(objpart).text("部"+ipart);
                 

                if (rowcount - ipart == 0) {
                    $(obj).addClass("bg-gray").removeClass("bg-blue")
                }
                else {
                    $(obj).addClass("bg-blue").removeClass("bg-gray")
                }
                //部分
                if (ipart == 0) {
                    $(objpart).addClass("bg-gray").removeClass("bg-orange")
                }
                else {
                    $(objpart).addClass("bg-orange").removeClass("bg-gray")
                }
            });
            //组装件数量
           

        }
        function cancel() {
            $('.weui-cell').removeClass("hide");
            $('.weui-cell').siblings('.weui-cells__title').removeClass("hide");
             
            $('ul li ul li').children(".js-category2").css("display", "")
            showBlockCount();
        }

        function clear() {
            $('#searchInput').val('');
            $('.weui-cell').removeClass("hide");
            $('.weui-cell').siblings('.weui-cells__title').removeClass("hide");
            $('ul li ul li').children(".js-category2").css("display", "")
            showBlockCount();
        }

        //组装件显示折叠
        function showorhide(obj) {
            var divLineBody=$(obj)[0].nextElementSibling;
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
                                    int rowscount = dt_line.Rows.Count;
                                %>
                                <ul class="collapse">
                                    <li>
                                        <div class="weui-flex js-category">
                                            <div class="weui-cells__title weui-flex__item">
                                                <i class="icon nav-icon icon-49"></i>入库完成(24小时内)
                                                <span class="weui-badge  bg-<% =(rowscount==0?"gray":"blue") %> margin20-l " 
                                                    style="margin-right: 15px;"><% =rowscount %></span>
                                            </div>
                                            <i class="icon icon-74"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells">
                                                <%                                          
                                                     System.Data.DataView dataView = dt_line.DefaultView;
                                                     System.Data.DataTable dtLineDistinct = dataView.ToTable(true, "pgino");
                                                    foreach (System.Data.DataRow drLine in dtLineDistinct.Rows)
                                                    {
                                                        string pgino = drLine["pgino"].ToString();
                                                %>
                                                <ul class="collapse2 ">
                                                    <li class=" LH " style="margin-top: 0px; margin-bottom: 0px">
                                                        <div class="weui-flex js-category2 " onclick="showorhide(this);">
                                                            <div class="weui-cells__title weui-flex__item LH" id="<%=pgino %>LH5">
                                                                <i class="icon nav-icon icon-22 color-success"></i><%=pgino %>
                                                                <span class="weui-badge bg-blue margin20-l " style="margin-right: 15px;">
                                                                    <% =(ViewState["dt_data"] as System.Data.DataTable)
                                                                            .Select("pgino='" + pgino + "'").Count() %>
                                                                </span>
                                                            </div>
                                                            <i class="icon icon-74 right"></i>
                                                        </div>
                                                        <div class="page-category js-categoryInner a_body" style="display: none">
                                                            <%                                                  
                                                                System.Data.DataTable dt = ViewState["dt_data"] as System.Data.DataTable;
                                                                foreach (System.Data.DataRow dr in dt.Select("pgino='" + pgino + "'"))
                                                                { %>
                                                            <a class="weui-cell  weui-cell_access " style="color: black">
                                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                                                <div class="weui-cell__hd">
                                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                                </div>
                                                                <div class="weui-cell__bd " style="font-size: smaller">
                                                                    <span class="margin10-r">
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
                                                                    </span>
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