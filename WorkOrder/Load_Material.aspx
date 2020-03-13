<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Load_Material.aspx.cs" Inherits="Load_Material" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <link href="/Content/bootstrap.min.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.10.2.min.js"></script>
    <script src="/Content/laydate/laydate.js"></script>
    <script src="/Content/layer/mobile/layer.js"></script>

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
            padding-right:37px;
        }        
        .textwidth2{
            padding-right:49px;
        }   
        .textwidth3{
            padding-right:23px;
        }  
        .textwidth4{
            padding-right:35px;
        } 
        .textwidth5{
            padding-right:35px;
        }
        .textwidth6{
            padding-right:48px;
        }
        
    </style>
    <script>
        function valid() {
           
        }
    </script>
</head>
<body>
    <%-- 步骤一：引入JS文件--%>
    <script src="../scripts/jquery-1.10.2.min.js"></script>
    
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <%--步骤二：通过config接口注入权限验证配置--%>
    <script>        
        //config注入的是企业的身份与权限
        $('#txt_lotno').val('<% =WeiXin.CorpID %>'+" "+'<% = timestamp %>'+" "+'<% = noncestr   %>' +" "+'<%= ent_signature %>'+" "+'<%= uri %>');
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
            document.querySelector('#txt_lotno').onclick = function () {
                //alert("a");
                wx.scanQRCode({
                    needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                    scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                    success: function (res) {
                        var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                        // code 在这里面写上扫描二维码之后需要做的内容                       
                        $('#txt_lotno').val(result);
                        $('#txt_lotno').change();
                        
                    }
                });
            };//end_document_scanQRCode
        });

        $(document).ready(function () {
            $("#txt_lotno").change(function () {
                $.ajax({
                    type: "post",
                    url: "Load_Material.aspx/lotno_change",
                    data: "{'pgino':'" + $("#txt_xmh").val() + "','lotno':'" + $("#txt_lotno").val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                    success: function (data) {
                        var obj = eval(data.d);
                        var flag = obj[0].flag;
                        if (flag == "Y") {
                            layer.alert(obj[0].msg, function (index) { $('#txt_lotno').val(""); })
                        } else {
                            $('#txt_wlh').val(wlh);
                            $('#txt_qty').val(qty);
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
            <div id="allContainer" class="menus-normal">
                <dl class="menus-module" style="background-color: #008083; height: 66px;">

                    <dt class="menus-title" style="background-color: #008083; height: 66px">
                        <div style="float: left; width: 80%; border: 0px solid #F00;">PGI产线作业-生产上线</div>
                        <div style="float: left; width: 18%; border: 0px solid #000; text-align: right;"><%--<a href="/Index.aspx"><img src="/img/home.png" width="22px" height="22px" style="text-align:right;"></a>--%></div>
                    </dt>


                </dl>
            </div>


            <div class="row ">
                <div class="col-md-12">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>

                            <div class="input-group rowbr">
                                <span class="input-group-addon textwidth3">当前岗位</span>
                                <asp:TextBox ID="txt_location" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                            </div>

                            <div class="input-group rowbr">
                                <span class="input-group-addon textwidth1">登入人</span>
                                <asp:TextBox ID="txt_emp" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                            </div>

                            <div class="input-group rowbr">
                                <span class="input-group-addon textwidth1">项目号</span>
                                <asp:TextBox ID="txt_xmh" class="form-control" ReadOnly="true" Style="max-width: 100%" runat="server"></asp:TextBox>
                            </div>                            

                            <div class="input-group rowbr">
                                <span class="input-group-addon textwidth3">工艺路线</span>
                                <asp:TextBox ID="txt_routing" class="form-control" ReadOnly="true" Style="max-width: 100%" runat="server"></asp:TextBox>

                            </div>

                            <div class="input-group rowbr">
                                <span class="input-group-addon textwidth2">Bom</span>
                                <asp:TextBox ID="txt_Bom" class="form-control" ReadOnly="true" Style="max-width: 100%;" runat="server"></asp:TextBox>

                            </div>

                            <div class="input-group rowbr">
                                <span class="input-group-addon textwidth4">Lot No</span>
                                <asp:TextBox ID="txt_lotno" class="form-control" Style="max-width: 100%" runat="server" AutoPostBack="True" OnTextChanged="txt_lotno_TextChanged"></asp:TextBox>
                            </div>

                            <div class="input-group rowbr">
                                <span class="input-group-addon textwidth5">物料号</span>
                                <asp:TextBox ID="txt_wlh" class="form-control" Style="max-width: 100%" runat="server" AutoPostBack="True" ReadOnly="true"></asp:TextBox>
                            </div>

                            <div class="input-group rowbr">
                                <span class="input-group-addon textwidth6">数量</span>
                                <asp:TextBox ID="txt_qty" class="form-control" ReadOnly="true" Style="max-width: 100%" runat="server"></asp:TextBox>

                            </div>

                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="">
                        <asp:Button ID="btnsave" class="btn btn-primary btn-lg btn-block" BackColor="#428bca" Style="padding: 10px 16px" runat="server" Text="上线" OnClick="btnsave_Click" OnClientClick="return valid();" />
                    </div>
                     
                    

                </div>
            </div>

        </div>
    </form>
</body>
</html>

