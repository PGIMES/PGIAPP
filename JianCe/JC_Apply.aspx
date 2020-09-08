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
            
            //$("#btn_save2").click(function(){
                
            //});

            //$("#btn_sign_0").click(function () {
            //});
            
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
                    $('#txt_jcnr').val('');

                    if (json_op.length == 1) {
                        $('#txt_op').val(json_op[0].title);
                        op_change();
                    }


                }

            });
        }

        function op_change() {

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

        function valid() {
            //if ($("#sb_code").val() == "") {
            //    layer.alert("请输入【设备】.");
            //    return false;
            //}
            //if ($("#on_pgino").val() == "") {
            //    layer.alert("请输入换上夹具【物料号】.");
            //    return false;
            //}
            //if ($("#on_pgino_no").val() == "") {
            //    layer.alert("请输入换上夹具【夹具号】.");
            //    return false;
            //}

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
            <div class="weui-cell">
                <div class="weui-cell__hd f-red"><label class="weui-label">优先级</label></div>
                <div class="weui-cells_radio">
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
            <div class="weui-cell">
                <div class="weui-cell__hd f-red"><label class="weui-label">检测内容</label></div> 
                <asp:TextBox ID="txt_jcnr" class="weui-input" runat="server" ></asp:TextBox>      
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
            var datalist_pgino, datalist_sj_type;
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
