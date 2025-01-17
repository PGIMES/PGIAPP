﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Ruku_bcp_hege.aspx.cs" Inherits="WorkOrder_Ruku_bcp_hege" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>半成品入库</title>
    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <script src="/Content/layer/layer.js"></script>

    <link href="../css/weui.css" rel="stylesheet" />
    <link href="../css/weuix.css" rel="stylesheet" />
    <script src="../js/zepto.min.js"></script>
    <script src="../js/zepto.weui.js"></script>

    <script>
        $(document).ready(function () {
            $("#workorder").attr("readonly", "readonly");
            $("#domain").attr("readonly", "readonly");
            $("#pgino").attr("readonly", "readonly");
            $("#pn").attr("readonly", "readonly");
            $("#qty").attr("readonly", "readonly");

            if ("<%= _dh %>" != "") {//仓库接收 扫码进来
                $('#workorder').val("<%= _dh %>");
                workorder_change();
            }
        });

        function workorder_change() {
            $("#domain").val('');
            $("#pgino").val('');
            $("#pn").val('');
            $('#qty').val('');
            $('#act_qty').val('');

            $.ajax({
                type: "post",
                url: "Ruku_bcp_hege.aspx/workorder_change",
                data: "{'workorder':'" + $('#workorder').val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    var obj = eval(data.d);

                    if (obj[0].flag == "Y") {
                        layer.alert(obj[0].msg);
                    }
                    $("#domain").val(obj[0].domain);
                    $("#pgino").val(obj[0].pgino);
                    $("#pn").val(obj[0].pn);
                    $('#qty').val(obj[0].qty);
                    $('#act_qty').val(obj[0].qty);
                }

            });
        }


        $(function () {
            sm_loc_hg();
        });

        function sm_loc_hg() {
            $('#img_sm_loc_hg').click(function () {
                wx.ready(function () {
                    wx.scanQRCode({
                        needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                        scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                        success: function (res) {
                            var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                            // code 在这里面写上扫描二维码之后需要做的内容  
                            $('#loc_hg').val(result);
                        }
                    });
                });
            });
        }

        function valid() {
            if ($("#workorder").val() == "") {
                layer.alert("请输入【单号】.");
                return false;
            }
            if ($.trim($("#qty").val()) == "" || $.trim($("#qty").val()) == "0") {
                layer.alert("请输入【数量】.");
                return false;
            }
            if ($.trim($("#act_qty").val()) == "" || $.trim($("#act_qty").val()) == "0") {
                layer.alert("请输入【接收数量】.");
                return false;
            }
            if (parseFloat($("#act_qty").val()) > parseFloat($("#qty").val())) {
                layer.alert("【接收数量】不可大于【数量】.");
                return false;
            }
            if ($.trim($("#loc_hg").val()) == "") {
                layer.alert("请输入【库位】.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>  
    <form id="form1" runat="server">
    <asp:ScriptManager runat="server">
    </asp:ScriptManager>
    <div class="weui-cells weui-cells_form">
        
        <asp:TextBox ID="emp_code_name" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="display:none;"></asp:TextBox>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="weui-cell">
                    <div class="weui-cell__hd f-red "><label class="weui-label">单号</label></div>
                    <asp:TextBox ID="workorder" class="weui-input" style="color:gray" runat="server"></asp:TextBox>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">物料号</label></div>              
                    <asp:TextBox ID="pgino" class="weui-input" style="color:gray" runat="server"></asp:TextBox>
                    <asp:TextBox ID="domain" class="weui-input" style="color:gray;display:none;" runat="server"></asp:TextBox>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">零件号</label></div>                          
                    <asp:TextBox ID="pn" class="weui-input" style="color:gray" runat="server"></asp:TextBox>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">数量</label></div>
                    <asp:TextBox ID="qty" class="weui-input"  placeholder="" style="color:gray" runat="server"></asp:TextBox>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd f-red "><label class="weui-label">接收数量</label></div>
                    <asp:TextBox ID="act_qty" class="weui-input" type='number' placeholder="请输入接收数量" runat="server" step="0.0001"></asp:TextBox>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">说明</label></div>
                    <textarea id="Textarea1" class="weui-textarea"  placeholder="请输入说明" rows="3"  runat="server"></textarea>
                </div>      
                <div class="weui-cell">
                    <div class="weui-cell__hd f-red "><label class="weui-label">库位</label></div> 
                    <div class="weui-cell__bd">
                        <span style="float:left; width:90%">
                            <asp:TextBox ID="loc_hg" class="weui-input" placeholder="请输入库位" runat="server"></asp:TextBox>      
                        </span>
                        <span style="float:left; width:10%">
                            <img id="img_sm_loc_hg" src="../img/fdj2.png"/>
                        </span>
                    </div>      
                      
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">说明</label></div>
                    <textarea id="comment" class="weui-textarea"  placeholder="请输入说明" rows="3"  runat="server"></textarea>
                </div>
                <div class="weui-cell">
                    <asp:Button ID="btnsave" class="weui-btn weui-btn_primary" runat="server" 
                        Text="入库" OnClick="btnsave_Click" OnClientClick="return valid();" />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    </form>
</body>
    <script>
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            sm_loc_hg();
        });

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
                alert(error)
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
