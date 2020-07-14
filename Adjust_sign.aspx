<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Adjust_sign.aspx.cs" Inherits="Adjust_sign" %>

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
    <script>
        $(function(){
            $("#btn_sign2").hide();
            $("#btn_cancel2").hide();

            $("#div_com").hide();

            $.ajax({
                type: "post",
                url: "Adjust_sign.aspx/init_btn",
                data: "{'stepid':'" + "<%= _stepid %>" + "','formno':'" + "<%= _formno %>" + "','emp':'" + $("#emp_code_name").val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    var obj = eval(data.d);

                    if (obj[0].btn_sure == "Y") {
                        $("#btn_sign2").show();
                    }
                    if (obj[0].btn_cancel == "Y") {
                        $("#btn_cancel2").show();
                    }
                    if (obj[0].btn_sure == "Y" || obj[0].btn_cancel == "Y") {
                        $("#div_com").show();
                    }
                    return;
                }
            });

            $("#btn_sign2").click(function () {
                $("#btn_sign2").attr("disabled", "disabled");
                $("#btn_sign2").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');

                $("#btn_cancel2").attr("disabled", "disabled");
                $("#btn_cancel2").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');

                $.ajax({
                    type: "post",
                    url: "Adjust_sign.aspx/sure2",
                    data: "{'_emp_code_name':'" + $('#emp_code_name').val()
                        + "','_formno':'" + $('#formno').val() + "','_stepid':'" + $('#stepid').val() + "','_sign_comment':'" + $('#sign_comment').val() 
                        + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                    success: function (data) {
                        var obj = eval(data.d);
                        if (obj[0].flag=="Y") {
                            layer.alert(obj[0].msg);
                            $("#btn_sign2").removeAttr("disabled");
                            $("#btn_sign2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                            $("#btn_cancel2").removeAttr("disabled");
                            $("#btn_cancel2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                            return false;
                        }
                        window.location.href = "/Adjust_list.aspx";
                        
                    }

                });
             });

            $("#btn_cancel2").click(function () {
                $("#btn_sign2").attr("disabled", "disabled");
                $("#btn_sign2").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');

                $("#btn_cancel2").attr("disabled", "disabled");
                $("#btn_cancel2").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');

                if ($.trim($('#sign_comment').val()) == "") {
                    layer.alert('【签核意见】不可为空');
                    $("#btn_sign2").removeAttr("disabled");
                    $("#btn_sign2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                    $("#btn_cancel2").removeAttr("disabled");
                    $("#btn_cancel2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                    return;
                }

                $.ajax({
                    type: "post",
                    url: "Adjust_sign.aspx/cancel2",
                    data: "{'_emp_code_name':'" + $('#emp_code_name').val() 
                        + "','_formno':'" + $('#formno').val() + "','_stepid':'" + $('#stepid').val() + "','_sign_comment':'" + $('#sign_comment').val()
                        + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                    success: function (data) {
                        var obj = eval(data.d);
                        if (obj[0].flag=="Y") {
                            layer.alert(obj[0].msg);
                            $("#btn_sign2").removeAttr("disabled");
                            $("#btn_sign2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                            $("#btn_cancel2").removeAttr("disabled");
                            $("#btn_cancel2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                            return false;
                        }
                       window.location.href = "/Adjust_list.aspx";
                        
                    }

                });
             });

        });
    </script>
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
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager runat="server">
    </asp:ScriptManager>

        <asp:TextBox ID="emp_code_name" class="form-control" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
        <asp:TextBox ID="formno" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
        <asp:TextBox ID="stepid" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>

        <div class="weui-cells weui-cells_form">

            <div class="weui-form-preview__hd">
                <div class="weui-form-preview__item">
                    <label class="weui-form-preview__label">申请信息</label>
                    <label class="weui-form-preview__">单号:<% ="<font class='tag'/>"+_formno %></label>
                </div>
            </div>
            <div class="weui-form-preview__bd">

                <asp:Repeater runat="server" ID="listBxInfo">
                    <ItemTemplate>
                        <div class="weui-mark-vip">
                            <span class="weui-mark-lt <%# Eval("adj_result").ToString()=="盘亏"?"bg-red":"bg-green"%>""><%#Eval("adj_result") %></span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">地点</label>
                            <span class="weui-form-preview__value"><%# Eval("source") %></span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">单号</label>
                            <span class="weui-form-preview__value"><%# Eval("lot_no") %></span><%--/<%# Eval("need_no") %>--%>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">物料号</label>
                            <span class="weui-form-preview__value"><%# Eval("pgino")+","+Eval("pn") %></span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">数量</label>
                            <span class="weui-form-preview__value"><%# Eval("from_qty") %></span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">盈亏数量</label>
                            <span class="weui-form-preview__value"><%# Eval("adj_qty") %></span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">说明</label>
                            <span class="weui-form-preview__value"><%# Eval("remark") %></span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">申请人</label>
                            <span class="weui-form-preview__value"><%# Eval("phone") %><%# Eval("emp_name") %></span>
                        </div> 
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">申请时间</label>
                            <span class="weui-form-preview__value">
                                <%# Eval("create_date","{0:MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                            </span>
                        </div> 
                    </ItemTemplate>
                </asp:Repeater>

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
                            <label class="weui-form-preview__label">签核意见</label>
                            <span class="weui-form-preview__value"><%# Eval("sign_comment") %></span>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

            </div>

             <div class="weui-cell" id="div_com">
                <div class="weui-cell__hd"><label class="weui-label">签核意见</label></div>
                <textarea id="sign_comment" class="weui-textarea"  placeholder="请输入签核意见" rows="2" runat="server" value=''></textarea>
            </div>
            <div class="weui-cell" >
                <input id="btn_sign2" type="button" value="确认" class="weui-btn weui-btn_primary" />
                <input id="btn_cancel2" type="button" value="退回" class="weui-btn weui-btn_primary" style="margin-left:10px;" />
            </div>

        </div>
        
    </form>
</body>
</html>
