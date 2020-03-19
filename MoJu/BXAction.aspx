<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BXAction.aspx.cs" Inherits="MoJu_BXAction" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>单号：<% =Request["dh"].ToString() %></title>
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0" />
    <link rel="stylesheet" href="../css/weui.css" />
    <link rel="stylesheet" href="../css/weuix.css" />
    <style>
        .weui-form-preview__value {
            /*font-size: 10pt;*/
        }
        .weui-mark-lt {
            color: #fff;
            display: block;
            font-size: 0.775em !important;
            left: -1.0875em;
            height: 1em;
            line-height: 1em !important;
            position: relative;
            text-align: center;
            top: 0.25em;
            transform: rotate(-45deg);
            width: 3.375em;
            padding: 0.125em;
        }
        .input{
            border-bottom:1px solid gray 
        }
        .tag{
            color:dodgerblue
        }
        .weui-form-preview__hd {     
            line-height: 1.2em;
        }
    </style>
    <script src="../js/zepto.min.js"></script>
    <script>
        $(function () {


        });

    </script>
</head>
<body ontouchstart>
    <form id="form1" runat="server">
        <div class="page-bd">
            <div class="weui-form-preview">
                <div class="weui-form-preview__hd">
                    <div class="weui-form-preview__item">
                        <label class="weui-form-preview__label">报修信息</label>
                        <label class="weui-form-preview__">时长:<% ="<font class='tag'/>"+bx_shichang %></label>
                    </div>
                </div>
                <div class="weui-form-preview__bd">
                    <asp:Repeater runat="server" ID="listBxInfo">
                        <ItemTemplate>
                            <div class="weui-mark-vip"><span class="weui-mark-lt <%# Eval("level").ToString()=="一级"?"bg-blue":"bg-orange"%>"><%#Eval("level") %></span></div>
                            
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">设备</label>
                                <span class="weui-form-preview__value"><%# Eval("bx_sbname") %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">模具</label>
                                <span class="weui-form-preview__value"><%# Eval("bx_moju_no")%> <%# Eval("bx_moju_type") %> </span>
                            </div>                             
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">零件号</label>
                                <span class="weui-form-preview__value"><%# Eval("bx_part") %> </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">故障类型/描述</label>
                                <span class="weui-form-preview__value"><%# Eval("bx_gz_type").ToString() +"| " %><%# Eval("bx_gz_desc") %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">报修人</label>
                                <span class="weui-form-preview__value"><%# Eval("cellphone").ToString()+" | " %><%# Eval("bx_name") %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">报修时间  </label>
                                <span class="weui-form-preview__value"><%# Eval("bx_date","{0:MM/dd HH:mm}")  %></span>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="weui-form-preview__bd " >
                    <asp:button type="button" class="weui-btn weui-btn_primary"   runat="server" id="btnStart" Text="开始维修" OnClick="btnStart_Click"></asp:button>
                </div>
            </div>
             
            

            <div class="weui-form-preview"  id="PageWX" hidden="hidden">
                <div class="weui-form-preview__hd">
                    <div class="weui-form-preview__item">
                        <label class="weui-form-preview__label">接修信息</label>
                        <label class="weui-form-preview__"></label>
                    </div>
                </div>
                <div class="weui-form-preview__bd">
                    <asp:Repeater runat="server" ID="listWXInfo">
                        <ItemTemplate>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">接修人</label>
                                <span class="weui-form-preview__value"><%# Eval("cellphone").ToString()+" | " %><%# Eval("wx_name") %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">接修时间/时长</label>
                                <span class="weui-form-preview__value"><%# Eval("wx_begin_date","{0:MM/dd HH:mm}") %> | <%# "<font class='tag'/>"+Eval("jx_shichang")+"</font>" %></span>

                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">维修措施</label>
                                <span class="weui-form-preview__value"><%# ViewState["state"].ToString()=="维修完成"? Eval("wx_cs"):"" %>                                    
                                    <asp:TextBox ID="wx_cs" runat="server" Text='<%# Eval("wx_cs") %>' class="weui-input input"  Visible='<%# ViewState["state"].ToString()=="维修完成"?false:true %>'  placeholder="请输入维修措施"></asp:TextBox>
                                     
                                </span>
                            </div>
                            <div class="weui-form-preview__item " hidden="hidden">
                                <label class="weui-form-preview__label">维修结果</label>
                                <span class="weui-form-preview__value"><%# ViewState["state"].ToString()=="维修完成"? Eval("wx_result"):"" %>
                                    <asp:textbox id="wx_result" type="text" value='<%# Eval("wx_result") %>'  visible='<%# ViewState["state"].ToString()=="维修完成"?false:true %>'  runat="server"   class="weui-input input" placeholder="请输入维修结果"/> 

                                </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">完成时间/时长</label>
                                <span class="weui-form-preview__value"><%# Eval("wx_end_date","{0:MM/dd HH:mm}") %> | <%# "<font class='tag'>"+Eval("wx_shichang")+"</font>" %></span>
                            </div>                             
                             
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="weui-form-preview__bd">
                    <asp:button type="button" class="weui-btn weui-btn_primary"  runat="server" id="btnEnd" text="维修完成" OnClick="btnEnd_Click"></asp:button>
                </div>
            </div>
             
            <div class="weui-form-preview" id="PageQR" hidden="hidden">
                <div class="weui-form-preview__hd">
                    <div class="weui-form-preview__item">
                        <label class="weui-form-preview__label">生产确认信息</label>
                        <label class="weui-form-preview__"></label>
                    </div>
                </div>
                <div class="weui-form-preview__bd">
                    <div class="weui-form-preview__item">
                        <textarea class="weui-input input" placeholder="请输入确认说明" id="txtQr_Remark" runat="server" rows="2" ></textarea>
                    </div>
                </div>
                <div class="weui-form-preview__bd">
                    <asp:button type="button" class="weui-btn weui-btn_primary " runat="server" id="btnConfirm" Text="生产确认" OnClick="btnConfirm_Click"></asp:button>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
