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
        _workshop = Request.QueryString["workshop"].ToString();

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        if (!IsPostBack)
        {
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();

            ShowValue(lu.WorkCode);
            //ShowValue("02432");
            bind_gv();
        }
    }

    public void ShowValue(string WorkCode)
    {
        //取当前登录者
        string sql = @"select emp_code+emp_name,pgino,location from [dbo].[Mes_App_EmployeeLogin] where emp_code='{0}' and off_date is null   ";
        sql = string.Format(sql, WorkCode);
        var value = SQLHelper.Query(sql).Tables[0];
        if (value != null && value.Rows.Count > 0)
        {
            txt_emp.Text = value.Rows[0][0].ToString();
            txt_xmh.Text = value.Rows[0][1].ToString();
            txt_location.Text = value.Rows[0][2].ToString();

            string strsql = "select pt_ord_mult from [172.16.5.26].mes.dbo.qad_pt_mstr where pt_part='{0}'";
            strsql = string.Format(strsql, txt_xmh.Text);
            var value_rout = SQLHelper.Query(strsql).Tables[0];
            txt_qty.Text = value_rout.Rows[0][0].ToString();
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert(\"员工未上岗,请跳转至上岗页面\");window.location.href = 'Emp_Login.aspx'", true);
            return;
        }
    }

    void bind_gv()
    {
        DataTable dt = new DataTable();
        string sql = @"exec usp_app_off_material_gv '{0}'";
        sql = string.Format(sql, txt_xmh.Text);
        dt = SQLHelper.Query(sql).Tables[0];
        GridView1.DataSource = dt;
        GridView1.DataBind();
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        this.GridView1.PageIndex = e.NewPageIndex;
        bind_gv();
    }

    //protected void txt_qty_TextChanged(object sender, EventArgs e)
    //{
    //    string strsql = @"select lot_no as [Lot No],qty as 已上料数,qty-off_qty as 生产中,off_qty as 已下料数 from Mes_App_WorkOrder_Wip  where pgino='{0}'";
    //    strsql = string.Format(strsql, txt_xmh.Text);
    //    var value = SQLHelper.reDs(strsql).Tables[0];
    //    if (value != null && value.Rows.Count > 0)
    //    {
    //        GridView1.DataSource = value;
    //        GridView1.DataBind();
    //    }
    //    else
    //    {
    //        ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert(\"当前产品无上料数，请确认.\")", true);
    //    }
    //}

    protected void btnsave_Click(object sender, EventArgs e)
    {
        string sql = @"exec usp_app_off_material '{0}','{1}','{2}','{3}'";
        sql = string.Format(sql, txt_emp.Text, txt_location.Text, txt_xmh.Text, txt_qty.Text);
        DataTable re_dt = SQLHelper.Query(sql).Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        if (flag == "N")
        {
            bind_gv();
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "layer.alert(\"下料完成.\");$('#txt_qty').val('');", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "layer.alert('" + msg + "')", true);
        }
    }



}
