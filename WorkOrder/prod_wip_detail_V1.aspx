<%@ Page Language="C#" AutoEventWireup="true" CodeFile="prod_wip_detail_V1.aspx.cs" Inherits="prod_wip_detail_V1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>生产操作明细</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0" />
    
    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <script src="/Content/layer/layer.js"></script>

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
        .collapse .weui-flex{
            padding:0px 10px;
        }
        .collapse li.js-show .weui-flex {
            opacity: 1;
            color: rgb(66, 139, 202);
        }
    </style>
    <script src="../js/zepto.min.js"></script>
    <script src="../js/zepto.weui.js"></script>
    <script src="../js/iscroll-lite.js"></script>
    <script>

        $(function () {
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

            $('#btn_cancel').click(function () {
                //var qty = "<%= Request["wipqty"] %>";
                var qty = $("#wip_qty").val();

                $.confirm('确认要【退回】【数量' + qty + '】吗？', function () {
                    //点击确认后的回调函数

                    $.actions({
                        title: "请选择【退料】位置"
                        , onClose: function () {  }
                        ,actions: [{
                            text: "仓库",
                            onClick: function () {
                                Reject_Sku("仓库", qty);
                            }
                        }, {
                            text: "线边库",
                            onClick: function () {
                                Reject_Sku("线边库", qty);
                            }
                        }]
                    });
                    
                }, function () {
                    //点击取消后的回调函数
                });


            });
        });

        function Reject_Sku(reject_where, qty) {
            $.ajax({
                type: "post",
                url: "prod_wip_detail_V1.aspx/Reject_Sku",
                data: "{'emp':'" + "<%= _emp %>" + "','needno':'" + "<%= _needno %>" + "','lotno':'" + "<%= _lotno %>" + "','reject_qty':'" + qty
                    + "','source':'2','reject_where':'" + reject_where + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    var obj = eval(data.d);
                    var flag = obj[0].flag;
                    if (flag == "Y") {
                        layer.alert(obj[0].msg);
                    } else {
                        window.location.href = "/workorder/prod_wip_list_v2.aspx?workshop=<%=_workshop %>";
                    }
                }
            });
        }
    </script>
</head>
<body ontouchstart>
    <form id="form1" runat="server">
        <div class="page">
            <div class="page__bd" id="t2" style="height: 100%;">
                <div class="weui-tab">
                </div>
                <div class="weui-form-preview">                    
                    <asp:TextBox ID="wip_qty" class="form-control" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>

                    <div class="weui-form-preview__hd">
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">Lot No</label>
                            <label class="weui-form-preview__"><% ="<font class='tag'/>"+_lotno %></label>
                        </div>
                    </div>
                    <div class="weui-form-preview__bd">
                        <asp:Repeater runat="server" ID="dtMain">
                            <ItemTemplate>
                                <div class="weui-mark-vip"><span class="weui-mark-lt <%# Eval("zt").ToString()=="1"?"bg-gray":"bg-yellow"%>"></span></div>

                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">项目号</label>
                                    <span class="weui-form-preview__value"><%# Eval("sku") %></span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">零件号</label>
                                    <span class="weui-form-preview__value"><%# Eval("sku_descr") %> </span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">上料时间</label>
                                    <span class="weui-form-preview__value"><%# string.Format("{0:MM-dd HH:mm}",Eval("begin_date"))+"，时长" %> 
                                        <span class="f-blue"><%# Eval("shichang") %></span>
                                    </span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">上料数量</label>
                                    <span class="weui-form-preview__value"><%# Eval("load_qty") %> </span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">下料数量</label>
                                    <span class="weui-form-preview__value"><%# Eval("off_qty") %> </span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">不合格申请数量</label>
                                    <span class="weui-form-preview__value"><%# Eval("ng_qty") %> </span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label margin10-l">废品数量</label>
                                    <span class="weui-form-preview__value"><%# Eval("wastqty") %> </span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label margin10-l">合格数量</label>
                                    <span class="weui-form-preview__value"><%# Eval("goodqty") %> </span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label margin10-l">未处置数量</label>
                                    <span class="weui-form-preview__value"><%# Eval("undealqty") %> </span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">调整数量</label>
                                    <span class="weui-form-preview__value"><%# Eval("adj_qty") %> </span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">在制数量</label>
                                    <span class="weui-form-preview__value"><%# Convert.ToSingle(Eval("wip_qty")) %> </span>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    
                </div>
                <div class="weui-form-preview">
                    <div class="weui-cells__title ">                         
                        <asp:Label ID="Label1" runat="server" Text='操作明细'></asp:Label><span class="icon icon-40 f-blue f20 margin20-l"  onclick="$.toptip('[ 说明 ]  不合格：不合格申请数；IP:在制数；NG:未处置数','success') "></span>
                    </div>
                   
                    <% foreach (System.Data.DataRow dr_ in dt_dtl.Rows)
                    {%>
                        <ul class="collapse">
                            <li class="js-show">                
                                <div class="weui-flex js-category">
                                    <div class="weui-flex__item" style="font-size:14px;"><%= dr_["deal_time_str"]+" " +dr_["emp_name"]+" "+dr_["title"]+":"+ dr_["deal_qty"] %> , IP <%= dr_["wip"] %> , NG <%= dr_["ng"] %></div>
                                    <i class="icon icon-35 padding10-l" style="display :<%= dr_["workorder"].ToString()!=""?"block":"none"%>;"></i>
                                </div>                    
                                <div class="page-category js-categoryInner "> 
                                    <div class="weui-cells page-category-content">
                                        <div class="weui-cell__bd" style="padding-left:15px;margin-bottom:5px;display :<%= dr_["workorder"].ToString()!=""?"block":"none"%>;">
                                            <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2;">
                                                <%= dr_["pgino"] + " , " + dr_["pn"] %>  
                                            </span>
                                            <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2;">
                                                <% if (dr_["title"].ToString() == "下料")
                                                    { %>
                                                    <a href="prod_qcc_part_detail.aspx?dh=<%=dr_["workorder"] %>&type=0"><%= dr_["workorder"] %></a>
                                                    <%= ",下料数 " +dr_["deal_qty"]+" --> "+dr_["par_qty"] %>
                                                <%}
                                                    else if (dr_["flag"].ToString().Contains("nglog")) { %>
                                                    <a href="bhgp_Apply_V1.aspx?workorder=<%=dr_["workorder"] %>&workorder_f=<%=dr_["workorder_f"] %>&workshop=<%=_workshop %>"><%= dr_["workorder"] %></a>
                                                    <%= ",数量 " +dr_["deal_qty"]+" --> "+dr_["par_qty"] %>
                                                <%} 
                                                    else if (dr_["title"].ToString() == "盘点") { %>
                                                    <% if (dr_["workorder"].ToString().Length == 5)
                                                        { %>
                                                        <%= dr_["workorder"] %>
                                                      <%}
                                                        else {%>
                                                            <a href="Adjust_Apply.aspx?workorder=<%=dr_["workorder"] %>&workshop=<%=_workshop %>"><%= dr_["workorder"] %></a>
                                                        <%}%>
                                                    <%= ",数量 " +dr_["deal_qty"] %> 
                                                <%} %>
                                            </span>
                                        </div>
                                    </div>
                                </div>               
                            </li>
                        </ul> 
                    <%} %>
                    
                </div>

                <div class="weui-cell" style="display:<%= _para=="Y"?"flex":"none"%>;">
                    <input id="btn_cancel" type="button" class="weui-btn weui-btn_primary" value="退料" />
                </div>

            </div>
        </div>


        <%--<div class="weui-footer weui-footer_fixed-bottom">
            <p class="weui-footer__text"><%=WeiXin.GetCookie("workcode") +((LoginUser)WeiXin.GetJsonCookie()).UserName %></p>
        </div>--%>

    </form>
</body>
</html>
