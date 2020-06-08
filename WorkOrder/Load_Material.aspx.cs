using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Maticsoft.DBUtility;

public partial class Load_Material : System.Web.UI.Page
{
    public string _workshop = "";
    public string _lotno = "";
    public string _needno = "";
    public string _para = "";
    public string _emp = "";
    public DataTable dt_infor;

    protected void Page_Load(object sender, EventArgs e)
    {
        _workshop = Request.QueryString["workshop"].ToString();
        _lotno = Request.QueryString["lotno"].ToString();
        _needno= Request.QueryString["need_no"].ToString();
        _para = Request.QueryString["para"].ToString();

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>layer.alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }


        if (!IsPostBack)
        {
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            _emp = lu.WorkCode + lu.UserName;
            emp_code_name.Text = lu.WorkCode;

            load_data();
        }
    }

    void load_data()
    {
        string re_sql = @"exec [usp_app_load_material_load_data_V1] '{0}','{1}','{2}'";
        re_sql = string.Format(re_sql, _lotno, _needno, _para);
        DataSet ds = SQLHelper.Query(re_sql);

        DataTable dt0 = ds.Tables[0];
        listBxInfo_YL.DataSource = dt0;
        listBxInfo_YL.DataBind();

        dt_infor = ds.Tables[1];
    }


    [WebMethod]
    public static string Set_Lotno(string lotno, string needno, string para, string emp)
    {

        string result = "";
        string re_sql = @"exec [usp_app_load_material_lotno_change_V1] '{0}','{1}','{2}','{3}'";
        re_sql = string.Format(re_sql, lotno, needno, para, emp);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        result = Newtonsoft.Json.JsonConvert.SerializeObject(re_dt);

        return result;
    }


    [WebMethod]
    public static string Reject_Sku(string emp, string needno, string lotno, string reject_qty, string source)
    {
        string result = "";

        string re_sql = @"exec [usp_app_Reject] '{0}','{1}','{2}',{3},'{4}'";
        re_sql = string.Format(re_sql, emp, needno, lotno, Convert.ToSingle(reject_qty == "" ? "0" : reject_qty), source);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }

    [WebMethod]
    public static string Save_Sku(string emp, string needno, string lotno, string para)
    {
        string result = "";
        string flag = "", msg = "";

        string sqlstr = @"select emp_code+emp_name,pgino,location,id from [dbo].[Mes_App_EmployeeLogin] where emp_code='{0}' and off_date is null";
        sqlstr = string.Format(sqlstr, emp);
        var dt = SQLHelper.reDs(sqlstr).Tables[0];
        if (dt.Rows.Count <= 0)
        {
            flag = "Y1";
            msg = "员工未上岗,请跳转至上岗页面";
            result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
            return result;
        }

        string re_sql = @"exec usp_app_load_material_Insert_tz '{0}','{1}','{2}','{3}'";
        re_sql = string.Format(re_sql, emp, needno, lotno, para);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        if (re_dt.Rows.Count == 1)
        {
            flag = re_dt.Rows[0][0].ToString();
            msg = re_dt.Rows[0][1].ToString();
        }

        result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }

}
