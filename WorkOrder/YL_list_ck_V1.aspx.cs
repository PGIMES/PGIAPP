using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_YL_list_ck_V1 : System.Web.UI.Page
{
    public int count_go_2, count_wc_2, count_rj_2, count_end_2;
    public int count_go_3, count_wc_3, count_rj_3, count_end_3;
    public int count_go_4, count_wc_4, count_rj_4, count_end_4;

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
        string sql = @"exec [usp_app_YL_list_ck_V1]";
        DataSet ds = SQLHelper.Query(sql);

        DataTable dt_go_2 = ds.Tables[0]; DataTable dt_wc_2 = ds.Tables[1]; DataTable dt_rj_2 = ds.Tables[2]; DataTable dt_end_2 = ds.Tables[3];
        DataTable dt_go_3 = ds.Tables[4]; DataTable dt_wc_3 = ds.Tables[5]; DataTable dt_rj_3 = ds.Tables[6]; DataTable dt_end_3 = ds.Tables[7];
        DataTable dt_go_4 = ds.Tables[8]; DataTable dt_wc_4 = ds.Tables[9]; DataTable dt_rj_4 = ds.Tables[10]; DataTable dt_end_4 = ds.Tables[11];

        ViewState["dt_go_2"] = dt_go_2; ViewState["dt_wc_2"] = dt_wc_2; ViewState["dt_rj_2"] = dt_rj_2; ViewState["dt_end_2"] = dt_end_2;
        ViewState["dt_go_3"] = dt_go_3; ViewState["dt_wc_3"] = dt_wc_3; ViewState["dt_rj_3"] = dt_rj_3; ViewState["dt_end_3"] = dt_end_3;
        ViewState["dt_go_4"] = dt_go_4; ViewState["dt_wc_4"] = dt_wc_4; ViewState["dt_rj_4"] = dt_rj_4; ViewState["dt_end_4"] = dt_end_4;

        DataTable rowsline_go_2 = dt_go_2.DefaultView.ToTable(true, "line");
        list_go_2_line.DataSource = rowsline_go_2;
        list_go_2_line.DataBind();
        count_go_2 = dt_go_2.Rows.Count;

        DataTable rowsline_wc_2 = dt_wc_2.DefaultView.ToTable(true, "line");
        list_wc_2_line.DataSource = rowsline_wc_2;
        list_wc_2_line.DataBind();
        count_wc_2 = dt_wc_2.Rows.Count;

        DataTable rowsline_rj_2 = dt_rj_2.DefaultView.ToTable(true, "line");
        list_rj_2_line.DataSource = rowsline_rj_2;
        list_rj_2_line.DataBind();
        count_rj_2 = dt_rj_2.Rows.Count;

        DataTable rowsline_end_2 = dt_end_2.DefaultView.ToTable(true, "line");
        list_end_2_line.DataSource = rowsline_end_2;
        list_end_2_line.DataBind();
        count_end_2 = dt_end_2.Rows.Count;

        DataTable rowsline_go_3 = dt_go_3.DefaultView.ToTable(true, "line");
        list_go_3_line.DataSource = rowsline_go_3;
        list_go_3_line.DataBind();
        count_go_3 = dt_go_3.Rows.Count;

        DataTable rowsline_wc_3 = dt_wc_3.DefaultView.ToTable(true, "line");
        list_wc_3_line.DataSource = rowsline_wc_3;
        list_wc_3_line.DataBind();
        count_wc_3 = dt_wc_3.Rows.Count;

        DataTable rowsline_rj_3 = dt_rj_3.DefaultView.ToTable(true, "line");
        list_rj_3_line.DataSource = rowsline_rj_3;
        list_rj_3_line.DataBind();
        count_rj_3 = dt_rj_3.Rows.Count;

        DataTable rowsline_end_3 = dt_end_3.DefaultView.ToTable(true, "line");
        list_end_3_line.DataSource = rowsline_end_3;
        list_end_3_line.DataBind();
        count_end_3 = dt_end_3.Rows.Count;

        DataTable rowsline_go_4 = dt_go_4.DefaultView.ToTable(true, "line");
        list_go_4_line.DataSource = rowsline_go_4;
        list_go_4_line.DataBind();
        count_go_4 = dt_go_4.Rows.Count;

        DataTable rowsline_wc_4 = dt_wc_4.DefaultView.ToTable(true, "line");
        list_wc_4_line.DataSource = rowsline_wc_4;
        list_wc_4_line.DataBind();
        count_wc_4 = dt_wc_4.Rows.Count;

        DataTable rowsline_rj_4 = dt_rj_4.DefaultView.ToTable(true, "line");
        list_rj_4_line.DataSource = rowsline_rj_4;
        list_rj_4_line.DataBind();
        count_rj_4 = dt_rj_4.Rows.Count;

        DataTable rowsline_end_4 = dt_end_4.DefaultView.ToTable(true, "line");
        list_end_4_line.DataSource = rowsline_end_4;
        list_end_4_line.DataBind();
        count_end_4 = dt_end_4.Rows.Count;

    }
    protected void list_go_2_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_go_2");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_go_2"] as DataTable;
            dt_wk.DefaultView.RowFilter = "line='" + item["line"].ToString() + "'";

            detail.DataSource = dt_wk;
            detail.DataBind();

            Label1.Text = detail.Items.Count.ToString();
            if (Label1.Text == "0")
            {
                Label1.CssClass = "weui-badge  bg-gray";
            }
            else
            {
                Label1.CssClass = "weui-badge  bg-blue";
            }
        }
    }

    protected void list_wc_2_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_wc_2");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_wc_2"] as DataTable;
            dt_wk.DefaultView.RowFilter = "line='" + item["line"].ToString() + "'";

            detail.DataSource = dt_wk;
            detail.DataBind();

            Label1.Text = detail.Items.Count.ToString();
            if (Label1.Text == "0")
            {
                Label1.CssClass = "weui-badge  bg-gray";
            }
            else
            {
                Label1.CssClass = "weui-badge  bg-blue";
            }
        }
    }

    protected void list_rj_2_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_rj_2");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_rj_2"] as DataTable;
            dt_wk.DefaultView.RowFilter = "line='" + item["line"].ToString() + "'";

            detail.DataSource = dt_wk;
            detail.DataBind();

            Label1.Text = detail.Items.Count.ToString();
            if (Label1.Text == "0")
            {
                Label1.CssClass = "weui-badge  bg-gray";
            }
            else
            {
                Label1.CssClass = "weui-badge  bg-blue";
            }
        }
    }

    protected void list_end_2_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_end_2");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_end_2"] as DataTable;
            dt_wk.DefaultView.RowFilter = "line='" + item["line"].ToString() + "'";

            detail.DataSource = dt_wk;
            detail.DataBind();

            Label1.Text = detail.Items.Count.ToString();
            if (Label1.Text == "0")
            {
                Label1.CssClass = "weui-badge  bg-gray";
            }
            else
            {
                Label1.CssClass = "weui-badge  bg-blue";
            }
        }
    }

    protected void list_go_3_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_go_3");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_go_3"] as DataTable;
            dt_wk.DefaultView.RowFilter = "line='" + item["line"].ToString() + "'";

            detail.DataSource = dt_wk;
            detail.DataBind();

            Label1.Text = detail.Items.Count.ToString();
            if (Label1.Text == "0")
            {
                Label1.CssClass = "weui-badge  bg-gray";
            }
            else
            {
                Label1.CssClass = "weui-badge  bg-blue";
            }
        }
    }

    protected void list_wc_3_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_wc_3");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_wc_3"] as DataTable;
            dt_wk.DefaultView.RowFilter = "line='" + item["line"].ToString() + "'";

            detail.DataSource = dt_wk;
            detail.DataBind();

            Label1.Text = detail.Items.Count.ToString();
            if (Label1.Text == "0")
            {
                Label1.CssClass = "weui-badge  bg-gray";
            }
            else
            {
                Label1.CssClass = "weui-badge  bg-blue";
            }
        }
    }

    protected void list_rj_3_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_rj_3");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_rj_3"] as DataTable;
            dt_wk.DefaultView.RowFilter = "line='" + item["line"].ToString() + "'";

            detail.DataSource = dt_wk;
            detail.DataBind();

            Label1.Text = detail.Items.Count.ToString();
            if (Label1.Text == "0")
            {
                Label1.CssClass = "weui-badge  bg-gray";
            }
            else
            {
                Label1.CssClass = "weui-badge  bg-blue";
            }
        }
    }

    protected void list_end_3_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_end_3");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_end_3"] as DataTable;
            dt_wk.DefaultView.RowFilter = "line='" + item["line"].ToString() + "'";

            detail.DataSource = dt_wk;
            detail.DataBind();

            Label1.Text = detail.Items.Count.ToString();
            if (Label1.Text == "0")
            {
                Label1.CssClass = "weui-badge  bg-gray";
            }
            else
            {
                Label1.CssClass = "weui-badge  bg-blue";
            }
        }
    }

    protected void list_go_4_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_go_4");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_go_4"] as DataTable;
            dt_wk.DefaultView.RowFilter = "line='" + item["line"].ToString() + "'";

            detail.DataSource = dt_wk;
            detail.DataBind();

            Label1.Text = detail.Items.Count.ToString();
            if (Label1.Text == "0")
            {
                Label1.CssClass = "weui-badge  bg-gray";
            }
            else
            {
                Label1.CssClass = "weui-badge  bg-blue";
            }
        }
    }

    protected void list_wc_4_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_wc_4");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_wc_4"] as DataTable;
            dt_wk.DefaultView.RowFilter = "line='" + item["line"].ToString() + "'";

            detail.DataSource = dt_wk;
            detail.DataBind();

            Label1.Text = detail.Items.Count.ToString();
            if (Label1.Text == "0")
            {
                Label1.CssClass = "weui-badge  bg-gray";
            }
            else
            {
                Label1.CssClass = "weui-badge  bg-blue";
            }
        }
    }

    protected void list_rj_4_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_rj_4");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_rj_4"] as DataTable;
            dt_wk.DefaultView.RowFilter = "line='" + item["line"].ToString() + "'";

            detail.DataSource = dt_wk;
            detail.DataBind();

            Label1.Text = detail.Items.Count.ToString();
            if (Label1.Text == "0")
            {
                Label1.CssClass = "weui-badge  bg-gray";
            }
            else
            {
                Label1.CssClass = "weui-badge  bg-blue";
            }
        }
    }

    protected void list_end_4_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_end_4");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_end_4"] as DataTable;
            dt_wk.DefaultView.RowFilter = "line='" + item["line"].ToString() + "'";

            detail.DataSource = dt_wk;
            detail.DataBind();

            Label1.Text = detail.Items.Count.ToString();
            if (Label1.Text == "0")
            {
                Label1.CssClass = "weui-badge  bg-gray";
            }
            else
            {
                Label1.CssClass = "weui-badge  bg-blue";
            }
        }
    }

}