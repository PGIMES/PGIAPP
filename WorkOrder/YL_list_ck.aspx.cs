using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_YL_list_ck : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }
        GetData();

    }

    private void GetData()
    {
        DataTable dt_go = new DataTable();

        string sql = @"exec [usp_app_YL_list_new] '{0}','{1}'";
        sql = string.Format(sql, "", "");
        dt_go = SQLHelper.Query(sql).Tables[0];

        ViewState["dt_go"] = dt_go;

        //list_go.DataSource = dt_go;
        DataTable rowsline_go = dt_go.DefaultView.ToTable(true, "workshop");
        list_go.DataSource = rowsline_go;
        list_go.DataBind();

    }

    protected void list_go_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_go_dt");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_go"] as DataTable;
            dt_wk.DefaultView.RowFilter = "workshop='" + item["workshop"].ToString() + "'";

            detail.DataSource = dt_wk;
            detail.DataBind();

            Label1.Text = "(" + dt_wk.Rows.Count + ")";
        }
    }

}