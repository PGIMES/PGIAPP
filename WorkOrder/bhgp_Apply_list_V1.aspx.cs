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

    protected void Page_Load(object sender, EventArgs e)
    {
        _workshop = Request.QueryString["workshop"].ToString();

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
        DataTable dt_wk = new DataTable();

        string sql = @"exec [usp_app_bhgp_Apply_list_V1] '{0}','{1}'";
        sql = string.Format(sql, _workshop, emp);
        DataSet ds = SQLHelper.Query(sql);

        dt_wk = ds.Tables[0];

        list_go.DataSource = dt_wk;
        list_go.DataBind();

        list_go_my.DataSource = dt_wk;
        list_go_my.DataBind();

    }

    protected void list_go_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("re_go");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = new DataTable();
            string sql = @"exec [usp_app_bhgp_Apply_list_dv_V1] '{0}','{1}','{2}','{3}'";
            sql = string.Format(sql, _workshop, item["stepname"].ToString(), item["stepid"].ToString(), "");
            dt_wk = SQLHelper.Query(sql).Tables[0];

            detail.DataSource = dt_wk;
            detail.DataBind();

            Label1.Text = "(" + dt_wk.Rows.Count + ")";


        }
    }


    protected void list_go_my_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("re_go_my");
            Label Label1 = (Label)e.Item.FindControl("Label1_my");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = new DataTable();
            string sql = @"exec [usp_app_bhgp_Apply_list_dv_V1] '{0}','{1}','{2}','{3}'";
            sql = string.Format(sql, _workshop, item["stepname"].ToString(), item["stepid"].ToString(), _workcode);
            dt_wk = SQLHelper.Query(sql).Tables[0];

            detail.DataSource = dt_wk;
            detail.DataBind();

            Label1.Text = "(" + dt_wk.Rows.Count + ")";


        }
    }
}