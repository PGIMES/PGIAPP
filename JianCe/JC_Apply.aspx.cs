using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class JC_Apply : System.Web.UI.Page
{
    public static string connString = System.Configuration.ConfigurationManager.ConnectionStrings["DBJianCe"].ConnectionString;

    public string _dh = "";
    public string _stepid = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["dh"] != null) { _dh = Request.QueryString["dh"].ToString(); }

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>layer.alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }
        if (!IsPostBack)
        {
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            emp_code_name.Text = lu.WorkCode + lu.UserName;
            domain.Text = lu.Domain;
            //emp_code_name.Text = "02432何桂勤";
            domain.Text = "200";

            dh.Text = _dh;

            if (_dh != "")
            {
                init_data(_dh,connString);
            }

        }
    }

    void init_data(string dh, string connString)
    {
        //string sql = @"exec [usp_app_Jiaju_Apply_init] '{0}','{1}'";
        //sql = string.Format(sql, dh, emp_code_name.Text);
        //DataSet ds = SQLHelper.Query(sql,connString);

        //DataTable dt = ds.Tables[0];
        //if (dt.Rows.Count == 1)
        //{
        //    id.Text = dt.Rows[0]["id"].ToString();
        //    _stepid = dt.Rows[0]["status"].ToString(); stepid.Text = _stepid;
        //    _times_t = dt.Rows[0]["times_t"].ToString(); _times_t_YN = dt.Rows[0]["times_t_YN"].ToString();
        //    listBxInfo.DataSource = dt;
        //    listBxInfo.DataBind();

        //    if (_stepid == "2")//检测结果确认，默认带出，上一步的 检测结果
        //    {
        //        ng_ok_2.Text = ds.Tables[1].Rows[ds.Tables[1].Rows.Count - 1]["ng_ok"].ToString();
        //        _sign_2_YN = dt.Rows[0]["sign_2_YN"].ToString();
        //    }
        //}

        //DataTable dt_sg = ds.Tables[1];
        //Repeater_sg.DataSource = dt_sg;
        //Repeater_sg.DataBind();

        //ViewState["dt_sg"] = dt_sg.Rows.Count.ToString();
    }

    [WebMethod]
    public static string init_data_js(string domain, string emp)
    {
        string result = "";
        string sql = @" exec [usp_app_JC_Apply_init_data_js] '" + domain + "','" + emp + "'";
        DataSet ds = SQLHelper.Query(sql, connString);

        DataTable dt_pgino = ds.Tables[0];
        string json_pgino = JsonConvert.SerializeObject(dt_pgino);

        DataTable dt_sj_type = ds.Tables[1];
        string json_sj_type = JsonConvert.SerializeObject(dt_sj_type);

        DataTable dt_jcnr = ds.Tables[2];
        string json_jcnr = JsonConvert.SerializeObject(dt_jcnr);

        result = "[{\"json_pgino\":" + json_pgino + ",\"json_sj_type\":" + json_sj_type + ",\"json_jcnr\":" + json_jcnr + "}]";
        return result;

    }
    [WebMethod]
    public static string pgino_change(string pgino, string sj_type, string domain)
    {
        string result = "";
        string sql = @" exec [usp_app_JC_Apply_pgino_change] '" + domain + "','" + pgino + "','" + sj_type + "'";
        DataSet ds = SQLHelper.Query(sql, connString);

        string ljh = "", line = "", workshop = "";
        DataTable dt = ds.Tables[0];
        if (dt.Rows.Count > 0)
        {
            ljh = dt.Rows[0]["pt_desc1"].ToString();
            line = dt.Rows[0]["scx"].ToString();
            workshop = dt.Rows[0]["scx_workshop"].ToString();
        }

        DataTable dt_op = ds.Tables[1];
        string json_op = JsonConvert.SerializeObject(dt_op);

        result = "[{\"ljh\":\"" + ljh + "\",\"line\":\"" + line + "\",\"workshop\":\"" + workshop + "\",\"json_op\":" + json_op + "}]";
        return result;

    }
    [WebMethod]
    public static string op_change(string pgino, string sj_type, string op, string domain)
    {
        string result = "";
        string sql = @" exec [usp_app_JC_Apply_op_change] '" + domain + "','" + pgino + "','" + sj_type + "','" + op + "'";
        DataSet ds = SQLHelper.Query(sql, connString);

        DataTable dt_jcnr = ds.Tables[0];
        string json_jcnr = JsonConvert.SerializeObject(dt_jcnr);

        result = "[{\"json_jcnr\":" + json_jcnr + "}]";
        return result;

    }
    [WebMethod]
    public static string save(string _option, string _emp_code_name, string _id, string _dh, string _source_lot, string _xmh
        , string _ljh, string _line, string _workshop, string _sj_type, string _op, string _prod_machine, string _sj_qty
        , string _priority, string _jcnr, string _remark)
    {
        string flag = "N", msg = "";
        string re_sql = @"exec usp_app_JC_Apply '{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}','{13}','{14}','{15}'";
        re_sql = string.Format(re_sql, _option, _emp_code_name, _id, _dh, _source_lot, _xmh, _ljh, _line, _workshop
                , _sj_type, _op, _prod_machine, _sj_qty, _priority, _jcnr, _remark);

        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        flag = re_dt.Rows[0][0].ToString();
        msg = re_dt.Rows[0][1].ToString();

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }
}