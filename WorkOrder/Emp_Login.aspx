<%@ Page Language="C#" Title="" AutoEventWireup="true" CodeFile="Emp_Login.aspx.cs" Inherits="Emp_Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>员工上下岗操作</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no"/>

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
            padding-right:25px;
        }        
        .textwidth2{
            padding-right:40px;
        }
        
        #cbl_position label{
            font-weight:normal;
        }
        
    </style>
</head>
<body>

    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <%--步骤二：通过config接口注入权限验证配置--%>
    <script>        
        //config注入的是企业的身份与权限
        <%--$('#e_code').val('<% =WeiXin.CorpID %>' + " " + '<% = timestamp %>' + " " + '<% = noncestr   %>' + " " + '<%= ent_signature %>' + " " + '<%= uri %>');
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
                        $('#e_code').val(result);
                        $('#e_code').change();
                        
                    }
                });
            };//end_document_scanQRCode
        });--%>
        $(document).ready(function () {
            if ($("#btn_sure").val() == "离岗确认") {
                $("#div_code").hide();
            }
            $("#e_code").change(function () {
               
                document.getElementById("btn_bind_data").click();
                
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
                    <div style="float:left;width:80%;border:0px solid #F00;">PGI产线作业-员工上下岗操作</div> 
                    <div style="float:left;width:18%;border:0px solid #000; text-align:right;"></div> 
                </dt> 
         
            </dl>
        </div> --%>

        
        <div class="row ">
            <div class="col-md-12">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
            
                <div class="input-group rowbr">
                    <span class="input-group-addon textwidth2">登入人</span>
                    <asp:TextBox ID="txt_emp" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                    <asp:TextBox ID="domain" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server" Visible="false"></asp:TextBox>
                </div>

                <div id="div_code" class="input-group rowbr">
                    <span class="input-group-addon textwidth1">当前设备</span>
                    <span style="float:left; width:90%">
                        <asp:TextBox ID="e_code" class="form-control" Style="max-width: 100%" runat="server"></asp:TextBox> 
                    </span>
                    <span style="float:left; width:10%">
                        <img id="img_sm" src="../img/fdj.gif" style="padding-top:10px;" />
                        <asp:Button ID="btn_bind_data" runat="server" Text="绑定grid数据"  OnClick="btn_bind_data_Click" Visible="false"/>
                    </span>
                </div>
                当前岗位：
                <asp:GridView ID="GridView1" 
                        AllowMultiColumnSorting="True" AllowPaging="True"
                        AllowSorting="True" AutoGenerateColumns="False"
                        OnPageIndexChanging="GridView1_PageIndexChanging" OnRowDeleting="GridView1_RowDeleting" DataKeyNames="id"
                        runat="server" Font-Size="Small" Width="96%" style="margin-left:2%; margin-right:2%;" PageSize="5">
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <PagerSettings FirstPageText="首页" LastPageText="尾页"
                            Mode="NextPreviousFirstLast" NextPageText="下页" PreviousPageText="上页" />
                        <PagerStyle ForeColor="Red" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <EditRowStyle BackColor="#999999" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <HeaderStyle BackColor="#428bca" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />

                        <Columns>  
                            <asp:BoundField DataField="id" HeaderText="id" ReadOnly="True" />
                            <asp:BoundField DataField="e_code" HeaderText="设备号" ReadOnly="True" ItemStyle-Width="20%">
                                <HeaderStyle Wrap="True" />
                            </asp:BoundField> 
                            <asp:BoundField DataField="location" HeaderText="岗位" ReadOnly="True" ItemStyle-Width="65%">
                                <HeaderStyle Wrap="True" />
                            </asp:BoundField> 
                            <asp:CommandField HeaderText="删除" ShowDeleteButton="True" ItemStyle-Width="15%"/>
                        </Columns>
                    </asp:GridView>

            </ContentTemplate>
            </asp:UpdatePanel>

            <div class="">
                    <asp:Button ID="btn_sure" class="btn btn-primary btn-lg btn-block" BackColor="#428bca" style="padding:10px 16px" runat="server" Text="上岗确认" 
                        OnClick="btn_sure_Click"/>
            </div>
            
           
            </div>
        </div>
       
    </div>
    </form>
</body>
</html>
