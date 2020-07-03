<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bhgp_Apply_list_V1.aspx.cs" Inherits="WorkOrder_bhgp_Apply_list_V1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>不合格监视</title>
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

            $('#t2').tab({
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

            $('#searchInput').bind('input propertychange', function () {

                var text = $("#searchInput").val();
                $('.weui-cell').each(function () {
                    var $self = $(this);
                    var flag = $self.text().search(text)
                    if (flag > -1) {
                        $self.removeClass("hide"); //$self.siblings('.weui-cells__title').addClass("hide");
                    } else {
                        $self.addClass("hide"); //$self.siblings('.weui-cells__title').addClass("hide");

                    }
                });

                showBlockCount();
            });
        });
        //显示数量
        function showBlockCount() {
            $(".weui-form-preview>.weui-cells").each(function (i, item) {
                var rowcount = $(this).find("a:not(.hide)").length;
                // debugger;
                var obj = $(item).prev().children().last();
                $(obj).text(rowcount);
                if (rowcount == 0) {
                    $(obj).addClass("bg-gray").removeClass("bg-blue")
                }
                else {
                    $(obj).addClass("bg-blue").removeClass("bg-gray")
                }
            });
        }

        function cancel() {
            $('.weui-cell').removeClass("hide");
            //$('.weui-cell').siblings('.weui-cells__title').removeClass("hide");
            showBlockCount();
        }

        function clear() {
            $('#searchInput').val('');
            $('.weui-cell').removeClass("hide");
            //$('.weui-cell').siblings('.weui-cells__title').removeClass("hide");
            showBlockCount();
        }
    </script>
    <script>
        function deal(stepid, workorder, workorder_f, workorder_gl) {
            //alert(stepid);

            if ("<%=_workshop %>" == "二车间" || "<%=_workshop %>" == "四车间") {
                if (stepid == "0002") {//--检验处置
                    window.location.href = "/workorder/bhgp_Apply_V1.aspx?workorder=" + workorder + "&workorder_f=" + workorder_f + "&workshop=<%=_workshop %>";
                } else if (stepid == "9998") {//--待入库
                    window.location.href = "/workorder/CKSH.aspx?workorder_f=" + workorder_f + "&dh=" + workorder_gl + "&workshop=<%=_workshop %>";
                }
                else {
                    window.location.href = "/workorder/bhgp_sign_V1.aspx?stepid=" + stepid + "&workorder=" + workorder + "&workorder_f=" + workorder_f + "&workshop=<%=_workshop %>";
                }
            }
            if ("<%=_workshop %>" == "三车间") {
                if (stepid == "0002") {//--检验处置
                    window.location.href = "/workorder/bhgp_Apply_yz.aspx?workorder=" + workorder + "&workorder_f=" + workorder_f + "&workshop=<%=_workshop %>";
                } else if (stepid == "9998") {//--待入库
                    window.location.href = "/workorder/CKSH.aspx?workorder_f=" + workorder_f + "&dh=" + workorder_gl + "&workshop=<%=_workshop %>";
                }
                else {
                    window.location.href = "/workorder/bhgp_sign_yz.aspx?stepid=" + stepid + "&workorder=" + workorder + "&workorder_f=" + workorder_f + "&workshop=<%=_workshop %>";
                }
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
        <div class="page">
            <div class="page__bd" id="t2" style="height: 100%;">
                <div class="weui-tab">
                    <div class="weui-navbar">
                        <div href="#tab1" class="weui-navbar__item weui-bar__item_on">
                            不合格监视
                        </div>
                        <div href="#tab2" class="weui-navbar__item">
                            我的不合格
                        </div>
                    </div>

                    <div class="weui-tab__panel" style="background-color:lightgray">
                        <%--=======不合格监视-----%>
                        <div id="tab1" class="weui-tab__content">
                            
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  ">
                                    <i class="icon nav-icon icon-49"></i>检验处置
                                    <%--<asp:Label ID="Label_02" runat="server" Text="Label"></asp:Label>--%>
                                    <span class="weui-badge  bg-<% =(count_02==0?"gray":"blue") %>"><% =count_02 %></span>
                                </div>
                                <div class="weui-cells" id="_02">
                                    <asp:Repeater runat="server" ID="list_02" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>')>
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                        <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                        <%# "单号"+Eval("workorder") %>
                                                        <span style="display:<%# Eval("workorder_f").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 分单号" + Eval("workorder_f") %>
                                                        </span>
                                                        <span style="display:<%# Eval("workorder_f_a").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 父单号" + Eval("workorder_f_a") %>
                                                        </span>
                                                        <span style="display:<%# (Eval("stepid").ToString()=="9998" || Eval("stepid").ToString()=="9999")?"inline-block":"none"%>; ">
                                                            <%# " 关联单号" + Eval("workorder_gl") %>
                                                        </span>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("pgino") + "," + Eval("pn") + "," +Eval("op") + "" +Eval("op_descr")  %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <span style="display:<%# Eval("reason_code").ToString()!=""?"inline-block":"none"%>;"><%# Eval("reason_code") + "" + Eval("reason") + "," %></span>
                                                        <%# Eval("cur_qty")+"件" %>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("type").ToString()=="部分"?"#F7CF07":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                            <%#Eval("type") %>
                                                        </span>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("result").ToString()=="无法判定"?"#F7CF07":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# (Eval("result").ToString()=="无法判定")?"inline-block":"none"%>; ">
                                                            <%#Eval("result") %>
                                                        </span>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("result").ToString()=="返工"?"red":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# (Eval("result").ToString()=="返工" || Eval("result").ToString()=="分选")?"inline-block":"none"%>; ">
                                                            <%#Eval("result") %>
                                                        </span>
                                                    </span>
                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                            <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
                                                            <%-- <font class='f-blue'>"+Eval("times")+"</font>--%>
                                                            <span style="color:<%# Eval("is_chao_time").ToString()=="Y"?"red":"#10AEFF" %>;">
                                                                <%# Eval("times") %>
                                                            </span>
                                                        </span>
                                                </div>
                                            </a>

                                        </ItemTemplate>
                                    </asp:Repeater>
                                       
                                </div>
                            </div>
                                                        
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  ">
                                    <i class="icon nav-icon icon-49"></i>质量工程师
                                    <%--<asp:Label ID="Label_03" runat="server" Text="Label"></asp:Label>--%>
                                    <span class="weui-badge  bg-<% =(count_03==0?"gray":"blue") %>"><% =count_03 %></span>
                                </div>
                                <div class="weui-cells" id="_03">
                                    <asp:Repeater runat="server" ID="list_03" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>')>
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                        <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                        <%# "单号"+Eval("workorder") %>
                                                        <span style="display:<%# Eval("workorder_f").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 分单号" + Eval("workorder_f") %>
                                                        </span>
                                                        <span style="display:<%# Eval("workorder_f_a").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 父单号" + Eval("workorder_f_a") %>
                                                        </span>
                                                        <span style="display:<%# (Eval("stepid").ToString()=="9998" || Eval("stepid").ToString()=="9999")?"inline-block":"none"%>; ">
                                                            <%# " 关联单号" + Eval("workorder_gl") %>
                                                        </span>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("pgino") + "," + Eval("pn") + "," +Eval("op") + "" +Eval("op_descr")  %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <span style="display:<%# Eval("reason_code").ToString()!=""?"inline-block":"none"%>;"><%# Eval("reason_code") + "" + Eval("reason") + "," %></span>
                                                        <%# Eval("cur_qty")+"件" %>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("type").ToString()=="部分"?"#F7CF07":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                            <%#Eval("type") %>
                                                        </span>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("result").ToString()=="返工"?"red":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# (Eval("result").ToString()=="返工" || Eval("result").ToString()=="分选")?"inline-block":"none"%>; ">
                                                            <%#Eval("result") %>
                                                        </span>
                                                    </span>
                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                            <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
                                                            <%-- <font class='f-blue'>"+Eval("times")+"</font>--%>
                                                            <span style="color:<%# Eval("is_chao_time").ToString()=="Y"?"red":"#10AEFF" %>;">
                                                                <%# Eval("times") %>
                                                            </span>
                                                        </span>
                                                </div>
                                            </a>

                                        </ItemTemplate>
                                    </asp:Repeater>
                                       
                                </div>
                            </div>
                                                        
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  ">
                                    <i class="icon nav-icon icon-49"></i>质量经理
                                    <%--<asp:Label ID="Label_04" runat="server" Text="Label"></asp:Label>--%>
                                    <span class="weui-badge  bg-<% =(count_04==0?"gray":"blue") %>"><% =count_04 %></span>
                                </div>
                                <div class="weui-cells" id="_04">
                                    <asp:Repeater runat="server" ID="list_04" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>')>
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                        <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                        <%# "单号"+Eval("workorder") %>
                                                        <span style="display:<%# Eval("workorder_f").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 分单号" + Eval("workorder_f") %>
                                                        </span>
                                                        <span style="display:<%# Eval("workorder_f_a").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 父单号" + Eval("workorder_f_a") %>
                                                        </span>
                                                        <span style="display:<%# (Eval("stepid").ToString()=="9998" || Eval("stepid").ToString()=="9999")?"inline-block":"none"%>; ">
                                                            <%# " 关联单号" + Eval("workorder_gl") %>
                                                        </span>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("pgino") + "," + Eval("pn") + "," +Eval("op") + "" +Eval("op_descr")  %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <span style="display:<%# Eval("reason_code").ToString()!=""?"inline-block":"none"%>;"><%# Eval("reason_code") + "" + Eval("reason") + "," %></span>
                                                        <%# Eval("cur_qty")+"件" %>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("type").ToString()=="部分"?"#F7CF07":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                            <%#Eval("type") %>
                                                        </span>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("result").ToString()=="返工"?"red":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# (Eval("result").ToString()=="返工" || Eval("result").ToString()=="分选")?"inline-block":"none"%>; ">
                                                            <%#Eval("result") %>
                                                        </span>
                                                    </span>
                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                            <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
                                                            <%-- <font class='f-blue'>"+Eval("times")+"</font>--%>
                                                            <span style="color:<%# Eval("is_chao_time").ToString()=="Y"?"red":"#10AEFF" %>;">
                                                                <%# Eval("times") %>
                                                            </span>
                                                        </span>
                                                </div>
                                            </a>

                                        </ItemTemplate>
                                    </asp:Repeater>
                                       
                                </div>
                            </div>
                                                        
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  ">
                                    <i class="icon nav-icon icon-49"></i>总经理
                                    <%--<asp:Label ID="Label_05" runat="server" Text="Label"></asp:Label>--%>
                                    <span class="weui-badge  bg-<% =(count_05==0?"gray":"blue") %>"><% =count_05 %></span>
                                </div>
                                <div class="weui-cells" id="_05">
                                    <asp:Repeater runat="server" ID="list_05" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>')>
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                        <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                        <%# "单号"+Eval("workorder") %>
                                                        <span style="display:<%# Eval("workorder_f").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 分单号" + Eval("workorder_f") %>
                                                        </span>
                                                        <span style="display:<%# Eval("workorder_f_a").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 父单号" + Eval("workorder_f_a") %>
                                                        </span>
                                                        <span style="display:<%# (Eval("stepid").ToString()=="9998" || Eval("stepid").ToString()=="9999")?"inline-block":"none"%>; ">
                                                            <%# " 关联单号" + Eval("workorder_gl") %>
                                                        </span>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("pgino") + "," + Eval("pn") + "," +Eval("op") + "" +Eval("op_descr")  %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <span style="display:<%# Eval("reason_code").ToString()!=""?"inline-block":"none"%>;"><%# Eval("reason_code") + "" + Eval("reason") + "," %></span>
                                                        <%# Eval("cur_qty")+"件" %>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("type").ToString()=="部分"?"#F7CF07":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                            <%#Eval("type") %>
                                                        </span>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("result").ToString()=="返工"?"red":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# (Eval("result").ToString()=="返工" || Eval("result").ToString()=="分选")?"inline-block":"none"%>; ">
                                                            <%#Eval("result") %>
                                                        </span>
                                                    </span>
                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                            <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
                                                            <%-- <font class='f-blue'>"+Eval("times")+"</font>--%>
                                                            <span style="color:<%# Eval("is_chao_time").ToString()=="Y"?"red":"#10AEFF" %>;">
                                                                <%# Eval("times") %>
                                                            </span>
                                                        </span>
                                                </div>
                                            </a>

                                        </ItemTemplate>
                                    </asp:Repeater>
                                       
                                </div>
                            </div>
                                                        
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  ">
                                    <i class="icon nav-icon icon-49"></i>需返工/挑选
                                    <%--<asp:Label ID="Label_01" runat="server" Text="Label"></asp:Label>--%>
                                    <span class="weui-badge  bg-<% =(count_01==0?"gray":"blue") %>"><% =count_01 %></span>
                                </div>
                                <div class="weui-cells" id="_01">
                                    <asp:Repeater runat="server" ID="list_01" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>')>
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-danger"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                        <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                        <%# "单号"+Eval("workorder") %>
                                                        <span style="display:<%# Eval("workorder_f").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 分单号" + Eval("workorder_f") %>
                                                        </span>
                                                        <span style="display:<%# Eval("workorder_f_a").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 父单号" + Eval("workorder_f_a") %>
                                                        </span>
                                                        <span style="display:<%# (Eval("stepid").ToString()=="9998" || Eval("stepid").ToString()=="9999")?"inline-block":"none"%>; ">
                                                            <%# " 关联单号" + Eval("workorder_gl") %>
                                                        </span>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("pgino") + "," + Eval("pn") + "," +Eval("op") + "" +Eval("op_descr")  %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <span style="display:<%# Eval("reason_code").ToString()!=""?"inline-block":"none"%>;"><%# Eval("reason_code") + "" + Eval("reason") + "," %></span>
                                                        <%# Eval("cur_qty")+"件" %>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("type").ToString()=="部分"?"#F7CF07":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                            <%#Eval("type") %>
                                                        </span>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("result").ToString()=="返工"?"red":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# (Eval("result").ToString()=="返工" || Eval("result").ToString()=="分选")?"inline-block":"none"%>; ">
                                                            <%#Eval("result") %>
                                                        </span>
                                                    </span>
                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                            <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
                                                            <%-- <font class='f-blue'>"+Eval("times")+"</font>--%>
                                                            <span style="color:<%# Eval("is_chao_time").ToString()=="Y"?"red":"#10AEFF" %>;">
                                                                <%# Eval("times") %>
                                                            </span>
                                                        </span>
                                                </div>
                                            </a>

                                        </ItemTemplate>
                                    </asp:Repeater>
                                       
                                </div>
                            </div>
                                                        
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  ">
                                    <i class="icon nav-icon icon-49"></i>待入库
                                    <%--<asp:Label ID="Label_98" runat="server" Text="Label"></asp:Label>--%>
                                    <span class="weui-badge  bg-<% =(count_98==0?"gray":"blue") %>"><% =count_98 %></span>
                                </div>
                                <div class="weui-cells" id="_98">
                                    <asp:Repeater runat="server" ID="list_98" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>')>
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-green"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                        <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                        <%# "单号"+Eval("workorder") %>
                                                        <span style="display:<%# Eval("workorder_f").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 分单号" + Eval("workorder_f") %>
                                                        </span>
                                                        <span style="display:<%# Eval("workorder_f_a").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 父单号" + Eval("workorder_f_a") %>
                                                        </span>
                                                        <span style="display:<%# (Eval("stepid").ToString()=="9998" || Eval("stepid").ToString()=="9999")?"inline-block":"none"%>; ">
                                                            <%# " 关联单号" + Eval("workorder_gl") %>
                                                        </span>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("pgino") + "," + Eval("pn") + "," +Eval("op") + "" +Eval("op_descr")  %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <span style="display:<%# Eval("reason_code").ToString()!=""?"inline-block":"none"%>;"><%# Eval("reason_code") + "" + Eval("reason") + "," %></span>
                                                        <%# Eval("cur_qty")+"件" %>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("type").ToString()=="部分"?"#F7CF07":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                            <%#Eval("type") %>
                                                        </span>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("result").ToString()=="返工"?"red":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# (Eval("result").ToString()=="返工" || Eval("result").ToString()=="分选")?"inline-block":"none"%>; ">
                                                            <%#Eval("result") %>
                                                        </span>
                                                    </span>
                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                            <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
                                                            <%-- <font class='f-blue'>"+Eval("times")+"</font>--%>
                                                            <span style="color:<%# Eval("is_chao_time").ToString()=="Y"?"red":"#10AEFF" %>;">
                                                                <%# Eval("times") %>
                                                            </span>
                                                        </span>
                                                </div>
                                            </a>

                                        </ItemTemplate>
                                    </asp:Repeater>
                                       
                                </div>
                            </div>
                                                       
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  ">
                                    <i class="icon nav-icon icon-49"></i>已入库(24h内)
                                    <%--<asp:Label ID="Label_99" runat="server" Text="Label"></asp:Label>--%>
                                    <span class="weui-badge  bg-<% =(count_01==99?"gray":"blue") %>"><% =count_99 %></span>
                                </div>
                                <div class="weui-cells" id="_99">
                                    <asp:Repeater runat="server" ID="list_99" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>')>
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                        <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                        <%# "单号"+Eval("workorder") %>
                                                        <span style="display:<%# Eval("workorder_f").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 分单号" + Eval("workorder_f") %>
                                                        </span>
                                                        <span style="display:<%# Eval("workorder_f_a").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 父单号" + Eval("workorder_f_a") %>
                                                        </span>
                                                        <span style="display:<%# (Eval("stepid").ToString()=="9998" || Eval("stepid").ToString()=="9999")?"inline-block":"none"%>; ">
                                                            <%# " 关联单号" + Eval("workorder_gl") %>
                                                        </span>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("pgino") + "," + Eval("pn") + "," +Eval("op") + "" +Eval("op_descr")  %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <span style="display:<%# Eval("reason_code").ToString()!=""?"inline-block":"none"%>;"><%# Eval("reason_code") + "" + Eval("reason") + "," %></span>
                                                        <%# Eval("cur_qty")+"件" %>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("type").ToString()=="部分"?"#F7CF07":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                            <%#Eval("type") %>
                                                        </span>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("result").ToString()=="返工"?"red":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# (Eval("result").ToString()=="返工" || Eval("result").ToString()=="分选")?"inline-block":"none"%>; ">
                                                            <%#Eval("result") %>
                                                        </span>
                                                    </span>
                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                            <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
                                                            <%-- <font class='f-blue'>"+Eval("times")+"</font>--%>
                                                            <span style="color:<%# Eval("is_chao_time").ToString()=="Y"?"red":"#10AEFF" %>;">
                                                                <%# Eval("times") %>
                                                            </span>
                                                        </span>
                                                </div>
                                            </a>

                                        </ItemTemplate>
                                    </asp:Repeater>
                                       
                                </div>
                            </div>
                                                           
                        </div>
                        <%--=======我的不合格-----%>
                        <div id="tab2" class="weui-tab__content">
                            
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  ">
                                    <i class="icon nav-icon icon-49"></i>检验处置
                                    <%--<asp:Label ID="Label_02_my" runat="server" Text="Label"></asp:Label>--%>
                                    <span class="weui-badge  bg-<% =(count_02_my==0?"gray":"blue") %>"><% =count_02_my %></span>
                                </div>
                                <div class="weui-cells" id="_02_my">
                                    <asp:Repeater runat="server" ID="list_02_my" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>')>
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                        <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                        <%# "单号"+Eval("workorder") %>
                                                        <span style="display:<%# Eval("workorder_f").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 分单号" + Eval("workorder_f") %>
                                                        </span>
                                                        <span style="display:<%# Eval("workorder_f_a").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 父单号" + Eval("workorder_f_a") %>
                                                        </span>
                                                        <span style="display:<%# (Eval("stepid").ToString()=="9998" || Eval("stepid").ToString()=="9999")?"inline-block":"none"%>; ">
                                                            <%# " 关联单号" + Eval("workorder_gl") %>
                                                        </span>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("pgino") + "," + Eval("pn") + "," +Eval("op") + "" +Eval("op_descr")  %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <span style="display:<%# Eval("reason_code").ToString()!=""?"inline-block":"none"%>;"><%# Eval("reason_code") + "" + Eval("reason") + "," %></span>
                                                        <%# Eval("cur_qty")+"件" %>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("type").ToString()=="部分"?"#F7CF07":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                            <%#Eval("type") %>
                                                        </span>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("result").ToString()=="返工"?"red":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# (Eval("result").ToString()=="返工" || Eval("result").ToString()=="分选")?"inline-block":"none"%>; ">
                                                            <%#Eval("result") %>
                                                        </span>
                                                    </span>
                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                            <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
                                                            <%-- <font class='f-blue'>"+Eval("times")+"</font>--%>
                                                            <span style="color:<%# Eval("is_chao_time").ToString()=="Y"?"red":"#10AEFF" %>;">
                                                                <%# Eval("times") %>
                                                            </span>
                                                        </span>
                                                </div>
                                            </a>

                                        </ItemTemplate>
                                    </asp:Repeater>
                                       
                                </div>
                            </div>
                            
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  ">
                                    <i class="icon nav-icon icon-49"></i>质量工程师
                                    <%--<asp:Label ID="Label_03_my" runat="server" Text="Label"></asp:Label>--%>
                                    <span class="weui-badge  bg-<% =(count_03_my==0?"gray":"blue") %>"><% =count_03_my %></span>
                                </div>
                                <div class="weui-cells" id="_03_my">
                                    <asp:Repeater runat="server" ID="list_03_my" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>')>
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                        <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                        <%# "单号"+Eval("workorder") %>
                                                        <span style="display:<%# Eval("workorder_f").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 分单号" + Eval("workorder_f") %>
                                                        </span>
                                                        <span style="display:<%# Eval("workorder_f_a").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 父单号" + Eval("workorder_f_a") %>
                                                        </span>
                                                        <span style="display:<%# (Eval("stepid").ToString()=="9998" || Eval("stepid").ToString()=="9999")?"inline-block":"none"%>; ">
                                                            <%# " 关联单号" + Eval("workorder_gl") %>
                                                        </span>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("pgino") + "," + Eval("pn") + "," +Eval("op") + "" +Eval("op_descr")  %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <span style="display:<%# Eval("reason_code").ToString()!=""?"inline-block":"none"%>;"><%# Eval("reason_code") + "" + Eval("reason") + "," %></span>
                                                        <%# Eval("cur_qty")+"件" %>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("type").ToString()=="部分"?"#F7CF07":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                            <%#Eval("type") %>
                                                        </span>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("result").ToString()=="返工"?"red":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# (Eval("result").ToString()=="返工" || Eval("result").ToString()=="分选")?"inline-block":"none"%>; ">
                                                            <%#Eval("result") %>
                                                        </span>
                                                    </span>
                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                            <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
                                                            <%-- <font class='f-blue'>"+Eval("times")+"</font>--%>
                                                            <span style="color:<%# Eval("is_chao_time").ToString()=="Y"?"red":"#10AEFF" %>;">
                                                                <%# Eval("times") %>
                                                            </span>
                                                        </span>
                                                </div>
                                            </a>

                                        </ItemTemplate>
                                    </asp:Repeater>
                                       
                                </div>
                            </div>
                            
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  ">
                                    <i class="icon nav-icon icon-49"></i>质量经理
                                    <%--<asp:Label ID="Label_04_my" runat="server" Text="Label"></asp:Label>--%>
                                    <span class="weui-badge  bg-<% =(count_04_my==0?"gray":"blue") %>"><% =count_04_my %></span>
                                </div>
                                <div class="weui-cells" id="_04_my">
                                    <asp:Repeater runat="server" ID="list_04_my" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>')>
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                        <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                        <%# "单号"+Eval("workorder") %>
                                                        <span style="display:<%# Eval("workorder_f").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 分单号" + Eval("workorder_f") %>
                                                        </span>
                                                        <span style="display:<%# Eval("workorder_f_a").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 父单号" + Eval("workorder_f_a") %>
                                                        </span>
                                                        <span style="display:<%# (Eval("stepid").ToString()=="9998" || Eval("stepid").ToString()=="9999")?"inline-block":"none"%>; ">
                                                            <%# " 关联单号" + Eval("workorder_gl") %>
                                                        </span>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("pgino") + "," + Eval("pn") + "," +Eval("op") + "" +Eval("op_descr")  %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <span style="display:<%# Eval("reason_code").ToString()!=""?"inline-block":"none"%>;"><%# Eval("reason_code") + "" + Eval("reason") + "," %></span>
                                                        <%# Eval("cur_qty")+"件" %>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("type").ToString()=="部分"?"#F7CF07":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                            <%#Eval("type") %>
                                                        </span>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("result").ToString()=="返工"?"red":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# (Eval("result").ToString()=="返工" || Eval("result").ToString()=="分选")?"inline-block":"none"%>; ">
                                                            <%#Eval("result") %>
                                                        </span>
                                                    </span>
                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                            <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
                                                            <%-- <font class='f-blue'>"+Eval("times")+"</font>--%>
                                                            <span style="color:<%# Eval("is_chao_time").ToString()=="Y"?"red":"#10AEFF" %>;">
                                                                <%# Eval("times") %>
                                                            </span>
                                                        </span>
                                                </div>
                                            </a>

                                        </ItemTemplate>
                                    </asp:Repeater>
                                       
                                </div>
                            </div>
                            
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  ">
                                    <i class="icon nav-icon icon-49"></i>总经理
                                    <%--<asp:Label ID="Label_05_my" runat="server" Text="Label"></asp:Label>--%>
                                    <span class="weui-badge  bg-<% =(count_05_my==0?"gray":"blue") %>"><% =count_05_my %></span>
                                </div>
                                <div class="weui-cells" id="_05_my">
                                    <asp:Repeater runat="server" ID="list_05_my" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>')>
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-warning"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                        <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                        <%# "单号"+Eval("workorder") %>
                                                        <span style="display:<%# Eval("workorder_f").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 分单号" + Eval("workorder_f") %>
                                                        </span>
                                                        <span style="display:<%# Eval("workorder_f_a").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 父单号" + Eval("workorder_f_a") %>
                                                        </span>
                                                        <span style="display:<%# (Eval("stepid").ToString()=="9998" || Eval("stepid").ToString()=="9999")?"inline-block":"none"%>; ">
                                                            <%# " 关联单号" + Eval("workorder_gl") %>
                                                        </span>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("pgino") + "," + Eval("pn") + "," +Eval("op") + "" +Eval("op_descr")  %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <span style="display:<%# Eval("reason_code").ToString()!=""?"inline-block":"none"%>;"><%# Eval("reason_code") + "" + Eval("reason") + "," %></span>
                                                        <%# Eval("cur_qty")+"件" %>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("type").ToString()=="部分"?"#F7CF07":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                            <%#Eval("type") %>
                                                        </span>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("result").ToString()=="返工"?"red":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# (Eval("result").ToString()=="返工" || Eval("result").ToString()=="分选")?"inline-block":"none"%>; ">
                                                            <%#Eval("result") %>
                                                        </span>
                                                    </span>
                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                            <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
                                                            <%-- <font class='f-blue'>"+Eval("times")+"</font>--%>
                                                            <span style="color:<%# Eval("is_chao_time").ToString()=="Y"?"red":"#10AEFF" %>;">
                                                                <%# Eval("times") %>
                                                            </span>
                                                        </span>
                                                </div>
                                            </a>

                                        </ItemTemplate>
                                    </asp:Repeater>
                                       
                                </div>
                            </div>
                            
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  ">
                                    <i class="icon nav-icon icon-49"></i>需返工/挑选
                                    <%--<asp:Label ID="Label_01_my" runat="server" Text="Label"></asp:Label>--%>
                                    <span class="weui-badge  bg-<% =(count_01_my==0?"gray":"blue") %>"><% =count_01_my %></span>
                                </div>
                                <div class="weui-cells" id="_01_my">
                                    <asp:Repeater runat="server" ID="list_01_my" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>')>
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-danger"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                        <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                        <%# "单号"+Eval("workorder") %>
                                                        <span style="display:<%# Eval("workorder_f").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 分单号" + Eval("workorder_f") %>
                                                        </span>
                                                        <span style="display:<%# Eval("workorder_f_a").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 父单号" + Eval("workorder_f_a") %>
                                                        </span>
                                                        <span style="display:<%# (Eval("stepid").ToString()=="9998" || Eval("stepid").ToString()=="9999")?"inline-block":"none"%>; ">
                                                            <%# " 关联单号" + Eval("workorder_gl") %>
                                                        </span>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("pgino") + "," + Eval("pn") + "," +Eval("op") + "" +Eval("op_descr")  %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <span style="display:<%# Eval("reason_code").ToString()!=""?"inline-block":"none"%>;"><%# Eval("reason_code") + "" + Eval("reason") + "," %></span>
                                                        <%# Eval("cur_qty")+"件" %>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("type").ToString()=="部分"?"#F7CF07":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                            <%#Eval("type") %>
                                                        </span>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("result").ToString()=="返工"?"red":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# (Eval("result").ToString()=="返工" || Eval("result").ToString()=="分选")?"inline-block":"none"%>; ">
                                                            <%#Eval("result") %>
                                                        </span>
                                                    </span>
                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                            <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
                                                            <%-- <font class='f-blue'>"+Eval("times")+"</font>--%>
                                                            <span style="color:<%# Eval("is_chao_time").ToString()=="Y"?"red":"#10AEFF" %>;">
                                                                <%# Eval("times") %>
                                                            </span>
                                                        </span>
                                                </div>
                                            </a>

                                        </ItemTemplate>
                                    </asp:Repeater>
                                       
                                </div>
                            </div>
                            
                            <div class="weui-form-preview">
                                <div class="weui-cells__title  ">
                                    <i class="icon nav-icon icon-49"></i>待入库
                                    <%--<asp:Label ID="Label_98_my" runat="server" Text="Label"></asp:Label>--%>
                                    <span class="weui-badge  bg-<% =(count_98_my==0?"gray":"blue") %>"><% =count_98_my %></span>
                                </div>
                                <div class="weui-cells" id="_98_my">
                                    <asp:Repeater runat="server" ID="list_98_my" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>','<%# Eval("workorder_gl") %>')>
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-green"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                        <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                        <%# "单号"+Eval("workorder") %>
                                                        <span style="display:<%# Eval("workorder_f").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 分单号" + Eval("workorder_f") %>
                                                        </span>
                                                        <span style="display:<%# Eval("workorder_f_a").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 父单号" + Eval("workorder_f_a") %>
                                                        </span>
                                                        <span style="display:<%# (Eval("stepid").ToString()=="9998" || Eval("stepid").ToString()=="9999")?"inline-block":"none"%>; ">
                                                            <%# " 关联单号" + Eval("workorder_gl") %>
                                                        </span>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("pgino") + "," + Eval("pn") + "," +Eval("op") + "" +Eval("op_descr")  %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <span style="display:<%# Eval("reason_code").ToString()!=""?"inline-block":"none"%>;"><%# Eval("reason_code") + "" + Eval("reason") + "," %></span>
                                                        <%# Eval("cur_qty")+"件" %>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("type").ToString()=="部分"?"#F7CF07":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                            <%#Eval("type") %>
                                                        </span>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("result").ToString()=="返工"?"red":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# (Eval("result").ToString()=="返工" || Eval("result").ToString()=="分选")?"inline-block":"none"%>; ">
                                                            <%#Eval("result") %>
                                                        </span>
                                                    </span>
                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                            <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
                                                            <%-- <font class='f-blue'>"+Eval("times")+"</font>--%>
                                                            <span style="color:<%# Eval("is_chao_time").ToString()=="Y"?"red":"#10AEFF" %>;">
                                                                <%# Eval("times") %>
                                                            </span>
                                                        </span>
                                                </div>
                                            </a>

                                        </ItemTemplate>
                                    </asp:Repeater>
                                       
                                </div>
                            </div>

                            <div class="weui-form-preview">
                                <div class="weui-cells__title  ">
                                    <i class="icon nav-icon icon-49"></i>已入库(24h内)
                                    <%--<asp:Label ID="Label_99_my" runat="server" Text="Label"></asp:Label>--%>
                                    <span class="weui-badge  bg-<% =(count_99_my==0?"gray":"blue") %>"><% =count_99_my %></span>
                                </div>
                                <div class="weui-cells" id="_99_my">
                                    <asp:Repeater runat="server" ID="list_99_my" EnableTheming="False">
                                        <ItemTemplate>
                                            <a class="weui-cell weui-cell_access" onclick=deal('<%# Eval("stepid") %>','<%# Eval("workorder") %>','<%# Eval("workorder_f") %>'),'<%# Eval("workorder_gl") %>')>
                                                <div class="weui-mark-vip"><span class="weui-mark-lt bg-gray"></span></div>
                                                <div class="weui-cell__hd">
                                                    <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                                </div>
                                                <div class="weui-cell__bd">
                                                        <span class="weui-form-preview__value" style="color:#999999;font-size: smaller">
                                                        <%# "单号"+Eval("workorder") %>
                                                        <span style="display:<%# Eval("workorder_f").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 分单号" + Eval("workorder_f") %>
                                                        </span>
                                                        <span style="display:<%# Eval("workorder_f_a").ToString()!=""?"inline-block":"none"%>; ">
                                                            <%# " 父单号" + Eval("workorder_f_a") %>
                                                        </span>
                                                        <span style="display:<%# (Eval("stepid").ToString()=="9998" || Eval("stepid").ToString()=="9999")?"inline-block":"none"%>; ">
                                                            <%# " 关联单号" + Eval("workorder_gl") %>
                                                        </span>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <%# Eval("pgino") + "," + Eval("pn") + "," +Eval("op") + "" +Eval("op_descr")  %>
                                                    </span>
                                                    <span class="weui-form-preview__value" style="font-size: smaller">
                                                        <span style="display:<%# Eval("reason_code").ToString()!=""?"inline-block":"none"%>;"><%# Eval("reason_code") + "" + Eval("reason") + "," %></span>
                                                        <%# Eval("cur_qty")+"件" %>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("type").ToString()=="部分"?"#F7CF07":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# Eval("type").ToString()=="部分"?"inline-block":"none"%>; ">
                                                            <%#Eval("type") %>
                                                        </span>
                                                        <span class="weui-mark-rt- weui-badge" 
                                                            style="background-color: <%# Eval("result").ToString()=="返工"?"red":"#10AEFF"%>;
                                                                font-size: x-small; color: white; 
                                                                display:<%# (Eval("result").ToString()=="返工" || Eval("result").ToString()=="分选")?"inline-block":"none"%>; ">
                                                            <%#Eval("result") %>
                                                        </span>
                                                    </span>
                                                        <span class="weui-agree__text" style="font-size: smaller">
                                                            <%# Eval("phone") + "" +Eval("emp_name") +"," +Eval("create_date","{0:MM-dd HH:mm}")+  ",时长:"%>   
                                                            <%-- <font class='f-blue'>"+Eval("times")+"</font>--%>
                                                            <span style="color:<%# Eval("is_chao_time").ToString()=="Y"?"red":"#10AEFF" %>;">
                                                                <%# Eval("times") %>
                                                            </span>
                                                        </span>
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

            });
        </script>
    </form>


</body>
</html>
