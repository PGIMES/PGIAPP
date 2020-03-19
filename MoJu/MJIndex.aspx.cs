using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MJIndex : PageMain
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //WeiXin.delCookies("userid");
        //WeiXin.delCookies("workcode");
        //WeiXin.delCookies("usermodel");
    }

    //[WebMethod]
    //public static string init()
    //{

    //    //string sql = @"select count(1) app_ng from Mes_App_WorkOrder_Ng where status<>1";
    //    //DataTable re_dt = SQLHelper.Query(sql).Tables[0];
    //    //string appp_ng = re_dt.Rows[0]["app_ng"].ToString();

    //    //string result = "[{\"appp_ng\":\"" + appp_ng + "\"}]";
    //    //return result;

    //}

}