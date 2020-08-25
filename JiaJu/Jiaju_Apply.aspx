<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Jiaju_Apply.aspx.cs" Inherits="Jiaju_Apply" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>换夹具</title>

    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <script src="/Content/layer/layer.js"></script>

    <link href="/css/weui.css" rel="stylesheet" />
    <link href="/css/weuix.css" rel="stylesheet" />
    <script src="/js/zepto.min.js"></script>
    <script src="/js/zepto.weui.js"></script>
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
            $("#sb_desc").attr("readonly", "readonly"); $("#line").attr("readonly", "readonly");
            $("#off_pgino").attr("readonly", "readonly"); $("#off_jiaju_name").attr("readonly", "readonly");
            $("#on_pgino").attr("readonly", "readonly"); $("#on_jiaju_name").attr("readonly", "readonly");


            if ("<%= _formno %>" != "") {
                <%-- $("#source").attr("readonly", "readonly");
                $("#dh").attr("readonly", "readonly"); $("#img_sm_dh").hide();

                if ("<%= _stepid %>" == "0001" && $('#emp_code_name').val() == $('#emp_code_name_db').val()) {
                    $("#btn_save2").show(); 
                } else {
                    $("#btn_save2").hide();

                    $("#adj_qty").attr("readonly", "readonly");
                    $("#comment").attr("readonly", "readonly");
                }--%>

            }
        });

        $(function () {
            sm_sb();

            $('.collapse .js-category').click(function () {
                $parent = $(this).parent('li');
                if ($parent.hasClass('js-show')) {
                    $parent.removeClass('js-show');
                    $(this).children('i').removeClass('icon-35').addClass('icon-74');
                } else {
                    $parent.siblings().removeClass('js-show');
                    $parent.addClass('js-show');
                    $(this).children('i').removeClass('icon-74').addClass('icon-35');
                    $parent.siblings().find('i').removeClass('icon-35').addClass('icon-74');
                }
            });
            
            $("#btn_save2").click(function(){
                $("#btn_save2").attr("disabled", "disabled");
                $("#btn_save2").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');

                if(!valid()){
                    $("#btn_save2").removeAttr("disabled");
                    $("#btn_save2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                    return false;
                }

                $.ajax({
                    type: "post",
                    url: "Jiaju_Apply.aspx/save2",
                    data: "{'_emp_code_name':'" + $('#emp_code_name').val() + "','_workshop':'" + "<%= _workshop %>"
                        + "','_sb_code':'" + $('#sb_code').val() + "','_sb_desc':'" + $('#sb_desc').val() + "','_line':'" + $('#line').val()
                        + "','_off_pgino':'" + $('#off_pgino').val() + "','_off_pn':'" + $('#off_pn').val() + "','_off_jiaju_no':'" + $('#off_jiaju_no').val() + "','_off_jiaju_name':'" + $('#off_jiaju_name').val()
                        + "','_on_pgino':'" + $('#on_pgino').val() + "','_on_pn':'" + $('#on_pn').val() + "','_on_jiaju_no':'" + $('#on_jiaju_no').val() + "','_on_jiaju_name':'" + $('#on_jiaju_name').val()
                        + "','_formno':'" + $('#formno').val() + "','_stepid':'" + $('#stepid').val() + "'}",
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

                        window.location.href = "/Cjgl1.aspx?workshop=<%=_workshop %>";
                    }

                });
            });

            $("#btn_sign_0").click(function () {
                $("#btn_sign_0").attr("disabled", "disabled");
                $("#btn_sign_0").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');

                $.ajax({
                    type: "post",
                    url: "Jiaju_Apply.aspx/sign",
                    data: "{'_emp_code_name':'" + $('#emp_code_name').val() + "','_formno':'" + $('#formno').val() + "','_stepid':'" + $('#stepid').val()
                        + "','_comment':'" + $('#comment_0').val() + "','_ng_ok':'','_type':'送检说明'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                    success: function (data) {
                        var obj = eval(data.d);
                        if (obj[0].flag == "Y") {
                            layer.alert(obj[0].msg);
                            $("#btn_sign_0").removeAttr("disabled");
                            $("#btn_sign_0").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                            return false;
                        }
                        window.location.href = "/JiaJu/jiaju_monitor.aspx?workshop=<%=_workshop %>";

                    }

                });
            });

            $("#btn_sign_1").click(function () {
                $("#btn_sign_1").attr("disabled", "disabled");
                $("#btn_sign_1").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');

                if ($("#ng_ok_1").val() == "") {
                    $("#btn_sign_1").removeAttr("disabled");
                    $("#btn_sign_1").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                    layer.alert("请输入【检测结果】.");
                    return false;
                }

                $.ajax({
                    type: "post",
                    url: "Jiaju_Apply.aspx/sign",
                    data: "{'_emp_code_name':'" + $('#emp_code_name').val() + "','_formno':'" + $('#formno').val() + "','_stepid':'" + $('#stepid').val()
                        + "','_comment':'" + $('#comment_1').val() + "','_ng_ok':'" + $('#ng_ok_1').val() + "','_type':'检测说明'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                    success: function (data) {
                        var obj = eval(data.d);
                        if (obj[0].flag == "Y") {
                            layer.alert(obj[0].msg);
                            $("#btn_sign_1").removeAttr("disabled");
                            $("#btn_sign_1").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                            return false;
                        }
                        window.location.href = "/JiaJu/jiaju_monitor.aspx?workshop=<%=_workshop %>";

                    }

                });
            });
            
            $("#btn_sign_2").click(function () {
                $("#btn_sign_2").attr("disabled", "disabled");
                $("#btn_sign_2").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');

                if ($("#ng_ok_2").val() == "") {
                    $("#btn_sign_2").removeAttr("disabled");
                    $("#btn_sign_2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                    layer.alert("请输入【完成结果】.");
                    return false;
                }

                $.ajax({
                    type: "post",
                    url: "Jiaju_Apply.aspx/sign",
                    data: "{'_emp_code_name':'" + $('#emp_code_name').val() + "','_formno':'" + $('#formno').val() + "','_stepid':'" + $('#stepid').val()
                        + "','_comment':'" + $('#comment_2').val() + "','_ng_ok':'" + $('#ng_ok_2').val() + "','_type':'换夹完成说明'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                    success: function (data) {
                        var obj = eval(data.d);
                        if (obj[0].flag == "Y") {
                            layer.alert(obj[0].msg);
                            $("#btn_sign_2").removeAttr("disabled");
                            $("#btn_sign_2").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                            return false;
                        }
                        window.location.href = "/JiaJu/jiaju_monitor.aspx?workshop=<%=_workshop %>";

                    }

                });
            });

        });

        function sm_sb() {
            $('#img_sm_sb').click(function () {
                wx.ready(function () {
                    wx.scanQRCode({
                        needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                        scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                        success: function (res) {
                            var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                            // code 在这里面写上扫描二维码之后需要做的内容  
                            $('#dh').val(result);
                            sb_change();
                        }
                    });
                });
            });
        }

        function sb_change() {
            $.ajax({
                type: "post",
                url: "Jiaju_Apply.aspx/sb_change",
                data: "{'sb_code':'" + $('#sb_code').val() + "','workshop':'" + "<%= _workshop %>" + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    var obj = eval(data.d);
                    if (obj[0].e_code == "") {
                        layer.alert("【设备】" + $('#sb_code').val() + "不存在.");
                    }
                    $("#sb_code").val(obj[0].e_code);
                    $("#sb_desc").val(obj[0].location);
                    $("#line").val(obj[0].line);

                    $("#off_pgino").val(obj[0].off_pgino);
                    $("#off_jiaju_no").val(obj[0].off_jiaju_no);
                    $("#off_jiaju_name").val(obj[0].off_jiaju_name);
                }

            });
        }
        function pgino_change(pgino, type) {
            $.ajax({
                type: "post",
                url: "Jiaju_Apply.aspx/pgino_change",
                data: "{'pgino':'" + pgino + "','domain': '" + $("#domain").val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    var obj = eval(data.d);
                    var json_jj = obj[0].json_jj;
                    if (type == "off") {
                        $("#off_jiaju_no").select("update", { items: json_jj });
                        $('#off_jiaju_no').val('');
                        $('#off_jiaju_name').val('');
                    }
                    if (type == "on") {
                        $("#on_jiaju_no").select("update", { items: json_jj });
                        $('#on_jiaju_no').val('');
                        $('#on_jiaju_name').val('');
                    }
                    
                }

            });
        }

        function valid() {
            if ($("#sb_code").val() == "") {
                layer.alert("请输入【设备】.");
                return false;
            }
            if ($("#off_pgino").val() == "") {
                layer.alert("请输入换下夹具【物料号】.");
                return false;
            }
            if ($("#off_jiaju_no").val() == "") {
                layer.alert("请输入换下夹具【夹具号】.");
                return false;
            }
            if ($("#on_pgino").val() == "") {
                layer.alert("请输入换上夹具【物料号】.");
                return false;
            }
            if ($("#on_pgino_no").val() == "") {
                layer.alert("请输入换上夹具【夹具号】.");
                return false;
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
        <asp:TextBox ID="domain" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="display:none;"></asp:TextBox>
        <asp:TextBox ID="formno" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="display:none;"></asp:TextBox>
        <asp:TextBox ID="stepid" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="display:none;"></asp:TextBox>

        <div class="weui-cells weui-cells_form" style="display:<%= _formno==""?"":"none"%>;">     
            <div class="weui-cell">
                <div class="weui-cell__hd f-red "><label class="weui-label">设备</label></div>
                <asp:TextBox ID="sb_code" class="weui-input" style="color:gray;width:40%; border-bottom:1px solid #e5e5e5;" runat="server" placeholder="设备" ></asp:TextBox>    
                <asp:TextBox ID="sb_desc" class="weui-input" style="color:gray;" runat="server"></asp:TextBox>     
                <img id="img_sm_sb" src="../img/fdj2.png" />                                               
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">生产线</label></div> 
                <asp:TextBox ID="line" class="weui-input" style="color:gray;" runat="server"></asp:TextBox>                                                    
            </div>
            <%--<div class="weui-cell weui-flex">
                <div class="weui-cell__hd weui-flex__item f-red"><label class="weui-label">换下夹具</label></div>
                <div class="weui-cell__hd weui-flex__item f-red"><label class="weui-label">夹具号</label></div>
                <div class="weui-cell__hd weui-flex__item"><label class="weui-label">名称</label></div>
            </div>
            <div class="weui-cell weui-flex">
                <div class="weui-cell__hd weui-flex__item">
                    <asp:TextBox ID="off_pgino" class="weui-input" style="color:gray;width:90%;border-bottom:1px solid #e5e5e5;"  runat="server" placeholder="物料号" ></asp:TextBox>
                </div>
                <div class="weui-cell__hd weui-flex__item">
                    <asp:TextBox ID="off_jiaju_no" class="weui-input" runat="server" style="color:gray;width:90%;border-bottom:1px solid #e5e5e5;" placeholder="夹具号" ></asp:TextBox>
                </div>
                <div class="weui-cell__hd weui-flex__item">
                    <asp:TextBox ID="off_jiaju_name" class="weui-input" style="color:gray"  runat="server"></asp:TextBox>
                </div>
            </div>--%>
            <div class="weui-cell">
                <div class="weui-cell__hd f-red"><label class="weui-label">换下夹具</label></div>
                <asp:TextBox ID="off_pgino" class="weui-input" style="color:gray;width:55%; border-bottom:1px solid #e5e5e5;" runat="server" placeholder="物料号" ></asp:TextBox>    
                <asp:TextBox ID="off_pn" class="weui-input" style="color:gray;font-size:13px;" runat="server"></asp:TextBox> 
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd f-red"><label class="weui-label"></label></div>    
                <asp:TextBox ID="off_jiaju_no" class="weui-input" style="color:gray;width:55%; border-bottom:1px solid #e5e5e5;" runat="server" placeholder="夹具号" ></asp:TextBox>    
                <asp:TextBox ID="off_jiaju_name" class="weui-input" style="color:gray;font-size:13px;" runat="server"></asp:TextBox>                                           
            </div>
            <%--<div class="weui-cell weui-flex">
                <div class="weui-cell__hd weui-flex__item f-red"><label class="weui-label">换上夹具</label></div>
                <div class="weui-cell__hd weui-flex__item f-red"><label class="weui-label">夹具号</label></div>
                <div class="weui-cell__hd weui-flex__item"><label class="weui-label">名称</label></div>
            </div>
            <div class="weui-cell weui-flex">
                <div class="weui-cell__hd weui-flex__item">
                    <asp:TextBox ID="on_pgino" class="weui-input" style="color:gray;width:90%;border-bottom:1px solid #e5e5e5;"  runat="server" placeholder="物料号" ></asp:TextBox>
                </div>
                <div class="weui-cell__hd weui-flex__item">
                    <asp:TextBox ID="on_jiaju_no" class="weui-input" runat="server" style="color:gray;width:90%;border-bottom:1px solid #e5e5e5;" placeholder="夹具号" ></asp:TextBox>
                </div>
                <div class="weui-cell__hd weui-flex__item">
                    <asp:TextBox ID="on_jiaju_name" class="weui-input" style="color:gray"  runat="server"></asp:TextBox>
                </div>
            </div>--%>
            <div class="weui-cell">
                <div class="weui-cell__hd f-red"><label class="weui-label">换上夹具</label></div>
                <asp:TextBox ID="on_pgino" class="weui-input" style="color:gray;width:55%; border-bottom:1px solid #e5e5e5;" runat="server" placeholder="物料号" ></asp:TextBox>    
                <asp:TextBox ID="on_pn" class="weui-input" style="color:gray;font-size:13px;" runat="server"></asp:TextBox> 
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd f-red"><label class="weui-label"></label></div>    
                <asp:TextBox ID="on_jiaju_no" class="weui-input" style="color:gray;width:55%; border-bottom:1px solid #e5e5e5;" runat="server" placeholder="夹具号" ></asp:TextBox>    
                <asp:TextBox ID="on_jiaju_name" class="weui-input" style="color:gray;font-size:13px;" runat="server"></asp:TextBox>                                           
            </div>

            <div class="weui-cell" style="display:<%= _formno==""?"":"none"%>;">
                <input id="btn_save2" type="button" value="提交" class="weui-btn weui-btn_primary" />
            </div>
        </div>

        <div class="weui-form-preview" style="display:<%= _formno!=""?"":"none"%>;">
            <%--<div class="weui-form-preview__hd">
                <div class="weui-form-preview__item">
                    <label class="weui-form-preview__label">换夹具信息</label>
                    <label class="weui-form-preview__">单号:<% = _formno %></label>
                </div>
            </div>
            <div class="weui-form-preview__bd">
                <asp:Repeater runat="server" ID="listBxInfo">
                    <ItemTemplate>
                        <div class="weui-mark-vip">
                            <span class="weui-mark-lt <%# Eval("status").ToString()=="0"?"bg-green":"bg-gray"%>""><%#Eval("status_desc") %></span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">生产线</label>
                            <span class="weui-form-preview__value"><%# Eval("line") %></span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">设备</label>
                            <span class="weui-form-preview__value"><%# Eval("sb_code")+","+Eval("sb_desc") %></span>
                        </div>
                        <div class="weui-form-preview__item weui-flex" style="text-align:left;">
                            <label class="weui-flex__item">换下夹具</label>
                            <label class="weui-flex__item">夹具号</label>
                            <label class="weui-flex__item">名称</label>
                        </div>
                        <div class="weui-form-preview__item weui-flex" style="text-align:left;">
                            <label class="weui-flex__item"><%# Eval("off_pgino") %></label>
                            <label class="weui-flex__item"><%# Eval("off_jiaju_no") %></label>
                            <label class="weui-flex__item"><%# Eval("off_jiaju_name") %></label>
                        </div>
                        <div class="weui-form-preview__item weui-flex" style="text-align:left;">
                            <label class="weui-flex__item">换上夹具</label>
                            <label class="weui-flex__item">夹具号</label>
                            <label class="weui-flex__item">名称</label>
                        </div>
                        <div class="weui-form-preview__item weui-flex" style="text-align:left;">
                            <label class="weui-flex__item"><%# Eval("on_pgino") %></label>
                            <label class="weui-flex__item"><%# Eval("on_jiaju_no") %></label>
                            <label class="weui-flex__item"><%# Eval("on_jiaju_name") %></label>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">换下夹具</label>
                            <span class="weui-form-preview__value"><%# Eval("off_pgino")+","+Eval("off_pn") %></span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label"></label>
                            <span class="weui-form-preview__value"><%# Eval("off_jiaju_no")+","+Eval("off_jiaju_name") %></span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">换上夹具</label>
                            <span class="weui-form-preview__value"><%# Eval("on_pgino")+","+Eval("on_pn") %></span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label"></label>
                            <span class="weui-form-preview__value"><%# Eval("on_jiaju_no")+","+Eval("on_jiaju_name") %></span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">换夹人</label>
                            <span class="weui-form-preview__value"><%# Eval("phone") %><%# Eval("emp_name") %></span>
                        </div> 
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">开始时间</label>
                            <span class="weui-form-preview__value">
                                <%# Eval("create_date","{0:MM/dd HH:mm}") %>
                            </span>
                        </div> 
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <asp:Repeater runat="server" ID="Repeater_sg">
                <ItemTemplate>
                    <div class="weui-form-preview__bd" style="border-top:1px solid #e5e5e5">
                        <div class="weui-form-preview__item" style="display:<%# Eval("ng_ok").ToString()!=""?"":"none"%>; ">
                            <label class="weui-form-preview__label"><%# Eval("type_dd") %>结果</label>
                            <span class="weui-form-preview__value"><%# Eval("ng_ok") %></span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label"><%# Eval("type_dd") %>说明</label>
                            <span class="weui-form-preview__value"><%# Eval("comment") %></span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label"><%# Eval("type_dd") %>人</label>
                            <span class="weui-form-preview__value"><%# Eval("phone")+""+Eval("emp_name") %></span>
                        </div>
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label"><%# Eval("type_dd") %>时间</label>
                            <span class="weui-form-preview__value">
                                <%# Eval("create_date","{0:MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                            </span>
                        </div> 
                    </div>
                </ItemTemplate>
            </asp:Repeater>--%>

            <ul class="collapse" >
                <li>
                    <div class="weui-flex js-category">
                        <div class="weui-flex__item" >
                            <label class="weui-form-preview__label">换夹具信息</label>
                        </div>
                        <label class="weui-form-preview__label"><% = _formno %></label>
                        <i class="icon icon-74"></i>
                    </div>
                    <div class="page-category js-categoryInner">
                        <div class="weui-cells page-category-content">
                            <div class="weui-form-preview__bd">
                                <asp:Repeater runat="server" ID="listBxInfo">
                                    <ItemTemplate>
                                        <div class="weui-form-preview__item">
                                            <label class="weui-form-preview__label">生产线</label>
                                            <span class="weui-form-preview__value"><%# Eval("line") %></span>
                                        </div>
                                        <div class="weui-form-preview__item">
                                            <label class="weui-form-preview__label">设备</label>
                                            <span class="weui-form-preview__value"><%# Eval("sb_code")+","+Eval("sb_desc") %></span>
                                        </div>
                                        <div class="weui-form-preview__item">
                                            <label class="weui-form-preview__label">换下夹具</label>
                                            <span class="weui-form-preview__value"><%# Eval("off_pgino")+","+Eval("off_pn") %></span>
                                        </div>
                                        <div class="weui-form-preview__item">
                                            <label class="weui-form-preview__label"></label>
                                            <span class="weui-form-preview__value"><%# Eval("off_jiaju_no")+","+Eval("off_jiaju_name") %></span>
                                        </div>
                                        <div class="weui-form-preview__item">
                                            <label class="weui-form-preview__label">换上夹具</label>
                                            <span class="weui-form-preview__value"><%# Eval("on_pgino")+","+Eval("on_pn") %></span>
                                        </div>
                                        <div class="weui-form-preview__item">
                                            <label class="weui-form-preview__label"></label>
                                            <span class="weui-form-preview__value"><%# Eval("on_jiaju_no")+","+Eval("on_jiaju_name") %></span>
                                        </div>
                                        <div class="weui-form-preview__item">
                                            <label class="weui-form-preview__label">换夹人</label>
                                            <span class="weui-form-preview__value"><%# Eval("phone") %><%# Eval("emp_name") %></span>
                                        </div> 
                                        <div class="weui-form-preview__item">
                                            <label class="weui-form-preview__label">开始时间</label>
                                            <span class="weui-form-preview__value">
                                                <%# Eval("create_date","{0:MM/dd HH:mm}") %>
                                            </span>
                                        </div> 
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>

            <ul class="collapse" style="display:<%= ViewState["dt_sg"].ToString()!="0"?"":"none"%>;">
                <li>
                    <div class="weui-flex js-category">
                        <div class="weui-flex__item" >
                            <label class="weui-form-preview__label">操作信息</label>
                        </div>
                        <label class="weui-form-preview__label"></label>
                        <i class="icon icon-74"></i>
                    </div>
                    <div class="page-category js-categoryInner">
                        <div class="weui-cells page-category-content">
                            <asp:Repeater runat="server" ID="Repeater_sg">
                                <ItemTemplate>
                                    <div class="weui-form-preview__bd" style="border-top:1px solid #e5e5e5">
                                        <div class="weui-form-preview__item" style="display:<%# Eval("ng_ok").ToString()!=""?"":"none"%>; ">
                                            <label class="weui-form-preview__label"><%# Eval("type_dd") %>结果</label>
                                            <span class="weui-form-preview__value"><%# Eval("ng_ok") %></span>
                                        </div>
                                        <div class="weui-form-preview__item">
                                            <label class="weui-form-preview__label"><%# Eval("type_dd") %>说明</label>
                                            <span class="weui-form-preview__value"><%# Eval("comment") %></span>
                                        </div>
                                        <div class="weui-form-preview__item">
                                            <label class="weui-form-preview__label"><%# Eval("type_dd") %>人</label>
                                            <span class="weui-form-preview__value"><%# Eval("phone")+""+Eval("emp_name") %></span>
                                        </div>
                                        <div class="weui-form-preview__item">
                                            <label class="weui-form-preview__label"><%# Eval("type_dd") %>时间</label>
                                            <span class="weui-form-preview__value">
                                                <%# Eval("create_date","{0:MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                                            </span>
                                        </div> 
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </li>
            </ul>

            
            

        </div>

        <div class="weui-cells weui-cells_form" style="display:<%= _formno!="" && _stepid=="0"?"":"none"%>;">   
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">送检说明</label></div>
                <textarea id="comment_0" class="weui-textarea"  placeholder="请输入送检说明" rows="2" runat="server" value=''></textarea>
            </div>
            <div class="weui-cell" >
                <input id="btn_sign_0" type="button" value="确认" class="weui-btn weui-btn_primary" />
            </div>
        </div>
        
        <div class="weui-cells weui-cells_form" style="display:<%= _formno!="" && _stepid=="1"?"":"none"%>;">   
            <div class="weui-cell">
                <div class="weui-cell__hd f-red "><label class="weui-label">检测结果</label></div> 
                <asp:TextBox ID="ng_ok_1" class="weui-input" style="color:gray;" runat="server" placeholder="请输入检测结果"></asp:TextBox>  
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">检测说明</label></div>
                <textarea id="comment_1" class="weui-textarea"  placeholder="请输入检测说明" rows="2" runat="server" value=''></textarea>
            </div>
            <div class="weui-cell" >
                <input id="btn_sign_1" type="button" value="确认" class="weui-btn weui-btn_primary" />
            </div>
        </div>

        <div class="weui-cells weui-cells_form" style="display:<%= _formno!="" && _stepid=="2"?"":"none"%>;">   
            <div class="weui-cell">
                <div class="weui-cell__hd f-red "><label class="weui-label">完成结果</label></div> 
                <asp:TextBox ID="ng_ok_2" class="weui-input" style="color:gray;" runat="server" placeholder="请输入完成结果"></asp:TextBox>  
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">完成说明</label></div>
                <textarea id="comment_2" class="weui-textarea"  placeholder="请输入完成说明" rows="2" runat="server" value=''></textarea>
            </div>
            <div class="weui-cell" >
                <input id="btn_sign_2" type="button" value="确认" class="weui-btn weui-btn_primary" />
            </div>
        </div>
            
    </form>
    <script>
        if ("<%= _formno %>" == "") {
            var datalist_sb, datalist_pgino;
            $.ajax({
                type: "post",
                url: "Jiaju_Apply.aspx/init_sb_pgino",
                data: "{'domain': '" + $("#domain").val() + "','workshop':'" + "<%= _workshop %>" + "','emp': '" + $("#emp_code_name").val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    var obj = eval(data.d);
                    datalist_sb = obj[0].json_sb;
                    datalist_pgino = obj[0].json_pgino;
                }
            });

            $("#sb_code").select({
                title: "设备",
                items: datalist_sb,
                onChange: function (d) {
                    //alert(d.values);
                    sb_change();
                },
                onClose: function (d) {
                    //var obj = eval(d.data);
                    //alert(obj.values);

                },
                onOpen: function () {
                    //  console.log("open");
                },

            });
        
            $("#off_pgino").select({
                title: "物料号",
                items: datalist_pgino,
                onChange: function (d) {
                    //alert(d.values);
                    $("#off_pn").val(d.values);
                    pgino_change(d.values, "off");
                },
                onClose: function (d) {
                    //var obj = eval(d.data);
                    //alert(obj.values);
                
                },
                onOpen: function () {
                    //  console.log("open");
                },

            });

            $("#off_jiaju_no").select({
                title: "夹具号",
                items: [{ title: '', value: '' }],
                onChange: function (d) {
                    //alert(d.values);
                    $("#off_jiaju_name").val(d.values);
                },
                onClose: function (d) {
                    //var obj = eval(d.data);
                    //alert(obj.values);

                },
                onOpen: function () {
                    //  console.log("open");
                },

            });

            $("#on_pgino").select({
                title: "物料号",
                items: datalist_pgino,
                onChange: function (d) {
                    //alert(d.values);
                    $("#on_pn").val(d.values);
                    pgino_change(d.values, "on");
                },
                onClose: function (d) {
                    //var obj = eval(d.data);
                    //alert(obj.values);

                },
                onOpen: function () {
                    //  console.log("open");
                },

            });

            $("#on_jiaju_no").select({
                title: "夹具号",
                items: [{ title: '', value: '' }],
                onChange: function (d) {
                    //alert(d.values);
                    $("#on_jiaju_name").val(d.values);
                },
                onClose: function (d) {
                    //var obj = eval(d.data);
                    //alert(obj.values);

                },
                onOpen: function () {
                    //  console.log("open");
                },

            });
        } else {
            var datalist_sr = [{ title: 'NG', value: 'NG' }, { title: 'OK', value: 'OK' }];

            if ("<%= _stepid %>" == "1") {
                $("#ng_ok_1").select({
                    title: "结果",
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
            }
            if ("<%= _stepid %>" == "2") {
                $("#ng_ok_2").select({
                    title: "结果",
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
            }
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
