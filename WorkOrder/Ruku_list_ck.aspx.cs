using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_Ruku_list_ck : System.Web.UI.Page
{
    public string _para_ck = "";
    public int count_98_2, count_98_3, count_98_4, count_99_2, count_99_3, count_99_4;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["para_ck"] != null) { _para_ck = Request.QueryString["para_ck"].ToString(); }

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        GetData();
    }
    private void GetData()
    {
        string sql = @"exec [usp_app_bhgp_Apply_list_dv_V1_New] '','','','ruku'";
        DataSet ds = SQLHelper.Query(sql);

        DataTable dt_98_2 = ds.Tables[0]; DataTable dt_98_3 = ds.Tables[1]; DataTable dt_98_4 = ds.Tables[2];
        DataTable dt_99_2 = ds.Tables[3]; DataTable dt_99_3 = ds.Tables[4]; DataTable dt_99_4 = ds.Tables[5];


        ViewState["dt_99_2"] = dt_99_2; ViewState["dt_99_3"] = dt_99_3; ViewState["dt_99_4"] = dt_99_4;

        list_98_2.DataSource = dt_98_2; list_98_2.DataBind(); count_98_2 = dt_98_2.Rows.Count;
        list_98_3.DataSource = dt_98_3; list_98_3.DataBind(); count_98_3 = dt_98_3.Rows.Count;
        list_98_4.DataSource = dt_98_4; list_98_4.DataBind(); count_98_4 = dt_98_4.Rows.Count;

        DataTable rowsline_99_2 = dt_99_2.DefaultView.ToTable(true, "line");
        list_99_2_line.DataSource = rowsline_99_2;
        list_99_2_line.DataBind();

        count_99_2 = dt_99_2.Rows.Count;

        DataTable rowsline_99_3 = dt_99_3.DefaultView.ToTable(true, "line");
        list_99_3_line.DataSource = rowsline_99_3;
        list_99_3_line.DataBind();

        count_99_3 = dt_99_3.Rows.Count;


        DataTable rowsline_99_4 = dt_99_4.DefaultView.ToTable(true, "line");
        list_99_4_line.DataSource = rowsline_99_4;
        list_99_4_line.DataBind();

        count_99_4 = dt_99_4.Rows.Count;
    }

    protected void list_99_2_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_99_2");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_99_2"] as DataTable;
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


    protected void list_99_3_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_99_3");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_99_3"] as DataTable;
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


    protected void list_99_4_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_99_4");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_99_4"] as DataTable;
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

    /*
    private void GetData()
    {
        DataTable dt_wk = new DataTable();

        string sql = @"exec [usp_app_bhgp_Apply_list_ck]";
        DataSet ds = SQLHelper.Query(sql);

        dt_wk = ds.Tables[0];

        list_go.DataSource = dt_wk;
        list_go.DataBind();

    }

    protected void list_go_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("re_go");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = new DataTable();
            string sql = @"exec [usp_app_bhgp_Apply_list_dv_V1_New] '{0}','{1}','{2}','all'";
            sql = string.Format(sql, item["workshop"].ToString(), "", item["stepid"].ToString());
            dt_wk = SQLHelper.Query(sql).Tables[0];

            detail.DataSource = dt_wk;
            detail.DataBind();

            //Label1.Text = "(" + dt_wk.Rows.Count + ")";

            Label1.Text = dt_wk.DefaultView.Count.ToString();
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
    */
}