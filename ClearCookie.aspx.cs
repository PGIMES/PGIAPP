using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ClearCookie : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        WeiXin.delCookies("userid");
        WeiXin.delCookies("workcode");
        WeiXin.delCookies("usermodel");

        Response.Write("ok");
    }
}