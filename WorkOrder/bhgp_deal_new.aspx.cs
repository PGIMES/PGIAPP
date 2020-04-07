using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_bhgp_deal_new : System.Web.UI.Page
{
    public string _workshop = "";
    public string _workorder = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        _workshop = Request.QueryString["workshop"].ToString();

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>layer.alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        _workorder = Request.QueryString["workorder"].ToString();

        if (!IsPostBack)
        {
            //LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            //emp_code_name.Text = lu.WorkCode + lu.UserName;
            //domain.Text = lu.Domain;
            emp_code_name.Text = "02432何桂勤";
            domain.Text = "200";

            workorder.Text = _workorder;
            init_data(_workorder);
        }
    }

    void init_data(string workorder)
    {
        string sql = @"exec [usp_app_bhgp_deal_init] '{0}'";
        sql = string.Format(sql, workorder);
        DataSet ds = SQLHelper.Query(sql);

        DataTable dt = ds.Tables[0];
        listBxInfo.DataSource = dt;
        listBxInfo.DataBind();
        qty.Text = dt.Rows[0]["qty"].ToString();

        DataTable dt2 = ds.Tables[1];
        listBx_deal.DataSource = dt2;
        listBx_deal.DataBind();
    }

    [WebMethod]
    public static string init_rs(string domain)
    {
        string result = "";
        string sql = @"select rsn_code+'-'+rsn_desc as title ,rsn_code value 
                    from [172.16.5.26].[qad].[dbo].[qad_rsn_ref] 
                    where [rsn_type]='SCRAP' and rsn_domain='{0}' and left(rsn_code,1) in('1','5') order by rsn_code";
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

    protected void Button1_Click(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("cz_qty", typeof(string));
        dt.Columns.Add("sy_qty", typeof(string));
        dt.Columns.Add("result", typeof(string));
        dt.Columns.Add("reason", typeof(string));
        dt.Columns.Add("comment", typeof(string));
        foreach (RepeaterItem item in listBx_deal.Items)
        {
            TextBox txt_cz_qty = (TextBox)item.FindControl("cz_qty");
            TextBox txt_sy_qty = (TextBox)item.FindControl("sy_qty");
            TextBox txt_result = (TextBox)item.FindControl("result");
            TextBox txt_reason = (TextBox)item.FindControl("reason");
            System.Web.UI.HtmlControls.HtmlTextArea txt_comment = (System.Web.UI.HtmlControls.HtmlTextArea)item.FindControl("comment");

            if (txt_cz_qty.Text.Trim() == "")
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('【处置数量】不可为空')", true);
                return;
            }
            else if (Convert.ToInt32(txt_cz_qty.Text.Trim())<=0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('【处置数量】必须大于0')", true);
                return;
            }

            if (txt_sy_qty.Text.Trim() == "")
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('【剩余数量】不可为空')", true);
                return;
            }
            else if (Convert.ToInt32(txt_sy_qty.Text.Trim()) < 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('【剩余数量】必须大于等于0')", true);
                return;
            }

            if (txt_result.Text.Trim() == "")
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('【判断为】不可为空')", true);
                return;
            }
            else if (txt_result.Text.Trim() == "不合格")
            {
                if (txt_reason.Text.Trim() == "")
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('【废品原因】不可为空')", true);
                    return;
                }
            }

            DataRow dr_s = dt.NewRow();
            dr_s["cz_qty"] = txt_cz_qty.Text.Trim();
            dr_s["sy_qty"] = txt_sy_qty.Text.Trim();
            dr_s["result"] = txt_result.Text.Trim();
            dr_s["reason"] = txt_reason.Text.Trim();
            dr_s["comment"] = txt_comment.Value.Trim();
            dt.Rows.Add(dr_s);
        }

        DataRow dr = dt.NewRow();
        dt.Rows.Add(dr);

        listBx_deal.DataSource = dt;
        listBx_deal.DataBind();
    }

   
}