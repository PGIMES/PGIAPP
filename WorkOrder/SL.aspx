<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SL.aspx.cs" Inherits="WorkOrder_SL" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>仓库送料</title>
    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <script src="/Content/layer/layer.js"></script>

    <link href="../css/weui.css" rel="stylesheet" />
    <link href="../css/weuix.css" rel="stylesheet" />
    <script src="../js/zepto.min.js"></script>
    <script src="../js/zepto.weui.js"></script>
    <style>
         .weui-mark-lt {
            color: #fff;
            display: block;
            font-size: 0.775em !important;
            left: -0.5em;
            height: 1em;
            line-height: 1em !important;
            position: relative;
            text-align: center;
            top: 0.55em;
            transform: rotate(-45deg);
            width: 3.375em;
            padding: 0.125em;
        }
    </style>
    <style>
        .weui-cell{
            padding:4px 15px;
        }
        .weui-btn + .weui-btn{
            margin-top:0px;
        }
    </style>

     <script>
         function valid_sl() {
            if ($("#lot_no").val() == "") {
                layer.alert("请输入【Lot No】.");
                return false;
            }
            if ($.trim($("#act_qty").val()) == "" || $.trim($("#act_qty").val()) == "0") {
                layer.alert("请输入【送料数量】.");
                return false;
            } else if (parseInt($("#act_qty").val()) > parseInt($("#sy_qty").val())) {
                layer.alert("【送料数量】不可大于【剩余数量】.");
                return false;
            }
            //if ($("#sku_area").val() == "") {
            //    layer.alert("请输入【备料区】.");
            //    return false;
            //} else if (($("#sku_area").val()).indexOf(',')>=0) {
            //    layer.alert("【备料区】不可多个，请联系IT处理.");
            //    return false;
            //}
            if ($("#loc_from").val() == "") {
                layer.alert("请输入【loc_from】.");
                return false;
            }
            if ($("#loc_to").val() == "") {
                layer.alert("请输入【loc_to】.");
                return false;
            }
            return true;
         }

         //function valid_cancel() {
         //    return confirm('确认要【取消要料】吗？');
         //}

    </script>

</head>
<body>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <%--步骤二：通过config接口注入权限验证配置--%>
    <script>    

        $(document).ready(function () {
            $("#act_qty").attr("readonly", "readonly");
        });

        function lotno_change() {
            $.ajax({
                type: "post",
                url: "SL.aspx/lotno_change",
                data: "{'pgino':'" + $("#pgino").val() + "','lotno':'" + $("#lot_no").val() + "','need_no':'" + "<%= _need_no %>" + "','domain':'" + $("#domain").val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    var obj = eval(data.d);
                    var flag = obj[0].flag;
                    if (flag == "Y") {
                        layer.alert(obj[0].msg);
                        $('#lot_no').val("");
                        $('#act_qty').val("");
                        $('#txt_sy_qty').val($('#cur_sy_qty').val());
                        $('#loc_from').val("");
                        $('#loc_to').val("");
                        $('#pgino_yn').val("");
                    } else {
                        $('#act_qty').val(obj[0].qty);
                        $('#txt_sy_qty').val(parseFloat($('#cur_sy_qty').val() == "" ? "0" : $('#cur_sy_qty').val()) - parseFloat(obj[0].qty == "" ? "0" : obj[0].qty));
                        $('#loc_from').val(obj[0].loc_from);
                        $('#loc_to').val(obj[0].loc_to);
                        $('#pgino_yn').val(obj[0].pgino_yn);
                    }

                    return;
                }

            });
        }

        $(function () {
            sm_lotno();

            $("#btn_sl2").click(function () {
                $("#btn_sl2").attr("disabled", "disabled");
                $("#btn_sl2").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');

                $("#btn_cancel2").attr("disabled", "disabled");
                $("#btn_cancel2").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');

                if (!valid_sl()) {
                    $("#btn_sl2").removeAttr("disabled");
                    $("#btn_sl2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                    $("#btn_cancel2").removeAttr("disabled");
                    $("#btn_cancel2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                    return;
                }

                var flag = "N"; var msg = "";
                $.ajax({
                    type: "post",
                    url: "SL.aspx/sure2",
                    data: "{'_emp_code_name':'" + $('#emp_code_name').val() 
                        + "','need_no':'" + "<%= _need_no %>" + "','lotno':'" + $("#lot_no").val() + "','act_qty':'" + $('#act_qty').val()
                        + "','pgino':'" + $("#pgino").val() + "','pn':'" + $('#pn').val() + "','comment':'" + $('#comment').val()
                        + "','loc_from':'" + $("#loc_from").val() + "','loc_to':'" + $("#loc_to").val() + "','sku_area':'" + $("#sku_area").val()
                        + "','pgino_yn':'" + $("#pgino_yn").val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                    success: function (data) {
                        var obj = eval(data.d);
                        flag = obj[0].flag;
                        msg = obj[0].msg;                        
                    }
                });

                if (flag == "Y") {
                    layer.alert(obj[0].msg);
                    $("#btn_sl2").removeAttr("disabled");
                    $("#btn_sl2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                    $("#btn_cancel2").removeAttr("disabled");
                    $("#btn_cancel2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                    return;
                }

                if (flag == "Y_S") {
                    $.confirm('是否继续送料？' + msg, function () {
                        sl2();                    
                    }, function () {
                        //点击取消后的回调函数
                        $("#btn_sl2").removeAttr("disabled");
                        $("#btn_sl2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                        $("#btn_cancel2").removeAttr("disabled");
                        $("#btn_cancel2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                    });
                }

                if (flag == "N") {
                    sl2();
                }

             });

            $("#btn_cancel2").click(function () {
                $("#btn_sl2").attr("disabled", "disabled");
                $("#btn_sl2").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');

                $("#btn_cancel2").attr("disabled", "disabled");
                $("#btn_cancel2").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');

                $.confirm('确认要【取消要料】吗？', function () {
                    $.ajax({
                        type: "post",
                        url: "SL.aspx/cancel2",
                        data: "{'_emp_code_name':'" + $('#emp_code_name').val()+ "','need_no':'" + "<%= _need_no %>" + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                        success: function (data) {
                            var obj = eval(data.d);
                            if (obj[0].flag == "Y") {
                                layer.alert(obj[0].msg);
                                $("#btn_sl2").removeAttr("disabled");
                                $("#btn_sl2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                                $("#btn_cancel2").removeAttr("disabled");
                                $("#btn_cancel2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                                return;
                            }
                            window.location.href = "/workorder/YL_list_new.aspx?workshop=<%=_workshop %>";

                        }

                    });
                }, function () {
                    //点击取消后的回调函数
                    $("#btn_sl2").removeAttr("disabled");
                    $("#btn_sl2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                    $("#btn_cancel2").removeAttr("disabled");
                    $("#btn_cancel2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                });
            });

        });

        function sm_lotno() {
            $('#img_sm_lotno').click(function () {
                wx.ready(function () {
                    wx.scanQRCode({
                        needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                        scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                        success: function (res) {
                            var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                            // code 在这里面写上扫描二维码之后需要做的内容  
                            $('#lot_no').val(result);
                            lotno_change();
                        }
                    });
                });
            });
        }

        function sl2() {
             $.ajax({
                type: "post",
                url: "SL.aspx/sl2",
                data: "{'_emp_code_name':'" + $('#emp_code_name').val() 
                    + "','need_no':'" + "<%= _need_no %>" + "','lotno':'" + $("#lot_no").val() + "','act_qty':'" + $('#act_qty').val()
                    + "','pgino':'" + $("#pgino").val() + "','pn':'" + $('#pn').val() + "','comment':'" + $('#comment').val()
                    + "','loc_from':'" + $("#loc_from").val() + "','loc_to':'" + $("#loc_to").val() + "','sku_area':'" + $("#sku_area").val()
                    + "','pgino_yn':'" + $("#pgino_yn").val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    var obj = eval(data.d);
                                
                        if (obj[0].flag == "Y") {
                        layer.alert(obj[0].msg);
                        $("#btn_sl2").removeAttr("disabled");
                        $("#btn_sl2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                        $("#btn_cancel2").removeAttr("disabled");
                        $("#btn_cancel2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                        return;
                    }
                    window.location.href = "/workorder/YL_list_new.aspx?workshop=<%=_workshop %>";
                }
            });
        }
    </script>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server">
        </asp:ScriptManager>
   

        <div class="weui-cells weui-cells_form">

            <div class="weui-form-preview">
                <asp:TextBox ID="emp_code_name" class="form-control" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                <asp:TextBox ID="need_no" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                <asp:TextBox ID="pgino" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                <asp:TextBox ID="pn" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                <asp:TextBox ID="domain" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                <asp:TextBox ID="cur_sy_qty" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                <asp:TextBox ID="sku_area" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>

                <div class="weui-form-preview__hd">
                    <div class="weui-form-preview__item">
                        <label class="weui-form-preview__label">要料信息</label>
                        <label class="weui-form-preview__">单号:<% ="<font class='tag'/>"+_need_no %></label>
                    </div>
                </div>
                <div class="weui-form-preview__bd">
                    <asp:Repeater runat="server" ID="listBxInfo">
                        <ItemTemplate>
                            <div class="weui-mark-vip"><span class="weui-mark-lt <%# Eval("type").ToString()=="部分"?"bg-red":""%>"><%#Eval("type") %></span></div>
                            
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">要料人</label>
                                <span class="weui-form-preview__value"><%# Eval("emp_code")+""+ Eval("emp_name") +"["+ Eval("req_date")+"]" %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">岗位</label>
                                <span class="weui-form-preview__value"><%# Eval("location_desc") %>
                                   <span style="font-weight:800"><%# "["+ Eval("sku_area")+"]" %></span>
                                </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">物料号</label>
                                <span class="weui-form-preview__value"><%# Eval("pgino") %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">零件号</label>
                                <span class="weui-form-preview__value"><%# Eval("pn") %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">要料数量</label>
                                <span class="weui-form-preview__value"><%# Eval("need_qty") %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">要求送到时间</label>
                                <span class="weui-form-preview__value">
                                    <%# Eval("need_date","{0:MM/dd HH:mm}")%>
                                    <span style="color:<%# Eval("times_type").ToString()=="还差"?"#10AEFF":(Eval("times_type").ToString()=="超时"?"red":"#999999") %>;">
                                        <%# Eval("times_type") %><%# Eval("times") %>
                                    </span>
                                </span>
                            </div>  
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                <div class="weui-form-preview__hd" style="border-top:1px solid #e5e5e5">
                    <div class="weui-form-preview__item">
                        <asp:LinkButton ID="lk_lotno_qad" class="weui-form-preview__label" runat="server" OnClick="lk_lotno_qad_Click">送料信息</asp:LinkButton>
                    </div>
                </div>
                <div class="weui-form-preview__bd">
                    <asp:Repeater runat="server" ID="listBx_lotno_qad" Visible="false">
                        <ItemTemplate>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">物料号</label>
                                <span class="weui-form-preview__value"><%# Eval("ld_part") %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">参考号</label>
                                <span class="weui-form-preview__value"><%# Eval("ld_ref") %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">库位</label>
                                <span class="weui-form-preview__value"><%# Eval("ld_loc") %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">数量</label>
                                <span class="weui-form-preview__value"><%# Eval("ld_qty_oh") %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">备料区</label>
                                <span class="weui-form-preview__value"><%# Eval("sku_area") %></span>
                            </div>
                            <div class="weui-form-preview__item" style="border-bottom:1px solid #e5e5e5">
                                <label class="weui-form-preview__label">线边库位</label>
                                <span class="weui-form-preview__value"><%# Eval("loc_to") %></span>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                </ContentTemplate>
                </asp:UpdatePanel>

                <div class="weui-form-preview__bd">
                    <asp:Repeater runat="server" ID="listBx_lotno">
                        <ItemTemplate>
                            <div class="weui-form-preview__item"> <%--style="border-bottom:1px solid #e5e5e5"--%>
                                <label class="weui-form-preview__label">Lot No</label>
                                <span class="weui-form-preview__value"><%# Eval("lot_no") %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">送料数量</label>
                                <span class="weui-form-preview__value"><%# Eval("act_qty") %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">还差数量</label>
                                <span class="weui-form-preview__value"><%# Eval("sy_qty") %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">送料时间</label>
                                <span class="weui-form-preview__value"><%# Eval("act_date","{0:yyyy-MM-dd HH:mm}") %></span>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

            </div>

            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">Lot No</label></div>
                <div class="weui-cell__hd">
                    <span style="float:left; width:90%">
                        <asp:TextBox ID="lot_no" class="weui-input" placeholder="请输入Lot No" runat="server" onchange="lotno_change()"></asp:TextBox>
                    </span>
                        <span style="float:left; width:10%">
                            <img id="img_sm_lotno" src="../img/fdj2.png" style="padding-top:10px;" />
                    </span>
                </div>
            </div>

            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">送料数量</label></div>
                <asp:TextBox ID="act_qty" class="weui-input" placeholder="" style="color:gray" runat="server"></asp:TextBox>
                <asp:TextBox ID="loc_from" class="weui-input" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                <asp:TextBox ID="loc_to" class="weui-input" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                <asp:TextBox ID="pgino_yn" class="weui-input" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
            </div>

            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">还差数量</label></div>
                <asp:TextBox ID="txt_sy_qty" class="weui-input" ReadOnly="true" placeholder="" style="color:gray" runat="server"></asp:TextBox>
            </div>

            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">送料时间</label></div>
                <asp:TextBox ID="txt_act_date" class="weui-input" ReadOnly="true"  placeholder="" style="color:gray" runat="server"></asp:TextBox>
            </div>

            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">送料说明</label></div>
                <textarea id="comment" class="weui-textarea"  placeholder="请输入说明" rows="3"  runat="server"></textarea>
            </div>

            <div class="weui-cell">
                <%--<asp:Button ID="btn_sl" class="weui-btn weui-btn_primary" runat="server" UseSubmitBehavior="false" 
                    Text="送料" OnClick="btn_sl_Click" OnClientClick="if(!valid_sl()){return false;}this.disabled=false;this.value='处理中…';" />--%> <%--OnClientClick="return valid_sl();"--%>
                    <%--<asp:Button ID="btn_cancel" class="weui-btn weui-btn_primary" runat="server" 
                    Text="取消要料" OnClick="btn_cancel_Click" OnClientClick="return valid_cancel();" style="margin-left:10px;"/>--%>
                <input id="btn_sl2" type="button" value="送料" class="weui-btn weui-btn_primary" />
                <input id="btn_cancel2" type="button" value="取消要料" class="weui-btn weui-btn_primary" style="margin-left:10px;" />
            </div>

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
