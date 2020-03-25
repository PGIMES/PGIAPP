using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_SL : System.Web.UI.Page
{
    public string _need_no = "";

    protected void Page_Load(object sender, EventArgs e)
    {

        //if (WeiXin.GetCookie("workcode") == null)
        //{
        //    Response.Write("<script>layer.alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
        //    return;
        //}

        _need_no = Request.QueryString["need_no"].ToString();

        if (!IsPostBack)
        {
            //LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            //emp_code_name.Text = lu.WorkCode + lu.UserName;
            emp_code_name.Text = "02432何桂勤";


            need_no.Text = _need_no;
            init_data(_need_no);
        }
    }

    void init_data(string need_no)
    {
        //string sql = @"select * from Mes_App_WorkOrder_Ng where status<>1 and workorder='{0}'";
        //sql = string.Format(sql, need_no);
        //DataTable dt = SQLHelper.Query(sql).Tables[0];
        //pgino.Text = dt.Rows[0]["pgino"].ToString();
        //source.Text = dt.Rows[0]["source"].ToString();
        //op.Text = dt.Rows[0]["op"].ToString();
        //qty.Text = dt.Rows[0]["qty"].ToString();//处置数量
        //off_qty.Text = dt.Rows[0]["off_qty"].ToString();//处置数量
    }

    protected void btn_sl_Click(object sender, EventArgs e)
    {

    }

    protected void btn_cancel_Click(object sender, EventArgs e)
    {

    }

}