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
        #div_bq .icon{
          font-size: 23px;
          line-height: 40px;
          margin: 5px 0;
          color:#18b4ed;
          -webkit-transition: font-size 0.25s ease-out 0s;
          -moz-transition: font-size 0.25s ease-out 0s;
          transition: font-size 0.25s ease-out 0s;

        }
        #div_bq_last .icon{
          font-size: 23px;
          line-height: 40px;
          margin: 5px 0;
          color:#18b4ed;
          -webkit-transition: font-size 0.25s ease-out 0s;
          -moz-transition: font-size 0.25s ease-out 0s;
          transition: font-size 0.25s ease-out 0s;

        }
        .collapse li.js-show .weui-flex {
            opacity: 1;
            color: rgb(66, 139, 202);
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
            $("#xbq_pgino").attr("readonly", "readonly");
            $("#xbq_serialno").attr("readonly", "readonly");
            $("#div_bq_last").hide();
            

            if ("<%= _dh %>" != "") {//仓库接收 扫码进来
                $('#workorder').val("<%= _dh %>");
                workorder_change();
            }
            
        });

        $(function () {
            sm_xbq();

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
        });

        function sm_xbq() {
            $('#img_sm_xbq').click(function () {
                $("#div_bq_last").hide();
                wx.ready(function () {
                    wx.scanQRCode({
                        needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                        scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                        success: function (res) {
                            var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                            // code 在这里面写上扫描二维码之后需要做的内容  
                            $('#xbq_con').val(result);
                            xbq_change(result);
                        }, cancel: function () {
                            if ($("#xbq_con").val() != "") {
                                $("#div_bq_last").show();
                            }
                        }
                    });
                });
                //var result = "P0577AA|300|003789";
                //$('#xbq_con').val(result);
                //xbq_change(result);
            });
        }

        function del_xbq() {
            $.confirm('确认要清空已扫标签吗？', function () {
                $("#div_bq_last").hide();
                $("#<%=btn_bind_data_c.ClientID%>").click(); 
            }, function () {
                //点击取消后的回调函数
            });
        }

        function modify_xbq() {
            if ($.trim($("#xbq_qty").val()) == "") {
                layer.alert("请输入【QTY】.");
                return false;
            }
            if (parseInt($("#xbq_qty").val()) <=0) {
                layer.alert("【QTY】不可小于等于0.");
                return false;
            }

            $("#<%=btn_bind_data_e.ClientID%>").click();
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

        <div class="weui-form-preview__hd" id="div_bq">
            <div class="weui-form-preview__item">
                <asp:Label ID="lbl_bq" class="weui-form-preview__label" runat="server" Text=""></asp:Label>
                <asp:TextBox ID="xbq_con" class="weui-input" style="color:gray;display:none;" runat="server"></asp:TextBox>
                <img id="img_sm_xbq" src="../img/fdj2.png"/>
                <span class="icon icon-26" onclick="del_xbq();"></span>
            </div>
        </div>
        <div class="weui-cells weui-cells_form" id="div_bq_last">   
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">标签物料号</label></div>                          
                <asp:TextBox ID="xbq_pgino" class="weui-input" style="color:gray" runat="server"></asp:TextBox>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">Serial No</label></div>                          
                <asp:TextBox ID="xbq_serialno" class="weui-input" style="color:gray" runat="server"></asp:TextBox>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd f-red "><label class="weui-label">QTY</label></div>            
                <div class="weui-cell__bd">
                    <span style="float:left; width:90%">
                        <asp:TextBox ID="xbq_qty" class="weui-input" runat="server" type='number'></asp:TextBox>
                        <asp:TextBox ID="xbq_qty_ori" class="weui-input" runat="server" type='number' style="color:gray;display:none;"></asp:TextBox>
                    </span>
                    <span style="float:left; width:10%">
                        <span class="icon icon-66" onclick="modify_xbq();"></span>
                    </span>
                </div>
            </div>
        </div>

        <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional" style="display:none;">
        <ContentTemplate>
            <asp:GridView ID="GridView1" 
                    AllowMultiColumnSorting="True" AllowPaging="True"
                    AllowSorting="True" AutoGenerateColumns="False"
                    OnPageIndexChanging="GridView1_PageIndexChanging" DataKeyNames="num"
                    runat="server" Font-Size="Small" Width="96%" style="margin-left:2%; margin-right:2%;" PageSize="5" BorderStyle="None"  BorderWidth="0"
                    CellPadding="4" ForeColor="#999999" GridLines="Horizontal">
                <FooterStyle BackColor="#CCCC99" ForeColor="#999999" />
                <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下页" PreviousPageText="上页" />
                <PagerStyle ForeColor="Black" BackColor="White" HorizontalAlign="Right" />
                <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#ffffff" Font-Bold="True" ForeColor="#999999" HorizontalAlign="Center" />

                <Columns>  
                    <asp:BoundField DataField="num" HeaderText="行" ReadOnly="True"  ItemStyle-Width="25%"/>
                    <asp:BoundField DataField="pgino" HeaderText="物料号" ReadOnly="True" ItemStyle-Width="25%" />
                    <asp:BoundField DataField="serialno" HeaderText="Serial No" ReadOnly="True" ItemStyle-Width="25%" />
                    <asp:BoundField DataField="qty" HeaderText="QTY" ReadOnly="True" ItemStyle-Width="25%" />
                </Columns>
                <SortedAscendingCellStyle BackColor="#F7F7F7" />
                <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                <SortedDescendingCellStyle BackColor="#E5E5E5" />
                <SortedDescendingHeaderStyle BackColor="#242121" />
            </asp:GridView>

            <asp:Button ID="btn_bind_data" runat="server" Text="绑定grid数据" style="display:none;" OnClick="btn_bind_data_Click"/>
            <asp:Button ID="btn_bind_data_c" runat="server" Text="清空grid数据" style="display:none;" OnClick="btn_bind_data_c_Click"/>
            <asp:Button ID="btn_bind_data_e" runat="server" Text="修改grid最后一次数据" style="display:none;" OnClick="btn_bind_data_e_Click"/>
        </ContentTemplate>
        </asp:UpdatePanel>
                   
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="weui-cell">
                    <asp:Button ID="btnsave" class="weui-btn weui-btn_primary" runat="server" 
                        Text="打印" OnClick="btnsave_Click" OnClientClick="return valid();" />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

    </div>

        <%--==============  GP12========================================--%>
        <%  int i = 0;
            foreach (System.Data.DataRow dr in dtGP12.Rows)
            {
                //if (i == 0)
                //{%>
            <div class="weui-flex" style="height:28px; padding-top:2px; padding-bottom:2px;">
                <div class="weui-flex__item margin10-l"><% =dr["title"] %></div>
                <div class="margin20-r"><% =dr["qc_dh"] %></div>
            </div>
            <div class="weui-form-preview__bd " style="border-top:1px solid #e5e5e5; border-bottom:1px solid #e5e5e5;">
                <div class="weui-form-preview__item">
                    <label class="weui-form-preview__label">项目号</label>
                    <span class="weui-form-preview__value"><%=dr["pgino"] %></span>
                </div>
                <div class="weui-form-preview__item">
                    <label class="weui-form-preview__label">零件号</label>
                    <span class="weui-form-preview__value"><%=dr["pn"] %> </span>
                </div>
                <div class="weui-form-preview__item">
                    <label class="weui-form-preview__label">已检数量</label>
                    <span class="weui-form-preview__value"><%=dr["qty"] %></span>
                </div>  
            </div>

        <% //}
            i++; %>
        <% foreach (System.Data.DataRow dr_m_ in dtGP12_m.Select("qc_dh='" + dr["qc_dh"].ToString() + "'"))
        {%>
        <ul class="collapse">
            <li class="">
                <div class="weui-flex js-category">
                    <div class="weui-flex__item"><%=dr_m_["emp_name"] +" "+ dr_m_["on_date_str"] +" 已检数:"+ dr_m_["qty"] %></div>
                    <i class="icon icon-35 padding10-l"></i>
                </div>
                <div class="page-category js-categoryInner"><%-- style="margin-left:20px"--%>
                    <div class="weui-cells page-category-content">
                         <% foreach (System.Data.DataRow dr_ in dtGP12_dtl.Select("qc_dh='" + dr["qc_dh"].ToString() + "' and emp_name='" 
                               + dr_m_["emp_name"].ToString() + "' and on_date_str='" + dr_m_["on_date_str"].ToString() + "'"))
                        {%>
                        <%--<div class="weui-form-preview__bd ">
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">物料号</label>
                                <span class="weui-form-preview__value"><%=dr_["pgino"] %>  </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">零件号</label>
                                <span class="weui-form-preview__value"><%=dr_["pn"] %>  </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">数量</label>
                                <span class="weui-form-preview__value"><%=dr_["hege_qty"] %>  </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">完成时间</label>
                                <span class="weui-form-preview__value"><%= string.Format("{0:MM-dd HH:mm}",dr_["on_date"])%> 
                                    时长:<font class="<%=dr["shichang"].ToString().Contains("-")?"f-blue":"f-red"%>"> <%=dr["shichang"].ToString() %></font>  
                                    时长:<%=dr["shichang"].ToString() %>
                                </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">检验人</label>
                                <span class="weui-form-preview__value"><%  =dr["cellphone"] %><%  =dr_["emp_name"] %> </span>
                            </div>
                        </div>--%>
                        <div class="weui-cell__bd" style="padding-left:15px;margin-bottom:5px;">
                            <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                <%= "来自"+dr_["workorder"] + ",生产完成数" + dr_["off_qty"] + ",已检数" +dr_["hege_qty"] %>
                            </span>
                            <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                <%= dr_["pgino"] + "," + dr_["pn"] %>
                            </span>
                            <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                <%= "生产完成时间"+string.Format("{0:MM-dd HH:mm}",dr_["begin_date"]) + ",时长" %> <%--+ dr_["shichang"]--%>
                                 <span class="f-blue"> <%=dr_["shichang"].ToString() %></span> 
                            </span>
                        </div>
                        <%} %>
                    </div>
                </div>
            </li>
        </ul>
        <%} %>
        <% } %>

        <%--=======终检完成========================================--%>
        <%  i = 0;
            foreach (System.Data.DataRow dr in dtQC.Rows)
            {
                //if (i == 0)
                //{%>
            <div class="weui-flex" style="height:28px; padding-top:2px; padding-bottom:2px;">
                <div class="weui-flex__item margin10-l"><% =dr["title"] %></div>
                <div class="margin20-r"><% =dr["qc_dh"] %></div>
            </div>
            <div class="weui-form-preview__bd " style="border-top:1px solid #e5e5e5; border-bottom:1px solid #e5e5e5;">
                <div class="weui-form-preview__item">
                    <label class="weui-form-preview__label">项目号</label>
                    <span class="weui-form-preview__value"><%=dr["pgino"] %></span>
                </div>
                <div class="weui-form-preview__item">
                    <label class="weui-form-preview__label">零件号</label>
                    <span class="weui-form-preview__value"><%=dr["pn"] %> </span>
                </div>
                <div class="weui-form-preview__item">
                    <label class="weui-form-preview__label">已检数量</label>
                    <span class="weui-form-preview__value"><%=dr["qty"] %></span>
                </div>  
            </div>
        

        <% //}
            i++; %>
        <% foreach (System.Data.DataRow dr_m_ in dtQC_m.Select("qc_dh='" + dr["qc_dh"].ToString() + "'"))
        {%>
        <ul class="collapse">
            <li class="">
               
                <div class="weui-flex js-category">
                    <div class="weui-flex__item"><%=dr_m_["emp_name"] +" "+ dr_m_["on_date_str"] +" 已检数:"+ dr_m_["qty"] %></div>
                    <i class="icon icon-35 padding10-l"></i>
                </div>
                <div class="page-category js-categoryInner"> <%--style="margin-left:20px"--%>
                    <div class="weui-cells page-category-content">
                        <% foreach (System.Data.DataRow dr_ in dtQC_dtl.Select("qc_dh='" + dr["qc_dh"].ToString() + "' and emp_name='" 
                               + dr_m_["emp_name"].ToString() + "' and on_date_str='" + dr_m_["on_date_str"].ToString() + "'"))
                        {%>
                       <%--<div class="weui-form-preview__bd ">
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">物料号</label>
                                <span class="weui-form-preview__value"><%=dr_["pgino"] %>  </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">零件号</label>
                                <span class="weui-form-preview__value"><%=dr_["pn"] %>  </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">数量</label>
                                <span class="weui-form-preview__value"><%=dr_["hege_qty"] %>  </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">完成时间</label>
                                <span class="weui-form-preview__value"><%= string.Format("{0:MM-dd HH:mm}",dr_["on_date"])%> 
                                    时长:<font class="<%=dr["shichang"].ToString().Contains("-")?"f-blue":"f-red"%>"> <%=dr["shichang"].ToString() %></font>  
                                    时长:<%=dr["shichang"].ToString() %>
                                </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">检验人</label>
                                <span class="weui-form-preview__value"><%  =dr["cellphone"] %><%  =dr_["emp_name"] %> </span>
                            </div>
                        </div>--%>
                        <div class="weui-cell__bd" style="padding-left:15px;margin-bottom:5px;"><%-- border-bottom:1px solid #e5e5e5;--%>
                            <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                <%= "来自"+dr_["workorder"] + ",生产完成数" + dr_["off_qty"] + ",已检数" +dr_["hege_qty"] %>
                            </span>
                            <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                <%= dr_["pgino"] + "," + dr_["pn"] %>
                            </span>
                            <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                <%= "生产完成时间"+string.Format("{0:MM-dd HH:mm}",dr_["begin_date"]) + ",时长" %><%-- + dr_["shichang"]--%>
                                <span class="f-blue"> <%=dr_["shichang"].ToString() %></span>  
                            </span>
                        </div>
                        <%} %>
                    </div>
                </div>
                
            </li>
        </ul>
        <%} %>
        <% } %>


        <%--====下料完成======================================--%>
        <%  i = 0;
            foreach (System.Data.DataRow dr in dtProd.Rows)
            {
                //if (i == 0)
                //{%>
            <div class="weui-flex" style="height:28px; padding-top:2px; padding-bottom:2px;">
                <div class="weui-flex__item margin10-l"><% =dr["title"] %></div>
                <div class="margin20-r"><% =dr["workorder"] %></div>
            </div>
            <div class="weui-form-preview__bd " style="border-top:1px solid #e5e5e5; border-bottom:1px solid #e5e5e5;">
                <div class="weui-form-preview__item">
                    <label class="weui-form-preview__label">项目号</label>
                    <span class="weui-form-preview__value"><%=dr["pgino"] %></span>
                </div>
                <div class="weui-form-preview__item">
                    <label class="weui-form-preview__label">零件号</label>
                    <span class="weui-form-preview__value"><%=dr["pn"] %> </span>
                </div>
                <div class="weui-form-preview__item">
                    <label class="weui-form-preview__label">完工数量</label>
                    <span class="weui-form-preview__value"><%=dr["qty"] %></span>
                </div>  
            </div>
        <% //}
            i++; %>
        <% foreach (System.Data.DataRow dr_m_ in dtProd_m.Select("workorder='" + dr["workorder"].ToString() + "'"))
            {%>
        <ul class="collapse">
            <li class="">                
                <div class="weui-flex js-category">
                    <div class="weui-flex__item"><%=dr_m_["emp_name"] +" "+ dr_m_["off_date_str"] +" 下料数:"+ dr_m_["qty"] %></div>
                    <i class="icon icon-35 padding10-l"></i>
                </div>                    
                <div class="page-category js-categoryInner "> <%--style="margin-left:40px"--%>
                    <div class="weui-cells page-category-content">
                        <% foreach (System.Data.DataRow dr_ in dtProd_dtl.Select("workorder='" + dr["workorder"].ToString() + "' and emp_name='" 
                               + dr_m_["emp_name"].ToString() + "' and off_date_str='" + dr_m_["off_date_str"].ToString() + "'"))
                        {%>
                        <%--<div class="weui-form-preview__bd ">
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">Lot</label>
                                <span class="weui-form-preview__value"><%=dr_["lot_no"] %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">物料号</label>
                                <span class="weui-form-preview__value"><%=dr_["sku"] %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">零件号</label>
                                <span class="weui-form-preview__value"><%=dr_["sku_descr"] %> </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">下料数量</label>
                                <span class="weui-form-preview__value"><%=dr_["par_qty"] %> -->  <%=dr_["par_qty"] %> </span>
                            </div>                            
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">下线时间</label>
                                <span class="weui-form-preview__value"><%=string.Format("{0:MM-dd HH:mm}",dr_["off_date"]) %>   
                                </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">下料人</label>
                                <span class="weui-form-preview__value"><%=dr_["emp_name"] %> </span>
                            </div>
                        </div>--%>
                        <div class="weui-cell__bd" style="padding-left:15px;margin-bottom:5px;"><%-- border-bottom:1px solid #e5e5e5;--%>
                            <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">

                                <%--<%= "Lot:"+dr_["lot_no"] + ",上料数" + dr_["qty"] + ",下料数" +dr_["off_qty"]+" --> "+dr_["par_qty"] %>--%>

                               Lot:<a href="prod_wip_detail_V1.aspx?lotno=<%=dr_["lot_no"] %>&para=N"><%= dr_["lot_no"] %></a>
                                <%= ",上料数" + dr_["qty"] + ",下料数" +dr_["off_qty"]+" --> "+dr_["par_qty"] %>

                            </span>
                            <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                <%= dr_["sku"] + "," + dr_["sku_descr"] %>
                            </span>
                            <span class="weui-form-preview__value" style="color:#999999;font-size: smaller;line-height:2">
                                <%= "上料时间"+string.Format("{0:MM-dd HH:mm}",dr_["on_date"]) + ",时长" %> <%--+ dr_["shichang"]--%>
                                <span class="f-blue"> <%=dr_["shichang"].ToString() %></span>  
                            </span>
                        </div>
                        <%} %>
                    </div>
                </div>               
            </li>
        </ul> 
        <%} %>

        <% } %>

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
