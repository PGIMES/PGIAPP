using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class bhgp_deal_result : System.Web.UI.Page
{
    public string _workorder = "";
    public string _next = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        _workorder = Request.QueryString["workorder"].ToString();
        _next = Request.QueryString["next"].ToString();//N表示第一次链接进来，Y表示点击 下一次 进来的
        if (!IsPostBack)
        {
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            emp_code_name.Text = lu.WorkCode + lu.UserName;
            domain.Text = lu.Domain;

            //emp_code_name.Text = "02432何桂勤";
            //domain.Text = "200";

            workorder.Text = _workorder;
            init_data(_workorder);
            bind_reason(domain.Text);
            bind_dcl_rea(domain.Text);

            if (_next == "Y")
            {
                //绑定数据
                string sql = @"select * from [MES_APP_WorkOrder_Ng_Deal_Main_temp] where workorder='{0}'";
                sql = string.Format(sql, _workorder);
                DataTable dt = SQLHelper.Query(sql).Tables[0];
                if (dt.Rows[0]["cz_result"].ToString() == "废品")
                {
                    b_result1.Checked = true;
                }
                if (dt.Rows[0]["cz_result"].ToString() == "待处理")
                {
                    b_result2.Checked = true; 
                    hege_qty.Text = dt.Rows[0]["hege_qty"].ToString();
                    dcl_rea.SelectedValue= dt.Rows[0]["reason_code"].ToString();
                    dcl_rea.Visible = false;
                    txt_dcl_rea.Text = dt.Rows[0]["reason_code"].ToString() + "-" + dt.Rows[0]["reason"].ToString();
                    txt_dcl_rea.Visible = true;
                }
                //设定只读
                b_result1.Disabled = true;
                b_result2.Disabled = true;
                hege_qty.ReadOnly = true;

                GetData(_workorder);
            }
            else//若是第一次进来，需要确认 已处置数量不为0的话，需要赋值，且只读
            {
                string sql = @"select * from [Mes_App_WorkOrder_Ng] where workorder='{0}'";
                sql = string.Format(sql, _workorder);
                DataTable dt = SQLHelper.Query(sql).Tables[0];
                if (dt.Rows[0]["result"].ToString() == "废品")
                {
                    b_result1.Checked = true;
                    hege_qty.ReadOnly = true;
                }
                if (dt.Rows[0]["result"].ToString() == "待处理")
                {
                    b_result2.Checked = true;
                    dcl_rea.SelectedValue = dt.Rows[0]["reason_code"].ToString();
                    dcl_rea.Visible = false;
                    txt_dcl_rea.Text = dt.Rows[0]["reason_code"].ToString() + "-" + dt.Rows[0]["reason"].ToString();
                    txt_dcl_rea.Visible = true;
                }
                if (dt.Rows[0]["result"].ToString() != "")
                {
                    //设定只读
                    b_result1.Disabled = true;
                    b_result2.Disabled = true;
                }
            }
        }
    }

    //废品原因
    void bind_reason(string domain)
    {
        string sql = @"select '' rsn_code,'' rsn_desc,'' rsn_desc2 
                    union all 
                    select rsn_code,rsn_desc,rsn_code+'-'+rsn_desc rsn_desc2 
                    from [qad].[dbo].[qad_rsn_ref] 
                    where [rsn_type]='SCRAP' and rsn_domain='" + domain + "'";
        DataTable re_dt = SQLHelper.Query(sql).Tables[0];
        reason.DataSource = re_dt;
        reason.DataTextField = "rsn_desc2";
        reason.DataValueField = "rsn_code";
        reason.DataBind();
    }

    //待处理原因
    void bind_dcl_rea(string domain)
    {
        string sql = @"select '' rsn_code,'' rsn_desc,'' rsn_desc2 
                    union all 
                    select rsn_code,rsn_desc,rsn_code+'-'+rsn_desc rsn_desc2 
                    from [qad].[dbo].[qad_rsn_ref] 
                    where [rsn_type]='REJECT' and rsn_domain='" + domain + "'";
        DataTable re_dt = SQLHelper.Query(sql).Tables[0];
        dcl_rea.DataSource = re_dt;
        dcl_rea.DataTextField = "rsn_desc2";
        dcl_rea.DataValueField = "rsn_code";
        dcl_rea.DataBind();
    }

    void init_data(string _workorder)
    {
        string sql = @"select * from Mes_App_WorkOrder_Ng where status<>1 and workorder='{0}'";
        sql = string.Format(sql, _workorder);
        DataTable dt = SQLHelper.Query(sql).Tables[0];
        pgino.Text = dt.Rows[0]["pgino"].ToString();
        source.Text = dt.Rows[0]["source"].ToString();
        op.Text = dt.Rows[0]["op"].ToString();
        qty.Text = dt.Rows[0]["qty"].ToString();//处置数量
        off_qty.Text = dt.Rows[0]["off_qty"].ToString();//处置数量

    }


    void GetData(string _workorder)
    {
        DataTable dt = new DataTable();
        string sql = @"select *,reason_code+'-'+baofei_reason reason_desc from [MES_APP_WorkOrder_Ng_Deal_Dtl_temp] where workorder='{0}' order by id";
        sql = string.Format(sql, _workorder);
        dt = SQLHelper.Query(sql).Tables[0];
        GridView1.DataSource = dt;
        GridView1.DataBind();

    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        this.GridView1.PageIndex = e.NewPageIndex;
        GetData(workorder.Text);
    }

    protected void btnnext_Click(object sender, EventArgs e)
    {
        //插入到临时表里
        string _b_result = "";
        if (b_result1.Checked)
            _b_result = b_result1.Value;
        if (b_result2.Checked)
            _b_result = b_result2.Value;

        string _hege_qty = hege_qty.Text == "" ? "0" : hege_qty.Text;

        string re_sql = @"exec usp_app_workorder_ng_next '{0}', '{1}','{2}','{3}','{4}','{5}','{6}','{7}'";
        re_sql = string.Format(re_sql, emp_code_name.Text, workorder.Text, _b_result
            , _hege_qty, baofei_qty.Text, reason.SelectedItem.Text, dcl_rea.SelectedItem.Text, _next);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        if (flag == "N")
        {
            Response.Redirect(string.Format("/workorder/bhgp_deal_result.aspx?workorder={0}&next={1}", workorder.Text, "Y"));
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "alert('" + msg + "')", true);
        }
    }


    protected void btnsure_Click(object sender, EventArgs e)
    {
        if (_next == "N")
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "alert('没有处置明细，不能确认')", true);
            return;
        }

        if (GridView1.Rows.Count == 0 && (hege_qty.Text == "" || hege_qty.Text == "0"))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "alert('没有处置明细，不能确认')", true);
            return;
        }

        string re_sql = @"exec usp_app_workorder_ng_next_sure '{0}'";
        re_sql = string.Format(re_sql, workorder.Text);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        if (flag == "N")
        {
            Response.Redirect("/workorder/bhgp_deal_list.aspx");
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "alert('" + msg + "')", true);
        }
    }
}
