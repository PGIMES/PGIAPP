using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class prod_qc_list : System.Web.UI.Page
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
        DataTable dt_part = new DataTable();
        DataTable dt_complete = new DataTable();

        DataTable dt_part_my = new DataTable();
        DataTable dt_complete_my = new DataTable();

        string sql = string.Format(@"exec [usp_app_prod_qc_list] '{0}'", WeiXin.GetCookie("workcode"));
        DataSet ds = SQLHelper.Query(sql);

        dt_part = ds.Tables[0];
        dt_complete = ds.Tables[1];
        dt_part_my = ds.Tables[2];
        dt_complete_my = ds.Tables[3];
         
        ViewState["dt_part"] = dt_part; 
        ViewState["dt_complete"] = dt_complete; 
        ViewState["dt_part_my"] = dt_part_my; 
        ViewState["dt_complete_my"] = dt_complete_my;
        //完成工单
        var rowsline1 = dt_part.AsEnumerable().Select(r => ((string)r["line"]).ToString()).Distinct();

        DataList1_line.DataSource = rowsline1;
        DataList1_line.DataBind();

        //DataList1.DataSource = dt_part;
        //DataList1.DataBind();
        //Label1.Text = "(" + dt_part.Rows.Count + ")";
        var rowsline2 = dt_complete.AsEnumerable().Select(r => ((string)r["line"]).ToString()).Distinct();
        DataList2_line.DataSource = rowsline2;
        DataList2_line.DataBind();

        //DataList2.DataSource = dt_complete;
        //DataList2.DataBind();
        //Label2.Text = "(" + dt_complete.Rows.Count + ")";



        // 我的工单
        var rowsline3 = dt_part_my.AsEnumerable().Select(r => ((string)r["line"]).ToString()).Distinct();
        DataList3_line.DataSource = rowsline3;
        DataList3_line.DataBind();
        //DataList3.DataSource = dt_part_my;
        //DataList3.DataBind();
        //Label3.Text =  "(" + dt_part_my.Rows.Count + ")";
        var rowsline4 = dt_complete_my.AsEnumerable().Select(r => ((string)r["line"]).ToString()).Distinct();
        DataList4_line.DataSource = rowsline4;
        DataList4_line.DataBind();
        //DataList4.DataSource = dt_complete_my;
        //DataList4.DataBind();
        //Label4.Text = "(" + dt_complete_my.Rows.Count + ")";



        //dt_part = ds.Tables[0];
        //dt_complete = ds.Tables[1];

        //dt_part_my = ds.Tables[2];
        //dt_complete_my = ds.Tables[3];
        ////生产完成工单
        //DataList1.DataSource = dt_part;
        //DataList1.DataBind();
        //Label1.Text = "(" + dt_part.Rows.Count + ")";

        //DataList2.DataSource = dt_complete;
        //DataList2.DataBind();
        //Label2.Text = "(" + dt_complete.Rows.Count + ")";

        //// 我的工单
        //DataList3.DataSource = dt_part_my;
        //DataList3.DataBind();
        //Label3.Text =  "(" + dt_part_my.Rows.Count + ")";

        //DataList4.DataSource = dt_complete_my;
        //DataList4.DataBind();
        //Label4.Text = "(" + dt_complete_my.Rows.Count + ")";
    }
    protected void BindInnerRepeat(RepeaterItemEventArgs e, string innerRepeatId, string viewstateDataTable)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl(innerRepeatId);
            // DataRowView item = (DataRowView)e.Item.DataItem;
            // var line = item["line"].ToString();

            var line = e.Item.DataItem.ToString();
            DataTable dt_all = ViewState[viewstateDataTable] as DataTable;

            dt_all.DefaultView.RowFilter = "line='" + line + "'";

            detail.DataSource = dt_all;
            detail.DataBind();

        }
    }
    protected void DataList1_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        BindInnerRepeat(e, "DataList1", "dt_part");
    }

    protected void DataList2_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        BindInnerRepeat(e, "DataList2", "dt_complete");
    }



    protected void DataList3_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        BindInnerRepeat(e, "DataList3", "dt_part_my");
    }

    protected void DataList4_line_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        BindInnerRepeat(e, "DataList4", "dt_complete_my");
    }
}