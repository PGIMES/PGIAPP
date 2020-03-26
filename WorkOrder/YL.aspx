<%@ Page Language="C#" AutoEventWireup="true" CodeFile="YL.aspx.cs" Inherits="YL" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>生产要料</title>

    <link href="/Content/bootstrap.min.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <script src="/Content/layer/layer.js"></script>

    <link href="../css/weui.css" rel="stylesheet" />
    <link href="../css/weuix.css" rel="stylesheet" />
    <script src="../js/zepto.min.js"></script>
    <script src="../js/zepto.weui.js"></script>

    <link href="/css/global.css?v=201802091428" rel="stylesheet" type="text/css">
    <link href="/css/iconfont.css?v=201802091429" rel="stylesheet" type="text/css">
    <link href="/css/login.css?v=201802091428" rel="stylesheet" type="text/css">
    <link href="/css/comm.css?v=201802091429" rel="stylesheet" type="text/css">
    <link href="/css/theme.css?v=201805162207" rel="stylesheet" type="text/css">
    <style>
        .rowbr{
            margin-bottom:5px;
        }
        .textwidth1{
            padding-right:25px;
        }     
        .weui-picker-modal{
            height:18rem;
        }
        .weui-picker-modal .picker-modal-inner{
            height:14.8rem
        }
        .weui-picker-modal .picker-items{
            font-size:2rem;
        }
        .toolbar{
            font-size:2rem;
        }
        .toolbar .title{
            font-size:2rem;
        }
        
    </style>
    <script>
        function valid() {
            if ($("#pgino").val() == "") {
                layer.alert("请输入【物料号】.");
                return false;
            }
            if ($.trim($("#need_qty").val()) == "" || $.trim($("#need_qty").val()) == "0") {
                layer.alert("请输入【要料数量】.");
                return false;
            }
            if ($("#need_date").val() == "") {
                layer.alert("请选择【送到时间】.");
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
        $('#pgino').val('<% =WeiXin.CorpID %>' + " " + '<% = timestamp %>' + " " + '<% = noncestr   %>' + " " + '<%= ent_signature %>' + " " + '<%= uri %>');
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
                        $('#pgino').val(result);
                        $('#pgino').change();
                        
                    }
                });
            };//end_document_scanQRCode
        });

        $(document).ready(function () {
            $("#pn").attr("readonly", "readonly");
            $("#descr").attr("readonly", "readonly");

            $("#pgino").change(function () {
                $.ajax({
                    type: "post",
                    url: "YL.aspx/pgino_change",
                    data: "{'pgino':'" + $("#pgino").val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                    success: function (data) {
                        var obj = eval(data.d);
                        var flag = obj[0].flag;
                        if (flag == "Y") {
                            layer.alert(obj[0].msg);
                            $('#pgino').val("");
                            $('#pn').val("");
                            $('#descr').val("");
                            $('#need_qty').val("");
                        } else {
                            $('#pn').val(obj[0].pn);
                            $('#descr').val(obj[0].descr);
                            $('#need_qty').val(obj[0].qty);
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
    <div class="resume-setting-page normal-page-wrap"> 
        <%--<div id="allContainer" class="menus-normal">
            <dl class="menus-module" style="background-color:#008083;height:66px;"> 
                
                <dt class="menus-title" style="background-color:#008083;height:66px">
                    <div  style="float:left;width:80%;border:0px solid #F00;">PGI产线作业-生产要料</div> 
                    <div style="float:left;width:18%;border:0px solid #000; text-align:right;"></div> 
                </dt> 

         
            </dl>
        </div> --%>

        
        <div class="row ">
            <div class="col-md-12">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                   
                    <asp:TextBox ID="emp_code_name" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server" Visible="false"></asp:TextBox>
                    <asp:TextBox ID="domain" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server" Visible="false"></asp:TextBox>
                    <div class="input-group rowbr">
                        <span class="input-group-addon textwidth1">物料号</span>
                        <span style="float:left; width:90%">
                            <asp:TextBox ID="pgino" class="form-control" placeholder="请输入物料号" Style="max-width: 100%" runat="server"></asp:TextBox>
                        </span>
                        <span style="float:left; width:10%">
                            <img id="img_sm" src="../img/fdj.gif" style="padding-top:10px;" />
                        </span>
                    </div>

                    <div class="input-group rowbr">
                        <span class="input-group-addon textwidth1" >零件号</span>                       
                        <asp:TextBox ID="pn" class="form-control" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                    </div>

                    <div class="input-group rowbr">
                        <span class="input-group-addon " >物料名称</span>                       
                        <asp:TextBox ID="descr" class="form-control" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                    </div>

                    <div class="input-group rowbr">
                        <span class="input-group-addon">要料数量</span>
                        <asp:TextBox ID="need_qty" class="form-control" type='number' placeholder="请输入要料数量" Style="max-width: 100%" runat="server"></asp:TextBox>
                    </div>
                    
                    <div class="input-group rowbr">
                        <span class="input-group-addon">送到时间</span>
                        <asp:TextBox ID="need_date" class="form-control" Style="max-width: 100%; background-color:#fff;" runat="server"></asp:TextBox>
                    </div>

                </ContentTemplate>
                </asp:UpdatePanel>  

                <div class="">
                    <asp:Button ID="btnsave" class="btn btn-primary btn-lg btn-block" BackColor="#428bca" style="padding:10px 16px" runat="server" 
                        Text="确认" OnClick="btnsave_Click" OnClientClick="return valid();" />
                </div>
            
            
            </div>
        </div>
       
    </div>
    </form>

    <script>
        $("#need_date").datetimePicker({
            title: '送到时间',
            //yearSplit: '年',
            //monthSplit: '月',
            //dateSplit: '日',
            years:[2020,2021,2022],
            times: function () {
                return [  // 自定义的时间
                    {
                        values: (function () {
                            var hours = [];
                            for (var i = 0; i < 24; i++) hours.push(i > 9 ? i : '0' + i);
                            return hours;
                        })()
                    },
                    {
                        divider: true,  // 这是一个分隔符
                        content: ':'
                    },
                    {
                        values: (function () {
                            var minutes = [];
                            for (var i = 0; i < 60; i++) minutes.push(i > 9 ? i : '0' + i);
                            return minutes;
                        })()
                    }//,
                    //{
                    //    divider: true,  // 这是一个分隔符
                    //    content: '分'
                    //}
                ];
            },
            onChange: function (picker, values, displayValues) {
                console.log(values);
            }
        });
    </script>
</body>
</html>
