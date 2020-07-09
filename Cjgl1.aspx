<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Cjgl1.aspx.cs" Inherits="Cjgl1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <title><%=_workshop %></title>

    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <%--<script src="/js/jquery-3.0.0.min.js"></script>--%>
    <script src="/Content/layer/layer.js"></script>

    <link href="/css/weui.css" rel="stylesheet" />
    <link href="/css/weuix.css" rel="stylesheet" />    
    <script src="/js/zepto.min.js"></script>
    <script src="/js/zepto.weui.js"></script>
    <script src="/js/cjgl.js?ver=20200707001"></script>
    <link href="/css/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" />
    <style>
        .weui-cells {
            margin-top: 0px;
            line-height: 2.5;
        }
        .weui-cell:before {
            left: 0px;
                     
        }
        .weui-cell{
            padding:10px 20px;  
        }
        i{ color:#03a9f4}
        .bg-orange{background-color:orange}
    </style>

    <script type="text/javascript">
        <%-- function getQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = decodeURI(window.location.search).substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
        var workshop = getQueryString("workshop");
        //alert(workshop);--%>

        $(function () {
            //if ($("#emp_code_name").val() == "01968孙娟" || $("#emp_code_name").val() == "02274李晓根") {
            //    $("#sc_div").show();
            //} else {
            //    $("#sc_div").hide(); 
            //}
        });

        
    </script>
</head>
<body>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script> 
    <form id="form1" runat="server">
        
        <asp:TextBox ID="emp_code_name" class="weui-input" ReadOnly="true" placeholder="" runat="server" style="display:none;"></asp:TextBox>

        <div class="page-bd">

            <% if (_workshop=="二车间" || _workshop=="四车间")
                {%>
            <div class="weui-cells">
                <a class="weui-cell weui-cell_access" href="/workorder/Emp_Login.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-user-circle-o margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>上岗</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/workorder/Emp_Login_list_new.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-group margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>上岗监视</p>
                    </div>
                    <div class="weui-cell__ft">
                        <asp:Label ID="Label1" runat="server" Text="" style="display:none;"></asp:Label>
                        <asp:Label ID="Label1_j" runat="server" Text="" style="display:none;"></asp:Label>
                        <% string i1 = Label1.Text;
                            //Response.Write("<span style='background-color: #fff;font-size:12px;color:#10aeff;'>生</span>"); 
                            Response.Write("<span class='weui-badge  bg-" + (i1 == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>生" + i1 + "</span>");
                        %>   
                        <% string i1_j = Label1_j.Text;
                            //Response.Write("<span style='background-color: #fff;font-size:12px;color:orange;'>质</span>"); 
                            Response.Write("<span class='weui-badge' style='background-color:" + (i1_j == "0" ? "lightgray" : "orange") + ";color: white;margin-right: 15px;'>质" + i1_j + "</span>"); %> 
                    </div>
                </a>
                <a class="weui-cell weui-cell_access" href="/workorder/YL.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-cube margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>要料</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="javascript:sm_lotno('<%=_workshop %>');">
                    <div class="weui-cell__hd">
                        <i class="fa fa-arrow-up margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>生产上线</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/workorder/YL_list_new.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-cubes margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>要料监视</p>
                    </div>
                    <div class="weui-cell__ft">
                        <asp:Label ID="Label2" runat="server" Text="" style="display:none;"></asp:Label>
                        <% string i2 = Label2.Text; Response.Write("<span class='weui-badge  bg-" + (i2 == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>" + i2 + "</span>"); %>   
                    </div>
                </a>                
                <%--<a class="weui-cell weui-cell_access" href="/workorder/bhgp_Apply.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-edit margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>不合格申请</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/workorder/bhgp_Apply_list.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-bookmark-o margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>不合格监视</p>
                    </div>
                    <div class="weui-cell__ft">
                        <asp:Label ID="Label3" runat="server" Text="" style="display:none;"></asp:Label>
                        <% string i3 = Label3.Text; Response.Write("<span class='weui-badge  bg-" + (i3 == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>" + i3 + "</span>"); %>   
                    </div>
                </a>--%>
                <a class="weui-cell weui-cell_access"  href="javascript:sm_workorder('<%=_workshop %>');"   id="a_div">
                    <div class="weui-cell__hd">
                        <i class="fa fa-edit margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>不合格处理</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/workorder/bhgp_Apply_list_V1.aspx?workshop=<%=_workshop %>" id="a_div2">
                    <div class="weui-cell__hd">
                        <i class="fa fa-bookmark-o margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>不合格监视</p>
                    </div>
                    <div class="weui-cell__ft">
                        <asp:Label ID="Label3_V1" runat="server" Text="" style="display:none;"></asp:Label>
                        <% string i3_V1 = Label3_V1.Text; Response.Write("<span class='weui-badge  bg-" + (i3_V1 == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>" + i3_V1 + "</span>"); %>   
                    </div>
                </a>
                <a class="weui-cell weui-cell_access"  href="javascript:sm_product_off('<%=_workshop %>');">  <%-- href="javascript:sm_product_off();" --%>
                    <div class="weui-cell__hd">
                        <i class="fa fa-check-square-o margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>生产完成</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="javascript:sm_qc_off('<%=_workshop %>');">   
                    <div class="weui-cell__hd">
                        <i class="fa fa-wpexplorer margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>检验完成</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <%--<a class="weui-cell weui-cell_access" href="/workorder/CKSH.aspx?workshop=<%=_workshop %>">--%>         
                <a class="weui-cell weui-cell_access" href="javascript:sm_ck_dh('<%=_workshop %>');">
                    <div class="weui-cell__hd">
                        <i class="fa fa-random margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>仓库接收</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/workorder/prod_wip_list_v3.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-gears margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>生产监视</p>
                    </div>
                    <div class="weui-cell__ft">
                        <asp:Label ID="lblPart" runat="server" Text="" style="display:none;"></asp:Label>
                        <asp:Label ID="lblWip" runat="server" Text="" style="display:none;"></asp:Label>
                        <% string iPart = lblPart.Text;string iWip = lblWip.Text; Response.Write("<span class='weui-badge  bg-" + (iWip == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>" + iWip + "</span><span class='weui-badge  bg-" + (iPart == "0" ? "gray" : "orange") + "' style='margin-right: 15px;'>部" + iPart + "</span>"); %>  
                    </div>
                </a>   
                <%--<a class="weui-cell weui-cell_access" href="/workorder/prod_end_list.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-list-alt margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>生产完成监视<span class="f12">（临时）</span></p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/workorder/prod_qc_list.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-reorder margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>终检完成监视<span class="f12">（临时）</span></p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>--%>
                <%--<a class="weui-cell weui-cell_access" href="javascript:void(0);">
                    <div class="weui-cell__hd">
                        <i class="fa fa-bar-chart margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>报表查看<span class="f12">（未开放）</span></p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>--%>
            </div>
               <% }%>


               <%else if (_workshop=="三车间")
                {%>
            <div class="weui-cells">
                <a class="weui-cell weui-cell_access" href="/workorder/Emp_Login.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-user-circle-o margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>上岗</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/workorder/Emp_Login_list_new.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-group margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>上岗监视</p>
                    </div>
                    <div class="weui-cell__ft">
                        <%--<asp:Label ID="Label1_three" runat="server" Text="" style="display:none;"></asp:Label>
                        <% string i1_three = Label1_three.Text; Response.Write("<span class='weui-badge  bg-" + (i1_three == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>" + i1_three + "</span>"); %>--%> 
                        
                        <asp:Label ID="Label1_three" runat="server" Text="" style="display:none;"></asp:Label>
                        <asp:Label ID="Label1_three_j" runat="server" Text="" style="display:none;"></asp:Label>
                        <% string i1_three = Label1_three.Text;
                            Response.Write("<span class='weui-badge  bg-" + (i1_three == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>生" + i1_three + "</span>");
                        %>   
                        <% string i1_three_j = Label1_three_j.Text;
                            Response.Write("<span class='weui-badge' style='background-color:" + (i1_three_j == "0" ? "lightgray" : "orange") + ";color: white;margin-right: 15px;'>质" + i1_three_j + "</span>"); %> 
                          
                    </div>
                </a>
                <a class="weui-cell weui-cell_access" href="javascript:void(0);">
                    <div class="weui-cell__hd">
                        <i class="fa fa-cube margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>要料<span class="f12">（开发中）</span></p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="javascript:void(0);">
                    <div class="weui-cell__hd">
                        <i class="fa fa-cubes margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>要料监视<span class="f12">（开发中）</span></p>
                    </div>
                    <div class="weui-cell__ft"> 
                    </div>
                </a>   
                <a class="weui-cell weui-cell_access" href="/workorder/YT.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-tint margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>要汤<span class="f12"></span></p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/workorder/YT_list.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-hourglass-half margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>要汤监视<span class="f12"></span></p>
                    </div>
                    <div class="weui-cell__ft"> 
                    </div>
                </a>   
                <a class="weui-cell weui-cell_access"  href="javascript:sm_workorder('<%=_workshop %>');">
                    <div class="weui-cell__hd">
                        <i class="fa fa-edit margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>不合格处理<span class="f12"></span></p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/workorder/bhgp_Apply_list_V1.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-bookmark-o margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>不合格监视<span class="f12"></span></p>
                    </div>
                    <div class="weui-cell__ft"> 
                    </div>
                </a>
                <a class="weui-cell weui-cell_access"   href="javascript:sm_yz_off('<%=_workshop %>');"> 
                    <div class="weui-cell__hd">
                        <i class="fa fa-compress margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>压铸完成<span class="f12"></span></p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access"   href="javascript:sm_hsolve_off('<%=_workshop %>');">   
                    <div class="weui-cell__hd">
                        <i class="fa fa-compass margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>后处理完成<span class="f12"></span></p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>    
                <a class="weui-cell weui-cell_access" href="javascript:void(0);">   
                    <div class="weui-cell__hd">
                        <i class="fa fa-wpexplorer margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>检验完成<span class="f12">（开发中）</span></p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="javascript:void(0);">
                    <div class="weui-cell__hd">
                        <i class="fa fa-random margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>仓库接收<span class="f12">（开发中）</span></p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>
                <a class="weui-cell weui-cell_access" href="/workorder/prod_YZ_monitor.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-gears margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>生产监视</p>
                    </div>
                    <div class="weui-cell__ft"></div>
                </a>   
            </div>
                <%} %>

            
        </div>
        <div id="errmsg"class="f14"></div>  
        <div class="weui-footer weui-footer_fixed-bottom">
            <p class="weui-footer__text">
                <% =WeiXin.GetCookie("workcode")==""?"获取信息失败":WeiXin.GetCookie("workcode") +((LoginUser)WeiXin.GetJsonCookie()).UserName %>
            </p>
        </div>

    </form>

    <div id="div_2" style="display:none;">
        <div class="weui-cells">
          <a class="weui-cell weui-cell_access" href="/workorder/Ruku_Print.aspx?dh=&workshop=<%=_workshop %>&ck=N">
            <div class="weui-cell__bd">
              <p>生成入库单</p>
            </div>
            <div class="weui-cell__ft">
            </div>
          </a>
          <a class="weui-cell weui-cell_access" href="/workorder/Ruku_hege.aspx?dh=&workshop=<%=_workshop %>&ck=N">
            <div class="weui-cell__bd">
              <p>合格品入库</p>
            </div>
            <div class="weui-cell__ft">
            </div>
          </a>
          <a class="weui-cell weui-cell_access" href="/workorder/CKSH.aspx?dh=&workshop=<%=_workshop %>&ck=N">
            <div class="weui-cell__bd">
              <p>废品接收</p>
            </div>
            <div class="weui-cell__ft">
            </div>
          </a>
          <a class="weui-cell weui-cell_access" href="/workorder/Ruku_bcp_hege.aspx?dh=&workshop=<%=_workshop %>&ck=N">
            <div class="weui-cell__bd">
              <p>半成品入库</p>
            </div>
            <div class="weui-cell__ft">
            </div>
          </a>
        </div>
    </div>

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
                alert(error);
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
