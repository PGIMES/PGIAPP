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
    public int count1, count2, count3, count4, count5, count6, count7, count8;

    protected void Page_Load(object sender, EventArgs e)
    {
        _workshop = Request.QueryString["workshop"].ToString();

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
        //GetData(lu.WorkCode);
        GetData("02432");

    }

    private void GetData(string emp)
    {
        DataTable dt_go = new DataTable();
        DataTable dt_end = new DataTable();
        DataTable dt_go_my = new DataTable();
        DataTable dt_end_my = new DataTable();

        string sql = @"exec [usp_app_YT_list] '{0}','{1}'";
        sql = string.Format(sql, _workshop, emp);
        DataSet ds = SQLHelper.Query(sql);

        dt_go = ds.Tables[0];
        dt_end = ds.Tables[1];
        dt_go_my = ds.Tables[2];
        dt_end_my = ds.Tables[3];

        ViewState["dt_go"] = dt_go;
        ViewState["dt_end"] = dt_end;
        ViewState["dt_go_my"] = dt_go_my;
        ViewState["dt_end_my"] = dt_end_my;

        //list_go.DataSource = dt_go;
        DataTable rowsline_go = dt_go.DefaultView.ToTable(true, "line");
        list_go.DataSource = rowsline_go;
        list_go.DataBind();
        count1 = dt_go.Rows.Count;

        //list_end.DataSource = dt_end;
        DataTable rowsline_end = dt_end.DefaultView.ToTable(true, "line");
        list_end.DataSource = rowsline_end;
        list_end.DataBind();
        count4 = dt_end.Rows.Count;
        

        //list_go_my.DataSource = dt_go_my;
        DataTable rowsline_go_my = dt_go_my.DefaultView.ToTable(true, "line");
        list_go_my.DataSource = rowsline_go_my;
        list_go_my.DataBind();
        count5 = dt_go_my.Rows.Count;     

        //list_end_my.DataSource = dt_end_my;
        DataTable rowsline_end_my = dt_end_my.DefaultView.ToTable(true, "line");
        list_end_my.DataSource = rowsline_end_my;
        list_end_my.DataBind();
        count8 = dt_end_my.Rows.Count;
        

    }

    protected void list_go_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_go_dt");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_go"] as DataTable;
            dt_wk.DefaultView.RowFilter = "line='" + item["line"].ToString() + "'";

            detail.DataSource = dt_wk;
            detail.DataBind();
        }
    }

    protected void list_end_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_end_dt");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_end"] as DataTable;
            dt_wk.DefaultView.RowFilter = "line='" + item["line"].ToString() + "'";

            detail.DataSource = dt_wk;
            detail.DataBind();

        }
    }

    protected void list_go_my_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_go_my_dt");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_go_my"] as DataTable;
            dt_wk.DefaultView.RowFilter = "line='" + item["line"].ToString() + "'";

            detail.DataSource = dt_wk;
            detail.DataBind();

        }
    }


    protected void list_end_my_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_end_my_dt");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_end_my"] as DataTable;
            dt_wk.DefaultView.RowFilter = "line='" + item["line"].ToString() + "'";

            detail.DataSource = dt_wk;
            detail.DataBind();

        }
    }

}