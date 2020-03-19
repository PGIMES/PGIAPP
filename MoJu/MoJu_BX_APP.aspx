<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MoJu_BX_APP.aspx.cs" Inherits="MoJu_MoJu_BX_APP" %>

<!DOCTYPE html>

<html class="pixel-ratio-1"><head>
    <meta charset="utf-8">
    <title></title>
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weuix.css">
      <link href="/Content/bootstrap.min.css" rel="stylesheet" />
    <script src="../js/zepto.min.js"></script>
    <script src="../js/zepto.weui.js"></script>
    <script src="../js/jweixin-1.2.0.js"></script>
    <style>label{font-weight:normal}
    </style>
    <script>
       
        function Sel_sb() {
            //ajax下拉框选项 
            $.ajax({
                url: "MoJu_BX_APP.aspx/sel_sbno",    //后台webservice里的方法名称  
                type: "post",
                dataType: "json",
                contentType: "application/json",
                async: false,
                traditional: true,
                success: function (data) {
                    if (data) {
                        var datalist = new Array;
                        $.each(eval(data.d), function (i, item) {
                            datalist.push({ title: item.text, value: item.value });
                        })
                       // console.log(datalist);
                        $("#equipno").select({
                            title: "设备简称",
                            items: datalist,
                            //onChange: function (d) {
                            //    $("#mojuno").val("");
                                
                            //    Sel_moju($("#equipno").val());
                            //    console.log(this, d);
                            //},
                            onClose: function () {
                              //  console.log("close");
                            },
                            onOpen: function () {
                               // console.log("open");
                            },

                        });
                    }
                }
            });
        }


        function Sel_moju(sbno) {
            //ajax下拉框选项 Substring( 0, string.IndexOf( ' ' ) )
            //var sbno = $("#equipno").val();
            $.ajax({
                url: "MoJu_BX_APP.aspx/sel_Mojuno",    //后台webservice里的方法名称  
                data: "{'sbno':'" + sbno.substring(0,sbno.indexOf(' ')) + "'}",
                type: "post",
                dataType: "json",
                contentType: "application/json",
                async: false,
                traditional: true,
                success: function (data) {
                    if (data) {
                       
                        //var datalist = new Array;
                        $.each(eval(data.d), function (i, item) {

                            //datalist.push( item.value );
                            datalist.push({ "title": item.value });
                            //datalist.push({ title: item.text, value: item.value });

                        })
                        console.log(datalist);
                        //$("#mojuno").select("update", { items: datalist });

                        var selectcon = {
                            title: "模具",
                            items: datalist,
                            onChange: function (d) {
                                //  console.log(this, d);
                            },
                            onClose: function () {
                                // console.log("close");
                            },
                            onOpen: function () {
                                //  console.log("open");
                            },

                        };
                        $("#mojuno").select(selectcon);
                        //$("#mojuno").select({
                        //    title: "模具",
                        //    items: datalist,
                        //    onChange: function (d) {
                        //      //  console.log(this, d);
                        //    },
                        //    onClose: function () {
                        //       // console.log("close");
                        //    },
                        //    onOpen: function () {
                        //      //  console.log("open");
                        //    },

                        //});
                    }
                }
            });
        }

        function Sel_GZDESC() {
            //ajax下拉框选项 Substring( 0, string.IndexOf( ' ' ) )
            $.ajax({
                url: "MoJu_BX_APP.aspx/sel_gz",    //后台webservice里的方法名称  
                type: "post",
                dataType: "json",
                contentType: "application/json",
                traditional: true,
                success: function (data) {
                    if (data) {

                        var datalist = new Array;
                        $.each(eval(data.d), function (i, item) {
                            datalist.push({ title: item.text, value: item.value });
                        })
                        console.log(datalist);
                        $("#gztype").select({
                            title: "故障类型",
                            items: datalist,
                            onChange: function (d) {
                            //    console.log(this, d);
                            },
                            onClose: function () {
                             //   console.log("close");
                            },
                            onOpen: function () {
                              //  console.log("open");
                            },

                        });
                    }
                }
            });
        }

        var datalist = new Array;

    </script>
</head>

<body ontouchstart="">
<form id="form1" runat="server">
     <asp:ScriptManager runat="server">
        </asp:ScriptManager>
<div class="weui-cells weui-cells_form">
   

    <div class="weui-cell">
        <div class="weui-cell__hd f-red "><label for="job" class="weui-label">设备简称</label></div>
        <div class="weui-cell__bd">
           <%--<input class="weui-input" id="equipno" onchange=" Sel_moju($('#equipno').val());" type="text" value="" runat="server"  placeholder="请选择">--%>
            <asp:DropDownList ID="ddl_equip" runat="server" class="weui-input" Style="max-width: 100%;" AutoPostBack="True"   
                 OnSelectedIndexChanged="ddl_equip_SelectedIndexChanged"></asp:DropDownList>
             </div>
    </div>

     <div class="weui-cell">
        <div class="weui-cell__hd "><label for="job" class="weui-label">模具号</label></div>
        <div class="weui-cell__bd">
           <asp:DropDownList ID="ddl_mojuno" runat="server" class="weui-input" Style="max-width: 100%;border:none" AutoPostBack="True" OnSelectedIndexChanged="ddl_mojuno_SelectedIndexChanged" ></asp:DropDownList>
        </div>
    </div>

    <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">零件号</label></div>
        <div class="weui-cell__bd">
            <input class="weui-input"  runat="server"  id="txt_pn" readonly="readonly">
        </div>
    </div>

    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label for="" class="weui-label">报修等级
            </label>
        </div>
        <div class="weui-cell__bd">
            <div class="weui-cells__tips f-red">一级生产维修,二级模修维修</div>
            <div class="weui-form-li iblock">
            <input class="weui-form-checkbox" name="f2" id="g1" value="一级报修" type="radio"  runat="server">
            <label for="g1">
                <i class="weui-icon-radio"></i>
                <div class="weui-form-text"><p>一级</p></div>
            </label>
        </div>

        <div class="weui-form-li iblock">
            <input class="weui-form-checkbox" name="f2" id="g2" value="二级报修" type="radio" runat="server">
            <label for="g2">
                <i class="weui-icon-radio"></i>
                <div class="weui-form-text"><p>二级</p></div>
            </label>
        </div>
        </div>
    </div>

     <div class="weui-cell">
        <div class="weui-cell__hd "><label for="job" class="weui-label">故障类型</label></div>
        <div class="weui-cell__bd">
            <input class="weui-input" id="gztype" type="text" value=""  runat="server" placeholder="请选择" readonly="readonly">
        </div>
    </div>

      <div class="weui-cell">
        <div class="weui-cell__hd "><label class="weui-label">故障描述</label></div>
        <div class="weui-cell__bd">
             <textarea class="weui-textarea" id="gxms" placeholder="请输入故障描述" rows="3"  runat="server"></textarea>
        </div>
    </div>

    <div class="weui-cell" hidden="hidden">
        <div class="weui-cell__hd "><label class="weui-label">本次上机模次</label></div>
        <div class="weui-cell__bd">
            <input class="weui-form-area"  id="txt_moci" runat="server" placeholder="请输入本次上机模次" >
        </div>
    </div>

    

   

     <div class="weui-cell" hidden="hidden">
        <div class="weui-cell__hd"><label class="weui-label">登入人</label></div>
        <div class="weui-cell__bd">
            <input class="weui-input"  id="txt_empname" runat="server" readonly="readonly">
        </div>
    </div>

      <div class="">
                    <asp:Button ID="btnsave" class="btn btn-primary btn-lg btn-block" BackColor="#428bca" style="padding:10px 16px" runat="server" 
                        Text="报修" OnClick="btnsave_Click"  OnClientClick="return valid();" />
                </div>
     
   </div>
    


<script>
    $(document).ready(function () {
        //Sel_sb();//设备下拉
        Sel_GZDESC();
        
    })
   
    function valid() {
        if ($("select[id*='ddl_equip']").val() == "") {
            alert("请选择【设备简称】.");
            return false;
        }
        if ($("#ddl_mojuno").val() == "") {
            alert("请选择【模具号】.");
            return false;
        }
       
        var rdval = $("input[type='radio']:checked").val()
        if (typeof (rdval) == "undefined")
        {
           alert("请选择报修等级!");
           return false;
        }

        if ($("#gztype").val() == "") {
            alert("请选择【故障类型】.");
            return false;
        }

        //if ($("input[id*=txt_moci]").val() == "") {
        //    alert("请输入本次上机模次.");
        //    return false;
        //}
        //else {
        //    var moci_value = $("#txt_moci").val();
        //    if (!(/^(\+|-)?\d+$/.test(moci_value)) || moci_value < 0) {

        //        alert("本次上机模次必须是正整数！");
        //        return false;

        //    }
        //}


        return true;
    }
    
</script>


</form>
</body></html>