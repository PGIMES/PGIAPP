<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SB_WX_Chart_APP_bak.aspx.cs" Inherits="MoJu_SB_WX_Chart_APP_bak" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
    <title></title>
     <link rel="stylesheet" href="/css/weui.css"/>
    <link rel="stylesheet" href="/css/weuix.css"/>

    <script src="/js/zepto.min.js"></script>
    <script src="/js/zepto.weui.js"></script>
    <script src="/js/f2.min.js"></script>
</head>
<body ontouchstart>
   <div class="page-bd-15">
    <canvas id="myChart" height="260"></canvas>
    <script>

        $(document).ready(function () {
            $.ajax({
                type: "post",
                url: "SB_WX_Chart_APP.aspx/init",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
                success: function (data) {
                    var data = eval(data.d);

                    const chart = new F2.Chart({
                        id: 'myChart',
                        pixelRatio: window.devicePixelRatio
                    });

                    chart.source(data, {
                        sc: {
                            tickCount: 5,
                            min: 0
                        },
                        rep: {
                            range: [0, 1]
                        }
                    });
                    chart.tooltip({
                        showCrosshairs: true,
                        showItemMarker: false,
                        onShow: function onShow(ev) {
                            //const items = ev.items;
                            //items[0].name = null;
                            //items[0].value = items[0].sc;
                        }
                    });
                    chart.axis('rep', {
                        label: function label(text, index, total) {
                            const textCfg = {};
                            if (index === 0) {
                                textCfg.textAlign = 'left';
                            } else if (index === total - 1) {
                                textCfg.textAlign = 'right';
                            }
                            textCfg.rotate = Math.PI / 6;
                            return textCfg;
                        }
                    });
                    chart.line().position('rep*sc');
                    chart.point().position('rep*sc').style({
                        stroke: '#fff',
                        lineWidth: 1
                    });
                    chart.render();
                }

            });
        });



    </script>
    </div>
</body>
</html>
