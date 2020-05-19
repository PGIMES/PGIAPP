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

        .hidden { display:none;}
    </style>
    
</head>
<body>
    <script>  

        $(document).ready(function () {
            $("#txt_wlh").attr("readonly", "readonly");
            $("#txt_qty").attr("readonly", "readonly");
            var lotno = '<%=lotno%>';
            var needno = '<%=_needno%>';
            Bind_Lotno(lotno,needno);
        });

        $(function () {
            $('#btn_cancel').click(function () {
                var qty = $("#txt_qty").text();

                $.confirm('确认要【退回】【数量' + qty + '】吗？', function () {
                    //点击确认后的回调函数
                    $.ajax({
                        type: "post",
                        url: "Load_Material.aspx/Reject_Sku",
                        data: "{'emp':'" + "<%= _emp %>" + "','needno':'" + "<%= _needno %>" + "','lotno':'" + "<%= lotno %>" + "','reject_qty':'" + qty + "','source':'1'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                        success: function (data) {
                            var obj = eval(data.d);
                            var flag = obj[0].flag;
                            if (flag == "Y") {
                                layer.alert(obj[0].msg);
                            } else {
                                window.location.href = "/workorder/YL_List_new.aspx?workshop=<%=_workshop %>";
                            }
                            
                        }
                    });
                }, function () {
                    //点击取消后的回调函数
                });
            });
        });

        
        function Bind_Lotno(lotno, needno) {
            $.ajax({
                type: "post",
                url: "Load_Material.aspx/Set_Lotno",
                data: "{'lotno':'" + lotno + "','needno':'" + needno + "','para':'" + "<%= _para %>" + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    if (data) {
                        $.each(eval(data.d), function (i, item) {
                            if (item.text == "Y") {
                                alert(item.value);
                                $("input[type='text']").val("");
                                return;
                            }
                            else {
                                $("#txt_feed_person").text(item.feed_person);
                                $("#txt_feed_time").text(item.feed_time);
                                $("#txt_wlh").text(item.sku);
                                $("#sku_desc").text(item.sku_desc);
                                $("#txt_qty").text(item.feed_qty);
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

            <div class="weui-form-preview">

                <div hidden="hidden">
                    <div class="weui-cell__hd"><label class="weui-label">登入人</label></div>
                    <div class="weui-cell__bd">
                        <asp:TextBox ID="txt_emp"  class="weui-input"  placeholder="" Style="max-width: 100%" runat="server" ></asp:TextBox>
                    </div>
                </div>

                 <div class="weui-form-preview__hd">
                    <div class="weui-form-preview__item">
                       
                       <label class="weui-form-preview__">上料单号:<% ="<font class='tag'/>"+lotno %></label>
                    </div>
                </div>

                <div class="weui-form-preview__bd">

                    <div class="weui-form-preview__item">
                        <label class="weui-form-preview__label">岗位</label>
                        <span class="weui-form-preview__value">
                            <asp:Label ID="txt_location" class="weui-input" ReadOnly="true" placeholder="" Style="max-width: 100%" runat="server"></asp:Label>
                        </span>
                    </div>

                    <div class="weui-form-preview__item">
                        <label class="weui-form-preview__label">送料人</label>
                        <span class="weui-form-preview__value" id="txt_feed_person"></span>
                    </div>

                    <div class="weui-form-preview__item">
                        <label class="weui-form-preview__label ">送料时间</label>
                        <span class="weui-form-preview__value" id="txt_feed_time"></span>
                    </div>

                    <div class="weui-form-preview__item">
                        <label class="weui-form-preview__label1  ">物料号</label>
                        <span class="weui-form-preview__value1" ID="txt_wlh"></span>
                    </div>

                    <div class="weui-form-preview__item">
                        <label class="weui-form-preview__label1 ">零件号</label>
                        <span class="weui-form-preview__value1" ID="sku_desc"></span>
                    </div>


                    <div class="weui-form-preview__item">
                        <label class="weui-form-preview__label1 ">数量</label>
                        <span class="weui-form-preview__value1" ID="txt_qty"></span>
                    </div>                           

                </div>
            </div>

            <div class="weui-cell">
                <asp:Button ID="btnsave" class="weui-btn weui-btn_primary"  runat="server" Text="上线" OnClick="btnsave_Click" />
                <input id="btn_cancel" type="button" class="weui-btn weui-btn_primary" value="退料" style="margin-left:10px;" />
            </div>

        </div>
    </form>
</body>
</html>

