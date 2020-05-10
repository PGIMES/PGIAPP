using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_bhgp_Apply_list_V1 : System.Web.UI.Page
{
    public string _workshop = "";
    public string _workcode = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        _workshop = Request.QueryString["workshop"].ToString();

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
        _workcode = lu.WorkCode;
        GetData(_workcode);

        //_workcode = "02432";
        //GetData("02432");
    }

    private void GetData(string emp)
    {
        DataTable dt_06 = new DataTable();

        string sql = @"exec [usp_app_bhgp_Apply_list_dv_V1_New] '{0}','{1}'";
        sql = string.Format(sql, _workshop, emp);
        DataSet ds = SQLHelper.Query(sql);

        DataTable dt_01 = ds.Tables[0]; DataTable dt_02 = ds.Tables[0]; DataTable dt_03 = ds.Tables[0];
        DataTable dt_04 = ds.Tables[0]; DataTable dt_05 = ds.Tables[0]; DataTable dt_98 = ds.Tables[0];
        DataTable dt_99 = ds.Tables[0];

        DataTable dt_01_my = ds.Tables[1]; DataTable dt_02_my = ds.Tables[1]; DataTable dt_03_my = ds.Tables[1];
        DataTable dt_04_my = ds.Tables[1]; DataTable dt_05_my = ds.Tables[1]; DataTable dt_98_my = ds.Tables[1];
        DataTable dt_99_my = ds.Tables[1];

        dt_01.DefaultView.RowFilter = "stepid='0001'"; dt_02.DefaultView.RowFilter = "stepid='0002'";
        dt_03.DefaultView.RowFilter = "stepid='0003'"; dt_04.DefaultView.RowFilter = "stepid='0004'";
        dt_05.DefaultView.RowFilter = "stepid='0005'"; dt_98.DefaultView.RowFilter = "stepid='9998'";
        dt_99.DefaultView.RowFilter = "stepid='9999'";

        dt_01_my.DefaultView.RowFilter = "stepid='0001'"; dt_02_my.DefaultView.RowFilter = "stepid='0002'";
        dt_03_my.DefaultView.RowFilter = "stepid='0003'"; dt_04_my.DefaultView.RowFilter = "stepid='0004'";
        dt_05_my.DefaultView.RowFilter = "stepid='0005'"; dt_98_my.DefaultView.RowFilter = "stepid='9998'";
        dt_99_my.DefaultView.RowFilter = "stepid='9999'";

        list_01.DataSource = dt_01; list_01.DataBind(); Label_01.Text = "(" + dt_01.Rows.Count + ")";
        list_02.DataSource = dt_02; list_02.DataBind(); Label_02.Text = "(" + dt_02.Rows.Count + ")";
        list_03.DataSource = dt_03; list_03.DataBind(); Label_03.Text = "(" + dt_03.Rows.Count + ")";
        list_04.DataSource = dt_04; list_04.DataBind(); Label_04.Text = "(" + dt_04.Rows.Count + ")";
        list_05.DataSource = dt_05; list_05.DataBind(); Label_05.Text = "(" + dt_05.Rows.Count + ")";
        list_98.DataSource = dt_99; list_98.DataBind(); Label_98.Text = "(" + dt_98.Rows.Count + ")";
        list_99.DataSource = dt_99; list_99.DataBind(); Label_99.Text = "(" + dt_99.Rows.Count + ")";

        list_01_my.DataSource = dt_01_my; list_01_my.DataBind(); Label_01_my.Text = "(" + dt_01_my.Rows.Count + ")";
        list_02_my.DataSource = dt_02_my; list_02_my.DataBind(); Label_02_my.Text = "(" + dt_02_my.Rows.Count + ")";
        list_03_my.DataSource = dt_03_my; list_03_my.DataBind(); Label_03_my.Text = "(" + dt_03_my.Rows.Count + ")";
        list_04_my.DataSource = dt_04_my; list_04_my.DataBind(); Label_04_my.Text = "(" + dt_04_my.Rows.Count + ")";
        list_05_my.DataSource = dt_05_my; list_05_my.DataBind(); Label_05_my.Text = "(" + dt_05_my.Rows.Count + ")";
        list_98_my.DataSource = dt_99_my; list_98_my.DataBind(); Label_98_my.Text = "(" + dt_98_my.Rows.Count + ")";
        list_99_my.DataSource = dt_99_my; list_99_my.DataBind(); Label_99_my.Text = "(" + dt_99_my.Rows.Count + ")";

    }
    
}