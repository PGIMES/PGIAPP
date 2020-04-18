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
    <style>
        .weui-cell{
            padding:4px 15px;
        }
        #UpdatePanel1 .weui-cell:before{
            border-top:none;
        }
    </style>
    
    <script>
        $(document).ready(function () {
            $("#pn").attr("readonly", "readonly");
            $("#descr").attr("readonly", "readonly");
            $("#b_use_routing").attr("readonly", "readonly");
            $("#b_use_routing_two").attr("readonly", "readonly");

            if ($("#ref_order").val() == "") {
                $("#div_ref_order").hide();
                $("#lbl_ref_order").text("参考号/生产完成单号");
                $("#ref_order").val("");
            }
            if ($("#ref_order_two").val() == "") {
                $("#div_ref_order_two").hide();
                $("#lbl_ref_order_two").text("参考号/生产完成单号");
                $("#ref_order_two").val("");
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

            sm_workorder();
            sm_pgino();

            saomiao_workorder_two();
            saomiao_pgino_two();
            saomiao_workorder_gl();
        });

        function sm_workorder() {
            $('#img_sm_workorder').click(function () {
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

        function sm_pgino() {
            $('#img_sm_pgino').click(function () {
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
                    $('#b_use_routing').val(obj[0].b_use_routing);

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
            } else {//b_use_routing=0当作没有检验序
                if ($.trim($("#ref_order").val()) == "" && $("#b_use_routing").val() == "1") {
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

        //====================================two=============================
        function saomiao_workorder_two() {
            $('#img_sm_workorder_two').click(function () {
                wx.ready(function () {
                    wx.scanQRCode({
                        needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                        scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                        success: function (res) {
                            var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                            // code 在这里面写上扫描二维码之后需要做的内容                       
                            $('#workorder_two').val(result);
                        }
                    });
                });
            });
        }

        function saomiao_pgino_two() {
            $('#img_sm_pgino_two').click(function () {
                wx.ready(function () {
                    wx.scanQRCode({
                        needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                        scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                        success: function (res) {
                            var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                            // code 在这里面写上扫描二维码之后需要做的内容                       
                            $('#pgino_two').val(result);
                            pgino_change_two(result);
                        }
                    });
                });
            });
        }

        function pgino_change_two(pgino) {
            $.ajax({
                type: "post",
                url: "bhgp_Apply.aspx/pgino_change",
                data: "{'pgino':'" + pgino + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    var obj = eval(data.d);
                    $('#pn_two').val(obj[0].pn);
                    $('#descr_two').val(obj[0].descr);
                    $('#b_use_routing_two').val(obj[0].b_use_routing);

                    var json_op = obj[0].json_op;
                    $("#op_two").select("update", { items: json_op });
                    $('#op_two').val('');

                    $("#div_ref_order_two").hide();
                    $("#lbl_ref_order_two").text("参考号/生产完成单号");
                    $("#ref_order_two").val("");
                }

            });
        }

        function saomiao_workorder_gl() {
            $('#UpdatePanel1 img[id*=img_sm_gl]').click(function () {
                var obj = $(this);
                wx.ready(function () {
                    wx.scanQRCode({
                        needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                        scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                        success: function (res) {
                            var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                            // code 在这里面写上扫描二维码之后需要做的内容  
                            obj.parent().parent().find("input[name*=workorder_gl]").val(result);
                        }
                    });
                });
            });
        }

        function valid_two() {
            if ($("#workorder_two").val() == "") {
                layer.alert("请输入【单号】.");
                return false;
            }
            if ($("#pgino_two").val() == "") {
                layer.alert("请输入【物料号】.");
                return false;
            }
            if ($("#op_two").val() == "") {
                layer.alert("请输入【工序】.");
                return false;
            } else {//b_use_routing=0当作没有检验序
                if ($.trim($("#ref_order_two").val()) == "" && $("#b_use_routing_two").val() == "1") {
                    var _op_two = ($("#op_two").val()).substr(0, ($("#op_two").val()).indexOf('-'));
                    if (parseInt(_op_two) > 700) {
                        layer.alert("请输入【参考号】.");
                        return false;
                    } else if (parseInt(_op_two) >= 600) {
                        layer.alert("请输入【生产完成单号】.");
                        return false;
                    }
                }
            }
            return true;
        }

        //====================================two=============================

    </script>
</head>
<body>    
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>   
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server">
        </asp:ScriptManager>

        <asp:TextBox ID="emp_code_name" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="display:none;"></asp:TextBox>
        <asp:TextBox ID="domain" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="display:none;"></asp:TextBox>

        <div class="weui-tab" id="t1">
            <div class="weui-navbar">
                <div href="#tab1" class="weui-navbar__item">
                    申请
                </div>
                <div href="#tab2" class="weui-navbar__item">
                    检验申请处置
                </div>
            </div>
            <div class="weui-tab__panel">
                 <%--=======申请-----%>
                <div id="tab1" class="weui-tab__content">

                    <div class="weui-cells weui-cells_form">     
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
                            <asp:TextBox ID="b_use_routing" class="weui-input" placeholder="" runat="server" style="display:none;"></asp:TextBox>
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
                 <%--=======申请&处置-----%>
                <div id="tab2" class="weui-tab__content">
                    <div class="weui-cells weui-cells_form">
                        <div class="weui-cell">
                            <div class="weui-cell__hd f-red "><label class="weui-label">单号</label></div>
                            <div class="weui-cell__bd">
                                <span style="float:left; width:90%">
                                    <asp:TextBox ID="workorder_two" class="weui-input" placeholder="请输入不合格处置单号" runat="server"></asp:TextBox>
                                </span>
                                <span style="float:left; width:10%">
                                    <img id="img_sm_workorder_two" src="../img/fdj2.png"/>
                                </span>
                            </div>
                        </div>
                        <div class="weui-cell">
                            <div class="weui-cell__hd f-red "><label class="weui-label">物料号</label></div>
                            <div class="weui-cell__bd">
                                <span style="float:left; width:90%">
                                    <asp:TextBox ID="pgino_two" class="weui-input" style="color:gray"  runat="server"></asp:TextBox>
                                </span>
                                <span style="float:left; width:10%">
                                    <img id="img_sm_pgino_two" src="../img/fdj2.png" />
                                </span>
                            </div>
                        </div>
                        <div class="weui-cell">
                            <div class="weui-cell__hd"><label class="weui-label">零件号</label></div>              
                            <asp:TextBox ID="pn_two" class="weui-input" style="color:gray" runat="server"></asp:TextBox>
                        </div>
                        <div class="weui-cell">
                            <div class="weui-cell__hd"><label class="weui-label">物料名称</label></div>                          
                            <asp:TextBox ID="descr_two" class="weui-input" style="color:gray" runat="server"></asp:TextBox>
                        </div>
                        <div class="weui-cell">
                            <div class="weui-cell__hd f-red "><label class="weui-label">工序</label></div>
                            <asp:TextBox ID="op_two" class="weui-input" style="color:gray" runat="server"></asp:TextBox>
                            <asp:TextBox ID="b_use_routing_two" class="weui-input" placeholder="" runat="server" style="display:none;"></asp:TextBox>
                        </div>
                        <div class="weui-cell" id="div_ref_order_two">
                            <div class="weui-cell__hd f-red "><label class="weui-label" id="lbl_ref_order_two"></label></div>
                            <asp:TextBox ID="ref_order_two" class="weui-input"  runat="server"></asp:TextBox>
                        </div>
                        <div class="weui-cell">
                            <div class="weui-cell__hd"><label class="weui-label">说明</label></div>
                            <textarea id="comment_two" class="weui-textarea"  placeholder="请输入说明" rows="2"  runat="server"></textarea>
                        </div>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="weui-form-preview__hd" style="border-bottom:none;border-top:1px solid #e5e5e5;line-height:1.2rem;">
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">处置</label>
                                </div>
                            </div>
                            <asp:Repeater runat="server" ID="listBx_deal">
                                <ItemTemplate>
                                    <div class="weui-cell" style="display:none;">
                                        <div class="weui-cell__hd"><label class="weui-label">num</label></div>
                                        <asp:TextBox ID="num" class="weui-input" placeholder="" style="color:gray;" runat="server" 
                                            Text='<%# Eval("num") %>'></asp:TextBox>
                                    </div>
                                    <div class="weui-cell"style="border-top:1px solid #e5e5e5;">
                                        <div class="weui-cell__hd f-red"><label class="weui-label">处置数量</label></div>
                                        <asp:TextBox ID="cz_qty" class="weui-input" placeholder="" type="number" runat="server" 
                                            Text='<%# Eval("cz_qty") %>'></asp:TextBox>
                                    </div>
                                    <div class="weui-cell">
                                        <div class="weui-cell__hd f-red"><label class="weui-label">判断为</label></div>
                                        <asp:TextBox ID="result" class="weui-input" placeholder="" runat="server" 
                                            Text='<%# Eval("result") %>'></asp:TextBox>
                                    </div>
                                    <div class="weui-cell">
                                        <div class="weui-cell__hd f-red"><label class="weui-label">废品原因</label></div>
                                        <asp:TextBox ID="reason" class="weui-input" placeholder="" runat="server" 
                                            Text='<%# Eval("reason") %>'></asp:TextBox>
                                    </div>
                                    <div class="weui-cell">
                                        <div class="weui-cell__hd f-red"><label class="weui-label">关联单号</label></div>
                                        <span style="float:left; width:90%">
                                            <asp:TextBox ID="workorder_gl" class="weui-input" placeholder="" runat="server" 
                                                Text='<%# Eval("workorder_gl") %>'></asp:TextBox>
                                        </span>
                                        <span style="float:left; width:10%;">
                                            <img id="img_sm_gl" src="../img/fdj2.png" style="padding-top:10px;"/>
                                        </span>
                                    </div>
                                    <div class="weui-cell">
                                        <div class="weui-cell__hd"><label class="weui-label">原因说明</label></div>
                                        <textarea id="comment" class="weui-textarea"  placeholder="请输入说明" rows="2"  runat="server" 
                                            value='<%# Eval("comment") %>'></textarea>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <div class="weui-cell">
                                <asp:Button ID="Button1" class="weui-btn weui-btn_mini weui-btn_primary" runat="server" Text="再加一条" OnClick="Button1_Click" />
                            </div>
                            <div class="weui-cell">
                                <asp:Button ID="btn_sure" class="weui-btn weui-btn_primary" runat="server" Text="处置"  OnClientClick="return valid();" OnClick="btn_sure_Click" />
                            </div>
                        </ContentTemplate>
                        </asp:UpdatePanel>
                        
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script>
        var datalist_pgino, datalist_reason;
        $.ajax({
            type: "post",
            url: "bhgp_Apply.aspx/init_pgino",
            data: "{'domain': '" + $("#domain").val() + "','workshop':'" + "<%= _workshop %>" + "'}",
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
        $("#pgino_two").select({
            title: "物料号",
            items: datalist_pgino,
            onChange: function (d) {
                //alert(d.values);
                pgino_change_two(d.values);
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
                if (parseInt(d.values) < 600 || $("#b_use_routing").val() == "0") {
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
        $("#op_two").select({
            title: "工序",
            items: [{ title: '', value: '' }],
            onChange: function (d) {
                //alert(d.values);
                if (parseInt(d.values) < 600 || $("#b_use_routing_two").val() == "0") {
                    $("#div_ref_order_two").hide();
                    $("#lbl_ref_order_two").text("参考号/生产完成单号");
                    $("#ref_order_two").val("");
                } else if (parseInt(d.values) >= 600 && parseInt(d.values) <= 700) {
                    $("#div_ref_order_two").show();
                    $("#lbl_ref_order_two").text("生产完成单号");
                    $("#ref_order_two").val("");
                } else if (true) {
                    $("#div_ref_order_two").show();
                    $("#lbl_ref_order_two").text("参考号");
                    $("#ref_order_two").val("");
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
    <script type="text/javascript">
        var datalist_reason_two;
        $.ajax({
            type: "post",
            url: "bhgp_deal_new.aspx/init_rs",
            data: "{'domain': '" + $("#domain").val() + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
            success: function (data) {
                var obj = eval(data.d);
                datalist_reason_two = obj[0].json_reason;
            }
        });

        init_data();

        function init_data() {
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
                items: datalist_reason_two,
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
            saomiao_workorder_gl();
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
