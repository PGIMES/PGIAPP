<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Off_Material.aspx.cs" Inherits="Off_Material" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>生产下线</title>
    <script src="/Scripts/jquery-1.10.2.min.js"></script> 
  

    <link href="../css/weui.css" rel="stylesheet" />
    <link href="../css/weuix.css" rel="stylesheet" />
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
        
        
    </style>
    <script>
        function valid() {
            if ($("#txt_qty").val() == "" || $("#txt_qty").val() == "0") {
                alert("请输入处置数量.");
                return false;
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
                    <div  style="float:left;width:80%;border:0px solid #F00;">PGI产线作业-生产下线</div> 
                    <div style="float:left;width:18%;border:0px solid #000; text-align:right;"></div> 
                </dt> 

         
            </dl>
        </div> --%>

        
        
            <div class="weui-cells weui-cells_form">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
            
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
                    </div>
                </div>




                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">生产完成单号</label>
                    </div>
                    <div class="weui-cell__bd">
                        <asp:TextBox ID="txt_dh" class="weui-input" Style="max-width: 100%" runat="server" placeholder="请输入完成单号"></asp:TextBox>
                    </div>
                </div>



                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">物料号</label>
                    </div>
                    <div class="weui-cell__bd">
                        <asp:DropDownList ID="txt_xmh" class="weui-input" runat="server" OnSelectedIndexChanged="txt_xmh_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                    </div>
                </div>

                 <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">零件号</label>
                    </div>
                    <div class="weui-cell__bd">
                        <asp:TextBox ID="txt_pn" class="weui-input" Style="max-width: 100%" runat="server"></asp:TextBox>
                    </div>
                </div>


                  <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">本次完工数量</label>
                    </div>
                    <div class="weui-cell__bd">
                        <asp:TextBox ID="txt_qty" class="weui-input" Style="max-width: 100%" runat="server" placeholder="请输入完工数量"></asp:TextBox>
                    </div>
                </div>



               
                <div>
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
                            <asp:BoundField DataField="lot_no" HeaderText="Lot No" ReadOnly="True" ItemStyle-Width="20%">
                                <HeaderStyle Wrap="True" />
                            </asp:BoundField> 
                            <asp:BoundField DataField="qty" HeaderText="已上料数" ReadOnly="True" ItemStyle-Width="20%">
                                <HeaderStyle Wrap="True" />
                            </asp:BoundField> 
                            <asp:BoundField DataField="go_qty" HeaderText="生产中" ReadOnly="True" ItemStyle-Width="15%">
                                <HeaderStyle Wrap="True" />
                            </asp:BoundField>  
                            <asp:BoundField DataField="off_qty" HeaderText="已下料数" ReadOnly="True" ItemStyle-Width="20%">
                                <HeaderStyle Wrap="True" />
                            </asp:BoundField> 
                            <asp:BoundField DataField="bhg_qty" HeaderText="不合格申请数" ReadOnly="True" ItemStyle-Width="25%">
                                <HeaderStyle Wrap="True" />
                            </asp:BoundField>   
                        </Columns>
                    </asp:GridView>

                </div>

                </ContentTemplate>
            </asp:UpdatePanel>
                <div class="">
                    <asp:Button ID="btnsave" class="weui-btn weui-btn_primary" BackColor="#428bca"  runat="server" Text="下线" OnClick="btnsave_Click" OnClientClick="return valid();" />
                </div>
            
           
            </div>
        
       
    </div>
    </form>
</body>
</html>

