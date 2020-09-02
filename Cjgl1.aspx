<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Cjgl1.aspx.cs" Inherits="Cjgl1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <title><%=_workshop %></title>

    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <%--<script src="/js/jquery-3.0.0.min.js"></script>--%>
    <script src="/Content/layer/layer.js"></script>

    <link href="/css/weui.css" rel="stylesheet" />
    <link href="/css/weuix.css" rel="stylesheet" />    
    <script src="/js/zepto.min.js"></script>
    <script src="/js/zepto.weui.js"></script>
    <script src="/js/cjgl.js?ver=20200709001"></script>
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
            padding:7px 20px;  
        }
        i{ color:#03a9f4}
        .bg-orange{background-color:orange}
    </style>

    <script type="text/javascript">
        $(function () {
            var _wrokshop = "<%=Request["workshop"]%>";
            if (_wrokshop == "三车间") {
                show_login(_wrokshop);
                show_yl(_wrokshop);
                show_bhg(_wrokshop);
                show_prod_3(_wrokshop);
            } else {
                show_login(_wrokshop);
                show_yl(_wrokshop);
                show_bhg(_wrokshop);
                show_jj(_wrokshop);
                show_prod_24(_wrokshop);
            };
                 
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
                <a class="weui-cell weui-cell_access"  href="javascript:sm_workorder('<%=_workshop %>');"   id="a_div">
                    <div class="weui-cell__hd">
                        <i class="fa fa-edit margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>不合格处理</p>
                    </div>
                    <div class="weui-cell__ft"></div>
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
                <a class="weui-cell weui-cell_access" href="/workorder/Emp_Login_list_new.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-group margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>上岗监视</p>
                    </div>
                    <div class="weui-cell__ft">
                        <%--<asp:Label ID="Label1" runat="server" Text="" style="display:none;"></asp:Label>
                        <asp:Label ID="Label1_j" runat="server" Text="" style="display:none;"></asp:Label>
                        <% string i1 = Label1.Text;
                            Response.Write("<span class='weui-badge  bg-" + (i1 == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>生" + i1 + "</span>");
                        %>   
                        <% string i1_j = Label1_j.Text; 
                            Response.Write("<span class='weui-badge' style='background-color:" + (i1_j == "0" ? "lightgray" : "orange") + ";color: white;margin-right: 15px;'>质" + i1_j + "</span>"); %> --%>
                        <span class='weui-badge  bg-blue' id="sc" style='margin-right: 5px;'>生..</span>
                        <span class='weui-badge  bg-orange' id="zl"  style='margin-right: 5px;'>质..</span>  
                    </div>
                </a>
                <a class="weui-cell weui-cell_access" href="/JiaJu/jiaju_monitor.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-magnet margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>换夹具</p>
                    </div>
                    <div class="weui-cell__ft">
                        <span class="weui-badge bg-blue margin15-r" id="iOne" >..</span>
                        <span class="weui-badge bg-blue margin15-r" id="iF"  >..</span>
                        <span class="weui-badge bg-orange margin15-r" id="iTwo" >多..</span>
                        <span class="weui-badge bg-orange margin15-r" id="i2H"  >超..</span>
                    </div>
                </a>
                <a class="weui-cell weui-cell_access" href="/workorder/YL_list_new.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-cubes margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>要料监视</p>
                    </div>
                    <div class="weui-cell__ft">
                        <%--<asp:Label ID="Label2" runat="server" Text="" style="display:none;"></asp:Label>
                        <% string i2 = Label2.Text; Response.Write("<span class='weui-badge  bg-" + (i2 == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>" + i2 + "</span>"); %>   
                        
                        <asp:Label ID="Label2_end" runat="server" Text="" style="display:none;"></asp:Label>
                        <% string i2_end = Label2_end.Text; Response.Write("<span class='weui-badge  bg-" + (i2_end == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>" + i2_end + "</span>"); %> --%>
                        <span class='weui-badge  bg-blue' id="yl_go" style='margin-right: 5px;'>..</span>
                        <span class='weui-badge  bg-blue' id="yl_end"  style='margin-right: 5px;'>..</span>  
                    </div>
                </a>
                <a class="weui-cell weui-cell_access" href="/workorder/bhgp_Apply_list_V1.aspx?workshop=<%=_workshop %>" id="a_div2">
                    <div class="weui-cell__hd">
                        <i class="fa fa-bookmark-o margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>不合格监视</p>
                    </div>
                    <div class="weui-cell__ft">
                        <%--<asp:Label ID="Label3_V1" runat="server" Text="" style="display:none;"></asp:Label>
                        <asp:Label ID="Label3_V1_f" runat="server" Text="" style="display:none;"></asp:Label>
                        <asp:Label ID="Label3_V1_e" runat="server" Text="" style="display:none;"></asp:Label>
                        <% string i3_V1 = Label3_V1.Text; Response.Write("<span class='weui-badge  bg-" + (i3_V1 == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>" + i3_V1 + "</span>"); %>  
                        <% string i3_V1_e = Label3_V1_e.Text; Response.Write("<span class='weui-badge  bg-" + (i3_V1_e == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>" + i3_V1_e + "</span>"); %>  
                        <% string i3_V1_f = Label3_V1_f.Text;Response.Write("<span class='weui-badge  bg-" + (i3_V1_f == "0" ? "gray" : "red") + "' style='margin-right: 15px;'>返" + i3_V1_f + "</span>"); %>  --%>                        
                        <span class="weui-badge bg-blue" id="bhg_go" style='margin-right: 15px;'>..</span>  
                        <span class="weui-badge bg-blue" id="bhg_end" style='margin-right: 15px;'>..</span>  
                        <span class="weui-badge bg-red" id="bhg_fg" style='margin-right: 15px;'>返..</span> 
                    </div>
                </a>
                
                <a class="weui-cell weui-cell_access" href="/workorder/prod_wip_list_v4.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-gears margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>生产监视</p>
                    </div>
                    <div class="weui-cell__ft">                                                                        
                        <span class="weui-badge bg-blue" id="wip24" style='margin-right: 10px;'>..</span>
                        <span class="weui-badge bg-blue" id="sh24" style='margin-right: 10px;'>..</span>
                        <span class="weui-badge bg-orange" id="part24"  style='margin-right: 10px;'>部..</span>
                        <span class="weui-badge bg-red" id="ng24" style='margin-right: 15px;'>返..</span>
                     
                    </div>
                </a>   
                
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
                <a class="weui-cell weui-cell_access" href="/workorder/YL.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-cube margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>要料</p>
                    </div>
                    <div class="weui-cell__ft"></div>
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
                <a class="weui-cell weui-cell_access"  href="javascript:sm_workorder('<%=_workshop %>');">
                    <div class="weui-cell__hd">
                        <i class="fa fa-edit margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>不合格处理<span class="f12"></span></p>
                    </div>
                    <div class="weui-cell__ft"></div>
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
                <a class="weui-cell weui-cell_access" href="javascript:sm_qc_off('<%=_workshop %>');">   
                    <div class="weui-cell__hd">
                        <i class="fa fa-wpexplorer margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>检验完成</p>
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
                        <asp:Label ID="Label1_three_j" runat="server" Text="" style="display:none;"></asp:Label>
                        <% string i1_three = Label1_three.Text;
                            Response.Write("<span class='weui-badge  bg-" + (i1_three == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>生" + i1_three + "</span>");
                        %>   
                        <% string i1_three_j = Label1_three_j.Text;
                            Response.Write("<span class='weui-badge' style='background-color:" + (i1_three_j == "0" ? "lightgray" : "orange") + ";color: white;margin-right: 15px;'>质" + i1_three_j + "</span>"); %> --%>
                          
                        <span class='weui-badge  bg-blue' id="sc_three" style='margin-right: 5px;'>生..</span>
                        <span class='weui-badge  bg-orange' id="zl_three"  style='margin-right: 5px;'>质..</span>  
                    </div>
                </a>
                <a class="weui-cell weui-cell_access" href="/workorder/YL_list_new.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-cubes margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>要料监视</p>
                    </div>
                    <div class="weui-cell__ft">
                        <%--<asp:Label ID="Label2_three" runat="server" Text="" style="display:none;"></asp:Label>
                        <% string i2_three = Label2_three.Text; Response.Write("<span class='weui-badge  bg-" + (i2_three == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>" + i2_three + "</span>"); %>  
                        
                        <asp:Label ID="Label2_three_end" runat="server" Text="" style="display:none;"></asp:Label>
                        <% string i2_three_end = Label2_three_end.Text;
                            Response.Write("<span class='weui-badge  bg-" + (i2_three_end == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>" + i2_three_end + "</span>"); %>   --%>
                        <span class='weui-badge  bg-blue' id="yl_go_three" style='margin-right: 5px;'>..</span>
                        <span class='weui-badge  bg-blue' id="yl_end_three"  style='margin-right: 5px;'>..</span> 
                    </div>
                </a>   
                <a class="weui-cell weui-cell_access" href="/workorder/YT_list.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-hourglass-half margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>要汤监视<span class="f12"></span></p>
                    </div>
                    <div class="weui-cell__ft"> 
                        <asp:Label ID="Label_YT" runat="server" Text="" style="display:none;"></asp:Label>
                        <% string i_YT = Label_YT.Text;
                            Response.Write("<span class='weui-badge  bg-" + (i_YT == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>" + i_YT + "</span>");
                        %> 
                    </div>
                </a>   
                <a class="weui-cell weui-cell_access" href="/workorder/bhgp_Apply_list_V1.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-bookmark-o margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>不合格监视<span class="f12"></span></p>
                    </div>
                    <div class="weui-cell__ft"> 
                        <%--<asp:Label ID="Label_bhg_thr" runat="server" Text="" style="display:none;"></asp:Label>
                        <asp:Label ID="Label_bhg_thr_f" runat="server" Text="" style="display:none;"></asp:Label>
                        <asp:Label ID="Label_bhg_thr_e" runat="server" Text="" style="display:none;"></asp:Label>
                        <% string i_bhg_3 = Label_bhg_thr.Text; Response.Write("<span class='weui-badge  bg-" + (i_bhg_3 == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>" + i_bhg_3 + "</span>"); %> 
                        <% string i_bhg_3_e = Label_bhg_thr_e.Text;Response.Write("<span class='weui-badge  bg-" + (i_bhg_3_e == "0" ? "gray" : "blue") + "' style='margin-right: 15px;'>" + i_bhg_3_e + "</span>"); %>   
                        <% string i_bhg_3_f = Label_bhg_thr_f.Text;Response.Write("<span class='weui-badge  bg-" + (i_bhg_3_f == "0" ? "gray" : "red") + "' style='margin-right: 15px;'>返" + i_bhg_3_f + "</span>"); %> --%> 
                        <span class="weui-badge bg-blue" id="bhg_go_thr" style='margin-right: 15px;'>..</span>  
                        <span class="weui-badge bg-blue" id="bhg_end_thr" style='margin-right: 15px;'>..</span>  
                        <span class="weui-badge bg-red" id="bhg_fg_thr" style='margin-right: 15px;'>返..</span> 
                    </div>
                </a>
                 
                <a class="weui-cell weui-cell_access" href="/workorder/prod_YZ_monitor.aspx?workshop=<%=_workshop %>">
                    <div class="weui-cell__hd">
                        <i class="fa fa-gears margin10-r"></i>
                    </div>
                    <div class="weui-cell__bd">
                        <p>生产监视</p>                        
                    </div>
                    <div class="weui-cell__ft">                        
                        <span class="weui-badge bg-blue" id="wip3" style='margin-right: 10px;'>..</span>
                        <span class="weui-badge bg-blue" id="sh3" style='margin-right: 10px;'>..</span>
                        <span class="weui-badge bg-orange" id="part3"  style='margin-right: 10px;'>部..</span>
                        <span class="weui-badge bg-red" id="ng3" style='margin-right: 15px;'>返..</span>
                    </div>
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

        function show_login(_workshop) {
            $.ajax({
                url: "/Cjgl1.aspx/login_Data",
                type: "Post",
                data: "{'_workshop': '" + _workshop + "' }",
                async: true,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    datad = JSON.parse(data.d); //转为Json字符串
                    if (datad.length > 0) {

                        if (_workshop == "三车间") {
                            $("#sc_three").text('生' + datad[0].sc);
                            $("#zl_three").text('质' + datad[0].zl);
                            if (datad[0].go == 0) { $("#sc_three").removeClass("bg-blue").addClass("bg-gray"); }
                            if (datad[0].end == 0) { $("#zl_three").removeClass("bg-orange").addClass("bg-gray"); }
                        } else {
                            $("#sc").text('生' + datad[0].sc);
                            $("#zl").text('质' + datad[0].zl);
                            if (datad[0].go == 0) { $("#sc").removeClass("bg-blue").addClass("bg-gray"); }
                            if (datad[0].end == 0) { $("#zl").removeClass("bg-orange").addClass("bg-gray"); }
                        }

                    }

                }//,
                //error: function (error) {
                //    alert(error);
                //}
            });
        }

        function show_yl(_workshop) {
            $.ajax({
                url: "/Cjgl1.aspx/yl_Data",
                type: "Post",
                data: "{'_workshop': '" + _workshop + "' }",
                async: true,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    datad = JSON.parse(data.d); //转为Json字符串
                    if (datad.length > 0) {

                        if (_workshop == "三车间") {
                            $("#yl_go_three").text(datad[0].go);
                            $("#yl_end_three").text(datad[0].end);
                            if (datad[0].go == 0) { $("#yl_go_three").removeClass("bg-blue").addClass("bg-gray"); }
                            if (datad[0].end == 0) { $("#yl_end_three").removeClass("bg-blue").addClass("bg-gray"); }
                        } else {
                            $("#yl_go").text(datad[0].go);
                            $("#yl_end").text(datad[0].end);
                            if (datad[0].go == 0) { $("#yl_go").removeClass("bg-blue").addClass("bg-gray"); }
                            if (datad[0].end == 0) { $("#yl_end").removeClass("bg-blue").addClass("bg-gray"); }
                        }

                    }

                }//,
                //error: function (error) {
                //    alert(error);
                //}
            });
        }

        function show_bhg(_workshop) {
            $.ajax({
                url: "/Cjgl1.aspx/bhg_Data",
                type: "Post",
                data: "{ '_workshop': '" + _workshop + "'}",
                async: true,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    datad = JSON.parse(data.d); //转为Json字符串
                    if (datad.length > 0) {
                        if (_workshop == "三车间") {
                            $("#bhg_go_thr").text(datad[0].go);
                            $("#bhg_end_thr").text(datad[0].end);
                            $("#bhg_fg_thr").text('返' + datad[0].fg);
                            if (datad[0].go == 0) { $("#bhg_go_thr").removeClass("bg-blue").addClass("bg-gray"); }
                            if (datad[0].end == 0) { $("#bhg_end_thr").removeClass("bg-blue").addClass("bg-gray"); }
                            if (datad[0].go_bhg == 0) { $("#bhg_fg_thr").removeClass("bg-red").addClass("bg-gray"); }
                        } else {
                            $("#bhg_go").text(datad[0].go);
                            $("#bhg_end").text(datad[0].end);
                            $("#bhg_fg").text('返' + datad[0].fg);
                            if (datad[0].go == 0) { $("#bhg_go").removeClass("bg-blue").addClass("bg-gray"); }
                            if (datad[0].end == 0) { $("#bhg_end").removeClass("bg-blue").addClass("bg-gray"); }
                            if (datad[0].go_bhg == 0) { $("#bhg_fg").removeClass("bg-red").addClass("bg-gray"); }
                        }
                    }

                }//,
                //error: function (error) {
                //    alert(error);
                //}
            });
        }

        //show workshop 3 product data
        function show_prod_3(_workshop){
            $.ajax({
                url: "/Cjgl1.aspx/ProdList3_Data",
                type: "Post",
                data: "{ 'workshop': '" + _workshop + "' }",
                async: true,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    datad = JSON.parse(data.d); //转为Json字符串
                    if(datad.length>0){
                        $("#wip3").text(datad[0].wip);
                        $("#sh3").text(datad[0].sh);
                        $("#part3").text('部'+datad[0].part);
                        $("#ng3").text('返' + datad[0].ng);
                        if (datad[0].ng == 0) { $("#ng3").addClass("bg-gray") }
                        if (datad[0].sh == 0) { $("#sh3").addClass("bg-gray") }
                        if (datad[0].part == 0) { $("#part3").addClass("bg-gray") }
                        if (datad[0].wip == 0) { $("#wip3").addClass("bg-gray") }
                    }

                }//,
                //error: function (error) {
                //    alert(error);
                //}
            });
        }
        //show workshop 2,4 product data
        function show_prod_24(_workshop) {
            $.ajax({
                url: "/Cjgl1.aspx/ProdList24_Data",
                type: "Post",
                data: "{ 'workshop': '" + _workshop + "' }",
                async: true,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    datad = JSON.parse(data.d); //转为Json字符串
                    if (datad.length > 0) {
                        $("#wip24").text(datad[0].wip);
                        $("#sh24").text(datad[0].sh);
                        $("#part24").text('部' + datad[0].part);
                        $("#ng24").text('返' + datad[0].ng);
                        if (datad[0].ng == 0) { $("#ng24").addClass("bg-gray") }
                        if (datad[0].sh == 0) { $("#sh24").addClass("bg-gray") }
                        if (datad[0].part == 0) { $("#part24").addClass("bg-gray") }
                        if (datad[0].wip == 0) { $("#wip24").addClass("bg-gray") }
                    }

                }//,
                //error: function (error) {
                //    alert(error);
                //}
            });
        }
        //夹具统计
        function show_jj(_workshop) {
            $.ajax({
                url: "/Cjgl1.aspx/JiaJu_Data",
                type: "Post",
                data: "{ 'workshop': '" + _workshop + "' }",
                async: true,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    datad = JSON.parse(data.d); //转为Json字符串
                    if (datad.length > 0) {
                        $("#iOne").text(datad[0].iOne);
                        $("#iTwo").text("多"+datad[0].iTwo);
                        $("#iF").text(datad[0].iF);
                        $("#i2H").text("超"+datad[0].i2H);
                        if (datad[0].iOne == 0) { $("#iOne").addClass("bg-gray") }
                        if (datad[0].iTwo == 0) { $("#iTwo").addClass("bg-gray").removeClass("bg-orange") }
                        if (datad[0].iF == 0) { $("#iF").addClass("bg-gray") }
                        if (datad[0].i2H == 0) { $("#i2H").addClass("bg-gray").removeClass("bg-orange") }
                    }

                }//,
                //error: function (error) {
                //    alert(error);
                //}
            });
        }
    </script>
</html>
