<%@ Page Language="C#" AutoEventWireup="true" CodeFile="workshop.aspx.cs" Inherits="workshop" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<title>生产管理</title>
    <link href="/css/weui.css" rel="stylesheet" />
    <link href="/css/weuix.css" rel="stylesheet" />
    <script src="/js/jquery-3.0.0.min.js"></script>
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
    </style>
      <script type="text/javascript">        

        $(function () {
             


        });
        function show() {
            dh = $("#dj").val();
            if (dh == "") {
               // alert("请输入或扫描单据号(不含R字头).");
                $.alert("请输入或扫描单据号(不含R字头).","提示",function(){
                    return ;
                });
                return false;
            }
            window.location.href = "/workorder/trace_bycode.aspx?dh="+dh;
            //$.ajax({
            //    url: "/workshop.aspx/TraceByDH",
            //    type: "Post",
            //    data: "{ 'dh': '" + dh + "' }",
            //    async: false,
            //    contentType: "application/json; charset=utf-8",
            //    dataType: "json",
            //    success: function (data) {
            //        datad = JSON.parse(data.d); //转为Json字符串
            //        if (datad.length>0)
            //        {
            //            //alert(datad[0].href)
            //            if (datad[0].href != "")
            //            { window.location.href = datad[0].href; }
            //            else {
            //                alert("未发现【" + dh + "】对应的记录.");
            //            }
            //        }
            //    },
            //    error: function (error) {
            //        alert(error);
            //    }
            //});
        }
        
    </script>
</head>
<body>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <form id="form1" runat="server">
        <div class="page-bd">
            <div class="weui-cells">
                 
                <a class="weui-cell weui-cell_access" href="/Cjgl1.aspx?workshop=二车间">
                    <div class="weui-cell__hd">
                        <i class="fa fa-gears margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>二车间</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/Cjgl1.aspx?workshop=三车间">
                    <div class="weui-cell__hd">
                        <i class="fa fa-hourglass-half margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>三车间</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/Cjgl1.aspx?workshop=四车间">
                    <div class="weui-cell__hd">
                        <i class="fa fa-cog margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>四车间</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/ck.aspx">
                    <div class="weui-cell__hd">
                        <i class="fa fa-home margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>仓库</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/ZL.aspx">
                    <div class="weui-cell__hd">
                        <i class="fa fa-quora margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>质量</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/SB.aspx">
                    <div class="weui-cell__hd">
                        <i class="fa fa-medium margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>设备<font style="font-size:smaller">(调整中)</font></p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/Moju/mjindex.aspx">
                    <div class="weui-cell__hd">
                        <i class="fa fa-puzzle-piece margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>模具<font style="font-size:smaller">(调整中)</font></p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/Adjust_Apply.aspx">
                    <div class="weui-cell__hd">
                        <i class="fa fa-adjust margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>盘盈亏</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/Adjust_list.aspx">
                    <div class="weui-cell__hd">
                        <i class="fa fa-television margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>盘盈亏监视</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <div class="weui-cell weui-cell_access-">
                    <div class="weui-cell__hd">
                        <i class="fa fa-search margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <%--<p>单据查询<span class="f12">（未开放）</span></p>--%>
                        <span style="float:left; width:55%">
                            <asp:TextBox ID="dj" class="weui-input" style="border-bottom:1px solid #e5e5e5; "  placeholder="请输入单据" runat="server"></asp:TextBox>
                        </span>
                        <span style="float:left; width:10%;"   onclick="scan_DJ()">
                            <img id="img_sm" src="../img/fdj2.png" style="padding-top:10px;" />
                        </span>
                        <span style="float:left; width:35%; text-align:right;">
                            <a id="btnGo" class="  weui-btn-area"  onclick="show();" > 查询 </a>
                            <span class="f11" style="font-size:6px;"></span>
                        </span>
                    </div>
                    <%--<div class="weui-cell__ft"></div>--%>
                </div>
            </div>
        </div>
        <div id="err--msg"class="f14"></div>  
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
        //扫描
        function scan_DJ() {
            wx.ready(function () {
                wx.scanQRCode({
                    needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                    scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                    success: function (res) {
                        var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                        // code 在这里面写上扫描二维码之后需要做的内容 
                        $("#dj").val(result);
                        show();
                    }
                    //, cancel: function () {
                    //    window.location.href = "/workorder/Load_Material.aspx?lotno=&need_no=&workshop=" + _workshop + "&para=";
                    //}
                });
            });
        }
    </script>
</html>
