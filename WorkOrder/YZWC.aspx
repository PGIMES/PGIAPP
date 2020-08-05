<%@ Page Language="C#" AutoEventWireup="true" CodeFile="YZWC.aspx.cs" Inherits="WorkOrder_YZWC" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>压铸完成</title>
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

            if ($("#txt_pgino").val() == "")
            {
                alert("请选择物料号.");
                return false;
            }
            if ($("#txt_yzj").val() == "") {
                alert("请选择压铸机号.");
                return false;
            }
            if ($("#txt_dh").val() == "") {
                alert("请输入生产完成单号.");
                return false;
            }

            var hd_zyb = "";
            var bs = 0;
            $('#divtable table  tr').each(function (i) {
                if (i > 0) {
                    hd_zyb += $(this).children('td:eq(5)').text()+',';
                    $("#txt_lotno").val(hd_zyb);
                    bs = bs + 1;
                }

            });
            //if (bs < 2)
            //{
            //    alert("送汤笔数小于2笔,不可下线.");
            //    return false;
            //}
           

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


          });


          $(function () {
           <%--   $("#<%=btn_bind_xm.ClientID%>").click();  --%>

              $("#btnsave2").click(function () { 
                  $(":button").attr("disabled", "disabled");
                  $(":button").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');
                 
                  if (!valid()) {
                      $(":button").removeAttr("disabled");
                      $(":button").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                      return false;
                      //}
                  }

                  //var qty = $("#txt_qty").val();
                  //$.confirm('当前输入下料数量为 ' + qty + ' ，确认要暂存吗？', function () { btnclick($("#btnsave2").val()); },
                  //        function () {
                  //            $(":button").removeAttr("disabled");
                  //            $(":button").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                  //        });

                  if (parseFloat($("#txt_curr_qty").val()) < 0) {
                      $.confirm('本次下线数量小于0,确认倒冲吗？', function () { btnclick($("#btnsave2").val()); },
                         function () {
                             $(":button").removeAttr("disabled");
                             $(":button").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                         });
                  }
                  else {
                      var qty = $("#txt_qty").val();
                      $.confirm('当前输入下料数量为 ' + qty + ' ，确认要暂存吗？', function () { btnclick($("#btnsave2").val()); },
                              function () {
                                  $(":button").removeAttr("disabled");
                                  $(":button").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                              });
                  }
                  


                     
              });

              $("#btnsave3").click(function () {
                  $(":button").attr("disabled","disabled");
                  $(":button").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');

                  if (!valid()) {
                      $(":button").removeAttr("disabled");
                      $(":button").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                      return false;
                      //}
                  }
                 
                      //if (parseFloat($("#txt_curr_qty").val()) + parseFloat($("#txt_off_qty").val()) < parseFloat($("#txt_ztsl").val())) {
                      //    $.confirm('零托,确认执行下一步吗？', function () { btnclick($("#btnsave3").val()); },
                      //        function () {
                      //            $(":button").removeAttr("disabled");
                      //            $(":button").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                      //        });
                      //}
                      //else {
                      //    btnclick($("#btnsave3").val());
                      //}

                  if (parseFloat($("#txt_curr_qty").val()) < 0) {
                      $.confirm('本次下线数量小于0,确认倒冲吗？', function () { btnclick($("#btnsave3").val()); },
                         function () {
                             $(":button").removeAttr("disabled");
                             $(":button").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                         });
                  }
                  else {
                      if (parseFloat($("#txt_curr_qty").val()) + parseFloat($("#txt_off_qty").val()) < parseFloat($("#txt_ztsl").val())) {
                          $.confirm('零托,确认执行下一步吗？', function () { btnclick($("#btnsave3").val()); },
                              function () {
                                  $(":button").removeAttr("disabled");
                                  $(":button").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                              });
                      }
                      else {
                          var qty = $("#txt_qty").val();
                          $.confirm('当前输入下料数量为 ' + qty + ' ，确认要下料吗？', function () { btnclick($("#btnsave3").val()); },
                                  function () {
                                      $(":button").removeAttr("disabled");
                                      $(":button").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                                  });


                      }
                  }
                  

                  
              });

            });

            function source_dh_change() {

              $("#dh_record").val($("#dh_record").val() + "," + $("#source_dh").val());
                //$("#txt_yzj").val("2-6");

              $("#<%=btn_bind_data.ClientID%>").click();
                
               yz_wip_change($("#dh_record").val());

            }

            //物料change
         function yz_wip_change(source_dh) {

              $.ajax({
                   type: "post",
                   url: "YZWC.aspx/yz_source_change",
                   data: "{'source_dh': '" + source_dh + "'}",
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                   success: function (data) {
                       var obj = eval(data.d);
                       
                           $('#txt_pgino').val(obj[0].pgino);
                           $('#txt_pn').val(obj[0].pt_desc2);
                           $('#txt_qty').val(obj[0].act_qty);
                           $('#txt_off_qty').val(obj[0].off_qty);
                           $('#txt_curr_qty').val(obj[0].curr_qty);
                           $('#txt_ztsl').val(obj[0].pt_ord_mult);
                       
                     
                   }

              });
<%--               $("#<%=btn_bind_xm.ClientID%>").click(); --%>
         }


          function btnclick(btnevent){
               $.ajax({
                      type: "post",
                      url: "YZWC.aspx/save2",
                      data: "{'_dh':'" + $('#txt_dh').val() + "','_emp':'" + $('#txt_emp').val() + "','_pgino':'" + $('#txt_pgino').val()
                          + "','_pn':'" + $('#txt_pn').val() + "','_descr':'" + $('#txt_desc2').val()
                          + "','_curr_qty':'" + $('#txt_curr_qty').val() + "','_btnms':'" + btnevent + "','_lot':'" + $('#txt_lotno').val()
                          + "','_stepvalue':'" + $("input[name='step']:checked").val() + "','_remark':'" + $('#txt_remark').val()
                          + "','_dh_record':'" + $('#dh_record').val() + "','_workshop':'<%=_workshop %>','_yzjno':'" + $('#txt_yzj').val() + "' }",
                      contentType: "application/json; charset=utf-8",
                      dataType: "json",
                      async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                      success: function (data) {
                          var obj = eval(data.d);
                          if (obj[0].flag == "Y") {
                              alert(obj[0].msg);
                              $(":button").removeAttr("disabled");
                              $(":button").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                              return false;
                          }
                          alert(btnevent + '完成');
                          window.location.href = "/Cjgl1.aspx?workshop=<%=_workshop %>";
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

         

           function xmh_change() {

               $("#<%=btn_bind_xm.ClientID%>").click();
          }
          function qty_change() {

              var key_value = $("#txt_qty").val();//完工数量
              var off_qty = $("#txt_off_qty").val(); //已下料数量
              var curr_qty = key_value - off_qty;
              $("#txt_curr_qty").val(curr_qty);
             
             
          }

         

           function setvalue() {
               debugger
               alert($("#txt_step").val());
              
           }


           <%--function yzj_change(yzj) {
               $.ajax({
                   type: "post",
                   url: "YZWC.aspx/yzj_change",
                   data: "{'emp': '" + $("#txt_emp").val() + "','workshop':'" + "<%= _workshop %>" + "','workorder': '" + $("#txt_dh").val() + "','yzj_no': '" + yzj + "'}",
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                   success: function (data) {
                       var obj = eval(data.d);
                       $('#txt_pn').val(obj[0].pt_desc1);
                       //$('#descr').val(obj[0].descr);
                       //$('#b_use_routing').val(obj[0].b_use_routing);
                       //$('#b_op_one').val(obj[0].b_op_one);
                       var json_op = obj[0].json_op;
                       $("#txt_pgino").select("update", { items: json_op });
                   }

               });
           }--%>

          function sm_source() {
              $('img[id*=img_sm]').click(function () {
                  wx.ready(function () {
                      wx.scanQRCode({
                          needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                          scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                          success: function (res) {
                              var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                              $('#source_dh').val(result);
                              source_dh_change();
                                //$('#dh_record').val($('#dh_record').val()+","+result);
                              <%-- $("#<%=btn_bind_data.ClientID%>").click();--%>
                          }
                      });
                  });
              });
          }
        
          function step_change()
          { }

    </script>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server">
        </asp:ScriptManager>
    <div class="resume-setting-page normal-page-wrap"> 
      
    
        
            <div class="weui-cells weui-cells_form">
            <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
            <script type="text/javascript">
                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                    $("#txt_dh").attr("readonly", "readonly");
                    $("#txt_curr_qty").attr("readonly", "readonly");
                    $("#txt_off_qty").attr("readonly", "readonly");
                    $("#txt_pn").attr("readonly", "readonly");
                    page_show();
                    sm_source();

                    init_data();
                });
            </script>--%>

               <%-- <asp:TextBox ID="txt_step" class="weui-input" placeholder="" Style="max-width: 100%;" runat="server"></asp:TextBox>--%>
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
                        <asp:TextBox ID="txt_cz" class="weui-input" placeholder="" Style="max-width: 100%;" runat="server"></asp:TextBox>
                         <asp:TextBox ID="txt_desc2" class="weui-input" placeholder="" Style="max-width: 100%;" runat="server"></asp:TextBox>
                        <asp:TextBox ID="txt_lotno" class="weui-input" placeholder="" Style="max-width: 100%;" runat="server"></asp:TextBox>
                        <asp:TextBox ID="txt_equipno" class="weui-input" placeholder="" Style="max-width: 100%;" runat="server"></asp:TextBox>
                         <asp:TextBox ID="txt_equipname" class="weui-input" placeholder="" Style="max-width: 100%;" runat="server"></asp:TextBox>
                    </div>
                </div>






                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label f-red">压铸完成单号</label>
                    </div>
                    <div class="weui-cell__bd">
                        <asp:TextBox ID="txt_dh" class="weui-input" runat="server" Style="color: gray"></asp:TextBox>
                    </div>

                </div>


                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">来源单号</label>
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
                <div class="weui-cell__hd f-red"><label class="weui-label">压铸机</label></div>
                <div class="weui-cell__bd">
                    <span style="float:left; width:90%">
                        <asp:TextBox ID="txt_yzj" class="weui-input"  placeholder="请选择压铸机号" runat="server"></asp:TextBox>
                    </span>
                    <%--<span style="float:left; width:10%">
                        <img id="img_sm_yzj" src="../img/fdj2.png" style="padding-top:2px; "  />
                    </span>--%>
                </div>
            </div>

              <%--  <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label f-red">物料号</label>
                    </div>
                    <div class="weui-cell__bd">
                        <asp:DropDownList ID="txt_xmh" class="weui-input" runat="server" onchange="xmh_change()" ></asp:DropDownList>
                    </div>
                </div>--%>

                  <div class="weui-cell">
                <div class="weui-cell__hd f-red"><label class="weui-label">物料号</label></div>              
                <asp:TextBox ID="txt_pgino" class="weui-input" runat="server" placeholder="请选择物料号" style="color:gray;"></asp:TextBox>
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
                        <textarea id="txt_remark" class="weui-textarea" placeholder="请输入说明" rows="2" runat="server"></textarea>
                    </div>
                </div>   
                  
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                <script type="text/javascript">
                    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                        page_show();
                    
                    });
                </script>
                 <div class="weui-form-preview">

                     <ul class="collapse">
                         <li class="js-show">
                             <div class="weui-flex js-category">
                                 <div class="weui-flex__item"><span>下一步</span></div>
                                 <i class="icon icon-74"></i>
                             </div>
                             <div class="page-category js-categoryInner">

                                 <div class="weui-cells page-category-content">

                                     <div class="weui-cell__bd">
                                         <div class="weui-form-li">
                                             <input class="weui-form-checkbox" name="step"  id="g1" value="后处理完成" type="radio"  runat="server" />  
                                             <label for="g1">
                                                 <i class="weui-icon-radio"></i>
                                                 <div class="weui-form-text">
                                                     <p>后处理完成</p>
                                                 </div>
                                             </label>
                                         </div>
                                     </div>
                                     <div class="weui-cell__ft"></div>

                                     <div class="weui-cell__bd">
                                         <div class="weui-form-li">
                                             <input class="weui-form-checkbox" name="step"  id="g2" value="终检" type="radio"   runat="server" />   
                                             <label for="g2">
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
                                             <input class="weui-form-checkbox" name="step"  id="g3" value="GP12" type="radio" runat="server" />  
                                             <label for="g3" class="middle">
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
                                             <input class="weui-form-checkbox" name="step"  id="g4" value="入库" type="radio" runat="server"  /> 
                                             <label for="g4" class="middle">
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
                                                          <td>转运包</td>
                                                          <td>压铸机号</td>
                                                          <td>材料</td>
                                                          <td>Lot No</td>
                                                          <td>重量(KG) </td>
                                                          <td style="display:none">lotno </td>
                                                        
                                                      </tr>
                                              </HeaderTemplate>

                                               <ItemTemplate>
                                                   <tr>
                                                       <td><%# Eval("zyb") %></td>
                                                        <td><%# Eval("yzj_no") %></td>
                                                        <td><%# Eval("cl") %></td>
                                                       <td><%# Eval("zyb_lot")%></td>
                                                       <td><%# Eval("act_qty")%></td>
                                                        <td style="display:none"><%# Eval("lot_no")%></td>
                                                       
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
                                                <td><%# Eval("pgino") %></td>
                                                <td><%# Eval("off_qty")%></td>
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


                
           
              

               <asp:Button ID="btn_bind_xm" runat="server" Text="项目号关联数据" style="display:none;" OnClick="btn_bind_xm_Click" />
              
              <asp:Button ID="btn_bind_data" runat="server" Text="绑定来源数据" style="display:none;"  OnClick="btn_bind_data_Click"/>
              
           

                   </ContentTemplate>
            </asp:UpdatePanel>
                </div>
              <div class="weui-cell">

                   <input id="btnsave2" type="button" value="暂存" class="weui-btn weui-btn_primary" />
                  <input id="btnsave3" type="button" value="下料" class="weui-btn weui-btn_primary" style="margin-left:10px;" />
              </div>
               
              
     
      
               
            
           
           
        
       
    </div>
    </form>

    
       <script>

           function init_data() {
               var datalist_yzj, datalist_pgino;

               $.ajax({
                   type: "post",
                   url: "YZWC.aspx/init_yzj",
                   data: "{'emp': '" + $("#txt_emp").val() + "','workshop':'" + "<%= _workshop %>" + "','workorder': '" + $("#txt_dh").val() + "'}",
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                   success: function (data) {
                       var obj = eval(data.d);
                       datalist_yzj = obj[0].json;
                       datalist_pgino = obj[0].json_pgino;
                       if (obj[0].yzjno != "") {
                           $("#txt_equipno").val(obj[0].equip_no);
                           $("#txt_equipname").val(obj[0].equip_name);
                       }
                   }
               });

               $("#txt_yzj").select({
                   title: "压铸机",
                   items: datalist_yzj,
                   onChange: function (d) {
                       //alert(d.values);
                       yzj_change(d.values);
                       
                   },
                   onClose: function (d) {
                       //var obj = eval(d.data);
                       //alert(obj.values);

                   },
                   onOpen: function () {
                       //  console.log("open");
                   },

               });

               $("#txt_pgino").select({
                   title: "物料号",
                   items: [{ title: '', value: '' }],
                   onChange: function (d) {
                       //alert(d.values);

                       //绑定零件号
                       pgino_change(d.values, $("#txt_yzj").val());
                        
                   },
                   onClose: function (d) {
                       //var obj = eval(d.data);
                       //alert(obj.values);

                   },
                   onOpen: function () {
                       //  console.log("open");
                   },

               });
               if ($("#txt_yzjno").val() != "")
               {
                   $("#txt_yzj").val($("#txt_equipname").val());
                   yzj_change($("#txt_equipno").val());
               }

               //if (datalist_yzj.length == 1) {
              
               //    $("#txt_yzj").val(datalist_yzj[0].title);
               //    yzj_change(datalist_yzj[0].value);
               //}
           }
           

           function yzj_change(yzj_no) {
               $.ajax({
                   type: "post",
                   url: "YZWC.aspx/yzj_change",
                   data: "{'emp': '" + $("#txt_emp").val() + "','workshop':'" + "<%= _workshop %>" + "','workorder': '" + $("#txt_dh").val() + "','yzj_no': '" + yzj_no + "'}",
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                   success: function (data) {
                       var obj = eval(data.d);
                       //$('#txt_pn').val(obj[0].pt_desc1);
                       //$('#descr').val(obj[0].descr);
                       //$('#b_use_routing').val(obj[0].b_use_routing);
                       //$('#b_op_one').val(obj[0].b_op_one);
                       var json_op = obj[0].json_op;
                       $("#txt_pgino").select("update", { items: json_op });
                       $('#txt_pgino').val('');
                       $('#txt_pn').val('');
                       $('#txt_desc2').val('');
                       $('#txt_qty').val('');
                       $('#txt_off_qty').val('');
                       $('#txt_curr_qty').val('');

                       if (json_op.length == 1) {
                           $("#txt_pgino").val(json_op[0].title);
                           pgino_change(json_op[0].title, yzj_no);
                          
                       }
                      
                     
                      
                   }

               });
               
           }


           //物料change
         function pgino_change(pgino,yzj_no) {

              $.ajax({
                   type: "post",
                   url: "YZWC.aspx/pgino_change",
                   data: "{'emp': '" + $("#txt_emp").val() + "','workshop':'" + "<%= _workshop %>" + "','workorder': '" + $("#txt_dh").val() + "','pgino': '" + pgino + "','yzj_no': '" + yzj_no + "'}",
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                   success: function (data) {
                       var obj = eval(data.d);
                       
                           $('#txt_pn').val(obj[0].pt_desc1);
                           $('#txt_desc2').val(obj[0].pt_desc2);
                           $('#txt_qty').val(obj[0].pt_ord_mult);
                           $('#txt_off_qty').val(obj[0].off_qty);
                           $('#txt_curr_qty').val(obj[0].curr_qty);
                           $('#txt_ztsl').val(obj[0].pt_ord_mult);
                       
                     
                   }

              });
               $("#<%=btn_bind_xm.ClientID%>").click(); 
           }



           init_data();

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




