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

public partial class bhgp_Apply : System.Web.UI.Page
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

            init_data();
        }
        
    }

    void init_data()
    {
        string sql = @"exec [usp_app_bhgp_Apply_deal_init]";
        DataSet ds = SQLHelper.Query(sql);

        DataTable dt = ds.Tables[0];
        listBx_deal.DataSource = dt;
        listBx_deal.DataBind();

    }

    [WebMethod]
    public static string init_pgino(string domain,string workshop)
    {
        string result = "";
        string sql = @" exec [usp_app_bhgp_Apply_pgino] '" + domain + "','" + workshop + "'";
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

        string re_sql = @"exec [usp_app_bhgp_Apply_pgino_change] '{0}'";
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

    protected void btnsave_Click(object sender, EventArgs e)
    {

        string _op = op.Text;
        string _b_use_routing = b_use_routing.Text;

        int op_code = Convert.ToInt32(_op.Substring(0, _op.IndexOf('-')));
        string re_sql = "";
        if (op_code < 600 || _b_use_routing == "0")
        {
            re_sql = @"exec usp_app_bhgp_Apply '{0}', '{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}'";

        }
        else if (op_code >= 600 && op_code <= 700)
        {
            //re_sql = @"exec usp_app_bhgp_Apply_QC '{0}', '{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}'";
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('【开发中.....】')", true);
            return;
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('【开发中.....】')", true);
            return;
        }

        re_sql = string.Format(re_sql, emp_code_name.Text, workorder.Text, pgino.Text, pn.Text, descr.Text, op.Text
            , qty.Text, reason.Text, comment.Value, _b_use_routing);
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
            }
            if (txt_workorder_gl.Text.Trim() == "")
            {
                msg_row += "第" + (i + 1).ToString() + "组【关联单号】不可为空 <br />";
            }

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

        //=================================处理数据
        try
        {
            bhgp_Apply_Class bdn = new bhgp_Apply_Class();

            string _op = op.Text;
            string _b_use_routing_two = b_use_routing_two.Text;

            int op_code = Convert.ToInt32(_op.Substring(0, _op.IndexOf('-')));
            string re_flag = "";
            if (op_code < 600 || _b_use_routing_two == "0")
            {
                re_flag = "1";

            }
            else if (op_code >= 600 && op_code <= 700)
            {
                re_flag = "2";
                ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('【开发中.....】')", true);
                return;
            }
            else
            {
                re_flag = "3";
                ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('【开发中.....】')", true);
                return;
            }

            DataTable re_dt = bdn.save_data(dt, workorder.Text, emp_code_name.Text, workorder_two.Text, pgino_two.Text, pn_two.Text
               , descr_two.Text , op_two.Text, comment_two.Value, _b_use_routing_two, re_flag);

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


public class bhgp_Apply_Class
{
    public bhgp_Apply_Class()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }
    SQLHelper SQLHelper = new SQLHelper();

    public DataTable save_data(DataTable dt, string workorder, string emp_code_name, string workorder_two, string pgino_two, string pn_two
        , string descr_two, string op_two, string comment_two, string b_use_routing_two, string re_flag)
    {
        SqlParameter[] param = new SqlParameter[]
      {
            new SqlParameter("@dt",dt),
            new SqlParameter("@workorder",workorder),
            new SqlParameter("@emp",emp_code_name),
            new SqlParameter("@workorder",workorder_two),
            new SqlParameter("@pgino",pgino_two),
            new SqlParameter("@pn",pn_two),
            new SqlParameter("@descr",descr_two),
            new SqlParameter("@op",op_two),
            new SqlParameter("@comment",comment_two),
            new SqlParameter("@b_use_routing",b_use_routing_two)
      };

        string sql = "";
        if (sql == "1")
        {
            sql = "usp_app_bhgp_Apply_deal";
        }
        else if (sql == "2")
        {

        }
        else if (sql == "3")
        {

        }
        return SQLHelper.GetDataTable(sql, param);

    }
}