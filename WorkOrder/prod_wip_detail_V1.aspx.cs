using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class prod_wip_detail_V1 : System.Web.UI.Page
{
    public string _workshop = "";
    public string _emp = "";//当前登入
    public string _para = "";

    public DataTable dt_m;
    public DataTable dt_dtl;

    protected void Page_Load(object sender, EventArgs e)
    {
        _workshop = Request.QueryString["workshop"].ToString();
        _para = Request.QueryString["para"].ToString();

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
        _emp = lu.WorkCode + lu.UserName;
        //_emp = "02432何桂勤";

        GetData();
       
    }

    private void GetData()
    {
         
        string type = Request["type"].ToString();
        string dh = Request["dh"].ToString();
        string need_no= Request["need_no"].ToString();
        string sql = string.Format(@"exec [usp_app_prod_wip_detail_V1] '{0}'", dh);
        DataSet ds  = SQLHelper.Query(sql);

        dtMain.DataSource = ds.Tables[0];
        dtMain.DataBind();

        dt_m = ds.Tables[1];
        dt_dtl = ds.Tables[2]; 
    }

    [WebMethod]
    public static string Reject_Sku(string emp, string needno, string lotno, string reject_qty, string source, string reject_where)
    {
        string result = "";

        string re_sql = @"exec [usp_app_Reject] '{0}','{1}','{2}',{3},'{4}','{5}'";
        re_sql = string.Format(re_sql, emp, needno, lotno, Convert.ToSingle(reject_qty == "" ? "0" : reject_qty), source, reject_where);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }
}