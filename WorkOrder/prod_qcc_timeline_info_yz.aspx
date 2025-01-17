﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="prod_qcc_timeline_info_yz.aspx.cs" Inherits="prod_qcc_timeline_info_yz" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>入库单明细</title>
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

            <div class="page__bd" style="height: 100%;">
                <%--=================入库=========================--%>
                <ul class="collapse">
                    <li class="js-show">
                        <div class="weui-flex js-category_">
                            <div class="weui-mark-vip"><span class="weui-mark-lt  bg-gray "></span></div>
                            <div class="weui-flex__item">入库完成</div>
                            单号:<% ="<font class='tag'/>"+Request["dh"] %><%--<i class="icon icon-35 padding10-l"></i>--%>
                        </div>
                        <div class="page-category js-categoryInner">
                            <div class="weui-cells page-category-content">
                                <div class="weui-form-preview__bd ">
                                    <asp:Repeater runat="server" ID="dtMain">
                                        <ItemTemplate>
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">物料号</label>
                                                <span class="weui-form-preview__value"><%# Eval("pgino") %></span>
                                            </div>
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">零件号</label>
                                                <span class="weui-form-preview__value"><%# Eval("pn") %> </span>
                                            </div>
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">入库数量</label>
                                                <span class="weui-form-preview__value"><%# Eval("act_qty") %> </span>
                                            </div>
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">入库时间</label>
                                                <span class="weui-form-preview__value"><%# DataBinder.Eval(Container.DataItem, "ruku_date_hg","{0:MM-dd HH:mm}") %> | 时长：<span class="f-blue"><%#  Eval("shichang") %></span></span>
                                            </div>
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">入库人</label>
                                                <span class="weui-form-preview__value"><%#  Eval("cellphone") %><%#  Eval("emp_name_hg") %> </span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>

                <%--==============  GP12========================================--%>
                <%  int i = 0;
                    foreach (System.Data.DataRow dr in dtGP12.Rows)
                    {
                        //if (i == 0)
                        //{%>
                    <div class="weui-flex" style="height:28px; padding-top:2px; padding-bottom:2px;">
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

                <% //}
                    i++; %>
                <% foreach (System.Data.DataRow dr_m_ in dtGP12_m.Select("qc_dh='" + dr["qc_dh"].ToString() + "'"))
                {%>
                <ul class="collapse">
                    <li  class="js-show">
                        <div class="weui-flex js-category">
                            <div class="weui-flex__item"><%= dr_m_["on_date_str"] +" "+dr_m_["emp_name"] + " 已检数:"+ dr_m_["qty"] %></div>
                            <i class="icon icon-35 padding10-l"></i>
                        </div>
                        <div class="page-category js-categoryInner">
                            <div class="weui-cells page-category-content">
                                 <% foreach (System.Data.DataRow dr_ in dtGP12_dtl.Select("qc_dh='" + dr["qc_dh"].ToString() + "' and emp_name='" 
                                       + dr_m_["emp_name"].ToString() + "' and on_date_str='" + dr_m_["on_date_str"].ToString() + "'"))
                                {%>
                                <div class="weui-cell__bd" style="padding-left:15px;margin-bottom:5px;">
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        <%= "来自<a href='prod_qcc_part_detail.aspx?dh="+dr_["workorder"]+"'>"+dr_["workorder"] + "</a>,"+dr_["wk_ly"]+"完成数" + dr_["off_qty"] + ",已检数" +dr_["hege_qty"] %>
                                    </span>
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        <%= dr_["pgino"] + "," + dr_["pn"] %>
                                    </span>
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        <%= dr_["wk_ly"]+"完成时间"+string.Format("{0:MM-dd HH:mm}",dr_["begin_date"]) + ",时长" %> <%--+ dr_["shichang"]--%>
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
                <%  i = 0;
                    foreach (System.Data.DataRow dr in dtQC.Rows)
                    {
                        //if (i == 0)
                        //{%>
                    <div class="weui-flex" style="height:28px; padding-top:2px; padding-bottom:2px;">
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
        

                <% //}
                    i++; %>
                <% foreach (System.Data.DataRow dr_m_ in dtQC_m.Select("qc_dh='" + dr["qc_dh"].ToString() + "'"))
                {%>
                <ul class="collapse">
                    <li class="js-show">
               
                        <div class="weui-flex js-category">
                            <div class="weui-flex__item"><%=dr_m_["on_date_str"]+" "+dr_m_["emp_name"]   +" 已检数:"+ dr_m_["qty"] %></div>
                            <i class="icon icon-35 padding10-l"></i>
                        </div>
                        <div class="page-category js-categoryInner"> 
                            <div class="weui-cells page-category-content">
                                <% foreach (System.Data.DataRow dr_ in dtQC_dtl.Select("qc_dh='" + dr["qc_dh"].ToString() + "' and emp_name='" 
                                       + dr_m_["emp_name"].ToString() + "' and on_date_str='" + dr_m_["on_date_str"].ToString() + "'"))
                                {%>
                                <div class="weui-cell__bd" style="padding-left:15px;margin-bottom:5px;"><%-- border-bottom:1px solid #e5e5e5;--%>
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        <%= "来自<a href='prod_qcc_part_detail.aspx?dh="+dr_["workorder"]+"'>"+dr_["workorder"] + "</a>,"+dr_["wk_ly"]+"完成数" + dr_["off_qty"] + ",已检数" +dr_["hege_qty"] %>
                                    </span>
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        <%= dr_["pgino"] + "," + dr_["pn"] %>
                                    </span>
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        <%= dr_["wk_ly"]+"完成时间"+string.Format("{0:MM-dd HH:mm}",dr_["begin_date"]) + ",时长" %><%-- + dr_["shichang"]--%>
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

                <%--=======后处理完成========================================--%>
                <%  i = 0;
                    foreach (System.Data.DataRow dr in dtHsolve.Rows)
                    {
                        //if (i == 0)
                        //{%>
                    <div class="weui-flex" style="height:28px; padding-top:2px; padding-bottom:2px;">
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
                            <label class="weui-form-preview__label">已后处理</label>
                            <span class="weui-form-preview__value"><%=dr["qty"] %></span>
                        </div>  
                    </div>     

                <% //}
                    i++; %>
                 <% foreach (System.Data.DataRow dr_m_ in dtHsolve_m.Rows)
                    {%>
                <ul class="collapse">
                    <li class="js-show">                
                        <div class="weui-flex js-category">
                            <div class="weui-flex__item"><%=dr_m_["off_date_str"] +" "+dr_m_["emp_name"] + " 下料数:"+ dr_m_["qty"] %></div>
                            <i class="icon icon-35 padding10-l"></i>
                        </div>                    
                        <div class="page-category js-categoryInner "> 
                            <div class="weui-cells page-category-content">
                                <% foreach (System.Data.DataRow dr_ in dtHsolve_dtl.Select(" emp_name='"  + dr_m_["emp_name"].ToString() + "' and off_date_str='" + dr_m_["off_date_str"].ToString() + "'"))
                                {%>
                                <div class="weui-cell__bd" style="padding-left:15px;margin-bottom:5px;">
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">                                       

                                        来自:<a href="prod_qcc_part_detail.aspx?dh=<%=dr_["source_dh"] %>&para=N"><%= dr_["source_dh"] %></a>
                                        <%= ",上料数" + dr_["qty"] + ",下料数" +dr_["hege_qty"] %>
                                    </span>
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        <%= dr_["pgino"] + "," + dr_["pn"] %>
                                    </span>
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        <%= "上料时间"+string.Format("{0:MM-dd HH:mm}",dr_["on_date"]) + ",时长" %> 
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
                        //if (i == 0)
                        //{%>
                    <div class="weui-flex" style="height:28px; padding-top:2px; padding-bottom:2px;">
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
                    </div>
                <% //}
                    i++; %>
                <% foreach (System.Data.DataRow dr_m_ in dtProd_m.Select("workorder='" + dr["workorder"].ToString() + "'"))
                    {%>
                <ul class="collapse">
                    <li class="js-show">                
                        <div class="weui-flex js-category">
                            <div class="weui-flex__item"><%=dr_m_["off_date_str"] +" "+dr_m_["emp_name"] + " 下料数:"+ dr_m_["qty"] %></div>
                            <i class="icon icon-35 padding10-l"></i>
                        </div>                    
                        <div class="page-category js-categoryInner "> 
                            <div class="weui-cells page-category-content">
                                <% foreach (System.Data.DataRow dr_ in dtProd_dtl.Select("workorder='" + dr["workorder"].ToString() + "' and emp_name='" 
                                       + dr_m_["emp_name"].ToString() + "' and off_date_str='" + dr_m_["off_date_str"].ToString() + "'"))
                                {%>
                                <div class="weui-cell__bd" style="padding-left:15px;margin-bottom:5px;"><%-- border-bottom:1px solid #e5e5e5;--%>
                                    
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        <%= dr_["pgino"] + "," + dr_["pn"] %>  
                                    </span>
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        <%= "下料时间"+string.Format("{0:MM-dd HH:mm}",dr_["off_date"])   %>  
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


        <%--<div class="weui-footer weui-footer_fixed-bottom">
            <p class="weui-footer__text"><%=WeiXin.GetCookie("workcode") +((LoginUser)WeiXin.GetJsonCookie()).UserName %></p>
        </div>--%>

    </form>
</body>
</html>
