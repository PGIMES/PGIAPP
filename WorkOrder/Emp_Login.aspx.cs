using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;


public partial class Emp_Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }
        if (!IsPostBack)
        {
           
            LoginUser lu = (LoginUser)WeiXin.GetUserModeCookie();
            txt_emp.Text = lu.WorkCode + lu.UserName;
            domain.Text = lu.Domain;
            ////txt_emp.Text = "02432何桂勤";
            ////domain.Text = "200";

            bind_pgino(domain.Text);
            setButton(lu.WorkCode);
        }

        
        //setButton("02432");

    }

    void bind_pgino(string domain)
    {
        string strSQL = @"select distinct pgino from Mes_App_Base_Location where domain='" + domain + "'";
        DataTable re_dt = SQLHelper.Query(strSQL).Tables[0];
        ddl_part.DataSource = re_dt;
        ddl_part.DataTextField = "pgino";
        ddl_part.DataValueField = "pgino";
        ddl_part.DataBind();

        bind_position(ddl_part.SelectedValue);
    }

    void bind_position(string pgino)
    {

        string sql = @"select location from Mes_App_Base_Location where pgino='" + pgino + "'";
        DataTable re_dt = SQLHelper.Query(sql).Tables[0];
        cbl_position.DataSource = re_dt;
        cbl_position.DataTextField = "location";
        cbl_position.DataValueField = "location";
        cbl_position.DataBind();
    }

    public void setButton(string emp_code)
    {
        //取当前登录者工号
        string sql = @"select * from Mes_App_EmployeeLogin WHERE emp_code = '{0}' AND on_date is not null and off_date IS NULL";
        sql = string.Format(sql, emp_code);
        DataTable re_dt = SQLHelper.Query(sql).Tables[0];

        if (re_dt.Rows.Count == 1)
        {
            btn_sure.Text = "离岗确认";

            ddl_part.SelectedValue = re_dt.Rows[0]["pgino"].ToString();
            txt_part.Text = re_dt.Rows[0]["pgino"].ToString();

            string location = re_dt.Rows[0]["location"].ToString();
            for (int j = 0; j < cbl_position.Items.Count; j++)
            {
                if (location.Contains(cbl_position.Items[j].Value))
                {
                    cbl_position.Items[j].Selected = true;
                }
                else
                {
                    cbl_position.Items[j].Selected = false;
                }
            }

            ddl_part.Visible = false;
            txt_part.Visible = true;

            cbl_position.Enabled = false;
        }
        else if (re_dt.Rows.Count > 1)
        {
            Response.Write("<script>alert('程序异常，员工上岗记录多笔！');window.history.back();location.reload();</script>");
        }

    }


    protected void ddl_part_TextChanged(object sender, EventArgs e)
    {
        bind_position(ddl_part.SelectedValue);
    }


    protected void btn_sure_Click(object sender, EventArgs e)
    {
       
        string Inlogin = btn_sure.Text == "离岗确认" ? "Y" : "N";
        string position = "";
        for (int j = 0; j < cbl_position.Items.Count; j++)
        {
            if (cbl_position.Items[j].Selected)
            {
                position = position + cbl_position.Items[j].Value + "|";
            }
        }
        //除去最后一个,
        if (position != "") { position = position.Substring(0, position.Length - 1); }

        string sql = @"exec usp_app_emp_login '{0}','{1}','{2}','{3}','{4}'";
        sql = string.Format(sql, Inlogin, txt_emp.Text, ddl_part.SelectedValue, position, domain.Text);

        bool i = SQLHelper.ExSql(sql);

        if (i == true)
        {
            //Response.Redirect("/Cjgl1.aspx");
            //Response.Write("<script>location.replace(\"/Cjgl1.aspx\");</script>");
            Response.Write("<script>window.location.href = '/Cjgl1.aspx';</script>");
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "alert('操作失败')", true);
        }
    }


}