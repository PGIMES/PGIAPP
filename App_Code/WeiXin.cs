using LitJson;
using Newtonsoft.Json.Linq;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Caching;

public partial  class WeiXin
{

    /// <summary>
    /// 获取user信息  UserId  user_ticket  jsondata.ContainsKey("user_ticket")
    /// </summary>
    /// <param name="code"></param>
    /// <returns>jsondata["UserId"],jsondata.ContainsKey("user_ticket")</returns>
    public static JsonData GetUserInfo(string code)
    {
        string access_token = GetEntAccessToken();
        string url = "https://qyapi.weixin.qq.com/cgi-bin/user/getuserinfo?access_token=" + access_token + "&code=" + code;
        string returnString = Utility.HttpHelper.SendGet(url);
        LitJson.JsonData jd = LitJson.JsonMapper.ToObject(returnString);
        string account = jd.ContainsKey("UserId") ? jd["UserId"].ToString() : "";
        string user_ticket = jd.ContainsKey("user_ticket") ? jd["user_ticket"].ToString() : "";
        return jd;
    }

    public static JsonData GetUserDetail(string userid)
    {
        string access_token = GetEntAccessToken();
        string url = "https://qyapi.weixin.qq.com/cgi-bin/user/get?access_token=" + access_token + "&userid=" + userid;
        string returnString = Utility.HttpHelper.SendGet(url);
        LitJson.JsonData jd = LitJson.JsonMapper.ToObject(returnString);
        return jd;
    }

    /// <summary>
    /// 是否使用微信
    /// </summary>
    public static bool IsUse
    {
        get
        {
            return "1" == ConfigurationManager.AppSettings["wxqy_IsUse"];
        }
    }
    /// <summary>
    /// 微信企业ID
    /// </summary>
    public static string CorpID
    {
        get
        {
            return ConfigurationManager.AppSettings["wxqy_CorpID"];
        }
    }
    /// <summary>
    /// 微信secret
    /// </summary>
    public static string OrganizeSecret
    {
        get
        {
            return ConfigurationManager.AppSettings["wxqy_Secret"];
        }
    }
    /// <summary>
    /// 网站外网地址
    /// </summary>
    public static string WebUrl
    {
        get
        {
            string url = ConfigurationManager.AppSettings["WebUrl"];
            return url.EndsWith("/") ? url : url + "/";
        }
    }
    /// <summary>
    /// Port
    /// </summary>
    public static string Port
    {
        get
        {
            return ConfigurationManager.AppSettings["Port"];
        }
    }
    /// <summary>
    /// 获取企业的AccessToken
    /// </summary>
    /// <returns></returns>
    public static string GetEntAccessToken()
    {

        //取数据库存储过程的AccessToken
        //DataTable dt1 = SQLHelper.reDs("select * from [mes].[dbo].[WXAccount] where 1=1").Tables[0];
        //string s1_AccessToken = dt1.Rows[0]["AccessToken"].ToString().Trim();//企业的AccessToken
        //return s1_AccessToken;
        string access_token = "";

        if( CacheHelper.GetCache("access_token") == null)
        {
            string url = string.Format("https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid={0}&corpsecret={1}", CorpID, OrganizeSecret);
            string token = Utility.HttpHelper.SendGet(url);//token:{"access_token":"f3E6RsDRp1cj74QOgsVtqZN8IkmSD4zaNVkapLqKUQYQQZUmgCE1Czkv3dkqy4CHkn_tX3gBdfSO7OsZ7URQEFt1IxPWK4TCAalshzQTMxDyEr0O4RNRu8olQrSpGA6V4IPmv9ZVoHFBVjFcjuPUKC4hmtPZWoRn_FRwLks6HS2D61JCRGgeq9xAKtmpq8rB6p4jtYrbvOuCPKT_gC36qA","expires_in":7200}
            LitJson.JsonData jd = LitJson.JsonMapper.ToObject(token);


            if (jd.ContainsKey("access_token"))
            {
                //Response.Write("access_token：、、、、、、" + jd["access_token"].ToString());
                access_token = jd["access_token"].ToString();
                CacheHelper.SetCache("access_token", access_token, DateTime.Now.AddMinutes(60), Cache.NoSlidingExpiration);
            }
            Common.LogHelper.Write("get access_token from " + url+" access_token:"+ access_token);
        }
        else
        {
            access_token = CacheHelper.GetCache("access_token").ToString() ;
            Common.LogHelper.Write("use access_token cached ");
        }
        

        return access_token;
    }
    /// <summary>
    /// 获取每次操作微信API的Token访问令牌
    /// </summary>
    /// <param name="secret">管理组的凭证密钥</param>
    /// <returns></returns>
    public static string GetAccessToken(string secret)
    {
        if (string.IsNullOrWhiteSpace(secret) || string.IsNullOrEmpty(secret))
        {
            secret = WeiXin.OrganizeSecret;
        }
        if (string.IsNullOrWhiteSpace(secret) || string.IsNullOrEmpty(secret))
        {
            return "";
        }
        string url = string.Format("https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid={0}&corpsecret={1}", CorpID, secret);
        string token = Utility.HttpHelper.SendGet(url);//token:{"access_token":"7p-2wZwAYnGwE80-VXubyqXNS9YZxIbmcHscjdfB78FA1zNPRKOGftJQdHAR8447","expires_in":7200}
        LitJson.JsonData jd = LitJson.JsonMapper.ToObject(token);
        if (jd.ContainsKey("access_token"))
        {
            return jd["access_token"].ToString();
        }
        else
        {
            return "";
        }
    }
    /// <summary>
    /// 设置cookies
    /// </summary>
    /// <param name="name"></param>
    /// <param name="value"></param>
    /// <param name="time"></param>
    public static void SetCookie(string name, string value, int time)
    {
        HttpCookie cookies = new HttpCookie(name);
        cookies.Name = name;
        cookies.Value = value;
        cookies.Expires = DateTime.Now.AddDays(time);
        HttpContext.Current.Response.Cookies.Add(cookies);

    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="name">具体cookie名称 如: workcode</param>
    /// <param name="cookiename">cookie序列名称，默认user</param>
    /// <returns></returns>
    public static string GetCookie( string name)
    {
        HttpCookie cookie = HttpContext.Current.Request.Cookies[name];
        
        if (cookie != null )
        {
            return cookie.Value;
        }
        else {
            return "";
        };
    }
    /// <summary>
    /// 获取存放在cookie中的LoginUser对象
    /// </summary>
    /// <param name="cookiename"></param>
    /// <returns></returns>
    public static LoginUser GetJsonCookie(string cookiename="usermodel")
    {
        HttpCookie cookie = HttpContext.Current.Request.Cookies[cookiename];       
        if (cookie != null )
        {
            string ck = HttpUtility.UrlDecode(cookie.Value,System.Text.Encoding.GetEncoding("UTF-8"));
            
            LoginUser userMode = Newtonsoft.Json.JsonConvert.DeserializeObject<LoginUser>(ck);
             
            return userMode ;
        }
        else {
            return null;
        };
    }
    /// <summary>
    /// 删除cookies
    /// </summary>
    /// <param name="name"></param>
    public static void delCookies(string name)
    {
        foreach (string cookiename in HttpContext.Current.Request.Cookies.AllKeys)
        {
            HttpCookie cookies = HttpContext.Current.Request.Cookies[name];
            if (cookies != null)
            {
                cookies.Expires = DateTime.Today.AddDays(-1);
                HttpContext.Current.Response.Cookies.Add(cookies);
                HttpContext.Current.Request.Cookies.Remove(name);
            }
        }
    }
    /// <summary>
    /// 根据CODE得到用户帐号地址
    /// </summary>
    //public static string GetAccountUrl
    //{
    //    get
    //    {
    //        string url = System.Web.HttpContext.Current.Request.Url.AbsolutePath;
    //        if (url.ToLower().Contains(".aspx"))
    //        {
    //            return (Config.WebUrl + "Applications/WeiXin/GetUserAccount.ashx").UrlEncode();
    //        }
    //        else
    //        {
    //            return (Config.WebUrl + "WeiXin/Common/GetUserAccount").UrlEncode();
    //        }
    //    }
    //}

    /// <summary>
    /// 获取企业Jsapi_Ticket
    /// </summary>
    /// <returns></returns>
    public static string GetEntJsapi_Ticket(string entAccessToken)
    {
        string type = "jsapi";
        //actoken 3l8h6pDV4NU9XIDUmCE1pvSsYS7HIjRxKChnW-AF6mSrQ1C1FXn9pQBeUwcpfdti671TsoMMs38OL8dKryjiZ7KhOcE3prOY8SEM8sdjb8j4Rqjl9Lms5K91J27oYuaUIQ6UqUx-oEhVK-rLoQfp00NevsZOhZnxaaS6pK6NZuV9Z4qK1mlJ2UoX2_u7CQmDsxR5k7MwodUglB1ZI9PqTQ

        string ticket = "";

        if (CacheHelper.GetCache("jsapi_ticket") == null)
        {
            string tokenUrl = string.Format("https://qyapi.weixin.qq.com/cgi-bin/get_jsapi_ticket?access_token={0}", entAccessToken);
            
            var wc = new WebClient();
            var strReturn = wc.DownloadString(tokenUrl); //取得微信返回的json数据
            JObject obj = JObject.Parse(strReturn);
            ticket = obj.SelectToken("ticket").ToString();      //obj["strReturn"]["ticket"].ToString();

             
            CacheHelper.SetCache("jsapi_ticket", ticket, DateTime.Now.AddMinutes(60), Cache.NoSlidingExpiration);
            
            Common.LogHelper.Write("get jsapi_ticket from " + tokenUrl + " jsapi_ticket:" + ticket);
        }
        else
        {
            ticket = CacheHelper.GetCache("jsapi_ticket").ToString();
            Common.LogHelper.Write("use jsapi_ticket cached: "+ ticket);
        }

        return ticket;
    }

    /// <summary>
    /// 获取应用Jsapi_Ticket
    /// </summary>
    /// <returns></returns>
    public static string GetAppJsapi_Ticket(string appAccessToken)
    {
        string type = "jsapi";
        string tokenUrl = string.Format("https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token={0}&type={1}", appAccessToken, type);
        var wc = new WebClient();
        var strReturn = wc.DownloadString(tokenUrl); //取得微信返回的json数据
        JObject obj = JObject.Parse(strReturn);
        string ticket = obj.SelectToken("ticket").ToString();      //obj["strReturn"]["ticket"].ToString();
        return ticket;
    }

    /// <summary>
    /// 获取JS-SDK权限验证的签名Signature
    /// </summary>
    /// <param name="ticket"></param>
    /// <param name="noncestr"></param>
    /// <param name="timestamp"></param>
    /// <param name="url"></param>
    /// <returns>CreateSha1(parameters)</returns>
    public static string GetSignature(string ticket, string noncestr, string timestamp, string url)
    {
        var parameters = new Hashtable();
        parameters.Add("jsapi_ticket", ticket);
        parameters.Add("noncestr", noncestr);
        parameters.Add("timestamp", timestamp);
        parameters.Add("url", url);
        return CreateSha1(parameters);
    }

    /// <summary>
    /// sha1加密
    /// </summary>
    /// <returns>GetSha1(sb.ToString()).ToLower()</returns>
    private static string CreateSha1(Hashtable parameters)
    {
        var sb = new StringBuilder();
        var akeys = new ArrayList(parameters.Keys);
        akeys.Sort();

        foreach (var k in akeys)
        {
            if (parameters[k] != null)
            {
                var v = (string)parameters[k];

                if (sb.Length == 0)
                {
                    sb.Append(k + "=" + v);
                }
                else
                {
                    sb.Append("&" + k + "=" + v);
                }
            }
        }
        return GetSha1(sb.ToString()).ToLower();
    }
    /// <summary>
    /// 签名算法
    /// </summary>
    /// <param name="str"></param>
    /// <returns>hash</returns>
    public static string GetSha1(string str)
    {
        //建立SHA1对象
        SHA1 sha = new SHA1CryptoServiceProvider();
        //将mystr转换成byte[]
        ASCIIEncoding enc = new ASCIIEncoding();
        byte[] dataToHash = enc.GetBytes(str);
        //Hash运算
        byte[] dataHashed = sha.ComputeHash(dataToHash);
        //将运算结果转换成string
        string hash = BitConverter.ToString(dataHashed).Replace("-", "");
        return hash;
    }

    //private static DateTime GetJsapi_ticket_Time;
    ///// <summary>
    ///// 过期时间为7200秒
    ///// </summary>
    //private static int Jsapi_ticket_Expires_Period = 7200;
    ///// <summary>
    ///// 
    ///// </summary>
    //private static string mJsapi_ticket;
    ///// <summary>
    ///// 判断 是否过期
    ///// </summary>
    ///// <returns>bool</returns>
    //private static bool Jsapi_ticket_HasExpired()
    //{
    //    if (GetJsapi_ticket_Time != null)
    //    {
    //        //过期时间，允许有一定的误差，一分钟。获取时间消耗
    //        if (DateTime.Now > GetJsapi_ticket_Time.AddSeconds(Jsapi_ticket_Expires_Period).AddSeconds(-60))
    //        {
    //            return true;
    //        }
    //    }
    //    return false;
    //}
    ///// <summary>
    ///// 调用获取Jsapi_ticket,包含判断是否过期
    ///// </summary>
    //public static string Jsapi_ticket
    //{
    //    get
    //    {
    //        //如果为空，或者过期，需要重新获取
    //        if (string.IsNullOrEmpty(mJsapi_ticket) || Jsapi_ticket_HasExpired())
    //        {
    //            //获取access_token
    //            mJsapi_ticket = GetJsapi_ticket(AppID, AppSecret);
    //        }

    //        return mJsapi_ticket;
    //    }
    //}


}



