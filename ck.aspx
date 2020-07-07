<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ck.aspx.cs" Inherits="ck" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <title>仓库</title>
    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <%--<script src="/js/jquery-3.0.0.min.js"></script>--%>
    <script src="/Content/layer/layer.js"></script>

    <link href="/css/weui.css" rel="stylesheet" />
    <link href="/css/weuix.css" rel="stylesheet" />
    <script src="/js/zepto.min.js"></script>
    <script src="/js/zepto.weui.js"></script>
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

        /*.weui-cells_radio .weui-check:checked+.weui-icon-checked:before{
            color:#09bb07;
        }*/
    </style>
        
    <script type="text/javascript">
        <%-- function getQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = decodeURI(window.location.search).substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
        var workshop = getQueryString("workshop");
        //alert(workshop);--%>

        $(function () {

        });

        function sm_ck_dh() {
            wx.ready(function () {
                wx.scanQRCode({
                    needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                    scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                    success: function (res) {
                        var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                        // code 在这里面写上扫描二维码之后需要做的内容 
                        ck_dh_change(result);

                    }, cancel: function () {
                        $.modal({
                            title: "",
                            text: $("#div_2").html(),
                            buttons: [ ]
                        });
                    }
                });
            });
        }
        function ck_dh_change(result) {
            $.ajax({
                type: "post",
                url: "Cjgl1.aspx/ck_dh_change",
                data: "{'result':'" + result + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    var obj = eval(data.d);
                    var flag = obj[0].flag;
                    var msg = obj[0].msg;

                    if (flag == "Y") {
                        layer.alert(msg);
                        return;
                    }

                    if (msg == "hg") {
                        window.location.href = "/workorder/Ruku_Print.aspx?dh=" + result + "&ck=Y";
                    }
                    else if (msg == "bf") {
                        window.location.href = "/workorder/CKSH.aspx?dh=" + result + "&ck=Y";
                    }
                    else if (msg == "rk") {                        
                        window.location.href = "/workorder/Ruku_hege.aspx?dh=" + result + "&ck=Y";
                    }
                    else if (msg == "bhg") {
                        window.location.href = "/workorder/Ruku_bcp_hege.aspx?dh=" + result + "&ck=Y";
                    }
                }

            });
            
        }
        function sm_ckck_dh() {
            wx.ready(function () {
                wx.scanQRCode({
                    needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                    scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                    success: function (res) {
                        var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                        // code 在这里面写上扫描二维码之后需要做的内容 
                        ckck_dh_change(result);

                    }, cancel: function () {
                        window.location.href = "/workorder/Chuku.aspx?workorder=&ruku_dh=";
                    }
                });
            });
        }
        function ckck_dh_change(result) {
            $.ajax({
                type: "post",
                url: "ck.aspx/ckck_dh_change",
                data: "{'result':'" + result + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    var obj = eval(data.d);
                    var flag = obj[0].flag;
                    var msg = obj[0].msg;
                    var workorder = obj[0].workorder;
                    var ruku_dh = obj[0].ruku_dh;

                    if (flag == "Y") {
                        layer.alert(msg);
                        return;
                    }
                    window.location.href = "/workorder/Chuku.aspx?workorder=" + workorder + "&ruku_dh=" + ruku_dh;
                }

            });

        }
        function sm_ruku_print() {

            $.confirm('确认要补打吗？', function () {
                //点击确认后的回调函数
                wx.ready(function () {
                    wx.scanQRCode({
                        needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                        scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                        success: function (res) {
                            var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                            // code 在这里面写上扫描二维码之后需要做的内容 
                            ruku_print_change(result);

                        }
                    });
                });
            }, function () {
                //点击取消后的回调函数
            });


        }
        function ruku_print_change(result) {
            $.ajax({
                type: "post",
                url: "ck.aspx/ruku_print_change",
                data: "{'result':'" + result + "','emp':'" + $("#emp_code_name").val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    var obj = eval(data.d);
                    var flag = obj[0].flag;
                    var msg = obj[0].msg;

                    layer.alert(msg);
                    return;
                }

            });
        }
    </script>
</head>
<body>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script> 
    <form id="form1" runat="server">

        <asp:TextBox ID="emp_code_name" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="display:none;"></asp:TextBox>

        <div class="page-bd">
            <div class="weui-cells">
                <a class="weui-cell weui-cell_access" href="/workorder/YL_list_ck.aspx">
                    <div class="weui-cell__hd">
                        <i class="fa fa-cubes margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>要料监视</p>
                    </div>
                    <div class="weui-cell__ft">
                        <asp:Label ID="Label1" runat="server" Text="" style="display:none;"></asp:Label>
                        <% string i1 = Label1.Text; Response.Write("<span class='weui-badge  bg-" + (i1 == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>" + i1 + "</span>"); %> 
                    </div>
                </a>
                <a class="weui-cell weui-cell_access" href="javascript:sm_ckck_dh()">
                    <div class="weui-cell__hd">
                        <i class="fa fa-shopping-basket margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>成品出库</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="javascript:sm_ck_dh();"><%--/workorder/CKSH.aspx--%>
                    <div class="weui-cell__hd">
                        <i class="fa fa-random margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>仓库接收</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/workorder/bhgp_Apply_list_ck.aspx">
                    <div class="weui-cell__hd">
                        <i class="fa fa-bookmark-o margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>不合格监视</p>
                    </div>
                    <div class="weui-cell__ft">
                        <asp:Label ID="Label2" runat="server" Text="" style="display:none;"></asp:Label>
                        <% string i2 = Label2.Text; Response.Write("<span class='weui-badge  bg-" + (i2 == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>" + i2 + "</span>"); %> 
                    </div>
                </a>
                <a class="weui-cell weui-cell_access" href="javascript:sm_ruku_print();">
                    <div class="weui-cell__hd">
                        <i class="fa fa-print margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>入库标签补打</p>
                    </div>
                    <div class="weui-cell__ft"></div>
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

    <%--<div id="div_1">
    <div class="weui-cells weui-cells_radio" >
      <label class="weui-cell weui-check__label" for="x11">
        <div class="weui-cell__bd">
          <p>生成入库单</p>
        </div>
        <div class="weui-cell__ft">
          <input type="radio" class="weui-check" name="radio1" id="x11">
          <span class="weui-icon-checked"></span>
        </div>
      </label>
      <label class="weui-cell weui-check__label" for="x12">
        <div class="weui-cell__bd">
          <p>合格品入库</p>
        </div>
        <div class="weui-cell__ft">
          <input type="radio" class="weui-check" name="radio1" id="x12" checked="checked">
          <span class="weui-icon-checked"></span>
        </div>
      </label>
      <label class="weui-cell weui-check__label" for="x13">
        <div class="weui-cell__bd">
          <p>废品接收</p>
        </div>
        <div class="weui-cell__ft">
          <input type="radio" class="weui-check" name="radio1" id="x13" checked="checked">
          <span class="weui-icon-checked"></span>
        </div>
      </label>
     
    </div>
    </div>--%>

    <div id="div_2" style="display:none;">
        <div class="weui-cells">
          <a class="weui-cell weui-cell_access" href="/workorder/Ruku_Print.aspx?dh=&ck=Y">
            <div class="weui-cell__bd">
              <p>生成入库单</p>
            </div>
            <div class="weui-cell__ft">
            </div>
          </a>
          <a class="weui-cell weui-cell_access" href="/workorder/Ruku_hege.aspx?dh=&ck=Y">
            <div class="weui-cell__bd">
              <p>合格品入库</p>
            </div>
            <div class="weui-cell__ft">
            </div>
          </a>
          <a class="weui-cell weui-cell_access" href="/workorder/CKSH.aspx?dh=&ck=Y">
            <div class="weui-cell__bd">
              <p>废品接收</p>
            </div>
            <div class="weui-cell__ft">
            </div>
          </a>
          <a class="weui-cell weui-cell_access" href="/workorder/Ruku_bcp_hege.aspx?dh=&ck=Y">
            <div class="weui-cell__bd">
              <p>半成品入库</p>
            </div>
            <div class="weui-cell__ft">
            </div>
          </a>
        </div>
    </div>

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
    </script>
</html>
