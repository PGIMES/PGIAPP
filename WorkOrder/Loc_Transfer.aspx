<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Loc_Transfer.aspx.cs" Inherits="WorkOrder_Loc_Transfer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>库位转移</title>
    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <script src="/Content/layer/layer.js"></script>
    <link href="/css/weui.css" rel="stylesheet" />
    <link href="/css/weuix.css" rel="stylesheet" />
    <script src="/js/zepto.min.js"></script>
    <script src="/js/zepto.weui.js"></script>

    <style>
        .weui-cell{
            padding:4px 15px; 
        }
        .weui-label{
            width:85px;
        }
    </style>

    <script>
        $(document).ready(function () {
            //$("#txt_ljh").attr("readonly", "readonly"); 
        });

        $(function () {
            $("#txt_xmh_rs").change(function () {
                $("#txt_xmh").val($("#txt_xmh_rs").val());
                pgino_change();
            });
            $("#txt_ref").change(function () {
                pgino_change();
            });
            $("#txt_loc").change(function () {
                pgino_change();
            });
            $("#txt_loc_to").change(function () {
                loc_to_change();
            });
            sm_ref(); sm_loc();
            sm_ref_to(); sm_loc_to();

            $("#btnsave").click(function () {              
                $("#btnsave").attr("disabled", "disabled");
                $("#btnsave").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');

                if (!valid()) {
                    $("#btnsave").removeAttr("disabled");
                    $("#btnsave").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                    return false;
                }

                $.ajax({
                    type: "post",
                    url: "Loc_Transfer.aspx/save",
                    data: "{'_emp_code_name':'" + $('#emp_code_name').val() + "','domain': '" + $("#domain").val()
                        + "','pgino':'" + $("#txt_xmh").val() + "','_ref':'" + $("#txt_ref").val() + "','loc':'" + $('#txt_loc').val() + "','qty':'" + $('#txt_qty').val()
                        + "','ref_to':'" + $('#txt_ref_to').val() + "','loc_to':'" + $('#txt_loc_to').val() + "','comment':'" + $('#comment').val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                    success: function (data) {
                        var obj = eval(data.d);
                        if (obj[0].msg != "") {
                            layer.alert(obj[0].msg);
                            $("#btnsave").removeAttr("disabled");
                            $("#btnsave").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                            return false;
                        }
                        window.location.href = "/ck.aspx";
                    }
                });
            });
        });

        function sm_ref() {
            $('#img_sm_ref').click(function () {
                wx.ready(function () {
                    wx.scanQRCode({
                        needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                        scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                        success: function (res) {
                            var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                            // code 在这里面写上扫描二维码之后需要做的内容
                            $('#txt_ref').val(result);
                            pgino_change();
                        }
                    });
                });
            });
        }
        function sm_loc() {
            $('#img_sm_loc').click(function () {
                wx.ready(function () {
                    wx.scanQRCode({
                        needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                        scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                        success: function (res) {
                            var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                            // code 在这里面写上扫描二维码之后需要做的内容
                            $('#txt_loc').val(result);
                            pgino_change();
                        }
                    });
                });
            });
        }

        function sm_ref_to() {
            $('#img_sm_ref_to').click(function () {
                wx.ready(function () {
                    wx.scanQRCode({
                        needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                        scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                        success: function (res) {
                            var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                            // code 在这里面写上扫描二维码之后需要做的内容
                            $('#txt_ref_to').val(result);
                        }
                    });
                });
            });
        }
        function sm_loc_to() {
            $('#img_sm_loc_to').click(function () {
                wx.ready(function () {
                    wx.scanQRCode({
                        needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                        scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                        success: function (res) {
                            var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                            // code 在这里面写上扫描二维码之后需要做的内容
                            $('#txt_loc_to').val(result);
                            loc_to_change();
                        }
                    });
                });
            });
        }

        function pgino_change() {
            $.ajax({
                type: "post",
                url: "Loc_Transfer.aspx/pgino_change",
                data: "{'domain': '" + $("#domain").val() + "','pgino':'" + $("#txt_xmh").val() + "','_ref':'" + $("#txt_ref").val() + "','loc':'" + $('#txt_loc').val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    var obj = eval(data.d);

                    if (obj[0].msg != "") { $.toptip(obj[0].msg, 3000, 'error'); }//layer.alert(obj[0].msg);

                    if ($("#txt_xmh_rs").val() != "") { $("#txt_xmh_rs").val(obj[0].xmh_value); }
                    $("#txt_xmh").val(obj[0].xmh_value);
                    $("#txt_ref").val(obj[0].ref_value);
                    $("#txt_loc").val(obj[0].loc_value);
                    $("#txt_qty").val(obj[0].qty_value);
                }
            });
        }

        function loc_to_change() {
            $.ajax({
                type: "post",
                url: "Loc_Transfer.aspx/loc_to_change",
                data: "{'domain': '" + $("#domain").val() + "','loc':'" + $("#txt_loc_to").val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    var obj = eval(data.d);

                    if (obj[0].flag == "Y") {
                        $.toptip(obj[0].msg, 3000, 'error');//layer.alert(obj[0].msg);
                        $("#txt_loc_to").val('');
                    }
                }
            });
        }

        function valid() {
            if ($.trim($("#txt_xmh").val()) == "") {
                layer.alert("请输入【项目号】.");
                return false;
            }
            if ($.trim($("#txt_loc").val()) == "") {
                layer.alert("请输入【当前库位】.");
                return false;
            }
            if ($.trim($("#txt_qty").val()) == "" || $.trim($("#txt_qty").val()) == "0") {
                layer.alert("请输入【数量】.");
                return false;
            } else if (parseFloat($("#txt_qty").val()) <= 0) {
                layer.alert("【数量】不可小于等于0.");
                return false;
            }
            if ($.trim($("#txt_ref_to").val()) == "") {
                layer.alert("请输入【移至参考号】.");
                return false;
            } else if (($.trim($("#txt_ref_to").val())).length != 8) {
                layer.alert("【移至参考号】长度必须8位.");
                return false;
            }
            if ($.trim($("#txt_loc_to").val()) == "") {
                layer.alert("请输入【移至库位】.");
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
        <asp:TextBox ID="domain" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="display:none;"></asp:TextBox>

        <div class="weui-cell">
            <div class="weui-cell__hd f-red"><label class="weui-label">项目号</label></div>
                <asp:TextBox ID="txt_xmh_rs" class="weui-input" style="color:gray;width:55%;border-bottom:1px solid #e5e5e5;" runat="server" placeholder="项目号" ></asp:TextBox> 
                <asp:TextBox ID="txt_xmh" class="weui-input" style="color:gray;" runat="server"></asp:TextBox>    
            </div>
        <div class="weui-cell">
            <div class="weui-cell__hd"><label class="weui-label">参考号</label></div>              
            <asp:TextBox ID="txt_ref" class="weui-input" runat="server"></asp:TextBox>
            <img id="img_sm_ref" src="../img/fdj2.png"/>
        </div>
        <div class="weui-cell">
            <div class="weui-cell__hd f-red"><label class="weui-label">当前库位</label></div>                          
            <asp:TextBox ID="txt_loc" class="weui-input" runat="server"></asp:TextBox>
            <img id="img_sm_loc" src="../img/fdj2.png"/>
        </div>
        <div class="weui-cell">
            <div class="weui-cell__hd f-red"><label class="weui-label">数量</label></div>
            <asp:TextBox ID="txt_qty" class="weui-input"  placeholder="" style="color:gray" runat="server"></asp:TextBox>
        </div>
        <div class="weui-cell">
            <div class="weui-cell__hd f-red"><label class="weui-label">移至参考号</label></div>
            <asp:TextBox ID="txt_ref_to" class="weui-input" runat="server"></asp:TextBox>
            <img id="img_sm_ref_to" src="../img/fdj2.png"/>
        </div>
        <div class="weui-cell">
            <div class="weui-cell__hd f-red"><label class="weui-label">移至库位</label></div>                          
            <asp:TextBox ID="txt_loc_to" class="weui-input" runat="server"></asp:TextBox>
            <img id="img_sm_loc_to" src="../img/fdj2.png"/>
        </div> 
        <div class="weui-cell">
            <div class="weui-cell__hd"><label class="weui-label">说明</label></div>
            <textarea id="comment" class="weui-textarea"  placeholder="请输入说明" rows="3"  runat="server"></textarea>
        </div>
        <div class="weui-cell">
            <input id="btnsave" type="button" value="确认" class="weui-btn weui-btn_primary" />
        </div>
    </div>
    </form>
    <script>
        var datalist_pgino;
        $.ajax({
            type: "post",
            url: "Loc_Transfer.aspx/init_data_js",
            data: "{'domain': '" + $("#domain").val() + "','emp': '" + $("#emp_code_name").val() + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
            success: function (data) {
                var obj = eval(data.d);
                datalist_pgino = obj[0].json_pgino;
            }
        });

        $("#txt_xmh").select({
            title: "项目号",
            items: datalist_pgino,
            onChange: function (d) {
                //alert(d.values);
                pgino_change();
            },
            onClose: function (d) {
                //var obj = eval(d.data);
                //alert(obj.values);

            },
            onOpen: function () {
                //  console.log("open");
            }
        });
    </script>
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
