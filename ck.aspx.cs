using LitJson;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ck : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        bind_data();

        if (!IsPostBack)
        {
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            emp_code_name.Text = lu.WorkCode + lu.UserName;
        }
    }

    public void bind_data()
    {
        //要料监视
        DataTable dt_go = new DataTable();

        string sql = @"exec [usp_app_YL_list_new] '',''";
        dt_go = SQLHelper.Query(sql).Tables[0];

        int count_yl = dt_go.Rows.Count;
        Label1.Text = count_yl.ToString();


        //不合格监视
        //sql = @"exec [usp_app_bhgp_Apply_list_dv] '','','9998',''";
        //DataTable dt_06 = SQLHelper.Query(sql).Tables[0];
        //int count_bhg = dt_06.Rows.Count;

        sql = @"exec [usp_app_bhgp_Apply_list_dv_V1_New] '','','9998'";
        DataTable dt_98 = SQLHelper.Query(sql).Tables[0];
        int count_bhg = dt_98.Rows.Count;

        Label2.Text = count_bhg.ToString();
    }


    [WebMethod]
    public static string ckck_dh_change(string result)
    {

        string re_sql = @"exec [usp_app_ckck_dh_change] '{0}'";
        re_sql = string.Format(re_sql, result);
        DataSet ds = SQLHelper.Query(re_sql);

        string workorder = "", ruku_dh = "";

        DataTable re_dt = ds.Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        if (flag == "N")
        {
            workorder = re_dt.Rows[0][2].ToString();
            ruku_dh = re_dt.Rows[0][3].ToString();
        }

        string res = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\",\"workorder\":\"" + workorder + "\",\"ruku_dh\":\"" + ruku_dh + "\"}]";
        return res;

    }

    [WebMethod]
    public static string ruku_print_change(string result, string emp)
    {

        string re_sql = @"exec [usp_app_Ruku_Print_again] '{0}','{1}'";
        re_sql = string.Format(re_sql, result, emp);
        DataSet ds = SQLHelper.Query(re_sql);

        DataTable re_dt = ds.Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        string res = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return res;

    }
}