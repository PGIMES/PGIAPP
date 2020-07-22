using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_Ruku_bcp_list_ck : System.Web.UI.Page
{
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
        string sql = @"exec [usp_app_Ruku_bcp_list_ck]";
        DataSet ds = SQLHelper.Query(sql);
        DataTable dt_data = ds.Tables[0];


        ViewState["dt_data"] = dt_data;
    }
}