<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bhgp_sign.aspx.cs" Inherits="WorkOrder_bhgp_sign" %>

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
                } 
            });

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
            if ("<%= _stepid %>"=="0005") {//总经理
                $("#btn_sign").show();
                $("#btn_cancel").show();
            } else if ("<%= _stepid %>" == "9999") {//已完成
                $("#btn_sign").hide();
                $("#btn_cancel").hide();
            }else {
                $("#btn_sign").show();
                $("#btn_cancel").hide();
            }
        });

      
    </script>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server">
        </asp:ScriptManager>
   

        <div class="weui-cells weui-cells_form">

            <div class="weui-form-preview">
                <asp:TextBox ID="emp_code_name" class="form-control" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                <asp:TextBox ID="domain" class="form-control" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                <asp:TextBox ID="workorder" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                <asp:TextBox ID="workorder_f" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>
                <asp:TextBox ID="stepid" class="weui-input" ReadOnly="true" placeholder="" style="color:gray;display:none;" runat="server"></asp:TextBox>

                <div class="weui-form-preview__hd">
                    <div class="weui-form-preview__item">
                        <label class="weui-form-preview__label">申请信息</label>
                        <label class="weui-form-preview__">单号:<% ="<font class='tag'/>"+_workorder %></label>
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

            <ul class="collapse" style="display:<%= ViewState["dt1"].ToString()!="0"?"block":"none"%>;">
                <li>
                    <div class="weui-flex js-category" >
                        <div class="weui-flex__item" >
                            <label class="weui-form-preview__label">处置</label>
                        </div>
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
                                            </ItemTemplate>
                                        </asp:Repeater>  
                                        <div class="weui-form-preview__item">
                                            <label class="weui-form-preview__label">处置结果</label>
                                            <span class="weui-form-preview__value"><%# "<font class='f-red'>"+Eval("status_desc")+"</font>" %></span>
                                        </div>                                           
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
                                            </ItemTemplate>
                                        </asp:Repeater>  
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

            <%--<ul class="collapse">
           <asp:Repeater runat="server" ID="Repeater_cz"  OnItemDataBound="Repeater_cz_ItemDataBound">
                <ItemTemplate>                    
                    <li>
                        <div class="weui-flex js-category" >
                            <div class="weui-flex__item" >
                                <label class="weui-form-preview__label">处置信息</label>
                            </div>
                            <label class="weui-form-preview__label">序列号:<span id="dh_s"><%# Eval("workorder_f")%></span></label>
                            <i class="icon icon-74"></i>
                        </div>
                        <div class="page-category js-categoryInner">
                            <div class="weui-cells page-category-content">
                                <div class="weui-form-preview__bd">
                                    <asp:Repeater runat="server" ID="Repeater_cz_dt">
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
                                                <label class="weui-form-preview__label"><span style="color:#10AEFF; font-weight:800;">关联单号</span></label>
                                                <span class="weui-form-preview__value"><span style="color:#10AEFF; font-weight:800;"><%# Eval("workorder_gl") %></span></span>
                                            </div>
                                            <div class="weui-form-preview__item">
                                                <label class="weui-form-preview__label">原因说明</label>
                                                <span class="weui-form-preview__value"><%# Eval("comment") %></span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>                                    
                                    <div class="weui-form-preview__item" style="display:<%# Eval("result").ToString()=="返工"?"block":"none"%>; ">
                                        <label class="weui-form-preview__label">返工说明</label>
                                        <span class="weui-form-preview__value"><%# Eval("fg_comment") %></span>
                                    </div>
                                    <div class="weui-form-preview__item" style="border-top:1px solid #e5e5e5">
                                        <label class="weui-form-preview__label">处置人</label>
                                        <span class="weui-form-preview__value"><%# Eval("phone") %><%# Eval("emp_name") %></span>
                                    </div> 
                                    <div class="weui-form-preview__item">
                                        <label class="weui-form-preview__label">处置时间</label>
                                        <span class="weui-form-preview__value">
                                            <%# Eval("create_date","{0:yyyy-MM-dd HH:mm}") +",时长: <font class='f-blue'>"+Eval("times")+"</font>" %>
                                        </span>
                                    </div> 
                                    <asp:Repeater runat="server" ID="Repeater_sg_dt">
                                        <ItemTemplate>
                                            <div class="weui-form-preview__item" style="border-top:1px solid #e5e5e5">
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
                                    <div class="weui-form-preview__item" style="border-top:1px solid #e5e5e5">
                                        <label class="weui-form-preview__label">处置结果</label>
                                        <span class="weui-form-preview__value"><%# "<font class='f-red'>"+Eval("status_desc")+"</font>" %></span>
                                    </div>
                                </div>
                            </div>
                        </div>                            
                    </li>
                </ItemTemplate>
            </asp:Repeater>
                
            </ul>--%>

            <div class="weui-cell" style="display:<%= _stepid=="0001"?"flex":"none"%>;">
                <div class="weui-cell__hd"><label class="weui-label">返工说明</label></div>
                <textarea id="fg_comment" class="weui-textarea"  placeholder="请输入返工说明" rows="2"  runat="server" value='<%# Eval("fg_comment") %>'></textarea>
            </div>
            <div class="weui-cell" style="display:<%= _stepid!="9999"?"flex":"none"%>;">
                <asp:Button ID="btn_sign" class="weui-btn weui-btn_primary" runat="server" Text="确认" OnClick="btn_sure_Click" />
                <asp:Button ID="btn_cancel" class="weui-btn weui-btn_primary" runat="server" Text="退回" OnClick="btn_cancel_Click"/>
            </div>
            
        </div>

    
    </form>
</body>
</html>
