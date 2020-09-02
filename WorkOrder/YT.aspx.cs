using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class YL : System.Web.UI.Page
{
    public string _workshop = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        _workshop = Request.QueryString["workshop"].ToString();

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

            //登入岗位的域
            string strsql_d = "select * from [Mes_App_EmployeeLogin] with(readpast) where emp_code='" + lu.WorkCode + "' and on_date is not null and off_date is null";
            var value_login = SQLHelper.reDs(strsql_d).Tables[0];
            if (value_login != null && value_login.Rows.Count > 0)
            {
                if (domain.Text == "100" || domain.Text == "")
                {
                    domain.Text = value_login.Rows[0]["domain"].ToString();
                }
            }

            lbl_emp.Text = lu.Telephone + lu.UserName;
            if (string.IsNullOrEmpty( lu.Telephone))//增加手机号的获取，因为cookIE里的手机号有可能会是空值
            {
                string strsql = "select * from [172.16.5.26].[Production].[dbo].[Hrm_Emp] with(nolock) where employeeid = '" + lu.WorkCode + "'";
                var value_rout = SQLHelper.reDs(strsql).Tables[0];
                if (value_rout != null && value_rout.Rows.Count > 0)
                {
                    lbl_emp.Text = value_rout.Rows[0]["tel"].ToString() + lu.UserName;
                }
            }


            //emp_code_name.Text = "02432何桂勤";
            //domain.Text = "200";
            //lbl_emp.Text = "15850349106何桂勤";

            //绑定岗位
            ShowValue(lu.WorkCode);
            //ShowValue("02432");
        }

    }

    public void ShowValue(string WorkCode)
    {
        //取当前登录者
        string sql = @"select id,domain from [dbo].[Mes_App_EmployeeLogin] with(readpast) where emp_code='{0}' and off_date is null";
        sql = string.Format(sql, WorkCode);
        var value = SQLHelper.reDs(sql).Tables[0];
        if (value != null && value.Rows.Count > 0)
        {
            string id = value.Rows[0]["id"].ToString();
            if (domain.Text == "100")
            {
                domain.Text = value.Rows[0]["domain"].ToString();
            }

            string strsql = "select distinct workshop,area,line,op from [dbo].Mes_App_EmployeeLogin_Location with(nolock) where login_id = '{0}'";
            strsql = string.Format(strsql, id);
            var value_rout = SQLHelper.reDs(strsql).Tables[0];

            for (int i = 0; i < value_rout.Rows.Count; i++)
            {
                lbl_location.Text += value_rout.Rows[i]["workshop"].ToString() + "/" + value_rout.Rows[i]["line"].ToString() + "/" + value_rout.Rows[i]["op"].ToString();
                if (i != value_rout.Rows.Count - 1) { lbl_location.Text += "<br />"; }
            } 
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "$('#btn_save2').hide();$.toptip('员工未上岗,请先上岗', 3000, 'warning');", true);
            return;
        }


    }

    [WebMethod]
    public static string init_yzj(string workshop, string emp, string yzj_no)
    {
        string result = "";
        string sql = @" exec [usp_app_YT_yzj_V1] '" + workshop + "','" + emp + "','" + yzj_no + "'";
        DataSet ds = SQLHelper.Query(sql);

        DataTable dt_yzj = ds.Tables[0];

        if (yzj_no == "")//初始化
        {
            string json_yzj = JsonConvert.SerializeObject(dt_yzj);
            result = "[{\"json_yzj\":" + json_yzj + "}]";
        }
        else//change
        {
            string flag = "N", msg = ""; string yzj = ""; string json_pgino = "";

            if (dt_yzj.Rows.Count != 1)
            {
                flag = "Y"; msg = "压铸机"+ yzj_no + "不存在";
            }

            DataTable dt_pgino = ds.Tables[1];
            if (dt_pgino.Rows.Count <=0)
            {
                flag = "Y"; msg = "压铸机" + yzj_no + ",对应的物料号不存在";
            }

            if (flag == "N")
            {
                yzj = dt_yzj.Rows[0]["title"].ToString();
                json_pgino = JsonConvert.SerializeObject(dt_pgino);
                result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\",\"yzj\":\"" + yzj + "\",\"json_pgino\":" + json_pgino + "}]";
            }
            else
            {
                result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\",\"yzj\":\"" + yzj + "\",\"json_pgino\":\"" + json_pgino + "\"}]";
            }
        }
        
        return result;

    }

    [WebMethod]
    public static string pgino_change(string domain, string pgino, string workshop,string mojuno)
    {
        string flag = "N", msg = "";
        string cl = "", JgSec = "", weight1 = "", need_qty_xh = "";
        string sql = @" exec [usp_app_YT_pgino_change] '" + pgino + "','" + domain + "','" + workshop + "','" + mojuno + "'";
        DataSet ds = SQLHelper.Query(sql);

        DataTable re_dt = ds.Tables[0];
        flag = re_dt.Rows[0][0].ToString();
        msg = re_dt.Rows[0][1].ToString();

        if (flag == "N")
        {
            DataTable dt = ds.Tables[1];
            cl = dt.Rows[0]["cl"].ToString();
            JgSec = dt.Rows[0]["JgSec"].ToString();
            weight1 = dt.Rows[0]["weight1"].ToString();
            need_qty_xh = dt.Rows[0]["need_qty_xh"].ToString();
        }

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\",\"cl\":\"" + cl 
            + "\",\"JgSec\":\"" + JgSec + "\",\"weight1\":\"" + weight1 + "\",\"need_qty_xh\":\"" + need_qty_xh + "\"}]";
        return result;

    }

    [WebMethod]
    public static string nd_change(string nd_jg, string yzj, string pgino, string domain, string JgSec, string weight1)
    {
        string time = "", need_qty = "";
        time = DateTime.Now.AddMinutes(Convert.ToDouble(nd_jg)).ToString("yyyy-MM-dd HH:mm");

        string sql = @" exec [usp_app_YT_nd_change] '" + time + "','" + yzj + "','" + pgino + "','" + domain + "','" + JgSec + "','" + weight1 + "'";
        DataTable dt = SQLHelper.Query(sql).Tables[0];
        if (dt.Rows.Count == 1)
        {
            need_qty = dt.Rows[0][0].ToString();
        }

        string result = "[{\"time\":\"" + time + "\",\"need_qty\":\"" + need_qty + "\"}]";
        return result;

    }

    protected bool IsNum(string text)
    {
        for (int i = 0; i < text.Length; i++)
        {
            if (!Char.IsNumber(text, i))
            {
                return true; //输入的不是数字  
            }
        }
        return false; //否则是数字

    }

    [WebMethod]
    public static string save2(string _emp_code_name, string yzj, string domain, string cl, string need_qty, string need_date, string need_date_dl
        , string JgSec, string weight1, string need_qty_xh)
    {
        string flag = "N", msg = "";

        DateTime date = DateTime.MinValue;
        bool bf = DateTime.TryParse(need_date, out date);

        if (!bf)
        {
            flag = "Y"; msg = "【送到时间】日期格式不正确";
        }


        if (flag == "N")
        {
            string re_sql = @"exec [usp_app_YT] '{0}', '{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}'";
            re_sql = string.Format(re_sql, _emp_code_name, yzj, domain, cl, need_qty, need_date, need_date_dl, JgSec, weight1, need_qty_xh);
            DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
            flag = re_dt.Rows[0][0].ToString();
            msg = re_dt.Rows[0][1].ToString();
        }

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }

   

}