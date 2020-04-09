<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bhgp_sign.aspx.cs" Inherits="WorkOrder_bhgp_sign" %>

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
        #UpdatePanel1 .weui-cell:before{
            border-top:none;
        }
    </style>

     <script>
         function valid() {
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
                <asp:TextBox ID="domain" class="form-control" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                <asp:TextBox ID="workorder" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>

                <div class="weui-form-preview__hd">
                    <div class="weui-form-preview__item">
                        <label class="weui-form-preview__label">申请信息</label>
                        <label class="weui-form-preview__">单号:<% ="<font class='tag'/>"+_workorder %></label>
                    </div>
                </div>
                <div class="weui-form-preview__bd">
                    <asp:Repeater runat="server" ID="listBxInfo" OnItemDataBound="listBxInfo_ItemDataBound">
                        <ItemTemplate>
                            <div class="weui-mark-vip">
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
                                <label class="weui-form-preview__label">申请数量</label>
                                <span class="weui-form-preview__value"><%# Eval("qty") %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">剩余数量</label>
                                <span class="weui-form-preview__value"><%# "<font class='f-red'>"+Eval("sy_qty") +"</font>" %></span>
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

           <div class="weui-form-preview__hd">
                <div class="weui-form-preview__item">
                    <label class="weui-form-preview__label">处置信息</label>
                    <label class="weui-form-preview__">单号:<% ="<font class='tag'/>"+_workorder_f %></label>
                </div>
            </div>
            <div class="weui-form-preview__bd">
                <asp:Repeater runat="server" ID="listBx_deal">
                    <ItemTemplate>
                        <div class="weui-mark-vip">
                            <span class="weui-mark-lt"></span>
                        </div>
                        <div class="weui-form-preview__item" style="display:none;">
                            <label class="weui-form-preview__label">num</label>
                            <span class="weui-form-preview__value"><%# Eval("num") %></span>
                        </div>
                        <div class="weui-form-preview__item" style="border-top:1px solid #e5e5e5">
                            <label class="weui-form-preview__label">处置数量</label>
                            <span class="weui-form-preview__value"><%# Eval("cz_qty") %></span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">剩余数量</label>
                            <span class="weui-form-preview__value"><%# Eval("sy_qty") %></span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">判断为</label>
                            <span class="weui-form-preview__value"><%# Eval("result") %></span>
                        </div>
                        <div class="weui-form-preview__item" style="display:<%# Eval("result").ToString()=="不合格"?"block":"none"%>; ">
                            <label class="weui-form-preview__label">废品原因</label>
                            <span class="weui-form-preview__value"><%# Eval("reason") %></span>
                        </div>
                       <%-- <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">原因说明</label>
                            <span class="weui-form-preview__value"><%# Eval("comment") %></span>
                        </div>--%>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">返工说明</label></div>
                <textarea id="comment" class="weui-textarea"  placeholder="请输入返工说明" rows="2"  runat="server" value='<%# Eval("comment") %>'></textarea>
            </div>
            <div class="weui-cell">
                <asp:Button ID="btn_sign" class="weui-btn weui-btn_primary" runat="server" Text="确认"  OnClientClick="return valid();" />
                 <asp:Button ID="btn_cancel" class="weui-btn weui-btn_primary" runat="server" Text="退回"/>
            </div>
            
        </div>

    
    </form>
    <script type="text/javascript">
        var datalist_reason;
        $.ajax({
            type: "post",
            url: "bhgp_deal_new.aspx/init_rs",
            data: "{'domain': '" + $("#domain").val() + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
            success: function (data) {
                var obj = eval(data.d);
                datalist_reason = obj[0].json_reason;
            }
        });

        init_data();

        function init_data() {
            $("#UpdatePanel1 input[name*=sy_qty]").attr("readonly", "readonly");

            $("#UpdatePanel1 input[name*=cz_qty]").change(function () {
                var result = $("#sy_qty").val();//总数量
                $("#UpdatePanel1").find("input[id*=cz_qty]").each(function () {
                    var cz_qty = $(this).val();
                    result = result - cz_qty;
                    $(this).parent().next().find("input[id*=sy_qty]").val(result);
                });
            });

            $("#UpdatePanel1 input[name*=result]").select({
                title: "判断为",
                items: [{ title: '合格', value: '合格' }, { title: '不合格', value: '不合格' }
                    , { title: '让步合格', value: '让步合格' }, { title: '返工', value: '返工' }],
                onChange: function (d) {
                    //alert(d.values);
                    //if (d.values == "不合格") {
                    //    this.parent().next().hide();
                    //} else {

                    //}
                },
                onClose: function (d) {
                    //var obj = eval(d.data);
                    //alert(obj.values);

                },
                onOpen: function () {
                    //  console.log("open");
                }
            });

           
            $("#UpdatePanel1").find("input[id*=result]").each(function () {
                if ($(this).val() == "不合格") {
                    $(this).parent().next().show();
                } else {
                    $(this).parent().next().hide();
                }
            });

            $("#UpdatePanel1 input[name*=result]").change(function () {
                if ($(this).val() == "不合格") {
                    $(this).parent().next().show();
                    $(this).parent().next().find("input[name*=reason]").val("");
                } else {
                    $(this).parent().next().hide();
                    $(this).parent().next().find("input[name*=reason]").val("");
                }

            });
            
            $("#UpdatePanel1 input[name*=reason]").select({
                title: "废品原因",
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
                }
            });
        }
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {

            init_data();

        });

    </script>
</body>
</html>
