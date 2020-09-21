using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class prod_wip_detail_V1 : System.Web.UI.Page
{
    public string _workshop = "";
    public string _lotno = "";
    public string _needno = "";
    public string _para = "";
    public string _emp = "";//当前登入
    public string _btn = "";

    public DataTable dt_dtl;

    protected void Page_Load(object sender, EventArgs e)
    {
        _lotno = Request.QueryString["lotno"].ToString();
        _para = Request.QueryString["para"].ToString();
        if (Request.QueryString["workshop"] != null) { _workshop = Request.QueryString["workshop"].ToString(); }
        if (Request.QueryString["needno"] != null) { _needno = Request.QueryString["needno"].ToString(); }

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
        _emp = lu.WorkCode + lu.UserName;
        //_emp = "02432何桂勤";

        GetData(_lotno, lu.WorkCode);
       
    }

    private void GetData(string _lotno, string emp_code)
    {
        string sql_re = @"select count(1) from [dbo].[Mes_App_EmployeeLogin] a  with(nolock) 
                        inner join [Mes_App_EmployeeLogin_Location] b  with(nolock) on a.id=b.login_id 
	                    inner join [172.16.5.26].[Production].[dbo].[Hrm_Emp] c  with(nolock) on a.emp_code=c.EMPLOYEEID
                    where emp_code='" + emp_code + "' and off_date is null and (b.e_code like 'G%' or c.dept_name='IT部')";
        DataTable re_dt = SQLHelper.Query(sql_re).Tables[0];
        if (Convert.ToInt32(re_dt.Rows[0][0].ToString()) > 0)
        {
            _btn = "Y";
        }

        string sql = string.Format(@"exec [usp_app_prod_wip_" + (_workshop == "三车间" ? "YZ_" : "") + "detail_V1] '{0}'", _lotno);
        DataSet ds  = SQLHelper.Query(sql);

        dtMain.DataSource = ds.Tables[0];
        dtMain.DataBind();

        string _wip_qty = "0";
        if (ds.Tables[0].Rows.Count == 1)
        {
            _wip_qty = ds.Tables[0].Rows[0]["wip_qty"].ToString();
        }
        wip_qty.Text = _wip_qty;

     dt_dtl = ds.Tables[1]; 
    }

    [WebMethod]
    public static string Reject_Sku(string emp, string needno, string lotno, string reject_qty, string source, string reject_where)
    {
        string result = "";

        string re_sql = @"exec [usp_app_Reject] '{0}','{1}','{2}',{3},'{4}','{5}'";
        re_sql = string.Format(re_sql, emp, needno, lotno, Convert.ToSingle(reject_qty == "" ? "0" : reject_qty), source, reject_where);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }
}