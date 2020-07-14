using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Adjust_list : System.Web.UI.Page
{
    public int count_01, count_02, count_03, count_99;
    public int count_01_my, count_02_my, count_03_my, count_99_my;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
        GetData(lu.WorkCode);
    }

    private void GetData(string emp)
    {
        string sql = @"exec [usp_app_Adjust_Apply_list_dv] '{0}'";
        sql = string.Format(sql, emp);
        DataSet ds = SQLHelper.Query(sql);

        DataTable dt_01 = ds.Tables[0]; DataTable dt_02 = ds.Tables[1]; DataTable dt_03 = ds.Tables[2];
        DataTable dt_99 = ds.Tables[3];

        DataTable dt_01_my = ds.Tables[4]; DataTable dt_02_my = ds.Tables[5]; DataTable dt_03_my = ds.Tables[6];
        DataTable dt_99_my = ds.Tables[7];

        list_01.DataSource = dt_01; list_01.DataBind(); count_01 = dt_01.Rows.Count;
        list_02.DataSource = dt_02; list_02.DataBind(); count_02 = dt_02.Rows.Count;
        list_03.DataSource = dt_03; list_03.DataBind(); count_03 = dt_03.Rows.Count;
        list_99.DataSource = dt_99; list_99.DataBind(); count_99 = dt_99.Rows.Count;

        list_01_my.DataSource = dt_01_my; list_01_my.DataBind(); count_01_my = dt_01_my.Rows.Count;
        list_02_my.DataSource = dt_02_my; list_02_my.DataBind(); count_02_my = dt_02_my.Rows.Count;
        list_03_my.DataSource = dt_03_my; list_03_my.DataBind(); count_03_my = dt_03_my.Rows.Count;
        list_99_my.DataSource = dt_99_my; list_99_my.DataBind(); count_99_my = dt_99_my.Rows.Count;

    }
}