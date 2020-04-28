using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class prod_wip_list : System.Web.UI.Page
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

        string workcode =  WeiXin.GetCookie("workcode");
        GetData(workcode);
        //GetData("02432");
    }

    private void GetData(string emp)
    {
        DataTable dt_line = new DataTable();
        DataTable dt_all = new DataTable();

        string sql = @"exec [usp_app_prod_wip_list] '{0}','{1}'";
        sql = string.Format(sql, Request.QueryString["workshop"].ToString(), WeiXin.GetCookie("workcode"));

        DataSet ds= SQLHelper.Query(sql);

        dt_line = ds.Tables[0];
        dt_all = ds.Tables[1];
        ViewState["dt_all"] = dt_all;         

        list_line.DataSource = dt_line;
        list_line.DataBind();

        //.Where<DataRow>(c => c["emp_code"].ToString() == "")
        var rows = dt_all.AsEnumerable().Select(r => ((string)r["line"]).ToString()).Distinct();//.ToList();

        list_line_my.DataSource = rows;
        list_line_my.DataBind();         

    }

    protected void list_go_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("re_go");
            DataRowView item = (DataRowView)e.Item.DataItem;
           // string item = (string)e.Item.DataItem;

            var line = item["line"].ToString();

            DataTable dt_all = ViewState["dt_all"] as DataTable;
            
            dt_all.DefaultView.RowFilter = "line='" + line + "'";
            dt_all.DefaultView.Sort = "on_date asc";
            detail.DataSource = dt_all;
            detail.DataBind();

        }
    }

 

    protected void list_go_my_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("re_go_my");
            var item = (string)e.Item.DataItem;

            var line = item;//item["line"].ToString();

            DataTable dt_all = ViewState["dt_all"] as DataTable;
            //var dt_wk = dt_all.Clone();
            //dt_wk.Rows.Add( dt_all.Select("line='" + line + "'"));
            dt_all.DefaultView.RowFilter = "line='" + line + "' and emp_code='"+WeiXin.GetCookie("workcode")+"'";
            dt_all.DefaultView.Sort = "on_date asc";
            //string sql = @"exec [usp_app_emp_login_list_dv] '{0}','{1}'";
            //sql = string.Format(sql, _workshop, item["line"].ToString());
            //dt_wk = SQLHelper.Query(sql).Tables[0];

            detail.DataSource = dt_all;
            detail.DataBind();

        }
    }

}