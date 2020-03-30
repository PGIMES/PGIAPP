<%@ Page Language="C#" Title="" AutoEventWireup="true" CodeFile="Emp_Login.aspx.cs" Inherits="Emp_Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>员工上下岗操作</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no"/>

    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <script src="/Content/layer/layer.js"></script>

    <link href="../css/weui.css" rel="stylesheet" />
    <link href="../css/weuix.css" rel="stylesheet" />
    <script src="../js/zepto.min.js"></script>
    <script src="../js/zepto.weui.js"></script>
</head>
<body>

    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <%--步骤二：通过config接口注入权限验证配置--%>
    <script>        
        //config注入的是企业的身份与权限
       $('#e_code').val('<% =WeiXin.CorpID %>' + " " + '<% = timestamp %>' + " " + '<% = noncestr   %>' + " " + '<%= ent_signature %>' + " " + '<%= uri %>');
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
                        //$('#e_code').change();
                        e_code_change();
                        
                    }
                });
            };//end_document_scanQRCode
        });

        $(document).ready(function () {
            $("#btn_bind_data").css("display", "none");

            if ($("#btn_sure").val() == "离岗确认") {
                $("#div_code").hide();
            }
        });

        function e_code_change() {
            if ($("#e_code").val() == "") {
                layer.alert('【设备】不可为空');
                return;
            }
            $("#<%=btn_bind_data.ClientID%>").click();
        }
    </script>
    <form id="form1" runat="server">
    <asp:ScriptManager runat="server">
    </asp:ScriptManager>
    
        
        <div class="weui-cells weui-cells_form">     
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
            
                <asp:TextBox ID="domain" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server" Visible="false"></asp:TextBox>

                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">登入人</label></div>
                    <asp:TextBox ID="txt_emp" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="color:gray"></asp:TextBox>
                </div>

                <div id="div_code" class="weui-cell">
                    <div class="weui-cell__hd f-red"><label class="weui-label">当前设备</label></div>
                    <div class="weui-cell__bd">
                        <span style="float:left; width:90%">
                            <asp:TextBox ID="e_code" class="weui-input" runat="server" placeholder="请输入当前设备" onkeyup="this.value=this.value.toUpperCase()" onchange="e_code_change()"></asp:TextBox> 
                        </span>
                        <span style="float:left; width:10%">
                            <img id="img_sm" src="../img/fdj2.png" style="padding-top:10px;" />
                        </span>
                    </div>
                </div>
                
                <div class="weui-cell">
                    <label class="weui-label">当前岗位：</label></div>
                    <asp:GridView ID="GridView1" 
                            AllowMultiColumnSorting="True" AllowPaging="True"
                            AllowSorting="True" AutoGenerateColumns="False"
                            OnPageIndexChanging="GridView1_PageIndexChanging" OnRowDeleting="GridView1_RowDeleting" DataKeyNames="id"
                            runat="server" Font-Size="Small" Width="96%" style="margin-left:2%; margin-right:2%;" PageSize="5" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal">
                            <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                            <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下页" PreviousPageText="上页" />
                            <PagerStyle ForeColor="Black" BackColor="White" HorizontalAlign="Right" />
                            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#10aeff" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />

                            <Columns>  
                                <asp:BoundField DataField="id" HeaderText="id" ReadOnly="True" />
                                <asp:BoundField DataField="e_code" HeaderText="设备号" ReadOnly="True" ItemStyle-Width="20%">
                                    <HeaderStyle Wrap="True" />
                                <ItemStyle Width="20%" />
                                </asp:BoundField> 
                                <asp:BoundField DataField="location" HeaderText="岗位" ReadOnly="True" ItemStyle-Width="65%">
                                    <HeaderStyle Wrap="True" />
                                <ItemStyle Width="65%" />
                                </asp:BoundField> 
                                <asp:CommandField HeaderText="" ShowDeleteButton="True" ItemStyle-Width="15%" >
                                <ItemStyle Width="15%" />
                                </asp:CommandField>
                            </Columns>
                            <SortedAscendingCellStyle BackColor="#F7F7F7" />
                            <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                            <SortedDescendingCellStyle BackColor="#E5E5E5" />
                            <SortedDescendingHeaderStyle BackColor="#242121" />
                        </asp:GridView>
                    
                </div>
            </ContentTemplate>
            </asp:UpdatePanel>

            <asp:Button ID="btn_bind_data" runat="server" Text="绑定grid数据"  OnClick="btn_bind_data_Click"/>

            <div class="weui-cell">
                <asp:Button ID="btn_sure" class="weui-btn bg-blue" runat="server" Text="上岗确认" OnClick="btn_sure_Click"/>
            </div>
            
        </div>   
           
       
    
    </form>
</body>
</html>
