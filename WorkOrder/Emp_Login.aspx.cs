using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Services;

public partial class Emp_Login : System.Web.UI.Page
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
            txt_emp.Text = lu.WorkCode + lu.UserName;
            domain.Text = lu.Domain;

            //txt_emp.Text = "02432何桂勤";
            //domain.Text = "200";

            setButton();

            ViewState["emp_login_sb"] = null;

            timestamp = DateTime.Now.Ticks.ToString().Substring(0, 10);
            noncestr = new Random().Next(10000).ToString();
            uri = Request.Url.ToString().Replace("#", "").Replace(WeiXin.Port, ""); //本地地址                
            string entAccessTicket = WeiXin.GetEntAccessToken();//企业AccessTicket
            ent_ticket = WeiXin.GetEntJsapi_Ticket(entAccessTicket);
            ent_signature = WeiXin.GetSignature(ent_ticket, noncestr, timestamp, uri);//企业签名
        }

    }


    public void setButton()
    {
        //取当前登录者工号
        string sql = @"select * from Mes_App_EmployeeLogin WHERE emp_code = '{0}' AND on_date is not null and off_date IS NULL";
        sql = string.Format(sql, txt_emp.Text.Substring(0, 5));
        DataTable re_dt = SQLHelper.Query(sql).Tables[0];

        if (re_dt.Rows.Count == 1)
        {
            btn_sure.Text = "离岗确认";
            bind_gv();
        }
        else if (re_dt.Rows.Count > 1)
        {
            Response.Write("<script>layer.alert('程序异常，员工上岗记录多笔！');window.history.back();location.reload();</script>");
        }

    }

    public void bind_gv()
    {
        DataTable dt = new DataTable();

        if (btn_sure.Text == "离岗确认")
        {
            string sql = @"exec usp_app_emp_login_gv '{0}'";
            sql = string.Format(sql, txt_emp.Text.Substring(0, 5));
            dt = SQLHelper.Query(sql).Tables[0];
        }
        else
        {
            dt = (DataTable)ViewState["emp_login_sb"];
        }

        GridView1.Columns[0].Visible = true;
        GridView1.DataSource = dt;
        GridView1.DataBind();
        GridView1.Columns[0].Visible = false;
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        this.GridView1.PageIndex = e.NewPageIndex;
        bind_gv();
    }

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        DataTable dt = (DataTable)ViewState["emp_login_sb"];
        for (int i = dt.Rows.Count - 1; i >= 0; i--)
        {
            if (GridView1.DataKeys[e.RowIndex].Value.ToString() == dt.Rows[i]["id"].ToString()) { dt.Rows.RemoveAt(i); }
        }
        
        ViewState["emp_login_sb"] = dt;
        bind_gv();
    }

    public void sbcode_change()
    {
        string sb_code = e_code.Text;
        string sql = @"select distinct top 1 location from [Mes_App_Base_Location] WHERE e_code = '{0}' ";
        sql = string.Format(sql, sb_code);
        DataTable re_dt = SQLHelper.Query(sql).Tables[0];
        if (re_dt.Rows.Count <= 0)
        {
            e_code.Text = "";
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('【设备】不存在')", true);
            return;
        }
        string location = re_dt.Rows[0][0].ToString();

        DataTable dt = (DataTable)ViewState["emp_login_sb"];
        if (dt == null)
        {
            dt = new DataTable();
            dt.Columns.Add("id", typeof(Int32));
            dt.Columns.Add("e_code", typeof(string));
            dt.Columns.Add("location", typeof(string));
        }
        DataRow dr = dt.NewRow();
        dr["id"] = dt.Rows.Count <= 0 ? 1 : Convert.ToInt32(dt.Rows[dt.Rows.Count - 1]["id"]) + 1;
        dr["e_code"] = sb_code;
        dr["location"] = location;

        dt.Rows.Add(dr);
        ViewState["emp_login_sb"] = dt;
        e_code.Text = "";

        bind_gv();
    }

    protected void btn_bind_data_Click(object sender, EventArgs e)
    {
        sbcode_change();
    }
    protected void btn_sure_Click(object sender, EventArgs e)
    {
        if (GridView1.Rows.Count <= 0)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('【当前岗位】不可为空')", true);
            return;
        }

        string Inlogin = btn_sure.Text == "离岗确认" ? "Y" : "N";
        string e_codes = "", location = "";
        if (Inlogin == "N")//上岗保存
        {
            DataTable dt = (DataTable)ViewState["emp_login_sb"];
            for (int j = 0; j < GridView1.Rows.Count; j++)
            {
                e_codes = e_codes + dt.Rows[j]["e_code"] + "|";
                location = location + dt.Rows[j]["location"] + "|";
            }
            //除去最后一个|
            e_codes = e_codes.Substring(0, e_codes.Length - 1);
            location = location.Substring(0, location.Length - 1);
        }
       

        string sql = @"exec usp_app_emp_login_new '{0}','{1}','{2}','{3}','{4}'";
        sql = string.Format(sql, Inlogin, txt_emp.Text, e_codes, location, domain.Text);

        bool i = SQLHelper.ExSql(sql);

        if (i == true)
        {
            //Response.Redirect("/Cjgl1.aspx");
            //Response.Write("<script>location.replace(\"/Cjgl1.aspx\");</script>");
            Response.Write("<script>window.location.href = '/workshop.aspx';</script>");
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('操作失败')", true);
        }
    }



}
