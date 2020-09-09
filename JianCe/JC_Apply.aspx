<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JC_Apply.aspx.cs" Inherits="JC_Apply" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>检测</title>

    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <script src="/Content/layer/layer.js"></script>

    <link href="/css/weui.css" rel="stylesheet" />
    <link href="/css/weuix.css" rel="stylesheet" />
    <script src="/js/zepto.min.js"></script>
    <script src="/js/zepto.weui.js"></script>
    <link href="/css/multiple-select.css" rel="stylesheet" />
    <script src="/js/multiple-select.js"></script>
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
        .weui-cells:after{
            border:none;
        }
        .weui-form-preview:after{
            border:none;
        }
        #div_op .weui-cell:before{
            border-top:none;
        }
        #div_op .weui-cells:before{
            border-top:none;
        }
    </style>
    <script>
        $(document).ready(function () {
            $("#txt_ljh").attr("readonly", "readonly"); $("#txt_line").attr("readonly", "readonly"); $("#txt_workshop").attr("readonly", "readonly");

        });

        $(function () {
            $('#checkedLevel').multipleSelect({
                height: "100px", //宽度
                addTitle: true, //鼠标点悬停在下拉框时是否显示被选中的值
                selectAll: false, //是否显示全部复选框，默认显示
                name: "检测内容",
                selectAllText: "选择全部", //选择全部的复选框的text值
                allSelected: "全部", //全部选中后显示的值
                //delimiter: ', ', //多个值直接的间隔符，默认是逗号
                placeholder: "检测内容" //不选择时下拉框显示的内容
            });


            sm_dh();
            sm_lot();
            sm_prod_machine();

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
            
            $("#btn_zancun").click(function () {
                $("#btn_zancun").attr("disabled", "disabled");
                $("#btn_zancun").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');
                $("#btn_apply").attr("disabled", "disabled");
                $("#btn_apply").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');

                if(!valid("zancun")){
                    $("#btn_zancun").removeAttr("disabled");
                    $("#btn_zancun").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                    $("#btn_apply").removeAttr("disabled");
                    $("#btn_apply").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                    return false;
                }

                var selectValue = "";
                $("#checkedLevel").find("option:selected").each(function () {
                    selectValue += $(this).text() + ","
                });
                if (selectValue != "") { selectValue = selectValue.substr(0, selectValue.length - 1); }


                $.ajax({
                    type: "post",
                    url: "JC_Apply.aspx/save",
                    data: "{'_option':'zancun','_emp_code_name':'" + $('#emp_code_name').val() + "','_id':'" + $('#id').val()
                        + "','_dh':'" + $('#txt_dh').val() + "','_source_lot':'" + $('#txt_source_lot').val() + "','_xmh':'" + $('#txt_xmh').val()
                        + "','_ljh':'" + $('#txt_ljh').val() + "','_line':'" + $('#txt_line').val() + "','_workshop':'" + $('#txt_workshop').val()
                        + "','_sj_type':'" + $('#txt_sj_type').val() + "','_op':'" + $('#txt_op').val() + "','_prod_machine':'" + $('#txt_prod_machine').val()
                        + "','_sj_qty':'" + $('#txt_sj_qty').val() + "','_jcnr':'" + selectValue + "','_remark':'" + $('#txt_remark').val()
                        + "'}",
                        //+ "','_dh':'" + $('#dh').val() + "','_stepid':'" + $('#stepid').val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                    success: function (data) {
                        var obj = eval(data.d);
                        if (obj[0].flag=="Y") {
                            layer.alert(obj[0].msg);
                            $("#btn_zancun").removeAttr("disabled");
                            $("#btn_zancun").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                            $("#btn_apply").removeAttr("disabled");
                            $("#btn_apply").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                            return false;
                        }

                        window.location.href = "/JianCe/JiaJu_Monitor.aspx";
                    }

                });
            });

            $("#btn_apply").click(function () {
                $("#btn_zancun").attr("disabled", "disabled");
                $("#btn_zancun").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');
                $("#btn_apply").attr("disabled", "disabled");
                $("#btn_apply").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');

                if (!valid("apply")) {
                    $("#btn_zancun").removeAttr("disabled");
                    $("#btn_zancun").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                    $("#btn_apply").removeAttr("disabled");
                    $("#btn_apply").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                    return false;
                }

                var selectValue = "";
                $("#checkedLevel").find("option:selected").each(function () {
                    selectValue += $(this).text() + ","
                });
                if (selectValue != "") { selectValue = selectValue.substr(0, selectValue.length - 1); }


                $.ajax({
                    type: "post",
                    url: "JC_Apply.aspx/save",
                    data: "{'_option':'apply','_emp_code_name':'" + $('#emp_code_name').val() + "','_id':'" + $('#id').val()
                        + "','_dh':'" + $('#txt_dh').val() + "','_source_lot':'" + $('#txt_source_lot').val() + "','_xmh':'" + $('#txt_xmh').val()
                        + "','_ljh':'" + $('#txt_ljh').val() + "','_line':'" + $('#txt_line').val() + "','_workshop':'" + $('#txt_workshop').val()
                        + "','_sj_type':'" + $('#txt_sj_type').val() + "','_op':'" + $('#txt_op').val() + "','_prod_machine':'" + $('#txt_prod_machine').val()
                        + "','_sj_qty':'" + $('#txt_sj_qty').val() + "','_jcnr':'" + selectValue + "','_remark':'" + $('#txt_remark').val()
                        + "'}",
                        //+ "','_dh':'" + $('#dh').val() + "','_stepid':'" + $('#stepid').val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                    success: function (data) {
                        var obj = eval(data.d);
                        if (obj[0].flag == "Y") {
                            layer.alert(obj[0].msg);
                            $("#btn_zancun").removeAttr("disabled");
                            $("#btn_zancun").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                            $("#btn_apply").removeAttr("disabled");
                            $("#btn_apply").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                            return false;
                        }

                        window.location.href = "/JianCe/JiaJu_Monitor.aspx";
                    }

                });
            });

            $("#btn_sign_0").click(function () {
                $("#btn_sign_0").attr("disabled", "disabled");
                $("#btn_sign_0").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');

                //if (!valid_sgin("zancun")) {
                //    $("#btn_sign_0").removeAttr("disabled");
                //    $("#btn_sign_0").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                //    return false;
                //}


                $.ajax({
                    type: "post",
                    url: "JC_Apply.aspx/sign_0",
                    data: "{'_emp_code_name':'" + $('#emp_code_name').val() + "','_id':'" + $('#id').val()
                        + "','_dh':'" + $('#dh').val() + "','_stepid':'" + $('#stepid').val() + "'}",
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

                        window.location.href = "/JianCe/JiaJu_Monitor.aspx";
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
                            $('#txt_dh').val(result);
                            dh_change();
                        }
                    });
                });
            });
        }

        function dh_change() {
            var result = $('#txt_dh').val();
            var bj = result.toUpperCase().substring(0, 1).toUpperCase();
            if (bj != "C" || result.length != 8) {
                layer.alert("【检测单号】" + result + "必须是C开头，长度为8位.");
                $('#txt_dh').val("");
                return;
            }
        }

        function sm_lot() {
            $('#img_sm_lot').click(function () {
                wx.ready(function () {
                    wx.scanQRCode({
                        needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                        scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                        success: function (res) {
                            var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                            // code 在这里面写上扫描二维码之后需要做的内容
                            $('#txt_source_lot').val(result);
                            lot_change();
                        }
                    });
                });
            });
        }

        function lot_change() {
            $.ajax({
                type: "post",
                url: "Jiaju_Apply.aspx/sb_change",
                data: "{'lot':'" + $('#txt_source_lot').val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    var obj = eval(data.d);
                    if (obj[0].e_code == "") {
                        layer.alert("【来源于Lot】" + $('#txt_source_lot').val() + "不存在.");
                    }
                    $("#txt_xmh").val(obj[0].xmh);
                    $("#txt_ljh").val(obj[0].ljh);
                    $("#txt_workshop").val(obj[0].workshop);
                    $("#txt_line").val(obj[0].line);
                }

            });
        }

        function pgino_change(pgino) {
            $.ajax({
                type: "post",
                url: "JC_Apply.aspx/pgino_change",
                data: "{'pgino':'" + $("#txt_xmh").val() + "','sj_type':'" + $("#txt_sj_type").val() + "','domain': '" + $("#domain").val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    var obj = eval(data.d);

                    $("#txt_ljh").val(obj[0].ljh);
                    $("#txt_line").val(obj[0].line);
                    $("#txt_workshop").val(obj[0].workshop);

                    var json_op = obj[0].json_op;
                    $("#txt_op").select("update", { items: json_op });
                    $('#txt_op').val('');
                    $("select[id='checkedLevel']").multipleSelect('setSelects', []);

                    if (json_op.length == 1) {
                        $('#txt_op').val(json_op[0].title);
                        op_change();
                    }


                }

            });
        }

        function op_change() {
            $.ajax({
                type: "post",
                url: "JC_Apply.aspx/op_change",
                data: "{'pgino':'" + $("#txt_xmh").val() + "','sj_type':'" + $("#txt_sj_type").val() + "','op':'" + $("#txt_op").val() + "','domain': '" + $("#domain").val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    var obj = eval(data.d);

                    var json_op = obj[0].json_jcnr;
                    //$('#txt_jcnr').val('');
                    $("select[id='checkedLevel']").multipleSelect('setSelects', []);

                    // 设置默认选中
                    var arrayObj = new Array();　//创建一个数组 
                    $.each(json_op, function (index, item) {
                        arrayObj.push(item.jcsd);
                    });
                   
                    $("select[id='checkedLevel']").multipleSelect('setSelects', arrayObj);
                }

            });
        }

        function sm_prod_machine() {
            $('#img_sm_prod_machine').click(function () {
                wx.ready(function () {
                    wx.scanQRCode({
                        needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                        scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                        success: function (res) {
                            var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                            // code 在这里面写上扫描二维码之后需要做的内容
                            $('#txt_prod_machine').val(result);
                        }
                    });
                });
            });
        }

        function valid(para) {
            if ($("#txt_xmh").val() == "") {
                layer.alert("请输入【项目号】.");
                return false;
            }
            if ($("#txt_sj_type").val() == "") {
                layer.alert("请输入【送检类别】.");
                return false;
            }
            if ($("#txt_op").val() == "") {
                layer.alert("请输入【工序】.");
                return false;
            }
            if ($("#txt_prod_machine").val() == "") {
                layer.alert("请输入【生产设备】.");
                return false;
            }
            if ($.trim($("#txt_sj_qty").val()) == "" || $.trim($("#txt_sj_qty").val()) == "0") {
                layer.alert("请输入【送检数量】.");
                return false;
            } else if (parseFloat($("#txt_sj_qty").val()) <= 0) {
                layer.alert("【送检数量】不可小于等于0.");
                return false;
            }

            var selectValue = "";
            $("#checkedLevel").find("option:selected").each(function () {
                selectValue += $(this).text() + ","
            });
            if (selectValue != "") { selectValue = selectValue.substr(0, selectValue.length - 1); }
            if (selectValue=="") {
                layer.alert("请勾选【检测内容】.");
                return false;
            }

            if (para == "apply") {
                if ($("#txt_dh").val() == "") {
                    layer.alert("请输入【检测单号】.");
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
        <asp:TextBox ID="domain" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="display:none;"></asp:TextBox>
        <asp:TextBox ID="id" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="display:none;"></asp:TextBox>
        <asp:TextBox ID="dh" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="display:none;"></asp:TextBox>
        <asp:TextBox ID="stepid" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="display:none;"></asp:TextBox>
        
        <div class="weui-cells weui-cells_form" style="display:<%= (_stepid=="" || _stepid=="0")?"":"none"%>;"> 
            <div class="weui-cell">
                <div class="weui-cell__hd f-red"><label class="weui-label">检测单号</label></div> 
                <asp:TextBox ID="txt_dh" class="weui-input" runat="server" placeholder="检测单号"  onkeyup="this.value=this.value.toUpperCase()" onchange="dh_change()"></asp:TextBox> 
                <img id="img_sm_dh" src="/img/fdj2.png" />                                                     
            </div>    
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">来源于Lot</label></div> 
                <asp:TextBox ID="txt_source_lot" class="weui-input" runat="server" placeholder="Lot" onkeyup="this.value=this.value.toUpperCase()" onchange="lot_change()"></asp:TextBox> 
                <img id="img_sm_lot" src="/img/fdj2.png" />                                                     
            </div>    
            <div class="weui-cell">
                <div class="weui-cell__hd f-red"><label class="weui-label">项目号</label></div>
                <asp:TextBox ID="txt_xmh" class="weui-input" style="color:gray;width:55%; border-bottom:1px solid #e5e5e5;" runat="server" placeholder="项目号" ></asp:TextBox>    
                <asp:TextBox ID="txt_ljh" class="weui-input" style="color:gray;font-size:13px;" runat="server"></asp:TextBox> 
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">生产线</label></div> 
                <asp:TextBox ID="txt_line" class="weui-input" style="color:gray;font-size:13px;" runat="server"></asp:TextBox>                                                    
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">车间</label></div> 
                <asp:TextBox ID="txt_workshop" class="weui-input" style="color:gray;font-size:13px;" runat="server"></asp:TextBox>                                                    
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd f-red"><label class="weui-label">送检类别</label></div>
                <asp:TextBox ID="txt_sj_type" class="weui-input" style="color:gray;" runat="server" placeholder="送检类别" ></asp:TextBox>  
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd f-red"><label class="weui-label">工序</label></div>
                <asp:TextBox ID="txt_op" class="weui-input" style="color:gray;" runat="server" placeholder="工序" ></asp:TextBox>  
            </div>  
            <div class="weui-cell">
                <div class="weui-cell__hd f-red"><label class="weui-label">生产设备</label></div> 
                <asp:TextBox ID="txt_prod_machine" class="weui-input" runat="server" placeholder="生产设备"></asp:TextBox> 
                <img id="img_sm_prod_machine" src="/img/fdj2.png" />                                                     
            </div> 
            <div class="weui-cell">
                <div class="weui-cell__hd f-red"><label class="weui-label">送检数量</label></div> 
                <asp:TextBox ID="txt_sj_qty" class="weui-input" runat="server" placeholder="送检数量"></asp:TextBox>      
            </div>  
            <div class="weui-cell weui-flex">
                <div class="weui-cell__hd f-red"><label class="weui-label">优先级</label></div>
                <div class="weui-flex__item weui-cells_radio">
                    <label class="weui-cell weui-check__label" for="x11">
                        <div class="weui-cell__bd">
                            <p>紧急</p>
                        </div>
                        <div class="weui-cell__ft">
                            <input type="radio" class="weui-check" name="priority" id="x11">
                            <span class="weui-icon-checked"></span>
                        </div>
                        </label>
                    <label class="weui-cell weui-check__label" for="x12">

                    <div class="weui-cell__bd">
                        <p>一般</p>
                    </div>
                    <div class="weui-cell__ft">
                        <input type="radio" class="weui-check" name="priority" id="x12" checked="checked">
                        <span class="weui-icon-checked"></span>
                    </div>
                    </label>
                </div> 
            </div>    
            <div class="weui-cell weui-flex">
                <div class="weui-cell__hd f-red"><label class="weui-label">检测内容</label></div> 
                <div class="weui-flex__item ">
                    <select id='checkedLevel' multiple="multiple"></select>
                </div>
                 
            </div>

            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">说明</label></div>
                <textarea id="txt_remark" class="weui-textarea"  placeholder="请输入说明" rows="3"  runat="server"></textarea>
            </div>
            <div class="weui-cell">
                <input id="btn_zancun" type="button" value="暂存" class="weui-btn weui-btn_primary" />
                <input id="btn_apply" type="button" value="申请" class="weui-btn weui-btn_primary" style="margin-left:10px;"  />
            </div>
        </div>
        
        <div id="div_op">

        </div>
    </form>
    <script>
        if ("<%= _dh %>" == "") {
            var datalist_pgino, datalist_sj_type, datalist_jcnr;
            $.ajax({
                type: "post",
                url: "JC_Apply.aspx/init_data_js",
                data: "{'domain': '" + $("#domain").val()+ "','emp': '" + $("#emp_code_name").val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    var obj = eval(data.d);
                    datalist_pgino = obj[0].json_pgino;
                    datalist_sj_type = obj[0].json_sj_type;
                    datalist_jcnr = obj[0].json_jcnr;

                    $.each(datalist_jcnr, function (index, item) {
                        $("#checkedLevel").append("<option value='" + item.jcitem + "'>" + item.jcitem_desc + "</option>");
                    });
                }
            });

            

            $("#txt_xmh").select({
                title: "物料号",
                items: datalist_pgino,
                onChange: function (d) {
                    //alert(d.values);
                    $("#txt_ljh").val(d.values);
                    pgino_change();
                },
                onClose: function (d) {
                    //var obj = eval(d.data);
                    //alert(obj.values);

                },
                onOpen: function () {
                    //  console.log("open");
                }
            });

            $("#txt_sj_type").select({
                title: "送检类别",
                items: datalist_sj_type,
                onChange: function (d) {
                    //alert(d.values);
                    $("#txt_ljh").val(d.values);
                    pgino_change();
                },
                onClose: function (d) {
                    //var obj = eval(d.data);
                    //alert(obj.values);

                },
                onOpen: function () {
                    //  console.log("open");
                }
            });
            $("#txt_op").select({
                title: "工序",
                items: [{ title: '', value: '' }],
                onChange: function (d) {
                    //alert(d.values);
                    op_change();
                },
                onClose: function (d) {
                    //var obj = eval(d.data);
                    //alert(obj.values);

                },
                onOpen: function () {
                    //  console.log("open");
                }
            });

        } else {

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
