using LitJson;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Cjgl1 : System.Web.UI.Page
{
    public string _workshop = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        _workshop = Request.QueryString["workshop"].ToString();
        bind_data();
    }

    public void bind_data()
    {
        //上岗监视
        string sql = @"select count(1) app_emp from [Mes_App_EmployeeLogin] 
            where off_date is null and on_date is not null 
                and id in (select distinct login_id from Mes_App_EmployeeLogin_Location where workshop='" + _workshop + "')";
        DataTable re_dt = SQLHelper.Query(sql).Tables[0];
        Label1.Text = "(" + re_dt.Rows[0][0].ToString() + ")";

        //要料监视
        DataTable dt_go = new DataTable();
        DataTable dt_wc = new DataTable();
        DataTable dt_rj = new DataTable();

        sql = @"exec [usp_app_YL_list_new] '"+ _workshop + "',''";
        dt_go = SQLHelper.Query(sql).Tables[0];
        dt_wc = SQLHelper.Query(sql).Tables[1];
        dt_rj = SQLHelper.Query(sql).Tables[2];

        int count_yl = dt_go.Rows.Count + dt_wc.Rows.Count + dt_rj.Rows.Count;

        Label2.Text = "(" + count_yl.ToString() + ")";


        //不合格监视
        sql = @"exec [usp_app_bhgp_Apply_list_dv] '"+ _workshop + "','','0001',''";
        DataTable dt_01 = SQLHelper.Query(sql).Tables[0];
        sql = @"exec [usp_app_bhgp_Apply_list_dv] '" + _workshop + "','','0002',''";
        DataTable dt_02 = SQLHelper.Query(sql).Tables[0];
        sql = @"exec [usp_app_bhgp_Apply_list_dv] '" + _workshop + "','','0003',''";
        DataTable dt_03 = SQLHelper.Query(sql).Tables[0];
        sql = @"exec [usp_app_bhgp_Apply_list_dv] '" + _workshop + "','','0004',''";
        DataTable dt_04 = SQLHelper.Query(sql).Tables[0];
        sql = @"exec [usp_app_bhgp_Apply_list_dv] '" + _workshop + "','','0005',''";
        DataTable dt_05 = SQLHelper.Query(sql).Tables[0];

        int count_bhg = dt_01.Rows.Count + dt_02.Rows.Count + dt_03.Rows.Count + dt_04.Rows.Count + dt_05.Rows.Count;

        Label3.Text = "(" + count_bhg.ToString() + ")";
    }
}