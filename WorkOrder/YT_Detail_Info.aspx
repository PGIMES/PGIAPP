<%@ Page Language="C#" AutoEventWireup="true" CodeFile="YT_Detail_Info.aspx.cs" Inherits="YT_Detail_Info" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>要汤操作明细</title>
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
                <ul class="collapse">
                    <li class="js-show">
                        <div class="weui-flex js-category">
                            <div class="weui-mark-vip"><span class="weui-mark-lt  bg-gray "></span></div>
                            <div class="weui-flex__item"> 要汤单号</div>
                            <% ="<font class='tag'/>"+Request["need_t_no"] %><i class="icon icon-35 padding10-l"></i>
                        </div>
                        <div class="page-category js-categoryInner">
                            <div class="weui-cells page-category-content">
                                <div class="weui-form-preview__bd ">
                                    <asp:Repeater runat="server" ID="dtMain">
                                        <ItemTemplate>                                           
                                            <div class="weui-mark-vip">
                                                <span class="weui-mark-lt <%# Eval("status").ToString()=="1"?"bg-gray":"bg-yellow"%>"></span>
                                            </div>
                            
                                           <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">压铸机</label>
                                                <span class="weui-form-preview__value"><%# Eval("yzj_no_desc") %></span>
                                            </div>
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">材料</label>
                                                <span class="weui-form-preview__value"><%# Eval("cl") %></span>
                                            </div>
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">要求送到时间</label>
                                                <span class="weui-form-preview__value">
                                                    <%# Eval("need_date_dl")%>
                                                    <%# Eval("need_date","{0:yyyy-MM-dd HH:mm}")%>
                                                </span>
                                            </div>  
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">要汤人</label>
                                                <span class="weui-form-preview__value">
                                                    <%# Eval("phone")+""+ Eval("emp_name") %>
                                                    <%# Eval("times_type") %> <font class="f-blue"><%# Eval("times") %></font>
                                                </span>
                                
                                            </div>               
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>



                <% foreach (System.Data.DataRow dr in dtDetail.Rows)
                    { %>

                <ul class="collapse">
                    <li class="js-show">
                        <div class="weui-flex js-category">
                            <div class="weui-flex__item"><% =dr["title"] %></div>
                             <%= dr["lot_no"].ToString() ==""?"":"Lot:"+dr["lot_no"] %>
                            <i class="icon icon-35 padding10-l"></i>
                        </div>
                        <div class="page-category js-categoryInner">
                            <div class="weui-cells page-category-content">
                                <div class="weui-form-preview__bd ">
                                    <% if (dr["title"].ToString() == "送汤信息")
                                        { %>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">送汤人</label>
                                        <span class="weui-form-preview__value"><%  =dr["phone"] %><%  =dr["emp_name"] %> </span>
                                    </div>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">转运包</label>
                                        <span class="weui-form-preview__value"><%=dr["zyb"] %></span>
                                    </div>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">送汤量</label>
                                        <span class="weui-form-preview__value"><%=dr["qty"] %> KG </span>
                                    </div>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">送汤时间</label>
                                        <span class="weui-form-preview__value">
                                            <%= string.Format("{0:MM-dd HH:mm}",dr["date"])%> 时长<font class="f-blue"> <%=dr["shichang"].ToString() %></font>
                                        </span>
                                    </div>
                                    <% }
                                        else if (dr["title"].ToString() == "取消要汤")
                                        {  %>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">取消人</label>
                                        <span class="weui-form-preview__value"><%=dr["phone"] %><%=dr["emp_name"] %> </span>
                                    </div>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">取消时间</label>
                                        <span class="weui-form-preview__value"><%=string.Format("{0:MM-dd HH:mm}",dr["date"]) %> 时长<font class="f-blue"> <%=dr["shichang"].ToString() %> </span>
                                    </div>
                                    <% } %>  
                                </div>

                            </div>
                        </div>
                    </li>
                </ul>

                <% } %>
                
            </div>
        </div>

    </form>
</body>
</html>
