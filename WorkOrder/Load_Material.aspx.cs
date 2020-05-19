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
        string re_sql = @"exec [usp_app_load_material_load_data] '{0}','{1}','{2}'";
        re_sql = string.Format(re_sql, _lotno, _needno, _para);
        DataSet ds = SQLHelper.Query(re_sql);

        DataTable dt0 = ds.Tables[0];
        listBxInfo_YL.DataSource = dt0;
        listBxInfo_YL.DataBind();

        DataTable dt1 = ds.Tables[1];
        listBxInfo_SL.DataSource = dt1;
        listBxInfo_SL.DataBind();

        DataTable dt2 = ds.Tables[2];
        listBxInfo_LL.DataSource = dt2;
        listBxInfo_LL.DataBind();

        DataTable dt3 = ds.Tables[3];
        listBxInfo_TL.DataSource = dt3;
        listBxInfo_TL.DataBind();

        ViewState["dt2"] = dt2.Rows.Count.ToString();
        ViewState["dt3"] = dt3.Rows.Count.ToString();
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

    protected void btnsave_Click(object sender, EventArgs e)
    {

        
        string sqlstr = @"select emp_code+emp_name,pgino,location,id from [dbo].[Mes_App_EmployeeLogin] where emp_code='{0}' and off_date is null";
        sqlstr = string.Format(sqlstr, emp_code_name.Text);
        var dt = SQLHelper.reDs(sqlstr).Tables[0];
        if (dt.Rows.Count <= 0)
        {

            ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert(\"员工未上岗,请跳转至上岗页面\");window.location.href = 'Emp_Login.aspx?workshop=" + _workshop + "'", true);
            return;
        }

        string sql = @"exec usp_app_load_material_Insert_tz '{0}','{1}','{2}','{3}'";
        sql = string.Format(sql, emp_code_name.Text, _lotno, _needno, _para);
        var value = SQLHelper.reDs(sql).Tables[0];

        if (value != null && value.Rows.Count > 0)
        {
            if (value.Rows[0][0].ToString() == "Y")
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert(\"上料完成.\");window.location.href = 'YL_List_new.aspx?workshop=" + _workshop + "'", true);

            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert(\"失败，请重新提交.\")", true);
            }
        }
    }

}
