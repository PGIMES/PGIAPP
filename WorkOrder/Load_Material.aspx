<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Load_Material.aspx.cs" Inherits="Load_Material" EnableEventValidation="false" %>

<!DOCTYPE html>

<html><head>
    <meta charset="utf-8">
    <title>生产上线</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    
    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <script src="/Content/layer/layer.js"></script>
  

    <link href="../css/weui.css" rel="stylesheet" />
    <link href="../css/weuix.css" rel="stylesheet" />
    <script src="../js/zepto.min.js"></script>
    <script src="../js/zepto.weui.js"></script>
    <style>
     

      /*.weui-cell {
    padding: 7px 15px;
    position: relative;
    align-items: center;


}*/

      .weui-form-preview__value1 {
    display: block;
    overflow: hidden;
    word-break: normal;
    word-wrap: break-word;
    color:DodgerBlue;
    font-size:large;
}

      .weui-form-preview__label1 {
    float: left;
    margin-right: 1em;
    min-width: 4em;
    text-align: justify;
    text-align-last: justify;
     color:black;
    font-size:large;
}
       .weui-btn + .weui-btn{
            margin-top:0px;
        }

       .hidden { display:none;}
    </style>

    
    <script>
        function valid() {
            //if ($('#txt_lotno').val()=="") {
            //    alert("请输入【Lot No】.");
            //    return false;
            //}
            //if ($('#txt_wlh').val() == "") {
            //    alert("【物料号】不可为空.");
            //    return false;
            //}
            //if ($('#txt_xmh').val() == "") {
            //    alert("请选择【项目号】.");
            //    return false;
            //}
            //if ($('#txt_qty').val() == "" || $('#txt_qty').val() == "0") {
            //    alert("【数量】不可为空或0.");
            //    return false;
            //}
            //return true;
        }
    </script>
</head>
<body ontouchstart="">
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
            document.querySelector('#img_sm').onclick = function () {
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
            $("#txt_wlh").attr("readonly", "readonly");
            $("#txt_qty").attr("readonly", "readonly");
            var lotno = '<%=lotno%>';
            var needno = '<%=_needno%>';
            Bind_Lotno(lotno,needno);

        
        });

        
        function Bind_Lotno(lotno,needno) {       
                $.ajax({
                    type: "post",
                    url: "Load_Material.aspx/Set_Lotno",
                    data: "{'lotno':'" + lotno + "','needno':'" + needno + "'}",
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
                                  //  $("#txt_lotno").val(lotno);
                                    //$("#txt_wlh").text(item.sku);
                                    $("#txt_wlh").text(item.sku);
                                    $("#sku_desc").text(item.sku_desc);
                                    $("#txt_qty").text(item.feed_qty);

                                    $("#txt_need_person").text(item.need_person);
                                    $("#txt_line").text(item.line);
                                   // $("#txt_location").text(item.gw);
                                    $("#txt_need_qty").text(item.need_qty);
                                    $("#txt_deliver_time").text(item.need_time);
                                    $("#txt_feed_person").text(item.feed_person);
                                    $("#txt_feed_time").text(item.feed_time);
                                    
                                    $("#txt_desc").text(item.sku_desc);
                                   
                                    $("#txt_domain").text(item.domain);
                                  

                                }
                            })
                           
                        }
                       
                    } 

                });
        }

        function valid_cancel() {
            var qty = $("#txt_qty").text();
            
            if (confirm('确认要【退回】【数量' + qty + '】吗？')) {
                $.ajax({
                    type: "post",
                    url: "Load_Material.aspx/Reject_Sku",
                    data: "{'emp':'" + "<%= _emp %>" + "','needno':'" + "<%= _needno %>" + "','lotno':'" + "<%= lotno %>" + "','reject_qty':'" + qty + "','source':'1'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                    success: function (data) {
                        var obj = eval(data.d);
                        //var flag = obj[0].flag;
                        //if (flag == "Y") {
                        //    layer.alert(obj[0].msg);
                        //} else {
                           
                        //}
                        layer.alert(obj[0].msg);
                        return;
                    }
                });
            }
        }

    </script>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server">
        </asp:ScriptManager>
        <div class="weui-cells weui-cells_form">
            <%--<div id="allContainer" class="menus-normal">
                <dl class="menus-module" style="background-color: #008083; height: 66px;">

                    <dt class="menus-title" style="background-color: #008083; height: 66px">
                        <div style="float: left; width: 80%; border: 0px solid #F00;">PGI产线作业-生产上线</div>
                        <div style="float: left; width: 18%; border: 0px solid #000; text-align: right;"></div>
                    </dt>


                </dl>
            </div>--%>


            <div class="weui-form-preview">
                <asp:TextBox ID="emp_code_name" class="form-control" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                <asp:TextBox ID="need_no" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                <asp:TextBox ID="pgino" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                <asp:TextBox ID="pn" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>

                 <div class="weui-form-preview__hd">
                    <div class="weui-form-preview__item">
                       
                       <label class="weui-form-preview__">上料单号:<% ="<font class='tag'/>"+lotno %></label>
                    </div>
                </div>

                <div class="weui-form-preview__bd">
                    <%--<asp:Repeater runat="server" ID="listBxInfo">
                        <ItemTemplate>--%>


                    <div class="weui-form-preview__item">
                        <label class="weui-form-preview__label">岗位</label>
                        <span class="weui-form-preview__value">
                            <asp:Label ID="txt_location" class="weui-input" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:Label>
                        </span>
                    </div>

                    <div class="weui-form-preview__item">
                        <label class="weui-form-preview__label">送料人</label>
                        <span   class="weui-form-preview__value" id="txt_feed_person">
                            <%--<asp:Label ID="txt_feed_person" class="weui-input" Style="max-width: 100%" runat="server"></asp:Label>--%>
                        </span>
                    </div>

                    <div class="weui-form-preview__item">
                        <label class="weui-form-preview__label ">送料时间</label>
                        <span class="weui-form-preview__value" id="txt_feed_time">
                            <%--<asp:Label ID="txt_feed_time" class="weui-input" Style="max-width: 100%" runat="server"></asp:Label>--%>
                        </span>
                    </div>

                    <div class="weui-form-preview__item">
                        <label class="weui-form-preview__label1  ">物料号</label>
                        <span class="weui-form-preview__value1" ID="txt_wlh">
                            <%--<asp:Label ID="txt_wlh" class="weui-input" Style="max-width: 100%" runat="server"></asp:Label>--%>
                        </span>
                    </div>

                    <div class="weui-form-preview__item">
                        <label class="weui-form-preview__label1 ">零件号</label>
                        <span class="weui-form-preview__value1" ID="sku_desc">
                           <%-- <asp:Label ID="sku_desc" class="weui-input" Style="max-width: 100%" runat="server"></asp:Label>--%>
                        </span>
                    </div>


                    <div class="weui-form-preview__item">
                        <label class="weui-form-preview__label1 ">数量</label>
                        <span class="weui-form-preview__value1" ID="txt_qty">
                            <%--<asp:Label ID="txt_qty" class="weui-input" Style="max-width: 100%" runat="server"></asp:Label>--%>
                        </span>
                    </div>
                           

                           <%-- <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">要料人</label>
                                <span class="weui-form-preview__value" ID="txt_need_person">
                                </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">车间</label>
                                <span class="weui-form-preview__value" id="txt_workshop"><%--<%# Eval("workshop") %> 

                                </span>
                            </div>
                             <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">生产线</label>
                                <span class="weui-form-preview__value" id="txt_line"><%--<%# Eval("line") %>

                                </span>
                            </div>
                             <%--<div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">岗位</label>
                                <span class="weui-form-preview__value" id="txt_location"><%--<%# Eval("gw") %>

                                </span>
                            </div>
                             <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">要料数量</label>
                                <span class="weui-form-preview__value" id="txt_need_qty"><%--<%# Eval("need_qty") %>

                                </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">要求送到时间</label>
                                <span class="weui-form-preview__value" id="txt_deliver_time"><%--<%# Eval("need_time")%>

                                </span>
                            </div>                         
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">送料人</label>
                                <span class="weui-form-preview__value" id="txt_feed_person"><%--<%# Eval("feed_person")%>

                                </span>
                            </div>                             
                             <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">送料时间</label>
                                <span class="weui-form-preview__value" id="txt_feed_time"><%--<%# Eval("feed_time")%>

                                </span>
                            </div>   
                           
                           
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">物料号</label>
                                <span class="weui-form-preview__value"><%--<%# Eval("sku") %>
                                </span>
                            </div>
                            <%--<div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">零件号</label>
                                <span class="weui-form-preview__value"><%--<%# Eval("sku_desc") %>

                                </span>
                            </div>
                           
                            
                       <%-- </ItemTemplate>
                    </asp:Repeater>--%>
                </div>
            </div>



            
                   <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>--%>

                          <%--  <div class="weui-cell">
                                <div class="weui-cell__hd"><label class="weui-label">要料人</label></div>
                                <div class="weui-cell__bd">
                                     <asp:TextBox ID="txt_need_person" class="weui-input" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                                </div>
                            </div>

                             <div class="weui-cell">
                                <div class="weui-cell__hd">
                                    <label class="weui-label">车间</label></div>
                                <div class="weui-cell__bd">
                                   <asp:TextBox ID="txt_workshop" class="weui-input" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                                </div>
                            </div>

                            <div class="weui-cell">
                                 <div class="weui-cell__hd">
                                    <label class="weui-label">生产线</label></div>
                                 <div class="weui-cell__bd">
                                    <asp:TextBox ID="txt_line" class="weui-input" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                                </div>
                            </div>

                             <div class="weui-cell">
                                 <div class="weui-cell__hd">
                                    <label class="weui-label">岗位</label></div>
                                 <div class="weui-cell__bd">
                                     <asp:TextBox ID="txt_location" class="weui-input" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                                </div>
                            </div>--%>

                            

<%--                                 <div class="weui-cell">
                                 <div class="weui-cell__hd">
                                    <label class="weui-label">要料数量</label></div>
                                 <div class="weui-cell__bd">
                                    <asp:TextBox ID="txt_need_qty" class="weui-input" Style="max-width: 100%" runat="server" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>


                                 <div class="weui-cell">
                                 <div class="weui-cell__hd" ">
                                    <label class="weui-label">要求送到<br />时 间</label></div>
                                 <div class="weui-cell__bd">
                                   <asp:TextBox ID="txt_deliver_time" class="weui-input" Style="max-width: 100%" runat="server" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>
                         

                               <div class="weui-cell">
                                 <div class="weui-cell__hd">
                                    <label class="weui-label">送料人</label></div>
                                 <div class="weui-cell__bd">
                                    <asp:TextBox ID="txt_feed_person" class="weui-input" Style="max-width: 100%" runat="server" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>


                              <div class="weui-cell">
                                 <div class="weui-cell__hd">
                                    <label class="weui-label">送料时间</label></div>
                                 <div class="weui-cell__bd">
                                    <asp:TextBox ID="txt_feed_time" class="weui-input" Style="max-width: 100%" runat="server" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>--%>


                            <div  hidden="hidden">
                                 <div class="weui-cell__hd">
                                    <label class="weui-label">登入人</label></div>
                                 <div class="weui-cell__bd">
                                    <asp:TextBox ID="txt_emp"  class="weui-input"  placeholder="" Style="max-width: 100%" runat="server" ></asp:TextBox>
                                </div>
                            </div>


                             <%--  <div  hidden="hidden">
                                 <div class="weui-cell__hd">
                                    <label class="weui-label">工艺路线</label></div>
                                 <div class="weui-cell__bd">
                                    <asp:TextBox ID="txt_routing"  class="weui-input"  Style="max-width: 100%" runat="server"></asp:TextBox>
                                </div>
                            </div>--%>
                                                
                            <%--<div hidden="hidden">
                                <div class="weui-cell__hd">
                                    <label class="weui-label">Bom</label>
                                </div>
                                <div class="weui-cell__bd">
                                    <asp:TextBox ID="txt_Bom" class="weui-input" Style="max-width: 100%;" runat="server"></asp:TextBox>
                                </div>
                            </div>
                                    
                           
                             <div  hidden="hidden">
                                 <div class="weui-cell__hd">
                                    <label class="weui-label">域</label></div>
                                 <div class="weui-cell__bd">
                                     <asp:TextBox ID="txt_domain" class="weui-input"  Style="max-width: 100%;" runat="server"></asp:TextBox>
                                </div>
                            </div>
                          

                            <div   class="weui-cell">
                                 <div class="weui-cell__hd">
                                    <label class="weui-label f-red ">Lot No</label></div>
                                 <div class="weui-cell__bd">
                                     <span style="float:left; width:90%">
                                     <asp:TextBox ID="txt_lotno" class="weui-input"  runat="server" placeholder="请输入Lot No"></asp:TextBox> </span>
                                    <span style="float:left; width:10%">
                                     <img id="img_sm" src="../img/fdj2.png" style="padding-top:10px;" />
                                </span>
                                </div>
                            </div>

     
                            <%-- <div class="weui-cell">
                                 <div class="weui-cell__hd">
                                    <label class="weui-label">项目号</label></div>
                                 <div class="weui-cell__bd">
                                       <asp:DropDownList ID="txt_xmh"  class="weui-input" runat="server" ></asp:DropDownList>
                                       <asp:TextBox ID="txt_pgino"  CssClass="hidden"    Style="max-width: 100%" runat="server"></asp:TextBox>
                                </div>
                            </div>--%>


                             <%-- <div class="weui-cell">
                                 <div class="weui-cell__hd">
                                    <label class="weui-label">零件号</label></div>
                                 <div class="weui-cell__bd">
                                   <asp:TextBox ID="txt_pn" class="weui-input" Style="max-width: 100%" runat="server"></asp:TextBox>
                                </div>
                            </div>

                      
                          

                             <div  hidden="hidden">
                                 <div class="weui-cell__hd">
                                    <label class="weui-label">物料描述</label></div>
                                 <div class="weui-cell__bd">
                                     <asp:TextBox ID="txt_desc" class="weui-input" Style="max-width: 100%" runat="server"></asp:TextBox>
                                </div>
                            </div>--%>


                             




                        <%--</ContentTemplate>
                    </asp:UpdatePanel>--%>
                    <div class="weui-cell">
                        <asp:Button ID="btnsave"  class="weui-btn weui-btn_primary"  runat="server" Text="上线" OnClick="btnsave_Click" OnClientClick="return valid();" />
                        <asp:Button ID="btn_cancel" class="weui-btn weui-btn_primary" runat="server" Text="退回" OnClientClick="return valid_cancel();" style="margin-left:10px;" />
                    </div>
                     
                    

              

        </div>
    </form>
</body>
</html>

