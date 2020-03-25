<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SL.aspx.cs" Inherits="WorkOrder_SL" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title></title>

    <link href="/Content/bootstrap.min.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <script src="/Content/laydate/laydate.js"></script>
    <script src="/Content/layer/layer.js"></script>

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
            padding-right:53px;
        }        
        .textwidth2{
            padding-right:40px;
        }
        .textwidth3{
            padding-right:67px;
        } 
        .textwidth4{
            padding-right:25px;
        } 
        .textwidth5{
            padding-right:53px;
        } 
        
        
    </style>
     <script>
         function valid_sl() {
            
             if ($("#lot_no").attr("readonly")) {
                 layer.alert("已送料，不可再次送料.");
                 return false;
             } else {
                 if ($("#lot_no").val() == "") {
                     layer.alert("请输入【Lot No】.");
                     return false;
                 }
                 if ($("#act_qty").val() == "") {
                     layer.alert("请输入【数量】.");
                     return false;
                 }
             }
             return true;
         }

         function valid_cancel() {
             if ($("#need_qty").val() == $("#act_qty").val()) {
                 layer.alert("已经全部送料完成，不可取消要料.");
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
        $('#lot_no').val('<% =WeiXin.CorpID %>' + " " + '<% = timestamp %>' + " " + '<% = noncestr   %>' + " " + '<%= ent_signature %>' + " " + '<%= uri %>');
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
                        $('#lot_no').val(result);
                        $('#lot_no').change();
                        
                    }
                });
            };//end_document_scanQRCode
        });

        $(document).ready(function () {
            if ($("#lot_no").val() != "") { $("#lot_no").attr("readonly", "readonly"); }

            $("#act_qty").attr("readonly", "readonly");

            $("#lot_no").change(function () {
                $.ajax({
                    type: "post",
                    url: "SL.aspx/lotno_change",
                    data: "{'pgino':'" + $("#pgino").val() + "','lotno':'" + $("#lot_no").val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                    success: function (data) {
                        var obj = eval(data.d);
                        var flag = obj[0].flag;
                        if (flag == "Y") {
                            layer.alert(obj[0].msg);
                            $('#lot_no').val("");
                            $('#act_qty').val("");
                        } else {
                            $('#act_qty').val(obj[0].qty);
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
            <dl class="menus-module" style="background-color:#008083;height:66px;"> 
                
                <dt class="menus-title" style="background-color:#008083;height:66px">
                    <div  style="float:left;width:80%;border:0px solid #F00;">PGI产线作业-仓库送料</div> 
                    <div style="float:left;width:18%;border:0px solid #000; text-align:right;"><%--<a href="/workorder/bhgp_deal_list.aspx"><img src="/img/home.png" width="22px" height="22px" style="text-align:right;"></a>--%></div> 
                </dt> 

         
            </dl>
        </div> 

        <div class="row ">
            <div class="col-md-12">
                <asp:TextBox ID="emp_code_name" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server" Visible="false"></asp:TextBox>

                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth1">要料人</span>
                    <asp:TextBox ID="yl_emp" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                </div>

                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth4">要料人时间</span>
                    <asp:TextBox ID="req_date" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                </div>

                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth3">车间</span>
                    <asp:TextBox ID="workshop" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                </div>

                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth1">生产线</span>
                    <asp:TextBox ID="line" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                </div>

                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth3">岗位</span>
                    <asp:TextBox ID="location" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                </div>

                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth1">物料号</span>
                    <asp:TextBox ID="pgino" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                </div>

                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth1">零件号</span>
                    <asp:TextBox ID="pn" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                </div>

                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth2">要料数量</span>
                    <asp:TextBox ID="need_qty" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                </div>

                <div class="input-group rowbr">
                    <span class="input-group-addon">要求送到时间</span>
                    <asp:TextBox ID="need_date" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                    <asp:TextBox ID="need_no" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server" Visible="false"></asp:TextBox>
                </div>

                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth5">Lot No</span>
                    <span style="float:left; width:90%">
                        <asp:TextBox ID="lot_no" class="form-control" Style="max-width: 100%" runat="server"></asp:TextBox>
                    </span>
                        <span style="float:left; width:10%">
                            <img id="img_sm" src="../img/fdj.gif" style="padding-top:10px;" />
                    </span>
                </div>

                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth2">送料数量</span>
                    <asp:TextBox ID="act_qty" class="form-control" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                </div>

                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth1">送料人</span>
                    <asp:TextBox ID="emp_sl" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                </div>

                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth2">送料时间</span>
                    <asp:TextBox ID="act_date" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                </div>


                <div class="input-group-addon">
                    <asp:Button ID="btn_sl" class="btn btn-primary btn-lg" BackColor="#428bca" style="padding:10px 16px" runat="server" 
                        Text="送&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;料" OnClick="btn_sl_Click" OnClientClick="return valid_sl();" /> 
                     <asp:Button ID="btn_cancel" class="btn btn-primary btn-lg" BackColor="#428bca" style="padding:10px 16px" runat="server" 
                        Text="取消送料" OnClick="btn_cancel_Click" OnClientClick="return valid_cancel();"/>
                </div>


            </div>
        </div>

    </div>
    </form>
</body>
</html>
