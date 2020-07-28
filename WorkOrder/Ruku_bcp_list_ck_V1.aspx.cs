using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_Ruku_bcp_list_ck_V1 : System.Web.UI.Page
{
    public DataTable dt_line;
    public DataTable dt_pgino;
    public DataTable dt_detail;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }
        //入库完成24小时
        BindData5();
    }

    private void BindData5()
    {
        string sql = @"exec [usp_app_Ruku_bcp_list_ck_V1]";
        DataSet ds = SQLHelper.Query(sql);

        dt_line = ds.Tables[0];
        dt_pgino = ds.Tables[1];
        dt_detail = ds.Tables[2];
    }
}