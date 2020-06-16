using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_Chuku : System.Web.UI.Page
{
    public string _workorder = "";
    public string _ruku_dh = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        _workorder = Request.QueryString["workorder"].ToString();
        _ruku_dh = Request.QueryString["ruku_dh"].ToString();

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>layer.alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        if (!IsPostBack)
        {
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            emp_code_name.Text = lu.WorkCode + lu.UserName;
            //emp_code_name.Text = "02432何桂勤";

            emp.Text = emp_code_name.Text;
            time.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm");
        }
    }

    [WebMethod]
    public static string workorder_change(string workorder)
    {

        string re_sql = @"exec [usp_app_Chuku_workorder_change_V1] '{0}'";
        re_sql = string.Format(re_sql, workorder);
        DataSet ds = SQLHelper.Query(re_sql);

        DataTable re_dt = ds.Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        string domain = "", pgino = "", pn = "";

        if (flag == "N")
        {
            DataTable re_dt_2 = ds.Tables[1];
            domain = re_dt_2.Rows[0]["domain"].ToString();
            pgino = re_dt_2.Rows[0]["pgino"].ToString();
            pn = re_dt_2.Rows[0]["pn"].ToString();
        }

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\",\"domain\":\"" + domain + "\",\"pgino\":\"" + pgino + "\",\"pn\":\"" + pn + "\"}]";
        return result;

    }

    [WebMethod]
    public static string reason_change(string workorder, string ruku_dh, string reason)
    {

        string re_sql = @"exec [usp_app_Chuku_reason_change] '{0}','{1}','{2}'";
        re_sql = string.Format(re_sql, workorder, ruku_dh, reason);
        DataSet ds = SQLHelper.Query(re_sql);

        DataTable re_dt = ds.Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        string domain = "", pgino = "", pn = "", qty = "";

        if (flag == "N")
        {
            DataTable re_dt_2 = ds.Tables[1];
            domain = re_dt_2.Rows[0]["domain"].ToString();
            pgino = re_dt_2.Rows[0]["pgino"].ToString();
            pn = re_dt_2.Rows[0]["pn"].ToString();
            qty = re_dt_2.Rows[0]["qty"].ToString();
        }

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\",\"domain\":\"" + domain + "\",\"pgino\":\"" + pgino + "\",\"pn\":\"" + pn + "\",\"qty\":\"" + qty + "\"}]";
        return result;

    }

    protected void btnsave_Click(object sender, EventArgs e)
    {
        string re_sql = re_sql = @"exec usp_app_Chuku '{0}', '{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}'";
        re_sql = string.Format(re_sql, emp_code_name.Text, workorder.Text, ruku_dh.Text, domain.Text, pgino.Text, pn.Text, qty.Text, act_qty.Text, comment.Value, reason.Text);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        if (flag == "N")
        {
            string url = "/ck.aspx";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess"
                , "layer.alert('出库成功,出库单号" + msg + "', {}, function (index) {window.location.href='" + url + "'; }); "
                , true);
            return;
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('失败：" + msg + "');", true);
            return;
        }
    }

}