//生产上线
function sm_lotno(_workshop) {
    wx.ready(function () {
        wx.scanQRCode({
            needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
            scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
            success: function (res) {
                var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                // code 在这里面写上扫描二维码之后需要做的内容 
                lotno_change(result, _workshop);
            }
            //, cancel: function () {
            //    window.location.href = "/workorder/Load_Material.aspx?lotno=&need_no=&workshop=" + _workshop + "&para=";
            //}
        });
    });
}

function lotno_change(result, _workshop) {
    $.ajax({
        type: "post",
        url: "Cjgl1.aspx/lotno_change",
        data: "{'result':'" + result + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
        success: function (data) {
            var obj = eval(data.d);
            var flag = obj[0].flag;
            var msg = obj[0].msg;

            if (flag == "Y") {
                layer.alert(msg);
                return;
            }
            window.location.href = "/workorder/Load_Material.aspx?lotno=" + result + "&need_no=" + obj[0].need_no + "&workshop=" + _workshop + "&para=" + obj[0].para;
        }

    });

}

//生产下线
function sm_product_off(_workshop) {
    wx.ready(function () {
        wx.scanQRCode({
            needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
            scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
            success: function (res) {
                var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                // code 在这里面写上扫描二维码之后需要做的内容 
                var bj = result.toUpperCase().substring(0, 1).toUpperCase();
                if ((bj != "W" && bj != "G") || result.length != 8) {
                    alert("完成单号不正确，请重新扫描");

                }
                else {
                    window.location.href = "/workorder/Off_Material.aspx?dh=" + result + "&workshop=" + _workshop;
                }

            }, cancel: function () {
                window.location.href = "/workorder/Off_Material.aspx?dh=&workshop=" + _workshop;
            }
        });
    });
};

//压铸完成
function sm_yz_off(_workshop) {
    wx.ready(function () {
        wx.scanQRCode({
            needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
            scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
            success: function (res) {
                var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                // code 在这里面写上扫描二维码之后需要做的内容 
                var bj = result.toUpperCase().substring(0, 1).toUpperCase();
                if ((bj != "W" && bj != "G") || result.length != 8) {
                    alert("完成单号不正确，请重新扫描");

                }
                else {
                    window.location.href = "/workorder/YZWC.aspx?dh=" + result + "&workshop=" + _workshop;
                }

            }, cancel: function () {
                window.location.href = "/workorder/YZWC.aspx?dh=&workshop=" + _workshop;
            }
        });
    });
};


//后处理完成
function sm_hsolve_off(_workshop) {
    wx.ready(function () {
        wx.scanQRCode({
            needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
            scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
            success: function (res) {
                var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                // code 在这里面写上扫描二维码之后需要做的内容 
                var bj = result.toUpperCase().substring(0, 1).toUpperCase();
                if ((bj != "W" && bj != "G") || result.length != 8) {
                    alert("完成单号不正确，请重新扫描");

                }
                else {
                    window.location.href = "/workorder/YZ_HSolve.aspx?dh=" + result + "&workshop=" + _workshop;
                }

            }, cancel: function () {
                window.location.href = "/workorder/YZ_HSolve.aspx?dh=&workshop=" + _workshop;
            }
        });
    });
};

//检验完成
function sm_qc_off(_workshop) {
    wx.ready(function () {
        wx.scanQRCode({
            needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
            scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
            success: function (res) {
                var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                // code 在这里面写上扫描二维码之后需要做的内容 
                var bj = result.toUpperCase().substring(0, 1).toUpperCase();
                if ((bj != "W" && bj != "G") || result.length != 8) {
                    alert("完成单号不正确，请重新扫描");

                }
                else {
                    window.location.href = "/workorder/Quantity_Checked.aspx?dh=" + result + "&workshop=" + _workshop;
                }

            }, cancel: function () {
                window.location.href = "/workorder/Quantity_Checked.aspx?dh=&workshop=" + _workshop;
            }
        });
    });
};


//仓库接受
/*function sm_ck_dh(_workshop) {
    wx.ready(function () {
        wx.scanQRCode({
            needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
            scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
            success: function (res) {
                var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                // code 在这里面写上扫描二维码之后需要做的内容 
                ck_dh_change(result, _workshop);

            }, cancel: function () {
                $.modal({
                    title: "",
                    text: $("#div_2").html(),
                    buttons: []
                });
            }
        });
    });
}

function ck_dh_change(result, _workshop) {
    $.ajax({
        type: "post",
        url: "Cjgl1.aspx/ck_dh_change",
        data: "{'result':'" + result + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
        success: function (data) {
            var obj = eval(data.d);
            var flag = obj[0].flag;
            var msg = obj[0].msg;

            if (flag == "Y") {
                layer.alert(msg);
                return;
            }

            if (msg == "hg") {
                window.location.href = "/workorder/Ruku_Print.aspx?dh=" + result + "&workshop=" + _workshop + "&ck=N";
            }
            else if (msg == "bf") {
                window.location.href = "/workorder/CKSH.aspx?dh=" + result + "&workshop=" + _workshop + "&ck=N";
            }
            else if (msg == "rk") {
                window.location.href = "/workorder/Ruku_hege.aspx?dh=" + result + "&workshop=" + _workshop + "&ck=N";
            }
            else if (msg == "bhg") {
                window.location.href = "/workorder/Ruku_bcp_hege.aspx?dh=" + result + "&workshop=" + _workshop + "&ck=N";
            }
        }

    });

}*/

//不合格处理
function sm_workorder(_workshop) {
    wx.ready(function () {
        wx.scanQRCode({
            needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
            scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
            success: function (res) {
                var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                // code 在这里面写上扫描二维码之后需要做的内容 
                workorder_change(result, _workshop);

            }, cancel: function () {
                //window.location.href = "/workorder/bhgp_Apply_V1.aspx?workorder=&workorder_f=&workshop=" + _workshop;

                var str_addr = "/workorder/";
                if (_workshop == "二车间" || _workshop == "四车间") { str_addr = str_addr + "bhgp_Apply_V1.aspx"; }
                if (_workshop == "三车间") { str_addr = str_addr + "bhgp_Apply_yz.aspx"; }
                window.location.href = str_addr + "?workorder=&workorder_f=&workshop=" + _workshop;
            }
        });
    });

    //workorder_change("Q0001208");
};

function workorder_change(result, _workshop) {
    $.ajax({
        type: "post",
        url: "Cjgl1.aspx/workorder_change",
        data: "{'result':'" + result + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,//默认是true，异步；false为同步，此方法执行完在执行下面代码
        success: function (data) {
            var obj = eval(data.d);
            var json_wk = obj[0].json_wk;

            var workorder = "";
            var workorder_f = "";
            var cur_sign_step = "";
            var str_addr = "/workorder/";
            if (json_wk.length == 0) {

                workorder = result;
                //window.location.href = "/workorder/bhgp_Apply_V1.aspx?workorder=" + workorder + "&workorder_f=" + workorder_f
                //    + "&workshop=" + _workshop;

                if (_workshop == "二车间" || _workshop == "四车间") { str_addr = str_addr + "bhgp_Apply_V1.aspx"; }
                if (_workshop == "三车间") { str_addr = str_addr + "bhgp_Apply_yz.aspx"; }
                window.location.href = str_addr + "?workorder=" + workorder + "&workorder_f=" + workorder_f + "&workshop=" + _workshop;

            } else if (json_wk.length == 1) {

                workorder = json_wk[0]["workorder"];
                workorder_f = json_wk[0]["workorder_f"];
                cur_sign_step = json_wk[0]["cur_sign_step"];
                if (cur_sign_step == "0001" || cur_sign_step == "0003" || cur_sign_step == "0004" || cur_sign_step == "0005") {//当前签核步骤在 返工，且只有一笔

                    //window.location.href = "/workorder/bhgp_sign_V1.aspx?stepid=" + cur_sign_step + "&workorder=" + workorder + "&workorder_f=" + workorder_f + "&workshop=" + _workshop;

                    if (_workshop == "二车间" || _workshop == "四车间") { str_addr = str_addr + "bhgp_sign_V1.aspx"; }
                    if (_workshop == "三车间") { str_addr = str_addr + "bhgp_sign_yz.aspx"; }
                    window.location.href = str_addr + "?stepid=" + cur_sign_step + "&workorder=" + workorder + "&workorder_f=" + workorder_f + "&workshop=" + _workshop;

                } else {
                    //window.location.href = "/workorder/bhgp_Apply_V1.aspx?workorder=" + workorder + "&workorder_f=" + workorder_f
                    //+ "&workshop=" + _workshop;

                    if (_workshop == "二车间" || _workshop == "四车间") { str_addr = str_addr + "bhgp_Apply_V1.aspx"; }
                    if (_workshop == "三车间") { str_addr = str_addr + "bhgp_Apply_yz.aspx"; }
                    window.location.href = str_addr + "?workorder=" + workorder + "&workorder_f=" + workorder_f + "&workshop=" + _workshop;
                }

            } else {

                workorder = json_wk[0]["workorder"];
                window.location.href = "/workorder/bhgp_Apply_wk_V1.aspx?workorder=" + workorder + "&workshop=" + _workshop;

            }

        }

    });

}