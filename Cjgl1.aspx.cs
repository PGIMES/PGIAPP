using LitJson;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Cjgl1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        String code = Request.QueryString["code"];
        //Response.Write(code);
        JsonData userInfo = WeiXin.GetUserInfo(code);
       // Response.Write(userInfo.ToJson());
        string userid = userInfo.ContainsKey("UserId") ? userInfo["UserId"].ToString() : "";
        JsonData userDetail = WeiXin.GetUserDetail(userid);
        string workcode = userDetail.ContainsKey("alias") ? userDetail["alias"].ToString() : "";
        string name = userDetail.ContainsKey("name") ? userDetail["name"].ToString() : "";
        Session["userid"] = userid;
        Session["workcode"] = workcode;
        Session["name"] = name;
        // Response.Write(name);
    }
}