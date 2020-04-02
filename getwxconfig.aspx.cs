using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Text;
using System.Configuration;
using System.Web.Services;

public partial class getwxconfig : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //string result = "";
        //string jsapi = Request.QueryString["jsapi"];
        //if (jsapi.ToLower() == "scanQRCode".ToLower())
        //{
        //    string uri = Request.QueryString["uri"];
        //    result = GetScanQRCode(uri);
        //}
    }

    //GET api/GetInfoMation
    /// <summary>
    ///初始化的数据调用微信接口返回参数
    /// </summary>
    /// <returns></returns>
    [WebMethod]
    public static string GetScanQRCode(string url)
    {
        try
        {
            url = url.Replace(":63780", "").Replace(":8010", "");
            //生成tokcen
            string tocken = WeiXin.GetEntAccessToken();
            //JObject TokenJO = (JObject)JsonConvert.DeserializeObject(tocken);
            //验证签名
            //string Jsapi_Ticket = WeiXin.GetEntJsapi_Ticket(tocken);//TokenJO["access_token"].ToString()
            //JObject Jsapi_TicketJo = (JObject)JsonConvert.DeserializeObject(Jsapi_Ticket);
            #region
            string rtn = "";
            string jsapi_ticket = WeiXin.GetEntJsapi_Ticket(tocken); ;//Jsapi_TicketJo["ticket"].ToString();
            string noncestr = CreatenNonce_str();
            long timestamp = CreatenTimestamp();
            string outstring = "";
            string JS_SDK_Result = WeiXin.GetSignature(jsapi_ticket, noncestr, timestamp.ToString(), url);
            //拼接json串返回前台
            rtn = "{\"appid\":\"" + ConfigurationManager.AppSettings["wxqy_CorpID"] + "\",\"jsapi_ticket\":\"" + jsapi_ticket + "\",\"noncestr\":\"" + noncestr + "\",\"timestamp\":\"" + timestamp + "\",\"outstring\":\"" + outstring + "\",\"signature\":\"" + JS_SDK_Result.ToLower() + "\"}";
            #endregion
            return rtn;
        }
        catch (Exception ex)
        {
            return string.Empty;
        }
    }
    #region 基础字符
    private static string[] strs = new string[]
                           {
                                  "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
                                  "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"
                           };
    #endregion
    #region 创建随机字符串
    private static string CreatenNonce_str()
    {
        Random r = new Random();
        var sb = new StringBuilder();
        var length = strs.Length;
        for (int i = 0; i < 15; i++)
        {
            sb.Append(strs[r.Next(length - 1)]);
        }
        return sb.ToString();
    }
    #endregion
    #region  创建时间戳
    private static long CreatenTimestamp()
    {
        return (DateTime.Now.ToUniversalTime().Ticks - 621355968000000000) / 10000000;
    }
    #endregion
}