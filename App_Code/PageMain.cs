using LitJson;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;

using System.Web;

/// <summary>
/// PageMain 的摘要说明
/// </summary>
public class PageMain : System.Web.UI.Page
{
    
    protected override void OnInit(EventArgs e)
    {
        if (System.Configuration.ConfigurationManager.AppSettings["resetcookie"] == "true")
        {
            ResetCookie();
            
        }

        if (Request.Cookies["workcode"] == null)
        {
            
            String code = Request.QueryString["code"];
           // Response.Write(code);

           // string accesstoken = WeiXin.GetAccessToken(WeiXin.OrganizeSecret);
           // Response.Write(accesstoken);


           JsonData userInfo = WeiXin.GetUserInfo(code); //userInfo["errcode"].ToString()
            if (userInfo["errcode"].ToString() != "0")
            { 
                Response.Write("<div class='bg-red tcenter'>获取登入信息失败</div>");
                ClientScript.RegisterStartupScript(this.GetType(),"err","$(\"#errmsg\").text('" + userInfo.ToJson()+"');",true);
            }
             
            string userid = "";
            if(ConfigurationManager.AppSettings["debugmode"].ToString().ToLower()=="false")
            {
                userid = userInfo.ContainsKey("UserId") ? userInfo["UserId"].ToString() : ""; //账号
            }
            else
            {
                userid = ConfigurationManager.AppSettings["debuguserid"].ToString();  
            }
            // Response.Write("userid"+userid);
             

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
            WeiXin.SetCookie("userid", userid, 30);
            if (userModel == null)
            { 
                if(userid != "")
                {
                    Response.Redirect("/RegInfo.aspx?code=1");//完善信息
                    return;
                }
                else
                {
                    Response.Redirect("/RegInfo.aspx?code=0");//临时cookies
                    return;
                }
            }
            else
            {
                string jdUserMode = Newtonsoft.Json.JsonConvert.SerializeObject(userModel);
                Response.Write(jdUserMode);

                WeiXin.SetCookie("workcode", userModel.WorkCode,30);
                WeiXin.SetCookie("userid", userid, 30);
                WeiXin.SetCookie("usermodel", HttpUtility.UrlEncode(jdUserMode, System.Text.Encoding.GetEncoding("UTF-8")), 30);
                
            }

             
            /**/
        }


    }

    protected void ResetCookie()
    {

        if(WeiXin.GetCookie("cookiedate")!="")
        {
            var date = Convert.ToDateTime(WeiXin.GetCookie("cookiedate"));
            if (date.AddDays(1) < DateTime.Now)
            {
                WeiXin.delCookies("userid");
                WeiXin.delCookies("workcode");
                WeiXin.delCookies("usermodel");                
            }
        }
        
    }
}