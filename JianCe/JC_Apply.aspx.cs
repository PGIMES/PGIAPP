using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class JC_Apply : System.Web.UI.Page
{
    public static string connString = System.Configuration.ConfigurationManager.ConnectionStrings["DBJianCe"].ConnectionString;
    public static string file = "";

    public string _id = "";
    public string _dh = "", _priority = "", _jcnr = "", _jcnr_sy = "";
    public string _stepid = "";
    public string _times_t = ""; public string _times_t_YN = ""; public string _stp_cur = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        string year = DateTime.Now.Year.ToString();
        string month = DateTime.Now.Month.ToString();
        string day = DateTime.Now.Day.ToString();

        file = Server.MapPath(@"/file/" + year + @"/" + month + @"月/" + month + "-" + day + @"白班/");

        if (Request.QueryString["id"] != null) { _id = Request.QueryString["id"].ToString(); }

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

            id.Text = _id;
            if (_id != "")
            {
                init_data(_id, connString);
            }

        }
    }

    void init_data(string id, string connString)
    {
        string sql = @"exec [usp_app_JC_Apply_init] '{0}','{1}'";
        sql = string.Format(sql, Convert.ToInt32(id), emp_code_name.Text);
        DataSet ds = SQLHelper.Query(sql, connString);

        DataTable dt = ds.Tables[0];
        if (dt.Rows.Count == 1)
        {
            _dh = dt.Rows[0]["dh"].ToString();dh.Text = _dh;
            _stepid = dt.Rows[0]["status"].ToString(); stepid.Text = _stepid;
            _stp_cur = dt.Rows[0]["stp_cur"].ToString();//1:还存在没检测完成的内容；2已全部检测完毕，等待判断结论
            _jcnr_sy = dt.Rows[0]["jcnr_sy"].ToString();
            if (_stepid == "0")
            {
                txt_dh.Text = _dh; txt_source_lot.Text = dt.Rows[0]["source_lot"].ToString();
                txt_xmh.Text = dt.Rows[0]["xmh"].ToString(); txt_ljh.Text = dt.Rows[0]["ljh"].ToString();
                txt_workshop.Text = dt.Rows[0]["workshop"].ToString(); txt_line.Text = dt.Rows[0]["line"].ToString();
                txt_sj_type.Text = dt.Rows[0]["sj_type"].ToString(); txt_op.Text = dt.Rows[0]["op"].ToString();
                txt_prod_machine.Text = dt.Rows[0]["prod_machine"].ToString(); txt_sj_qty.Text = dt.Rows[0]["sj_qty"].ToString();
                txt_remark.Value = dt.Rows[0]["remark"].ToString();
                txt_dh.Text = _dh; txt_source_lot.Text = dt.Rows[0]["source_lot"].ToString();
                _priority = dt.Rows[0]["priority"].ToString(); _jcnr = dt.Rows[0]["jcnr"].ToString();
            }
            else
            {
                _times_t = dt.Rows[0]["times_t"].ToString(); _times_t_YN = dt.Rows[0]["times_t_YN"].ToString();
            }

            listBxInfo.DataSource = dt;
            listBxInfo.DataBind();
        }

        DataTable dt_sg = ds.Tables[1];
        Repeater_sg.DataSource = dt_sg;
        Repeater_sg.DataBind();

        ViewState["dt_sg"] = dt_sg.Rows.Count.ToString();
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
    public static string lot_change(string lot, string domain)
    {
        string result = "";
        string sql = @" exec [usp_app_JC_Apply_lot_change] '" + domain + "','" + lot + "'";
        DataSet ds = SQLHelper.Query(sql, connString);

        string xmh = "", ljh = "", line = "", workshop = "";
        DataTable dt = ds.Tables[0];
        if (dt.Rows.Count > 0)
        {
            xmh = dt.Rows[0]["xmh"].ToString();
            ljh = dt.Rows[0]["pt_desc1"].ToString();
            line = dt.Rows[0]["scx"].ToString();
            workshop = dt.Rows[0]["scx_workshop"].ToString();
        }

        if (xmh == "")
        {
            DataTable ldt = new DataTable();
            string sqlStr = @"select ld_part from pub.ld_det where ld_ref='{0}' and ld_qty_oh>0 with (nolock)";
            sqlStr = string.Format(sqlStr, lot);
            ldt = QadOdbcHelper.GetODBCRows(sqlStr);
            if (ldt != null)
            {
                if (ldt.Rows.Count > 0)
                {
                    xmh = ldt.Rows[0]["ld_part"].ToString();
                }
            }
        }

        result = "[{\"xmh\":\"" + xmh + "\",\"ljh\":\"" + ljh + "\",\"line\":\"" + line + "\",\"workshop\":\"" + workshop + "\"}]";
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

        if (_option == "apply")//新建文件夹
        {
            file = file + "p" + _xmh.Substring(2, 3);
            if (!Directory.Exists(file))
            {
                Directory.CreateDirectory(file);
            }
        }

        if (_id == "") { _id = "0"; }
        string re_sql = @"exec usp_app_JC_Apply '{0}','{1}',{2},'{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}',{12},'{13}','{14}','{15}'";
        re_sql = string.Format(re_sql, _option, _emp_code_name, Convert.ToInt32(_id), _dh, _source_lot, _xmh, _ljh, _line, _workshop
                , _sj_type, _op, _prod_machine, _sj_qty, _priority, _jcnr, _remark);

        DataTable re_dt = SQLHelper.Query(re_sql, connString).Tables[0];
        flag = re_dt.Rows[0][0].ToString();
        msg = re_dt.Rows[0][1].ToString();

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }
    [WebMethod]
    public static string sign(string _emp_code_name, string _id, string _stepid, string _jcnr, string _jcsb, string _comment, string _result, string _type)
    {
        string flag = "N", msg = "";
        string re_sql = re_sql = @"exec usp_app_JC_sign '{0}',{1},'{2}','{3}','{4}','{5}','{6}','{7}'";
        re_sql = string.Format(re_sql, _emp_code_name, Convert.ToInt32(_id), _stepid, _jcnr, _jcsb, _comment, _result, _type);

        DataTable re_dt = SQLHelper.Query(re_sql,connString).Tables[0];
        flag = re_dt.Rows[0][0].ToString();
        msg = re_dt.Rows[0][1].ToString();

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }
}