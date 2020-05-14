using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_CKSH : System.Web.UI.Page
{
    public string _workshop = "";
    public string _workorder_f = "";//不合格监视页面传递过来的
    public string _dh = "";//仓库接收 扫码进来
    public string _ck = "";//仓库接收 扫码进来  上级菜单是 仓库

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["workshop"] != null) { _workshop = Request.QueryString["workshop"].ToString(); }
        if (Request.QueryString["workorder_f"] != null) { _workorder_f = Request.QueryString["workorder_f"].ToString(); }
        if (Request.QueryString["dh"] != null) { _dh = Request.QueryString["dh"].ToString(); }
        if (Request.QueryString["ck"] != null) { _ck = Request.QueryString["ck"].ToString(); }

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

    [WebMethod]
    public static string workorder_f_change(string workorder_f)
    {

        string re_sql = @"select workorder_gl from Mes_App_WorkOrder_Ng_deal_Detail where  workorder_f='{0}'";
        re_sql = string.Format(re_sql, workorder_f);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        string workorder_gl = re_dt.Rows[0][0].ToString();

        string result = "[{\"workorder_gl\":\"" + workorder_gl + "\"}]";
        return result;

    }

    [WebMethod]
    public static string workorder_change(string workorder)
    {

        string re_sql = @"exec [usp_app_CKSH_workorder_change] '{0}'";
        re_sql = string.Format(re_sql, workorder);
        DataSet ds = SQLHelper.Query(re_sql);

        DataTable re_dt = ds.Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        string pgino = "", pn = "", qty = "";

        if (flag == "N")
        {
            DataTable re_dt_2 = ds.Tables[1];
            pgino = re_dt_2.Rows[0]["pgino"].ToString();
            pn = re_dt_2.Rows[0]["pn"].ToString();
            qty = re_dt_2.Rows[0]["qty"].ToString();
        }

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\",\"pgino\":\"" + pgino + "\",\"pn\":\"" + pn + "\",\"qty\":\"" + qty + "\"}]";
        return result;

    }

    protected void btnsave_Click(object sender, EventArgs e)
    {
        string re_sql = re_sql = @"exec usp_app_CKSH '{0}', '{1}','{2}','{3}','{4}','{5}','{6}'";
        re_sql = string.Format(re_sql, emp_code_name.Text, workorder.Text, pgino.Text, pn.Text, qty.Text, act_qty.Text, comment.Value);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        if (flag == "N")
        {
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('" + msg + "');$('#workorder').val('');$('#comment').val('');", true);
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "$('#workorder').val('');$('#comment').val('');$.toptip('" + msg + "', 'success');", true);
            //ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "$('#workorder').val('');$('#comment').val('');$.toptip('" + msg + "', 'success');", true);

            if (_workorder_f != "")
            {
                Response.Redirect("/workorder/bhgp_Apply_list_V1.aspx?workshop=" + _workshop);
            }
            if (_dh != "")
            {
                if (_ck == "Y")//车间的
                {
                    Response.Redirect("/Cjgl1.aspx?workshop=" + _workshop);
                }
                if (_ck == "N")//仓库的
                {
                    Response.Redirect("/ck.aspx");
                }
            }
            return;
        }
        else
        {
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('失败：" + msg + "');", true);
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('失败：" + msg + "');", true);
            return;
        }
    }

}