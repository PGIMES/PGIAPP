using LitJson;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// PageMain 的摘要说明
/// </summary>
public class PageMain : System.Web.UI.Page
{
    
    protected override void OnInit(EventArgs e)
    {


        String code = Request.QueryString["code"];
        JsonData userInfo = WeiXin.GetUserInfo(code);
        // Response.Write(userInfo.ToJson());
        string userid = userInfo.ContainsKey("UserId") ? userInfo["UserId"].ToString() : ""; //账号

        //string userid = "YuDuoKui";

        string sql = "select * from WX_User where wxuserid='{0}'";
        sql = string.Format(sql, userid);
        System.Data.DataTable dt = SQLHelper.reDs(sql).Tables[0];
         
        if (dt.Rows.Count == 0)         
        {
            //更新或插入微信id
            JsonData userDetail = WeiXin.GetUserDetail(userid);
            string workcode = userDetail.ContainsKey("alias") ? userDetail["alias"].ToString() : ""; //别名 对应工号
            string name = userDetail.ContainsKey("name") ? userDetail["name"].ToString() : ""; //姓名            
            sql = "insert into [dbo].[WX_User]([workcode],[wxuserid])values('{0}','{1}')";
            sql = string.Format(sql, workcode, userid);
            SQLHelper.ExSql(sql);
        }
        LoginUser userModel = InitUser.GetLoginUserInfo("", userid);
        Session["userModel"] = userModel;

    }
}