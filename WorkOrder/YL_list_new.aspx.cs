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
        DataTable dt_go = new DataTable();
        DataTable dt_wc = new DataTable();
        DataTable dt_rj = new DataTable();
        DataTable dt_end = new DataTable();
        DataTable dt_go_my = new DataTable();
        DataTable dt_wc_my = new DataTable();
        DataTable dt_rj_my = new DataTable();
        DataTable dt_end_my = new DataTable();

        string sql = @"exec [usp_app_YL_list_new] '{0}','{1}'";
        sql = string.Format(sql, _workshop, emp);
        dt_go = SQLHelper.Query(sql).Tables[0];
        dt_wc = SQLHelper.Query(sql).Tables[1];
        dt_rj = SQLHelper.Query(sql).Tables[2];
        dt_end = SQLHelper.Query(sql).Tables[3];
        dt_go_my = SQLHelper.Query(sql).Tables[4];
        dt_wc_my = SQLHelper.Query(sql).Tables[5];
        dt_rj_my = SQLHelper.Query(sql).Tables[6];
        dt_end_my = SQLHelper.Query(sql).Tables[7];

        ViewState["dt_go"] = dt_go;
        ViewState["dt_wc"] = dt_wc;
        ViewState["dt_rj"] = dt_rj;
        ViewState["dt_end"] = dt_end;
        ViewState["dt_go_my"] = dt_go_my;
        ViewState["dt_wc_my"] = dt_wc_my;
        ViewState["dt_rj_my"] = dt_rj_my;
        ViewState["dt_end_my"] = dt_end_my;

        //list_go.DataSource = dt_go;
        DataTable rowsline_go = dt_go.DefaultView.ToTable(true, "line");
        list_go.DataSource = rowsline_go;
        list_go.DataBind();
        //Label1.Text = "(" + dt_go.Rows.Count + ")";

        //list_wc.DataSource = dt_wc;
        DataTable rowsline_wc = dt_wc.DefaultView.ToTable(true, "line");
        list_wc.DataSource = rowsline_wc;
        list_wc.DataBind();
        //Label2.Text = "(" + dt_wc.Rows.Count + ")";

        //list_rj.DataSource = dt_rj;
        DataTable rowsline_rj = dt_rj.DefaultView.ToTable(true, "line");
        list_rj.DataSource = rowsline_rj;
        list_rj.DataBind();
        //Label3.Text = "(" + dt_rj.Rows.Count + ")";

        //list_end.DataSource = dt_end;
        DataTable rowsline_end = dt_end.DefaultView.ToTable(true, "line");
        list_end.DataSource = rowsline_end;
        list_end.DataBind();
        //Label4.Text = "(" + dt_end.Rows.Count + ")";

        //list_go_my.DataSource = dt_go_my;
        DataTable rowsline_go_my = dt_go_my.DefaultView.ToTable(true, "line");
        list_go_my.DataSource = rowsline_go_my;
        list_go_my.DataBind();
        //Label5.Text = "(" + dt_go_my.Rows.Count + ")";

        //list_wc_my.DataSource = dt_wc_my;
        DataTable rowsline_wc_my = dt_wc_my.DefaultView.ToTable(true, "line");
        list_wc_my.DataSource = rowsline_wc_my;
        list_wc_my.DataBind();
        //Label6.Text = "(" + dt_wc_my.Rows.Count + ")";

        //list_rj_my.DataSource = dt_rj_my;
        DataTable rowsline_rj_my = dt_rj_my.DefaultView.ToTable(true, "line");
        list_rj_my.DataSource = rowsline_rj_my;
        list_rj_my.DataBind();
        //Label7.Text = "(" + dt_rj_my.Rows.Count + ")";

        //list_end_my.DataSource = dt_end_my;
        DataTable rowsline_end_my = dt_end_my.DefaultView.ToTable(true, "line");
        list_end_my.DataSource = rowsline_end_my;
        list_end_my.DataBind();
        //Label8.Text = "(" + dt_end_my.Rows.Count + ")";

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

    protected void list_wc_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_wc_dt");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_wc"] as DataTable;
            dt_wk.DefaultView.RowFilter = "line='" + item["line"].ToString() + "'";

            detail.DataSource = dt_wk;
            detail.DataBind();

        }
    }

    protected void list_rj_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_rj_dt");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_rj"] as DataTable;
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

    protected void list_wc_my_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_wc_my_dt");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_wc_my"] as DataTable;
            dt_wk.DefaultView.RowFilter = "line='" + item["line"].ToString() + "'";

            detail.DataSource = dt_wk;
            detail.DataBind();

        }
    }

    protected void list_rj_my_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_rj_my_dt");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_rj_my"] as DataTable;
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