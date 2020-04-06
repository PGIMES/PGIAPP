<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bhgp_deal_new.aspx.cs" Inherits="WorkOrder_bhgp_deal_new" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>不合格处置</title>
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
            //if ($("#lot_no").val() == "") {
            //    layer.alert("请输入【Lot No】.");
            //    return false;
            //}
            //if ($.trim($("#act_qty").val()) == "" || $.trim($("#act_qty").val()) == "0") {
            //    layer.alert("请输入【送料数量】.");
            //    return false;
            //} else if (parseInt($("#act_qty").val()) > parseInt($("#sy_qty").val())) {
            //    layer.alert("【送料数量】不可大于【剩余数量】.");
            //    return false;
            //}
            //return true;
         }

         function valid_cancel() {
             //return confirm('确认要【取消要料】吗？');
         }

    </script>

</head>
<body>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <%--步骤二：通过config接口注入权限验证配置--%>
    <script>    

        $(document).ready(function () {
            //$("#act_qty").attr("readonly", "readonly");
        });

      
    </script>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server">
        </asp:ScriptManager>
   

        <div class="weui-cells weui-cells_form">

            <div class="weui-form-preview">
                <asp:TextBox ID="emp_code_name" class="form-control" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                <asp:TextBox ID="workorder" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>

                <div class="weui-form-preview__hd">
                    <div class="weui-form-preview__item">
                        <label class="weui-form-preview__label">不合格申请信息</label>
                        <label class="weui-form-preview__">单号:<% ="<font class='tag'/>"+_workorder %></label>
                    </div>
                </div>
                <div class="weui-form-preview__bd">
                    <asp:Repeater runat="server" ID="listBxInfo" OnItemDataBound="listBxInfo_ItemDataBound">
                        <ItemTemplate>
                            <div class="weui-mark-vip">
                               <%-- <span class="weui-mark-lt <%# Eval("type").ToString()=="部分"?"bg-red":""%>"><%#Eval("type") %></span>--%>
                                 <span class="weui-mark-lt"></span>
                            </div>
                            
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">产线</label>
                                <span class="weui-form-preview__value"><%= _workshop %>/<%# Eval("line") %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">物料号</label>
                                <span class="weui-form-preview__value"><%# Eval("pgino")+","+Eval("pn") %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">零件名称</label>
                                <span class="weui-form-preview__value"><%# Eval("descr") %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">工序</label>
                                <span class="weui-form-preview__value"><%# Eval("op") +""+ Eval("op_descr") %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">数量</label>
                                <span class="weui-form-preview__value"><%# Eval("qty") %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">原因名称</label>
                                <span class="weui-form-preview__value"><%# Eval("reason_code") +""+ Eval("reason") %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">说明</label>
                                <span class="weui-form-preview__value"><%# Eval("comment") %></span>
                            </div>
                            <asp:Repeater runat="server" ID="listBx_lotno">
                                <ItemTemplate>
                                    <div class="weui-form-preview__bd">
                                        <div class="weui-form-preview__item">
                                            <label class="weui-form-preview__label">Lot No</label>
                                            <span class="weui-form-preview__value"><%# Eval("lot_no") %></span>
                                        </div>
                                        <div class="weui-form-preview__item">
                                            <label class="weui-form-preview__label">数量</label>
                                            <span class="weui-form-preview__value"><%# Eval("qty") %></span>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">申请人</label>
                                <span class="weui-form-preview__value"><%# Eval("phone") %><%# Eval("emp_name") %></span>
                            </div> 
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">申请时间</label>
                                <span class="weui-form-preview__value">
                                    <%# Eval("create_date","{0:MM/dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                                </span>
                            </div> 
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

            </div>

            <%--<div class="weui-cell">
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
            </div>--%>


            <%--<div class="weui-cell">
                <asp:Button ID="btn_sl" class="weui-btn weui-btn_primary" runat="server" 
                    Text="送料"  OnClientClick="return valid_sl();" /> 
                    <asp:Button ID="btn_cancel" class="weui-btn weui-btn_primary" runat="server" 
                    Text="取消要料" OnClientClick="return valid_cancel();"/>
            </div>--%>

        </div>

    
    </form>
</body>
</html>
