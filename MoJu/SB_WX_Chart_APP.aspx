﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SB_WX_Chart_APP.aspx.cs" Inherits="MoJu_SB_WX_Chart_APP" %>

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

        function findLegendItem(name) {
            let index;
            for (let i = 0; i < legendItems.length; i++) {
                if (legendItems[i].name === name) {
                    index = i;
                    break;
                }
            }
            return index;
        }

        const legendItems = [{
            name: '时长',
            fill: '#FACC14',
        }, {
            name: '次数',
            fill: '#000'
        }];

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
                        pixelRatio: window.devicePixelRatio,
                        padding: ['auto', 'auto', 90, 'auto']
                    });

                    chart.source(data, {
                        sc: {
                            tickInterval: 5,
                            alias: '时长'
                        },
                        cs: {
                            tickInterval: 5,
                            alias: '次数'
                        },
                        name: {
                            range: [0, 1]
                        }
                    });


                    //chart.tooltip({
                    //    showCrosshairs: true,
                    //    showItemMarker: false,
                    //    onShow: function onShow(ev) {
                    //    }
                    //});

                    chart.axis('cs', {
                        grid: null
                    });
                    chart.axis('rep', {
                        label: {
                            rotate: Math.PI / 3,
                            textAlign: 'start',
                            textBaseline: 'middle'
                        }
                    });

                    // 自定义图例内容以及交互行为
                    chart.legend({
                        custom: true,
                        items: legendItems,
                        onClick: function onClick(ev) {
                            const item = ev.clickedItem;
                            const name = item.get('name');
                            const checked = item.get('checked');
                            const children = item.get('children');
                            if (checked) {
                                const markerFill = children[0].attr('fill');
                                const textFill = children[1].attr('fill');
                                children[0].set('_originColor', markerFill); // 缓存 marker 原来的颜色
                                children[1].set('_originColor', textFill); // 缓存文本原来的颜色
                            }
                            const geoms = chart.get('geoms');
                            for (let i = 0; i < geoms.length; i++) {
                                const geom = geoms[i];

                                if (geom.getYScale().alias === name) {
                                    if (!checked) {
                                        geom.show();
                                        children[0].attr('fill', children[0].get('_originColor'));
                                        children[1].attr('fill', children[1].get('_originColor'));
                                    } else {
                                        geom.hide();
                                        children[0].attr('fill', '#bfbfbf'); // marker 置灰
                                        children[1].attr('fill', '#bfbfbf'); // 文本置灰 置灰
                                    }
                                }
                                item.set('checked', !checked);
                                legendItems[findLegendItem(name)].checked = !checked;
                            }
                        }
                    });

                    // tooltip 和图例的联动
                    chart.tooltip({
                        showCrosshairs: true,
                        custom: true, // 自定义 tooltip 内容框
                        onChange: function onChange(obj) {
                            const legend = chart.get('legendController').legends.top[0];
                            const tooltipItems = obj.items;
                            const legendItems = legend.items;
                            const map = {};
                            legendItems.forEach(function (item) {
                                map[item.name] = _.clone(item);
                            });
                            tooltipItems.forEach(function (item) {
                                const name = item.name;
                                const value = item.value;
                                if (map[name]) {
                                    map[name].value = value;
                                }
                            });
                            legend.setItems(_.values(map));
                        },
                        onHide: function onHide() {
                            const legend = chart.get('legendController').legends.top[0];
                            legend.setItems(legendItems);
                        }
                    });

                    chart.line().position('rep*sc').color('#FACC14');
                    chart.point().position('rep*sc').size(3)
                      .style({
                          fill: '#FACC14',
                          stroke: '#fff',
                          lineWidth: 1
                      });

                    chart.line().position('rep*cs').color('#000');
                    chart.point().position('rep*cs').size(3)
                      .style({
                          fill: '#000',
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
