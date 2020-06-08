<%@ Page Title="终检" Language="C#" AutoEventWireup="true" CodeFile="Quantity_Checked.aspx.cs" Inherits="WorkOrder_Quantity_Checked" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>终检</title>
    <%--<script src="/Scripts/jquery-1.10.2.min.js"></script>
    <script src="../Content/layer/layer.js"></script>--%>
    <link rel="stylesheet" href="../css/weui.css" />
    <link rel="stylesheet" href="../css/weuix.css" />
    <script src="../js/zepto.min.js"></script>
    <script src="../js/zepto.weui.js"></script>

    <style>
        .rowbr {
            margin-bottom: 5px;
        }

        .textwidth1 {
            padding-right: 25px;
        }

        .textwidth2 {
            padding-right: 40px;
        }

        .weui-btn + .weui-btn {
            margin-top: 0px;
        }

        divtable .weui-table td, .weui-table th, table td, table th {
            border: none;
        }

        .collapse li.js-show .weui-flex {
            opacity: 1;
        }

        .hidden {
            display: none;
        }
    </style>
    <script>
        function valid() {
            if ($("#txt_dh").val() == "") {
                alert("请输入生产完成单号.");
                return false;
            }
            if ($("#dh_record").val() == "") {
                alert("请输入来源单号.");
                return false;
            }
           

            if (parseFloat($("#txt_curr_qty").val()) + parseFloat($("#txt_off_qty").val()) < parseFloat($("#txt_ztsl").val())) {

                return confirm('零托,确认执行下一步吗？');
            } else {
                return true;
            }
            //if (parseFloat($("#txt_curr_qty").val()) + parseFloat($("#txt_off_qty").val()) < parseFloat($("#txt_ztsl").val())) {
            //    $.confirm('零托,确认执行下一步吗？', function () {  $('#btn_wc').click() }, function () {  })
            //}

            //return true;
        }

        function zcvalid() {
            if ($("#txt_dh").val() == "") {
                alert("请输入生产完成单号.");
                return false;
            }
            if ($("#dh_record").val() == "") {
                alert("请输入来源单号.");
                return false;
            }
            
            return true;
        }


    </script>
</head>
<body>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script>

        $(document).ready(function () {
            //$("#txt_ycqty").attr("readonly", "readonly");
            //$("#txt_qty").attr("readonly", "readonly");
            $("#txt_dh").attr("readonly", "readonly");
            sm_source();
            page_show();
           
          Bind_WorkOrder($("#txt_dh").val(), $("#source_dh").val());
           
        });
        //$(function () {
        //    $('#btnsave').click(function () {
        //        if (parseFloat($("#txt_curr_qty").val()) + parseFloat($("#txt_off_qty").val()) < parseFloat($("#txt_ztsl").val())) {
        //            $.confirm('零托,确认执行下一步吗？', function () { $('#btn_wc').click() }, function () { })
        //        }

        //    })
        //});

        function Bind_WorkOrder(workorder, sourceorder) {
           debugger
            $.ajax({
                type: "post",
                url: "Quantity_Checked.aspx/Set_Page",
                data: "{'workorder':'" + workorder + "','sourceorder':'" + sourceorder + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    if (data) {
                        $.each(eval(data.d), function (i, item) {
                             
                            
                            if (item.text == "Y") {
                                alert(item.value);
                                $("input[type='text']").val("");
                                return;
                            }
                            else {
                                $("#txt_pgino").val(item.pgino).attr("readonly", "readonly");
                                $("#txt_pn").val(item.pn).attr("readonly", "readonly");
                                $("#txt_off_qty").val(item.off_qty).attr("readonly", "readonly");
                                $("#txt_qty").val(item.pt_ord_mult);
                                $("#txt_ztsl").val(item.pt_ord_mult);
                                $("#txt_step").val(item.stepvalue);

                                $("#g2").prop("checked", item.stepvalue == "GP12" ? true : false);
                                $("#g3").prop("checked", item.stepvalue == "入库" ? true : false);
                                $("#txt_curr_qty").val(item.curr_qty).attr("readonly", "readonly");  //txt_step
                                //xmh_change();
                               // alert($("#txt_source_sum").val());
                               setvalue();
                                //if ($("#txt_source_sum").val() != "") {
                                //   // alert("m")
                                //    if (parseFloat($("#txt_source_sum").val()) < parseFloat($("#txt_qty").val())) {
                                //        $("#txt_qty").val($("#txt_source_sum").val());
                                //        $("#txt_curr_qty").val(parseFloat($("#txt_source_sum").val()) - parseFloat($("#txt_off_qty").val()));
                                //       // alert("set")
                                //    }
                                //}
                            }
                        })

                    }

                }

            });
        }

        function page_show() {
            $('.collapse .js-category').children('div').children('span').css("color", "#e0e0e0");

            $('.collapse .js-category').click(function () {
                $parent = $(this).parent('li');
                if ($parent.hasClass('js-show')) {
                    $parent.removeClass('js-show');
                    $(this).children('i').removeClass('icon-35').addClass('icon-74');

                    $(this).children('div').children('span').css("color", "#e0e0e0");//#e0e0e0
                } else {
                    $parent.siblings().removeClass('js-show');
                    $parent.addClass('js-show');
                    $(this).children('i').removeClass('icon-74').addClass('icon-35');
                    $parent.siblings().find('i').removeClass('icon-35').addClass('icon-74');

                    $(this).children('div').children('span').css("color", "#428BCA");//
                }
            });

        }

        //function setvalues()  
        //{
        //    if ($("#txt_source_sum").val() != "") {

        //        if (parseFloat($("#txt_source_sum").val()) < parseFloat($("#txt_qty").val())) {
        //            $("#txt_qty").val($("#txt_source_sum").val());
        //            $("#txt_curr_qty").val(parseFloat($("#txt_source_sum").val()) - parseFloat($("#txt_off_qty").val()));
        //           // alert("set")
        //        }
        //    }
        //}
        

        function setvalue()  
        {
            var totalRow = 0; var is_tr_row = false;

            $('#divtable table  tr').each(function (i) {
                if (i > 0) {
                    is_tr_row = true;
                    
                    $(this).children('td').each(function (j) {
                        if (j >= 2) {
                           // alert(totalRow);
                            totalRow += parseFloat($(this).text());
                          
                        }
                    });
                }
                
            });

            if (is_tr_row) {
                //alert(totalRow);
                if (parseFloat(totalRow) + parseFloat($("#txt_off_qty").val()) < parseFloat($("#txt_qty").val())) {

                    $("#txt_qty").val(totalRow + parseFloat($("#txt_off_qty").val()));
                    $("#txt_curr_qty").val(totalRow);
                }
                else
                {
                    $("#txt_qty").val($("#txt_ztsl").val());
                    $("#txt_curr_qty").val(parseFloat($("#txt_ztsl").val()) - parseFloat($("#txt_off_qty").val()));
                }
            }
        }


            function sm_source() {
                $('img[id*=img_sm]').click(function () {
                    wx.ready(function () {
                        wx.scanQRCode({
                            needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                            scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                            success: function (res) {
                                var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                                $('#source_dh').val(result);
                                $('#dh_record').val($('#dh_record').val() + "," + result);
                                source_dh_change();
                               <%-- $("#<%=btn_bind_data.ClientID%>").click();
                                Bind_WorkOrder($("#txt_dh").val(), $("#source_dh").val());--%>

                            }
                        });
                    });
                });
            }

            function qty_change() {

                var key_value = $("#txt_qty").val();//完工数量
                var off_qty = $("#txt_off_qty").val(); //已下料数量
                var curr_qty = key_value - off_qty;
                $("#txt_curr_qty").val(curr_qty);


            }

            function source_dh_change() {

                $("#dh_record").val($("#dh_record").val() + "," + $("#source_dh").val());
                
                $("#<%=btn_bind_data.ClientID%>").click();
                //setTimeout(function () {
                     Bind_WorkOrder($("#txt_dh").val(), $("#source_dh").val());
                    page_show();                    

                //}, 9000)
              //  alert(3);
                //var int = self.setTimeout(function () { alert($("#txt_source_sum").val()); }, 2000);

               
            }
            <%--function xmh_change() {

               $("#<%=btn_bind_xm.ClientID%>").click();
          }--%>

     
    </script>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional"><ContentTemplate>

            <div class="weui-cells weui-cells_form">


                <asp:TextBox ID="ps_part" class="weui-input" placeholder="" Style="max-width: 100%; display: none" runat="server"></asp:TextBox>
               
                <div hidden="hidden">
                    <div class="weui-cell__hd">
                        <label class="weui-label">登入人</label>
                    </div>
                    <div class="weui-cell__bd">
                        <asp:TextBox ID="txt_ztsl" class="weui-input" placeholder="" Style="max-width: 100%;" runat="server"></asp:TextBox>
                        <asp:TextBox ID="txt_emp" class="weui-input" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox> 
                        
                        <asp:TextBox ID="txt_step" class="weui-input" placeholder="" Style="max-width: 100%;" runat="server"></asp:TextBox>
                    </div>
                </div>

              
                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label f-red">完成单号</label>
                    </div>
                    <div class="weui-cell__bd">
                     
                        <asp:TextBox ID="txt_dh" class="weui-input" runat="server" Style="color: gray"></asp:TextBox>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label f-red">来源单号</label>
                    </div>
                    <div class="weui-cell__bd">
                        <span style="float: left; width: 90%">
                            <asp:TextBox ID="source_dh" class="weui-input" Style="color: gray" placeholder="请输入来源单号" runat="server" onchange="source_dh_change()"></asp:TextBox>
                        </span>
                        <span style="float: left; width: 10%">
                            <img id="img_sm" src="../img/fdj2.png" style="padding-top: 10px;" />
                        </span>
                    </div>



                </div>



                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">物料号</label>
                    </div>
                    <div class="weui-cell__bd">
                        <asp:TextBox ID="txt_pgino" class="weui-input" Style="max-width: 100%" runat="server"></asp:TextBox>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">零件号</label>
                    </div>
                    <div class="weui-cell__bd">
                        <asp:TextBox ID="txt_pn" class="weui-input" Style="max-width: 100%" runat="server"></asp:TextBox>
                    </div>
                </div>

             

                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label f-red">检验数量</label>
                    </div>
                    <div class="weui-cell__bd">
                        <asp:TextBox ID="txt_qty" class="weui-input" Style="max-width: 100%" runat="server" placeholder="请输入检验数量" onchange="qty_change()"></asp:TextBox>
                    </div>
                </div>

                <div class="weui-cell" style="font-size: 12px; color: gray;">
                    <div class="weui-flex__item">
                        已检验
                               <asp:TextBox ID="txt_off_qty" class="weui-input" runat="server" Style="color: gray; width: 30%; border-bottom: 1px solid #e5e5e5; text-align: center;"></asp:TextBox>
                    </div>
                    <div class="weui-flex__item">
                        本次检验
                               <asp:TextBox ID="txt_curr_qty" class="weui-input" runat="server" Style="color: gray; width: 30%; border-bottom: 1px solid #e5e5e5; text-align: center;"></asp:TextBox>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd ">
                        <label class="weui-label">说明</label>
                    </div>
                    <div class="weui-cell__bd">
                        <textarea id="txt_remark" class="weui-textarea" placeholder="请输入说明" rows="3" runat="server"></textarea>
                    </div>
                </div>

             

         


                </ContentTemplate></asp:UpdatePanel>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <script type="text/javascript">
                            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {

                                page_show();
                                //sm_source();
                                Bind_WorkOrder($("#txt_dh").val(), $("#source_dh").val());
                               setvalue();

                            });
                        </script>


                         <div class="weui-cells weui-cells_form">

                    <ul class="collapse">
                        <li>
                            <div class="weui-flex js-category">
                                <div class="weui-flex__item"><span>下一步</span></div>
                                <i class="icon icon-74"></i>
                            </div>
                            <div class="page-category js-categoryInner">

                                <div class="weui-cells page-category-content">
                                    <div class="weui-cell__bd">
                                        <div class="weui-form-li">
                                            <input class="weui-form-checkbox" name="step" id="g2" value="GP12" type="radio" disabled="disabled" />
                                            <label for="g2" class="middle">
                                                <i class="weui-icon-radio"></i>
                                                <div class="weui-form-text">
                                                    <p>GP12</p>
                                                </div>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="weui-cell__ft"></div>

                                    <div class="weui-cell__bd">
                                        <div class="weui-form-li">
                                            <input class="weui-form-checkbox" name="step" id="g3" value="入库" type="radio" disabled="disabled"/>
                                            <label for="g3" class="middle">
                                                <i class="weui-icon-radio"></i>
                                                <div class="weui-form-text">
                                                    <p>入库</p>
                                                </div>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="weui-cell__ft"></div>

                                </div>
                            </div>
                        </li>

                    </ul>
                </div>

                        <div class="weui-cells weui-cells_form">

                            <ul class="collapse">
                                <li>
                                    <div class="weui-flex js-category">
                                        <div class="weui-flex__item"><span>关联产品</span></div>
                                        <i class="icon icon-74"></i>
                                    </div>
                                    <div class="page-category js-categoryInner">

                                        <div class="weui-cells page-category-content">
                                            <div class="weui-form-preview__bd" id="divtable">
                                                <asp:Repeater runat="server" ID="Repeater_lotno">

                                                    <HeaderTemplate>
                                                        <table border="0" id="gltable">
                                                            <tr>
                                                                <td>来源单号</td>
                                                                <td>物料号</td>
                                                                <td>数量 </td>
                                                            </tr>
                                                    </HeaderTemplate>

                                                    <ItemTemplate>
                                                        <tr>
                                                            <td><%# Eval("workorder")%></td>
                                                            <td><%#  Eval("pgino") %></td>
                                                            <td><%# Eval("need_off_qty")%></td>
                                                        </tr>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        </table>
                                                    </FooterTemplate>
                                                </asp:Repeater>
                                            </div>


                                        </div>
                                    </div>
                                </li>

                            </ul>
                        </div>

                         <div class="weui-cells weui-cells_form">
                    <ul class="collapse">

                        <li>
                            <div class="weui-flex js-category">
                                <div class="weui-flex__item"><span>完成记录</span></div>
                                <i class="icon icon-74"></i>
                            </div>
                            <div class="page-category js-categoryInner">

                                <div class="weui-cells page-category-content">
                                     <div class="weui-form-preview__bd"  >
                                    <asp:Repeater runat="server" ID="Repeater_record">

                                        <HeaderTemplate>
                                            <table>
                                                <tr>
                                                    <td>物料号</td>
                                                    <td>数量</td>
                                                    <td>检验人 </td>
                                                    <td>检验时间 </td>
                                                </tr>
                                        </HeaderTemplate>

                                        <ItemTemplate>
                                            <tr>
                                                <td><%#  Eval("pgino") %></td>
                                                <td><%# Eval("hege_qty")%></td>
                                                <td><%# Eval("emp_name")%></td>
                                                <td><%# Eval("create_date","{0:MM/dd HH:mm}")%></td>
                                            </tr>

                                        </ItemTemplate>
                                         <FooterTemplate>
                                      </table>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>

                        <div class="hidden">

                            <asp:TextBox ID="txt_source_sum" class="weui-input" placeholder="" Style="max-width: 100%;" runat="server"></asp:TextBox>
                            <asp:TextBox ID="dh_record" class="weui-input" placeholder="" Style="max-width: 100%;" runat="server"></asp:TextBox>

                        </div>


                        <asp:Button ID="btn_bind_data" runat="server" Text="绑定来源数据" Style="display: none;" OnClick="btn_bind_data_Click" />
                        <div class="weui-cell">
                            <asp:Button ID="btnzc" class="weui-btn weui-btn_primary" BackColor="#428bca" runat="server" Text="暂存"   UseSubmitBehavior="false"  OnClick ="btnzc_Click" OnClientClick="if(!zcvalid()){return false;}this.disabled=false;this.value='处理中…';" />
                           <%-- <asp:Button ID="btn_wc" runat="server" Text="未合托完成" OnClick="btn_wc_Click" Style="display: none" />--%>
                            <asp:Button ID="btnsave" class="weui-btn weui-btn_primary" BackColor="#428bca" runat="server" Text="下一步" UseSubmitBehavior="false" OnClick="btnsave_Click" OnClientClick="if(!valid()){return false;}this.disabled=false;this.value='处理中…';" Style="margin-left: 10px;" />
                        </div>

                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>



           
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
