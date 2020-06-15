using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_ST : System.Web.UI.Page
{
    public string _workshop = "";
    public string _need_t_no = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        _workshop = Request.QueryString["workshop"].ToString();

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>layer.alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        _need_t_no = Request.QueryString["need_t_no"].ToString();

        if (!IsPostBack)
        {
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            emp_code_name.Text = lu.WorkCode + lu.UserName;
            //emp_code_name.Text = "02432何桂勤";

            need_t_no.Text = _need_t_no;
            init_data(_need_t_no);
        }
    }

    void init_data(string need_t_no)
    {
        string sql = @"exec [usp_app_ST_init] '{0}'";
        sql = string.Format(sql, need_t_no);
        DataSet ds = SQLHelper.Query(sql);

        DataTable dt = ds.Tables[0];
        listBxInfo.DataSource = dt;
        listBxInfo.DataBind();

        domain.Text = dt.Rows[0]["domain"].ToString();
        sku_area.Text = dt.Rows[0]["sku_area"].ToString();
    }

    [WebMethod]
    public static string init_zyb(string workshop, string emp)
    {
        string result = "";
        string sql = @" exec [usp_app_ST_zyb] '" + workshop + "','" + emp + "'";
        DataSet ds = SQLHelper.Query(sql);

        DataTable dt_zyb = ds.Tables[0];
        string json_zyb = JsonConvert.SerializeObject(dt_zyb);
        result = "[{\"json_zyb\":" + json_zyb + "}]";

        return result;

    }

    [WebMethod]
    public static string lotno_change(string pgino, string lotno,string need_no, string domain)
    {
        string re_sql = @"exec [usp_app_SL_lot_change_qad_V1] '{0}', '{1}', '{2}'";
        re_sql = string.Format(re_sql, pgino, lotno, need_no);
        DataSet ds = SQLHelper.Query(re_sql);

        DataTable re_dt = ds.Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        string qty = "", loc_from = "", loc_to = "", pgino_yn = "";

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\",\"qty\":\"" + qty + "\",\"loc_from\":\"" + loc_from + "\",\"loc_to\":\"" + loc_to + "\",\"pgino_yn\":\"" + pgino_yn + "\"}]";
        return result;

    }
   
    [WebMethod]
    public static string sl2(string _emp_code_name, string need_no, string lotno, string act_qty, string pgino, string pn
        , string comment, string loc_from, string loc_to, string sku_area, string pgino_yn)
    {
        string flag = "N", msg = "";

        string re_sql = @"exec [usp_app_ST] '{0}', '{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}'";
        re_sql = string.Format(re_sql, _emp_code_name, need_no, lotno, act_qty, pgino, pn, comment, loc_from, loc_to, sku_area);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        flag = re_dt.Rows[0][0].ToString();
        msg = re_dt.Rows[0][1].ToString();

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }
    [WebMethod]
    public static string cancel2(string _emp_code_name, string need_no)
    {
        string flag = "N", msg = "";

        string re_sql = @"exec [usp_app_ST_cancel] '{0}', '{1}'";
        re_sql = string.Format(re_sql, _emp_code_name, need_no);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        flag = re_dt.Rows[0][0].ToString();
        msg = re_dt.Rows[0][1].ToString();

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }


}