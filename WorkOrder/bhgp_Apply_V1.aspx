<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bhgp_Apply_V1.aspx.cs" Inherits="bhgp_Apply_V1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>不合格处理</title>
    
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
            if ($("#workorder_qc").val() != "") {
                if ($("#workorder_qc").val().substr(0,1).toUpperCase()=="W") {
                    $("#lbl_workorder_qc").text("生产完成单号");
                } else {
                    $("#lbl_workorder_qc").text("参考号");
                }
            }

            $("#workorder").attr("readonly", "readonly");
            $("#pn").attr("readonly", "readonly");
            $("#descr").attr("readonly", "readonly");
            $("#b_use_routing").attr("readonly", "readonly");
            $("#yb_qty").attr("readonly", "readonly");
            $("#bc_qty").attr("readonly", "readonly");

            if ("<%= _ismodify %>"=="Y1") {
                $("#pgino").attr("readonly", "readonly");
                $("#op").attr("readonly", "readonly");
                $("#reason").attr("readonly", "readonly");
                $("#rscode").attr("readonly", "readonly");
            }

            if ($("#ref_order").val() == "") {
                $("#div_ref_order").hide();
                $("#lbl_ref_order").text("参考号/生产完成单号");
                $("#ref_order").val("");
            } else {
                if ($("#op").val()!="") {
                    var _op = ($("#op").val()).substr(0, ($("#op").val()).indexOf('-'));
                    if (parseInt(_op) > 700) {
                        $("#lbl_ref_order").text("参考号");
                    } else if (parseInt(_op) >= 600) {
                        $("#lbl_ref_order").text("生产完成单号");
                    }
                }
            }
            
        });

        $(function () {
            $('#t1').tab({
                defaultIndex: <%= _tab_index %>,
                activeClass: 'tab-green',
                onToggle: function (index) {
                    //console.log('index' + index);

                }
            });

            sm_workorder();
            sm_pgino();
            saomiao_workorder_gl();

            $("#qty").change(function () {
                var _qty=$("#qty").val();
                var _yb_qty=$("#yb_qty").val();
                var _bc_qty=parseInt(_qty)-parseInt(_yb_qty);
                $("#bc_qty").val(_bc_qty);
            });

            $("#rscode").change(function () {
                $.ajax({
                    type: "post",
                    url: "bhgp_Apply.aspx/rs_data",
                    data: "{'domain': '" + $("#domain").val() + "','rscode':'" + $("#rscode").val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                    success: function (data) {
                        var obj = eval(data.d);
                        if (obj[0].title == "") {
                            layer.alert("【原因代码】不存在.");
                        }
                        $("#reason").val(obj[0].title);
                    }
                });
            });                        

            $('.collapse .js-category').click(function(){
                $parent = $(this).parent('li');
                if($parent.hasClass('js-show')){
                    $parent.removeClass('js-show');
                    $(this).children('i').removeClass('icon-35').addClass('icon-74');
                }else{
                    $parent.siblings().removeClass('js-show');
                    $parent.addClass('js-show');
                    $(this).children('i').removeClass('icon-74').addClass('icon-35');
                    $parent.siblings().find('i').removeClass('icon-35').addClass('icon-74');
                }
            });

            var bg = 0;
            $("ul li").find("#dh_s").each(function () {
                if ("<%= _workorder_f %>" == $(this).text()) {
                    $(this).parent().parent().parent().siblings().removeClass('js-show');
                    $(this).parent().parent().parent().addClass('js-show');
                    $(this).parent().parent().parent().children('i').removeClass('icon-74').addClass('icon-35');
                    $(this).parent().parent().parent().siblings().find('i').removeClass('icon-35').addClass('icon-74');

                    //单号红色
                    $(this).parent().css("color", "red");
                    $(this).parent().css("font-weight", "800");

                    //处置信息
                    $(this).parent().parent().children('div').children().css("color", "red");
                    $(this).parent().parent().children('div').children().css("font-weight", "800");

                    bg = 1;
                } 
            });

            if (bg == 0 && "<%= _workorder_f %>" !="") {
                $("#sp_cz").parent().parent().parent().siblings().removeClass('js-show');
                $("#sp_cz").parent().parent().parent().addClass('js-show');
                $("#sp_cz").parent().parent().parent().children('i').removeClass('icon-74').addClass('icon-35');
                $("#sp_cz").parent().parent().parent().siblings().find('i').removeClass('icon-35').addClass('icon-74');

                //单号红色
                $("#sp_cz").parent().css("color", "red");
                $("#sp_cz").parent().css("font-weight", "800");

                //处置信息
                $("#sp_cz").parent().parent().children('div').children().css("color", "red");
                $("#sp_cz").parent().parent().children('div').children().css("font-weight", "800");
            }

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
            }else if (parseInt($("#qty").val()) <=0) {
                layer.alert("【数量】不可小于等于0.");
                return false;
            }
            if ($("#reason").val() == "") {
                layer.alert("请输入【原因名称】.");
                return false;
            } else {
                if ($("#rscode").val() != "") {
                    var _reason = ($("#reason").val()).substr(0, ($("#reason").val()).indexOf('-'));
                    if (_reason != $("#rscode").val()) {
                        layer.alert("【原因名称】与【代码】不匹配.");
                        return false;
                    }
                }
            }
            
            //当前数量 小于 之前 报的数量，需要提示
            if (parseInt($("#qty").val())<parseInt($("#yb_qty").val())) {
                //$.confirm('【数量】' + $("#qty").val() + '小于【已报不合格数量】'+$("#yb_qty").val()+',确定要提交吗？', function () {
                //    //点击确认后的回调函数
                //    return true;
                //}, function () {
                //    //点击取消后的回调函数
                //    return false;
                //});
                
                return confirm('【数量】' + $("#qty").val() + '小于【已报不合格数量】'+$("#yb_qty").val()+',确定要提交吗？');
            }else {
                return true;
            }

           
            //return true;
        }

        //====================================two=============================
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
                    处置
                </div>
            </div>
            <div class="weui-tab__panel">
                 <%--=======申请-----%>
                <div id="tab1" class="weui-tab__content">

                    <div class="weui-cells weui-cells_form" style="display:<%= _tab_index==0?"block":"none"%>;">     
                        <div class="weui-cell">
                            <div class="weui-cell__hd f-red "><label class="weui-label">单号</label></div>
                            <div class="weui-cell__bd">
                                <span style="float:left; width:90%">
                                    <asp:TextBox ID="workorder" class="weui-input" style="color:gray" runat="server"></asp:TextBox>
                                </span>
                                <span style="float:left; width:10%">
                                    <img id="img_sm_workorder" src="../img/fdj2.png" style="display:none;"/>
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
                        <div class="weui-cell" style="font-size:12px;color:gray;">
                          <div class="weui-flex__item">已报不合格数量
                               <asp:TextBox ID="yb_qty" class="weui-input" runat="server" style="color:gray;width:20%; border-bottom:1px solid #e5e5e5; text-align:center;" ></asp:TextBox>
                          </div>
                          <div class="weui-flex__item">本次不合格数量
                               <asp:TextBox ID="bc_qty" class="weui-input" runat="server" style="color:gray;width:20%; border-bottom:1px solid #e5e5e5; text-align:center;" ></asp:TextBox>
                          </div>
                        </div>
                        <div class="weui-cell">
                            <div class="weui-cell__hd f-red "><label class="weui-label">原因名称</label></div>
                            <input class="weui-input" id="rscode" type="text" value=""  runat="server" placeholder="原因代码" style="width:40%; border-bottom:1px solid #e5e5e5;" />
                            <asp:TextBox ID="reason" class="weui-input" style="color:gray;" runat="server"></asp:TextBox>                            
                        </div>
                        <div class="weui-cell">
                            <div class="weui-cell__hd"><label class="weui-label">说明</label></div>
                            <textarea id="comment" class="weui-textarea"  placeholder="请输入说明" rows="3"  runat="server"></textarea>
                        </div>
                        <div class="weui-cell">
                            <asp:Button ID="btnsave" class="weui-btn weui-btn_primary" runat="server" UseSubmitBehavior="false"
                                Text="提交" OnClick="btnsave_Click" OnClientClick="if(!valid()){return false;}this.disabled=false;this.value='处理中…';" /><%--OnClientClick="return valid();"--%>
                        </div>
                    </div>
                    
                    <div class="weui-form-preview" style="display:<%= _tab_index==1?"block":"none"%>;">
                        <div class="weui-form-preview__hd">
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">申请信息</label>
                                <label class="weui-form-preview__">单号:<% = _workorder %></label>
                            </div>
                        </div>
                        <div class="weui-form-preview__bd">
                            <asp:Repeater runat="server" ID="listBxInfo" OnItemDataBound="listBxInfo_ItemDataBound">
                                <ItemTemplate>
                                    <div class="weui-mark-vip">
                                        <span class="weui-mark-lt <%# Eval("type").ToString()=="部分"?"bg-red":""%>"><%#Eval("type") %></span>
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
                                    <div class="weui-form-preview__item" style="display:<%# Eval("workorder_qc").ToString()!=""?"block":"none"%>; ">
                                        <label class="weui-form-preview__label" id="lbl_workorder_qc"></label>
                                        <span class="weui-form-preview__value"><%# Eval("workorder_qc") %></span>
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

                </div>
                 <%--=======申请&处置-----%>
                <div id="tab2" class="weui-tab__content">
                    
                    <div class="weui-form-preview">
                        <asp:TextBox ID="workorder_f" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                        <asp:TextBox ID="cur_qty" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                        <asp:TextBox ID="ng_reason_main" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                        <asp:TextBox ID="ng_reason_desc_main" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                        <asp:TextBox ID="workorder_qc" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>


                        <ul class="collapse" style="display:<%= ViewState["dt1"].ToString()!="0"?"block":"none"%>;">
                            <li id="li_cz_one">
                                <div class="weui-flex js-category"   style="border-top:1px solid #e5e5e5">
                                    <div class="weui-flex__item" >
                                        <label class="weui-form-preview__label">处置</label>
                                    </div>
                                    <label class="weui-form-preview__label">
                                        <span id="sp_cz"></span>
                                    </label>
                                    <i class="icon icon-74"></i>
                                </div>
                                <div class="page-category js-categoryInner">
                                    <div class="weui-cells page-category-content">
                                        <div class="weui-form-preview__bd">
                                            <asp:Repeater runat="server" ID="Repeater_cz_one" OnItemDataBound="Repeater_cz_one_ItemDataBound">
                                                <ItemTemplate>
                                                    <div class="weui-form-preview__item"style="display:none;">
                                                        <label class="weui-form-preview__label">分单号</label>
                                                        <span class="weui-form-preview__value"><%# Eval("workorder_f") %></span>
                                                    </div>
                                                    <asp:Repeater runat="server" ID="Repeater_cz_one_dt">
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
                                                                <span class="weui-form-preview__value"><%# Eval("qty") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">判断为</label>
                                                                <span class="weui-form-preview__value"><%# Eval("result") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item" style="display:<%# Eval("result").ToString()=="不合格"?"block":"none"%>; ">
                                                                <label class="weui-form-preview__label">废品原因</label>
                                                                <span class="weui-form-preview__value"><%# Eval("reason_code")+""+Eval("reason") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">关联单号</label>
                                                                <span class="weui-form-preview__value"><%# Eval("workorder_gl") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">原因说明</label>
                                                                <span class="weui-form-preview__value"><%# Eval("comment") %></span>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">处置人</label>
                                                        <span class="weui-form-preview__value"><%# Eval("phone") %><%# Eval("emp_name") %></span>
                                                    </div> 
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">处置时间</label>
                                                        <span class="weui-form-preview__value">
                                                            <%# Eval("create_date","{0:yyyy-MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                                                        </span>
                                                    </div> 
                                                    <asp:Repeater runat="server" ID="Repeater_sg_one_dt">
                                                        <ItemTemplate>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label"><%# Eval("sign_stepname") %></label>
                                                                <span class="weui-form-preview__value"><%# Eval("phone")+""+Eval("sign_empname") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">签核时间</label>
                                                                <span class="weui-form-preview__value">
                                                                    <%# Eval("sign_time","{0:yyyy-MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                                                                </span>
                                                            </div> 
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">签核意见</label>
                                                                <span class="weui-form-preview__value"><%# Eval("sign_comment") %></span>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>  
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">处置结果</label>
                                                        <span class="weui-form-preview__value"><%# "<font class='f-red'>"+Eval("status_desc")+"</font>" %></span>
                                                    </div>                                           
                                                </ItemTemplate>
                                            </asp:Repeater>   
                                        </div>
                                    </div>
                                </div>                            
                            </li>
                        </ul>

                        <ul class="collapse" style="display:<%= ViewState["dt2"].ToString()!="0"?"block":"none"%>;">
                            <asp:Repeater runat="server" ID="Repeater_fg" OnItemDataBound="Repeater_fg_ItemDataBound">
                                <ItemTemplate>
                                    <li>
                                        <div class="weui-flex js-category"  style="border-top:1px solid #e5e5e5">
                                            <div class="weui-flex__item" >
                                                <label class="weui-form-preview__label">返工</label>
                                            </div>
                                            <label class="weui-form-preview__label">
                                                <span id="dh_s"><%# Eval("workorder_f")%></span>
                                                <span style="display:<%# Eval("workorder_f_a").ToString()!=""?"block":"none"%>;"><%# ">"+Eval("workorder_f_a")%></span>
                                            </label>
                                            <i class="icon icon-74"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells page-category-content">
                                                <div class="weui-form-preview__bd">
                                                    <asp:Repeater runat="server" ID="Repeater_fg_dt">
                                                        <ItemTemplate>
                                                            <div class="weui-mark-vip">
                                                                <span class="weui-mark-lt"></span>
                                                            </div>
                                                            <div class="weui-form-preview__item" style="display:none;">
                                                                <label class="weui-form-preview__label">num</label>
                                                                <span class="weui-form-preview__value"><%# Eval("num") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">处置数量</label>
                                                                <span class="weui-form-preview__value"><%# Eval("qty") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">判断为</label>
                                                                <span class="weui-form-preview__value"><%# Eval("result") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item" style="display:<%# Eval("result").ToString()=="不合格"?"block":"none"%>; ">
                                                                <label class="weui-form-preview__label">废品原因</label>
                                                                <span class="weui-form-preview__value"><%# Eval("reason_code")+""+Eval("reason") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">关联单号</label>
                                                                <span class="weui-form-preview__value"><%# Eval("workorder_gl") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">原因说明</label>
                                                                <span class="weui-form-preview__value"><%# Eval("comment") %></span>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">处置人</label>
                                                        <span class="weui-form-preview__value"><%# Eval("phone") %><%# Eval("emp_name") %></span>
                                                    </div> 
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">处置时间</label>
                                                        <span class="weui-form-preview__value">
                                                            <%# Eval("create_date","{0:yyyy-MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                                                        </span>
                                                    </div> 
                                                    <asp:Repeater runat="server" ID="Repeater_fg_sg_dt">
                                                        <ItemTemplate>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label"><%# Eval("sign_stepname") %></label>
                                                                <span class="weui-form-preview__value"><%# Eval("phone")+""+Eval("sign_empname") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">签核时间</label>
                                                                <span class="weui-form-preview__value">
                                                                    <%# Eval("sign_time","{0:yyyy-MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                                                                </span>
                                                            </div> 
                                                        </ItemTemplate>
                                                    </asp:Repeater>  
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">返工说明</label>
                                                        <span class="weui-form-preview__value"><%# Eval("fg_comment") %></span>
                                                    </div>
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">处置结果</label>
                                                        <span class="weui-form-preview__value"><%# "<font class='f-red'>"+Eval("status_desc")+"</font>" %></span>
                                                    </div>  
                                                </div>
                                            </div>
                                        </div>    
                                    </li>                                        
                                </ItemTemplate>
                            </asp:Repeater> 
                        </ul>

                        <ul class="collapse" style="display:<%= ViewState["dt3"].ToString()!="0"?"block":"none"%>;">
                            <asp:Repeater runat="server" ID="Repeater_cz_again" OnItemDataBound="Repeater_cz_again_ItemDataBound">
                                <ItemTemplate>
                                    <li>
                                        <div class="weui-flex js-category"  style="border-top:1px solid #e5e5e5">
                                            <div class="weui-flex__item" >
                                                <label class="weui-form-preview__label">处置</label>
                                            </div>
                                            <label class="weui-form-preview__label"><span id="dh_s"><%# Eval("workorder_f")%></span><%# ">"+Eval("workorder_f_a")%></label>
                                            <i class="icon icon-74"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells page-category-content">
                                                <div class="weui-form-preview__bd">
                                                    <asp:Repeater runat="server" ID="Repeater_cz_again_dt">
                                                        <ItemTemplate>
                                                            <div class="weui-mark-vip">
                                                                <span class="weui-mark-lt"></span>
                                                            </div>
                                                            <div class="weui-form-preview__item" style="display:none;">
                                                                <label class="weui-form-preview__label">num</label>
                                                                <span class="weui-form-preview__value"><%# Eval("num") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">处置数量</label>
                                                                <span class="weui-form-preview__value"><%# Eval("qty") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">判断为</label>
                                                                <span class="weui-form-preview__value"><%# Eval("result") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item" style="display:<%# Eval("result").ToString()=="不合格"?"block":"none"%>; ">
                                                                <label class="weui-form-preview__label">废品原因</label>
                                                                <span class="weui-form-preview__value"><%# Eval("reason_code")+""+Eval("reason") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">关联单号</label>
                                                                <span class="weui-form-preview__value"><%# Eval("workorder_gl") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">原因说明</label>
                                                                <span class="weui-form-preview__value"><%# Eval("comment") %></span>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">处置人</label>
                                                        <span class="weui-form-preview__value"><%# Eval("phone") %><%# Eval("emp_name") %></span>
                                                    </div> 
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">处置时间</label>
                                                        <span class="weui-form-preview__value">
                                                            <%# Eval("create_date","{0:yyyy-MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                                                        </span>
                                                    </div> 
                                                    <asp:Repeater runat="server" ID="Repeater_sg_again_dt">
                                                        <ItemTemplate>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label"><%# Eval("sign_stepname") %></label>
                                                                <span class="weui-form-preview__value"><%# Eval("phone")+""+Eval("sign_empname") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">签核时间</label>
                                                                <span class="weui-form-preview__value">
                                                                    <%# Eval("sign_time","{0:yyyy-MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                                                                </span>
                                                            </div> 
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">签核意见</label>
                                                                <span class="weui-form-preview__value"><%# Eval("sign_comment") %></span>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>  
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">处置结果</label>
                                                        <span class="weui-form-preview__value"><%# "<font class='f-red'>"+Eval("status_desc")+"</font>" %></span>
                                                    </div>  
                                                </div>
                                            </div>
                                        </div>    
                                    </li>                                        
                                </ItemTemplate>
                            </asp:Repeater> 
                        </ul>

                        <ul class="collapse" style="display:<%= ViewState["dt4"].ToString()!="0"?"block":"none"%>;">
                        <asp:Repeater runat="server" ID="Repeater_fx" OnItemDataBound="Repeater_fx_ItemDataBound">
                            <ItemTemplate>
                                <li>
                                    <div class="weui-flex js-category"  style="border-top:1px solid #e5e5e5">
                                        <div class="weui-flex__item" >
                                            <label class="weui-form-preview__label">分选</label>
                                        </div>
                                        <label class="weui-form-preview__label">
                                            <span id="dh_s"><%# Eval("workorder_f")%></span>
                                            <span style="display:<%# Eval("workorder_f_a").ToString()!=""?"block":"none"%>;"><%# ">"+Eval("workorder_f_a")%></span>
                                        </label>
                                        <i class="icon icon-74"></i>
                                    </div>
                                    <div class="page-category js-categoryInner">
                                        <div class="weui-cells page-category-content">
                                            <div class="weui-form-preview__bd">
                                                <asp:Repeater runat="server" ID="Repeater_fx_dt">
                                                    <ItemTemplate>
                                                        <div class="weui-mark-vip">
                                                            <span class="weui-mark-lt"></span>
                                                        </div>
                                                        <div class="weui-form-preview__item" style="display:none;">
                                                            <label class="weui-form-preview__label">num</label>
                                                            <span class="weui-form-preview__value"><%# Eval("num") %></span>
                                                        </div>
                                                        <div class="weui-form-preview__item">
                                                            <label class="weui-form-preview__label">处置数量</label>
                                                            <span class="weui-form-preview__value"><%# Eval("qty") %></span>
                                                        </div>
                                                        <div class="weui-form-preview__item">
                                                            <label class="weui-form-preview__label">判断为</label>
                                                            <span class="weui-form-preview__value"><%# Eval("result") %></span>
                                                        </div>
                                                        <div class="weui-form-preview__item" style="display:<%# Eval("result").ToString()=="不合格"?"block":"none"%>; ">
                                                            <label class="weui-form-preview__label">废品原因</label>
                                                            <span class="weui-form-preview__value"><%# Eval("reason_code")+""+Eval("reason") %></span>
                                                        </div>
                                                        <div class="weui-form-preview__item">
                                                            <label class="weui-form-preview__label">关联单号</label>
                                                            <span class="weui-form-preview__value"><%# Eval("workorder_gl") %></span>
                                                        </div>
                                                        <div class="weui-form-preview__item">
                                                            <label class="weui-form-preview__label">原因说明</label>
                                                            <span class="weui-form-preview__value"><%# Eval("comment") %></span>
                                                        </div>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                                <div class="weui-form-preview__item">
                                                    <label class="weui-form-preview__label">处置人</label>
                                                    <span class="weui-form-preview__value"><%# Eval("phone") %><%# Eval("emp_name") %></span>
                                                </div> 
                                                <div class="weui-form-preview__item">
                                                    <label class="weui-form-preview__label">处置时间</label>
                                                    <span class="weui-form-preview__value">
                                                        <%# Eval("create_date","{0:yyyy-MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                                                    </span>
                                                </div> 
                                                <asp:Repeater runat="server" ID="Repeater_fx_sg_dt">
                                                    <ItemTemplate>
                                                        <div class="weui-form-preview__item">
                                                            <label class="weui-form-preview__label"><%# Eval("sign_stepname") %></label>
                                                            <span class="weui-form-preview__value"><%# Eval("phone")+""+Eval("sign_empname") %></span>
                                                        </div>
                                                        <div class="weui-form-preview__item">
                                                            <label class="weui-form-preview__label">签核时间</label>
                                                            <span class="weui-form-preview__value">
                                                                <%# Eval("sign_time","{0:yyyy-MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                                                            </span>
                                                        </div> 
                                                    </ItemTemplate>
                                                </asp:Repeater>  
                                                <div class="weui-form-preview__item">
                                                    <label class="weui-form-preview__label">分选说明</label>
                                                    <span class="weui-form-preview__value"><%# Eval("fg_comment") %></span>
                                                </div>
                                                <div class="weui-form-preview__item">
                                                    <label class="weui-form-preview__label">处置结果</label>
                                                    <span class="weui-form-preview__value"><%# "<font class='f-red'>"+Eval("status_desc")+"</font>" %></span>
                                                </div>  
                                            </div>
                                        </div>
                                    </div>    
                                </li>                                        
                            </ItemTemplate>
                        </asp:Repeater> 
                    </ul>

                        <ul class="collapse" style="display:<%= ViewState["dt5"].ToString()!="0"?"block":"none"%>;">
                            <asp:Repeater runat="server" ID="Repeater_cz_fx_again" OnItemDataBound="Repeater_cz_fx_again_ItemDataBound">
                                <ItemTemplate>
                                    <li>
                                        <div class="weui-flex js-category"  style="border-top:1px solid #e5e5e5">
                                            <div class="weui-flex__item" >
                                                <label class="weui-form-preview__label">处置</label>
                                            </div>
                                            <label class="weui-form-preview__label"><span id="dh_s"><%# Eval("workorder_f")%></span><%# ">"+Eval("workorder_f_a")%></label>
                                            <i class="icon icon-74"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells page-category-content">
                                                <div class="weui-form-preview__bd">
                                                    <asp:Repeater runat="server" ID="Repeater_cz_fx_again_dt">
                                                        <ItemTemplate>
                                                            <div class="weui-mark-vip">
                                                                <span class="weui-mark-lt"></span>
                                                            </div>
                                                            <div class="weui-form-preview__item" style="display:none;">
                                                                <label class="weui-form-preview__label">num</label>
                                                                <span class="weui-form-preview__value"><%# Eval("num") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">处置数量</label>
                                                                <span class="weui-form-preview__value"><%# Eval("qty") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">判断为</label>
                                                                <span class="weui-form-preview__value"><%# Eval("result") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item" style="display:<%# Eval("result").ToString()=="不合格"?"block":"none"%>; ">
                                                                <label class="weui-form-preview__label">废品原因</label>
                                                                <span class="weui-form-preview__value"><%# Eval("reason_code")+""+Eval("reason") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">关联单号</label>
                                                                <span class="weui-form-preview__value"><%# Eval("workorder_gl") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">原因说明</label>
                                                                <span class="weui-form-preview__value"><%# Eval("comment") %></span>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">处置人</label>
                                                        <span class="weui-form-preview__value"><%# Eval("phone") %><%# Eval("emp_name") %></span>
                                                    </div> 
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">处置时间</label>
                                                        <span class="weui-form-preview__value">
                                                            <%# Eval("create_date","{0:yyyy-MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                                                        </span>
                                                    </div> 
                                                    <asp:Repeater runat="server" ID="Repeater_sg_fx_again_dt">
                                                        <ItemTemplate>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label"><%# Eval("sign_stepname") %></label>
                                                                <span class="weui-form-preview__value"><%# Eval("phone")+""+Eval("sign_empname") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">签核时间</label>
                                                                <span class="weui-form-preview__value">
                                                                    <%# Eval("sign_time","{0:yyyy-MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                                                                </span>
                                                            </div> 
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">签核意见</label>
                                                                <span class="weui-form-preview__value"><%# Eval("sign_comment") %></span>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>  
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">处置结果</label>
                                                        <span class="weui-form-preview__value"><%# "<font class='f-red'>"+Eval("status_desc")+"</font>" %></span>
                                                    </div>  
                                                </div>
                                            </div>
                                        </div>    
                                    </li>                                        
                                </ItemTemplate>
                            </asp:Repeater> 
                        </ul>
  

                    </div>
                                    
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                       
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
                                    <div class="weui-cell__hd"><label class="weui-label">剩余数量</label></div>
                                    <asp:TextBox ID="sy_qty" class="weui-input" placeholder="" style="color:gray" runat="server" Text='<%# Eval("sy_qty") %>'></asp:TextBox>
                                </div>
                                <div class="weui-cell">
                                    <div class="weui-cell__hd f-red"><label class="weui-label">判断为</label></div>
                                    <asp:TextBox ID="result" class="weui-input" placeholder="" runat="server" 
                                        Text='<%# Eval("result") %>'></asp:TextBox>
                                </div>
                                <div class="weui-cell">
                                    <div class="weui-cell__hd f-red"><label class="weui-label">废品原因</label></div>
                                    <asp:TextBox ID="rscode" class="weui-input" placeholder="原因代码" runat="server" 
                                        Text='' style="width:40%; border-bottom:1px solid #e5e5e5;"></asp:TextBox>
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
                            <asp:Button ID="btn_sure" class="weui-btn weui-btn_primary" runat="server" UseSubmitBehavior="false"
                                    Text="处置" OnClientClick="this.disabled=false;this.value='处理中…';" OnClick="btn_sure_Click" />
                        </div>
                    </ContentTemplate>
                    </asp:UpdatePanel>
                                            
                </div>
            </div>
        </div>
    </form>

    <script>
        var datalist_pgino, datalist_reason;
        $.ajax({
            type: "post",
            url: "bhgp_Apply.aspx/init_pgino",
            data: "{'domain': '" + $("#domain").val() + "','workshop':'" + "<%= _workshop %>" + "','emp': '" + $("#emp_code_name").val() + "'}",
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
    </script>
    <script type="text/javascript">
        var datalist_reason_two;
        $.ajax({
            type: "post",
            url: "bhgp_Apply_V1.aspx/init_rs",
            data: "{'domain': '" + $("#domain").val() + "','workshop':'" + "<%= _workshop %>" + "'}",
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
            $("#UpdatePanel1 input[name*=sy_qty]").attr("readonly", "readonly");

             $("#UpdatePanel1 input[name*=cz_qty]").change(function () {
                var result = $("#cur_qty").val();//总数量
                $("#UpdatePanel1").find("input[id*=cz_qty]").each(function () {
                    var cz_qty = $(this).val();
                    result = result - cz_qty;
                    $(this).parent().next().find("input[id*=sy_qty]").val(result);
                    if (result == "0") {
                        //默认关联单号为 当前主单号
                        $(this).parent().parent().find("input[id*=workorder_gl]").val("<%= _workorder %>");
                    }
                });
             });

            $("#UpdatePanel1 input[name*=result]").select({
                title: "判断为",
                items: [{ title: '合格', value: '合格' }, { title: '不合格', value: '不合格' }
                    , { title: '让步合格', value: '让步合格' }, { title: '返工', value: '返工' }
                    , { title: '分选', value: '分选' }],
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
                    $(this).parent().next().find("input[name*=rscode]").val("");

                    //剩余数量为0，选择不合格时，若是主表的也是工料废 原因，直接默认
                    if ($(this).parent().parent().find("input[name*=sy_qty]").val() == "0") {
                        if ($("#ng_reason_main").val().startsWith("1") || $("#ng_reason_main").val().startsWith("3")
                            || $("#ng_reason_main").val().startsWith("5")) {
                            var res = $("#ng_reason_main").val() + "-" + $("#ng_reason_desc_main").val();
                            $(this).parent().parent().find("input[name*=reason]").val(res);
                        }
                    }

                } else {
                    $(this).parent().next().hide();
                    $(this).parent().next().find("input[name*=reason]").val("");
                    $(this).parent().next().find("input[name*=rscode]").val("");
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

            $("#UpdatePanel1 input[name*=rscode]").change(function () {
                var title = "";
                $.ajax({
                    type: "post",
                    url: "bhgp_Apply.aspx/rs_data",
                    data: "{'domain': '" + $("#domain").val() + "','rscode':'" + $(this).val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                    success: function (data) {
                        var obj = eval(data.d); 
                        if (obj[0].title == "") {
                            layer.alert("【原因代码】不存在.");
                        }
                        title = obj[0].title;
                    }
                });
                $(this).parent().find("input[name*=reason]").val(title);               
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
