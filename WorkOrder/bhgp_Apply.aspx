<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bhgp_Apply.aspx.cs" Inherits="bhgp_Apply" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>不合格申请</title>
    
    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <script src="/Content/layer/layer.js"></script>

    <link href="../css/weui.css" rel="stylesheet" />
    <link href="../css/weuix.css" rel="stylesheet" />
    <script src="../js/zepto.min.js"></script>
    <script src="../js/zepto.weui.js"></script>
    <script src="../js/iscroll-lite.js"></script>

    
    <script>
        $(document).ready(function () {
            $("#pn").attr("readonly", "readonly");
            $("#descr").attr("readonly", "readonly");

            if ($("#ref_order").val() == "") {
                $("#div_ref_order").hide();
                $("#lbl_ref_order").text("参考号/生产完成单号");
                $("#ref_order").val("");
            }
            
        });

        $(function () {
            $('#t1').tab({
                defaultIndex: 0,
                activeClass: 'tab-green',
                onToggle: function (index) {
                    console.log('index' + index);
                }
            });

            saomiao_workorder();
            saomiao_pgino();
        });

        function saomiao_workorder() {
            $('img[id*=img_sm_workorder]').click(function () {
                wx.ready(function () {
                    wx.scanQRCode({
                        needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                        scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                        success: function (res) {
                            var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                            // code 在这里面写上扫描二维码之后需要做的内容                       
                            $('#workorder').val(result);
                        }
                    });
                });
            });
        }

        function saomiao_pgino() {
            $('img[id*=img_sm_pgino]').click(function () {
                wx.ready(function () {
                    wx.scanQRCode({
                        needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                        scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                        success: function (res) {
                            var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                            // code 在这里面写上扫描二维码之后需要做的内容                       
                            $('#pgino').val(result);
                            pgino_change(result);
                        }
                    });
                });
            });
        }

        function pgino_change(pgino) {
            $.ajax({
                type: "post",
                url: "bhgp_Apply.aspx/pgino_change",
                data: "{'pgino':'" + pgino + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    var obj = eval(data.d);
                    $('#pn').val(obj[0].pn);
                    $('#descr').val(obj[0].descr);

                    var json_op = obj[0].json_op;
                    $("#op").select("update", { items: json_op });
                    $('#op').val('');

                    $("#div_ref_order").hide();
                    $("#lbl_ref_order").text("参考号/生产完成单号");
                    $("#ref_order").val("");
                }

            });
        }

        function valid() {
            if ($("#workorder").val() == "") {
                layer.alert("请输入【单号】.");
                return false;
            }
            if ($("#pgino").val() == "") {
                layer.alert("请输入【物料号】.");
                return false;
            }
            if ($("#op").val() == "") {
                layer.alert("请输入【工序】.");
                return false;
            } else {
                if ($.trim($("#ref_order").val()) == "") {
                    var _op = ($("#op").val()).substr(0, ($("#op").val()).indexOf('-'));
                    if (parseInt(_op) > 700) {
                        layer.alert("请输入【参考号】.");
                        return false;
                    }else if (parseInt(_op) >= 600) {
                        layer.alert("请输入【生产完成单号】.");
                        return false;
                    }
                }
            }
            if ($.trim($("#qty").val()) == "" || $.trim($("#qty").val()) == "0") {
                layer.alert("请输入【数量】.");
                return false;
            }
            if ($("#reason").val() == "") {
                layer.alert("请输入【原因名称】.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>    
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server"></asp:ScriptManager>

        <div class="weui-tab" id="t1">
            <div class="weui-navbar">
                <div href="#tab1" class="weui-navbar__item weui-bar__item_on">
                    不合格申请1
                </div>
                <div href="#tab2" class="weui-navbar__item">
                    不合格申请2
                </div>
            </div>
            <div class="weui-tab__panel">
                 <%--=======所有工单-----%>
                <div id="tab1" class="weui-tab__content">
                    <div class="weui-cells weui-cells_form">             
                        <asp:TextBox ID="emp_code_name" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="display:none;"></asp:TextBox>
                        <asp:TextBox ID="domain" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="display:none;"></asp:TextBox>

                        <div class="weui-cell">
                            <div class="weui-cell__hd f-red "><label class="weui-label">单号</label></div>
                            <div class="weui-cell__bd">
                                <span style="float:left; width:90%">
                                    <asp:TextBox ID="workorder" class="weui-input" placeholder="请输入不合格处置单号" runat="server"></asp:TextBox>
                                </span>
                                <span style="float:left; width:10%">
                                    <img id="img_sm_workorder" src="../img/fdj2.png"/>
                                </span>
                            </div>
                        </div>

                        <div class="weui-cell">
                            <div class="weui-cell__hd f-red "><label class="weui-label">物料号</label></div>
                            <div class="weui-cell__bd">
                                <span style="float:left; width:90%">
                                    <asp:TextBox ID="pgino" class="weui-input" style="color:gray"  runat="server"></asp:TextBox>
                                </span>
                                <span style="float:left; width:10%">
                                    <img id="img_sm_pgino" src="../img/fdj2.png" />
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
                            <div class="weui-cell__hd f-red "><label class="weui-label">工序</label></div>
                            <asp:TextBox ID="op" class="weui-input" style="color:gray" runat="server"></asp:TextBox>
                        </div>

                        <div class="weui-cell" id="div_ref_order">
                            <div class="weui-cell__hd f-red "><label class="weui-label" id="lbl_ref_order"></label></div>
                            <asp:TextBox ID="ref_order" class="weui-input"  runat="server"></asp:TextBox>
                        </div>

                        <div class="weui-cell">
                            <div class="weui-cell__hd f-red "><label class="weui-label">数量</label></div>
                            <asp:TextBox ID="qty" class="weui-input" type='number' placeholder="请输入处置数量" runat="server"></asp:TextBox>
                        </div>

                        <div class="weui-cell">
                            <div class="weui-cell__hd f-red "><label class="weui-label">原因名称</label></div>
                            <asp:TextBox ID="reason" class="weui-input" style="color:gray" runat="server"></asp:TextBox>
                        </div>

                        <div class="weui-cell">
                            <div class="weui-cell__hd"><label class="weui-label">说明</label></div>
                            <textarea id="comment" class="weui-textarea"  placeholder="请输入说明" rows="3"  runat="server"></textarea>
                        </div>

                        <div class="weui-cell">
                            <asp:Button ID="btnsave" class="weui-btn weui-btn_primary" runat="server" 
                                Text="提交" OnClick="btnsave_Click" OnClientClick="return valid();" />
                        </div>

                    </div>
                </div>
                 <%--=======所有工单-----%>
                <div id="tab2" class="weui-tab__content">

                </div>
            </div>
        </div>


    
    </form>

    <script>
        var datalist_pgino, datalist_reason;
        $.ajax({
            type: "post",
            url: "bhgp_Apply.aspx/init_pgino",
            data: "{'domain': '" + $("#domain").val() + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
            success: function (data) {
                var obj = eval(data.d);
                datalist_pgino = obj[0].json;
                datalist_reason = obj[0].json_reason;
            }
        });
        $("#pgino").select({
            title: "物料号",
            items: datalist_pgino,
            onChange: function (d) {
                //alert(d.values);
                pgino_change(d.values);
            },
            onClose: function (d) {
                //var obj = eval(d.data);
                //alert(obj.values);
                
            },
            onOpen: function () {
                //  console.log("open");
            },

        });
        $("#reason").select({
            title: "原因名称",
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

        $("#op").select({
            title: "工序",
            items: [{title:'' ,value:''}],
            onChange: function (d) {
                //alert(d.values);
                if (parseInt(d.values) < 600) {
                    $("#div_ref_order").hide();
                    $("#lbl_ref_order").text("参考号/生产完成单号");
                    $("#ref_order").val("");
                } else if (parseInt(d.values) >= 600 && parseInt(d.values) <= 700) {
                    $("#div_ref_order").show();
                    $("#lbl_ref_order").text("生产完成单号");
                    $("#ref_order").val("");
                } else if (true) {
                    $("#div_ref_order").show();
                    $("#lbl_ref_order").text("参考号");
                    $("#ref_order").val("");
                }
            },
            onClose: function (d) {
                //var obj = eval(d.data);
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
