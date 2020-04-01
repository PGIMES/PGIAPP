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

    //定义对象
    public string timestamp;//签名的时间戳
    public string noncestr;//签名的随机串
    public string ent_signature;//企业签名        
    public string ent_ticket;//企业的jsapi_ticket         
    public string uri;//url

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
            txt_emp.Text = lu.Telephone + lu.UserName;

            //emp_code_name.Text = "02432何桂勤";
            //domain.Text = "200";
            //txt_emp.Text = "15850349106何桂勤";

            //绑定岗位
            ShowValue(lu.WorkCode);
            //ShowValue("02432");

            timestamp = DateTime.Now.Ticks.ToString().Substring(0, 10);
            noncestr = new Random().Next(10000).ToString();
            uri = Request.Url.AbsoluteUri.ToString().Replace("#", "").Replace(WeiXin.Port, ""); //本地地址                
            string entAccessTicket = WeiXin.GetEntAccessToken();//企业AccessTicket
            ent_ticket = WeiXin.GetEntJsapi_Ticket(entAccessTicket);
            ent_signature = WeiXin.GetSignature(ent_ticket, noncestr, timestamp, uri);//企业签名
        }

    }

    public void ShowValue(string WorkCode)
    {
        //取当前登录者
        string sql = @"select id from [dbo].[Mes_App_EmployeeLogin] where emp_code='{0}' and off_date is null";
        sql = string.Format(sql, WorkCode);
        var value = SQLHelper.reDs(sql).Tables[0];
        if (value != null && value.Rows.Count > 0)
        {
            string id = value.Rows[0][0].ToString();

            string strsql = "select * from [dbo].Mes_App_EmployeeLogin_Location where login_id = '{0}'";
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

            ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "layer.alert(\"员工未上岗,请跳转至上岗页面\");window.location.href = 'Emp_Login.aspx?workshop=" + _workshop + "'", true);
            return;
        }


    }


    [WebMethod]
    public static string pgino_change(string pgino)
    {

        string re_sql = @"exec [usp_app_YL_pgino_change] '{0}'";
        re_sql = string.Format(re_sql, pgino);
        DataSet ds = SQLHelper.Query(re_sql);

        DataTable re_dt = ds.Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        string pn = "", descr = "",qty = "";
        if (flag == "N")
        {
            DataTable dt = ds.Tables[1];
            pn = dt.Rows[0]["pt_desc1"].ToString();
            descr = dt.Rows[0]["pt_desc2"].ToString();
            qty = dt.Rows[0]["pt_ord_mult"].ToString();
        }

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\",\"pn\":\"" + pn + "\",\"descr\":\"" + descr + "\",\"qty\":\"" + qty + "\"}]";
        return result;

    }

    [WebMethod]
    public static string nd_change(string nd_jg)
    {
        string time = "";
        time = DateTime.Now.AddMinutes(Convert.ToDouble(nd_jg)).ToString("yyyy-MM-dd HH:mm");

        string result = "[{\"time\":\"" + time + "\"}]";
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

    protected void btnsave_Click(object sender, EventArgs e)
    {
        DateTime date = DateTime.MinValue;
        bool bf = DateTime.TryParse(need_date.Text, out date);

        if (!bf)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('【送到时间】日期格式不正确')", true);
            return;
        }

        if (IsNum(need_qty.Text))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('【要料数量】格式不正确')", true);
            return;
        }
        else if(Convert.ToInt32(need_qty.Text)<=0)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('【要料数量】必须大于0')", true);
            return;
        }

        string re_sql = @"exec [usp_app_YL] '{0}', '{1}','{2}','{3}','{4}','{5}','{6}'";
        re_sql = string.Format(re_sql, emp_code_name.Text, pgino.Text, domain.Text, pn.Text, descr.Text, need_qty.Text, need_date.Text);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        if (flag == "N")
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('" + msg + "');", true);
            Response.Redirect("/workorder/YL_list_new.aspx?workshop=" + _workshop);
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('失败：" + msg + "')", true);
        }

    }
}