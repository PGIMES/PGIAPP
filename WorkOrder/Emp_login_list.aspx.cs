using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_Emp_Login_list : System.Web.UI.Page
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
        dt_wk = SQLHelper.Query(sql).Tables[0];
        dt_my_1 = SQLHelper.Query(sql).Tables[1];
        dt_my_2 = SQLHelper.Query(sql).Tables[2];
        dt_my_3 = SQLHelper.Query(sql).Tables[3];

        DataList1_M.DataSource = dt_wk;
        DataList1_M.DataBind();
        //Label1.Text = Label1.Text + "(" + dt_wk.Rows.Count + ")";

        DataList2.DataSource = dt_my_1;
        DataList2.DataBind();
        Label2.Text = Label2.Text + "(" + dt_my_1.Rows.Count + ")";

        DataList3.DataSource = dt_my_2;
        DataList3.DataBind();
        Label3.Text = Label3.Text + "(" + dt_my_2.Rows.Count + ")";

        DataList4.DataSource = dt_my_3;
        DataList4.DataBind();
        Label4.Text = Label4.Text + "(" + dt_my_3.Rows.Count + ")";

    }

    protected void DataList1_M_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataList detail = (DataList)e.Item.FindControl("DataList1");
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