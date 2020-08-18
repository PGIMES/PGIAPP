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
        //bind_data();

        if (!IsPostBack)
        {
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            emp_code_name.Text = lu.WorkCode + lu.UserName;
        }
    }

    public void bind_data()
    {
        /*
        //要料监视
        DataTable dt_go = new DataTable();

        string sql = @"exec [usp_app_YL_list_new] '',''";
        dt_go = SQLHelper.Query(sql).Tables[0];

        int count_yl = dt_go.Rows.Count;
        Label1.Text = count_yl.ToString();
        */

        /*
        //不合格监视
        sql = @"exec [usp_app_bhgp_Apply_list_dv_V1_New] '','','','Y'";
        DataSet ds = SQLHelper.Query(sql);
        DataTable dt_01 = ds.Tables[0]; DataTable dt_02 = ds.Tables[1]; DataTable dt_03 = ds.Tables[2];
        DataTable dt_04 = ds.Tables[3]; DataTable dt_05 = ds.Tables[4]; DataTable dt_98 = ds.Tables[5];
        DataTable dt_99 = ds.Tables[6];
        int count_bhg = dt_02.Rows.Count + dt_03.Rows.Count + dt_04.Rows.Count + dt_05.Rows.Count + dt_98.Rows.Count;

        //Label3.Text = count_bhg.ToString();
        Label3_V1.Text = count_bhg.ToString();
        Label3_V1_f.Text = dt_01.Rows.Count.ToString();
        Label3_V1_e.Text = dt_99.Rows.Count.ToString();
        */
    }

    [WebMethod]
    public static string auth(string emp)
    {
        string re_sql = @"exec [usp_app_ck_auth] '{0}'";
        re_sql = string.Format(re_sql, emp);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];

        string flag = re_dt.Rows[0][0].ToString();
        string res = "[{\"flag\":\"" + flag + "\"}]";
        return res;

    }

    [WebMethod]
    public static string yl_Data()
    {
        string go = "0", end = "0", wc_rj = "0";

        string sql = @"exec [usp_app_YL_list_ck_V1]";
        DataSet ds = SQLHelper.Query(sql);

        DataTable dt_go_2 = ds.Tables[0]; DataTable dt_wc_2 = ds.Tables[1]; DataTable dt_rj_2 = ds.Tables[2]; DataTable dt_end_2 = ds.Tables[3];
        DataTable dt_go_3 = ds.Tables[4]; DataTable dt_wc_3 = ds.Tables[5]; DataTable dt_rj_3 = ds.Tables[6]; DataTable dt_end_3 = ds.Tables[7];
        DataTable dt_go_4 = ds.Tables[8]; DataTable dt_wc_4 = ds.Tables[9]; DataTable dt_rj_4 = ds.Tables[10]; DataTable dt_end_4 = ds.Tables[11];

        //要料中
        go= (dt_go_2.Rows.Count + dt_go_3.Rows.Count + dt_go_4.Rows.Count).ToString();

        //要料完成
        end = (dt_end_2.Rows.Count + dt_end_3.Rows.Count + dt_end_4.Rows.Count).ToString();

        //已送料，已退料
        wc_rj = (dt_wc_2.Rows.Count + dt_wc_3.Rows.Count + dt_wc_4.Rows.Count
            + dt_rj_2.Rows.Count + dt_rj_3.Rows.Count + dt_rj_4.Rows.Count).ToString();

        string res = "[{\"go\":\"" + go + "\",\"end\":\"" + end + "\",\"wc_rj\":\"" + wc_rj + "\"}]";
        return res;

    }

    [WebMethod]
    public static string ruku_Data()
    {
        string go = "0", end = "0", go_bhg = "0", end_bhg = "0";

        //待入库
        string sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}", "二车间", WeiXin.GetCookie("workcode"), 4);
        DataTable dt_data_2 = SQLHelper.Query(sql).Tables[0];

        sql = sql = string.Format(@"exec [usp_app_YZ_monitor] '{0}','{1}',{2}", "三车间", WeiXin.GetCookie("workcode"), 4);
        DataTable dt_data_3 = SQLHelper.Query(sql).Tables[0];

        sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}", "四车间", WeiXin.GetCookie("workcode"), 4);
        DataTable dt_data_4 = SQLHelper.Query(sql).Tables[0];

        go = (dt_data_2.Rows.Count + dt_data_3.Rows.Count + dt_data_4.Rows.Count).ToString();

        //入库完成
        sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}", "二车间", WeiXin.GetCookie("workcode"), 5);
        DataTable dt_data_end_2 = SQLHelper.Query(sql).Tables[0];

        sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}", "三车间", WeiXin.GetCookie("workcode"), 5);
        DataTable dt_data_end_3 = SQLHelper.Query(sql).Tables[0];

        sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}", "四车间", WeiXin.GetCookie("workcode"), 5);
        DataTable dt_data_end_4 = SQLHelper.Query(sql).Tables[0];

        end = (dt_data_end_2.Rows.Count + dt_data_end_3.Rows.Count + dt_data_end_4.Rows.Count).ToString();

        //不合格
        sql = @"exec [usp_app_bhgp_Apply_list_dv_V1_New] '','','','ruku'";
        DataSet ds = SQLHelper.Query(sql);
        DataTable dt_98_2 = ds.Tables[0]; DataTable dt_98_3 = ds.Tables[1]; DataTable dt_98_4 = ds.Tables[2];
        DataTable dt_99_2 = ds.Tables[3]; DataTable dt_99_3 = ds.Tables[4]; DataTable dt_99_4 = ds.Tables[5];

        //不合格待入库
        go_bhg = (dt_98_2.Rows.Count + dt_98_3.Rows.Count + dt_98_4.Rows.Count).ToString();
        //不合格已入库
        end_bhg = (dt_99_2.Rows.Count + dt_99_3.Rows.Count + dt_99_4.Rows.Count).ToString();

        string res = "[{\"go\":\"" + go + "\",\"end\":\"" + end + "\",\"go_bhg\":\"" + go_bhg + "\",\"end_bhg\":\"" + end_bhg + "\"}]";
        return res;

    }

    [WebMethod]
    public static string bcp_Data()
    {
        string gs = "0", ts = "0", ss = "0";

        string sql = @"exec [usp_app_Ruku_bcp_list_ck_V1]";
        DataTable dt_bcp = SQLHelper.Query(sql).Tables[3];

        gs = dt_bcp.Rows[0]["sum_cps"].ToString();
        ts = dt_bcp.Rows[0]["sum_ts"].ToString();
        ss = dt_bcp.Rows[0]["avg_hhs"].ToString();

        string res = "[{\"gs\":\"" + gs + "\",\"ts\":\"" + ts + "\",\"ss\":\"" + ss + "\"}]";
        return res;

    }

    [WebMethod]
    public static string cp_Data()
    {
        string gs = "0", ts = "0", ss = "0";

        string sql = @"exec [usp_app_Ruku_cp_list_ck]";
        DataTable dt_cp = SQLHelper.Query(sql).Tables[3];

        gs = dt_cp.Rows[0]["sum_cps"].ToString();
        ts = dt_cp.Rows[0]["sum_ts"].ToString();
        ss = dt_cp.Rows[0]["avg_days"].ToString();

        string res = "[{\"gs\":\"" + gs + "\",\"ts\":\"" + ts + "\",\"ss\":\"" + ss + "\"}]";
        return res;

    }
    /// <summary>
    /// 原材料 标注
    /// </summary>
    /// <returns></returns>
    [WebMethod]
    public static string ycl_Data()
    {
        string gs = "0", ts = "0", ss = "0";

        string sql = @"exec [usp_app_Ruku_YCL_list_ck]";
        DataTable dt_cp = SQLHelper.Query(sql).Tables[3];

        gs = dt_cp.Rows[0]["sum_cps"].ToString();
        ts = dt_cp.Rows[0]["sum_ts"].ToString();
        ss = dt_cp.Rows[0]["avg_hhs"].ToString();

        string res = "[{\"gs\":\"" + gs + "\",\"ts\":\"" + ts + "\",\"ss\":\"" + ss + "\"}]";
        return res;

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