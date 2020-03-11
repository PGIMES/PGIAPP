using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class bhgp_deal_list : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!IsPostBack)
        //{
            GetData();
        //}
    }

    private void GetData()
    {
        DataTable dt = new DataTable();
        string sql = @"exec [usp_app_workorder_ng_go] ''";
        dt = SQLHelper.Query(sql).Tables[0];

        if (dt == null || dt.Rows.Count <= 0)
        {
            lb_msg.Text = "No Data Found!";
        }
        GridView1.DataSource = dt;
        GridView1.DataBind();

    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        this.GridView1.PageIndex = e.NewPageIndex;
        GetData();
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes.Add("onmouseover", "javascript:currentcolor=this.style.backgroundColor;this.style.backgroundColor='#DFE7DF';");
            e.Row.Attributes.Add("onmouseout", "javascript:this.style.backgroundColor=currentcolor;");
        }
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        string workorder = GridView1.SelectedRow.Cells[1].Text.Trim().Replace("&nbsp;", "");
        //Response.Redirect(string.Format("/workorder/bhgp_deal_result.aspx?workorder={0}", workorder));
        Response.Redirect(string.Format("/workorder/bhgp_deal_result.aspx?workorder={0}&next={1}", workorder, "N"));
    }

}
