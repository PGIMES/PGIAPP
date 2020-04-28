<%@ Page Language="C#" AutoEventWireup="true" CodeFile="prod_wip_detail.aspx.cs" Inherits="prod_wip_detail" %>

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
    </style>
    <script src="../js/zepto.min.js"></script>
    <script src="../js/zepto.weui.js"></script>
    <script src="../js/iscroll-lite.js"></script>
    <script>

        $(function () {
            $('#btn_cancel').click(function () {
                var qty = "<%= Request["wipqty"] %>";
                if (confirm('确认要【退回】【数量' + qty + '】吗？')) {
                    $.ajax({
                        type: "post",
                        url: "prod_wip_detail.aspx/Reject_Sku",
                        data: "{'emp':'" + "<%= _emp %>" + "','needno':'" + "<%= Request["need_no"] %>" + "','lotno':'" + "<%= Request["dh"] %>" + "','reject_qty':'" + qty + "','source':'2'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                        success: function (data) {
                            var obj = eval(data.d);
                            var flag = obj[0].flag;
                            var msg = obj[0].msg;

                            layer.alert(obj[0].msg);
                        }
                    });
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
                            <label class="weui-form-preview__label">Lot No</label>
                            <label class="weui-form-preview__"><% ="<font class='tag'/>"+Request["dh"] %></label>
                        </div>
                    </div>
                    <div class="weui-form-preview__bd">
                        <asp:Repeater runat="server" ID="dtMain">
                            <ItemTemplate>
                                <div class="weui-mark-vip"><span class="weui-mark-lt <%# Request["type"].ToString()=="workorder"?"bg-gray":"bg-yellow"%>"></span></div>

                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">项目号</label>
                                    <span class="weui-form-preview__value"><%# Eval("sku") %></span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">零件号</label>
                                    <span class="weui-form-preview__value"><%# Eval("sku_descr") %> </span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">上料数量</label>
                                    <span class="weui-form-preview__value"><%# Eval("qty") %> </span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">完工数量</label>
                                    <span class="weui-form-preview__value"><%# Eval("off_qty") %> </span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">NG数量</label>
                                    <span class="weui-form-preview__value"><%# Request["ngqty"] %> </span>
                                </div>
                                 <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">在制数量</label>
                                    <span class="weui-form-preview__value"><%# Request["wipqty"] %> </span>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    <div class="weui-form-preview__bd ">
                    </div>
                </div>
                <div class="weui-form-preview">
                    <div class="weui-cells__title ">
                       <%-- <i class="icon nav-icon icon-49"></i>--%>
                        <asp:Label ID="Label1" runat="server" Text='操作明细'></asp:Label>
                    </div>
                    <div class="weui-cells">
                        <asp:Repeater ID="DataList1" runat="server">
                            <ItemTemplate>
                                <a class="weui-cell " href="javascript:void(0)">
                                    <div class="weui-mark-vip"><span class="weui-mark-lt bg-yellow" ></span></div>
                                    <div class="weui-cell__hd">
                                        <i class="fa fa-thermometer-full" aria-hidden="true"></i>
                                    </div>
                                    <div class="weui-cell__bd f-black" style="font-size: smaller">
                                        <span class="span_space ">
                                            <%# DataBinder.Eval(Container.DataItem, "pgino") %>
                                        </span>
                                        <span>
                                            <%# DataBinder.Eval(Container.DataItem, "pn") %>
                                        </span>
                                        <br />
                                        <%--<span class="span_space">完工单号:<%# DataBinder.Eval(Container.DataItem, "workorder_part") %>--%>
                                        </span>
                                        <span class="span_space"><%# DataBinder.Eval(Container.DataItem, "workorder") %></span>
                                        <span class="span_space">数量:<font class="f-blue"><%# DataBinder.Eval(Container.DataItem, "qty") %></font></span>
                                        <span><font class="f-blue"><%# DataBinder.Eval(Container.DataItem, "opdesc") %></font></span>
                                        <br />
                                        <span class="weui-agree__text span_space">
                                            <%# Eval("cellphone")%><%#Eval("Emp_Name") %>
                                        </span>
                                        <span class="weui-agree__text">时间：<%# DataBinder.Eval(Container.DataItem, "off_date","{0:MM-dd HH:mm}") %> </span>
                                        <%--<span class="weui-agree__text">下料时间：<%# DataBinder.Eval(Container.DataItem, "off_date","{0:MM-dd HH:mm}") %> </span>--%>
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

                <div class="weui-cell" >
                    <input id="btn_cancel" type="button" class="weui-btn weui-btn_primary" value="退回" />
                </div>

            </div>
        </div>


        <div class="weui-footer weui-footer_fixed-bottom">
            <p class="weui-footer__text"><%=WeiXin.GetCookie("workcode") +((LoginUser)WeiXin.GetJsonCookie()).UserName %></p>
        </div>

    </form>
</body>
</html>
