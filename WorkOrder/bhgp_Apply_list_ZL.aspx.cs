using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_bhgp_Apply_list_V1 : System.Web.UI.Page
{
    public string _workshop = "";
    public string _workcode = "";
    public int count_01, count_02, count_03, count_04, count_05, count_98, count_99;
    public int count_01_my, count_02_my, count_03_my, count_04_my, count_05_my, count_98_my, count_99_my;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["workshop"] != null) { _workshop = Request.QueryString["workshop"].ToString(); }

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
        _workcode = lu.WorkCode;
        GetData(_workcode);

        //_workcode = "02432";
        //GetData("02432");
    }

    private void GetData(string emp)
    {
        string sql = @"exec [usp_app_bhgp_Apply_list_dv_V1_New] '{0}','{1}','',''";
        sql = string.Format(sql, _workshop, emp);
        DataSet ds = SQLHelper.Query(sql);

        DataTable dt_01 = ds.Tables[0]; DataTable dt_02 = ds.Tables[1]; DataTable dt_03 = ds.Tables[2];
        DataTable dt_04 = ds.Tables[3]; DataTable dt_05 = ds.Tables[4]; DataTable dt_98 = ds.Tables[5];
        DataTable dt_99 = ds.Tables[6];

        DataTable dt_01_my = ds.Tables[7]; DataTable dt_02_my = ds.Tables[8]; DataTable dt_03_my = ds.Tables[9];
        DataTable dt_04_my = ds.Tables[10]; DataTable dt_05_my = ds.Tables[11]; DataTable dt_98_my = ds.Tables[12];
        DataTable dt_99_my = ds.Tables[13];

        ViewState["dt_01"] = dt_01; ViewState["dt_02"] = dt_02; ViewState["dt_03"] = dt_03;
        ViewState["dt_04"] = dt_04; ViewState["dt_05"] = dt_05; ViewState["dt_98"] = dt_98;
        ViewState["dt_99"] = dt_99;

        ViewState["dt_02_my"] = dt_02_my; ViewState["dt_99_my"] = dt_99_my;

        //list_01.DataSource = dt_01; list_01.DataBind();
        DataTable rowsline_01 = dt_01.DefaultView.ToTable(true, "workshop");
        list_01_line.DataSource = rowsline_01;
        list_01_line.DataBind();

        count_01 = dt_01.Rows.Count;

        //list_02.DataSource = dt_02; list_02.DataBind();
        DataTable rowsline_02 = dt_02.DefaultView.ToTable(true, "workshop");
        list_02_line.DataSource = rowsline_02;
        list_02_line.DataBind();

        count_02 = dt_02.Rows.Count;


        //list_03.DataSource = dt_03; list_03.DataBind();
        DataTable rowsline_03 = dt_03.DefaultView.ToTable(true, "workshop");
        list_03_line.DataSource = rowsline_03;
        list_03_line.DataBind();

        count_03 = dt_03.Rows.Count;

        //list_04.DataSource = dt_04; list_04.DataBind();
        DataTable rowsline_04 = dt_04.DefaultView.ToTable(true, "workshop");
        list_04_line.DataSource = rowsline_04;
        list_04_line.DataBind();

        count_04 = dt_04.Rows.Count;

        //list_05.DataSource = dt_05; list_05.DataBind();
        DataTable rowsline_05 = dt_05.DefaultView.ToTable(true, "workshop");
        list_05_line.DataSource = rowsline_05;
        list_05_line.DataBind();

        count_05 = dt_05.Rows.Count;


        //list_98.DataSource = dt_98; list_98.DataBind();
        DataTable rowsline_98 = dt_98.DefaultView.ToTable(true, "workshop");
        list_98_line.DataSource = rowsline_98;
        list_98_line.DataBind();

        count_98 = dt_98.Rows.Count;

        //list_99.DataSource = dt_99; list_99.DataBind();
        DataTable rowsline_99 = dt_99.DefaultView.ToTable(true, "line");
        list_99_line.DataSource = rowsline_99;
        list_99_line.DataBind();

        count_99 = dt_99.Rows.Count;

        list_01_my.DataSource = dt_01_my; list_01_my.DataBind(); count_01_my = dt_01_my.Rows.Count;
        list_02_my.DataSource = dt_02_my; list_02_my.DataBind(); count_02_my = dt_02_my.Rows.Count;
        list_03_my.DataSource = dt_03_my; list_03_my.DataBind(); count_03_my = dt_03_my.Rows.Count;
        list_04_my.DataSource = dt_04_my; list_04_my.DataBind(); count_04_my = dt_04_my.Rows.Count;
        list_05_my.DataSource = dt_05_my; list_05_my.DataBind(); count_05_my = dt_05_my.Rows.Count;
        list_98_my.DataSource = dt_98_my; list_98_my.DataBind(); count_98_my = dt_98_my.Rows.Count;

        //list_99_my.DataSource = dt_99_my; list_99_my.DataBind();
        DataTable rowsline_99_my = dt_99_my.DefaultView.ToTable(true, "line");
        list_99_line_my.DataSource = rowsline_99_my;
        list_99_line_my.DataBind();

        count_99_my = dt_99_my.Rows.Count;

    }

    protected void list_01_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_01");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_01"] as DataTable;
            dt_wk.DefaultView.RowFilter = "workshop='" + item["workshop"].ToString() + "'";

            detail.DataSource = dt_wk;
            detail.DataBind();

            Label1.Text = detail.Items.Count.ToString();
            if (Label1.Text == "0")
            {
                Label1.CssClass = "weui-badge  bg-gray";
            }
            else
            {
                Label1.CssClass = "weui-badge  bg-red";
            }
        }
    }

    protected void list_02_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_02");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_02"] as DataTable;
            dt_wk.DefaultView.RowFilter = "workshop='" + item["workshop"].ToString() + "'";

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

    protected void list_03_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_03");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_03"] as DataTable;
            dt_wk.DefaultView.RowFilter = "workshop='" + item["workshop"].ToString() + "'";

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

    protected void list_04_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_04");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_04"] as DataTable;
            dt_wk.DefaultView.RowFilter = "workshop='" + item["workshop"].ToString() + "'";

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

    protected void list_05_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_05");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_05"] as DataTable;
            dt_wk.DefaultView.RowFilter = "workshop='" + item["workshop"].ToString() + "'";

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

    protected void list_98_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_98");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_98"] as DataTable;
            dt_wk.DefaultView.RowFilter = "workshop='" + item["workshop"].ToString() + "'";

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

    protected void list_99_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_99");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_99"] as DataTable;
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

    protected void list_99_line_my_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_99_my");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_99_my"] as DataTable;
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