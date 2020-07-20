<%@ Page Language="C#" Title="操作明细" AutoEventWireup="true" CodeFile="prod_YZ_HSolve_Wip.aspx.cs" Inherits="prod_YZ_HSolve_Wip" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>操作明细</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0" />
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

        })
    </script>
</head>
<body ontouchstart>
    <form id="form1" runat="server">
        <div class="page">
            <div class="page__bd" id="t2" style="height: 100%;">

 
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
                            <div class="weui-flex__item"><%=dr_m_["emp_name"] +" "+ dr_m_["on_date_str"] +" 已检数:"+ dr_m_["qty"] %></div>
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


                <%--====下料完成======================================--%>
                <%  i = 0;
                    foreach (System.Data.DataRow dr in dtProd.Rows)
                    {
                         %>
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
                            <% foreach (System.Data.DataRow dr_ in dtProd_dtl.Select("workorder='" + dr["workorder"].ToString() + "' and emp_name='" + dr_m_["emp_name"].ToString() + "' and off_date_str='" + dr_m_["off_date_str"].ToString() + "'"))
                               { %>
                                <div class="weui-cell__bd" style="padding-left:15px;margin-bottom:5px;"> 
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        
                                    </span>
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        <%= dr_["pgino"] + ","+ dr_["pn"] + dr_["sku_descr"] %>
                                    </span>
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        <%=  "下料数：" +dr_["off_qty"] %><%= "  下料时间"+string.Format("{0:MM-dd HH:mm}",dr_["off_date"])   %>  
                                          
                                    </span>
                                </div>
                            <% } %>
                            </div>
                        </div>               
                    </li>
                </ul> 
                <%} %>

                <% } %>




            </div>
        </div>


        <div class="weui-footer weui-footer_fixed-bottom">
            <p class="weui-footer__text"><%=WeiXin.GetCookie("workcode") +((LoginUser)WeiXin.GetJsonCookie()).UserName %></p>
        </div>

    </form>
</body>
</html>
