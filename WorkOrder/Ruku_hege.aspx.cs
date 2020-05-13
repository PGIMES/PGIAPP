using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_Ruku_hege : System.Web.UI.Page
{
    public string _para_dh = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        _para_dh = Request.QueryString["para_dh"].ToString();

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>layer.alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        if (!IsPostBack)
        {
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            emp_code_name.Text = lu.WorkCode + lu.UserName;
            domain.Text = lu.Domain;

            //emp_code_name.Text = "02432何桂勤";
            //domain.Text = "200";

        }
    }
}