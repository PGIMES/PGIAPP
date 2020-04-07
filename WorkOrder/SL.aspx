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
            return true;
         }

         function valid_cancel() {
             return confirm('确认要【取消要料】吗？');
         }

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
                data: "{'pgino':'" + $("#pgino").val() + "','lotno':'" + $("#lot_no").val() + "'}",
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
                    } else {
                        $('#act_qty').val(obj[0].qty);
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
                                $('#lot_no').val(result);
                                lotno_change();

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

            <div class="weui-form-preview">
                <asp:TextBox ID="emp_code_name" class="form-control" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                <asp:TextBox ID="need_no" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                <asp:TextBox ID="pgino" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                <asp:TextBox ID="pn" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                <asp:TextBox ID="sy_qty" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>

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
                                <span class="weui-form-preview__value"><%# Eval("emp_code") %><%# Eval("emp_name") %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">岗位</label>
                                <span class="weui-form-preview__value"><%# Eval("location_desc") %></span>
                            </div>
                            <%--<div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">要料人时间</label>
                                <span class="weui-form-preview__value"><%# Eval("req_date","{0:MM/dd HH:mm}")%></span>
                            </div>                             
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">车间</label>
                                <span class="weui-form-preview__value"><%# Eval("workshop") %> </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">生产线</label>
                                <span class="weui-form-preview__value"><%# Eval("line") %> </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">岗位</label>
                                <span class="weui-form-preview__value"><%# Eval("location") %></span>
                            </div>--%>
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
                            <%--<div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">已送数量</label>
                                <span class="weui-form-preview__value"><%# Eval("act_qty") %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">还差数量</label>
                                <span class="weui-form-preview__value"><span style="color:<%# Eval("type").ToString()=="部分"?"red":""%>;"><%# Eval("sy_qty") %></span></span>
                            </div>--%>
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

                <div class="weui-form-preview__hd" style="border-top:1px solid #e5e5e5">
                    <div class="weui-form-preview__item">
                        <label class="weui-form-preview__label">送料信息</label>
                    </div>
                </div>
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
                            <img id="img_sm" src="../img/fdj2.png" style="padding-top:10px;" />
                    </span>
                </div>
            </div>

            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">送料数量</label></div>
                <asp:TextBox ID="act_qty" class="weui-input" placeholder="" style="color:gray" runat="server"></asp:TextBox>
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
                <asp:Button ID="btn_sl" class="weui-btn weui-btn_primary" runat="server" 
                    Text="送料" OnClick="btn_sl_Click" OnClientClick="return valid_sl();" /> 
                    <asp:Button ID="btn_cancel" class="weui-btn weui-btn_primary" runat="server" 
                    Text="取消要料" OnClick="btn_cancel_Click" OnClientClick="return valid_cancel();"/>
            </div>

        </div>

    
    </form>
</body>
</html>
