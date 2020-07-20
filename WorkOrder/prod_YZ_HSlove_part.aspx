<%@ Page Language="C#" Title="后处理部分操作明细" AutoEventWireup="true" CodeFile="prod_YZ_HSlove_part.aspx.cs" Inherits="prod_YZ_HSlove_part" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><%=Title %></title>
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
                
                

                <%--=======后处理完成========================================--%>
                <%   
                    foreach (System.Data.DataRow dr in dtHCL.Rows)
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
                        <%--<div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">下料数量</label>
                            <span class="weui-form-preview__value"><%=dr["off_qty"] %></span>
                        </div>--%>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">已处理数量</label>
                            <span class="weui-form-preview__value"><%=dr["solve_qty"] %></span>
                        </div>  
                    </div>
        

               
                <% foreach (System.Data.DataRow dr_m_ in dtHCL_m.Rows)
                {%>
                <ul class="collapse">
                    <li class="js-show">
               
                        <div class="weui-flex js-category">
                            <div class="weui-flex__item"><%=dr_m_["off_date_str"]+ " "+dr_m_["emp_name"]  +" 已处理数:"+ dr_m_["solve_qty"] %></div>
                            <i class="icon icon-35 padding10-l"></i>
                        </div>
                        <div class="page-category js-categoryInner"> 
                            <div class="weui-cells page-category-content">
                                <% foreach (System.Data.DataRow dr_d in dtHCL_dtl.Select("workorder='" + dr["workorder"].ToString() + "' and emp_name='" 
                                       + dr_m_["emp_name"].ToString() + "' and off_date_str='" + dr_m_["off_date_str"].ToString() + "'"))
                                {%>
                                <div class="weui-cell__bd" style="padding-left:15px;margin-bottom:5px;">
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        <%= "来自<a href='prod_YZ_end_detail_v1.aspx?dh="+dr_d["source_dh"]+"'>"+dr_d["source_dh"] + "</a>,"+dr_d["wk_ly"]+"完成数" + dr_d["off_qty"] + ",已处理数" +dr_d["solve_qty"] %>
                                    </span>
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        <%= dr_d["pgino"] + "," + dr_d["pn"] %>
                                    </span>
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        <%= dr_d["wk_ly"]+"完成时间"+string.Format("{0:MM-dd HH:mm}",dr_d["on_date"]) + ",时长" %><%-- + dr_["shichang"]--%>
                                        <span class="f-blue"> <%=dr_d["shichang"].ToString() %></span>  
                                    </span>
                                </div>
                                <%} %>
                            </div>
                        </div>
                
                    </li>
                </ul>
                <%} %>
                <% } %>


              

                <%--后处理完成--%>


            </div>
        </div>


        <div class="weui-footer weui-footer_fixed-bottom">
            <p class="weui-footer__text"><%=WeiXin.GetCookie("workcode") +((LoginUser)WeiXin.GetJsonCookie()).UserName %></p>
        </div>

    </form>
</body>
</html>
