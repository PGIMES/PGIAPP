using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class Off_Material : System.Web.UI.Page
{
    public string _workshop = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        //_workshop = Request.QueryString["workshop"].ToString();

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        if (!IsPostBack)
        {
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            txt_emp.Text = lu.WorkCode;
            ShowValue(txt_emp.Text);
           
        }
    }

    public void ShowValue(string WorkCode)
    {
        //取当前登录者
        string sql = @"select top 1 1  from [dbo].[Mes_App_EmployeeLogin] where emp_code='{0}' and off_date is null   ";
        sql = string.Format(sql, WorkCode);
        var value = SQLHelper.Query(sql).Tables[0];
        if (value != null && value.Rows.Count > 0)
        {
            string sql_str = @"exec usp_app_off_material_Bind_xmh '{0}','{1}'";
            sql_str = string.Format(sql_str,"", WorkCode);
            DataTable dt = SQLHelper.Query(sql_str).Tables[0];
            txt_xmh.DataSource = dt;
            txt_xmh.DataTextField = "pgino";
            txt_xmh.DataValueField = "pn";
            txt_xmh.DataBind();
            if (dt.Rows.Count > 1)
            {
                txt_xmh.Items.Insert(0, new ListItem("--请选择--", ""));
            }
            bind_gv();
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert(\"员工未上岗,请跳转至上岗页面\");window.location.href = 'Emp_Login.aspx?workshop=" + _workshop + "'", true);
            return;
        }
    }

    void bind_gv()
    {
        DataTable dt = new DataTable();

        string sql = @"exec usp_app_off_material_Bind_xmh '{0}','{1}'";
        sql = string.Format(sql, txt_xmh.SelectedItem.Text,txt_emp.Text);
        txt_pn.Text = txt_xmh.SelectedValue;
        DataTable redt = SQLHelper.Query(sql).Tables[0];
        //根据项目号取子集
        //if(txt_xmh.SelectedValue!="")
        //{ 
        //DataRow[] drs2 = redt.Select("pgino = '"+ txt_xmh.SelectedItem.Text + "' ");
        //ps_part.Text = drs2.CopyToDataTable().Rows[0]["ps_comp"].ToString();
        //}

        dt = SQLHelper.Query(sql).Tables[1];
        GridView1.DataSource = dt;
        GridView1.DataBind();
        
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        this.GridView1.PageIndex = e.NewPageIndex;
        bind_gv();
    }

 
    protected void btnsave_Click(object sender, EventArgs e)
    {
        string sql = @"exec usp_app_off_material '{0}','{1}','{2}','{3}'";
        sql = string.Format(sql, txt_dh.Text, txt_emp.Text,txt_xmh.SelectedItem.Text, txt_qty.Text);
        DataTable re_dt = SQLHelper.Query(sql).Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        if (flag == "N")
        {
            bind_gv();
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert(\"下料完成.\");$('#txt_qty').val('');", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert('" + msg + "')", true);
        }
    }




    protected void txt_xmh_SelectedIndexChanged(object sender, EventArgs e)
    {
        bind_gv();
    }
}
