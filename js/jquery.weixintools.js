/**
 * Created by yidezhi on 2015/11/24.
 */
(function ($) {

    var wxTools = {
        version: 1.0
    };

    $.wxTools = wxTools;

    var _wx_params = {
        title: null,                    // 转发时的标题
        desc: null,                     // 转发时的描述
        shareDesc: null,               // 分享到朋友圈儿时的描述
        imgUrl: "",                    // 转发时的图片地址
        redirectLink: null,           // 转发后点开跳转到的链接地址（默认为当前页面的链接地址）
        pageCode: null,                // 转发的页面代码（添加在历史记录中，防止把同一个页面转发给同一个人，多次点开作弊行为，若需要有积分行为，则转发页面必须有该值，并且唯一）
        pageType: null,                // 转发页面的页面类型（对应数据中心系统里面的SharePageType枚举）
        bAddShare: false,             // 是否添加分享历史记录（该值为true时，bAddScore和bClickScore的值有效，否则无效）
        eUid: null,                    // 转发的受益人id（转发或者被点开时加积分的受益人id，如果没有显式给值，则默认受益人为当前登录人员）
        bAddScore: false,             // 是否在转发时直接添加积分
        bClickScore: false,          // 是否在被点开时添加积分
        bEmployeeScore: true,        // 记录积分是否内部员工默认优先（默认是）（如果内部员工优先，则非内部员工帮内部员工转发时，积分产生在内部员工身上）
        serverKey: null,              // 转发时的某些信息需要来自服务器配置时，服务器配置的键值（当有title，desc，shareDesc的显式指定值时，该值找到的相应配置值失效）
        // bPointScore为true时，以shareScore和readScore设置的值为积分增长，当bPointScore为false时，shareScore和readScore值无效
        bPointScore: false,           // 产生积分数是否以下面显式设置的值为准
        shareScore: 0,                 // 分享动作发生时添加的积分数（0代表不添加积分，负数代表以数据库配置积分为准）
        readScore: 0,                   // 分享被点开时添加的积分数（0代表不添加积分，负数代表以数据库配置为准，如果bAddShare值为false或者bClickScore值为false，则该值无效）
        // 是否要单独引入依赖的js框架
        importJson: false,             // 是否自动引入依赖的json2框架
        importJsWeixin: false,        // 是否自动引入依赖的微信js框架
        importJsProtocol: "http",     // 引入js依赖的协议（importJsWeixin为true时有效）
        needLoading: true,             // 加载转发信息时是否需要loading遮盖层
        getLocation: false,            // 是否要获取地理位置
        getLocationCallback: function(latitude, longitude, speed, accuracy){},      // 获取地理位置后的回调函数（latitude--纬度，longitude--经度，speed--速度（米/每秒），accuracy--位置精度）
        cancelGetLocationCallback: function () {},//拒绝地理位置授权的回调函数
        failGetLocationCallback: function () {},//获取地理位置失败的回调函数
        hideMenus: false               // 是否要隐藏微信右上角菜单
    };

    var _config = {
        development: false,               // 是否是开发环境的标识
        uid: null,                         // 转发人的id（默认没有值）
        time: null,                        // 转发的时间戳
        eUid: null,                        // 转发积分受益人的id（默认没有值）
        oUid: null,                        // 原转发人id（添加转发历史用，用于查询原转发（父转发）记录）
        oeUid: null,                       // 原转发受益人id（添加转发历史用，用于查询原转发（父转发）记录，当没有原转发人时，启用该值查找）
        oTime: null,                       // 原转发时间戳（添加转发历史用，用于查询原转发（父转发）记录）
        link: null,                        // 转发链接
        readLink: null,                   // 转发出去后，别人打开的链接地址
        scriptDomain: null,              // 引用js文件的域名
        ajaxDomain: null,                // 异步请求的域名
        secretKey: "sharePage",         // 对参数进行加密的键值
        curOperate: null,                // 当前操作（分享给好友，或发送到朋友圈）
        shareType: {sendToF: "SENDTOFRIEND", shareToF: "SHARETOFRIEND", forwardBeC: "FORWARD_CLICKED"}
    };

    wxTools.share = function(params){
        for(var key in params) {
            if(params[key] && params[key]!="" && params[key]!="null") { _wx_params[key] = params[key]; }
            if(params[key] == false) { _wx_params[key] = params[key]; }
        }
        _importLocalJs();
        _setConfigLink();
        // 设置来自服务器配置信息的值
        if(_wx_params.serverKey) {
            $.globalAjax.get({
                url: _config.ajaxDomain + "/shareData/shareConfig",
                data: {key: _wx_params.serverKey},
                successCallback: function(data) {
                    if(data.success) {
                        var shareConfig = data.config;
                        if(!_wx_params.title) {
                            _wx_params.title = shareConfig.title;
                            if(shareConfig.bPName && (shareConfig.pageType && shareConfig.pageType.name=="POSITION_CHOICE") && $("#positionNameParams").attr("value")) {
                                _wx_params.title = $("#positionNameParams").attr("value");
                            }
                        }
                        else if(shareConfig.title && shareConfig.title.indexOf("${title}")>=0) { _wx_params.title = shareConfig.title.replace("${title}", _wx_params.title); }
                        if(!_wx_params.desc) { _wx_params.desc = shareConfig.description; }
                        else if(shareConfig.description && shareConfig.description.indexOf("${description}")>=0) { _wx_params.desc = shareConfig.description.replace("${description}", _wx_params.desc); }
                        if(!_wx_params.shareDesc) {
                            _wx_params.shareDesc = shareConfig.shareDesc;
                            if(shareConfig.bPName && (shareConfig.pageType && shareConfig.pageType.name=="POSITION_CHOICE") && $("#positionNameParams").attr("value")) {
                                _wx_params.shareDesc = $("#positionNameParams").attr("value");
                            }
                        }
                        else if(shareConfig.shareDesc && shareConfig.shareDesc.indexOf("${shareDesc}")>=0) { _wx_params.shareDesc = shareConfig.shareDesc.replace("${shareDesc}", _wx_params.shareDesc); }
                        _wxJsTicket();
                    }
                    else { _wxJsTicket(); }
                }
            });
        }
        else { _wxJsTicket(); }
    };

    // 引入依赖的js文件
    var _importLocalJs = function(){
        // 引入jquery.weixintools.js文件的script标签可以给一个domain自定义属性，这里作为异步请求的域名出现，如果不设置这个值，则异步请求的域名默认为global文件中设置的域名
        var scripts = $("script");
        var scriptUrl = "";
        for(var i=0; i<scripts.length; i++){
            if($(scripts[i]).attr("src") && $(scripts[i]).attr("src").indexOf("jquery.weixintools.js") >= 0) {
                scriptUrl = $(scripts[i]).attr("src");
                _config.ajaxDomain = $(scripts[i]).attr("domain");
                break;
            }
        }
        if(!_config.ajaxDomain || _config.ajaxDomain=="" || _config.ajaxDomain=="null") { _config.ajaxDomain = $.global.domain(); }
        _formatScriptDomain(scriptUrl);
        var jsFile = "/js/json2.min.js";
        // 引入框架依赖的js文件，json2.js和腾讯提供的转发框架
        if(_wx_params.importJson) { document.write("<script type='text/javascript' src='"+_config.scriptDomain+jsFile+"'></script>"); }
        if(_wx_params.importJsWeixin) { document.write("<script type='text/javascript' src='" + _wx_params.importJsProtocol + "://res.wx.qq.com/open/js/jweixin-1.0.0.js'></script>"); }
    };

    // 功能：把指定的url地址，截断出域名信息，包含起协议头（例如结果为：http://www.tupu360.com）
    // 参数：requestUrl--指定的rul地址
    // 返回值：截断后的域名地址结果
    var _formatScriptDomain = function(resultUrl){
        if(resultUrl.indexOf(".com") >= 0) { _config.scriptDomain = resultUrl.substring(0, resultUrl.indexOf(".com")+4); }
        else if(resultUrl.indexOf(".cn") >= 0) { _config.scriptDomain = resultUrl.substring(0, resultUrl.indexOf(".cn")+3); }
        else if(resultUrl.indexOf(".net") >= 0) { _config.scriptDomain = resultUrl.substring(0, resultUrl.indexOf(".net")+4); }
        else if(resultUrl.indexOf(".org") >= 0) { _config.scriptDomain = resultUrl.substring(0, resultUrl.indexOf(".org")+4); }
        else if(resultUrl.indexOf(".hk") >= 0) { _config.scriptDomain = resultUrl.substring(0, resultUrl.indexOf(".hk")+3); }
        else if(resultUrl.indexOf("/WXTemplate") >= 0) { _config.scriptDomain = resultUrl.substring(0, resultUrl.indexOf("/WXTemplate")+11); }
    };

    var _setConfigLink = function(){
        _config.link = window.location.href;
        if(_config.link.indexOf("#") >= 0) { _config.link = _config.link.substring(0, _config.link.indexOf("#")); }
        // if(_wx_params.bAddShare) {
        //     // 如果是转发别人转发过的页面，则提取出前面转发的参数（主要是对转发人，受益人以及转发时间的提取）
        //     var spJson = null;
        //     var sp = "";
        //     if(_config.link.indexOf("sp=") >= 0) {
        //         sp = _config.link.substring(_config.link.indexOf("sp=")+3);
        //         if(sp.indexOf("&") >=0 ) { sp = sp.substring(0, sp.indexOf("&")); }
        //     }
        //     if(sp && sp!="") {
        //         _config.link = _config.link.replace("sp="+sp, "");
        //         if(_config.link.indexOf("?&") >= 0) { _config.link = _config.link.replace("?&", "?"); }
        //         else if(_config.link.indexOf("&&") >= 0) { _config.link = _config.link.replace("&&", "&"); }
        //         if(_config.link.slice(-1) == "&") { _config.link = _config.link.substring(0, _config.link.length-1); }
        //         if(_config.link.slice(-1) == "?") { _config.link = _config.link.substring(0, _config.link.length-1); }
        //         spJson = eval("("+_decrypt(sp, _config.secretKey)+")");
        //         if(spJson.uid) { _config.oUid = spJson.uid; }
        //         if(spJson.time) { _config.oTime = spJson.time; }
        //         if(spJson.eUid) {
        //             _config.eUid = spJson.eUid;
        //             _config.oeUid = spJson.eUid;
        //         }
        //     }
        // }
        _config.readLink = (_wx_params.redirectLink) ? _wx_params.redirectLink : _config.link;
    };

    var _wxJsTicket = function(){
        $.globalAjax.post({
            url: _config.ajaxDomain + "/weiXin/wxJsTicket",
            // data: {curUrl: window.encodeURIComponent(window.location.href), eUid: _config.eUid},
            data: {curUrl: window.encodeURIComponent(window.location.href)},
            needLoading: _wx_params.needLoading,
            successCallback: function(data){
                if(_wx_params.bAddShare) {
                    _config.time = data.timestamp;
                    // var spJson = {time: data.timestamp};
                    // // 设置转发人id（当前登录人员）
                    // if(data.uid) {
                    //     _config.uid = data.uid;
                    //     spJson.uid = data.uid;
                    //     // 如果没有受益人（不是转发的别人的转发记录，或者别人的转发记录没有受益人）或者内部员工没有受益优先权限，则设置受益人为当前登录人员
                    //     if(!_config.eUid || !_wx_params.bEmployeeScore) { _config.eUid = data.uid; }
                    //     // 如果有受益人（转发的是别人的转发记录，并且别人的转发记录已经有受益人存在）并且内部员工受益优先，则需要判断是否是员工受益优先，以及上次转发的受益人是否是内部员工
                    //     else {
                    //         if(data.userRole=="EMPLOYEE") { _config.eUid = data.uid; }
                    //         else {
                    //             $.globalAjax.post({
                    //                 url: _config.ajaxDomain + "/userData/userRole",
                    //                 data: {uid: _config.eUid},
                    //                 async: false,
                    //                 successCallback: function(roleData){
                    //                     if(roleData.role!="EMPLOYEE") { _config.eUid = data.uid; }
                    //                 }
                    //             });
                    //         }
                    //     }
                    // }
                    // 如果有外界指定的受益人id，则设置受益人为指定人，如果没有，则根据当前登录人员的角色判断（看是否员工优先）
                    // if(_wx_params.eUid) { _config.eUid = _wx_params.eUid; }
                    // spJson.eUid = _config.eUid;
                    // _config.readLink += (_config.readLink.indexOf("?") >= 0) ? "&sp=" : "?sp=";
                    // _config.readLink += _encrypt(JSON.stringify(spJson), _config.secretKey);
                    // 如果设置了点开添加积分，则重新制定打开的链接，把原来的链接作为重定向地址参数，并添加额外的参数，以保证知道是给哪位受益人添加积分，给哪条点击记录添加积分
                    if(_wx_params.bClickScore) {
                        var tempReadLink = _config.readLink;
                        // var opJson = {time: spJson.time};
                        // if(_config.uid && _config.uid!="" && _config.uid!="null") { opJson.uid = _config.uid; }
                        // if(_config.eUid && _config.eUid!="" && _config.eUid!="null") { opJson.eUid = _config.eUid; }
                        // if(_wx_params.readScore>0) { opJson.score = _wx_params.readScore; }
                        tempReadLink = _linkLang(tempReadLink, window.location.href);
                        var dataParams = {rl: tempReadLink, time: _config.time, pageType: _wx_params.pageType, pageCode: _wx_params.pageCode};
                        if(_wx_params.readScore>0) { dataParams.score = _wx_params.readScore; }
                        if(_wx_params.bEmployeeScore) { dataParams.emFirst = "Y"; }
                        $.globalAjax.post({
                            url: _config.ajaxDomain + "/shareData/spEncode",
                            // data: {rl: tempReadLink, time: _config.time, op: JSON.stringify(opJson), pageType: _wx_params.pageType},
                            data: dataParams,
                            async: false,
                            needLoading: _wx_params.needLoading,
                            successCallback: function(data){
                                if(data.success) {
                                    _config.readLink = _config.ajaxDomain + "/shareData/shareRead?rl=" + data.rl + "&op=" + data.op;
                                }
                                else {
                                    // _config.readLink = _config.ajaxDomain + "/shareData/shareRead?rl=" + window.encodeURIComponent(tempReadLink) + "&op=" + window.encodeURIComponent(JSON.stringify(opJson));
                                    _config.readLink = _config.ajaxDomain + "/shareData/shareRead?rl=" + window.encodeURIComponent(tempReadLink);
                                }
                            }
                        });
                        // _config.readLink = _config.ajaxDomain + "/shareData/shareRead?rl=" + window.encodeURIComponent(tempReadLink) + "&op=" + window.encodeURIComponent(JSON.stringify(opJson));
                    }
                }
                if(_config.readLink.indexOf("lang=") < 0) {
                    _config.readLink = _linkLang(_config.readLink, window.location.href);
                }
                _wxConfig(data.appId, data.timestamp, data.noncestr, data.signature);
            },
            errorCallback: function(XmlHttpRequest, textStatus, errorThrown){
                console.log("启动微信转发失败！");
            }
        });
    };

    var _linkLang = function(targetUrl, referUrl){
        if(targetUrl.indexOf("lang=")<0 && referUrl.indexOf("lang=")>=0) {
            referUrl = referUrl.substring(referUrl.indexOf("lang="));
            if(referUrl.indexOf("&") >= 0) { referUrl = referUrl.substring(0, referUrl.indexOf("&")); }
            if(referUrl=="lang=" || referUrl=="lang=null") { referUrl = "lang=zh_CN"; }
            targetUrl += (targetUrl.indexOf("?")>=0) ? "&" : "?";
            targetUrl += referUrl;
        }
        return targetUrl;
    };

    // params(link--转发的页面链接，readLink--实际转发出去的链接)
    var _wxConfig = function(appId, timestamp, noncestr, signature, params) {
        wx.config({
            // debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
            appId: appId,
            timestamp: timestamp,
            nonceStr: noncestr,
            signature: signature,
            jsApiList: ['onMenuShareAppMessage', 'onMenuShareTimeline',"getLocation", "openLocation",
                'startRecord', 'stopRecord', 'onVoiceRecordEnd', 'playVoice', 'stopVoice',
                'onVoicePlayEnd', 'uploadVoice', 'downloadVoice', 'translateVoice',
            ]
        });

        wx.ready(function(){
            wx.checkJsApi({
                jsApiList: ['onMenuShareAppMessage', 'onMenuShareTimeline', "getLocation", "openLocation"], // 需要检测的JS接口列表
                success: function(res) {
                    // 以键值对的形式返回，可用的api值true，不可用为false
                    // 如：{"checkResult":{"chooseImage":true},"errMsg":"checkJsApi:ok"}
                    console.log(res);
                }
            });

            wx.onMenuShareAppMessage({
                title: _wx_params.title,           // 分享标题
                desc: _wx_params.desc,             // 分享描述
                link: _config.readLink,           // 分享链接
                imgUrl: _wx_params.imgUrl,        // 分享图标
                type: 'link',                     // 分享类型,music、video或link，不填默认为link
                trigger: function(res) {
                    if(res.shareTo=="friend" || res.scene=="friend") {
                        if(_wx_params.bAddShare) {
                            _addSharePageHistory(_config.shareType.sendToF);
                        }
                    }
                },
                success: function(res) {
                },
                cancel: function(res) { _config.curOperate = null; },
                fail: function(res) { _config.curOperate = null; }
            });

            wx.onMenuShareTimeline({
                title: _wx_params.shareDesc,    // 分享描述
                link: _config.readLink,         // 分享链接
                imgUrl: _wx_params.imgUrl,      // 分享图标
                trigger: function(res) {
                    if(_wx_params.bAddShare) {
                        _addSharePageHistory(_config.shareType.shareToF);
                    }
                },
                success: function (res) {
                },
                cancel: function (res) { _config.curOperate = null; },
                fail: function(res) { _config.curOperate = null; }
            });

            if(_wx_params.hideMenus) {
                wx.hideOptionMenu();
            }

            if(_wx_params.getLocation) {
                wx.getLocation({
                    type: "gcj02",
                    success: function(res) {
                        _wx_params.getLocationCallback(res.latitude, res.longitude, res.speed, res.accuracy);
                    },
                    cancel:function () { _wx_params.cancelGetLocationCallback();},
                    fail:function () {_wx_params.failGetLocationCallback();}
                });
            }
        });

        wx.error(function(res){});
    };

    // 添加转发历史
    var _addSharePageHistory = function(shareType){
        var dataParams = {time: _config.time, type: shareType, link: window.encodeURIComponent(_config.link)};
        // 设置转发人和受益人参数
        // if(_config.uid && _config.uid!="" && _config.uid!="null") {
        //     dataParams.uid = _config.uid;
        //     dataParams.eUid = _config.uid;
        // }
        // if(_config.eUid && _config.eUid!="" && _config.eUid!="null") { dataParams.eUid = _config.eUid; }
        // // 设置原始的转发人，转发时间和受益人id，用于获取上次转发记录（父转发记录，以便于记录转发链条）
        // if(_config.oTime && _config.oTime!="" && _config.oTime!="null") { dataParams.oTime = _config.oTime; }
        // if(_config.oUid && _config.oUid!="" && _config.oUid!="null") { dataParams.oUid = _config.oUid; }
        // if(_config.oeUid && _config.oeUid!="" && _config.oeUid!="null") { dataParams.oeUid = _config.oeUid; }
        // 如果转发时直接添加积分，则设置积分分值参数
        if(_wx_params.bAddScore && _wx_params.shareScore>0) { dataParams.score = _wx_params.shareScore; }
        // 设置转发的页面代码和类型，为后续的防止刷分做准备
        if(_wx_params.pageCode) { dataParams.pageCode = _wx_params.pageCode; }
        if(_wx_params.pageType) { dataParams.pageType = _wx_params.pageType; }
        if(_wx_params.bEmployeeScore) { dataParams.emFirst = "Y"; }
        $.globalAjax.post({
            url: _config.ajaxDomain + "/shareData/addShareHistory",
            data: dataParams,
            successCallback: function(data){
                console.log("添加转发历史记录成功！");
            },
            errorCallback: function(XMLHttpRequest, textStatus, errorThrown) {
                console.log("添加转发历史记录失败！");
            }
        });
    };

    var _encrypt = function(str, pwd) {
        if(pwd == null || pwd.length <= 0) {
            console.log("请指定加密秘钥");
            return null;
        }
        var prand = "";
        for(var i=0; i<pwd.length; i++) {
            prand += pwd.charCodeAt(i).toString();
        }
        var sPos = Math.floor(prand.length / 5);
        var mult = parseInt(prand.charAt(sPos) + prand.charAt(sPos*2) + prand.charAt(sPos*3) + prand.charAt(sPos*4) + prand.charAt(sPos*5));
        var incr = Math.ceil(pwd.length / 2);
        var modu = Math.pow(2, 31) - 1;
        if(mult < 2) {
            alert("Algorithm cannot find a suitable hash. Please choose a different password. \nPossible considerations are to choose a more complex or longer password.");
            return null;
        }
        var salt = Math.round(Math.random() * 1000000000) % 100000000;
        prand += salt;
        while(prand.length > 10) {
            prand = (parseInt(prand.substring(0, 10)) + parseInt(prand.substring(10, prand.length))).toString();
        }
        prand = (mult * prand + incr) % modu;
        var enc_chr = "";
        var enc_str = "";
        for(var i=0; i<str.length; i++) {
            enc_chr = parseInt(str.charCodeAt(i) ^ Math.floor((prand / modu) * 255));
            if(enc_chr < 16) {
                enc_str += "0" + enc_chr.toString(16);
            } else enc_str += enc_chr.toString(16);
            prand = (mult * prand + incr) % modu;
        }
        salt = salt.toString(16);
        while(salt.length < 8)salt = "0" + salt;
        enc_str += salt;
        return enc_str;
    };

    var _decrypt = function(str, pwd) {
        if(str == null || str.length < 8) {
            console.log("非法密串儿");
            return;
        }
        if(pwd == null || pwd.length <= 0) {
            console.log("请指定解密秘钥");
            return;
        }
        var prand = "";
        for(var i=0; i<pwd.length; i++) {
            prand += pwd.charCodeAt(i).toString();
        }
        var sPos = Math.floor(prand.length / 5);
        var mult = parseInt(prand.charAt(sPos) + prand.charAt(sPos*2) + prand.charAt(sPos*3) + prand.charAt(sPos*4) + prand.charAt(sPos*5));
        var incr = Math.round(pwd.length / 2);
        var modu = Math.pow(2, 31) - 1;
        var salt = parseInt(str.substring(str.length - 8, str.length), 16);
        str = str.substring(0, str.length - 8);
        prand += salt;
        while(prand.length > 10) {
            prand = (parseInt(prand.substring(0, 10)) + parseInt(prand.substring(10, prand.length))).toString();
        }
        prand = (mult * prand + incr) % modu;
        var enc_chr = "";
        var enc_str = "";
        for(var i=0; i<str.length; i+=2) {
            enc_chr = parseInt(parseInt(str.substring(i, i+2), 16) ^ Math.floor((prand / modu) * 255));
            enc_str += String.fromCharCode(enc_chr);
            prand = (mult * prand + incr) % modu;
        }
        return enc_str;
    };

    wxTools.openLocation = function (position) {
        wx.openLocation({
            latitude: parseFloat(position.latitude), // 纬度，浮点数，范围为90 ~ -90
            longitude: parseFloat(position.longitude), // 经度，浮点数，范围为180 ~ -180。
            name: position.name,         // 位置名
            address: position.workAddress, // 地址详情说明
            scale: (position.scale) ? position.scale : 14,     // 地图缩放级别,整形值,范围从1~28。默认为最大
            infoUrl: position.infoUrl, // 在查看位置界面底部显示的超链接,可点击跳转
            fail: function (res) {
                console.log("打开地理位置失败！")
            }
        });
    };
})(jQuery);