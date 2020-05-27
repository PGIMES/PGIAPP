<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Ruku_Print.aspx.cs" Inherits="WorkOrder_Ruku_Print" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>生成入库单</title>
    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <script src="/Content/layer/layer.js"></script>

    <link href="../css/weui.css" rel="stylesheet" />
    <link href="../css/weuix.css" rel="stylesheet" />
    <script src="../js/zepto.min.js"></script>
    <script src="../js/zepto.weui.js"></script>
    <style>
        #UpdatePanel2 .weui-table td, .weui-table th, table td, table th{
            border:none;
        }
    </style>
    <script>
        $(document).ready(function () {
            $("#dh").attr("readonly", "readonly");
            $("#workorder").attr("readonly", "readonly");
            $("#domain").attr("readonly", "readonly");
            $("#pgino").attr("readonly", "readonly");
            $("#pn").attr("readonly", "readonly");
            $("#qty").attr("readonly", "readonly");

            $("#xbq_con").attr("readonly", "readonly");
            

            if ("<%= _dh %>" != "") {//仓库接收 扫码进来
                $('#workorder').val("<%= _dh %>");
                workorder_change();
            }
            
        });

        $(function () {
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
            sm_xbq();
        });

        function sm_xbq() {
            $('#img_sm_xbq').click(function () {
                wx.ready(function () {
                    wx.scanQRCode({
                        needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                        scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                        success: function (res) {
                            var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                            // code 在这里面写上扫描二维码之后需要做的内容  
                            $('#xbq_con').val(result);
                            xbq_change(result);
                        }
                    });
                });
                //var result = "P0577AA|300|003789";
                //$('#xbq_con').val(result);
                //xbq_change(result);
            });
        }

        function xbq_change() {
            if ($("#xbq_con").val() == "") {
                layer.alert('【标签】不可为空');
                return;
            }
            $("#<%=btn_bind_data.ClientID%>").click();
        }

        function workorder_change() {
            $("#domain").val('');
            $("#pgino").val('');
            $("#pn").val('');
            $('#qty').val('');
            $('#act_qty').val('');

            $.ajax({
                type: "post",
                url: "Ruku_Print.aspx/workorder_change",
                data: "{'workorder':'" + $('#workorder').val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    var obj = eval(data.d);

                    if (obj[0].flag == "Y") {
                        layer.alert(obj[0].msg);
                    }
                    $("#domain").val(obj[0].domain);
                    $("#pgino").val(obj[0].pgino);
                    $("#pn").val(obj[0].pn);
                    $('#qty').val(obj[0].qty);
                    $('#act_qty').val(obj[0].qty);
                }

            });
        }

        function valid() {
            if ($.trim($("#qty").val()) == "" || $.trim($("#qty").val()) == "0") {
                layer.alert("请输入【数量】.");
                return false;
            }
            if ($.trim($("#act_qty").val()) == "" || $.trim($("#act_qty").val()) == "0") {
                layer.alert("请输入【接收数量】.");
                return false;
            }
            if (parseInt($("#act_qty").val()) > parseInt($("#qty").val())) {
                layer.alert("【接收数量】不可大于【数量】.");
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
    <div class="weui-cells weui-cells_form">
        
        <asp:TextBox ID="emp_code_name" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="display:none;"></asp:TextBox>
        <div class="weui-cells weui-cells_form">   
            <div class="weui-cell">
                <div class="weui-cell__hd f-red "><label class="weui-label">入库单号</label></div>
                <asp:TextBox ID="dh" class="weui-input" placeholder="系统自动生成" style="color:gray" runat="server"></asp:TextBox>                
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd f-red "><label class="weui-label">来源单号</label></div>
                <asp:TextBox ID="workorder" class="weui-input" style="color:gray" runat="server"></asp:TextBox>                
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">物料号</label></div>              
                <asp:TextBox ID="pgino" class="weui-input" style="color:gray" runat="server"></asp:TextBox>
                <asp:TextBox ID="domain" class="weui-input" style="color:gray;display:none;" runat="server"></asp:TextBox>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">零件号</label></div>                          
                <asp:TextBox ID="pn" class="weui-input" style="color:gray" runat="server"></asp:TextBox>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">交付数量</label></div>
                <asp:TextBox ID="qty" class="weui-input" type='number' placeholder="" style="color:gray" runat="server"></asp:TextBox>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd f-red "><label class="weui-label">接收数量</label></div>
                <asp:TextBox ID="act_qty" class="weui-input" type='number' placeholder="请输入接收数量" runat="server"></asp:TextBox>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">说明</label></div>
                <textarea id="comment" class="weui-textarea"  placeholder="请输入说明" rows="3"  runat="server"></textarea>
            </div>
        </div>

        <ul class="collapse">
            <li id="li_cz_one">
                <div class="weui-flex js-category">
                    <div class="weui-flex__item" >
                        <label class="weui-form-preview__label">标签</label>
                    </div>
                    <label class="weui-form-preview__label">
                        <span id="sp_cz"></span>
                    </label>
                    <i class="icon icon-74"></i>
                </div>
                <div class="page-category js-categoryInner">
                    <div class="weui-cells page-category-content">

                        <div class="weui-cells weui-cells_form">
                            <div class="weui-cell">
                                <div class="weui-cell__hd"><label class="weui-label">扫码</label></div>  
                                <span style="float:left; width:90%">
                                    <asp:TextBox ID="xbq_con" class="weui-input" style="color:gray;" runat="server"></asp:TextBox>
                                </span>
                                <span style="float:left; width:10%;">
                                    <img id="img_sm_xbq" src="../img/fdj2.png" style="padding-top:10px;"/>
                                </span>                     
                            </div>

                            <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:GridView ID="GridView1" 
                                        AllowMultiColumnSorting="True" AllowPaging="True"
                                        AllowSorting="True" AutoGenerateColumns="False"
                                        OnPageIndexChanging="GridView1_PageIndexChanging" OnRowDeleting="GridView1_RowDeleting" DataKeyNames="num"
                                        runat="server" Font-Size="Small" Width="96%" style="margin-left:2%; margin-right:2%;" PageSize="5" BorderStyle="None"  BorderWidth="0"
                                        CellPadding="4" ForeColor="#999999" GridLines="Horizontal">
                                    <FooterStyle BackColor="#CCCC99" ForeColor="#999999" />
                                    <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下页" PreviousPageText="上页" />
                                    <PagerStyle ForeColor="Black" BackColor="White" HorizontalAlign="Right" />
                                    <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#ffffff" Font-Bold="True" ForeColor="#999999" HorizontalAlign="Center" />

                                    <Columns>  
                                        <asp:BoundField DataField="num" HeaderText="行" ReadOnly="True"  ItemStyle-Width="15%"/>
                                        <asp:BoundField DataField="pgino" HeaderText="物料号" ReadOnly="True" ItemStyle-Width="25%" />
                                        <asp:BoundField DataField="serialno" HeaderText="Serial No" ReadOnly="True" ItemStyle-Width="25%" />
                                        <asp:BoundField DataField="qty" HeaderText="QTY" ReadOnly="True" ItemStyle-Width="20%" />
                                        <asp:CommandField HeaderText="" ShowDeleteButton="True" ItemStyle-Width="15%" />
                                    </Columns>
                                    <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                    <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                                    <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                    <SortedDescendingHeaderStyle BackColor="#242121" />
                                </asp:GridView>

                                <asp:Button ID="btn_bind_data" runat="server" Text="绑定grid数据" style="display:none;" OnClick="btn_bind_data_Click"/>
                            </ContentTemplate>
                            </asp:UpdatePanel>

                        </div>

                    </div>
                </div>                            
            </li>
        </ul>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="weui-cell">
                    <asp:Button ID="btnsave" class="weui-btn weui-btn_primary" runat="server" 
                        Text="打印" OnClick="btnsave_Click" OnClientClick="return valid();" />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    </form>
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
