using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_YL_list : System.Web.UI.Page
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


        GetData();
       
    }

    private void GetData()
    {
        DataTable dt_go = new DataTable();
        DataTable dt_complete_bf = new DataTable();
        DataTable dt_complete = new DataTable();

        string sql = @"exec [usp_app_YL_list] '{0}'";
        sql = string.Format(sql, _workshop);
        dt_go = SQLHelper.Query(sql).Tables[0];
        dt_complete_bf = SQLHelper.Query(sql).Tables[1];
        dt_complete = SQLHelper.Query(sql).Tables[2];

        DataList1.DataSource = dt_go;
        DataList1.DataBind();
        Label1.Text = Label1.Text + "(" + dt_go.Rows.Count + ")";

        DataList2.DataSource = dt_complete_bf;
        DataList2.DataBind();
        Label2.Text = Label2.Text + "(" + dt_complete_bf.Rows.Count + ")";

        DataList3.DataSource = dt_complete;
        DataList3.DataBind();
        Label3.Text = Label3.Text + "(" + dt_complete.Rows.Count + ")";

    }
}