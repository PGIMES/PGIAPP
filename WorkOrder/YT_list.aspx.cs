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
    public int count0, count1, count2
        , count0_my, count1_my, count2_my;

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
        DataTable dt_pre = new DataTable();
        DataTable dt_go = new DataTable();
        DataTable dt_end = new DataTable();
        DataTable dt_pre_my = new DataTable();
        DataTable dt_go_my = new DataTable();
        DataTable dt_end_my = new DataTable();

        string sql = @"exec [usp_app_YT_list_V1] '{0}','{1}'";
        sql = string.Format(sql, _workshop, emp);
        DataSet ds = SQLHelper.Query(sql);

        dt_pre = ds.Tables[0];
        dt_go = ds.Tables[1];
        dt_end = ds.Tables[2];
        dt_pre_my = ds.Tables[3];
        dt_go_my = ds.Tables[4];
        dt_end_my = ds.Tables[5];

        ViewState["dt_pre"] = dt_pre;
        ViewState["dt_go"] = dt_go;
        ViewState["dt_end"] = dt_end;
        ViewState["dt_pre_my"] = dt_pre_my;
        ViewState["dt_go_my"] = dt_go_my;
        ViewState["dt_end_my"] = dt_end_my;

        //list_pre.DataSource = dt_pre;
        DataTable rowsline_pre = dt_pre.DefaultView.ToTable(true, "cl");
        list_pre.DataSource = rowsline_pre;
        list_pre.DataBind();
        count0 = dt_pre.Rows.Count;

        //list_go.DataSource = dt_go;
        DataTable rowsline_go = dt_go.DefaultView.ToTable(true, "cl");
        list_go.DataSource = rowsline_go;
        list_go.DataBind();
        count1 = dt_go.Rows.Count;

        //list_end.DataSource = dt_end;
        DataTable rowsline_end = dt_end.DefaultView.ToTable(true, "cl");
        list_end.DataSource = rowsline_end;
        list_end.DataBind();
        count2 = dt_end.Rows.Count;

        //list_pre_my.DataSource = dt_pre_my;
        DataTable rowsline_pre_my = dt_pre_my.DefaultView.ToTable(true, "cl");
        list_pre_my.DataSource = rowsline_pre_my;
        list_pre_my.DataBind();
        count0_my = dt_pre_my.Rows.Count;

        //list_go_my.DataSource = dt_go_my;
        DataTable rowsline_go_my = dt_go_my.DefaultView.ToTable(true, "cl");
        list_go_my.DataSource = rowsline_go_my;
        list_go_my.DataBind();
        count1_my = dt_go_my.Rows.Count;     

        //list_end_my.DataSource = dt_end_my;
        DataTable rowsline_end_my = dt_end_my.DefaultView.ToTable(true, "cl");
        list_end_my.DataSource = rowsline_end_my;
        list_end_my.DataBind();
        count2_my = dt_end_my.Rows.Count;


    }
    protected void list_pre_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_pre_dt");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_pre"] as DataTable;
            dt_wk.DefaultView.RowFilter = "cl='" + item["cl"].ToString() + "'";

            detail.DataSource = dt_wk;
            detail.DataBind();
        }
    }

    protected void list_go_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_go_dt");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_go"] as DataTable;
            dt_wk.DefaultView.RowFilter = "cl='" + item["cl"].ToString() + "'";

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
            dt_wk.DefaultView.RowFilter = "cl='" + item["cl"].ToString() + "'";

            detail.DataSource = dt_wk;
            detail.DataBind();

        }
    }

    protected void list_pre_my_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_pre_my_dt");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_pre_my"] as DataTable;
            dt_wk.DefaultView.RowFilter = "cl='" + item["cl"].ToString() + "'";

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
            dt_wk.DefaultView.RowFilter = "cl='" + item["cl"].ToString() + "'";

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
            dt_wk.DefaultView.RowFilter = "cl='" + item["cl"].ToString() + "'";

            detail.DataSource = dt_wk;
            detail.DataBind();

        }
    }

}