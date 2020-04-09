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

            workorder.Text = _workorder;
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

        DataTable dt2 = ds.Tables[1];
        listBx_deal.DataSource = dt2;
        listBx_deal.DataBind();

        DataTable dt3 = ds.Tables[2];
        listBx_deal_a.DataSource = dt3;
        listBx_deal_a.DataBind();
    }

    [WebMethod]
    public static string init_rs(string domain)
    {
        string result = "";
        string sql = @"select rsn_code+'-'+rsn_desc as title ,rsn_code value 
                    from [172.16.5.26].[qad].[dbo].[qad_rsn_ref] 
                    where [rsn_type]='SCRAP' and rsn_domain='{0}' order by rsn_code";
        sql = string.Format(sql, domain);
        DataSet ds = SQLHelper.Query(sql);

        DataTable dt_reason = ds.Tables[0];
        string json_reason = JsonConvert.SerializeObject(dt_reason);

        result = "[{\"json_reason\":" + json_reason + "}]";
        return result;

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


    protected void btn_sure_Click(object sender, EventArgs e)
    {
        string msg = "";
       
        if (msg != "")
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('失败：" + msg + "')", true);
            return;
        }
        

    }


}

