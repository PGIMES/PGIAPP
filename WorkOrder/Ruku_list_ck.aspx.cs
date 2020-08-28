using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_Ruku_list_ck : System.Web.UI.Page
{
    public int count_98_2, count_98_3, count_98_4, count_99_2, count_99_3, count_99_4;
    public double maxHour_98_2 = 0.0, maxHour_98_3 = 0.0, maxHour_98_4 = 0.0;

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
        string sql = @"exec [usp_app_bhgp_Apply_list_dv_V1_New] '','','','ruku'";
        DataSet ds = SQLHelper.Query(sql);

        DataTable dt_98_2 = ds.Tables[0]; DataTable dt_98_3 = ds.Tables[1]; DataTable dt_98_4 = ds.Tables[2];
        DataTable dt_99_2 = ds.Tables[3]; DataTable dt_99_3 = ds.Tables[4]; DataTable dt_99_4 = ds.Tables[5];


        ViewState["dt_98_2"] = dt_98_2; ViewState["dt_98_3"] = dt_98_3; ViewState["dt_98_4"] = dt_98_4;
        ViewState["dt_99_2"] = dt_99_2; ViewState["dt_99_3"] = dt_99_3; ViewState["dt_99_4"] = dt_99_4;

        DataTable rowsline_98_2 = dt_98_2.DefaultView.ToTable(true, "line");
        list_98_2_line.DataSource = rowsline_98_2;
        list_98_2_line.DataBind();
        count_98_2 = dt_98_2.Rows.Count;
        if (dt_98_2.Rows.Count > 0) { maxHour_98_2 = Convert.ToDouble(dt_98_2.Compute("max(timesHours)", "")); }

        DataTable rowsline_98_3 = dt_98_3.DefaultView.ToTable(true, "line");
        list_98_3_line.DataSource = rowsline_98_3;
        list_98_3_line.DataBind();
        count_98_3 = dt_98_3.Rows.Count;
        if (dt_98_3.Rows.Count > 0) { maxHour_98_3 = Convert.ToDouble(dt_98_3.Compute("max(timesHours)", "")); }

        DataTable rowsline_98_4 = dt_98_4.DefaultView.ToTable(true, "line");
        list_98_4_line.DataSource = rowsline_98_4;
        list_98_4_line.DataBind();
        count_98_4 = dt_98_4.Rows.Count;
        if (dt_98_4.Rows.Count > 0) { maxHour_98_4 = Convert.ToDouble(dt_98_4.Compute("max(timesHours)", "")); }

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

        //待入库
        BindData4();
        //入库完成24小时
        BindData5();
    }

    //待入库
    private void BindData4()
    {
        string sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}", "二车间", WeiXin.GetCookie("workcode"), 4);
        DataTable dt_data_2 = SQLHelper.Query(sql).Tables[0];
        ViewState["dt_data_2"] = dt_data_2;

        sql = sql = string.Format(@"exec [usp_app_YZ_monitor] '{0}','{1}',{2}", "三车间", WeiXin.GetCookie("workcode"), 4);
        DataTable dt_data_3 = SQLHelper.Query(sql).Tables[0];
        ViewState["dt_data_3"] = dt_data_3;

        sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}", "四车间", WeiXin.GetCookie("workcode"), 4);
        DataTable dt_data_4 = SQLHelper.Query(sql).Tables[0];
        ViewState["dt_data_4"] = dt_data_4;

    }
    //入库完成
    private void BindData5()
    {
        string sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}", "二车间", WeiXin.GetCookie("workcode"), 5);
        DataTable dt_data_end_2 = SQLHelper.Query(sql).Tables[0];
        ViewState["dt_data_end_2"] = dt_data_end_2;

        sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}", "三车间", WeiXin.GetCookie("workcode"), 5);
        DataTable dt_data_end_3 = SQLHelper.Query(sql).Tables[0];
        ViewState["dt_data_end_3"] = dt_data_end_3;

        sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}", "四车间", WeiXin.GetCookie("workcode"), 5);
        DataTable dt_data_end_4 = SQLHelper.Query(sql).Tables[0];
        ViewState["dt_data_end_4"] = dt_data_end_4;
    }


    protected void list_98_2_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_98_2");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            Label Label2 = (Label)e.Item.FindControl("Label2");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_98_2"] as DataTable;
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
                Label1.CssClass = "weui-badge  bg-orange";
            }

            Label2.Text = "0";
            if (dt_wk.Rows.Count > 0) { Label2.Text = dt_wk.Compute("max(timesHours)", "").ToString(); }
            if (Convert.ToDouble(Label2.Text) < 4)
            {
                Label2.CssClass = "weui-badge  bg-orange";
            }
            else
            {
                Label2.CssClass = "weui-badge  bg-red";
            }
            Label2.Text = Label2.Text + "H";
        }
    }

    protected void list_98_3_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_98_3");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            Label Label2 = (Label)e.Item.FindControl("Label2");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_98_3"] as DataTable;
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
                Label1.CssClass = "weui-badge  bg-orange";
            }

            Label2.Text = "0";
            if (dt_wk.Rows.Count > 0) { Label2.Text = dt_wk.Compute("max(timesHours)", "").ToString(); }
            if (Convert.ToDouble(Label2.Text) < 4)
            {
                Label2.CssClass = "weui-badge  bg-orange";
            }
            else
            {
                Label2.CssClass = "weui-badge  bg-red";
            }
            Label2.Text = Label2.Text + "H";
        }
    }

    protected void list_98_4_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_98_4");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            Label Label2 = (Label)e.Item.FindControl("Label2");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = ViewState["dt_98_4"] as DataTable;
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
                Label1.CssClass = "weui-badge  bg-orange";
            }

            Label2.Text = "0";
            if (dt_wk.Rows.Count > 0) { Label2.Text = dt_wk.Compute("max(timesHours)", "").ToString(); }
            if (Convert.ToDouble(Label2.Text) < 4)
            {
                Label2.CssClass = "weui-badge  bg-orange";
            }
            else
            {
                Label2.CssClass = "weui-badge  bg-red";
            }
            Label2.Text = Label2.Text + "H";
        }
    }

    protected void list_99_2_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("list_99_2");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            Label Label2 = (Label)e.Item.FindControl("Label2");
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
                Label1.CssClass = "weui-badge  bg-orange";
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
                Label1.CssClass = "weui-badge  bg-orange";
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
                Label1.CssClass = "weui-badge  bg-orange";
            }
        }
    }

}