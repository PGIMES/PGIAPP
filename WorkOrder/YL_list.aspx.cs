using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_YL_list : System.Web.UI.Page
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
        DataTable dt_go = new DataTable();
        DataTable dt_complete = new DataTable();

        string sql = @"exec [usp_app_YL_list] ''";
        dt_go = SQLHelper.Query(sql).Tables[0];
        dt_complete = SQLHelper.Query(sql).Tables[1];

        DataList1.DataSource = dt_go;
        DataList1.DataBind();
        Label1.Text = Label1.Text + "(" + dt_go.Rows.Count + ")";

        DataList2.DataSource = dt_complete;
        DataList2.DataBind();
        Label2.Text = Label2.Text + "(" + dt_complete.Rows.Count + ")";

    }
}