/**
 * Created by yidezhi on 2016/6/22.
 */
(function($){

    var common = { version: 1.0 };

    $.tpCommon = common;

    common.domain = function() { return window.location.host; };

    common.catDomain = function() {
        var curDomain = window.location.host;
        var curHref = window.location.href;
        if(curHref.indexOf("company_") >= 0) {
            curHref = curHref.substring(curHref.indexOf("company_"));
            curHref = curHref.substring(0, curHref.indexOf("/"));
            return curDomain + "/" + curHref;
        }
        return curDomain;
    };

    common.cdnDomain = function() { return $("#commonJsScript").attr("domain"); };

    common.curLang = function() {
        var href = window.location.href;
        if(href.indexOf("lang=") >= 0) {
            href = href.substring(href.indexOf("lang=") + 5);
            if(href.indexOf("&") >= 0) {
                return href.substring(0, href.indexOf("&"));
            }
            else { return href; }
        }
        else { return "zh_CN"; }
    };

    common.interruptBubble = function(e) {
        if(e && e.stopPropagation()) { e.stopPropagation(); }
        else { window.event.cancelBubble = true; }
    };

    common.scroll = function(callback) {
        $(window).scroll(function() {
            var scrollHeight = document.documentElement.scrollHeight;//文档大小
            var scrollTop = document.documentElement.scrollTop + document.body.scrollTop;//超出外层元素上边界的部分
            var height = document.documentElement.clientHeight;//可见区域的宽度
            if(scrollTop+height+1 >= scrollHeight) {
                if(!window.isTriggerScroll) {
                    window.isTriggerScroll = true;
                    if(callback) {
                        callback(function(){
                            window.isTriggerScroll = false;
                        });
                    }
                }
            }
        });
    };

    common.constant = {
        degreeList: {
            degree_zh: ["初中", "高中", "中技", "中专", "大专", "本科", "硕士", "博士", "MBA", "EMBA", "其他"],
            degree_zh_CN: ["初中", "高中", "中技", "中专", "大专", "本科", "硕士", "博士", "MBA", "EMBA", "其他"],
            degree_zh_HK: ["初中", "高中", "中技", "中專", "大專", "本科", "碩士", "博士", "MBA", "EMBA", "其他"],
            degree_zh_TW: ["初中", "高中", "中技", "中專", "大專", "本科", "碩士", "博士", "MBA", "EMBA", "其他"],
            degree_en: ["Junior high", "Senior high", "Technical school", "Secondary sepcialized", "Associate", "Bachelor", "Master", "Doctor", "MBA", "EMBA", "Other"]
        },
        degree: function(lang){
            if(!lang || lang=="" || lang=="null") { lang = "zh_CN"; }
            console.log(lang);
            return common.constant.degreeList["degree_" + lang];
        },
        degree_default: function(value, lang) {
            var defaultObj = {zh_CN: "本科", en: "Bachelor", zh_HK: "本科", zh_TW: "本科"};
            if(!lang || lang=="" || lang=="null" || lang=="zh") { lang = "zh_CN"; }
            return value == defaultObj[lang];
        },
        degree_zh: function() { return ["初中", "高中", "中技", "中专", "大专", "本科", "硕士", "博士", "MBA", "EMBA", "其他"]; },
        degree_zh_CN: function() { return ["初中", "高中", "中技", "中专", "大专", "本科", "硕士", "博士", "MBA", "EMBA", "其他"]; },
        degree_zh_HK: function() { return ["初中", "高中", "中技", "中專", "大專", "本科", "碩士", "博士", "MBA", "EMBA", "其他"]; },
        degree_zh_TW: function() { return ["初中", "高中", "中技", "中專", "大專", "本科", "碩士", "博士", "MBA", "EMBA", "其他"]; },
        degree_en: function() { return ["Junior high", "Senior high", "Technical school", "Secondary sepcialized", "Associate", "Bachelor", "Master", "Doctor", "MBA", "EMBA", "Other"]; },

        //是否住宿
        accommodationList:{
            accommodation_zh: ["可以", "不可以"],
            accommodation_zh_CN: ["可以", "不可以"],
            accommodation_zh_HK: ["可以", "不可以"],
            accommodation_zh_TW: ["可以", "不可以"],
            accommodation_en: ["yes", "no"]
        },
        accommodation: function(lang){
            if(!lang || lang=="" || lang=="null") { lang = "zh_CN"; }
            return common.constant.accommodationList["accommodation_" + lang];
        },
        accommodation_default: function(value, lang) {
            var defaultObj = {zh_CN: "可以", en: "yes", zh_HK: "可以", zh_TW: "可以"};
            if(!lang || lang=="" || lang=="null" || lang=="zh") { lang = "zh_CN"; }
            return value == defaultObj[lang];
        },
        accommodation_zh: function() { return ["可以", "不可以"]; },
        accommodation_zh_CN: function() { return ["可以", "不可以"]; },
        accommodation_zh_HK: function() { return ["可以", "不可以"]; },
        accommodation_zh_TW: function() { return ["可以", "不可以"]; },
        accommodation_en: function() { return ["yes", "no"]; },


        //性别选择
        genderList:{
            gender_zh:["男","女"],
            gender_zh_CN:["男","女"],
            gender_zh_HK:["男","女"],
            gender_zh_TW:["男","女"],
            gender_en:["male","female"]
        },
        gender: function (lang) {
            if(!lang || lang=="" || lang=="null") { lang = "zh_CN"; }
            return common.constant.genderList["gender_" + lang];
        },
        gender_defult: function (value, lang) {
            var defaultObj = {zh_CN: "男", en: "male", zh_HK: "男", zh_TW: "男"};
            if(!lang || lang=="" || lang=="null" || lang=="zh") { lang = "zh_CN"; }
            return value == defaultObj[lang];
        },
        gender_zh:function () {return ["男","女"]},
        gender_zh_CN:function () {return ["男","女"]},
        gender_zh_HK:function () {return ["男","女"]},
        gender_zh_TW:function () {return ["男","女"]},
        gender_en:function () {return ["male","female"]},

        //员工身份选择
        isEmployeeList:{
            isEmployee_zh:["非员工","员工"],
            isEmployee_zh_CN:["非员工","员工"],
            isEmployee_zh_HK:["非員工","員工"],
            isEmployee_zh_TW:["非員工","員工"],
            isEmployee_en:["Non Employee","Employee"]
        },
        isEmployee: function (lang) {
            if(!lang || lang=="" || lang=="null") { lang = "zh_CN"; }
            return common.constant.isEmployeeList["isEmployee_" + lang];
        },
        //党员选择
        partyMemberList:{
            party_zh:["非党员","党员"],
            party_zh_CN:["非党员","党员"],
            party_zh_HK:["非黨員","黨員"],
            party_zh_TW:["非黨員","黨員"],
            party_en:["Non Party Members","Party Member"]
        },
        party: function (lang) {
            if(!lang || lang=="" || lang=="null") { lang = "zh_CN"; }
            return common.constant.partyMemberList["party_" + lang];
        },
        // 婚姻状态选择
        maritalStatusList:{
            maritalStatus_zh:["未婚","已婚"],
            maritalStatus_zh_CN:["未婚","已婚"],
            maritalStatus_zh_HK:["未婚","已婚"],
            maritalStatus_zh_TW:["未婚","已婚"],
            maritalStatus_en:["Single","Married"],
        },
        maritalStatus:function (lang) {
            if(!lang || lang=="" || lang=="null") { lang = "zh_CN"; }
            return common.constant.maritalStatusList["maritalStatus_" + lang];
        },
        // 是否为老员工
        oldEmployeeList:{
            oldEmployee_zh:["无本企业就职经验","有本企业就职经验"],
            oldEmployee_zh_CN:["无本企业就职经验","有本企业就职经验"],
            oldEmployee_zh_HK:["無本企業就職經驗","有本企業就職經驗"],
            oldEmployee_zh_TW:["無本企業就職經驗","有本企業就職經驗"],
            oldEmployee_en:["Having working experience with subject entity "," Non working experience with subject entity "],
        },
        oldEmployee:function (lang) {
            if(!lang || lang=="" || lang=="null") { lang = "zh_CN"; }
            return common.constant.oldEmployeeList["oldEmployee_" + lang];
        },
        //每周实习天数选择
        internshipDays: function () { return ["1","2","3","4","5","6","7"] },
        //学校是否支持实习协议
        intAgreementList:{
            intAgreement_zh:["支持","不支持","不知道"],
            intAgreement_zh_CN:["支持","不支持","不知道"],
            intAgreement_zh_HK:["支持","不支持","不知道"],
            intAgreement_zh_TW:["支持","不支持","不知道"],
            intAgreement_en:["Yes","No","I don't know"],
        },
        intAgreement: function (lang) {
            if(!lang || lang=="" || lang=="null") { lang = "zh_CN"; }
            return common.constant.intAgreementList["intAgreement_" + lang];
        },
        //招聘人数为0时显示若干
        headCountNums:{
            headCountNum_zh:["若干"],
            headCountNum_zh_CN:["若干"],
            headCountNum_zh_HK:["若干"],
            headCountNum_zh_TW:["若干"],
            headCountNum_en:["some"],
        },
        headCountNum: function (lang) {
            if(!lang || lang=="" || lang=="null") { lang = "zh_CN"; }
            return common.constant.headCountNums["headCountNum_" + lang];
        },
        workStateList:{
            workState_zh:["在职","非在职"],
            workState_zh_CN:["在职","非在职"],
            workState_zh_HK:["在職","非在職"],
            workState_zh_TW:["在職","非在職"],
            workState_en:["On","Not"],
        },
        workState: function (lang) {
            if(!lang || lang=="" || lang=="null") { lang = "zh_CN"; }
            return common.constant.workStateList["workState_" + lang];
        },
    };

    // 请求时的loading遮盖层
    common.progressPanel = {
        show: function(mainPanel) {
            var coverPanel = $(mainPanel).find("#progressCoverPanel");
            if(!coverPanel || coverPanel.length<=0) {
                var coverHeight = Math.max($(window).height(), document.documentElement.scrollHeight);
                var windowHeight = $(window).height();
                var cover = $("<div id='progressCoverPanel' style='position: fixed; top:0;left:0;right:0;bottom:0;text-align: center;vertical-align: middle;background-color: #000000;opacity: 0.5;filter:alpha(opacity=50);z-index:9999'></div>");
                if(!mainPanel) { mainPanel = "body"; }
                var imgMarginTop = (windowHeight-250)/2;
                var srcUrl = common.cdnDomain()+"/images/page_loading.gif";
                var progressLoading = $("<img id='progressLoadingImg' src='"+srcUrl+"' style='width: 190px; height: 150px; margin-top:"+imgMarginTop+"px; z-index:9999;' />");
                cover.append(progressLoading);
                $(mainPanel).append(cover);
            }
        },

        remove: function() {
            if($("#progressCoverPanel").length >= 0) {
                $("#progressCoverPanel").remove();
            }
        }
    };

    // 提示转发的遮盖层
    common.shareClip = {
        show: function(){
            var clipCover = $("body").find("#shareClipPanel");
            if(!clipCover || clipCover.length<=0) {
                var clipHtml = "<div id='shareClipPanel' class='share-notice-box' style='display: none; position:fixed; width:100%; height:100%; top:0; left:0; background:rgba(0,0,0,.8); text-align:right; z-index:999;'>" +
                    "  <div class='share-notice'> <img src='"+common.cdnDomain()+"/images/shareNotice_" + common.curLang() + ".png' /></div>" +
                    "</div>";
                $("body").append(clipHtml);
            }
            $("#shareClipPanel").fadeIn(300);
            $("#shareClipPanel").off("click").on("click", function(){
                $("#shareClipPanel").fadeOut(300);
            });
        }
    };

    // 本地存储
    common.globalStorage = {
        localStore: function(key, value) {
            if(window.localStorage) {
                var storage = window.localStorage;
                if(value && value!="" && value!="null" && value!="undefined") {
                    storage.setItem(key, value);
                    return value;
                }
                else { return storage.getItem(key); }
            }
            else { return null; }
        },
        removeLocalStore: function(key) {
            if(window.localStorage) { window.localStorage.removeItem(key); }
        },
        sessionStore: function(key, value) {
            if(window.sessionStorage) {
                var storage = window.sessionStorage;
                if(value && value!="" && value!="null" && value!="undefined") {
                    storage.setItem(key, value);
                    return value;
                }
                else { return storage.getItem(key); }
            }
            else { return null; }
        },
        removeSessionStore: function(key) {
            if(window.sessionStorage) { window.sessionStorage.removeItem(key); }
        }
    };

    // 全局form表单校验提示
    common.validateForm = {
        defaultParams: {
            formId: null,                          // 要验证的form表单的id
            clipContent: null,                    // 弹窗提示语内容
            clipTemplateKey: null,               // 在本地缓存的弹窗模板html的键值
            clipContainerId: null,               // 弹窗模板中，提示语容器标签的id
            clipCloseBtnId: null,                // 弹窗模板中，关闭按钮标签的id
            clipAutoClose: true,                 // 提示弹窗是否自动关闭
            clipTime: 0,                          // 提示弹窗显示的默认时间（到达时长后，自动关闭，该值在clipAutoClose为true时有效）
            clipCallback: null,                  // 提示弹窗关闭时的回调函数
            specialValidateCall: null           // 特殊校验的回调函数
        },
        validate: function(params){
            var dataParams = _mergeValidateFormParams(params);
            var flag = true;
            if(dataParams.formId) {
                var validateObjs = $("#" + dataParams.formId).find("[validate='yes']");
                $.each(validateObjs, function(k, v){
                    if(!$(v).is(":hidden") || $(v).attr("type")=="hidden") {
                        // 校验非空
                        if($(v).attr("vEmpty") == "yes") {
                            if($(v).val().trim() == "") {
                                var clipContent = $(v).attr("vEmptyClip");
                                clipContent = (dataParams.clipContent) ? dataParams.clipContent:((clipContent) ? clipContent:"该项不可为空！");
                                _validateFormClip(clipContent, dataParams);
                                flag = false;
                                return false;
                            }
                        }
                        // 校验邮箱格式
                        if($(v).attr("vEmail") == "yes") {
                            //如果邮箱配置成非必填，则当邮箱为空时可以校验通过，如果填写了邮箱，则校验邮箱格式
                            if($(v).attr("vEmpty") != "yes" && $(v).val().trim() == "") return true;
                            var email = $(v).val().trim();
                            if (email.indexOf("@")!=-1){
                                var emailPreffix = email.substring(0,email.indexOf("@"));
                                var emailSuffix = email.substring(email.indexOf("@"),email.length);
                                email = emailPreffix.trim() + emailSuffix.trim();
                                console.log(email)
                            }

                            if(email.indexOf("*")>=0 || !(/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$/i.test(email.trim()))) {
                                var clipContent = $(v).attr("vEmailClip");
                                clipContent = (dataParams.clipContent) ? dataParams.clipContent:((clipContent) ? clipContent:"邮箱格式错误！");
                                _validateFormClip(clipContent, dataParams);
                                flag = false;
                                return false;
                            }
                        }
                        // 校验手机号码格式
                        if($(v).attr("vMobile") == "yes") {
                            var mobile = $(v).val().trim().replace("\u202D","").replace("\u202C","");
                            //如果手机配置成非必填，则当手机为空时可以校验通过，如果填写了手机，则校验手机格式
                            if($(v).attr("vEmpty")!="yes" && mobile == ""){
                                flag = true;
                                return true;
                            }
                            if(mobile.length<7 || mobile.length>25 || /[^\d\+\(\)\-\s]/.test(mobile)) {
                                var clipContent = $(v).attr("vMobileClip");
                                clipContent = (dataParams.clipContent) ? dataParams.clipContent:((clipContent) ? clipContent:"手机号码错误！");
                                _validateFormClip(clipContent, dataParams);
                                flag = false;
                                return false;
                            }
                        }
                        // 校验数字
                        if($(v).attr("vNum") == "yes") {
                            var thisValue = $(v).val().trim();
                            if(thisValue && thisValue!="" && !$.isNumeric(thisValue)) {
                                var clipContent = $(v).attr("vNumClip");
                                clipContent = (dataParams.clipContent) ? dataParams.clipContent:((clipContent) ? clipContent:"该项只能输入数字！");
                                _validateFormClip(clipContent, dataParams);
                                flag = false;
                                return false;
                            }
                        }
                        //校验输入数字是否超过最大值
                        if ($(v).attr("vNumMax") && $(v).attr("vNumMax")!="" && $.isNumeric($(v).attr("vNumMax"))){
                            var thisValue = $(v).val().trim();
                            if (thisValue && thisValue!="" && $.isNumeric(thisValue) && parseInt(thisValue) > parseInt($(v).attr("vNumMax"))){
                                var clipContent = $(v).attr("vNumMaxClip");
                                if (clipContent && clipContent.indexOf("#{numMax}") >= 0){
                                    clipContent = clipContent.replace("#{numMax}",$(v).attr("vNumMax"))
                                }
                                clipContent = (dataParams.clipContent) ? dataParams.clipContent:((clipContent) ? clipContent:"该项只能输入小于等于"+$(v).attr("vNumMax")+"的数字！");
                                _validateFormClip(clipContent, dataParams);
                                flag = false;
                                return false;
                            }
                        }
                        // 校验两次输入的信息一致性
                        if($(v).attr("vSame") == "yes") {
                            var thisValue = $(v).val().trim();
                            var targetValue = $("#"+$(v).attr("targetId")).val();
                            if(thisValue != targetValue) {
                                var clipContent = $(v).attr("vSameClip");
                                clipContent = (dataParams.clipContent) ? dataParams.clipContent:((clipContent) ? clipContent:"两次输入的数据不一致！");
                                _validateFormClip(clipContent, dataParams);
                                flag = false;
                                return false;
                            }
                        }
                        // 校验正整数
                        if($(v).attr("vPositiveInteger") == "yes") {
                            var thisValue = $(v).val().trim();
                            if (!_isPositiveInteger(thisValue)){
                                var clipContent = $(v).attr("vPositiveIntegerClip");
                                clipContent = (dataParams.clipContent) ? dataParams.clipContent:((clipContent) ? clipContent:"该项只能输入正整数！");
                                _validateFormClip(clipContent, dataParams);
                                flag = false;
                                return false;
                            }
                        }
                        // 校验非负整数
                        if($(v).attr("vNotNegativeInteger") == "yes") {
                            var thisValue = $(v).val().trim();
                            if (thisValue && thisValue!="" && !_isNotNegativeInteger(thisValue)){
                                var clipContent = $(v).attr("vNotNegativeIntegerClip");
                                clipContent = (dataParams.clipContent) ? dataParams.clipContent:((clipContent) ? clipContent:"该项只能输入非负整数！");
                                _validateFormClip(clipContent, dataParams);
                                flag = false;
                                return false;
                            }
                        }
                        // 最小长度校验
                        if($(v).attr("vMinLength") && $(v).attr("vMinLength")!="" && typeof($(v).attr("vMinLength"))=="number") {
                            var thisValue = $(v).val().trim();
                            if(thisValue.length < parseInt($(v).attr("vMinLength"))) {
                                var clipContent = $(v).attr("vMinLengthClip");
                                clipContent = (dataParams.clipContent) ? dataParams.clipContent:((clipContent) ? clipContent:"该项至少需要"+$(v).attr("vMinLength")+"个字！");
                                _validateFormClip(clipContent, dataParams);
                                flag = false;
                                return false;
                            }
                        }
                        // 最大长度校验
                        if($(v).attr("vMaxLength") && $(v).attr("vMaxLength")!="") {
                            var thisValue = $(v).val().trim();
                            if(thisValue.length > parseInt($(v).attr("vMaxLength"))) {
                                var clipContent = $(v).attr("vMaxLengthClip");
                                clipContent = (dataParams.clipContent) ? dataParams.clipContent:((clipContent) ? clipContent:"该项最多为"+$(v).attr("vMaxLength")+"个字！");
                                _validateFormClip(clipContent, dataParams);
                                flag = false;
                                return false;
                            }
                        }
                        // 下拉框必选校验
                        if($(v).attr("vSelect") == "yes") {
                            var selectedVal = $(v).find("option:selected").val().trim();
                            if (!selectedVal || selectedVal=="null" || selectedVal.indexOf("请选择")>=0){
                                var clipContent = $(v).attr("vSelectClip");
                                clipContent = (dataParams.clipContent) ? dataParams.clipContent:((clipContent) ? clipContent:"该项必须选择！");
                                _validateFormClip(clipContent, dataParams);
                                flag = false;
                                return false;
                            }
                        }

                        if($(v).attr("vIdCard") == "yes"){
                            var idCard = $(v).val().trim();
                            if(!_isIdCard(idCard)) {
                                var clipContent = $(v).attr("vIdCardClip");
                                clipContent = (dataParams.clipContent) ? dataParams.clipContent:((clipContent) ? clipContent:"身份证号输入不合法！");
                                _validateFormClip(clipContent, dataParams);
                                flag = false;
                                return false;
                            }
                        }
                        //n位数校验(身份证号后n位校验)
                        if($(v).attr("vLength") && $(v).attr("vLength") != ''){
                            var len = $(v).val().trim();
                            var tLength = parseInt($(v).attr("vLength"));
                            if(!_vLength(len, tLength)) {
                                var clipContent = $(v).attr("vIdCardClip");
                                clipContent = (dataParams.clipContent) ? dataParams.clipContent:((clipContent) ? clipContent:"请输入您的身份证号后四位！");
                                _validateFormClip(clipContent, dataParams);
                                flag = false;
                                return false;
                            }
                        }
                        //11位手机号校验
                        if($(v).attr("vMobile11") == 'yes'){
                            var mobile = $(v).val().trim();
                            if($(v).attr("vEmpty")!="yes" && mobile == ""){
                                flag = true;
                                return true;
                            }
                            if( !/^[1][3,4,5,7,8,9][0-9]{9}$/.test(mobile)) {
                                var clipContent = $(v).attr("vMobile11Clip");
                                clipContent = (dataParams.clipContent) ? dataParams.clipContent:((clipContent) ? clipContent:"11位手机号码错误！");
                                _validateFormClip(clipContent, dataParams);
                                flag = false;
                                return false;
                            }
                        }

                        if ($(v).attr("vDateFormat") == "yes") {
                            var dateValue = $(v).val().trim();
                            if (dateValue != "" && dateValue != undefined && dateValue != null) {
                                var dateFormatHtml = $(v).attr("dateFormatHtml");
                                if (dateFormatHtml.indexOf(".") > 0) {
                                    var dateFormatArray =  dateFormatHtml.split(".");
                                    var dateValueArray =  dateValue.split(".");
                                    if (dateFormatArray.length != dateValueArray.length) {
                                        var clipContent = $(v).attr("vDateFormatClip");
                                        clipContent = (dataParams.clipContent) ? dataParams.clipContent:((clipContent) ? clipContent:"日期格式错误！");
                                        _validateFormClip(clipContent, dataParams);
                                        flag = false;
                                        return false;
                                    }
                                }
                            }
                        }

                        // 通过生日检查是否成年
                        if ($(v).attr("vAdult") == "yes") {
                            var dateValue = $(v).val().trim();
                            var date = new Date();
                            var currentYear = date.getFullYear();
                            var currentMonth = date.getMonth()+1;
                            var currentDay = date.getDate();
                            if (dateValue != "" && dateValue != undefined && dateValue != null) {
                                var dateValueArray = dateValue.split(".");
                                if (currentYear-dateValueArray[0] < 18){
                                    clipContent = (dataParams.clipContent) ? dataParams.clipContent:((clipContent) ? clipContent:"您未满18周岁，请返回修改出生日期");
                                    _validateFormClip(clipContent, dataParams);
                                    flag = false;
                                    return false;
                                } else if (currentYear-dateValueArray[0] == 18) {
                                    if (dateValueArray.length>1){
                                        if(currentMonth-dateValueArray[1]<0){
                                            clipContent = (dataParams.clipContent) ? dataParams.clipContent:((clipContent) ? clipContent:"您未满18周岁，请返回修改出生日期");
                                            _validateFormClip(clipContent, dataParams);
                                            flag = false;
                                            return false;
                                        }else if (currentMonth-dateValueArray[1] == 0){
                                            if (dateValueArray.length>2){
                                                if (currentDay-dateValueArray[2] < 0){
                                                    clipContent = (dataParams.clipContent) ? dataParams.clipContent:((clipContent) ? clipContent:"您未满18周岁，请返回修改出生日期");
                                                    _validateFormClip(clipContent, dataParams);
                                                    flag = false;
                                                    return false;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                });
            }
            // 其他的特殊校验
            if(dataParams.specialValidateCall && flag) { flag = dataParams.specialValidateCall.call(); }
            return flag;
        }
    };
    var _mergeValidateFormParams = function(dataParams) {
        var resultDataParams = {};
        for(var key in common.validateForm.defaultParams) {
            if((dataParams[key] || (!dataParams[key] && (typeof(dataParams[key])=="boolean" || typeof(dataParams[key])=="number"))) && dataParams[key]!="null") { resultDataParams[key] = dataParams[key]; }
            else { resultDataParams[key] = common.validateForm.defaultParams[key]; }
        }
        return resultDataParams;
    };
    var _validateFormClip = function(clipContent, dataParams) {
        common.globalClip.showTime(clipContent, dataParams.clipCallback, dataParams.clipTime, dataParams.clipContainerId, dataParams.clipCloseBtnId, dataParams.clipTemplateKey);
    };
    var _isPositiveInteger = function(v){
        if(/^[1-9]+[0-9]*]*$/.test(v)){ return true; }
        else { return false; }
    };
    var _isNotNegativeInteger = function(v){
        if(/^(0|[1-9]\d*)$/.test(v)){ return true; }
        else { return false; }
    };
    //身份证号判断
    var _isIdCard = function (card) {
        // 身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X
        if(/(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/.test(card)){ return true; }
        {return false;}
    };

    var _vLength = function (v, tLength) {
        if(v.length != tLength) {
            return false;
        }
        return true;
    };

    // 全局浮动菜单
    common.floatMenu = {
        localKey: function(){ return {htmlKey: common.catDomain()+"_FLOATMENU_HTML", cssKey: common.catDomain()+"_FLOATMENU_CSS", menuItemKey: common.catDomain()+"_FLOATMENU_ITEM"}},
        keyValue: function(){ return {menuContainerId: "diskContainer", showBtnId: "showMenuBtn", positionId: "positionFloatMenu", idSuffix: "FloatMenu"}},
        disk: function(showMap){
            var templateKey = common.floatMenu.localKey();
            var templateHtml = common.globalStorage.sessionStore(templateKey.htmlKey);
            if(templateHtml && templateHtml!="" && templateHtml!="null") { _floatMenuShow(templateHtml) }
            else {
                $.globalAjax.get({
                    url: $.global.domain() + "/clip/diskFloatMenu",
                    async: false,
                    successCallback: function(data){
                        if(data.menu && data.menu!="" && data.menu!="null") {
                            templateHtml = data.html;
                            common.globalStorage.sessionStore(templateKey.htmlKey, templateHtml);
                            common.globalStorage.sessionStore(templateKey.cssKey, JSON.stringify({path: data.cssPath, version: data.cssVersion}));
                            common.globalStorage.sessionStore(templateKey.menuItemKey, JSON.stringify(data.menu));
                            _floatMenuShow(templateHtml, data.menu);
                        }
                    },
                    errorCallback: function(data){}
                });
            }
            if(showMap) {
                $("#showMapBtn").show();
                $("#showMapBtn").off("touchmove").on("touchmove", function(e){
                    _dragDiskMenu(e, "showMapBtn", "showMapBtn");
                });
            }else { $("#showMapBtn").remove();}
        }
    };
    var _floatMenuShow = function(templateHtml, menuItemData){
        var menuContainerId = common.floatMenu.keyValue().menuContainerId;
        var showBtnId = common.floatMenu.keyValue().showBtnId;
        var positionId = common.floatMenu.keyValue().positionId;
        var idSuffix = common.floatMenu.keyValue().idSuffix;
        var templateKey = common.floatMenu.localKey();
        if(!menuItemData) { menuItemData = JSON.parse(common.globalStorage.sessionStore(templateKey.menuItemKey)) }
        $("body").find(".normal-page-wrap").append(templateHtml);
        $("#"+showBtnId).off("click").on("click", function(){
            _floatMenuShowOrHide([menuContainerId, "qrCodeContainer"]);
        });
        $("#"+showBtnId).off("touchmove").on("touchmove", function(e){
            _dragDiskMenu(e, showBtnId, "showQrCodeBtn");
        });
        if(menuItemData.showQrCode == "yes") {
            // 如果当前语言是英文，将二维码替换成有英文文字描述的二维码
            if (common.curLang() == "en"){
                //如果配置了英文二维码显示动图 则显示出英文动态图片二维码
                if(menuItemData.imgCodeGif && menuItemData.imgCodeGif!="" && menuItemData.imgCodeGif!="null"){
                    var qrImgPath = $("#qr_box_img").attr("src");
                    var temp = qrImgPath.substring(0,qrImgPath.lastIndexOf("code-img.png")) + menuItemData.imgCodeGif;
                    var suffix = temp.substring(temp.lastIndexOf("."),temp.length);
                    var prefix = temp.substring(0,temp.lastIndexOf("."))+"_"+ common.curLang();
                    $("#qr_box_img").attr("src",prefix+suffix);
                }else{
                    var qrImgPath = $("#qr_box_img").attr("src");
                    var suffix = qrImgPath.substring(qrImgPath.lastIndexOf("."),qrImgPath.length);
                    var prefix = qrImgPath.substring(0,qrImgPath.lastIndexOf("."))+"_"+ common.curLang();
                    $("#qr_box_img").attr("src",prefix+suffix);
                }
            }else{
                //如果配置了二维码显示动图 则显示出动态图片二维码
                if(menuItemData.imgCodeGif && menuItemData.imgCodeGif!="" && menuItemData.imgCodeGif!="null"){
                        var qrImgPath = $("#qr_box_img").attr("src");
                        var prefix = qrImgPath.substring(0,qrImgPath.lastIndexOf("code-img.png"));
                        $("#qr_box_img").attr("src",prefix+menuItemData.imgCodeGif);
                }
            }
            $("#showQrCodeBtn").show();
            $("#showQrCodeBtn").off("click").on("click", function(){
                _floatMenuShowOrHide(["qrCodeContainer", menuContainerId]);
            });
            $("#showQrCodeBtn").off("touchmove").on("touchmove", function(e){
                _dragDiskMenu(e, "showQrCodeBtn", showBtnId);
            });
        }
        var floatMenuObjs = [$("#" + menuItemData.top + idSuffix), $("#" + menuItemData.right + idSuffix), $("#" + menuItemData.bottom + idSuffix), $("#" + menuItemData.left + idSuffix)];
        $("#floatMenuContainer").empty();
        for(var i=0; i<floatMenuObjs.length; i++) {
            $("#floatMenuContainer").append(floatMenuObjs[i]);
        }
        var lang = common.curLang() ? common.curLang() : "zh_CN";
        if (menuItemData.positionText && menuItemData.positionText != "" && menuItemData.positionText != "null"
            && menuItemData.positionText[lang] && menuItemData.positionText[lang] != "" && menuItemData.positionText[lang] != "null"){
            $("#" + positionId + "Text").html(menuItemData.positionText[lang])
        }
        if (menuItemData.topText && menuItemData.topText != "" && menuItemData.topText != "null"
            && menuItemData.topText[lang] && menuItemData.topText[lang] != "" && menuItemData.topText[lang] != "null" ){
            $("#" + menuItemData.top + idSuffix + "Text").html(menuItemData.topText[lang])
        }
        if (menuItemData.rightText && menuItemData.rightText != "" && menuItemData.rightText != "null"
            && menuItemData.rightText[lang] && menuItemData.rightText[lang] != "" && menuItemData.rightText[lang] != "null"){
            $("#" + menuItemData.right + idSuffix + "Text").html(menuItemData.rightText[lang])
        }
        if (menuItemData.leftText && menuItemData.leftText != "" && menuItemData.leftText != "null"
            && menuItemData.leftText[lang] && menuItemData.leftText[lang] != "" && menuItemData.leftText[lang] != "null"){
            $("#" + menuItemData.left + idSuffix + "Text").html(menuItemData.leftText[lang])
        }
        if (menuItemData.bottomText && menuItemData.bottomText != "" && menuItemData.bottomText != "null"
            && menuItemData.bottomText[lang] && menuItemData.bottomText[lang] != "" && menuItemData.bottomText[lang] != "null"){
            $("#" + menuItemData.bottom + idSuffix + "Text").html(menuItemData.bottomText[lang])
        }
        $("#" + positionId).off("click").on("click", function(){
            if(menuItemData.isBlue == "yes"){
                _floatMenuHref("bluePosition");
            }else if(menuItemData.isGeneral == "yes"){
                _floatMenuHref("generalPosition");
            } else{
                _floatMenuHref("position", menuItemData.positionLink);
            }
        });
        $("#" + menuItemData.top + idSuffix).off("click").on("click", function(){
            _floatMenuHref(menuItemData.top);
        });
        $("#" + menuItemData.right + idSuffix).off("click").on("click", function(){
            _floatMenuHref(menuItemData.right);
        });
        $("#" + menuItemData.bottom + idSuffix).off("click").on("click", function(){
            _floatMenuHref(menuItemData.bottom);
        });
        $("#" + menuItemData.left + idSuffix).off("click").on("click", function(){
            _floatMenuHref(menuItemData.left);
        });
    };
    var _floatMenuShowOrHide = function(menuIds) {
        var coverShow = $("#diskMenuCoverDiv").css("display");
        if(coverShow == "block") {
            for(var i=0; i<menuIds.length; i++) {
                $("#" + menuIds[i]).removeClass("show-job-guide");
            }
            $("#diskMenuCoverDiv").hide();
        }
        else {
            $("#" + menuIds[0]).addClass("show-job-guide");
            $("#diskMenuCoverDiv").show();
            if(menuIds[0] == "qrCodeContainer") {
                $("#closeQrCodeBtn").off("click").on("click", function(){
                    _floatMenuShowOrHide(menuIds);
                });
            }
            $("#diskMenuCoverDiv").off("click").on("click", function(){
                _floatMenuShowOrHide(menuIds);
            });
        }
    };
    var _floatMenuHref = function(key, link) {
        var url = "/position/list";
        if(key == "position") {
            url = "/position/list?type=SOCIALRECRUITMENT&enter=menu";
            if(link && link!="" && link!="null") { url = link; }
        }
        else if(key == "bluePosition") { url = "/position/blueList?enter=menu"; }
        else if(key == "resume") { url = "/resume/index?enter=menu"; }
        else if(key == "resumeManage") { url = "/user/resume?enter=menu"; }
        else if(key == "email") { url = "/user/bindEmail?enter=menu"; }
        else if(key == "history") { url = "/user/history?enter=menu"; }
        else if(key == "import") { url = "/user/resume?enter=menu"; }
        else if(key == "personal") { url = "/user/index?enter=menu"; }
        else if(key == "recommend") { url = "/history/recommend?enter=menu"; }
        else if(key == "socialRecommend") { url = "/history/socialRecommend?enter=menu"; }
        else if(key == "deliver") { url = "/history/deliver?enter=menu"; }
        else if(key == "favorite") { url = "/history/favorite?enter=menu"; }
        else if(key == "generalPosition") {url = "/position/list?type=SOCIALRECRUITMENT&enter=menu&hotSubType=general";}
        else if(key == "robot") {url = "/chat/index?lang=zh_CN";}
        common.pageJump(url);
    };
    var _dragDiskMenu = function(e, menuId1, menuId2){
        e.preventDefault();
        var menuObj1 = $("#" + menuId1);
        var menuObj2 = $("#" + menuId2);
        if(menuObj1.css("position") != "fixed") {
            if(menuObj2 && menuObj2.length>0 && menuObj2.css("position")!="fixed") {
                var obj2Margin = parseInt(menuObj2.css("margin"));
                var obj2Border = parseInt(menuObj2.css("border-width"));
                var obj2Padding = parseInt(menuObj2.css("padding"));
                var obj2Offset = 0;
                if(obj2Margin) { obj2Offset += obj2Margin/2; }
                if(obj2Border) { obj2Offset += obj2Border; }
                if(obj2Padding) { obj2Offset += obj2Padding; }
                menuObj2.css({
                    "position": "fixed",
                    "left": (menuObj2.offset().left - obj2Offset - 1)+"px",
                    "top": (menuObj2.offset().top - obj2Offset - 1 - document.body.scrollTop)+"px"
                });
            }
            menuObj1.css({"position": "fixed"});
        }
        var menuObj1MarginTop = parseInt(menuObj1.css("margin-top"));
        var menuObj1MarginBottom = parseInt(menuObj1.css("margin-bottom"));
        var menuObj1MarginLeft = parseInt(menuObj1.css("margin-left"));
        var menuObj1MarginRight = parseInt(menuObj1.css("margin-right"));
        var screenWidth = $(window).width() - menuObj1.width();
        if(menuObj1MarginLeft) { screenWidth -= menuObj1MarginLeft; }
        if(menuObj1MarginRight) { screenWidth -= menuObj1MarginRight; }
        var screenHeight = $(window).height() - menuObj1.height();
        if(menuObj1MarginTop) { screenHeight -= menuObj1MarginTop; }
        if(menuObj1MarginBottom) { screenHeight -= menuObj1MarginBottom; }
        var menuObj1Left = e.originalEvent.changedTouches[0].pageX - menuObj1.width() + 4;
        var menuObj1Top = e.originalEvent.changedTouches[0].pageY - menuObj1.height() + 4;
        menuObj1Top -= document.body.scrollTop;
        menuObj1Left = Math.min(screenWidth, menuObj1Left);
        menuObj1Top = Math.min(screenHeight, menuObj1Top);
        menuObj1Left = Math.max(0, menuObj1Left);
        menuObj1Top = Math.max(0, menuObj1Top);
        menuObj1.css ({
            "left": menuObj1Left+"px",
            "top": menuObj1Top+"px"
        });
    };

    // 全局确认弹层
    common.globalConfirm = {
        localKey: function(){ return {htmlKey: common.domain()+"_CONFIRM_HTML", cssKey: common.domain()+"_CONFIRM_CSS"} },
        keyValue: function(){ return {clipContainerId: "confirmClipContainer", contentContainerId: "clipContentContainer", closeBtnId: "confirmCloseBtn", yesBtnId: "yesBtn", noBtnId: "noBtn", nextBtnId: "nextBtn"}},
        show: function(content, yesCallback, noCallback, nextCallback) {
            var templateKey = common.globalConfirm.localKey();
            var templateHtml = common.globalStorage.sessionStore(templateKey.htmlKey);
            var dataParams = {};
            dataParams["curLang"] = common.curLang();
            if(templateHtml && templateHtml!="" && templateHtml!="null") { _confirmDialogShow(content, templateHtml, yesCallback, noCallback, nextCallback); }
            else {
                $.globalAjax.get({
                    url: $.global.domain()+"/clip/confirm",
                    data: dataParams,
                    dataType: "json",
                    async: false,
                    successCallback: function(data){
                        templateHtml = data.html;
                        common.globalStorage.sessionStore(templateKey.htmlKey, templateHtml);
                        if(data.cssPath && data.cssPath!="" && data.cssPath!="null") {
                            common.globalStorage.sessionStore(templateKey.cssKey, JSON.stringify({path: data.cssPath, version: data.cssVersion}));
                        }
                        _confirmDialogShow(content, templateHtml, yesCallback, noCallback, nextCallback);
                    },
                    errorCallback: function(data){}
                });
            }
            return templateHtml;
        }
    };
    var _confirmDialogShow = function(content, templateHtml, yesCallback, noCallback, nextCallback, containerId, closeBtnId, yesBtnId, noBtnId, nextBtnId){
        if(!containerId || containerId=="" || containerId=="null") { containerId = common.globalConfirm.keyValue().contentContainerId; }
        if(!closeBtnId || closeBtnId=="" || closeBtnId=="null") { closeBtnId = common.globalConfirm.keyValue().closeBtnId; }
        if(!yesBtnId || yesBtnId=="" || yesBtnId=="null") { yesBtnId = common.globalConfirm.keyValue().yesBtnId; }
        if(!noBtnId || noBtnId=="" || noBtnId=="null") { noBtnId = common.globalConfirm.keyValue().noBtnId; }
        if(!nextBtnId || nextBtnId=="" || nextBtnId=="null") { nextBtnId = common.globalConfirm.keyValue().nextBtnId; }
        var templateObj = $(templateHtml);
        var confirmDialog = $("body").find("#"+$(templateObj).attr("id"));
        if(!confirmDialog || confirmDialog.length==0) {
            var confirmCssObj = $("head").find("#confirmCss");
            if(!confirmCssObj || confirmCssObj.length<=0) {
                var templateKey = common.globalConfirm.localKey();
                var cssDataStr = common.globalStorage.sessionStore(templateKey.cssKey);
                var cssDataObj = (cssDataStr && cssDataStr!="null") ? JSON.parse(cssDataStr) : null;
                if(cssDataObj) {
                    // $("head").append("<link id='confirmCss' href='"+ cssDataObj.path +"?v=" + cssDataObj.version + "' rel='stylesheet' type='text/css'>");
                }
            }
            $("body").append(templateHtml);
            confirmDialog = $("body").find("#"+$(templateObj).attr("id"));
        }
        $("#"+containerId).html(content);
        confirmDialog.fadeIn();
        confirmDialog.css("display", confirmDialog.attr("display"));
        if($("#"+yesBtnId).length > 0) {
            $("#"+yesBtnId).off("click").on("click", function(){
                if(yesCallback) {
                    common.storeCurUrlToTargetUrl();
                    yesCallback.call();
                }
                _confirmDialogRemove(confirmDialog);
            });
        }
        if($("#"+noBtnId).length > 0) {
            $("#"+noBtnId).off("click").on("click", function(){
                $.globalAjax.get({
                    url: $.global.domain()+"/userData/unEmployee",
                    successCallback: function(data){
                        if(noCallback) { noCallback.call(); }
                        _confirmDialogRemove(confirmDialog);
                    }
                });
                if(noCallback) { noCallback.call(); }
                _confirmDialogRemove(confirmDialog);
            });
        }
        if($("#"+nextBtnId).length > 0) {
            $("#"+nextBtnId).off("click").on("click", function(){
                if(nextCallback) { nextCallback.call(); }
                _confirmDialogRemove(confirmDialog);
            });
        }
        if($("#"+closeBtnId).length > 0) {
            $("#"+closeBtnId).off("click").on("click", function() {
                _confirmDialogRemove(confirmDialog);
            });
        }
    };
    var _confirmDialogRemove = function(dialogObj){
        $(dialogObj).fadeOut();
        setTimeout(function() {
            $(dialogObj).remove();
        }, 500);
    };

    // 全局提示弹层
    common.globalClip = {
        localKey: function(){ return {htmlKey: common.domain()+"_CLIP_DIALOG_HTML", cssKey: common.domain()+"_CLIP_DIALOG_CSS"} },
        keyValue: function(){ return {contentContainerId: "clipContentContainer", closeBtnId: "clipCloseBtn", time: 3}; },
        removeClipTimeout: null,
        showTime: function(content, callback, time, containerId, closeBtnId, templateKey){
            window.isClipClose = false;
            if(!time || time=="null"|| time=="") { time = common.globalClip.keyValue().time; }
            var templateHtml = _templateHtml(content, null, callback, containerId, closeBtnId, templateKey);
            if(time && time>0) {
                common.globalClip.removeClipTimeout = setTimeout(function(){
                    if(!window.isClipClose) {
                        window.isClipClose = true;
                        var templateObj = $(templateHtml);
                        var clipDialog = $("body").find("#"+$(templateObj).attr("id"));
                        if(clipDialog && clipDialog.length>0) {
                            _clipDialogRemove(clipDialog);
                            if(callback) { callback.call(); }
                        }
                        setTimeout(function() {
                            window.isClipClose = false;
                        }, 500);
                    }
                }, time*1000);
            }
        },
        showDataTime: function(content, dataParams, callback, time, containerId, closeBtnId, templateKey) {
            if(!time || time!="null") { time = common.globalClip.keyValue().time; }
            var templateHtml = _templateHtml(content, dataParams, callback, containerId, closeBtnId, templateKey);
            if(time && time>0) {
                common.globalClip.removeClipTimeout = setTimeout(function(){
                    var templateObj = $(templateHtml);
                    var clipDialog = $("body").find("#"+$(templateObj).attr("id"));
                    if(clipDialog && clipDialog.length>0 && clipDialog.attr("sign")==templateObj.attr("sign")) {
                        if(!window.isClipClose) {
                            window.isClipClose = true;
                            _clipDialogRemove(clipDialog);
                            if(callback) { callback(dataParams); }
                            setTimeout(function() {
                                window.isClipClose = false;
                            }, 500);
                        }
                    }
                }, time*1000);
            }
        },
        show: function(content, callback, containerId, closeBtnId, templateKey){
            _templateHtml(content, null, callback, containerId, closeBtnId, templateKey);
        }
    };
    var _templateHtml = function(content, dataParams, callback, containerId, closeBtnId, templateKey) {
        if(templateKey && templateKey!="null") { templateKey = {htmlKey: templateKey, cssKey: templateKey+"_CSS"}; }
        else { templateKey = common.globalClip.localKey(); }
        var templateHtml = common.globalStorage.sessionStore(templateKey.htmlKey);
        if(templateHtml && templateHtml!="" && templateHtml!="null") {
            templateHtml = templateHtml.replace("#{timeSign}", new Date().getTime());
            _clipDialogShow(content, dataParams, templateHtml, containerId, closeBtnId, callback);
        }
        else {
            $.globalAjax.get({
                url: $.global.domain()+"/clip/clip",
                data: {},
                dataType: "json",
                async: false,
                successCallback: function(data){
                    templateHtml = data.html;
                    common.globalStorage.sessionStore(templateKey.htmlKey, templateHtml);
                    if(data.cssPath && data.cssPath!="" && data.cssPath!="null") {
                        common.globalStorage.sessionStore(templateKey.cssKey, JSON.stringify({path: data.cssPath, version: data.cssVersion}));
                    }
                    templateHtml = templateHtml.replace("#{timeSign}", new Date().getTime());
                    _clipDialogShow(content, dataParams, templateHtml, containerId, closeBtnId, callback);
                },
                errorCallback: function(data){}
            });
        }
        return templateHtml;
    };
    var _clipDialogShow = function(content, dataParams, templateHtml, containerId, closeBtnId, callback){
        if(!containerId || containerId=="" || containerId=="null") { containerId = common.globalClip.keyValue().contentContainerId; }
        if(!closeBtnId || closeBtnId=="" || closeBtnId=="null") { closeBtnId = common.globalClip.keyValue().closeBtnId; }
        var templateObj = $(templateHtml);
        var clipDialog = $("body").find("#"+$(templateObj).attr("id"));
        if(!clipDialog || clipDialog.length==0) {
            var clipCssObj = $("head").find("#clipCss");
            if(!clipCssObj || clipCssObj.length<=0) {
                var templateKey = common.globalClip.localKey();
                var cssDataStr = common.globalStorage.sessionStore(templateKey.cssKey);
                var cssDataObj = (cssDataStr && cssDataStr!="null") ? JSON.parse(cssDataStr) : null;
                if(cssDataObj) {
                    // $("head").append("<link id='clipCss' href='"+ cssDataObj.path +"?v=" + cssDataObj.version + "' rel='stylesheet' type='text/css'>");
                }
            }
            $("body").append(templateObj);
            clipDialog = $("body").find("#"+$(templateObj).attr("id"));
        }
        $("#globalDialog").find("#"+containerId).html(content);
        clipDialog.fadeIn();
        clipDialog.css("display", clipDialog.attr("display"));
        $("#globalDialog").find("#"+closeBtnId).off("click").on("click", function() {
            if(!window.isClipClose) {
                window.isClipClose = true;
                if(callback) {
                    if(dataParams) { callback(dataParams); }
                    else { callback.call(); }
                }
                _clipDialogRemove(clipDialog);
                setTimeout(function() {
                    window.isClipClose = false;
                }, 500);
            }
        });
    };
    var _clipDialogRemove = function(dialogObj){
        $(dialogObj).fadeOut();
        setTimeout(function() {
            $(dialogObj).remove();
        }, 500);
        if(common.globalClip.removeClipTimeout) { window.clearTimeout(common.globalClip.removeClipTimeout); }
    };

    // 页面跳转统一处理
    common.pageJump = function(url) {
        if(url.indexOf("http:")<0 && url.indexOf("https:")<0) {
            common.progressPanel.show();
            var url = $.global.domain() + url;
            url = _urlJoinLang(url);
        }
        if(url.indexOf("/neitui/api/neitui/api") >= 0) { url = url.replace("/neitui/api/neitui/api", "/neitui/api"); }
        window.location.href = url;
        common.progressPanel.remove();
    };

    common.jumpTargetUrl = function(targetUrl) {
        common.progressPanel.show();
        var sessionTargetUrl = common.globalStorage.sessionStore("targetUrl");
        if(!sessionTargetUrl || sessionTargetUrl=="" || sessionTargetUrl=="null") {
            sessionTargetUrl = $.global.domain() + targetUrl;
        }
        sessionTargetUrl = _urlJoinLang(sessionTargetUrl);
        if(sessionTargetUrl.indexOf("http://")<0 && sessionTargetUrl.indexOf("https://")<0) {
            sessionTargetUrl = $.global.domain() + sessionTargetUrl;
        }
        common.globalStorage.removeSessionStore("targetUrl");
        if(sessionTargetUrl.indexOf("/neitui/api/neitui/api") >= 0) { sessionTargetUrl = sessionTargetUrl.replace("/neitui/api/neitui/api", "/neitui/api"); }
        window.location.href = sessionTargetUrl;
        common.progressPanel.remove();
    };

    var _urlJoinLang = function(url){
        if(url.indexOf("lang=") < 0) {
            var curUrl = window.location.href;
            if(curUrl.indexOf("lang=") >= 0) {
                curUrl = curUrl.substring(curUrl.indexOf("lang="));
                if(curUrl.indexOf("&") >= 0) {
                    curUrl = curUrl.substring(0, curUrl.indexOf("&"));
                }
                if(curUrl=="lang=" || curUrl=="lang=null") { curUrl = "lang=zh_CN"; }
            }
            else { curUrl = "lang=zh_CN"; }
            url += (url.indexOf("?") < 0) ? "?" : "&";
            url += curUrl;
        }
        return url;
    };

    common.storeTargetUrl = function(targetUrl) {
        if(targetUrl.indexOf("http://")<0 && targetUrl.indexOf("https://")<0) { targetUrl = $.global.domain() + targetUrl; }
        common.globalStorage.sessionStore("targetUrl", targetUrl);
    };

    common.storeCurUrlToTargetUrl = function(){
        common.storeTargetUrl(window.location.href);
    };

    common.formatStr = function(targetStr) {
        if(targetStr && targetStr!="" && targetStr!="null") {
            return targetStr;
        }
        return "";
    };

    common.formatNum = function(targetNum) {
        if (targetNum == 0) {
            return common.constant.headCountNum($.tpCommon.curLang());
        }else {
            return targetNum;
        }
    };

    common.privacyNotice = function(callback) {
        $("#readPrivacyNoticeBtn").off("click").on("click", function(){
            if($("#privacyNoticeDiv").length > 0) {
                $("#privacyNoticeDiv").show();
                _privacyNoticeClose();
            }
            else {
                $.globalAjax.get({
                    url: $.global.domain() + "/clip/privacyNotice",
                    successCallback: function(data) {
                        $("body").append(data.html);
                        _privacyNoticeClose();
                    }
                });
            }
        });
        $("#privacyCheck").off("click").on("click", function(){
            if(callback) { callback(this); }
        });
    };
    var _privacyNoticeClose = function() {
        $("#privacyNoticeCloseBtn").off("click").on("click", function(){
            $("#privacyNoticeDiv").hide();
        });
    };

    common.formatDistance = function (distance) {
        if(distance >20000) { return (distance/1000).toFixed(0) + "km"; }
        else if(distance > 1000 ) {return (distance/1000).toFixed(1) + "km";}
        else {return distance + "m";}
    };
    common.checkOSType = function () {
        var u = navigator.userAgent;
        var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
        var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
        return {isAndroid: isAndroid, isiOS: isiOS};
    };
    //Location Api
    common.getLocation = function(successCallback, errorCallback) {
        var geolocation = new qq.maps.Geolocation("X6DBZ-7OPWX-YSG4M-TZMHW-JGEWF-VXBB6", "myapp");
        var options = {timeout: 500};
        var success = function (location) {
            successCallback(location);
        };
        var error = function () {
            errorCallback();
        };
        geolocation.getLocation(success, error, options);
    };
    //验证身份证
    common.IdentityCodeValid = function(code) {
        code = code.replace(/^\s*|\s*$/g, "");
        var home, sex, birthday;
        if(code.length == 18) {
            if(!/^\d{6}(18|19|20)?\d{2}(0[1-9]|1[012])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$/i.test(code)){
                // alert("18位身份证号格式错误");
                return false;
            }
            var codeArr = code.split('');
            var factor = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ];    //加权因子
            var parity = [ 1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2 ];                        //校验位
            var sum = 0;
            for (var i = 0; i < 17; i++){
                sum += codeArr[i] * factor[i];
            }
            if(parity[sum % 11] != codeArr[17]){
                // alert("校验位错误");
                return false;
            }
            sex = code.substring(14,17)%2==0 ? '女':'男';
            birthday = code.substring(6,10) + '-' + code.substring(10,12) + '-' + code.substring(12,14);
        } else if(code.length == 15) {
            if(!/^\d{6}\d{2}(0[1-9]|1[012])(0[1-9]|[12]\d|3[01])\d{3}$/i.test(code)){
                // alert("15位身份证号格式错误");
                return false;
            }
            sex = code.substring(14,15)%2==0 ? '女':'男';
            birthday = "19" + code.substring(6,8) + '-' + code.substring(8,10) + '-' + code.substring(10,12);
        } else {
            // alert("身份证号位数错误");
            return false;
        }
        var city={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江 ",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北 ",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏 ",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门"};
        if(!city[code.substring(0,2)]){
            // alert("地址编码错误");
            return false;
        }
        //省份
        home = city[code.substring(0,2)];
        return {home:home, birthday:birthday, sex:sex}
    };
    //开始时间去除时间只保留日期
    common.formatStartDate = function (startDate) {
        if(!startDate || startDate =="" || startDate =="null"){ return "";}
        if(startDate.indexOf("T") >=0){
            return startDate.split("T")[0];
        }else{
            return startDate.split(" ")[0];
        }
    };
    //格式化底层时间2018-06-17T00:00:00+0800为2018-06-17 00:00:00
    common.formatDate = function (date) {
        if(!date || date == "" || date == "null"){ return "";}
        return date.replace("T", " ").split("+")[0];
    };

    common.formNotice = {
        "init":function() {
            var _this = this;
            setTimeout(function () {
                _this.format()
            },100)
        },
        "showNotice":function(v) {
            $(v).parents(".form-item").addClass("form-show-notice");
            $(v).parents(".form-item").removeClass("form-finish-notice")
        },
        "hideNotice":function(v) {
            $(v).parents(".form-item").removeClass("form-show-notice")
            $(v).parents(".form-item").removeClass("form-finish-notice")
        },
        "finishNotice":function(v) {
            $(v).parents(".form-item").removeClass("form-show-notice");
            $(v).parents(".form-item").addClass("form-finish-notice")
        },
        "format":function() {
            var _this = this;
            $(".input-enter, .input-select-show").each(function(i,v) {
                var box = $(v).parents(".form-item");
                var notice = $(v).attr("placeholder") || $(box).find(".form-title").text().replace(/[":","："]/,"");
                $(box).addClass("form-toggle-notice");

                if(notice && notice.replace(" ","") != "undefined" && notice.length > 0){
                    notice.replace("请输入您的","")
                    if($(box).find(".form-content .float-notice").length == 0){
                        $(box).find(".form-content").eq(0).append("<span class='float-notice'>"+notice+"</span>");
                    }
                    // $(v).attr("placeholder","")
                }

                // 是否有简历内容
                if($(v).val().length > 0 || $(v).text().length > 0){
                    _this.finishNotice(v)
                }else{
                    _this.hideNotice(v)
                }

                // 获得&失去焦点时
                $(v).focus(function() {
                    _this.showNotice(v)
                });
                $(v).blur(function() {
                    if($(v).val().length > 0 || $(v).text().length > 0){
                        _this.finishNotice(v)
                    }else{
                        _this.hideNotice(v)
                    }
                })
            })
        }
    }
})(jQuery);

(function($){

    var degree = {version: 1.0};

    $.degreeSelect = degree;

    degree.select = function(value, version){
        var degreeOptions = "";
        var degrees = $.tpCommon.constant.degree_zh();
        if(version == "en") { degrees = $.tpCommon.constant.degree_en(); }
        if(version == "zh_HK") { degrees = $.tpCommon.constant.degree_zh_HK(); }
        if(version == "zh_TW") { degrees = $.tpCommon.constant.degree_zh_TW(); }
        var hasResumeDegree = (degrees.indexOf(value) < 0) ? false : true
        for(var i=0; i<degrees.length; i++) {
            degreeOptions += "<option value='" + degrees[i] + "'";
            if(hasResumeDegree) {
                if(value == degrees[i]) { degreeOptions += " selected"; }
            }
            else {
                if($.tpCommon.constant.degree_default(degrees[i], version)) { degreeOptions += "selected"; }
            }
            degreeOptions += ">" + degrees[i] + "</option>";
        }
        return degreeOptions;
    }

})(jQuery);

(function($){
    var global = {version: 1.0};

    $.global = global;

    global.domain = function(){
        var curHref = window.location.href;
        var domain = _formatScriptDomain(curHref);
        var extCatalog = $("#extCatalogSign").attr("extCatalog");
        if(curHref.indexOf(".com/neitui/api/") >= 0) { extCatalog = "neitui/api" }
        if(extCatalog && extCatalog!="" && extCatalog!="null") { domain += "/" + extCatalog; }
        // if($("#globalJsScript").attr("environment") == "development") { domain += "/WXView"; }
        return domain;
    };
    var _formatScriptDomain = function(resultUrl){
        if(resultUrl.indexOf(".com") >= 0) { return resultUrl.substring(0, resultUrl.indexOf(".com")+4); }
        else if(resultUrl.indexOf(".cn") >= 0) { return resultUrl.substring(0, resultUrl.indexOf(".cn")+3); }
        else if(resultUrl.indexOf(".net") >= 0) { return resultUrl.substring(0, resultUrl.indexOf(".net")+4); }
        else if(resultUrl.indexOf(".org") >= 0) { return resultUrl.substring(0, resultUrl.indexOf(".org")+4); }
        else if(resultUrl.indexOf(".hk") >= 0) { return resultUrl.substring(0, resultUrl.indexOf(".hk")+3); }
        else if(resultUrl.indexOf("/WXView") >= 0) { return resultUrl.substring(0, resultUrl.indexOf("/WXView")); }
        return "";
    };
})(jQuery);

(function($){
    var globalAjax = { version: 1.0 };

    $.globalAjax = globalAjax;

    var defaultDataParams = {
        url: null,                               // 请求的url地址
        data: {},                                // 请求参数
        dataType: "json",                      // 返回数据类型
        protocol: "http",                      // 请求协议，默认http（可以为https）
        async: true,                            // 请求同步或异步类型（true为异步（ajax默认值），false为同步）
        timeout: 300000,                        // 请求超时返回限制（默认100秒）
        formId: null,                          // 如果是form提交，form标签的id
        uploadFileId: null,                   // 如果是上传文件，文件控件标签的id
        uploadFileSize: 2097152,              // 默认上传文件的文件大小限制（最大值，默认2M）
        uploadImgCompress: false,            // 上传图片文件是否进行前端压缩（默认不压缩）
        bErrDataUnified: true,                // 数据错误时，是否统一处理数据
        successCallback: null,               // 请求成功的回调函数
        errorCallback: null,                  // 请求错误的回调函数
        beforeSendCallback: null,            // 请求发送前走的回调函数
        completeCallback: null,              // 请求完成后的回调函数
        uploadFileWrongCallback: null,      // 上传文件时，文件不符合标准时的回调函数，回传参数（size--大小超过上限，type--文件格式不允许）
        clipContent: null,                    // 弹窗提示语内容
        clipTemplateKey: null,               // 在本地缓存的弹窗模板html的键值
        clipContainerId: null,               // 弹窗模板中，提示语容器标签的id
        clipCloseBtnId: null,                // 弹窗模板中，关闭按钮标签的id
        clipAutoClose: true,                 // 提示弹窗是否自动关闭
        clipTime: 3,                          // 提示弹窗显示的默认时间（到达时长后，自动关闭，该值在clipAutoClose为true时有效）
        clipCallback: null,                  // 提示弹窗关闭时的回调函数
        needLoading: true,                    // 是否需要loading遮盖层
        needFileForAnalysis: "N",             // 是否需要上传简历附件后进行拆分
        isIdCard: false                          // 上传的是否是身份证
    };

    var _mergeDataParams = function(dataParams){
        var resultDataParams = {};
        for(var key in defaultDataParams) {
            if((dataParams[key] || (!dataParams[key] && (typeof(dataParams[key])=="boolean" || typeof(dataParams[key])=="number"))) && dataParams[key]!="null") {
                if(typeof(dataParams[key])=="string") { resultDataParams[key] = dataParams[key].trim(); }
                else { resultDataParams[key] = dataParams[key]; }
            }
            else { resultDataParams[key] = defaultDataParams[key]; }
        }
        return resultDataParams;
    };

    globalAjax.post = function(dataParams) { _ajaxOperate(dataParams, "post"); };
    globalAjax.get = function(dataParams) {
        dataParams.t = new Date().getTime();
        _ajaxOperate(dataParams, "get");
    };
    globalAjax.put = function(dataParams) { _ajaxOperate(dataParams, "put"); };
    globalAjax.delete = function(dataParams) { _ajaxOperate(dataParams, "delete"); };

    globalAjax.globalForm = function(dataParams){
        if(!window.ajaxForm) { window.ajaxForm = {}; }
        if(window.ajaxForm[dataParams.formId] == "yes") { return; }
        dataParams = _mergeDataParams(dataParams);
        $.tpCommon.progressPanel.show();
        var inputs = $("#" + dataParams.formId).find("input");
        for(var i=0; i<inputs.length; i++) {
            if($(inputs[i]).attr("type") != "file") {
                $(inputs[i]).val($(inputs[i]).val().trim());
            }
        }
        if(dataParams.protocol == "https") {
            $("#"+dataParams.formId).ajaxSubmit({
                type:'POST',
                timeout: dataParams.timeout,
                xhrFields: { withCredentials: true },
                crossDomain: true,
                beforeSend: function(jqXHR, settings){
                    _beforeSend(jqXHR, settings, dataParams);
                    if(window.ajaxForm[dataParams.formId] == "yes") { return false; }
                    else { window.ajaxForm[dataParams.formId] = "yes"; }
                },
                dataFilter: function(data, type){ return _dataFilter(data, type, dataParams); },
                success:function (data) { _success(data, dataParams); },
                error: function(XMLHttpRequest, textStatus, errorThrown){ _error(XMLHttpRequest, textStatus, errorThrown, dataParams); },
                complete: function(XMLHttpRequest, status){
                    _complete(XMLHttpRequest, status, dataParams);
                    window.ajaxForm[dataParams.formId] = null;
                }
            });
        }
        else {
            $("#"+dataParams.formId).ajaxSubmit({
                type:'POST',
                timeout: dataParams.timeout,
                beforeSend: function(jqXHR, settings){
                    _beforeSend(jqXHR, settings, dataParams);
                    if(window.ajaxForm[dataParams.formId] == "yes") { return false; }
                    else { window.ajaxForm[dataParams.formId] = "yes"; }
                },
                dataFilter: function(data, type){ return _dataFilter(data, type, dataParams); },
                success:function (data) { _success(data, dataParams); },
                error: function(XMLHttpRequest, textStatus, errorThrown){ _error(XMLHttpRequest, textStatus, errorThrown, dataParams); },
                complete: function(XMLHttpRequest, status){
                    _complete(XMLHttpRequest, status, dataParams);
                    window.ajaxForm[dataParams.formId] = null;
                }
            });
        }
    };

    var _ajaxOperate = function(dataParams, type){
        if(!window.ajaxList) { window.ajaxList = {}; }
        if(window.ajaxList[dataParams.url] == "yes") { return; }
        dataParams = _mergeDataParams(dataParams);
        if(dataParams.needLoading) { $.tpCommon.progressPanel.show(); }
        if(dataParams.url.indexOf("/neitui/api/neitui/api") >= 0) { dataParams.url = dataParams.url.replace("/neitui/api/neitui/api", "/neitui/api") }
        $.ajax({
            url: dataParams.url,
            data: dataParams.data,
            type: type,
            dataType: (dataParams.dataType) ? dataParams.dataType:"json",
            timeout: dataParams.timeout,
            async: dataParams.async,
            beforeSend: function(jqXHR, settings){
                _beforeSend(jqXHR, settings, dataParams);
                if(window.ajaxList[dataParams.url] == "yes") { return false; }
                else { window.ajaxList[dataParams.url] = "yes"; }
            },
            dataFilter: function(data, type){ return _dataFilter(data, type, dataParams); },
            success: function(data) { _success(data, dataParams); },
            error: function(XMLHttpRequest, textStatus, errorThrown){ _error(XMLHttpRequest, textStatus, errorThrown, dataParams); },
            complete: function(XMLHttpRequest, status){
                _complete(XMLHttpRequest, status, dataParams);
                window.ajaxList[dataParams.url] = null;
            }
        });
    };

    var _imgCompress = function(file, callback) {
        var reader = new FileReader, img = new Image();
        reader.onload = function(e) {
            img.src = e.target.result;
        };
        var canvas = document.createElement("canvas");
        var context = canvas.getContext("2d");
        img.onload = function() {
            var width = this.width;
            var height = this.height;
            var maxWidth = 768, maxHeight = 1024;
            if(width > height) {
                var tempWidth = maxWidth;
                maxWidth = maxHeight;
                maxHeight = tempWidth;
            }
            var targetWidth = width, targetHeight = height;
            if(width>maxWidth || height>maxHeight) {
                if(width/height > maxWidth/maxHeight) {
                    targetWidth = maxWidth;
                    targetHeight = Math.round(maxWidth * (height / width));
                }
                else {
                    targetHeight = maxHeight;
                    targetWidth = Math.round(maxHeight * (width / height));
                }
            }
            if(targetWidth > targetHeight) {
                canvas.width = targetHeight;
                canvas.height = targetWidth;
                var xo = canvas.width/2;
                var ho = canvas.height/2;
                context.clearRect(0, 0, canvas.width, canvas.height);
                context.translate(xo, ho);
                context.rotate(90*Math.PI/180);
                context.translate(-xo, -ho);
                context.drawImage(img, -(targetWidth-targetHeight)/2, (targetWidth-targetHeight)/2, targetWidth, targetHeight);
            }
            else {
                canvas.width = targetWidth;
                canvas.height = targetHeight;
                context.clearRect(0, 0, targetWidth, targetHeight);
                context.drawImage(img, 0, 0, targetWidth, targetHeight);
            }
            canvas.toBlob(function(blob){
                callback(blob);
            });
        };
        reader.readAsDataURL(file);
    };

    globalAjax.uploadFile = function(dataParams, type) {
        dataParams = _mergeDataParams(dataParams);
        var fileObj = document.querySelector("#" + dataParams.uploadFileId).files[0];
        var fileName = fileObj.name;
        if(fileName.indexOf("%")>=0 || fileName.indexOf(";")>=0 || fileName.indexOf("#")>=0) {
            if(!dataParams.uploadFileWrongCallback) { $.tpCommon.globalClip.showTime("文件名称不可包含特殊符号：'%'、';'、'#'等", function(){}); }
            else { dataParams.uploadFileWrongCallback("name"); }
            return;
        }
        var fileSuffixName = fileName.substring(fileName.lastIndexOf(".")+1);
        var suffixes = ["doc", "docx", "ppt", "pptx", "xls", "xlsx", "wps", "dps", "et", "pdf", "jpg", "jpeg", "png", "bmp", "gif", "html", "htm", "txt"];
        if($.inArray(fileSuffixName.toLowerCase(), suffixes) < 0) {
            if(!dataParams.uploadFileWrongCallback) { $.tpCommon.globalClip.showTime("不允许上传该格式文件", function(){}); }
            else { dataParams.uploadFileWrongCallback("type"); }
            return;
        }
        if(dataParams.uploadImgCompress && fileObj.type.indexOf("image")==0 && fileObj.size>1363148) {
            if(dataParams.needLoading) { $.tpCommon.progressPanel.show(); }
            _imgCompress(fileObj, function(comBlob){
                _uploadFile(dataParams, comBlob, fileName);
            });
        }
        else {
            if(fileObj.size > dataParams.uploadFileSize) {
                if(!dataParams.uploadFileWrongCallback) { $.tpCommon.globalClip.showTime("文件大小超过2M", function(){}); }
                else { dataParams.uploadFileWrongCallback("size"); }
                return;
            }
            _uploadFile(dataParams);
        }
    };

    var _uploadFile = function(dataParams, blob, fileName){
        if(dataParams.needLoading) { $.tpCommon.progressPanel.show(); }
        var formData = new FormData();
        if(blob) {
            formData.append("file", blob, (fileName) ? fileName : "image.jpg");
        }
        else {
            formData.append("file", document.querySelector("#" + dataParams.uploadFileId).files[0]);
        }
        formData.append("needFileForAnalysis", dataParams.needFileForAnalysis ? dataParams.needFileForAnalysis : "N");
        formData.append("isIdCard", dataParams.isIdCard ?  "Y" : "N");
        $.ajax({
            url: dataParams.url,
            type: "post",
            data: formData,
            dataType: (dataParams.dataType) ? dataParams.dataType:"json",
            cache: false,
            contentType: false,
            processData: false,
            beforeSend: function(jqXHR, settings) { _beforeSend(jqXHR, settings, dataParams); },
            dataFilter: function(data, type) { return _dataFilter(data, type, dataParams); },
            success: function(data) { _success(data, dataParams); },
            error: function(XMLHttpRequest, textStatus, errorThrown){
                if(XMLHttpRequest.status == 200) { _success(eval("(" + XMLHttpRequest.responseText + ")"), dataParams); }
                else { _error(XMLHttpRequest, textStatus, errorThrown, dataParams); }
            },
            complete: function(XMLHttpRequest, status){ _complete(XMLHttpRequest, status, dataParams); }
        });
    };

    var _beforeSend = function(jqXHR, settings, dataParams){
        if(dataParams.beforeSendCallback) { dataParams.beforeSendCallback(jqXHR, settings); }
    };
    var _dataFilter = function(data, type, dataParams){
        return data;
    };
    var _success = function(data, dataParams){
        if(dataParams.dataType == "json") {
            if(!dataParams.bErrDataUnified || !data.code || data.code=="null") {
                if(dataParams.successCallback) { dataParams.successCallback(data); }
            }
            else if(data.code == "0") {
                if(dataParams.successCallback) { dataParams.successCallback(data.result); }
            }
            else {
                var word = (dataParams.clipContent && dataParams.clipContent!="null") ? dataParams.clipContent : data.message;
                if(dataParams.clipAutoClose) { $.tpCommon.globalClip.showTime(word, data.clipCallback, dataParams.clipTime, dataParams.clipContainerId, dataParams.clipCloseBtnId, dataParams.clipTemplateKey); }
                else { $.tpCommon.globalClip.show(word, dataParams.clipCallback, dataParams.clipContainerId, dataParams.clipCloseBtnId, dataParams.clipTemplateKey); }
            }
        }
        else {
            if(dataParams.successCallback) { dataParams.successCallback(data); }
        }
        if(dataParams.needLoading) { $.tpCommon.progressPanel.remove(); }
    };
    var _error = function(XMLHttpRequest, textStatus, errorThrown, dataParams){
        if(dataParams.errorCallback) {
            dataParams.errorCallback(XMLHttpRequest, textStatus, errorThrown);
            return;
        }
        // status为错误码，如502等
        var status = XMLHttpRequest.status;
        if(dataParams.needLoading) { $.tpCommon.progressPanel.remove(); }
        if(status != 200) {
            var clipWord = {zh_CN: "系统繁忙，请稍后重试！", en: "System is busy now, please try again later!"};
            if(status == 403) {
                clipWord = {zh_CN: "您的请求过于频繁，请稍后重试！", en: "Operation too frequent, please try again later."};
                $.tpCommon.globalClip.showTime(clipWord[$.tpCommon.curLang()], function(){});
            }
        }
    };
    var _complete = function(XMLHttpRequest, status, dataParams){
        if(dataParams.completeCallback) { dataParams.completeCallback(XMLHttpRequest, status); }
        if(dataParams.needLoading) { $.tpCommon.progressPanel.remove(); }
    };
})(jQuery);