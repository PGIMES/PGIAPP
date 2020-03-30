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
        .weui-cell{
            padding:4px 15px;
        }
    </style>

     <script>
         function valid_sl() {
            
             if ($("#lot_no").attr("readonly")) {
                 layer.alert("已送料，不可再次送料.");
                 return false;
             } else {
                 if ($("#lot_no").val() == "") {
                     layer.alert("请输入【Lot No】.");
                     return false;
                 }
                 if ($("#act_qty").val() == "") {
                     layer.alert("请输入【数量】.");
                     return false;
                 }
             }
             return true;
         }

         function valid_cancel() {
             if ($("#need_qty").val() == $("#act_qty").val()) {
                 layer.alert("已经全部送料完成，不可取消要料.");
                 return false;
             }
             return true;
         }

    </script>

</head>
<body>
     <%-- 步骤一：引入JS文件--%>
    <%--<script src="../scripts/jquery-1.10.2.min.js"></script>--%>
    
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <%--步骤二：通过config接口注入权限验证配置--%>
    <script>        
       //config注入的是企业的身份与权限
        $('#lot_no').val('<% =WeiXin.CorpID %>' + " " + '<% = timestamp %>' + " " + '<% = noncestr   %>' + " " + '<%= ent_signature %>' + " " + '<%= uri %>');
        wx.config({
            debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
            appId: '<% =WeiXin.CorpID %>', // 公众号
            timestamp: '<% = timestamp %>', // 必填，生成签名的时间戳
            nonceStr: '<% = noncestr   %>', // 必填，生成签名的随机串 
            signature: '<%= ent_signature %>',// 必填，签名，config所以为企业签名
            jsApiList: ['scanQRCode']
        });

        wx.ready(function () {
            //扫描二维码
            document.querySelector('#img_sm').onclick = function () {
                //alert("a");
                wx.scanQRCode({
                    needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                    scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                    success: function (res) {
                        var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                        // code 在这里面写上扫描二维码之后需要做的内容                       
                        $('#lot_no').val(result);
                        $('#lot_no').change();
                        
                    }
                });
            };//end_document_scanQRCode
        });

        $(document).ready(function () {
            if ($("#lot_no").val() != "") {
                $("#lot_no").attr("readonly", "readonly"); $("#lot_no").css('color', 'gray');
                $("#btn_sl").hide(); $("#btn_cancel").show();
            } else {
                $("#btn_sl").show(); $("#btn_cancel").hide();
            }

            $("#act_qty").attr("readonly", "readonly");

            $("#lot_no").change(function () {
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
            });
        });

    </script>

    <form id="form1" runat="server">
        <asp:ScriptManager runat="server">
        </asp:ScriptManager>
   

        <div class="weui-cells weui-cells_form">

            <div class="weui-form-preview">
                <asp:TextBox ID="emp_code_name" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server" Visible="false"></asp:TextBox>
                <asp:TextBox ID="need_no" class="weui-input" ReadOnly="true" placeholder="" style="color:gray" runat="server" Visible="false"></asp:TextBox>
                <asp:TextBox ID="pgino" class="weui-input" ReadOnly="true" placeholder="" style="color:gray" runat="server" Visible="false"></asp:TextBox>
                <asp:TextBox ID="pn" class="weui-input" ReadOnly="true" placeholder="" style="color:gray" runat="server" Visible="false"></asp:TextBox>

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
                                <span class="weui-form-preview__value"><%# Eval("need_date","{0:MM/dd HH:mm}")%></span>
                            </div>  
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
                <%--<asp:TextBox ID="emp_code_name" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server" Visible="false"></asp:TextBox>

                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">要料人</label></div>
                    <asp:TextBox ID="yl_emp" class="weui-input" ReadOnly="true" placeholder="" style="color:gray" runat="server"></asp:TextBox>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">要料人时间</label></div>
                    <asp:TextBox ID="req_date" class="weui-input" ReadOnly="true" placeholder="" style="color:gray" runat="server"></asp:TextBox>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">车间</label></div>
                    <asp:TextBox ID="workshop" class="weui-input" ReadOnly="true" placeholder="" style="color:gray" runat="server"></asp:TextBox>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">生产线</label></div>
                    <asp:TextBox ID="line" class="weui-input" ReadOnly="true" placeholder="" style="color:gray" runat="server"></asp:TextBox>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">岗位</label></div>
                    <asp:TextBox ID="location" class="weui-input" ReadOnly="true" placeholder="" style="color:gray" runat="server"></asp:TextBox>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">物料号</label></div>
                    <asp:TextBox ID="pgino" class="weui-input" ReadOnly="true" placeholder="" style="color:gray" runat="server"></asp:TextBox>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">零件号</label></div>
                    <asp:TextBox ID="pn" class="weui-input" ReadOnly="true" placeholder="" style="color:gray" runat="server"></asp:TextBox>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">要料数量</label></div>
                    <asp:TextBox ID="need_qty" class="weui-input" ReadOnly="true" placeholder="" style="color:gray" runat="server"></asp:TextBox>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">要求送到时间</label></div>
                    <asp:TextBox ID="need_date" class="weui-input" ReadOnly="true" placeholder="" style="color:gray" runat="server"></asp:TextBox>
                    <asp:TextBox ID="need_no" class="weui-input" ReadOnly="true" placeholder="" style="color:gray" runat="server" Visible="false"></asp:TextBox>
                </div>--%>

                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">Lot No</label></div>
                    <div class="weui-cell__hd">
                        <span style="float:left; width:90%">
                            <asp:TextBox ID="lot_no" class="weui-input" placeholder="请输入Lot No" runat="server"></asp:TextBox>
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
                    <div class="weui-cell__hd"><label class="weui-label">送料人</label></div>
                    <asp:TextBox ID="emp_sl" class="weui-input" ReadOnly="true" placeholder="" style="color:gray" runat="server"></asp:TextBox>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">送料时间</label></div>
                    <asp:TextBox ID="act_date" class="weui-input" ReadOnly="true" placeholder="" style="color:gray" runat="server"></asp:TextBox>
                </div>


                <div class="">
                    <asp:Button ID="btn_sl" class="weui-btn weui-btn_primary" runat="server" 
                        Text="送&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;料" OnClick="btn_sl_Click" OnClientClick="return valid_sl();" /> 
                     <asp:Button ID="btn_cancel" class="weui-btn weui-btn_primary" runat="server" 
                        Text="取消要料" OnClick="btn_cancel_Click" OnClientClick="return valid_cancel();"/>
                </div>

        </div>

    
    </form>
</body>
</html>
