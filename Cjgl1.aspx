<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Cjgl1.aspx.cs" Inherits="Cjgl1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <title><%=_workshop %></title>

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
            //if ($("#emp_code_name").val() == "01968孙娟" || $("#emp_code_name").val() == "02274李晓根") {
            //    $("#sc_div").show();
            //} else {
            //    $("#sc_div").hide(); 
            //}
        });

        function sm_product_off() {
            wx.ready(function () {
                wx.scanQRCode({
                    needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                    scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                    success: function (res) {
                        var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                        // code 在这里面写上扫描二维码之后需要做的内容 
                          var bj = result.toUpperCase().substring(0, 1).toUpperCase();
                        if ((bj != "W" && bj != "G") || result.length < 8) {
                            alert("完成单号不正确，请重新扫描");

                        }
                        else {
                            window.location.href = "/workorder/Off_Material.aspx?dh=" + result + "&workshop=<%=_workshop %>";
                        }

                    }
                });
            });
        };

          function sm_qc_off() {
            wx.ready(function () {
                wx.scanQRCode({
                    needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                    scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                    success: function (res) {
                        var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                        // code 在这里面写上扫描二维码之后需要做的内容 
                          var bj = result.toUpperCase().substring(0, 1).toUpperCase();
                        if ((bj != "W" && bj != "G") || result.length < 8) {
                            alert("完成单号不正确，请重新扫描");

                        }
                        else {
                            window.location.href = "/workorder/Quantity_Checked.aspx?dh=" + result + "&workshop=<%=_workshop %>";
                        }

                    }
                });
            });
        };

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
                        window.location.href = "/workorder/CKSH.aspx?dh=&workshop=<%=_workshop %>" + "&ck=N";
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
                        window.location.href = "/workorder/Ruku_Print.aspx?dh=" + result + "&workshop=<%=_workshop %>" + "&ck=N";
                    }
                    else if (msg == "bf") {
                        window.location.href = "/workorder/CKSH.aspx?dh=" + result + "&workshop=<%=_workshop %>" + "&ck=N";
                    }
                    else if (msg == "rk") {                        
                        window.location.href = "/workorder/Ruku_hege.aspx?dh=" + result + "&workshop=<%=_workshop %>" + "&ck=N";
                    }
                }

            });
            
        }

        function sm_workorder() {
            wx.ready(function () {
                wx.scanQRCode({
                    needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                    scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                    success: function (res) {
                        var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                        // code 在这里面写上扫描二维码之后需要做的内容 
                         workorder_change(result);

                    }
                });
            });

            //workorder_change("Q0001208");
        };

        function workorder_change(result) {
            $.ajax({
                type: "post",
                url: "Cjgl1.aspx/workorder_change",
                data: "{'result':'" + result + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    var obj = eval(data.d);
                    var json_wk = obj[0].json_wk;

                    var workorder = "";
                    var workorder_f = "";
                    var cur_sign_step = "";
                    if (json_wk.length == 0) {

                        workorder = result;
                        window.location.href = "/workorder/bhgp_Apply_V1.aspx?workorder=" + workorder + "&workorder_f=" + workorder_f
                            + "&workshop=<%=_workshop %>";

                    } else if (json_wk.length == 1) {

                        workorder = json_wk[0]["workorder"];
                        workorder_f = json_wk[0]["workorder_f"];
                        cur_sign_step = json_wk[0]["cur_sign_step"];
                        if (cur_sign_step == "0001" || cur_sign_step == "0003" || cur_sign_step == "0004" || cur_sign_step == "0005") {//当前签核步骤在 返工，且只有一笔
                            window.location.href = "/workorder/bhgp_sign_V1.aspx?stepid=" + cur_sign_step + "&workorder=" + workorder + "&workorder_f=" + workorder_f + "&workshop=<%=_workshop %>";
                        } else {
                            window.location.href = "/workorder/bhgp_Apply_V1.aspx?workorder=" + workorder + "&workorder_f=" + workorder_f
                            + "&workshop=<%=_workshop %>";
                        }
                        
                    } else {

                        workorder = json_wk[0]["workorder"];
                        window.location.href = "/workorder/bhgp_Apply_wk_V1.aspx?workorder=" + workorder
                            + "&workshop=<%=_workshop %>";

                    }

                   
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
                <a class="weui-cell weui-cell_access" href="/workorder/Emp_Login.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-user-circle-o margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>上岗</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/workorder/Emp_Login_list_new.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-group margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>上岗监视</p>
                    </div>
                    <div class="weui-cell__ft">
                        <asp:Label ID="Label1" runat="server" Text="" style="display:none;"></asp:Label>
                        <% string i1 = Label1.Text; Response.Write("<span class='weui-badge  bg-" + (i1 == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>" + i1 + "</span>"); %>   
                    </div>
                </a>
                <a class="weui-cell weui-cell_access" href="/workorder/YL.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-cube margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>要料</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/workorder/YL_list_new.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-cubes margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>要料监视</p>
                    </div>
                    <div class="weui-cell__ft">
                        <asp:Label ID="Label2" runat="server" Text="" style="display:none;"></asp:Label>
                        <% string i2 = Label2.Text; Response.Write("<span class='weui-badge  bg-" + (i2 == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>" + i2 + "</span>"); %>   
                    </div>
                </a>                
                <%--<a class="weui-cell weui-cell_access" href="/workorder/bhgp_Apply.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-edit margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>不合格申请</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/workorder/bhgp_Apply_list.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-bookmark-o margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>不合格监视</p>
                    </div>
                    <div class="weui-cell__ft">
                        <asp:Label ID="Label3" runat="server" Text="" style="display:none;"></asp:Label>
                        <% string i3 = Label3.Text; Response.Write("<span class='weui-badge  bg-" + (i3 == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>" + i3 + "</span>"); %>   
                    </div>
                </a>--%>
                <a class="weui-cell weui-cell_access"  href="javascript:sm_workorder();"   id="a_div">
                    <div class="weui-cell__hd">
                        <i class="fa fa-edit margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>不合格处理</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/workorder/bhgp_Apply_list_V1.aspx?workshop=<%=_workshop %>" id="a_div2">
                    <div class="weui-cell__hd">
                        <i class="fa fa-bookmark-o margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>不合格监视</p>
                    </div>
                    <div class="weui-cell__ft">
                        <asp:Label ID="Label3_V1" runat="server" Text="" style="display:none;"></asp:Label>
                        <% string i3_V1 = Label3_V1.Text; Response.Write("<span class='weui-badge  bg-" + (i3_V1 == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>" + i3_V1 + "</span>"); %>   
                    </div>
                </a>
                <a class="weui-cell weui-cell_access"  href="javascript:sm_product_off();">  <%-- href="javascript:sm_product_off();" --%>
                    <div class="weui-cell__hd">
                        <i class="fa fa-check-square-o margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>生产完成</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="javascript:sm_qc_off();">   
                    <div class="weui-cell__hd">
                        <i class="fa fa-wpexplorer margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>检验完成</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <%--<a class="weui-cell weui-cell_access" href="/workorder/CKSH.aspx?workshop=<%=_workshop %>">--%>         
                <a class="weui-cell weui-cell_access" href="javascript:sm_ck_dh();">
                    <div class="weui-cell__hd">
                        <i class="fa fa-random margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>仓库接收</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/workorder/prod_wip_list.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-gears margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>生产监视</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>   
                <a class="weui-cell weui-cell_access" href="/workorder/prod_end_list.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-list-alt margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>生产完成监视<span class="f12">（临时）</span></p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/workorder/prod_qc_list.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-reorder margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>终检完成监视<span class="f12">（临时）</span></p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <%--<a class="weui-cell weui-cell_access" href="javascript:void(0);">
                    <div class="weui-cell__hd">
                        <i class="fa fa-bar-chart margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>报表查看<span class="f12">（未开放）</span></p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>--%>
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
    </script>
</html>
