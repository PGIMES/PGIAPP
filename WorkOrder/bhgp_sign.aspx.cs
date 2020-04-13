using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_bhgp_sign : System.Web.UI.Page
{
    public string _workshop = "";
    public string _workorder = "";
    public string _workorder_f = "";
    public string _stepid = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        _workshop = Request.QueryString["workshop"].ToString();

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>layer.alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        _workorder = Request.QueryString["workorder"].ToString();
        _workorder_f = Request.QueryString["workorder_f"].ToString();
        _stepid = Request.QueryString["stepid"].ToString();

        if (!IsPostBack)
        {
            //LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            //emp_code_name.Text = lu.WorkCode + lu.UserName;
            //domain.Text = lu.Domain;
            emp_code_name.Text = "02432何桂勤";
            domain.Text = "200";

            workorder.Text = _workorder; workorder_f.Text = _workorder_f; stepid.Text = _stepid;
            init_data(_workorder, _workorder_f);
        }
    }

    void init_data(string workorder,string workorder_f)
    {
        string sql = @"exec [usp_app_bhgp_deal_sign_init] '{0}','{1}'";
        sql = string.Format(sql, workorder, _workorder_f);
        DataSet ds = SQLHelper.Query(sql);

        DataTable dt = ds.Tables[0];
        listBxInfo.DataSource = dt;
        listBxInfo.DataBind();

        DataTable dt1 = ds.Tables[1];
        Repeater_cz.DataSource = dt1;
        Repeater_cz.DataBind();
    }

    protected void listBxInfo_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("listBx_lotno");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = new DataTable();
            string sql = @"select id,lot_no,qty,workorder from Mes_App_WorkOrder_Ng_Detail where workorder='{0}' order by id";
            sql = string.Format(sql, item["workorder"].ToString());
            dt_wk = SQLHelper.Query(sql).Tables[0];

            detail.DataSource = dt_wk;
            detail.DataBind();
        }
    }
    protected void Repeater_cz_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("Repeater_cz_dt");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = new DataTable();
            string sql = @"select * from Mes_App_WorkOrder_Ng_deal_Detail where workorder_f='{0}' order by num";
            sql = string.Format(sql, item["workorder_f"].ToString());
            dt_wk = SQLHelper.Query(sql).Tables[0];

            detail.DataSource = dt_wk;
            detail.DataBind();
        }
    }

    protected void btn_sure_Click(object sender, EventArgs e)
    {
        string _fg_comment = "";
        if (_stepid == "0001")//需返工
        {
            _fg_comment = fg_comment.Value.Trim();
            if (_fg_comment == "")
            {
                ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('【返工说明】不可为空')", true);
                return;
            }
        }

        string re_sql = @"exec [usp_app_bhgp_sign] '{0}', '{1}','{2}','{3}','{4}'";
        re_sql = string.Format(re_sql, emp_code_name.Text, workorder.Text, workorder_f.Text, stepid.Text, _fg_comment);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        if (flag == "N")
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('" + msg + "');", true);
            Response.Redirect("/workorder/bhgp_Apply_list.aspx?workshop=" + _workshop);
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('失败：" + msg + "')", true);
        }


    }

    protected void btn_cancel_Click(object sender, EventArgs e)
    {
        string re_sql = @"exec [usp_app_bhgp_sign_cancel] '{0}', '{1}','{2}','{3}'";
        re_sql = string.Format(re_sql, emp_code_name.Text, workorder.Text, workorder_f.Text, stepid.Text);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        if (flag == "N")
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('" + msg + "');", true);
            Response.Redirect("/workorder/bhgp_Apply_list.aspx?workshop=" + _workshop);
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('失败：" + msg + "')", true);
        }

    }
}

