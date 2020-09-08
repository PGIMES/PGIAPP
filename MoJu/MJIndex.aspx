<%@ Page Language="C#" Title="模修监视" AutoEventWireup="true" CodeFile="MJIndex.aspx.cs" Inherits="MJIndex" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="../css/weui.css" rel="stylesheet" />
    <link href="../css/weuix.css" rel="stylesheet" />
    <script src="../js/jquery-3.0.0.min.js"></script>
    <link href="/css/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" />
    <style>
        .weui-cells {
            margin-top: 0px;
            line-height: 2.5;
        }
        .weui-cell:before {
            left: 0px;
                     
        }
        .weui-cell{
            padding:10px 20px;  
        }
        i{ color:orangered}
    </style>
    
    <script>
        $(document).ready(function () {
            //$.ajax({
            //    type: "post",
            //    url: "Dbsx.aspx/init",
            //    data: "{}",
            //    contentType: "application/json; charset=utf-8",
            //    dataType: "json",
            //    async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
            //    success: function (data) {
            //        var obj = eval(data.d);
            //        var appp_ng = obj[0].appp_ng;//不合格品处置数量
            //        $("#span_ng").text("不合格品处置(" + appp_ng + ")");

            //        //layer.alert(obj[0].re_flag, function (index) { location.reload(); })
            //        return;
            //    }

            //});
            //$(document).append

        });
         //WeiXin.GetCookie("workcode") +((LoginUser)WeiXin.GetJsonCookie()).UserName

    </script>
     
</head>
<body>
    <form id="form1" runat="server">         
        <div class="page-bd">
            <div class="weui-cells">
                <a class="weui-cell weui-cell_access" href="/workorder/Emp_Login.aspx?workshop=模修">
                    <div class="weui-cell__hd">
                        <i class="fa fa-user-circle-o margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>上岗<span style="font-size:smaller">(调整中)</span></p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/MoJu/Mj_use_apply.aspx">
                    <div class="weui-cell__hd">
                        <i class="fa fa-edit margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>上模申请</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/MoJu/MoJu_BX_APP.aspx">
                    <div class="weui-cell__hd">
                        <i class="fa fa-wrench margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>模具报修</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/workorder/Emp_Login_list_new.aspx?workshop=模修">
                    <div class="weui-cell__hd">
                        <i class="fa fa-group margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>上岗监视<span style="font-size:smaller">(调整中)</span></p>
                    </div>
                    <div class="weui-cell__ft">
                        <asp:Label ID="Label1" runat="server" Text="" style="display:none;"></asp:Label>
                        <% string i1 = Label1.Text; 
                            Response.Write("<span class='weui-badge  bg-" + (i1 == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>设" + i1 + "</span>");
                                %>
                    </div>
                </a>
                <a class="weui-cell weui-cell_access" href="/MoJu/Mj_use_list.aspx">
                    <div class="weui-cell__hd">
                        <i class="fa fa-life-bouy margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>上模监视</p>
                    </div>
                    <div class="weui-cell__ft"><% string i = MJIndex.getSMCount(); Response.Write("<span class='weui-badge  bg-"+(i=="0"?"gray":"red")+"' style='margin-right: 15px;'>"+i+"</span>"); %></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/MoJu/BXMonitor.aspx">
                    <div class="weui-cell__hd">
                        <i class="fa fa-tasks margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>模修监视</p>
                    </div>
                    <div class="weui-cell__ft"><% string j = MJIndex.getMoXiuCount(); Response.Write("<span class='weui-badge  bg-"+(j=="0"?"gray":"red")+"' style='margin-right: 15px;'>"+j+"</span>"); %></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/MoJu/MJ_WXSC_APP.aspx">
                    <div class="weui-cell__hd"><i class="fa fa-bar-chart-o margin10-r"></i></div>
                    <div class="weui-cell__bd">
                        <p>模修统计</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/MoJu/MJ_maintaince_list.aspx">
                    <div class="weui-cell__hd">
                        <i class="fa fa-desktop margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>保养监视</p>
                    </div>
                    <div class="weui-cell__ft"><% string k = MJIndex.getBYCount(); Response.Write("<span class='weui-badge  bg-"+(k=="0"?"gray":"red")+"' style='margin-right: 15px;'>"+k+"</span>"); %></div>
                </a>
            </div>
        </div>
        <div id="errmsg"class="f14"></div>  
        <div class="weui-footer weui-footer_fixed-bottom">
            <p class="weui-footer__text">
                <% =WeiXin.GetCookie("workcode")==""?"获取信息失败":WeiXin.GetCookie("workcode") +((LoginUser)WeiXin.GetJsonCookie()).UserName %>
            </p>
        </div>
    </form>
</body>
</html>
