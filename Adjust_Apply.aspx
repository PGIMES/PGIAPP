<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Adjust_Apply.aspx.cs" Inherits="Adjust_Apply" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>盘盈亏</title>

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
        .weui-btn + .weui-btn{
            margin-top:0px;
        }
    </style>
    <script>
        $(document).ready(function () {
            $("#pgino").attr("readonly", "readonly");
            $("#pn").attr("readonly", "readonly");
            $("#from_qty").attr("readonly", "readonly");

            $("#btn_cancel2").hide();
            if ("<%= _formno %>" != "") {
                $("#source").attr("readonly", "readonly");
                $("#dh").attr("readonly", "readonly"); $("#img_sm_dh").hide();

                if ("<%= _stepid %>" == "0001") {
                    $("#btn_cancel2").show();
                } else {
                    $("#adj_qty").attr("readonly", "readonly");
                    $("#comment").attr("readonly", "readonly");
                }

                if ($("#from_qty").val() == "") {
                    $.toptip('【数量】不可为空.<font color=red>请【放弃申请】.</font>', 2000, 'warning');
                } else if (parseFloat($("#from_qty").val()) <= 0) {
                    $.toptip('【数量】不可小于等于0.<font color=red>请【放弃申请】.</font>', 2000, 'warning');
                }
            }
        });

        $(function () {
            sm_dh();
            
            $("#btn_save2").click(function(){
                $("#btn_save2").attr("disabled", "disabled");
                $("#btn_save2").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');

                $("#btn_cancel2").attr("disabled", "disabled");
                $("#btn_cancel2").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');

                if(!valid()){
                    $("#btn_save2").removeAttr("disabled");
                    $("#btn_save2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                    $("#btn_cancel2").removeAttr("disabled");
                    $("#btn_cancel2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                    return false;
                }

                $.ajax({
                    type: "post",
                    url: "Adjust_Apply.aspx/save2",
                    data: "{'_emp_code_name':'" + $('#emp_code_name').val() 
                        + "','_source':'" + $('#source').val() + "','_dh':'" + $('#dh').val() + "','_pgino':'" + $('#pgino').val()
                        + "','_pn':'" + $('#pn').val() + "','_from_qty':'" + $('#from_qty').val() + "','_adj_qty':'" + $('#adj_qty').val()
                        + "','_comment':'" + $('#comment').val() + "','_flagwhere':'" + $('#flagwhere').val() + "','_need_no':'" + $('#need_no').val()
                        + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                    success: function (data) {
                        var obj = eval(data.d);
                        if (obj[0].flag=="Y") {
                            layer.alert(obj[0].msg);
                            $("#btn_save2").removeAttr("disabled");
                            $("#btn_save2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                            $("#btn_cancel2").removeAttr("disabled");
                            $("#btn_cancel2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                            return false;
                        }

                        window.location.href = "/workshop.aspx";
                    }

                });
            });

            $("#btn_cancel2").click(function () {
                $("#btn_save2").attr("disabled", "disabled");
                $("#btn_save2").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');

                $("#btn_cancel2").attr("disabled", "disabled");
                $("#btn_cancel2").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');

                $.ajax({
                    type: "post",
                    url: "Adjust_Apply.aspx/cancel2",
                    data: "{'_emp_code_name':'" + $('#emp_code_name').val() 
                        + "','_formno':'" + $('#formno').val() + "','_stepid':'" + $('#stepid').val() + "','_comment':'" + $('#comment').val()
                        + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                    success: function (data) {
                        var obj = eval(data.d);
                        if (obj[0].flag=="Y") {
                            layer.alert(obj[0].msg);
                            $("#btn_save2").removeAttr("disabled");
                            $("#btn_save2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                            $("#btn_cancel2").removeAttr("disabled");
                            $("#btn_cancel2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
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
                data: "{'dh':'" + $('#dh').val() + "','source':'" + $("#source").val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    var obj = eval(data.d);
                    if (obj[0].flag == "Y") {
                        layer.alert(obj[0].msg);
                    }
                    $('#pgino').val(obj[0].pgino);
                    $('#pn').val(obj[0].pn);
                    $('#from_qty').val(obj[0].from_qty);
                    $('#flagwhere').val(obj[0].flagwhere);
                    $('#need_no').val(obj[0].need_no);
                }

            });
        }

        function valid() {
            if ($("#source").val() == "") {
                layer.alert("请输入【地点】.");
                return false;
            }
            if ($("#dh").val() == "") {
                layer.alert("请输入【单号】.");
                return false;
            }
            if ($("#pgino").val() == "") {
                layer.alert("【项目号】不可为空.");
                return false;
            }
            if ($("#pn").val() == "") {
                layer.alert("【零件号】不可为空.");
                return false;
            }
            if ($("#from_qty").val() == "") {
                layer.alert("【数量】不可为空.<font color=red>请【放弃申请】.</font>");
                return false;
            } else if (parseFloat($("#from_qty").val()) <= 0) {
                layer.alert("【数量】不可小于等于0.<font color=red>请【放弃申请】.</font>");
                return false;
            }

            if ($.trim($("#adj_qty").val()) == "" || $.trim($("#adj_qty").val()) == "0") {
                layer.alert("请输入【盈亏数量】.");
                return false;
            } else if (parseFloat($("#adj_qty").val()) < 0) {
                if (parseFloat($("#from_qty").val()) + parseFloat($("#adj_qty").val())<0) {
                    layer.alert("盘亏时，负的数量不可超过在制数量.");
                    return false;
                }
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
    
        <asp:TextBox ID="emp_code_name" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="display:none;"></asp:TextBox>
        <asp:TextBox ID="formno" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="display:none;"></asp:TextBox>
        <asp:TextBox ID="stepid" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="display:none;"></asp:TextBox>

        <div class="weui-cells weui-cells_form">     
            <div class="weui-cell">
                <div class="weui-cell__hd f-red "><label class="weui-label">地点</label></div>
                <asp:TextBox ID="source" class="weui-input" style="color:gray;" runat="server"></asp:TextBox>                            
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd f-red "><label class="weui-label">单号</label></div>
                <div class="weui-cell__bd">
                    <span style="float:left; width:90%">
                        <asp:TextBox ID="dh" class="weui-input" style="color:gray" runat="server" onchange="dh_change()"></asp:TextBox>
                    </span>
                    <span style="float:left; width:10%">
                        <img id="img_sm_dh" src="../img/fdj2.png" />
                    </span>
                    <asp:TextBox ID="flagwhere" class="weui-input" placeholder="" runat="server" style="display:none;"></asp:TextBox>
                    <asp:TextBox ID="need_no" class="weui-input" placeholder="" runat="server" style="display:none;"></asp:TextBox>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">项目号</label></div>
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
                <div class="weui-cell__hd f-red "><label class="weui-label">盈亏数量</label></div>                          
                <asp:TextBox ID="adj_qty" class="weui-input" runat="server" placeholder="盈正数，亏负数" type="number"></asp:TextBox>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">说明</label></div>
                <textarea id="comment" class="weui-textarea"  placeholder="请输入说明" rows="3"  runat="server"></textarea>
            </div>

            <div class="weui-form-preview__hd" style="display:<%= _formno!=""?"block":"none"%>;">
                <div class="weui-form-preview__item">
                    <label class="weui-form-preview__label">签核信息</label>
                    <label class="weui-form-preview__"></label>
                </div>
            </div>
            <div class="weui-form-preview__bd">
                <asp:Repeater runat="server" ID="Repeater_sg">
                    <ItemTemplate>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label"><%# Eval("sign_stepname") %></label>
                            <span class="weui-form-preview__value"><%# Eval("phone")+""+Eval("sign_empname") %></span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">签核时间</label>
                            <span class="weui-form-preview__value">
                                <%# Eval("sign_time","{0:MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                            </span>
                        </div> 
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">签核结果</label>
                            <span class="weui-form-preview__value"><%# Eval("sign_result_desc") %></span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">签核意见</label>
                            <span class="weui-form-preview__value"><%# Eval("sign_comment") %></span>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <div class="weui-cell">
                <input id="btn_save2" type="button" value="提交" class="weui-btn weui-btn_primary" />
                <input id="btn_cancel2" type="button" value="放弃申请" class="weui-btn weui-btn_primary" style="margin-left:10px;" />
            </div>
        </div>

    </form>
    <script>
        if ("<%= _formno %>" == "") {
            var datalist_sr = [{ title: '二车间', value: '二车间' }, { title: '三车间', value: '三车间' }, { title: '四车间', value: '四车间' }
                            , { title: '原材料', value: '原材料' }, { title: '成品库', value: '成品库' }, { title: '半成品库', value: '半成品库' }]
            $("#source").select({
                title: "来源",
                items: datalist_sr,
                onChange: function (d) {
                    //    console.log(this, d);
                },
                onClose: function (d) {
                    var obj = eval(d.data);
                    //alert(obj.values);
                    if ($('#dh').val() != "") {
                        dh_change();
                    }
                },
                onOpen: function () {
                    //  console.log("open");
                },

            });
        }
        
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
