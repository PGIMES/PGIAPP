<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Ruku_hege.aspx.cs" Inherits="WorkOrder_Ruku_hege" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>合格品入库</title>
    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <script src="/Content/layer/layer.js"></script>

    <link href="../css/weui.css" rel="stylesheet" />
    <link href="../css/weuix.css" rel="stylesheet" />
    <script src="../js/zepto.min.js"></script>
    <script src="../js/zepto.weui.js"></script>

    <script>
        $(document).ready(function () {
            $("#dh").attr("readonly", "readonly");
            $("#status_hg").attr("readonly", "readonly");
            $("#status_date_hg").attr("readonly", "readonly");
            $("#domain").attr("readonly", "readonly");
            $("#pgino").attr("readonly", "readonly");
            $("#pn").attr("readonly", "readonly");
            $("#qty").attr("readonly", "readonly");
            $("#ac_qty").attr("readonly", "readonly");

            if ("<%= _dh %>" != "") {//仓库接收 扫码进来
                $('#dh').val("<%= _dh %>");
                dh_change();
            }
        });

        function dh_change() {
            $("#domain").val('');
            $("#pgino").val('');
            $("#pn").val('');
            $('#qty').val('');
            $('#act_qty').val('');

            $.ajax({
                type: "post",
                url: "Ruku_hege.aspx/dh_change",
                data: "{'dh':'" + $('#dh').val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    var obj = eval(data.d);

                    if (obj[0].flag == "Y") {
                        layer.alert(obj[0].msg);
                        return;
                    }
                    $("#sp_workorder").text(obj[0].workorder); $("#workorder").val(obj[0].workorder);
                    $("#sp_domain").text(obj[0].domain);
                    $("#sp_pgino").text(obj[0].pgino);
                    $("#sp_pn").text(obj[0].pn);
                    $('#sp_qty').text(obj[0].qty);
                    $('#sp_act_qty').text(obj[0].qty);
                    $('#sp_phone').text(obj[0].phone);
                    $('#sp_create_date').text(obj[0].create_date);
                    $('#status_hg').val(obj[0].status_hg);
                    $('#status_date_hg').val(obj[0].status_date_hg);
                }

            });
        }


        $(function () {
            sm_workorder();
            sm_loc_hg();
        });

        function sm_workorder() {
            $('#img_sm_workorder').click(function () {
                wx.ready(function () {
                    wx.scanQRCode({
                        needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                        scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                        success: function (res) {
                            var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                            // code 在这里面写上扫描二维码之后需要做的内容  
                            $('#workorder').val(result);
                            workorder_change();
                        }
                    });
                });
            });
        }

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

        function workorder_change() {
            if ($.trim($("#workorder").val()) != "") {
                if ($.trim($("#workorder").val()) != $("#sp_workorder").text()) {
                    layer.alert("【来源单号】不正确.");
                    return;
                }

                //更新状态为 已确认
                $.ajax({
                    type: "post",
                    url: "Ruku_hege.aspx/dh_status",
                    data: "{'dh':'" + $('#dh').val() + "','workorder':'" + $('#workorder').val() + "','emp_code_name':'" + $('#emp_code_name').val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                    success: function (data) {
                        var obj = eval(data.d);

                        if (obj[0].flag == "Y") {
                            layer.alert(obj[0].msg);
                            return;
                        }
                        $('#status_hg').val(obj[0].status_hg);
                        $('#status_date_hg').val(obj[0].status_date_hg);
                    }

                });


            }
        }

        function valid() {
            if ($.trim($("#workorder").val()) == "") {
                layer.alert("请输入【来源单号】.");
                return false;
            }
            if ($.trim($("#status_hg").val()) != "已确认") {
                layer.alert("【来源单号】状态不是已确认，不可打印.");
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
                    <div class="weui-cell__hd f-red "><label class="weui-label">入库单号</label></div>
                    <asp:TextBox ID="dh" class="weui-input" style="color:gray" runat="server"></asp:TextBox>                
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd f-red "><label class="weui-label">来源单号</label></div> 
                    <div class="weui-cell__bd">
                        <span style="float:left; width:90%">
                            <asp:TextBox ID="workorder" class="weui-input" placeholder="请输入来源单号" runat="server" onkeyup="this.value=this.value.toUpperCase()" onchange="workorder_change()"></asp:TextBox>
                            <span id="sp_workorder" style="display:none;"></span>
                        </span>
                        <span style="float:left; width:10%">
                            <img id="img_sm_workorder" src="../img/fdj2.png"/>
                        </span>
                    </div>              
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd f-red "><label class="weui-label">状态</label></div>
                    <div class="weui-cell__bd">
                        <span style="float:left; width:30%">
                            <asp:TextBox ID="status_hg" class="weui-input" style="color:gray" runat="server"></asp:TextBox>        
                        </span>
                        <span style="float:left; width:70%">
                            <asp:TextBox ID="status_date_hg" class="weui-input" style="color:gray" runat="server"></asp:TextBox>        
                        </span>
                    </div>
                            
                </div>
                <div class="weui-form-preview">
                    <div class="weui-form-preview__bd">
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">物料号</label>
                            <span class="weui-form-preview__value" id="sp_pgino"></span>
                            <span class="weui-form-preview__value" id="sp_domain" style="display:none;"></span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">零件号</label>
                            <span class="weui-form-preview__value" id="sp_pn"></span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">交付数量</label>
                            <span class="weui-form-preview__value" id="sp_qty"></span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">接收数量</label>
                            <span class="weui-form-preview__value" id="sp_act_qty"></span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">生成人</label>
                            <span class="weui-form-preview__value" id="sp_phone"></span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">生成时间</label>
                            <span class="weui-form-preview__value" id="sp_create_date"></span>
                        </div>
                    </div>
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
            sm_workorder();
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
