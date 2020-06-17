using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class YT_Detail_Info : System.Web.UI.Page
{
    public string _need_t_no = "";
    public DataTable dtDetail;
    protected void Page_Load(object sender, EventArgs e)
    {
        _need_t_no = Request.QueryString["need_t_no"].ToString();

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        GetData();
       
    }

    private void GetData()
    {

        string sql = string.Format("usp_app_YT_Detail_Info '{0}'", _need_t_no);
        DataSet ds = SQLHelper.Query(sql);

        dtMain.DataSource = ds.Tables[0];
        dtMain.DataBind();

        dtDetail = ds.Tables[1];
    }
}