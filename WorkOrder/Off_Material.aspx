<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Off_Material.aspx.cs" Inherits="Off_Material" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>生产下线</title>
    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <script src="../Content/layer/layer.js"></script>
     <link rel="stylesheet" href="../css/weui.css" />
    <link rel="stylesheet" href="../css/weuix.css" />
    <script src="../js/zepto.min.js"></script>
    <script src="../js/zepto.weui.js"></script>
   

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
         .weui-btn + .weui-btn{
            margin-top:0px;
        }
       divtable .weui-table td, .weui-table th, table td, table th
       {
           border:none;
       }
       .collapse li.js-show .weui-flex{
           opacity:1;
       }
      
        
    </style>


    
    <script>


        function valid() {
            if ($("#txt_curr_qty").val() == "" || $("#txt_curr_qty").val() <= "0") {
                alert("本次下料数量必须大于0.");
                return false;
            }

            if ($("#txt_xmh").val() == "")
            {
                alert("请选择物料号.");
                return false;
            }
            if ($("#txt_dh").val() == "") {
                alert("请输入生产完成单号.");
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
              page_show();
              sm_source();
              Bind_WorkOrder($("#txt_dh").val());
              xmh_change();
             
          })
         
          function xmh_change() {

               $("#<%=btn_bind_xm.ClientID%>").click();
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

          //function dh_change() {
             
             
          //    if ($("#txt_dh").val().toUpperCase().substring(0, 1).toUpperCase() != "W" || $("#txt_dh").val().length != 8)
          //    {
          //        alert("完成单号不正确，请重新扫描");
          //        $("#txt_dh").val("");
          //        return;
          //    }
          //}

        
          function source_dh_change() {

              $("#dh_record").val($("#dh_record").val() + "," + $("#source_dh").val());
              
                   $("#<%=btn_bind_data.ClientID%>").click();
              
          }
             
         

          function qty_change() {

              var key_value = $("#txt_qty").val();//完工数量
              var off_qty = $("#txt_off_qty").val(); //已下料数量
              var curr_qty = key_value - off_qty;
              $("#txt_curr_qty").val(curr_qty);
             
             
          }

           function Bind_WorkOrder(workorder) {       
                $.ajax({
                    type: "post",
                    url: "Off_Material.aspx/Set_Page",
                    data: "{'workorder':'" + workorder + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                    success: function (data) {
                        if (data) {
                            $.each(eval(data.d), function (i, item) {
                                if (item.text == "Y")
                                {
                                    alert(item.value);
                                    $("input[type='text']").val("");
                                    return;
                                }
                                else
                                {
                                    
                                    $("#txt_pn").val(item.pn).attr("readonly", "readonly");
                                    $("#txt_off_qty").val(item.off_qty).attr("readonly", "readonly");
                                    $("#txt_qty").val(item.pt_ord_mult);
                                    $("#txt_ztsl").val(item.pt_ord_mult);
                                    $("#txt_curr_qty").val(item.curr_qty).attr("readonly", "readonly");
                                    $("select#txt_xmh option[value='" + item.pgino + "']").attr('selected', 'true');
                                    $("#txt_xmh").val(item.pgino).css("color","gray");
                                    xmh_change();
                                   $("#txt_xmh").val(item.pgino).attr("disabled", "disabled");
                                }
                            })
                           
                        }
                       
                    } 
                    
                });
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
                                $('#dh_record').val($('#dh_record').val()+","+result);
                               $("#<%=btn_bind_data.ClientID%>").click();
                          }
                      });
                  });
              });
          }


    </script>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server">
        </asp:ScriptManager>
    <div class="resume-setting-page normal-page-wrap"> 
      
    
        
            <div class="weui-cells weui-cells_form">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
            <script type="text/javascript">
                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                    $("#txt_dh").attr("readonly", "readonly");
                    $("#txt_curr_qty").attr("readonly", "readonly");
                    $("#txt_off_qty").attr("readonly", "readonly");
                    $("#txt_pn").attr("readonly", "readonly");
                    //$("#txt_xmh").attr("disabled", "disabled");
                    page_show();
                    sm_source();
                });
            </script>
             <asp:TextBox ID="ps_part" class="weui-input" placeholder="" Style="max-width: 100%; display:none" runat="server" ></asp:TextBox>

                <div hidden="hidden">
                    <div class="weui-cell__hd">
                        <label class="weui-label">当前岗位</label>
                    </div>
                    <div class="weui-cell__bd">
                        <asp:TextBox ID="txt_location" class="weui-input" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                    </div>
                </div>
                         
                 <div hidden="hidden">
                    <div class="weui-cell__hd">
                        <label class="weui-label">登入人</label>
                    </div>
                    <div class="weui-cell__bd">
                       <asp:TextBox ID="txt_emp" class="weui-input" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                        <asp:TextBox ID="txt_ztsl" class="weui-input"  placeholder="" Style="max-width: 100%; "  runat="server" ></asp:TextBox>
                           <asp:TextBox ID="dh_record" class="weui-input"  placeholder="" Style="max-width: 100%; "  runat="server" ></asp:TextBox>

                    </div>
                </div>

                 




                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label f-red" >生产完成单号</label>
                    </div>
                 <%--   <div class="weui-cell__bd">
                         <span style="float:left; width:90%">
                        <asp:TextBox ID="txt_dh" class="weui-input" placeholder="请输入完成单号" runat="server"   onchange="dh_change()"></asp:TextBox>
                    </span>
                        <span style="float:left; width:10%">
                            <img id="img_sm" src="../img/fdj2.png" style="padding-top:10px;" />
                    </span>
                    </div>--%>

                       <div class="weui-cell__bd">
                        
                        <asp:TextBox ID="txt_dh" class="weui-input" runat="server" style="color:gray"  ></asp:TextBox>   <%-- onchange="dh_change()"--%>
                   
                    </div>

                </div>


                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">来源单号</label>
                    </div>
                    <div class="weui-cell__bd">
                         <span style="float:left; width:90%">
                        <asp:TextBox ID="source_dh" class="weui-input" style="color:gray" placeholder="请输入来源单号" runat="server" onchange="source_dh_change()"   ></asp:TextBox>
                    </span>
                        <span style="float:left; width:10%">
                            <img id="img_sm" src="../img/fdj2.png" style="padding-top:10px;" />
                    </span>
                    </div>

                      

                </div>


                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label f-red">物料号</label>
                    </div>
                    <div class="weui-cell__bd">
                        <asp:DropDownList ID="txt_xmh" class="weui-input" runat="server" onchange="xmh_change()" ></asp:DropDownList>
                    </div>
                </div>

                 <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">零件号</label>
                    </div>
                    <div class="weui-cell__bd">
                        <asp:TextBox ID="txt_pn" class="weui-input" Style="max-width: 100%; color:gray" runat="server"></asp:TextBox>
                    </div>
                </div>

                  <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label f-red">下料数量</label>
                    </div>
                    <div class="weui-cell__bd">
                        <asp:TextBox ID="txt_qty" class="weui-input" Style="max-width: 100%"  onchange="qty_change()" runat="server" placeholder="请输入完工数量"  ></asp:TextBox>    
                    </div>
                </div>



                <div class="weui-cell" style="font-size: 12px; color: gray;">
                    <div class="weui-flex__item">
                        已下料
                               <asp:TextBox ID="txt_off_qty" class="weui-input" runat="server" Style="color: gray; width: 30%; border-bottom: 1px solid #e5e5e5; text-align: center;"></asp:TextBox>
                    </div>
                    <div class="weui-flex__item">
                        本次下料
                               <asp:TextBox ID="txt_curr_qty" class="weui-input" runat="server" Style="color: gray; width: 30%; border-bottom: 1px solid #e5e5e5; text-align: center;"></asp:TextBox>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd ">
                        <label class="weui-label">说明</label></div>
                    <div class="weui-cell__bd">
                        <textarea id="txt_remark" class="weui-textarea" placeholder="请输入说明" rows="3" runat="server"></textarea>
                    </div>
                </div>     

                 <div class="weui-form-preview">

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
                                             <input class="weui-form-checkbox" name="maintain_type" disabled="disabled" id="g1" value="终检" type="radio" <%= ViewState["STEPVALUE"].ToString()=="终检"?"checked":"" %> />
                                             <label for="g1">
                                                 <i class="weui-icon-radio"></i>
                                                 <div class="weui-form-text">
                                                     <p>终检</p>
                                                 </div>
                                             </label>
                                         </div>
                                     </div>
                                     <div class="weui-cell__ft"></div>

                                     <div class="weui-cell__bd">
                                         <div class="weui-form-li">
                                             <input class="weui-form-checkbox" name="maintain_type" disabled="disabled" id="g2" value="GP12" type="radio" <%= ViewState["STEPVALUE"].ToString()=="GP12"?"checked":"" %> />
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
                                             <input class="weui-form-checkbox" name="maintain_type" disabled="disabled" id="g3" value="入库" type="radio" <%= ViewState["STEPVALUE"].ToString()=="入库"?"checked":"" %> />
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

                
            

                
                 <div class="weui-form-preview">

                     <ul class="collapse">
                         <li class="">
                             <div class="weui-flex js-category">
                                 <div class="weui-flex__item"><span>关联材料</span></div>
                                 <i class="icon icon-74"></i>
                             </div>
                             <div class="page-category js-categoryInner">

                                 <div class="weui-cells page-category-content">
                                      <div class="weui-form-preview__bd" id="divtable">
                                      <asp:Repeater runat="server" ID="Repeater_lotno">

                                              <HeaderTemplate>
                                                  <table border="0">
                                                      <tr>
                                                          <td>物料号</td>
                                                          <td>Lot No</td>
                                                          <td>数量 </td>
                                                      </tr>
                                              </HeaderTemplate>

                                               <ItemTemplate>
                                                   <tr>
                                                       <td><%#  Eval("sku") %></td>
                                                       <td><%# Eval("lot_no")%></td>
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

               

                <div class="weui-form-preview">
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
                                                    <td>下料人 </td>
                                                    <td>下料时间 </td>
                                                </tr>
                                        </HeaderTemplate>

                                        <ItemTemplate>
                                            <tr>
                                                <td><%#  Eval("sku") %></td>
                                                <td><%# Eval("par_qty")%></td>
                                                <td><%# Eval("create_by")%></td>
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

              

                <asp:Button ID="btn_bind_xm" runat="server" Text="项目号关联数据" style="display:none;" OnClick="btn_bind_xm_Click" />
              
              <asp:Button ID="btn_bind_data" runat="server" Text="绑定来源数据" style="display:none;" OnClick="btn_bind_data_Click"/>
               
                 <div class="weui-cell">
                   <asp:Button ID="btnzc" class="weui-btn weui-btn_primary" BackColor="#428bca"  runat="server" Text="暂存" OnClick="btnzc_Click"  OnClientClick="if(!valid()){return false;}this.disabled=false;this.value='处理中…';" /> 
                   <asp:Button ID="btn_wc" runat="server" Text="未合托完成" onclick="btn_wc_Click"   style=" display:none"  />       
                   <asp:Button ID="btnsave" class="weui-btn weui-btn_primary" BackColor="#428bca"  runat="server" Text="下料" OnClick="btnsave_Click"  OnClientClick="if(!valid()){return false;}this.disabled=false;this.value='处理中…';"  style="margin-left:10px;" />
                </div>
               

                   </ContentTemplate>
            </asp:UpdatePanel>
                </div>

               
              
     
      
               
            
           
           
        
       
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

