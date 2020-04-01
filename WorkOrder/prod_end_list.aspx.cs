using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class prod_end_list : System.Web.UI.Page
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

        string sql = string.Format(@"exec [usp_app_prod_end_list] '{0}'", WeiXin.GetCookie("workcode"));
        dt_part = SQLHelper.Query(sql).Tables[0];
        dt_complete = SQLHelper.Query(sql).Tables[1];

        dt_part_my = SQLHelper.Query(sql).Tables[2];
        dt_complete_my = SQLHelper.Query(sql).Tables[3];
        //生产完成工单
        DataList1.DataSource = dt_part;
        DataList1.DataBind();
        Label1.Text = "(" + dt_part.Rows.Count + ")";

        DataList2.DataSource = dt_complete;
        DataList2.DataBind();
        Label2.Text = "(" + dt_complete.Rows.Count + ")";

        // 我的工单
        DataList3.DataSource = dt_part_my;
        DataList3.DataBind();
        Label3.Text =  "(" + dt_part_my.Rows.Count + ")";

        DataList4.DataSource = dt_complete_my;
        DataList4.DataBind();
        Label4.Text = "(" + dt_complete_my.Rows.Count + ")";
    }
}