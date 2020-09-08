<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SB.aspx.cs" Inherits="SB" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <title>设备</title>

    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <%--<script src="/js/jquery-3.0.0.min.js"></script>--%>
    <script src="/Content/layer/layer.js"></script>

    <link href="/css/weui.css" rel="stylesheet" />
    <link href="/css/weuix.css" rel="stylesheet" />    
    <script src="/js/zepto.min.js"></script>
    <script src="/js/zepto.weui.js"></script>
    <script src="/js/cjgl.js?ver=20200709001"></script>
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
        i{ color:#03a9f4}
        .bg-orange{background-color:orange}
    </style>

    <script type="text/javascript">
        $(function () {
            
           show_prod();
           show_bhg();
            
                 
        });
                
    </script>
</head>
<body>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script> 
    <form id="form1" runat="server">
        
        <asp:TextBox ID="emp_code_name" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="display:none;"></asp:TextBox>

        <div class="page-bd">

            <div class="weui-cells">
                <a class="weui-cell weui-cell_access" href="/workorder/Emp_Login.aspx?workshop=设备">
                    <div class="weui-cell__hd">
                        <i class="fa fa-user-circle-o margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>上岗<span style="font-size:smaller">(调整中)</span></p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>                
                <a class="weui-cell weui-cell_access" href="https://open.weixin.qq.com/connect/oauth2/authorize?appid=ww3912fa18e2d1ff24&redirect_uri=http%3A%2F%2Fapi.pgi.cn%2FwechatRepairPower%2Frepair&response_type=code&scope=snsapi_base&agentid=1000003&state=1#wechat_redirect">   
                    <div class="weui-cell__hd">
                        <i class="fa fa-wrench margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>API报修</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>   
                <a class="weui-cell weui-cell_access" href="/workorder/Emp_Login_list_new.aspx?workshop=设备">
                    <div class="weui-cell__hd">
                        <i class="fa fa-group margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>上岗监视<span style="font-size:smaller">(调整中)</span></p>
                    </div>
                    <div class="weui-cell__ft">
                        <asp:Label ID="Label1_j" runat="server" Text="" style="display:none;"></asp:Label>
                        <%--<% string i1_j = Label1_j.Text;
                            Response.Write("<span class='weui-badge' style='background-color:" + (i1_j == "0" ? "lightgray" : "orange") + ";color: white;margin-right: 15px;'>质" + i1_j + "</span>"); %> --%>
                    </div>
                </a>             
                <a class="weui-cell weui-cell_access" href="https://open.weixin.qq.com/connect/oauth2/authorize?appid=ww3912fa18e2d1ff24&redirect_uri=http%3A%2F%2Fapi.pgi.cn%2FwechatRepairPower%2Flist&response_type=code&scope=snsapi_base&state=1#wechat_redirect">
                    <div class="weui-cell__hd">
                        <i class="fa fa-gears margin10-r"></i>
                    </div>

                    <div class="weui-cell__bd">
                        <p>故障监视</p>
                    </div>
                    <div class="weui-cell__ft">                                                
                       <%-- <span class="weui-badge bg-blue" id="wip" style='margin-right: 15px;'>..</span>
                        <span class="weui-badge bg-blue" id="sh" style='margin-right: 15px;'>..</span>
                        <span class="weui-badge bg-orange" id="part"  style='margin-right: 15px;'>部..</span>
                        <span class="weui-badge bg-red" id="ng" style='margin-right: 15px;'>返..</span>   --%>                  
                    </div>
                </a> 
                <a class="weui-cell weui-cell_access" href="/moju/SB_WXSC_APP.aspx" >
                    <div class="weui-cell__hd">
                        <i class="fa fa-bar-chart-o margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>故障统计</p>
                    </div>
                    <div class="weui-cell__ft">                       
                    </div>
                </a>  
                <% if (WeiXin.GetCookie("workcode") == "01968" ||WeiXin.GetCookie("workcode") == "02069"){%> 
                <a class="weui-cell weui-cell_access " href="https://open.weixin.qq.com/connect/oauth2/authorize?appid=ww3912fa18e2d1ff24&redirect_uri=http%3A%2F%2Fmes.pgi.cn%2Fmoju%2Fapichangeuser.aspx&response_type=code&scope=snsapi_base&agentid=1000010&state=1#wechat_redirect">
                    <div class="weui-cell__hd">
                        <i class="fa fa-group margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>更换代理人<font style="font-size:smaller">(IT调试)</font></p>
                    </div>
                    <div class="weui-cell__ft">                                                 
                    </div>
                </a> 
                <%} %>
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
    <script>
        var datad = [];
        $.ajax({
            url: "/getwxconfig.aspx/GetScanQRCode",
            type: "Post",
            data: "{ 'url': '" + location.href + "' }",
            async: false,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                datad = JSON.parse(data.d); //转为Json字符串
            },
            error: function (error) {
                alert(error);
            }
        });
        wx.config({
            debug: false, // 开启调试模式
            appId: datad.appid, // 必填，公众号的唯一标识
            timestamp: datad.timestamp, // 必填，生成签名的时间戳
            nonceStr: datad.noncestr, // 必填，生成签名的随机串
            signature: datad.signature,// 必填，签名，见附录1
            jsApiList: ["scanQRCode"] // 必填，需要使用的JS接口列表
        });

        //show workshop 2,3,4 product data
        function show_prod(){
            $.ajax({
                url: "/zl.aspx/ProdList_Data",
                type: "Post",
                data: "{ 'workshop': '' }",
                async: true,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    datad = JSON.parse(data.d); //转为Json字符串
                    if(datad.length>0){
                        $("#wip").text(datad[0].wip);
                        $("#sh").text(datad[0].sh);
                        $("#part").text('部'+datad[0].part);
                        $("#ng").text('返' + datad[0].ng);
                        if (datad[0].ng == 0) { $("#ng").addClass("bg-gray") }
                        if (datad[0].sh == 0) { $("#sh").addClass("bg-gray") }
                        if (datad[0].part == 0) { $("#part").addClass("bg-gray") }
                        if (datad[0].wip == 0) { $("#wip").addClass("bg-gray") }
                    }

                }//,
                //error: function (error) {
                //    alert(error);
                //}
            });
        }


        function show_bhg() {
            $.ajax({
                url: "/ZL.aspx/bhg_Data",
                type: "Post",
                data: "{ }",
                async: true,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    datad = JSON.parse(data.d); //转为Json字符串
                    if (datad.length > 0) {
                        $("#bhg_go").text(datad[0].go);
                        $("#bhg_end").text(datad[0].end);
                        $("#bhg_fg").text('返' + datad[0].fg);
                        if (datad[0].go == 0) { $("#bhg_go").removeClass("bg-blue").addClass("bg-gray"); }
                        if (datad[0].end == 0) { $("#bhg_end").removeClass("bg-blue").addClass("bg-gray"); }
                        if (datad[0].go_bhg == 0) { $("#bhg_fg").removeClass("bg-red").addClass("bg-gray"); }
                    }

                }//,
                //error: function (error) {
                //    alert(error);
                //}
            });
        }
    </script>
</html>
