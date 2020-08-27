using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_Emp_Login_list_zl : System.Web.UI.Page
{
    public string _workshop = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        _workshop = Request.QueryString["workshop"].ToString();

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
        GetData(lu.WorkCode);
        //GetData("02432");
    }

    private void GetData(string emp)
    {
        DataTable dt_wk = new DataTable();
        DataTable dt_my_1 = new DataTable();
        DataTable dt_my_2 = new DataTable();
        DataTable dt_my_3 = new DataTable();

        string sql = @"exec [usp_app_emp_login_list] '{0}','{1}'";
        sql = string.Format(sql, _workshop, emp);
        DataSet ds = SQLHelper.Query(sql);

        dt_wk = ds.Tables[0];
        dt_my_1 = ds.Tables[1];
        dt_my_2 = ds.Tables[2];
        dt_my_3 = ds.Tables[3];

        list_go.DataSource = dt_wk;
        list_go.DataBind();

        list_go_my.DataSource = dt_my_1;
        list_go_my.DataBind();

        list_wc_my.DataSource = dt_my_2;
        list_wc_my.DataBind();

        list_wc_last_my.DataSource = dt_my_3;
        list_wc_last_my.DataBind();

    }

    protected void list_go_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("re_go");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = new DataTable();
            string sql = @"exec [usp_app_emp_login_list_dv] '{0}','{1}'";
            sql = string.Format(sql, _workshop, item["line"].ToString());
            dt_wk = SQLHelper.Query(sql).Tables[0];

            detail.DataSource = dt_wk;
            detail.DataBind();

        }
    }
}