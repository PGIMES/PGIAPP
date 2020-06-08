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
        
       .collapse li.js-show .weui-flex{
           opacity:1;
       }
        /*.weui-cells:before{
            border-top:1px dashed #e5e5e5
        }
        .weui-cells:after{
            border-bottom:1px dashed #e5e5e5
        }
        .weui-form-preview:before{
            border-top:1px dashed #e5e5e5
        }
        .weui-form-preview:after{
            border-bottom:1px dashed #e5e5e5
        }*/
    </style>
    
</head>
<body>
    <script>  

        $(document).ready(function () {
            var lotno = '<%=_lotno%>';
            var needno = '<%=_needno%>';
            Bind_Lotno(lotno,needno);
        });

        $(function () {
            $('.collapse .js-category').find('label').css("color", "#e0e0e0");

            $('.collapse .js-category').click(function () {
                $parent = $(this).parent('li');
                if ($parent.hasClass('js-show')) {
                    $parent.removeClass('js-show');
                    $(this).children('i').removeClass('icon-35').addClass('icon-74');

                    $(this).find('label').css("color", "#e0e0e0");
                } else {
                    $parent.siblings().removeClass('js-show');
                    $parent.addClass('js-show');
                    $(this).children('i').removeClass('icon-74').addClass('icon-35');
                    $parent.siblings().find('i').removeClass('icon-35').addClass('icon-74');

                    $(this).find('label').css("color", "#428BCA");
                }
            });

            $("ul li .js-category").find("label").each(function () {
                if ($(this).text().indexOf("<%= _lotno %>")>=0) {
                    $(this).parent().parent().siblings().removeClass('js-show');
                    $(this).parent().parent().addClass('js-show');
                    $(this).parent().parent().children('i').removeClass('icon-74').addClass('icon-35');
                    $(this).parent().parent().siblings().find('i').removeClass('icon-35').addClass('icon-74');

                    //单号红色
                    $(this).css("color", "#428BCA");

                    //处置信息
                    $(this).parent().children('div').children().css("color", "#428BCA");

                } 
            });
            
            $('#btn_save').click(function () {
                $("#btn_save").attr("disabled", "disabled");
                $("#btn_save").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');

                $("#btn_cancel").attr("disabled", "disabled");
                $("#btn_cancel").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');

                if ($("#txt_qty").text() == "") {
                    layer.alert('【上料数量】不可为空');

                    $("#btn_save").removeAttr("disabled");
                    $("#btn_save").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                    $("#btn_cancel").removeAttr("disabled");
                    $("#btn_cancel").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                    return;
                }

                $.ajax({
                    type: "post",
                    url: "Load_Material.aspx/Save_Sku",
                    data: "{'emp':'" + $("#emp_code_name").val() + "','needno':'" + "<%= _needno %>" + "','lotno':'" + "<%= _lotno %>" + "','para':'" + "<%= _para %>" + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                    success: function (data) {
                        var obj = eval(data.d);
                        var flag = obj[0].flag;
                        if (flag == "N") {
                            $("#btn_save").removeAttr("disabled");
                            $("#btn_save").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                            $("#btn_cancel").removeAttr("disabled");
                            $("#btn_cancel").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                            layer.alert(obj[0].msg);
                        } else  if (flag == "Y") {
                            layer.alert(obj[0].msg, {}, function (index) {
                                layer.close(index);
                                window.location.href = "/workorder/YL_List_new.aspx?workshop=<%=_workshop %>";
                            });
                        } else if (flag == "Y1") {
                            layer.alert(obj[0].msg, {}, function (index) {
                                layer.close(index);
                                window.location.href = "/workorder/Emp_Login.aspx?workshop=<%=_workshop %>";
                            });
                        }

                    }
                });

            });

            $('#btn_cancel').click(function () {
                $("#btn_save").attr("disabled", "disabled");
                $("#btn_save").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');

                $("#btn_cancel").attr("disabled", "disabled");
                $("#btn_cancel").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');

                var qty = $("#txt_qty").text();

                $.confirm('确认要【退回】【数量' + qty + '】吗？', function () {
                    //点击确认后的回调函数
                    $.ajax({
                        type: "post",
                        url: "Load_Material.aspx/Reject_Sku",
                        data: "{'emp':'" + "<%= _emp %>" + "','needno':'" + "<%= _needno %>" + "','lotno':'" + "<%= _lotno %>" + "','reject_qty':'" + qty + "','source':'1'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                        success: function (data) {
                            var obj = eval(data.d);
                            var flag = obj[0].flag;
                            if (flag == "Y") {
                                $("#btn_save").removeAttr("disabled");
                                $("#btn_save").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                                $("#btn_cancel").removeAttr("disabled");
                                $("#btn_cancel").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                                layer.alert(obj[0].msg);
                            } else {
                                window.location.href = "/workorder/YL_List_new.aspx?workshop=<%=_workshop %>";
                            }
                            
                        }
                    });
                }, function () {
                    //点击取消后的回调函数
                    $("#btn_save").removeAttr("disabled");
                    $("#btn_save").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                    $("#btn_cancel").removeAttr("disabled");
                    $("#btn_cancel").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                    return;
                });
            });
        });

        
        function Bind_Lotno(lotno, needno) {
            $.ajax({
                type: "post",
                url: "Load_Material.aspx/Set_Lotno",
                data: "{'lotno':'" + lotno + "','needno':'" + needno + "','para':'" + "<%= _para %>" + "','emp':'" + "<%= _emp %>" + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    if (data) {
                        $.each(eval(data.d), function (i, item) {
                            if (item.text == "Y") {
                                layer.alert(item.value);
                                $("#txt_wlh").text("");
                                $("#sku_desc").text("");
                                $("#txt_qty").text("");
                                $("#txt_location").text("");
                                $("#txt_load_person").text("");
                                $("#txt_load_time").text("");

                                $("#btn_save").attr("disabled", "disabled");
                                $("#btn_save").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');

                                $("#btn_cancel").attr("disabled", "disabled");
                                $("#btn_cancel").removeClass('weui-btn_primary').addClass('weui_btn_disabled weui_btn_default');
                            }
                            else {
                                $("#txt_wlh").text(item.sku);
                                $("#sku_desc").text(item.sku_desc);
                                $("#txt_qty").text(item.qty);
                                $("#txt_location").text(item.location);
                                $("#txt_load_person").text(item.person);
                                $("#txt_load_time").text(item.times);

                                $("#btn_save").removeAttr("disabled");
                                $("#btn_save").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');

                                $("#btn_cancel").removeAttr("disabled");
                                $("#btn_cancel").removeClass('weui_btn_disabled weui_btn_default').addClass('weui-btn_primary');
                            }
                        });
                    }
                }
            });
        }


    </script>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server">
        </asp:ScriptManager>
        <div class="weui-cells weui-cells_form">
            
            <asp:TextBox ID="emp_code_name" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="display:none;"></asp:TextBox>

            <div class="weui-form-preview">
                <%--要料信息--%>
                <ul class="collapse">
                    <li>
                        <div class="weui-flex js-category">
                            <div class="weui-flex__item" >
                                <label class="weui-form-preview__label">要料信息</label>
                            </div>
                            <label class="weui-form-preview__label">单号:<%= _needno%></label>
                            <i class="icon icon-74"></i>
                        </div>
                        <div class="page-category js-categoryInner">
                            <div class="weui-cells page-category-content">
                                <div class="weui-form-preview__bd">
                                    <asp:Repeater runat="server" ID="listBxInfo_YL">
                                        <ItemTemplate>                         
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">要料人</label>
                                                <span class="weui-form-preview__value"><%# Eval("phone")+""+ Eval("emp_name") %></span>
                                            </div>                          
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">要料时间</label>
                                                <span class="weui-form-preview__value"><%# Eval("req_date") %></span>
                                            </div>
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">岗位</label>
                                                <span class="weui-form-preview__value"><%# Eval("location_desc") %></span>
                                            </div>
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">物料号</label>
                                                <span class="weui-form-preview__value"><%# Eval("pgino") %></span>
                                            </div>
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">零件号</label>
                                                <span class="weui-form-preview__value"><%# Eval("pn") %></span>
                                            </div>
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">要料数量</label>
                                                <span class="weui-form-preview__value"><%# Eval("need_qty") %></span>
                                            </div>
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">要求送到时间</label>
                                                <span class="weui-form-preview__value">
                                                    <%# Eval("need_date","{0:MM-dd HH:mm}") +""%>
                                                    <font class="f-blue"><%# "|"+Eval("need_date_dl_desc") %></font>
                                                </span>
                                            </div>  
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>


                <% foreach (System.Data.DataRow dr_ in dt_infor.Rows)
                {%>
                <ul class="collapse">
                    <li class="">
                        <div class="weui-flex js-category">
                            <div class="weui-flex__item" >
                                <label class="weui-form-preview__label"><%=dr_["title"] %></label>
                            </div>
                            <label class="weui-form-preview__label"><%=dr_["title_desc"] %></label>
                            <i class="icon icon-74"></i>
                        </div>
                        <div class="page-category js-categoryInner">
                            <div class="weui-cells page-category-content">
                                <div class="weui-form-preview__bd ">
                                 <%if (dr_["title"].ToString() == "送料信息")
                                { %>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">送料人</label>
                                        <span class="weui-form-preview__value"><%= dr_["phone"]+""+ dr_["emp_name"] %></span>
                                    </div>   
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">送料数量</label>
                                        <span class="weui-form-preview__value"><%= dr_["deal_qty"] %></span>
                                    </div>  
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">送料时间</label>
                                        <span class="weui-form-preview__value">
                                            <%= string.Format("{0:MM-dd HH:mm}",dr_["deal_time"])%>
                                            <span style="color:<%= dr_["times_type"].ToString()=="还差"?"#10AEFF":(dr_["times_type"].ToString()=="超时"?"red":"#999999") %>;">
                                                <%= dr_["times_type"] +""+ dr_["times"] %>
                                            </span>
                                        </span>
                                    </div>  
                                <%} %>

                                 <%if (dr_["title"].ToString() == "上料信息" || dr_["title"].ToString() == "退料信息" || dr_["title"].ToString() == "取消要料")
                                { %>
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label"><%= dr_["keys"] %>人</label>
                                        <span class="weui-form-preview__value"><%= dr_["phone"]+""+ dr_["emp_name"] %></span>
                                    </div>   
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label"><%= dr_["keys"] %>数量</label>
                                        <span class="weui-form-preview__value"><%= dr_["deal_qty"] %></span>
                                    </div>  
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label"><%= dr_["keys"] %>时间</label>
                                        <span class="weui-form-preview__value"> <%= string.Format("{0:MM-dd HH:mm}",dr_["deal_time"])%></span>
                                    </div>  
                                
                                <%} %>
                                    
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>

                <%}%>
            </div>

            <div class="weui-form-preview">

                 <div class="weui-form-preview__hd">
                    <div class="weui-form-preview__item">
                       
                       <label class="weui-form-preview__">上料单号:<% =_lotno %></label>
                    </div>
                </div>

                <div class="weui-form-preview__bd">
                    <div class="weui-form-preview__item">
                        <label class="weui-form-preview__label1  ">物料号</label>
                        <span class="weui-form-preview__value1" ID="txt_wlh"></span>
                    </div>

                    <div class="weui-form-preview__item">
                        <label class="weui-form-preview__label1 ">零件号</label>
                        <span class="weui-form-preview__value1" ID="sku_desc"></span>
                    </div>

                    <div class="weui-form-preview__item">
                        <label class="weui-form-preview__label1 ">上料数量</label>
                        <span class="weui-form-preview__value1" ID="txt_qty"></span>
                    </div> 

                    <div class="weui-form-preview__item">
                        <label class="weui-form-preview__label">岗位</label>
                        <span class="weui-form-preview__value" ID="txt_location"></span>
                    </div>

                    <div class="weui-form-preview__item">
                        <label class="weui-form-preview__label">上料人</label>
                        <span class="weui-form-preview__value" id="txt_load_person"></span>
                    </div>

                    <div class="weui-form-preview__item">
                        <label class="weui-form-preview__label ">上料时间</label>
                        <span class="weui-form-preview__value" id="txt_load_time"></span>
                    </div>                          

                </div>
            </div>

            <div class="weui-cell">
                <%--<asp:Button ID="btnsave" class="weui-btn weui-btn_primary"  runat="server" Text="上线" OnClick="btnsave_Click" />--%>
                <input id="btn_save" type="button" class="weui-btn weui-btn_primary" value="上线" />
                <input id="btn_cancel" type="button" class="weui-btn weui-btn_primary" value="退料" style="margin-left:10px;" />
            </div>

        </div>
    </form>
</body>
</html>

