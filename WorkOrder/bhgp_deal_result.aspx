<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bhgp_deal_result.aspx.cs" Inherits="bhgp_deal_result" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>不合格品处置</title>
    
     <link href="/Content/bootstrap.min.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
    <script src="/Content/laydate/laydate.js"></script>
    <script src="/Content/layer/layer.js"></script>

    <link href="/css/global.css?v=201802091428" rel="stylesheet" type="text/css">
    <link href="/css/iconfont.css?v=201802091429" rel="stylesheet" type="text/css">
    <link href="/css/login.css?v=201802091428" rel="stylesheet" type="text/css">
    <link href="/css/comm.css?v=201802091429" rel="stylesheet" type="text/css">
    <link href="/css/theme.css?v=201805162207" rel="stylesheet" type="text/css">

     <style>
        .rowbr{
            margin-bottom:5px;
        }
        .textwidth1{
            padding-right:26px;
        }        
        .textwidth2{
            padding-right:55px;
        }
        .textwidth3{
            padding-right:40px;
        }  
        
        
    </style>
    <script>

        $(document).ready(function () {
            $('input[type=radio][name=b_result]').change(function () {
                if (this.value == '废品') {
                    //alert("废品");
                    $("#hege_qty").attr("readonly", "readonly");
                    $("#hege_qty").attr("placeholder", "");
                    $("#hege_qty").val("");

                    $("#dcl_rea").val("");
                    $("#div_dcl").hide();
                }
                else if (this.value == '待处理') {
                    //alert("待处理");
                    $("#hege_qty").removeAttr("readonly");
                    $("#hege_qty").attr("placeholder", "请输入合格数量");

                    $("#div_dcl").show();
                }
            });

            if ($("input[name*=b_result]:checked").val() == "废品") {
                $("#dcl_rea").val("");
                $("#div_dcl").hide();
            } else if ($("input[name*=b_result]:checked").val() == "待处理") {
                $("#div_dcl").show();
            }
        });
        function valid_next() {
            //alert($("input[name*=b_result]:checked").val());
            //return false;

            if ($("input[name*=b_result]:checked").length == 0) {
                layer.alert("请选择是【处置结果】.");
                return false;
            }

            //if ($("#hege_qty").attr("readonly") != "readonly") {
            //    if ($("#hege_qty").val() == "") {
            //        alert("请输入【合格数量】.");
            //        return false;
            //    }
            //}

            if ($("input[name*=b_result]:checked").val()=="废品") {
                if ($("input[id*=baofei_qty]").val() == "") {
                    layer.alert("请输入【废品数量】.");
                    return false;
                }
                if ($("#reason").val() == "") {
                    layer.alert("请输入【废品原因】.");
                    return false;
                }
            } else if ($("input[name*=b_result]:checked").val() == "待处理") {
                if ($("#dcl_rea").val() == "") {
                    layer.alert("请输入【待处理原因】.");
                    return false;
                }
                
                if ($("#hege_qty").val() == "" && $("input[id*=baofei_qty]").val() == "") {
                    layer.alert("请输入【合格数量】或【废品数量】.");
                    return false;
                }
                if ($("input[id*=baofei_qty]").val() != "" && $("#reason").val() == "") {
                    layer.alert("请输入【废品原因】.");
                    return false;
                }
            }
           
            return true;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager runat="server">
        </asp:ScriptManager>
    <div class="resume-setting-page normal-page-wrap"> 
        <%--<div id="allContainer" class="menus-normal">
            <dl class="menus-module" style="background-color:#008083;height:66px;"> 
                
                <dt class="menus-title" style="background-color:#008083;height:66px">
                    <div  style="float:left;width:80%;border:0px solid #F00;">PGI产线作业-不合格品处置</div> 
                    <div style="float:left;width:18%;border:0px solid #000; text-align:right;"></div> 
                </dt> 

         
            </dl>
        </div> --%>

        
        <div class="row ">
            <div class="col-md-12">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
            
                    <div class="input-group rowbr">
                        <span class="input-group-addon textwidth3">登入人</span>
                        <asp:TextBox ID="emp_code_name" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                        <asp:TextBox ID="domain" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server" Visible="false"></asp:TextBox>
                    </div>

                    <div class="input-group rowbr">
                        <span class="input-group-addon textwidth2" >单号</span>
                        <asp:TextBox ID="workorder" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                    </div>
                    <div class="input-group rowbr">
                        <span class="input-group-addon textwidth1">当前产品</span>
                        <asp:TextBox ID="pgino" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                    </div>
                
                    <div class="input-group rowbr">
                        <span class="input-group-addon textwidth2">来源</span>
                        <asp:TextBox ID="source" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                    </div>

                    <div class="input-group rowbr">
                        <span class="input-group-addon textwidth2">工序</span>
                        <asp:TextBox ID="op" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                    </div>

                    <div class="input-group rowbr">
                        <span class="input-group-addon textwidth1">处置数量</span>
                        <asp:TextBox ID="qty" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                    </div>

                    <div class="input-group rowbr">
                        <span class="input-group-addon">已处置数量</span>
                        <asp:TextBox ID="off_qty" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                    </div>

                    <div class="input-group rowbr">
                        <span class="input-group-addon textwidth1">处置结果</span>
                        <span class="form-control">
                            <label class="checkbox-inline">
                                <input type="radio" name="b_result" id="b_result1" value="废品" runat="server">废品
                            </label>
                            <label class="checkbox-inline">
                                <input type="radio" name="b_result" id="b_result2" value="待处理" runat="server">待处理
                            </label>
                        </span>
                    </div>

                    <div class="input-group rowbr" id="div_dcl">
                        <span class="input-group-addon">待处理原因</span>
                        <asp:DropDownList ID="dcl_rea" runat="server" class="form-control" Style="max-width: 100%" ></asp:DropDownList>
                        <asp:TextBox ID="txt_dcl_rea" class="form-control" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server" Visible="false"></asp:TextBox>
                    </div>

                    <div class="input-group rowbr">
                        <span class="input-group-addon textwidth1">合格数量</span>
                        <asp:TextBox ID="hege_qty" class="form-control" placeholder="" Style="max-width: 100%" runat="server"></asp:TextBox>
                    </div>

                    <div class="input-group rowbr">
                        <span class="input-group-addon textwidth1">废品原因</span>
                        <%--<asp:TextBox ID="reason" class="form-control" placeholder="请输入废品原因" Style="max-width: 100%" runat="server"></asp:TextBox>--%>
                        <asp:DropDownList ID="reason" runat="server" class="form-control" Style="max-width: 100%" ></asp:DropDownList>
                    </div>

                    <div class="input-group rowbr">
                        <span class="input-group-addon textwidth1">废品数量</span>
                        <asp:TextBox ID="baofei_qty" class="form-control" placeholder="请输入废品数量" Style="max-width: 100%" runat="server"></asp:TextBox>
                    </div>

                </ContentTemplate>
                </asp:UpdatePanel>  

                <div class="input-group-addon">
                    <asp:Button ID="btnnext" class="btn btn-primary btn-lg" BackColor="#428bca" style="padding:10px 16px" runat="server" 
                        Text="下一个" OnClick="btnnext_Click" OnClientClick="return valid_next();"/> 
                     <asp:Button ID="btnsure" class="btn btn-primary btn-lg" BackColor="#428bca" style="padding:10px 16px" runat="server" 
                        Text="确&nbsp;&nbsp;&nbsp;&nbsp;认" OnClick="btnsure_Click"/>
                </div>
             <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:GridView ID="GridView1" 
                            AllowMultiColumnSorting="True" AllowPaging="True"
                            AllowSorting="True" AutoGenerateColumns="False"
                            OnPageIndexChanging="GridView1_PageIndexChanging"
                            runat="server" Font-Size="Small" Width="96%" style="margin-left:2%; margin-right:2%;" PageSize="5">
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <PagerSettings FirstPageText="首页" LastPageText="尾页"
                                Mode="NextPreviousFirstLast" NextPageText="下页" PreviousPageText="上页" />
                            <PagerStyle ForeColor="Red" />
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <EditRowStyle BackColor="#999999" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <HeaderStyle BackColor="#428bca" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />

                            <Columns>  
                                <asp:BoundField DataField="baofei_qty" HeaderText="废品数量" ReadOnly="True" ItemStyle-Width="20%">
                                    <HeaderStyle Wrap="True" />
                                </asp:BoundField>  
                                <asp:BoundField DataField="reason_desc" HeaderText="废品原因" ReadOnly="True" ItemStyle-Width="80%">
                                    <HeaderStyle Wrap="True" />
                                </asp:BoundField>  
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>  
            </div>
        </div>
       
    </div>
    </form>
</body>
</html>
