<%@ Page Language="C#" AutoEventWireup="true" CodeFile="prod_end_detail_v2.aspx.cs" Inherits="prod_end_detail_v2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>生产完成明细</title>
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
                            <label class="weui-form-preview__label">完工单号</label>
                            <label class="weui-form-preview__"><% ="<font class='tag'/>"+Request["dh"] %></label>
                        </div>
                    </div>
                    <div class="weui-form-preview__bd">
                        <asp:Repeater runat="server" ID="dtMain">
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
                                    <label class="weui-form-preview__label">完工数量</label>
                                    <span class="weui-form-preview__value"><%# Eval("par_qty") %> </span>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    <div class="weui-form-preview__bd ">
                    </div>
                </div>

                <% 

                    int i = 0;
                     
                    System.Data.DataTable dt_m = ds.Tables[0];
                    System.Data.DataTable dt_d = ds.Tables[1];

                    foreach (System.Data.DataRow dr in dt_m.Rows)
                    {%>
                <ul class="collapse">
                    <li class="js-show">                
                        <div class="weui-flex js-category">
                            <div class="weui-flex__item"><%=dr["emp_name"] +" "+ dr["off_date"] +" 下料数:"+ dr["off_qty"] %></div>
                            <i class="icon icon-35 padding10-l"></i>
                        </div>                    
                        <div class="page-category js-categoryInner "> 
                            <div class="weui-cells page-category-content">
                                <% foreach (System.Data.DataRow dr_ in dt_d.Select(" emp_name='" + dr["emp_name"].ToString() + "' and off_date_str='" + dr["off_date"] + "'"))
                                {%>
                                <div class="weui-cell__bd" style="padding-left:15px;margin-bottom:5px;"><%-- border-bottom:1px solid #e5e5e5;--%>
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        <%= "Lot:<a href='prod_wip_detail_V1.aspx?lotno="+(dr_["new_lot"].ToString().IndexOf("/") < 0 ? dr_["new_lot"].ToString():dr_["new_lot"].ToString().Substring(0,dr_["new_lot"].ToString().IndexOf("/")))+"&para=N'>"+dr_["new_lot"] + "</a>,上料数" + dr_["qty"] + ",下料数" +dr_["off_qty"]+" --> "+dr_["par_qty"] %>
                                    </span>
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        <%= dr_["sku"] + "," + dr_["sku_descr"] %>
                                    </span>
                                    <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                        <%= "上料时间"+string.Format("{0:MM-dd HH:mm}",dr_["on_date"]) + ",时长" %> <%--+ dr_["shichang"]--%>
                                        <span class="f-blue"> <%=dr_["times"].ToString() %></span>  
                                    </span>
                                </div>
                                <%} %>
                            </div>
                        </div>               
                    </li>
                </ul> 
                <%} %>

 


                <%--不使用--%>
                <div class="weui-form-preview hide">
                    <div class="weui-cells__title ">
                       <%-- <i class="icon nav-icon icon-49"></i>--%>
                        <asp:Label ID="Label1" runat="server" Text="用料明细"></asp:Label>
                    </div>
                    <div class="weui-cells">
                        <asp:Repeater ID="DataList1" runat="server">
                            <ItemTemplate>
                                <a class="weui-cell " href="javascript:void(0)">
                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-<% =Request["type"] == "workorder" ? "gray" : "yellow" %>"></span></div>
                                    <div class="weui-cell__hd">
                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                    </div>
                                    <div class="weui-cell__bd f-black" style="font-size: smaller">
                                        <span class="span_space">
                                            <font color="blue"><%# DataBinder.Eval(Container.DataItem, "sku") %></font>
                                        </span>
                                        <span>
                                            <%# DataBinder.Eval(Container.DataItem, "sku_descr") %>
                                        </span>
                                        <br />
                                        <%--<span class="span_space">完工单号:<%# DataBinder.Eval(Container.DataItem, "workorder_part") %>--%>
                                        </span>
                                        <span>Lot:<font color="blue"><%# DataBinder.Eval(Container.DataItem, "new_lot") %></font></span>
                                        <span>上料数:<font color="blue"><%# DataBinder.Eval(Container.DataItem, "qty") %></font></span>
                                        <span>下料数:<font color="blue"><%# DataBinder.Eval(Container.DataItem, "off_qty") %></font></span>
                                        <br />
                                        <span class="weui-agree__text span_space">
                                            <%# DataBinder.Eval(Container.DataItem, "Emp_Name") %>
                                        </span>
                                        <span class="weui-agree__text">上料时间：<%# DataBinder.Eval(Container.DataItem, "on_date","{0:MM-dd HH:mm}") %> </span>
                                        <span class="weui-agree__text">下料时间：<%# DataBinder.Eval(Container.DataItem, "off_date","{0:MM-dd HH:mm}") %> </span>
                                        <%--<span class="weui-agree__text">时长:<font class="f-blue"> <%# DataBinder.Eval(Container.DataItem, "times") %></font>--%>
                                        </span>
                                    </div>
                                    <div class="weui-cell__ft">
                                    </div>
                                </a>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>


            </div>
        </div>


        <div class="weui-footer weui-footer_fixed-bottom">
            <p class="weui-footer__text"><%=WeiXin.GetCookie("workcode") +((LoginUser)WeiXin.GetJsonCookie()).UserName %></p>
        </div>

    </form>
</body>
</html>
