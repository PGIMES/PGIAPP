using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class bhgp_Apply_wk_V1 : System.Web.UI.Page
{
    public string _workshop = "";
    public string _workorder = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        _workshop = Request.QueryString["workshop"].ToString();
        _workorder = Request.QueryString["workorder"].ToString();

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>layer.alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        if (!IsPostBack)
        {
            init_data(_workorder);
        }
        
    }

    void init_data(string workorder)
    {

        string re_sql = @"exec [usp_app_Cjgl1_V1] '{0}'";
        re_sql = string.Format(re_sql, workorder);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];

        listBxInfo.DataSource = re_dt;
        listBxInfo.DataBind();
    }
    
    
}
