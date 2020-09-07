
//检测申请
function sm_jc() {
    wx.ready(function () {
        wx.scanQRCode({
            needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
            scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
            success: function (res) {
                var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                // code 在这里面写上扫描二维码之后需要做的内容 
                var bj = result.toUpperCase().substring(0, 1).toUpperCase();
                if (bj != "C" || result.length != 8) {
                    layer.alert("【检测单号】必须是C开头，长度为8位.请重新扫描.");
                }
                else {
                    window.location.href = "/JianCe/JC_Apply.aspx?dh=" + result;
                }

            }, cancel: function () {
                window.location.href = "/JianCe/JC_Apply.aspx?dh=";
            }
        });
    });
};
