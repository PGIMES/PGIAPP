<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Adjust_Apply.aspx.cs" Inherits="Adjust_Apply" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>盘盈/盘亏</title>

    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <script src="/Content/layer/layer.js"></script>

    <link href="../css/weui.css" rel="stylesheet" />
    <link href="../css/weuix.css" rel="stylesheet" />
    <script src="../js/zepto.min.js"></script>
    <script src="../js/zepto.weui.js"></script>
    <style>
        .weui-cell{
            padding:4px 15px;
        }
        .f_gray{
            color:gray;
        }
    </style>
    <script>
        $(document).ready(function () {
        });

        $(function () {
            sm_dh();

            $("#btnsave2").click(function(){
                $("#btnsave2").attr("disabled","disabled");
                $("#btnsave2").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');

                if(!valid()){
                    $("#btnsave2").removeAttr("disabled");
                    $("#btnsave2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                    return false;
                }

                $.ajax({
                    type: "post",
                    url: "Adjust_Apply.aspx/save2",
                    data: "{'_emp_code_name':'" + $('#emp_code_name').val() 
                        + "','_workorder':'" + $('#workorder').val() + "','_pgino':'" + $('#pgino').val() + "','_pn':'" + $('#pn').val() 
                        + "','_descr':'" + $('#descr').val() + "','_op':'" + $('#op').val() + "','_qty':'" + $('#qty').val() 
                        + "','_reason':'" + $('#reason').val() + "','_comment':'" + $('#comment').val() + "','_b_use_routing':'" 
                        + $('#b_use_routing').val() + "','_ref_order':'" + $('#ref_order').val() + "','_b_op_one':'" + $('#b_op_one').val() 
                        + "','_lot_no_fixed':'" + $('#lot_no_fixed').val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                    success: function (data) {
                        var obj = eval(data.d);
                        if (obj[0].flag=="Y") {
                            layer.alert(obj[0].msg);
                            $("#btnsave2").removeAttr("disabled");
                            $("#btnsave2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                            return false;
                        }

                        window.location.href = "/workshop.aspx";
                    }

                });
            });
        });

        function sm_dh() {
            $('#img_sm_dh').click(function () {
                wx.ready(function () {
                    wx.scanQRCode({
                        needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                        scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                        success: function (res) {
                            var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                            // code 在这里面写上扫描二维码之后需要做的内容  
                            $('#dh').val(result);
                            dh_change();
                        }
                    });
                });
            });
        }

        function dh_change() {
            $.ajax({
                type: "post",
                url: "Adjust_Apply.aspx/dh_change",
                data: "{'pgino':'" + $('#dh').val() + "','domain':'" + $("#domain").val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    var obj = eval(data.d);
                    $('#pn').val(obj[0].pn);
                    $('#descr').val(obj[0].descr);
                    $('#b_use_routing').val(obj[0].b_use_routing);
                    $('#b_op_one').val(obj[0].b_op_one);
                }

            });
        }

        function valid() {
            //if ($("#workorder").val() == "") {
            //    layer.alert("请输入【单号】.");
            //    return false;
            //} else if ($("#workorder").val().length != 8) {
            //    layer.alert("【单号】长度必须8位.");
            //    return false;
            //}
            return true;
        }

    </script>
</head>
<body>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>  
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server">
        </asp:ScriptManager>
    
        <asp:TextBox ID="emp_code_name" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="display:none;"></asp:TextBox>

        <div class="weui-cells weui-cells_form">     
            <div class="weui-cell">
                <div class="weui-cell__hd f-red "><label class="weui-label">来源</label></div>
                <asp:TextBox ID="source" class="weui-input" style="color:gray;" runat="server"></asp:TextBox>                            
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd f-red "><label class="weui-label">单号</label></div>
                <div class="weui-cell__bd">
                    <span style="float:left; width:90%">
                        <asp:TextBox ID="dh" class="weui-input" style="color:gray" runat="server"></asp:TextBox>
                    </span>
                    <span style="float:left; width:10%">
                        <img id="img_sm_dh" src="../img/fdj2.png" />
                    </span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd f-red "><label class="weui-label">项目号</label></div>
                <div class="weui-cell__bd">
                    <asp:TextBox ID="pgino" class="weui-input" style="color:gray"  runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">零件号</label></div>              
                <asp:TextBox ID="pn" class="weui-input" style="color:gray" runat="server"></asp:TextBox>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">数量</label></div>                          
                <asp:TextBox ID="from_qty" class="weui-input" style="color:gray" runat="server"></asp:TextBox>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd f-red "><label class="weui-label">调整至</label></div>
                <asp:TextBox ID="to_qty" class="weui-input" type='number' placeholder="请输入调整至" runat="server" step="0.0001"></asp:TextBox>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">本次调整</label></div>                          
                <asp:TextBox ID="adj_qty" class="weui-input" style="color:gray" runat="server"></asp:TextBox>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">说明</label></div>
                <textarea id="comment" class="weui-textarea"  placeholder="请输入说明" rows="3"  runat="server"></textarea>
            </div>
            <div class="weui-cell">
                <input id="btnsave2" type="button" value="提交" class="weui-btn weui-btn_primary" />
            </div>
        </div>

    </form>
    <script>
        var datalist_sr = [{ title: '备料区', value: '备料区' }, { title: '已上线', value: '已上线' }]
        $("#source").select({
            title: "来源",
            items: datalist_sr,
            onChange: function (d) {
                //    console.log(this, d);
            },
            onClose: function (d) {
                var obj = eval(d.data);
                //alert(obj.values);
            },
            onOpen: function () {
                //  console.log("open");
            },

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
