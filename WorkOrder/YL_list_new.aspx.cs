using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_YL_list_new : System.Web.UI.Page
{
    public string _workshop = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        _workshop = Request.QueryString["workshop"].ToString();

        //if (WeiXin.GetCookie("workcode") == null)
        //{
        //    Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
        //    return;
        //}


        GetData("02432");
       
    }

    private void GetData(string emp)
    {
        DataTable dt_go = new DataTable();
        DataTable dt_wc = new DataTable();
        DataTable dt_go_my = new DataTable();
        DataTable dt_wc_my = new DataTable();

        string sql = @"exec [usp_app_YL_list_new] '{0}','{1}'";
        sql = string.Format(sql, _workshop, emp);
        dt_go = SQLHelper.Query(sql).Tables[0];
        dt_wc = SQLHelper.Query(sql).Tables[1];
        dt_go_my = SQLHelper.Query(sql).Tables[2];
        dt_wc_my = SQLHelper.Query(sql).Tables[3];

        list_go.DataSource = dt_go;
        list_go.DataBind();

        list_wc.DataSource = dt_wc;
        list_wc.DataBind();

        list_go_my.DataSource = dt_go_my;
        list_go_my.DataBind();

        list_wc_my.DataSource = dt_wc_my;
        list_wc_my.DataBind();

    }
}