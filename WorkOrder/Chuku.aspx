<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Chuku.aspx.cs" Inherits="WorkOrder_Chuku" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>成品出库</title>
    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <script src="/Content/layer/layer.js"></script>

    <link href="../css/weui.css" rel="stylesheet" />
    <link href="../css/weuix.css" rel="stylesheet" />
    <script src="../js/zepto.min.js"></script>
    <script src="../js/zepto.weui.js"></script>

    <script>
        $(document).ready(function () {
            $("#dh").attr("readonly", "readonly");
            $("#workorder").attr("readonly", "readonly");
            $("#domain").attr("readonly", "readonly");
            $("#pgino").attr("readonly", "readonly");
            $("#pn").attr("readonly", "readonly");
            $("#qty").attr("readonly", "readonly");
            $("#emp").attr("readonly", "readonly");
            $("#time").attr("readonly", "readonly");

            if ("<%= _dh %>" != "") {
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
                url: "Chuku.aspx/workorder_change",
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
        function valid() {
            if ($.trim($("#reason").val()) == "") {
                layer.alert("请输入【出库原因】.");
                return false;
            }
            if ($.trim($("#qty").val()) == "" || $.trim($("#qty").val()) == "0") {
                layer.alert("请输入【完成数量】.");
                return false;
            }
            if ($.trim($("#act_qty").val()) == "" || $.trim($("#act_qty").val()) == "0") {
                layer.alert("请输入【出库数量】.");
                return false;
            }
            if (parseInt($("#act_qty").val()) > parseInt($("#qty").val())) {
                layer.alert("【出库数量】不可大于【完成数量】.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <%--<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>  --%>
    <form id="form1" runat="server">
    <asp:ScriptManager runat="server">
    </asp:ScriptManager>
    <div class="weui-cells weui-cells_form">
        
        <asp:TextBox ID="emp_code_name" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="display:none;"></asp:TextBox>

        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="weui-cell">
                    <div class="weui-cell__hd f-red "><label class="weui-label">出库单号</label></div>
                    <asp:TextBox ID="dh" class="weui-input" placeholder="系统自动生成" style="color:gray" runat="server"></asp:TextBox>                
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd f-red "><label class="weui-label">来源单号</label></div>
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
                    <div class="weui-cell__hd"><label class="weui-label">完成数量</label></div>
                    <asp:TextBox ID="qty" class="weui-input" type='number' placeholder="" style="color:gray" runat="server"></asp:TextBox>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd f-red "><label class="weui-label">出库原因</label></div>
                    <asp:TextBox ID="reason" class="weui-input" style="color:gray;" runat="server"></asp:TextBox>                            
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd f-red "><label class="weui-label">出库数量</label></div>
                    <asp:TextBox ID="act_qty" class="weui-input" type='number' placeholder="请输入出库数量" runat="server"></asp:TextBox>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">说明</label></div>
                    <textarea id="comment" class="weui-textarea"  placeholder="请输入说明" rows="3"  runat="server"></textarea>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">出库人</label></div>                          
                    <asp:TextBox ID="emp" class="weui-input" style="color:gray" runat="server"></asp:TextBox>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">出库时间</label></div>                          
                    <asp:TextBox ID="time" class="weui-input" style="color:gray" runat="server"></asp:TextBox>
                </div>
                <div class="weui-cell">
                    <asp:Button ID="btnsave" class="weui-btn weui-btn_primary" runat="server" 
                        Text="出库" OnClick="btnsave_Click" OnClientClick="return valid();" />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    </form>
    <script>
        
        init_data();

        function init_data() {
            var datalist_reason = [{ title: '发货', value: '0' }, { title: '成品领用', value: '1' }, { title: '零箱返线', value: '2' }]
            $("#reason").select({
                title: "出库原因",
                items: datalist_reason,
                onChange: function (d) {
                    //alert(d.values);
                },
                onClose: function (d) {
                    //var obj = eval(d.data);
                    //alert(obj.values);

                },
                onOpen: function () {
                    //  console.log("open");
                },

            });
        }

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {

            init_data();
        });
    </script>
</body>
   <%-- <script>
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
    </script>--%>
</html>
