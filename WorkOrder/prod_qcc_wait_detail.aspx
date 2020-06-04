<%@ Page Language="C#" AutoEventWireup="true" CodeFile="prod_qcc_wait_detail.aspx.cs" Inherits="prod_qcc_wait_detail" %>

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

        table td {
            padding-bottom: 0px;
            padding-top: 0px;
            border: 0px hidden white;
        }

        .span_space {
            padding-right: 20px;
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
            <%--$('#btn_cancel').click(function () {
                var qty = "<%= Request["wipqty"] %>";

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


            });--%>
        });

<%--        function Reject_Sku(reject_where, qty) {
            $.ajax({
                type: "post",
                url: "prod_wip_detail.aspx/Reject_Sku",
                data: "{'emp':'" + "<%= _emp %>" + "','needno':'" + "<%= Request["need_no"] %>" + "','lotno':'" + "<%= Request["dh"] %>" + "','reject_qty':'" + qty
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
                        window.location.href = "/workorder/prod_wip_list.aspx?workshop=<%=_workshop %>";
                    }
                }
            });
        }--%>
    </script>
</head>
<body ontouchstart>
    <form id="form1" runat="server">
        <div class="page">
            <div class="page__bd" id="t2" style="height: 100%;">
                <div class="weui-tab">
                </div>
                <div class="weui-form-preview">
                    <div class="weui-form-preview__hd">
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label"><% =(dtMain.Rows[0]["laiyuan"].ToString().Contains("生产下线")?"完工单号":"终检单号") %></label>
                            <label class="weui-form-preview__"><% ="<font class='tag'/>"+Request["dh"] %></label>
                        </div>
                    </div>
                    <div class="weui-form-preview__bd">
                        <asp:Repeater runat="server" ID="rptMain">
                            <ItemTemplate>
                                <div class="weui-mark-vip"><span class="weui-mark-lt <%# Request["type"].ToString()=="workorder"?"bg-gray":"bg-yellow"%>"></span></div>

                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">项目号</label>
                                    <span class="weui-form-preview__value"><%# Eval("pgino") %></span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">零件号</label>
                                    <span class="weui-form-preview__value"><%# Eval("pn") %> </span>
                                </div>                                 
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">下线数</label>
                                    <span class="weui-form-preview__value"><%# Eval("off_qty") %> </span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">合格数</label>
                                    <span class="weui-form-preview__value"><%# Eval("hege_qty") %> </span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">NG数量</label>
                                    <span class="weui-form-preview__value"><%# Request["ngqty"] %> </span>
                                </div>
                                 <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">待检数量</label>
                                    <span class="weui-form-preview__value"><%# Request["waitqty"] %> </span>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    
                </div>






                  <%--=======终检完成========================================--%>
                <% int i = 0;
                    foreach (System.Data.DataRow dr in dtQC.Rows)
                    {
                        //if (i == 0)
                        //{%>
               <%--     <div class="weui-flex" style="height:28px; padding-top:2px; padding-bottom:2px;">
                        <div class="weui-flex__item margin10-l"><% =dr["title"] %></div>
                        <div class="margin20-r"><% =dr["qc_dh"] %></div>
                    </div>
                    <div class="weui-form-preview__bd " style="border-top:1px solid #e5e5e5; border-bottom:1px solid #e5e5e5;">
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">项目号</label>
                            <span class="weui-form-preview__value"><%=dr["pgino"] %></span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">零件号</label>
                            <span class="weui-form-preview__value"><%=dr["pn"] %> </span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">已检数量</label>
                            <span class="weui-form-preview__value"><%=dr["qty"] %></span>
                        </div>  
                    </div>
        --%>

                <% //}
                    i++; %>
                <% foreach (System.Data.DataRow dr_m_ in dtQC_m.Select("qc_dh='" + dr["qc_dh"].ToString() + "'"))
                {%>
                <ul class="collapse">
                    <li class="js-show">
               
                        <div class="weui-flex js-category">
                            <div class="weui-flex__item"><%=dr_m_["emp_name"] +" "+ dr_m_["on_date_str"] +" 已检数:"+ dr_m_["qty"] %></div>
                            <i class="icon icon-35 padding10-l"></i>
                        </div>
                        <div class="page-category js-categoryInner"> 
                            <div class="weui-cells page-category-content">
                                <% foreach (System.Data.DataRow dr_ in dtQC_dtl.Select("qc_dh='" + dr["qc_dh"].ToString() + "' and emp_name='" 
                                       + dr_m_["emp_name"].ToString() + "' and on_date_str='" + dr_m_["on_date_str"].ToString() + "'"))
                                {%>
                                <div class="weui-cell__bd" style="padding-left:15px;margin-bottom:5px;"><%-- border-bottom:1px solid #e5e5e5;--%>
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        <%= "来自"+dr_["workorder"] + ",生产完成数" + dr_["off_qty"] + ",已检数" +dr_["hege_qty"] %>
                                    </span>
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        <%= dr_["pgino"] + "," + dr_["pn"] %>
                                    </span>
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        <%= "生产完成时间"+string.Format("{0:MM-dd HH:mm}",dr_["begin_date"]) + ",时长" %><%-- + dr_["shichang"]--%>
                                        <span class="f-blue"> <%=dr_["shichang"].ToString() %></span>  
                                    </span>
                                </div>
                                <%} %>
                            </div>
                        </div>
                
                    </li>
                </ul>
                <%} %>
                <% } %>


                <%--====下料完成======================================--%>
                <%  i = 0;
                    foreach (System.Data.DataRow dr in dtProd.Rows)
                    {
                        %>
                   <%-- <div class="weui-flex" style="height:28px; padding-top:2px; padding-bottom:2px;">
                        <div class="weui-flex__item margin10-l"><% =dr["title"] %></div>
                        <div class="margin20-r"><% =dr["workorder"] %></div>
                    </div>
                    <div class="weui-form-preview__bd " style="border-top:1px solid #e5e5e5; border-bottom:1px solid #e5e5e5;">
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">项目号</label>
                            <span class="weui-form-preview__value"><%=dr["pgino"] %></span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">零件号</label>
                            <span class="weui-form-preview__value"><%=dr["pn"] %> </span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">完工数量</label>
                            <span class="weui-form-preview__value"><%=dr["qty"] %></span>
                        </div>  
                    </div>--%>
                <% 
                    i++; %>
                <% foreach (System.Data.DataRow dr_m_ in dtProd_m.Select("workorder='" + dr["workorder"].ToString() + "'"))
                    {%>
                <ul class="collapse">
                    <li class="js-show">                
                        <div class="weui-flex js-category">
                            <div class="weui-flex__item"><%=dr_m_["emp_name"] +" "+ dr_m_["off_date_str"] +" 下料数:"+ dr_m_["qty"] %></div>
                            <i class="icon icon-35 padding10-l"></i>
                        </div>                    
                        <div class="page-category js-categoryInner "> 
                            <div class="weui-cells page-category-content">
                                <% foreach (System.Data.DataRow dr_ in dtProd_dtl.Select("workorder='" + dr["workorder"].ToString() + "' and emp_name='" 
                                       + dr_m_["emp_name"].ToString() + "' and off_date_str='" + dr_m_["off_date_str"].ToString() + "'"))
                                {%>
                                <div class="weui-cell__bd" style="padding-left:15px;margin-bottom:5px;"><%-- border-bottom:1px solid #e5e5e5;--%>
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        <%--<%= "Lot:"+dr_["lot_no"] + ",上料数" + dr_["qty"] + ",下料数" +dr_["off_qty"]+" --> "+dr_["par_qty"] %>--%>

                                        Lot:<a href="prod_wip_detail_V1.aspx?lotno=<%=dr_["lot_no"] %>&para=N"><%= dr_["lot_no"] %></a>
                                        <%= ",上料数" + dr_["qty"] + ",下料数" +dr_["off_qty"]+" --> "+dr_["par_qty"] %>
                                    </span>
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        <%= dr_["sku"] + "," + dr_["sku_descr"] %>
                                    </span>
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        <%= "上料时间"+string.Format("{0:MM-dd HH:mm}",dr_["on_date"]) + ",时长" %> <%--+ dr_["shichang"]--%>
                                        <span class="f-blue"> <%=dr_["shichang"].ToString() %></span>  
                                    </span>
                                </div>
                                <%} %>
                            </div>
                        </div>               
                    </li>
                </ul> 
                <%} %>

                <% } %>










<%--                <div class="weui-form-preview">
                    <div class="weui-cells__title ">                        
                        <asp:Label ID="Label1" runat="server" Text='操作明细'></asp:Label>
                    </div>
                    <div class="weui-cells">
                        <% foreach (System.Data.DataRow dr in dtDetail.Rows)
                            {
                                if (dr["title"].ToString() == "下料")
                                {   %>
                                <a class="weui-cell " href="javascript:void(0)">
                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-yellow" ></span></div>
                                    <div class="weui-cell__hd">
                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                    </div>
                                    <div class="weui-cell__bd f-black" style="font-size: smaller">
                                        <span class="span_space ">
                                            <%=dr["sku"] %>
                                        </span>
                                        <span>
                                            <%=dr["sku_descr"] %>
                                        </span>
                                        <br />                                        
                                         
                                        <span class="span_space">Lot：<%=dr["lot_no"] %></span>
                                        <span class="span_space">下料数量: <font class="f-blue padding10-l"><%=dr["par_qty"] %></font></span>
                                         
                                        <br />
                                        <span class="weui-agree__text span_space">
                                             <%=dr["Emp_Name"] %>
                                        </span>
                                        <span class="weui-agree__text">上料时间：<%=string.Format("{0:MM-dd HH:mm}",dr[ "on_date"]) %> </span>
                                        <span class="weui-agree__text">下线时间：<%=string.Format("{0:MM-dd HH:mm}",dr[ "off_date"]) %> </span>
                                    </div>
                                    <div class="weui-cell__ft">
                                    </div>
                                </a>
                            <%  }else
                                {%>

                        <a class="weui-cell " href="javascript:void(0)">
                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-yellow" ></span></div>
                                    <div class="weui-cell__hd">
                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                    </div>
                                    <div class="weui-cell__bd f-black" style="font-size: smaller">
                                        <span class="span_space ">
                                            <%=dr["pgino"] %>
                                        </span>
                                        <span>
                                            <%=dr["pn"] %>
                                        </span>
                                        <br />                                       
                                         
                                        <span class="span_space"><%=dr["workorder"] %></span>
                                        <span class="span_space">合格数量: <font class="f-blue padding10-l"><%=dr["hege_qty"] %></font></span>
                                        <span><font class="f-blue"><%=dr["opdesc"] %></font></span>
                                        <br />
                                        <span class="weui-agree__text span_space">
                                            <%=dr["cellphone"]%><%=dr["Emp_Name"] %>
                                        </span>
                                        <span class="weui-agree__text">时间：<%=string.Format("{0:MM-dd HH:mm}",dr["on_date"]) %> </span>
                                        
                                    </div>
                                    <div class="weui-cell__ft">
                                    </div>
                                </a>

                          <% 
                                 }

                           } %>
                    </div>
                </div>

                --%>

            </div>
        </div>


        <div class="weui-footer weui-footer_fixed-bottom">
            <p class="weui-footer__text"><%=WeiXin.GetCookie("workcode") +((LoginUser)WeiXin.GetJsonCookie()).UserName %></p>
        </div>

    </form>
</body>
</html>
