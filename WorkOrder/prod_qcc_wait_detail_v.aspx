<%@ Page Language="C#" AutoEventWireup="true" CodeFile="prod_qcc_wait_detail_v.aspx.cs" Inherits="WorkOrder_prod_qcc_wait_detail_v" %>

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
        });
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
                            <label class="weui-form-preview__label"><%= Request["laiyuan"].ToString() %></label>
                            <label class="weui-form-preview__"><% ="<font class='tag'/>"+Request["dh"] %></label>
                        </div>
                    </div>
                    <div class="weui-form-preview__bd">
                        <asp:Repeater runat="server" ID="rptMain">
                            <ItemTemplate>
		                        <div class="weui-mark-vip"><span class="weui-mark-lt <%# Eval("zt").ToString()=="1"?"bg-gray":"bg-yellow"%>"></span></div>                                
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">项目号</label>
                                    <span class="weui-form-preview__value"><%# Eval("pgino") %></span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">零件号</label>
                                    <span class="weui-form-preview__value"><%# Eval("pn") %> </span>
                                </div>           
                                <% if (Request["laiyuan"].ToString()=="终检单号")%>
	                             <% { %>                      
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">终检数量</label>
                                    <span class="weui-form-preview__value"><%# Eval("qty") %> </span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">GP12已检数量</label>
                                    <span class="weui-form-preview__value"><%# Eval("off_qty") %> </span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">GP12 NG数量</label>
                                    <span class="weui-form-preview__value"><%# Eval("ng_qty") %> </span>
                                </div>
                                 <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">GP12待检数量</label>
                                    <span class="weui-form-preview__value"><%# Eval("wip_qty") %> </span>
                                </div>
	                             <% } %>
                                <% if (Request["laiyuan"].ToString()=="完工单号")%>
	                             <% { %>                       
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">完工数量</label>
                                    <span class="weui-form-preview__value"><%# Eval("qty") %> </span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">已终检数量</label>
                                    <span class="weui-form-preview__value"><%# Eval("off_qty") %> </span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">终检NG数量</label>
                                    <span class="weui-form-preview__value"><%# Eval("ng_qty") %> </span>
                                </div>
                                 <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">待终检数量</label>
                                    <span class="weui-form-preview__value"><%# Eval("wip_qty") %> </span>
                                </div>
	                             <% } %>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    
                </div>


                <%--==============  GP12========================================--%>
        <% 
            foreach (System.Data.DataRow dr in dtGP12.Rows)
            {
                %>
        <% foreach (System.Data.DataRow dr_m_ in dtGP12_m.Select("qc_dh='" + dr["qc_dh"].ToString() + "'"))
        {%>
        <ul class="collapse">
            <li class="js-show">
                <div class="weui-flex js-category">
                    <div class="weui-flex__item"><%=dr_m_["emp_name"] +" "+ dr_m_["on_date_str"] +" 已检数:"+ dr_m_["qty"] %></div>
                    <i class="icon icon-35 padding10-l"></i>
                </div>
                <div class="page-category js-categoryInner"><%-- style="margin-left:20px"--%>
                    <div class="weui-cells page-category-content">
                         <% foreach (System.Data.DataRow dr_ in dtGP12_dtl.Select("qc_dh='" + dr["qc_dh"].ToString() + "' and emp_name='" 
                               + dr_m_["emp_name"].ToString() + "' and on_date_str='" + dr_m_["on_date_str"].ToString() + "'"))
                        {%>
                        <div class="weui-cell__bd" style="padding-left:15px;margin-bottom:5px;">
                            <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                <%--<%= "来自"+dr_["qc_dh"] + ",生产完成数" + dr_["off_qty"] + ",已检数" +dr_["hege_qty"] %>--%>

                                来自<%= dr_["qc_dh"] %><%--<a href="prod_wip_detail_V1.aspx?lotno=<%=dr_["lot_no"] %>&para=N"><%= dr_["qc_dh"] %></a>--%>
                                <%= ",生产完成数" + dr_["off_qty"] + ",已检数" +dr_["hege_qty"] %>
                            </span>
                            <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                <%= dr_["pgino"] + "," + dr_["pn"] %>
                            </span>
                            <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                <%= "GP12完成时间"+string.Format("{0:MM-dd HH:mm}",dr_["begin_date"]) + ",时长" %> 
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



                  <%--=======终检完成========================================--%>
                <%
                    foreach (System.Data.DataRow dr in dtQC.Rows)
                    {%>
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
                                <div class="weui-cell__bd" style="padding-left:15px;margin-bottom:5px;">
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        <%= "来自"+dr_["workorder"] + ",生产完成数" + dr_["off_qty"] + ",已检数" +dr_["hege_qty"] %>
                                    </span>
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        <%= dr_["pgino"] + "," + dr_["pn"] %>
                                    </span>
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        <%= "终检完成时间"+string.Format("{0:MM-dd HH:mm}",dr_["begin_date"]) + ",时长" %>
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


            </div>
        </div>


       <%-- <div class="weui-footer weui-footer_fixed-bottom">
            <p class="weui-footer__text"><%=WeiXin.GetCookie("workcode") +((LoginUser)WeiXin.GetJsonCookie()).UserName %></p>
        </div>--%>

    </form>
</body>
</html>
