using LitJson;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Cjgl_three : System.Web.UI.Page
{
    public string _workshop = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        _workshop = Request.QueryString["workshop"].ToString();
        bind_data();

        if (!IsPostBack)
        {
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            emp_code_name.Text = lu.WorkCode + lu.UserName;
        }
    }

    public void bind_data()
    {
        //上岗监视
        string sql = @"select count(1) app_emp from [Mes_App_EmployeeLogin] 
            where off_date is null and on_date is not null 
                and id in (select distinct login_id from Mes_App_EmployeeLogin_Location where workshop='" + _workshop + "')";
        DataTable re_dt = SQLHelper.Query(sql).Tables[0];

        Label1.Text = re_dt.Rows[0][0].ToString();
    }



}