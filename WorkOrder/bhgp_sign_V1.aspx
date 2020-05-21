<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bhgp_sign_V1.aspx.cs" Inherits="WorkOrder_bhgp_sign_V1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>不合格处置</title>
    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <script src="/Content/layer/layer.js"></script>

    <link href="../css/weui.css" rel="stylesheet" />
    <link href="../css/weuix.css" rel="stylesheet" />
    <script src="../js/zepto.min.js"></script>
    <script src="../js/zepto.weui.js"></script>
    <script>
        $(function(){
            $('.collapse .js-category').click(function(){
                $parent = $(this).parent('li');
                if($parent.hasClass('js-show')){
                    $parent.removeClass('js-show');
                    $(this).children('i').removeClass('icon-35').addClass('icon-74');
                }else{
                    $parent.siblings().removeClass('js-show');
                    $parent.addClass('js-show');
                    $(this).children('i').removeClass('icon-74').addClass('icon-35');
                    $parent.siblings().find('i').removeClass('icon-35').addClass('icon-74');
                }
            });

            var bg = 0;
            $("ul li").find("#dh_s").each(function () {
                if ("<%= _workorder_f %>" == $(this).text()) {
                    $(this).parent().parent().parent().siblings().removeClass('js-show');
                    $(this).parent().parent().parent().addClass('js-show');
                    $(this).parent().parent().parent().children('i').removeClass('icon-74').addClass('icon-35');
                    $(this).parent().parent().parent().siblings().find('i').removeClass('icon-35').addClass('icon-74');

                    //单号红色
                    $(this).parent().css("color", "red");
                    $(this).parent().css("font-weight", "800");

                    //处置信息
                    $(this).parent().parent().children('div').children().css("color", "red");
                    $(this).parent().parent().children('div').children().css("font-weight", "800");

                    bg = 1;
                } 
            });

            if (bg == 0 && "<%= _workorder_f %>" !="") {
                $("#sp_cz").parent().parent().parent().siblings().removeClass('js-show');
                $("#sp_cz").parent().parent().parent().addClass('js-show');
                $("#sp_cz").parent().parent().parent().children('i').removeClass('icon-74').addClass('icon-35');
                $("#sp_cz").parent().parent().parent().siblings().find('i').removeClass('icon-35').addClass('icon-74');

                //单号红色
                $("#sp_cz").parent().css("color", "red");
                $("#sp_cz").parent().css("font-weight", "800");

                //处置信息
                $("#sp_cz").parent().parent().children('div').children().css("color", "red");
                $("#sp_cz").parent().parent().children('div').children().css("font-weight", "800");
            }

            $("#fg_comment").attr("placeholder", "请填写"+$("#lbl_fg").text()+"说明");

        });

    </script>
    <style>
         .weui-mark-lt {
            color: #fff;
            display: block;
            font-size: 0.775em !important;
            left: -0.5em;
            height: 1em;
            line-height: 1em !important;
            position: relative;
            text-align: center;
            top: 0.55em;
            transform: rotate(-45deg);
            width: 3.375em;
            padding: 0.125em;
        }
    </style>
    <style>
        .weui-cell{
            padding:4px 15px;
        }
        .weui-btn + .weui-btn{
            margin-top:0px;
        }
        #UpdatePanel1 .weui-cell:before{
            border-top:none;
        }
        .collapse li.js-show .weui-flex{
            opacity:1;
        }
    </style>

</head>
<body>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <%--步骤二：通过config接口注入权限验证配置--%>
    <script>    

        $(document).ready(function () {
            if ($("#workorder_qc").val() != "") {
                if ($("#workorder_qc").val().substr(0, 1).toUpperCase() == "W") {
                    $("#lbl_workorder_qc").text("生产完成单号");
                } else {
                    $("#lbl_workorder_qc").text("参考号");
                }
            }

            $("#btn_sign").hide();
            $("#btn_cancel").hide();
            $("#div_com").hide();

            $.ajax({
                type: "post",
                url: "bhgp_sign.aspx/init_btn",
                data: "{'stepid':'" + "<%= _stepid %>" + "','workshop':'" + "<%= _workshop %>" + "','pgino':'" + $("#pgino").val() + "','emp':'" + $("#emp_code_name").val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    var obj = eval(data.d);

                    if (obj[0].btn_sure == "Y") {
                        $("#btn_sign").show();
                    }
                    if (obj[0].btn_cancel == "Y") {
                        $("#btn_cancel").show();
                    }
                    if (obj[0].btn_sure == "Y" || obj[0].btn_cancel == "Y") {
                        $("#div_com").show();
                    }
                    return;
                }
            });
            
        });
        $(function () {
            $('#t1').tab({
                defaultIndex: 1,
                activeClass: 'tab-green',
                onToggle: function (index) {
                    //console.log('index' + index);

                }
            });
        });
      
    </script>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server">
        </asp:ScriptManager>

        <div class="weui-tab" id="t1">
            <div class="weui-navbar">
                <div href="#tab1" class="weui-navbar__item">
                    申请
                </div>
                <div href="#tab2" class="weui-navbar__item">
                    处置
                </div>
            </div>
            <div class="weui-tab__panel">
                 <%--=======申请-----%>
                <div id="tab1" class="weui-tab__content">                    
                    <div class="weui-form-preview__hd">
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label">申请信息</label>
                            <label class="weui-form-preview__">单号:<% = _workorder %></label>
                        </div>
                    </div>
                    <div class="weui-form-preview__bd">
                        <asp:Repeater runat="server" ID="listBxInfo" OnItemDataBound="listBxInfo_ItemDataBound">
                            <ItemTemplate>
                                <div class="weui-mark-vip">
                                     <span class="weui-mark-lt"></span>
                                </div>
                            
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">产线</label>
                                    <span class="weui-form-preview__value"><%= _workshop %>/<%# Eval("line") %></span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">物料号</label>
                                    <span class="weui-form-preview__value"><%# Eval("pgino")+","+Eval("pn") %></span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">零件名称</label>
                                    <span class="weui-form-preview__value"><%# Eval("descr") %></span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">工序</label>
                                    <span class="weui-form-preview__value"><%# Eval("op") +""+ Eval("op_descr") %></span>
                                </div>
                                <div class="weui-form-preview__item" style="display:<%# Eval("workorder_qc").ToString()!=""?"block":"none"%>; ">
                                    <label class="weui-form-preview__label" id="lbl_workorder_qc"></label>
                                    <span class="weui-form-preview__value"><%# Eval("workorder_qc") %></span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">申请数量</label>
                                    <span class="weui-form-preview__value"><%# Eval("qty") %></span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">剩余数量</label>
                                    <span class="weui-form-preview__value"><%# Eval("sy_qty") %></span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">原因名称</label>
                                    <span class="weui-form-preview__value"><%# Eval("reason_code") +""+ Eval("reason") %></span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">说明</label>
                                    <span class="weui-form-preview__value"><%# Eval("comment") %></span>
                                </div>
                                <asp:Repeater runat="server" ID="listBx_lotno">
                                    <ItemTemplate>
                                        <div class="weui-form-preview__bd">
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">Lot No</label>
                                                <span class="weui-form-preview__value"><%# Eval("lot_no") %></span>
                                            </div>
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">数量</label>
                                                <span class="weui-form-preview__value"><%# Eval("qty") %></span>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">申请人</label>
                                    <span class="weui-form-preview__value"><%# Eval("phone") %><%# Eval("emp_name") %></span>
                                </div> 
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">申请时间</label>
                                    <span class="weui-form-preview__value">
                                        <%# Eval("create_date","{0:MM/dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                                    </span>
                                </div> 
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>

                <div id="tab2" class="weui-tab__content">
                    <div class="weui-cells weui-cells_form">

                        <div class="weui-form-preview">
                            <asp:TextBox ID="emp_code_name" class="form-control" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                            <asp:TextBox ID="domain" class="form-control" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                            <asp:TextBox ID="workorder" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                            <asp:TextBox ID="workorder_f" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                            <asp:TextBox ID="stepid" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                            <asp:TextBox ID="pgino" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                            <asp:TextBox ID="workorder_qc" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>


                        </div>

                        <ul class="collapse" style="display:<%= ViewState["dt1"].ToString()!="0"?"block":"none"%>;">
                            <li id="li_cz_one">
                                <div class="weui-flex js-category" >
                                    <div class="weui-flex__item" >
                                        <label class="weui-form-preview__label">处置</label>
                                    </div>
                                    <label class="weui-form-preview__label">
                                        <span id="sp_cz"></span>
                                    </label>
                                    <i class="icon icon-74"></i>
                                </div>
                                <div class="page-category js-categoryInner">
                                    <div class="weui-cells page-category-content">
                                        <div class="weui-form-preview__bd">
                                            <asp:Repeater runat="server" ID="Repeater_cz_one" OnItemDataBound="Repeater_cz_one_ItemDataBound">
                                                <ItemTemplate>
                                                    <div class="weui-form-preview__item"style="display:none;">
                                                        <label class="weui-form-preview__label">分单号</label>
                                                        <span class="weui-form-preview__value"><%# Eval("workorder_f") %></span>
                                                    </div>
                                                    <asp:Repeater runat="server" ID="Repeater_cz_one_dt">
                                                        <ItemTemplate>
                                                            <div class="weui-mark-vip">
                                                                <span class="weui-mark-lt"></span>
                                                            </div>
                                                            <div class="weui-form-preview__item" style="display:none;">
                                                                <label class="weui-form-preview__label">num</label>
                                                                <span class="weui-form-preview__value"><%# Eval("num") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item" style="border-top:1px solid #e5e5e5">
                                                                <label class="weui-form-preview__label">处置数量</label>
                                                                <span class="weui-form-preview__value"><%# Eval("qty") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">判断为</label>
                                                                <span class="weui-form-preview__value"><%# Eval("result") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item" style="display:<%# Eval("result").ToString()=="不合格"?"block":"none"%>; ">
                                                                <label class="weui-form-preview__label">废品原因</label>
                                                                <span class="weui-form-preview__value"><%# Eval("reason_code")+""+Eval("reason") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">关联单号</label>
                                                                <span class="weui-form-preview__value"><%# Eval("workorder_gl") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">原因说明</label>
                                                                <span class="weui-form-preview__value"><%# Eval("comment") %></span>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">处置人</label>
                                                        <span class="weui-form-preview__value"><%# Eval("phone") %><%# Eval("emp_name") %></span>
                                                    </div> 
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">处置时间</label>
                                                        <span class="weui-form-preview__value">
                                                            <%# Eval("create_date","{0:yyyy-MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                                                        </span>
                                                    </div> 
                                                    <asp:Repeater runat="server" ID="Repeater_sg_one_dt">
                                                        <ItemTemplate>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label"><%# Eval("sign_stepname") %></label>
                                                                <span class="weui-form-preview__value"><%# Eval("phone")+""+Eval("sign_empname") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">签核时间</label>
                                                                <span class="weui-form-preview__value">
                                                                    <%# Eval("sign_time","{0:yyyy-MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                                                                </span>
                                                            </div> 
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">签核意见</label>
                                                                <span class="weui-form-preview__value"><%# Eval("sign_comment") %></span>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater> 
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">处置结果</label>
                                                        <span class="weui-form-preview__value"><%# "<font class='f-red'>"+Eval("status_desc")+"</font>" %></span>
                                                    </div>            
                                                    <asp:Repeater runat="server" ID="Repeater_rk_one_dt">
                                                        <ItemTemplate>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">仓库接收单号</label>
                                                                <span class="weui-form-preview__value"><%# Eval("workorder") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">接收数量</label>
                                                                <span class="weui-form-preview__value"><%# Eval("act_qty") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">仓库接收人</label>
                                                                <span class="weui-form-preview__value"><%# Eval("phone")+""+Eval("emp_name") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">接收时间</label>
                                                                <span class="weui-form-preview__value">
                                                                    <%# Eval("create_date","{0:yyyy-MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                                                                </span>
                                                            </div> 
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">接收意见</label>
                                                                <span class="weui-form-preview__value"><%# Eval("comment") %></span>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>                               
                                                </ItemTemplate>
                                            </asp:Repeater>   
                                        </div>
                                    </div>
                                </div>                            
                            </li>
                        </ul>

                        <ul class="collapse" style="display:<%= ViewState["dt2"].ToString()!="0"?"block":"none"%>;">
                            <asp:Repeater runat="server" ID="Repeater_fg" OnItemDataBound="Repeater_fg_ItemDataBound">
                                <ItemTemplate>
                                    <li>
                                        <div class="weui-flex js-category"  style="border-top:1px solid #e5e5e5">
                                            <div class="weui-flex__item" >
                                                <label class="weui-form-preview__label">返工</label>
                                            </div>
                                            <label class="weui-form-preview__label">
                                                <span id="dh_s"><%# Eval("workorder_f")%></span>
                                                <span style="display:<%# Eval("workorder_f_a").ToString()!=""?"block":"none"%>;"><%# ">"+Eval("workorder_f_a")%></span>
                                            </label>
                                            <i class="icon icon-74"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells page-category-content">
                                                <div class="weui-form-preview__bd">
                                                    <asp:Repeater runat="server" ID="Repeater_fg_dt">
                                                        <ItemTemplate>
                                                            <div class="weui-mark-vip">
                                                                <span class="weui-mark-lt"></span>
                                                            </div>
                                                            <div class="weui-form-preview__item" style="display:none;">
                                                                <label class="weui-form-preview__label">num</label>
                                                                <span class="weui-form-preview__value"><%# Eval("num") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">处置数量</label>
                                                                <span class="weui-form-preview__value"><%# Eval("qty") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">判断为</label>
                                                                <span class="weui-form-preview__value"><%# Eval("result") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item" style="display:<%# Eval("result").ToString()=="不合格"?"block":"none"%>; ">
                                                                <label class="weui-form-preview__label">废品原因</label>
                                                                <span class="weui-form-preview__value"><%# Eval("reason_code")+""+Eval("reason") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">关联单号</label>
                                                                <span class="weui-form-preview__value"><%# Eval("workorder_gl") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">原因说明</label>
                                                                <span class="weui-form-preview__value"><%# Eval("comment") %></span>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">处置人</label>
                                                        <span class="weui-form-preview__value"><%# Eval("phone") %><%# Eval("emp_name") %></span>
                                                    </div> 
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">处置时间</label>
                                                        <span class="weui-form-preview__value">
                                                            <%# Eval("create_date","{0:yyyy-MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                                                        </span>
                                                    </div> 
                                                    <asp:Repeater runat="server" ID="Repeater_fg_sg_dt">
                                                        <ItemTemplate>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label"><%# Eval("sign_stepname") %></label>
                                                                <span class="weui-form-preview__value"><%# Eval("phone")+""+Eval("sign_empname") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">签核时间</label>
                                                                <span class="weui-form-preview__value">
                                                                    <%# Eval("sign_time","{0:yyyy-MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                                                                </span>
                                                            </div> 
                                                        </ItemTemplate>
                                                    </asp:Repeater>  
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">返工说明</label>
                                                        <span class="weui-form-preview__value"><%# Eval("fg_comment") %></span>
                                                    </div>
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">处置结果</label>
                                                        <span class="weui-form-preview__value"><%# "<font class='f-red'>"+Eval("status_desc")+"</font>" %></span>
                                                    </div>  
                                                </div>
                                            </div>
                                        </div>    
                                    </li>                                        
                                </ItemTemplate>
                            </asp:Repeater> 
                        </ul>

                        <ul class="collapse" style="display:<%= ViewState["dt3"].ToString()!="0"?"block":"none"%>;">
                            <asp:Repeater runat="server" ID="Repeater_cz_again" OnItemDataBound="Repeater_cz_again_ItemDataBound">
                                <ItemTemplate>
                                    <li>
                                        <div class="weui-flex js-category"  style="border-top:1px solid #e5e5e5">
                                            <div class="weui-flex__item" >
                                                <label class="weui-form-preview__label">处置</label>
                                            </div>
                                            <label class="weui-form-preview__label"><span id="dh_s"><%# Eval("workorder_f")%></span><%# ">"+Eval("workorder_f_a")%></label>
                                            <i class="icon icon-74"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells page-category-content">
                                                <div class="weui-form-preview__bd">
                                                    <asp:Repeater runat="server" ID="Repeater_cz_again_dt">
                                                        <ItemTemplate>
                                                            <div class="weui-mark-vip">
                                                                <span class="weui-mark-lt"></span>
                                                            </div>
                                                            <div class="weui-form-preview__item" style="display:none;">
                                                                <label class="weui-form-preview__label">num</label>
                                                                <span class="weui-form-preview__value"><%# Eval("num") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">处置数量</label>
                                                                <span class="weui-form-preview__value"><%# Eval("qty") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">判断为</label>
                                                                <span class="weui-form-preview__value"><%# Eval("result") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item" style="display:<%# Eval("result").ToString()=="不合格"?"block":"none"%>; ">
                                                                <label class="weui-form-preview__label">废品原因</label>
                                                                <span class="weui-form-preview__value"><%# Eval("reason_code")+""+Eval("reason") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">关联单号</label>
                                                                <span class="weui-form-preview__value"><%# Eval("workorder_gl") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">原因说明</label>
                                                                <span class="weui-form-preview__value"><%# Eval("comment") %></span>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">处置人</label>
                                                        <span class="weui-form-preview__value"><%# Eval("phone") %><%# Eval("emp_name") %></span>
                                                    </div> 
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">处置时间</label>
                                                        <span class="weui-form-preview__value">
                                                            <%# Eval("create_date","{0:yyyy-MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                                                        </span>
                                                    </div> 
                                                    <asp:Repeater runat="server" ID="Repeater_sg_again_dt">
                                                        <ItemTemplate>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label"><%# Eval("sign_stepname") %></label>
                                                                <span class="weui-form-preview__value"><%# Eval("phone")+""+Eval("sign_empname") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">签核时间</label>
                                                                <span class="weui-form-preview__value">
                                                                    <%# Eval("sign_time","{0:yyyy-MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                                                                </span>
                                                            </div> 
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">签核意见</label>
                                                                <span class="weui-form-preview__value"><%# Eval("sign_comment") %></span>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>  
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">处置结果</label>
                                                        <span class="weui-form-preview__value"><%# "<font class='f-red'>"+Eval("status_desc")+"</font>" %></span>
                                                    </div>  
                                                    <asp:Repeater runat="server" ID="Repeater_rk_again_dt">
                                                        <ItemTemplate>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">仓库接收单号</label>
                                                                <span class="weui-form-preview__value"><%# Eval("workorder") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">接收数量</label>
                                                                <span class="weui-form-preview__value"><%# Eval("act_qty") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">仓库接收人</label>
                                                                <span class="weui-form-preview__value"><%# Eval("phone")+""+Eval("emp_name") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">接收时间</label>
                                                                <span class="weui-form-preview__value">
                                                                    <%# Eval("create_date","{0:yyyy-MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                                                                </span>
                                                            </div> 
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">接收意见</label>
                                                                <span class="weui-form-preview__value"><%# Eval("comment") %></span>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </div>
                                            </div>
                                        </div>    
                                    </li>                                        
                                </ItemTemplate>
                            </asp:Repeater> 
                        </ul>

                        <ul class="collapse" style="display:<%= ViewState["dt4"].ToString()!="0"?"block":"none"%>;">
                            <asp:Repeater runat="server" ID="Repeater_fx" OnItemDataBound="Repeater_fx_ItemDataBound">
                                <ItemTemplate>
                                    <li>
                                        <div class="weui-flex js-category"  style="border-top:1px solid #e5e5e5">
                                            <div class="weui-flex__item" >
                                                <label class="weui-form-preview__label">分选</label>
                                            </div>
                                            <label class="weui-form-preview__label">
                                                <span id="dh_s"><%# Eval("workorder_f")%></span>
                                                <span style="display:<%# Eval("workorder_f_a").ToString()!=""?"block":"none"%>;"><%# ">"+Eval("workorder_f_a")%></span>
                                            </label>
                                            <i class="icon icon-74"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells page-category-content">
                                                <div class="weui-form-preview__bd">
                                                    <asp:Repeater runat="server" ID="Repeater_fx_dt">
                                                        <ItemTemplate>
                                                            <div class="weui-mark-vip">
                                                                <span class="weui-mark-lt"></span>
                                                            </div>
                                                            <div class="weui-form-preview__item" style="display:none;">
                                                                <label class="weui-form-preview__label">num</label>
                                                                <span class="weui-form-preview__value"><%# Eval("num") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">处置数量</label>
                                                                <span class="weui-form-preview__value"><%# Eval("qty") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">判断为</label>
                                                                <span class="weui-form-preview__value"><%# Eval("result") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item" style="display:<%# Eval("result").ToString()=="不合格"?"block":"none"%>; ">
                                                                <label class="weui-form-preview__label">废品原因</label>
                                                                <span class="weui-form-preview__value"><%# Eval("reason_code")+""+Eval("reason") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">关联单号</label>
                                                                <span class="weui-form-preview__value"><%# Eval("workorder_gl") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">原因说明</label>
                                                                <span class="weui-form-preview__value"><%# Eval("comment") %></span>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">处置人</label>
                                                        <span class="weui-form-preview__value"><%# Eval("phone") %><%# Eval("emp_name") %></span>
                                                    </div> 
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">处置时间</label>
                                                        <span class="weui-form-preview__value">
                                                            <%# Eval("create_date","{0:yyyy-MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                                                        </span>
                                                    </div> 
                                                    <asp:Repeater runat="server" ID="Repeater_fx_sg_dt">
                                                        <ItemTemplate>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label"><%# Eval("sign_stepname") %></label>
                                                                <span class="weui-form-preview__value"><%# Eval("phone")+""+Eval("sign_empname") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">签核时间</label>
                                                                <span class="weui-form-preview__value">
                                                                    <%# Eval("sign_time","{0:yyyy-MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                                                                </span>
                                                            </div> 
                                                        </ItemTemplate>
                                                    </asp:Repeater>  
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">分选说明</label>
                                                        <span class="weui-form-preview__value"><%# Eval("fg_comment") %></span>
                                                    </div>
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">处置结果</label>
                                                        <span class="weui-form-preview__value"><%# "<font class='f-red'>"+Eval("status_desc")+"</font>" %></span>
                                                    </div>  
                                                </div>
                                            </div>
                                        </div>    
                                    </li>                                        
                                </ItemTemplate>
                            </asp:Repeater> 
                        </ul>

                        <ul class="collapse" style="display:<%= ViewState["dt5"].ToString()!="0"?"block":"none"%>;">
                            <asp:Repeater runat="server" ID="Repeater_cz_fx_again" OnItemDataBound="Repeater_cz_fx_again_ItemDataBound">
                                <ItemTemplate>
                                    <li>
                                        <div class="weui-flex js-category"  style="border-top:1px solid #e5e5e5">
                                            <div class="weui-flex__item" >
                                                <label class="weui-form-preview__label">处置</label>
                                            </div>
                                            <label class="weui-form-preview__label"><span id="dh_s"><%# Eval("workorder_f")%></span><%# ">"+Eval("workorder_f_a")%></label>
                                            <i class="icon icon-74"></i>
                                        </div>
                                        <div class="page-category js-categoryInner">
                                            <div class="weui-cells page-category-content">
                                                <div class="weui-form-preview__bd">
                                                    <asp:Repeater runat="server" ID="Repeater_cz_fx_again_dt">
                                                        <ItemTemplate>
                                                            <div class="weui-mark-vip">
                                                                <span class="weui-mark-lt"></span>
                                                            </div>
                                                            <div class="weui-form-preview__item" style="display:none;">
                                                                <label class="weui-form-preview__label">num</label>
                                                                <span class="weui-form-preview__value"><%# Eval("num") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">处置数量</label>
                                                                <span class="weui-form-preview__value"><%# Eval("qty") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">判断为</label>
                                                                <span class="weui-form-preview__value"><%# Eval("result") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item" style="display:<%# Eval("result").ToString()=="不合格"?"block":"none"%>; ">
                                                                <label class="weui-form-preview__label">废品原因</label>
                                                                <span class="weui-form-preview__value"><%# Eval("reason_code")+""+Eval("reason") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">关联单号</label>
                                                                <span class="weui-form-preview__value"><%# Eval("workorder_gl") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">原因说明</label>
                                                                <span class="weui-form-preview__value"><%# Eval("comment") %></span>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">处置人</label>
                                                        <span class="weui-form-preview__value"><%# Eval("phone") %><%# Eval("emp_name") %></span>
                                                    </div> 
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">处置时间</label>
                                                        <span class="weui-form-preview__value">
                                                            <%# Eval("create_date","{0:yyyy-MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                                                        </span>
                                                    </div> 
                                                    <asp:Repeater runat="server" ID="Repeater_sg_fx_again_dt">
                                                        <ItemTemplate>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label"><%# Eval("sign_stepname") %></label>
                                                                <span class="weui-form-preview__value"><%# Eval("phone")+""+Eval("sign_empname") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">签核时间</label>
                                                                <span class="weui-form-preview__value">
                                                                    <%# Eval("sign_time","{0:yyyy-MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                                                                </span>
                                                            </div> 
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">签核意见</label>
                                                                <span class="weui-form-preview__value"><%# Eval("sign_comment") %></span>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater> 
                                                    <div class="weui-form-preview__item">
                                                        <label class="weui-form-preview__label">处置结果</label>
                                                        <span class="weui-form-preview__value"><%# "<font class='f-red'>"+Eval("status_desc")+"</font>" %></span>
                                                    </div>   
                                                    <asp:Repeater runat="server" ID="Repeater_rk_fx_again_dt">
                                                        <ItemTemplate>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">仓库接收单号</label>
                                                                <span class="weui-form-preview__value"><%# Eval("workorder") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">接收数量</label>
                                                                <span class="weui-form-preview__value"><%# Eval("act_qty") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">仓库接收人</label>
                                                                <span class="weui-form-preview__value"><%# Eval("phone")+""+Eval("emp_name") %></span>
                                                            </div>
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">接收时间</label>
                                                                <span class="weui-form-preview__value">
                                                                    <%# Eval("create_date","{0:yyyy-MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                                                                </span>
                                                            </div> 
                                                            <div class="weui-form-preview__item">
                                                                <label class="weui-form-preview__label">接收意见</label>
                                                                <span class="weui-form-preview__value"><%# Eval("comment") %></span>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </div>
                                            </div>
                                        </div>    
                                    </li>                                        
                                </ItemTemplate>
                            </asp:Repeater> 
                        </ul>


                        <div class="weui-cell" style="display:<%= _stepid=="0001"?"flex":"none"%>;">
                            <div class="weui-cell__hd">
                                <label class="weui-label" id="sp_fg"><asp:Label ID="lbl_fg" runat="server" Text=""></asp:Label>说明</label>
                            </div>
                            <textarea id="fg_comment" class="weui-textarea"  placeholder="请输入返工说明" rows="2"  
                                runat="server" value=''></textarea>
                        </div>
                        <div class="weui-cell" id="div_com"> <%--style="display:<%= _stepid!="9999"?"flex":"none"%>;"--%>
                            <div class="weui-cell__hd"><label class="weui-label">签核意见</label></div>
                            <textarea id="sign_comment" class="weui-textarea"  placeholder="请输入签核意见" rows="2"  
                                runat="server" value=''></textarea>
                        </div>
                        <div class="weui-cell" ><%--style="display:<%= _stepid!="9999"?"flex":"none"%>;"--%>
                            <asp:Button ID="btn_sign" class="weui-btn weui-btn_primary" runat="server" UseSubmitBehavior="false"  
                                Text="确认" OnClientClick="this.disabled=false;this.value='处理中…';" OnClick="btn_sure_Click" />
                            <asp:Button ID="btn_cancel" class="weui-btn weui-btn_primary" runat="server" UseSubmitBehavior="false"  
                                Text="退回" OnClientClick="this.disabled=false;this.value='处理中…';" OnClick="btn_cancel_Click" style="margin-left:10px;"/>
                        </div>
            
                    </div>

                </div>
            </div>
        </div>
        

    
    </form>
</body>
</html>
