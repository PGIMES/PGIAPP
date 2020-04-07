<%@ Page Language="C#" AutoEventWireup="true" CodeFile="YL.aspx.cs" Inherits="YL" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>生产要料</title>

    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <script src="/Content/layer/layer.js"></script>

    <link href="../css/weui.css" rel="stylesheet" />
    <link href="../css/weuix.css" rel="stylesheet" />
    <script src="../js/zepto.min.js"></script>
    <script src="../js/zepto.weui.js"></script>
    <style>          
        /*.weui-cell{
            padding:4px 15px;
        }*/   
    </style>
    <script>
        function valid() {
            if ($("#pgino").val() == "") {
                layer.alert("请输入【物料号】.");
                return false;
            }
            if ($.trim($("#need_qty").val()) == "" || $.trim($("#need_qty").val()) == "0") {
                layer.alert("请输入【要料数量】.");
                return false;
            }
            if ($("#need_date_dl").val() == "") {
                layer.alert("请输入【送到时间】.");
                return false;
            }
            if ($("#need_date").val() == "") {
                layer.alert("请选择【送到时间】.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>    
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <%--步骤二：通过config接口注入权限验证配置--%>
    <script>     
        $(document).ready(function () {
            $("#pn").attr("readonly", "readonly");
            $("#descr").attr("readonly", "readonly");
            $("#need_date").attr("readonly", "readonly");
        });

        function pgino_change() {
            $.ajax({
                type: "post",
                url: "YL.aspx/pgino_change",
                data: "{'pgino':'" + $("#pgino").val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    var obj = eval(data.d);
                    var flag = obj[0].flag;
                    if (flag == "Y") {
                        layer.alert(obj[0].msg);
                        $('#pgino').val("");
                        $('#pn').val("");
                        $('#descr').val("");
                        $('#need_qty').val("");
                    } else {
                        $('#pn').val(obj[0].pn);
                        $('#descr').val(obj[0].descr);
                        $('#need_qty').val(obj[0].qty);
                    }

                    return;
                }

            });
        }
        
    </script>
    <script>
        $.ajax({
            url: "/getwxconfig.aspx/GetScanQRCode",
            type: "Post",
            data: "{ 'url': '" + location.href + "' }",
            async: false,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                var datad = JSON.parse(data.d); //转为Json字符串
                wx.config({
                    debug: false, // 开启调试模式
                    appId: datad.appid, // 必填，公众号的唯一标识
                    timestamp: datad.timestamp, // 必填，生成签名的时间戳
                    nonceStr: datad.noncestr, // 必填，生成签名的随机串
                    signature: datad.signature,// 必填，签名，见附录1
                    jsApiList: ["scanQRCode"] // 必填，需要使用的JS接口列表
                });
                //wx.error(function (res) {
                //    alert(res);
                //});
                wx.ready(function () {
                    //扫描二维码
                    document.querySelector('img[id*=img_sm]').onclick = function () {
                        wx.scanQRCode({
                            needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                            scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                            success: function (res) {
                                var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                                // code 在这里面写上扫描二维码之后需要做的内容                       
                                $('#pgino').val(result);
                                $('#pgino').change();

                            }
                        });
                    };//end_document_scanQRCode
                });
            },
            error: function (error) {
                alert(error)
            }
        });
    </script>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server">
        </asp:ScriptManager>
        <div class="weui-cells weui-cells_form">       
    
            <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>--%>
                   
                <asp:TextBox ID="emp_code_name" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server" Visible="false"></asp:TextBox>
                <asp:TextBox ID="domain" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server" Visible="false"></asp:TextBox>

                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">要料人</label></div>
                    <asp:Label ID="lbl_emp" runat="server" Text="" style="color:gray"></asp:Label>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">当前岗位</label></div>
                    <asp:Label ID="lbl_location" runat="server" Text="" style="color:gray"></asp:Label>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd f-red "><label class="weui-label">物料号</label></div>
                    <div class="weui-cell__bd">
                        <span style="float:left; width:90%">
                            <asp:TextBox ID="pgino" class="weui-input"  placeholder="请输入物料号" runat="server" onkeyup="this.value=this.value.toUpperCase()" onchange="pgino_change()"></asp:TextBox>
                        </span>
                        <span style="float:left; width:10%">
                            <img id="img_sm" src="../img/fdj2.png" style="padding-top:10px;" />
                        </span>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">零件号</label></div>              
                    <asp:TextBox ID="pn" class="weui-input" style="color:gray" runat="server"></asp:TextBox>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">物料名称</label></div>                          
                    <asp:TextBox ID="descr" class="weui-input" style="color:gray" runat="server"></asp:TextBox>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">要料数量</label></div> 
                    <asp:TextBox ID="need_qty" class="weui-input" type='number' placeholder="请输入要料数量" runat="server"></asp:TextBox>
                </div>
                    
                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">送到时间</label></div>
                    <div class="weui-cell__hd" style="width:30%">
                        <input class="weui-input" id="need_date_dl" type="text" value=""  runat="server" placeholder="请选择" readonly="readonly" />
                    </div>
                    <div class="weui-cell__hd" style="width:70%; text-align:right;">
                        <asp:TextBox ID="need_date" class="weui-input" style="color:gray"  runat="server"></asp:TextBox>
                    </div>
                </div>

           <%-- </ContentTemplate>
        </asp:UpdatePanel>  --%>

        <div class="weui-cell">
            <asp:Button ID="btnsave" class="weui-btn weui-btn_primary" runat="server" 
                Text="确认" OnClick="btnsave_Click" OnClientClick="return valid();" />
        </div>

    </div>
    </form>

    <script>
        var datalist_nd = [{ title: '立即', value: '0' }, { title: '半小时后', value: '30' }, { title: '1小时后', value: '60' }
                        , { title: '2小时后', value: '120' }, { title: '4小时后', value: '240' }, { title: '8小时后', value: '480' }]
        $("#need_date_dl").select({
            title: "送到时间",
            items: datalist_nd,
            onChange: function (d) {
                //    console.log(this, d);
            },
            onClose: function (d) {
                var obj = eval(d.data);
                //alert(obj.values);
                $.ajax({
                    type: "post",
                    url: "YL.aspx/nd_change",
                    data: "{'nd_jg':'" + obj.values + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                    success: function (data) {
                        var obj = eval(data.d);
                        var time = obj[0].time;
                        //alert(time);
                        $("#need_date").val(time);
                    }

                });
            },
            onOpen: function () {
                //  console.log("open");
            },

        });
        
    </script>
</body>
</html>
