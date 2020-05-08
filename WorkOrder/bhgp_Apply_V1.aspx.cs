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

public partial class bhgp_Apply_V1 : System.Web.UI.Page
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
            //LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            //emp_code_name.Text = lu.WorkCode + lu.UserName;
            //domain.Text = lu.Domain;

            emp_code_name.Text = "02432何桂勤";
            domain.Text = "200";

            init_data(workorder.Text, workorder_f.Text);
        }
        
    }

    void init_data(string workorder, string workorder_f)
    {

        string sql = @"exec [usp_app_bhgp_Apply_init_V1] '{0}','{1}'";
        sql = string.Format(sql, workorder, workorder_f);
        DataSet ds = SQLHelper.Query(sql);

        DataTable dt = ds.Tables[0];
        listBxInfo.DataSource = dt;
        listBxInfo.DataBind();

        if (dt.Rows.Count == 1)
        {
            cur_qty.Text = dt.Rows[0]["cur_qty"].ToString();
            ng_reason_main.Text = dt.Rows[0]["reason_code"].ToString();
            ng_reason_desc_main.Text = dt.Rows[0]["reason"].ToString();
            workorder_qc.Text = dt.Rows[0]["workorder_qc"].ToString();
        }       

        DataTable dt1 = ds.Tables[1];
        Repeater_cz_one.DataSource = dt1;
        Repeater_cz_one.DataBind();

        DataTable dt2 = ds.Tables[2];
        Repeater_fg.DataSource = dt2;
        Repeater_fg.DataBind();

        DataTable dt3 = ds.Tables[3];
        Repeater_cz_again.DataSource = dt3;
        Repeater_cz_again.DataBind();

        DataTable dt4 = ds.Tables[4];
        Repeater_fx.DataSource = dt4;
        Repeater_fx.DataBind();

        DataTable dt5 = ds.Tables[5];
        Repeater_cz_fx_again.DataSource = dt5;
        Repeater_cz_fx_again.DataBind();

        DataTable dt6 = ds.Tables[6];
        listBx_deal.DataSource = dt6;
        listBx_deal.DataBind();

        ViewState["dt1"] = dt1.Rows.Count.ToString();
        ViewState["dt2"] = dt2.Rows.Count.ToString();
        ViewState["dt3"] = dt3.Rows.Count.ToString();
        ViewState["dt4"] = dt4.Rows.Count.ToString();
        ViewState["dt5"] = dt5.Rows.Count.ToString();
    }

    [WebMethod]
    public static string init_pgino(string domain,string workshop,string emp)
    {
        string result = "";
        string sql = @" exec [usp_app_bhgp_Apply_pgino_V1] '" + domain + "','" + workshop + "','" + emp + "'";
        DataSet ds = SQLHelper.Query(sql);

        DataTable dt = ds.Tables[0];
        string json = JsonConvert.SerializeObject(dt);

        DataTable dt_reason = ds.Tables[1];
        string json_reason = JsonConvert.SerializeObject(dt_reason);

        result = "[{\"json\":" + json + ",\"json_reason\":" + json_reason + "}]";
        return result;

    }

    [WebMethod]
    public static string pgino_change(string pgino)
    {

        string re_sql = @"exec [usp_app_bhgp_Apply_pgino_change_V1] '{0}'";
        re_sql = string.Format(re_sql, pgino);
        DataSet ds = SQLHelper.Query(re_sql);

        string pn = "", descr = "", b_use_routing = "";
        DataTable re_dt = ds.Tables[0];
        pn = re_dt.Rows[0][0].ToString();
        descr = re_dt.Rows[0][1].ToString();
        b_use_routing = re_dt.Rows[0][2].ToString();

        DataTable dt_op = ds.Tables[1];
        string json_op = JsonConvert.SerializeObject(dt_op);

        string result = "[{\"pn\":\"" + pn + "\",\"descr\":\"" + descr + "\",\"b_use_routing\":\"" + b_use_routing + "\",\"json_op\":" + json_op + "}]";
        return result;

    }

    [WebMethod]
    public static string init_rs(string domain,string workshop)
    {
        string result = "";
        string sql = @"";
        if (workshop=="一车间" || workshop == "二车间" || workshop == "四车间")
        {
            sql = @"select rsn_code+'-'+rsn_desc as title ,rsn_code value 
                    from [172.16.5.26].[qad].[dbo].[qad_rsn_ref] 
                    where left(rsn_code,1) in('3','5') and rsn_domain='{0}' order by rsn_code";//[rsn_type]='SCRAP'
        }
        //else if (workshop == "三车间")
        //{
        //    sql = @"select rsn_code+'-'+rsn_desc as title ,rsn_code value 
        //            from [172.16.5.26].[qad].[dbo].[qad_rsn_ref] 
        //            where left(rsn_code,1) in('1','5') and rsn_domain='{0}' order by rsn_code";
        //}
        sql = string.Format(sql, domain);
        DataSet ds = SQLHelper.Query(sql);

        DataTable dt_reason = ds.Tables[0];
        string json_reason = JsonConvert.SerializeObject(dt_reason);

        result = "[{\"json_reason\":" + json_reason + "}]";
        return result;

    }

    [WebMethod]
    public static string rs_data(string domain, string rscode)
    {
        string result = "";
        string sql = @"select rsn_code+'-'+rsn_desc as title ,rsn_code value 
                    from [172.16.5.26].[qad].[dbo].[qad_rsn_ref] 
                    where rsn_domain='{0}' and rsn_code='{1}' order by rsn_code";
        sql = string.Format(sql, domain, rscode);
        DataTable dt_reason = SQLHelper.Query(sql).Tables[0];

        string title = "";
        if (dt_reason.Rows.Count == 1)
        {
            title = dt_reason.Rows[0]["title"].ToString();
        }

        result = "[{\"title\":\"" + title + "\"}]";
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

    protected void Repeater_cz_one_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView item = (DataRowView)e.Item.DataItem;

            Repeater detail = (Repeater)e.Item.FindControl("Repeater_cz_one_dt");
            DataTable dt_wk = new DataTable();
            string sql = @"select * from Mes_App_WorkOrder_Ng_deal_Detail where workorder_f='{0}' order by num";
            sql = string.Format(sql, item["workorder_f"].ToString());
            dt_wk = SQLHelper.Query(sql).Tables[0];

            detail.DataSource = dt_wk;
            detail.DataBind();

            Repeater detail_sg = (Repeater)e.Item.FindControl("Repeater_sg_one_dt");
            DataTable dt_wk_sg = new DataTable();
            string sql_sg = @"exec [usp_app_bhgp_sign_record] '{0}'";
            sql_sg = string.Format(sql_sg, item["workorder_f"].ToString());
            dt_wk_sg = SQLHelper.Query(sql_sg).Tables[0];

            detail_sg.DataSource = dt_wk_sg;
            detail_sg.DataBind();
        }
    }


    protected void Repeater_fg_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView item = (DataRowView)e.Item.DataItem;

            Repeater detail = (Repeater)e.Item.FindControl("Repeater_fg_dt");
            DataTable dt_wk = new DataTable();
            string sql = @"select * from Mes_App_WorkOrder_Ng_deal_Detail where workorder_f='{0}' order by num";
            sql = string.Format(sql, item["workorder_f"].ToString());
            dt_wk = SQLHelper.Query(sql).Tables[0];

            detail.DataSource = dt_wk;
            detail.DataBind();

            Repeater detail_sg = (Repeater)e.Item.FindControl("Repeater_fg_sg_dt");
            DataTable dt_wk_sg = new DataTable();
            string sql_sg = @"exec [usp_app_bhgp_sign_record] '{0}','返工'";
            sql_sg = string.Format(sql_sg, item["workorder_f"].ToString());
            dt_wk_sg = SQLHelper.Query(sql_sg).Tables[0];

            detail_sg.DataSource = dt_wk_sg;
            detail_sg.DataBind();
        }
    }

    protected void Repeater_cz_again_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView item = (DataRowView)e.Item.DataItem;

            Repeater detail = (Repeater)e.Item.FindControl("Repeater_cz_again_dt");
            DataTable dt_wk = new DataTable();
            string sql = @"select * from Mes_App_WorkOrder_Ng_deal_Detail where workorder_f='{0}' order by num";
            sql = string.Format(sql, item["workorder_f"].ToString());
            dt_wk = SQLHelper.Query(sql).Tables[0];

            detail.DataSource = dt_wk;
            detail.DataBind();

            Repeater detail_sg = (Repeater)e.Item.FindControl("Repeater_sg_again_dt");
            DataTable dt_wk_sg = new DataTable();
            string sql_sg = @"exec [usp_app_bhgp_sign_record] '{0}'";
            sql_sg = string.Format(sql_sg, item["workorder_f"].ToString());
            dt_wk_sg = SQLHelper.Query(sql_sg).Tables[0];

            detail_sg.DataSource = dt_wk_sg;
            detail_sg.DataBind();
        }
    }


    protected void Repeater_fx_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView item = (DataRowView)e.Item.DataItem;

            Repeater detail = (Repeater)e.Item.FindControl("Repeater_fx_dt");
            DataTable dt_wk = new DataTable();
            string sql = @"select * from Mes_App_WorkOrder_Ng_deal_Detail where workorder_f='{0}' order by num";
            sql = string.Format(sql, item["workorder_f"].ToString());
            dt_wk = SQLHelper.Query(sql).Tables[0];

            detail.DataSource = dt_wk;
            detail.DataBind();

            Repeater detail_sg = (Repeater)e.Item.FindControl("Repeater_fx_sg_dt");
            DataTable dt_wk_sg = new DataTable();
            string sql_sg = @"exec [usp_app_bhgp_sign_record] '{0}','分选'";
            sql_sg = string.Format(sql_sg, item["workorder_f"].ToString());
            dt_wk_sg = SQLHelper.Query(sql_sg).Tables[0];

            detail_sg.DataSource = dt_wk_sg;
            detail_sg.DataBind();
        }
    }

    protected void Repeater_cz_fx_again_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView item = (DataRowView)e.Item.DataItem;

            Repeater detail = (Repeater)e.Item.FindControl("Repeater_cz_fx_again_dt");
            DataTable dt_wk = new DataTable();
            string sql = @"select * from Mes_App_WorkOrder_Ng_deal_Detail where workorder_f='{0}' order by num";
            sql = string.Format(sql, item["workorder_f"].ToString());
            dt_wk = SQLHelper.Query(sql).Tables[0];

            detail.DataSource = dt_wk;
            detail.DataBind();

            Repeater detail_sg = (Repeater)e.Item.FindControl("Repeater_sg_fx_again_dt");
            DataTable dt_wk_sg = new DataTable();
            string sql_sg = @"exec [usp_app_bhgp_sign_record] '{0}'";
            sql_sg = string.Format(sql_sg, item["workorder_f"].ToString());
            dt_wk_sg = SQLHelper.Query(sql_sg).Tables[0];

            detail_sg.DataSource = dt_wk_sg;
            detail_sg.DataBind();
        }
    }

    protected void btnsave_Click(object sender, EventArgs e)
    {

        string _op = op.Text;
        string _b_use_routing = b_use_routing.Text;

        int op_code = Convert.ToInt32(_op.Substring(0, _op.IndexOf('-')));
        string re_sql = "";
        if (op_code < 600 || _b_use_routing == "0")
        {
            re_sql = @"exec usp_app_bhgp_Apply_V1 '{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}'";

        }
        else if (op_code >= 600 && op_code <= 700)
        {
            re_sql = @"exec usp_app_bhgp_Apply_QC_V1 '{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}'";
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('【开发中.....】')", true);
            return;
        }

        re_sql = string.Format(re_sql, emp_code_name.Text, workorder.Text, pgino.Text, pn.Text, descr.Text, op.Text
            , qty.Text, reason.Text, comment.Value, _b_use_routing, ref_order.Text);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        if (flag == "N")
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('" + msg + "')", true);
            Response.Redirect("/workorder/bhgp_Apply_list.aspx?workshop=" + _workshop);
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('失败：" + msg + "')", true);
        }
    }
    
    public DataTable Get_Repeat_cz(out string msg)
    {
        msg = "";

        DataTable dt = new DataTable();
        dt.Columns.Add("num", typeof(int));
        dt.Columns.Add("cz_qty", typeof(string));
        dt.Columns.Add("sy_qty", typeof(string));
        dt.Columns.Add("result", typeof(string));
        dt.Columns.Add("reason", typeof(string));
        dt.Columns.Add("comment", typeof(string));
        dt.Columns.Add("workorder_gl", typeof(string));

        int i = 0; string msg_row = "";
        foreach (RepeaterItem item in listBx_deal.Items)
        {
            TextBox txt_num = (TextBox)item.FindControl("num");
            TextBox txt_cz_qty = (TextBox)item.FindControl("cz_qty");
            TextBox txt_result = (TextBox)item.FindControl("result");
            TextBox txt_rscode = (TextBox)item.FindControl("rscode");
            TextBox txt_reason = (TextBox)item.FindControl("reason");
            TextBox txt_workorder_gl = (TextBox)item.FindControl("workorder_gl");
            System.Web.UI.HtmlControls.HtmlTextArea txt_comment = (System.Web.UI.HtmlControls.HtmlTextArea)item.FindControl("comment");

            if (txt_cz_qty.Text.Trim() == "")
            {
                msg_row += "第" + (i + 1).ToString() + "组【处置数量】不可为空 <br />";
            }
            else if (Convert.ToInt32(txt_cz_qty.Text.Trim()) <= 0)
            {
                msg_row += "第" + (i + 1).ToString() + "组【处置数量】必须大于0 <br />";
            }
            if (txt_result.Text.Trim() == "")
            {
                msg_row += "第" + (i + 1).ToString() + "组【判断为】不可为空 <br />";
            }
            else if (txt_result.Text.Trim() == "不合格")
            {
                if (txt_reason.Text.Trim() == "")
                {
                    msg_row += "第" + (i + 1).ToString() + "组【废品原因】不可为空 <br />";
                }
                else
                {
                    if (txt_rscode.Text.Trim() != "") {
                        var _reason = txt_reason.Text.Trim().Substring(0, txt_reason.Text.Trim().IndexOf('-'));
                        if (_reason != txt_rscode.Text.Trim()) {
                            msg_row += "第" + (i + 1).ToString() + "组【原因名称】与【代码】不匹配 <br />";
                        }
                    }
                }
            }
            //if (txt_workorder_gl.Text.Trim() == "")
            //{
            //    msg_row += "第" + (i + 1).ToString() + "组【关联单号】不可为空 <br />";
            //}

            if (msg_row == "")//此行正确，添加到datatable
            {
                DataRow dr_s = dt.NewRow();
                dr_s["num"] = txt_num.Text;
                dr_s["cz_qty"] = txt_cz_qty.Text.Trim();
                dr_s["sy_qty"] = "0";
                dr_s["result"] = txt_result.Text.Trim();
                dr_s["reason"] = txt_reason.Text.Trim();
                dr_s["comment"] = txt_comment.Value.Trim();
                dr_s["workorder_gl"] = txt_workorder_gl.Text.Trim();
                dt.Rows.Add(dr_s);
            }

            msg += msg_row;//累计msg信息
            i++; msg_row = "";
        }

        return dt;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        string msg = "";
        DataTable dt = new DataTable();
        dt = Get_Repeat_cz(out msg);
        if (msg != "")
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('" + msg + "')", true);
            return;
        }

        //=================================add 一空行
        DataRow dr = dt.NewRow();
        dr["num"] = dt.Rows.Count + 1;
        dt.Rows.Add(dr);

        listBx_deal.DataSource = dt;
        listBx_deal.DataBind();
    }

    protected void btn_sure_Click(object sender, EventArgs e)
    {
        btn_sure.Text = "正在处置中。。。。"; btn_sure.Enabled = false;

        string msg = "";
        DataTable dt = new DataTable();
        dt = Get_Repeat_cz(out msg);
        if (msg != "")
        {
            btn_sure.Text = "处置"; btn_sure.Enabled = true;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('" + msg + "')", true);
            return;
        }
        //要做数量的检查，特别是在事务提交之前
        //=================================处理数据
        try
        {
            bhgp_Apply_V1_Class bdn = new bhgp_Apply_V1_Class();
            DataTable re_dt = bdn.save_data(dt, workorder.Text, workorder_f.Text, emp_code_name.Text, ref_order.Text);

            string flag = re_dt.Rows[0][0].ToString();
            string msg_f = re_dt.Rows[0][1].ToString();
            if (flag == "N")
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('" + msg_f + "')", true);
                Response.Redirect("/workorder/bhgp_Apply_list.aspx?workshop=" + _workshop);
            }
            else
            {
                btn_sure.Text = "处置"; btn_sure.Enabled = true;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('" + msg_f + "')", true);
            }
        }
        catch (Exception ex)
        {
            btn_sure.Text = "处置"; btn_sure.Enabled = true;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('处置异常：" + ex.Message + "')", true);
        }

    }
}


public class bhgp_Apply_V1_Class
{
    public bhgp_Apply_V1_Class()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }
    SQLHelper SQLHelper = new SQLHelper();

    public DataTable save_data(DataTable dt, string workorder, string workorder_f, string emp_code_name, string workorder_qc)
    {
        SqlParameter[] param = new SqlParameter[]
      {
            new SqlParameter("@dt",dt),
            new SqlParameter("@workorder",workorder),
            new SqlParameter("@workorder_f",workorder_f),
            new SqlParameter("@emp",emp_code_name),
            new SqlParameter("@workorder_qc",workorder_qc)
      };
        return SQLHelper.GetDataTable("usp_app_bhgp_deal_V1", param);

    }
}