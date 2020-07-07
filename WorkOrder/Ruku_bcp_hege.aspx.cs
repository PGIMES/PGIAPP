using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_Ruku_bcp_hege : System.Web.UI.Page
{
    public string _workshop = "";
    public string _dh = "";//仓库接收 扫码进来
    public string _ck = "";//仓库接收 扫码进来  上级菜单是 仓库

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["workshop"] != null) { _workshop = Request.QueryString["workshop"].ToString(); }
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
            //emp_code_name.Text = "02432何桂勤";
        }
    }

    [WebMethod]
    public static string dh_change(string dh)
    {

        string re_sql = @"exec [usp_app_Ruku_hege_workorder_change] '{0}'";
        re_sql = string.Format(re_sql, dh);
        DataSet ds = SQLHelper.Query(re_sql);

        DataTable re_dt = ds.Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        string workorder = "", domain = "", pgino = "", pn = "", qty = "", act_qty = "", phone = "", create_date = "", status_hg = "", status_date_hg = "";

        if (flag == "N")
        {
            DataTable re_dt_2 = ds.Tables[1];
            workorder = re_dt_2.Rows[0]["workorder"].ToString();
            domain = re_dt_2.Rows[0]["domain"].ToString();
            pgino = re_dt_2.Rows[0]["pgino"].ToString();
            pn = re_dt_2.Rows[0]["pn"].ToString();
            qty = re_dt_2.Rows[0]["qty"].ToString();
            act_qty = re_dt_2.Rows[0]["act_qty"].ToString();
            phone = re_dt_2.Rows[0]["phone"].ToString();
            create_date = re_dt_2.Rows[0]["create_date"].ToString();
            status_hg = re_dt_2.Rows[0]["status_hg"].ToString();
            status_date_hg = re_dt_2.Rows[0]["status_date_hg"].ToString();
        }

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg 
            + "\",\"workorder\":\"" + workorder + "\",\"domain\":\"" + domain 
            + "\",\"pgino\":\"" + pgino + "\",\"pn\":\"" + pn + "\",\"qty\":\"" + qty + "\",\"act_qty\":\"" 
            + act_qty + "\",\"phone\":\"" + phone + "\",\"create_date\":\"" + create_date 
            + "\",\"status_hg\":\"" + status_hg + "\",\"status_date_hg\":\"" + status_date_hg + "\"}]";
        return result;

    }

    [WebMethod]
    public static string dh_status(string dh, string workorder, string emp_code_name)
    {

        string re_sql = @"exec [usp_app_Ruku_hege_status] '{0}','{1}','{2}'";
        re_sql = string.Format(re_sql, dh, workorder, emp_code_name);
        DataSet ds = SQLHelper.Query(re_sql);

        DataTable re_dt = ds.Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        string status_hg = "", status_date_hg = "";

        if (flag == "N")
        {
            status_hg = re_dt.Rows[0][2].ToString();
            status_date_hg = re_dt.Rows[0][3].ToString();
        }

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg
            + "\",\"status_hg\":\"" + status_hg + "\",\"status_date_hg\":\"" + status_date_hg + "\"}]";
        return result;

    }

    protected void btnsave_Click(object sender, EventArgs e)
    {
        string re_sql = re_sql = @"exec usp_app_Ruku_hege '{0}', '{1}','{2}','{3}','{4}'";
        re_sql = string.Format(re_sql, emp_code_name.Text, dh.Text, workorder.Text, loc_hg.Text, comment.Value);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        if (flag == "N")
        {
            string url = "";
            if (_dh != "")
            {
                if (_ck == "N")//车间的
                {
                    //Response.Redirect("/Cjgl1.aspx?workshop=" + _workshop);
                    url = "/Cjgl1.aspx?workshop=" + _workshop;
                }
                if (_ck == "Y")//仓库的
                {
                    //Response.Redirect("/ck.aspx");
                    url = "/ck.aspx";
                }
            }
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess"
               , "$.toptip('入库成功', 2000, 'success');var int = self.setTimeout(function(){ self.location='" + url + "'  }, 2000); "
               , true);
            return;
        }
        else
        {
            //ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('失败：" + msg + "');", true);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('失败：" + msg + "');", true);
            return;
        }
    }

}