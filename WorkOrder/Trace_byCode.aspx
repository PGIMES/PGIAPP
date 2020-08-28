<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Trace_byCode.aspx.cs" Inherits="Trace_byCode" %>

<!DOCTYPE html>

<html  >
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>扫码查询结果</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0" />
    <link rel="stylesheet" href="../css/weui.css" />
    <link rel="stylesheet" href="../css/weuix.css?v=1.2" />
    <style>
        .weui-mark-lt {
            color: #fff;
            display: block;
            font-size: 0.775em !important;
            left: -2.5em;
            height: 1em;
            line-height: 1em !important;
            position: relative;
            text-align: center;
            top: 0.25em;
            transform: rotate(-45deg);
            width: 3.375em;
            padding: 0.125em;
        }

        table td {
            padding-bottom: 0px;
            padding-top: 0px;
            border: 0px hidden white;
        }
        .span_space{
            padding-right:20px
        }
    </style>
    <style>
        html,body,iframe{
            padding:0;
            margin:0;
            width:100%;
            /*height:100%*/
        }
        iframe{
            border:0;
         }
    </style>
    <script src="../js/zepto.min.js"></script>
    <script src="../js/zepto.weui.js"></script>
    <script src="../js/iscroll-lite.js"></script>

    <script>
        $(function () { 
            $('#t2').tab({
                defaultIndex:0,// _index == null ? 0 : _index,
                activeClass: 'tab-green',
                onToggle: function (index) {
                    //console.log('index' + index);
                }
            })
               
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


        })
    </script>
    <script>

        $(function(){
            if(<% =ds.Tables[0].Rows.Count+ds.Tables[1].Rows.Count  %>==0){                
                $.alert("未发现【 <% =Request.QueryString["dh"] %> 】对应的记录.","提示",function(){
                     history.back(-1);
                });
                
            } 

        });
    </script>
</head>
<body ontouchstart >

    <form id="form1" runat="server">
        <div class="page">
            <div class="page__bd" id="t2" style="height: 100%;">
                <div class="weui-tab">
                    <div class="weui-navbar">
                        <div href="#tab1" class="weui-navbar__item weui-bar__item_on">
                            来自
                        </div>
                        <div href="#tab2" class="weui-navbar__item">
                            去往
                        </div>
                    </div>
                    <%System.Data.DataTable dt  = ds.Tables[0];%>
                    <%System.Data.DataTable dt2  = ds.Tables[1];%>
                    <div class="weui-tab__panel"  >
                        <%--==来自==--%>
                        <div id="tab1" class="weui-tab__content" style="overflow-y: scroll;display:inherit"> 
                            <% 
                            if (dt.Rows.Count > 0)
                            {%>
                                <%--<%=dt.Rows[0]["content"] %> --%>
                                <iframe src="<%=dt.Rows[0]["href"]%>"   height="700"></iframe>                              
                            <% }
                            else {%> <div class="tcenter;margin20-t">未发现来自记录1</div> <% } %>                                                   
                                                      
                        </div>
                        <%--==去往==--%>
                        <div id="tab2" class="weui-tab__content">  
                            
                            <ul class="collapse">                                
                                <% if (dt2.Rows.Count == 0) {%>   <div class="tcenter;margin20-t">未发现去往记录</div><% };
                                    foreach (System.Data.DataRow dr in dt2.Rows) {%>
                                                                  
                                <li class="">
                                    <%=dr["content"] %> 
                                    <%--<div class="weui-flex js-category">
                                        <div class="weui-flex__item"><%=dr["nextstep"] %>单<%=dr["dh"] %></div>
                                        <i class="icon icon-74"></i>
                                    </div>--%>
                                    <%--<div class="page-category js-categoryInner">
                                        <div class="weui-cells page-category-content">                                             
                                           <iframe src="<%=dr["href"] %>"  height="700" ></iframe> 
                                        </div>
                                    </div>--%>
                                </li>  
                               <%}%>                            
                            </ul>                             
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <script>
            $(function () {
                $('.weui-navbar__item').on('click', function () {
                    $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
                    $($(this).attr("href")).show().siblings('.weui-tab__content').hide();
                });

            });</script>
    </form>
</body>
</html>
