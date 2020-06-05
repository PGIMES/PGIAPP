<%@ Page Language="C#" AutoEventWireup="true" CodeFile="YL_Detail_Info.aspx.cs" Inherits="YL_Detail_Show" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>要料操作明细</title>
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
                            <div class="weui-flex__item"> 要料信息</div>
                            要料单号:<% ="<font class='tag'/>"+Request["need_no"] %><i class="icon icon-35 padding10-l"></i>
                        </div>
                        <div class="page-category js-categoryInner">
                            <div class="weui-cells page-category-content">

                                <div class="weui-form-preview__bd ">
                                    <asp:Repeater runat="server" ID="dtMain">
                                        <ItemTemplate>                                           
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">要料人</label>
                                                <span class="weui-form-preview__value"><%#  Eval("cellphone") %><%#  Eval("emp_name") %> </span>
                                            </div>
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">要料时间</label>
                                                <span class="weui-form-preview__value"><%# DataBinder.Eval(Container.DataItem, "req_date","{0:MM-dd HH:mm}") %> </span>
                                            </div>
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">岗位</label>
                                                <span class="weui-form-preview__value"><%# Eval("worklocation") %></span>
                                            </div>
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">物料号</label>
                                                <span class="weui-form-preview__value"><%# Eval("pgino") %></span>
                                            </div>
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">零件号</label>
                                                <span class="weui-form-preview__value"><%# Eval("pn") %> </span>
                                            </div>
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">零件名称</label>
                                                <span class="weui-form-preview__value"><%# Eval("descr") %> </span>
                                            </div>
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">要料数量</label>
                                                <span class="weui-form-preview__value"><%# Eval("need_qty") %> </span>
                                            </div>
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">要求送到时间</label>
                                                <span class="weui-form-preview__value"><%# DataBinder.Eval(Container.DataItem, "need_date","{0:MM-dd HH:mm}") %>  | <font class="f-blue"><%# Eval("d") %> </font></span>
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
               <%-- <i class="icon icon-2 f20"></i>--%>

                <ul class="collapse">
                    <li class="js-show">
                        <div class="weui-flex js-category">
                            <div class="weui-flex__item"><% =dr["title"] %></div>
                             <%= dr["lot_no"] ==""?"":"Lot:"+dr["lot_no"] %>
                            <i class="icon icon-35 padding10-l"></i>
                        </div>
                        <div class="page-category js-categoryInner">
                            <div class="weui-cells page-category-content">
                                <div class="weui-form-preview__bd ">
                                    <% if (dr["title"].ToString() == "送料信息")
                                        { %>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">送料人</label>
                                        <span class="weui-form-preview__value"><%  =dr["cellphone"] %><%  =dr["emp_name"] %> </span>
                                    </div>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">送料数量</label>
                                        <span class="weui-form-preview__value"><%=dr["qty"] %>  </span>
                                    </div>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">送料时间</label>
                                        <span class="weui-form-preview__value"><%= string.Format("{0:MM-dd HH:mm}",dr["date"])%> 时长:<font class="<%=dr["shichang"].ToString().Contains("-")?"f-blue":"f-red"%>"> <%=dr["shichang"].ToString() %></font>  </span>
                                    </div>
                                    <% }
                                    else if (dr["title"].ToString() == "上料信息")
                                    {  %>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">上料人</label>
                                        <span class="weui-form-preview__value"><%=dr["cellphone"] %><%=dr["emp_name"] %> </span>
                                    </div>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">上料数量</label>
                                        <span class="weui-form-preview__value"><% =dr["qty"] %> </span>
                                    </div>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">上料时间</label>
                                        <span class="weui-form-preview__value"><%=string.Format("{0:MM-dd HH:mm}",dr["date"]) %>  </span>
                                    </div>
                                    <% }
                                    else if (dr["title"].ToString() == "退料信息")
                                    {  %>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">退料人</label>
                                        <span class="weui-form-preview__value"><%=dr["cellphone"] %><%=dr["emp_name"] %> </span>
                                    </div>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">退料数量</label>
                                        <span class="weui-form-preview__value"><%=dr["qty"] %> </span>
                                    </div>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">退料时间</label>
                                        <span class="weui-form-preview__value"><%=string.Format("{0:MM-dd HH:mm}",dr["date"]) %>  </span>
                                    </div>
                                    <% }
                                        else if (dr["title"].ToString() == "取消要料")
                                        {  %>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">取消人</label>
                                        <span class="weui-form-preview__value"><%=dr["cellphone"] %><%=dr["emp_name"] %> </span>
                                    </div>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">取消数量</label>
                                        <span class="weui-form-preview__value"><%=dr["qty"] %> </span>
                                    </div>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">取消时间</label>
                                        <span class="weui-form-preview__value"><%=string.Format("{0:MM-dd HH:mm}",dr["date"]) %>  </span>
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


        <div class="weui-footer weui-footer_fixed-bottom">
            <p class="weui-footer__text"><%=WeiXin.GetCookie("workcode") +((LoginUser)WeiXin.GetJsonCookie()).UserName %></p>
        </div>

    </form>
</body>
</html>
