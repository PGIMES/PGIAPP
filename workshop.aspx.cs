using LitJson;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class workshop : PageMain
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //WeiXin.delCookies("userid");
        //WeiXin.delCookies("workcode");
        //WeiXin.delCookies("usermodel");
        //Response.Write("cookie:" + WeiXin.GetCookie("workcode"));

    }

    [WebMethod]
    public static string TraceByDH(string dh)
    {

        string sql = @"MES_APP_TraceByCode '{0}'";
        DataTable re_dt = SQLHelper.Query(string.Format(sql,dh)).Tables[0];
        string result = "[{\"tab\":\"\",\"href\":\"\"}]";
        if (re_dt.Rows.Count > 0)
        {
            string _tab = re_dt.Rows[0]["tab"].ToString();
            string _href = re_dt.Rows[0]["href"].ToString();
            result = "[{\"tab\":\"" + _tab + "\",\"href\":\""+_href+"\"}]";
        }         
        return result;

    }
}