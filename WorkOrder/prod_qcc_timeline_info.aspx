<%@ Page Language="C#" AutoEventWireup="true" CodeFile="prod_qcc_timeline_info.aspx.cs" Inherits="prod_qcc_timeline_info" %>

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
                        <div class="weui-flex js-category">
                            <div class="weui-mark-vip"><span class="weui-mark-lt  bg-gray "></span></div>
                            <div class="weui-flex__item">入库完成</div>
                            单号:<% ="<font class='tag'/>"+Request["dh"] %><i class="icon icon-35 padding10-l"></i>
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
                                                <span class="weui-form-preview__value"><%# DataBinder.Eval(Container.DataItem, "ruku_date_hg","{0:MM-dd HH:mm}") %>   </span>
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
                        if (i == 0)
                        {%>
                <div class="weui-flex js-category">
                    <div class="weui-flex__item margin10-l"><%=dr["title"] %></div>
                    <div class="margin20-r">单号:<% =dr["qc_dh"] %></div>
                </div>

                <% }
                    i++; %>

                <ul class="collapse">
                    <li class="">
                        <div class="weui-flex js-category">
                            <div class="weui-flex__item margin10-l"><%=dr["workorder"] %></div>
                            <i class="icon icon-35 padding10-l"></i>
                        </div>
                        <div class="page-category js-categoryInner" style="margin-left:20px">
                            <div class="weui-cells page-category-content">
                                <div class="weui-form-preview__bd ">
                                    <% if (dr["title"].ToString() == "GP12完成")
                                        { %>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">检验人</label>
                                        <span class="weui-form-preview__value"><%--<%  =dr["cellphone"] %>--%><%  =dr["emp_name"] %> </span>
                                    </div>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">下料数量</label>
                                        <span class="weui-form-preview__value"><%=dr["off_qty"] %>  </span>
                                    </div>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">合格数量</label>
                                        <span class="weui-form-preview__value"><%=dr["hege_qty"] %>  </span>
                                    </div>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">检验时间</label>
                                        <span class="weui-form-preview__value"><%= string.Format("{0:MM-dd HH:mm}",dr["on_date"])%> <%--时长:<font class="<%=dr["shichang"].ToString().Contains("-")?"f-blue":"f-red"%>"> <%=dr["shichang"].ToString() %></font> --%> </span>
                                    </div>
                                    <% } %>
                                </div>

                            </div>
                        </div>
                    </li>
                </ul>
                <% } %>


                <%--=======终检完成========================================--%>
                <%  i = 0;
                    foreach (System.Data.DataRow dr in dtQC.Rows)
                    {
                        if (i == 0)
                        {%>
                <div class="weui-flex js-category">
                    <div class="weui-flex__item margin10-l"><%=dr["title"] %></div>
                    <div class="margin20-r">单号:<% =dr["qc_dh"] %></div>
                </div>

                <% }
                    i++; %>

                <ul class="collapse">
                    <li class="">
                        <div class="weui-flex js-category">
                            <div class="weui-flex__item margin10-l"><%=dr["workorder"] %></div>
                            <i class="icon icon-35 padding10-l"></i>
                        </div>
                        <div class="page-category js-categoryInner" style="margin-left:20px">
                            <div class="weui-cells page-category-content">
                                <div class="weui-form-preview__bd ">
                                    <% if (dr["title"].ToString() == "终检完成")
                                        { %>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">检验人</label>
                                        <span class="weui-form-preview__value"><%--<%  =dr["cellphone"] %>--%><%  =dr["emp_name"] %> </span>
                                    </div>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">下料数量</label>
                                        <span class="weui-form-preview__value"><%=dr["off_qty"] %>  </span>
                                    </div>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">合格数量</label>
                                        <span class="weui-form-preview__value"><%=dr["hege_qty"] %>  </span>
                                    </div>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">检验时间</label>
                                        <span class="weui-form-preview__value"><%= string.Format("{0:MM-dd HH:mm}",dr["on_date"])%> <%--时长:<font class="<%=dr["shichang"].ToString().Contains("-")?"f-blue":"f-red"%>"> <%=dr["shichang"].ToString() %></font> --%> </span>
                                    </div>
                                    <% } %>
                                </div>

                            </div>
                        </div>
                    </li>
                </ul>
                <% } %>



                <%--====下料完成======================================--%>
                <%  i = 0;                   
                    System.Data.DataView dataView = dtProd.DefaultView;
                    System.Data.DataTable dtWorkorderDist = dataView.ToTable(true,"workorder");
                    foreach (System.Data.DataRow dr in dtWorkorderDist.Rows)
                    {
                        if (i == 0)
                        {%>
                <div class="weui-flex js-category">
                    <div class="weui-flex__item margin10-l">生产完成</div>
                    <div class="margin20-r"></div>
                </div>
                <% }
                    i++; %>
                <ul class="collapse">
                    <li class="">
                        <div class="weui-flex js-category">
                            <div class="weui-flex__item margin10-l"><%=dr["workorder"] %></div>
                            <i class="icon icon-35 padding10-l"></i>
                        </div>
                         <% foreach (System.Data.DataRow dr_ in dtProd.Select("workorder='" + dr["workorder"].ToString() + "'"))
                             {%>
                        <div class="page-category js-categoryInner " style="margin-left:40px">
                            Lot:<%=dr_["lot_no"] %>
                            <div class="weui-cells page-category-content">
                                <div class="weui-form-preview__bd ">
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">物料号</label>
                                        <span class="weui-form-preview__value"><%=dr_["sku"] %></span>
                                    </div>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">零件号</label>
                                        <span class="weui-form-preview__value"><%=dr_["sku_descr"] %> </span>
                                    </div>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">数量</label>
                                        <span class="weui-form-preview__value"><%=dr_["par_qty"] %> </span>
                                    </div>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">上线时间</label>
                                        <span class="weui-form-preview__value"><%=string.Format("{0:MM-dd HH:mm}",dr_["on_date"]) %>   </span>
                                    </div>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">下线时间</label>
                                        <span class="weui-form-preview__value"><%=string.Format("{0:MM-dd HH:mm}",dr_["off_date"]) %>   </span>
                                    </div>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">下料人</label>
                                        <span class="weui-form-preview__value"><%=dr_["emp_name"] %> </span>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <%} %>
                    </li>
                </ul>

                <% } %>

                <%--                <asp:Repeater runat="server" ID="RptPRODDUCT">
                    <ItemTemplate>
                        <ul class="collapse">
                            <li class="js-show">
                                <div class="weui-flex js-category">
                                    <div class="weui-mark-vip"><span class="weui-mark-lt  bg-gray "></span></div>
                                    <div class="weui-flex__item">下料完成</div>
                                    单号:<%# Eval("workorder") %><i class="icon icon-35 padding10-l"></i>
                                </div>
                                <div class="page-category js-categoryInner">
                                    <div class="weui-cells page-category-content">
                                        <div class="weui-form-preview__bd ">

                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">物料号</label>
                                                <span class="weui-form-preview__value"><%# Eval("pgino") %></span>
                                            </div>
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">零件号</label>
                                                <span class="weui-form-preview__value"><%# Eval("pn") %> </span>
                                            </div>
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">数量</label>
                                                <span class="weui-form-preview__value"><%# Eval("par_qty") %> </span>
                                            </div>
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">上线时间</label>
                                                <span class="weui-form-preview__value"><%# DataBinder.Eval(Container.DataItem, "on_date","{0:MM-dd HH:mm}") %>   </span>
                                            </div>
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">下线时间</label>
                                                <span class="weui-form-preview__value"><%# DataBinder.Eval(Container.DataItem, "off_date","{0:MM-dd HH:mm}") %>   </span>
                                            </div>
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">上料人</label>
                                                <span class="weui-form-preview__value"><%#  Eval("emp_name") %> </span>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </ItemTemplate>
                </asp:Repeater>
                --%>




                <% foreach (System.Data.DataRow dr in dtDetail.Rows)
                    { %>

                <ul class="collapse">
                    <li class="js-show">
                        <div class="weui-flex js-category">
                            <div class="weui-flex__item"><% =dr["title"] %></div>
                            Lot: <%=dr["lot_no"] %>
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
