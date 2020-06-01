using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;


public partial class Off_Material : System.Web.UI.Page
{
    public string _workshop = "";
    public string _dh = "";
    public DataTable dt_append;

    protected void Page_Load(object sender, EventArgs e)
    {
        _workshop =  Request.QueryString["workshop"].ToString(); // "四车间";  
        _dh =   Request.QueryString["dh"].ToString(); //"W1497589";


        dt_append = new DataTable();
        dt_append.Columns.Add("sku");
        dt_append.Columns.Add("lot_no");
        dt_append.Columns.Add("need_off_qty");
        dt_append.Columns.Add("need_no");
        dt_append.Columns.Add("idno");



        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        if (!IsPostBack)
        {
            ViewState["STEPVALUE"] = "";
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            txt_emp.Text = lu.WorkCode;
            txt_dh.Text = _dh;
            ShowValue(txt_emp.Text);

        }
    }

    public void ShowValue(string WorkCode)
    {
        string pgino = "";
        string sql_str = @"exec usp_app_off_material_Sel_xmh '{0}','{1}','{2}'";
        sql_str = string.Format(sql_str, "", WorkCode, _workshop);
        DataTable dt = SQLHelper.Query(sql_str).Tables[0];
        if (dt != null && dt.Rows.Count > 0)
        {
            txt_xmh.DataSource = dt;
            txt_xmh.DataTextField = "pgino";
            txt_xmh.DataValueField = "pgino";
            txt_xmh.DataBind();
            if (dt.Rows.Count > 1)
            {
                txt_xmh.Items.Insert(0, new ListItem("--请选择--", ""));
            }
           
        }

        string sql_his = "select top 1 pgino   from [dbo].[Mes_App_WorkOrder_History] where workorder='{0}'";
        sql_his = string.Format(sql_his, txt_dh.Text);
        DataTable dt_his = SQLHelper.Query(sql_his).Tables[0];
        if (dt_his.Rows.Count > 0)
        {
            pgino = dt_his.Rows[0]["pgino"].ToString();

            if (!txt_xmh.Items.Contains(new ListItem(pgino)))
            {
                btnsave.Attributes.Add("disabled", "disabled");
                btnzc.Attributes.Add("disabled", "disabled");
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert('请上岗" + pgino + "岗位');", true);
                return;
            }
        }

    }






    protected void btnsave_Click(object sender, EventArgs e)
    {
        //txt_curr_qty.Text = (double.Parse(txt_qty.Text) - double.Parse(txt_off_qty.Text)).ToString();
        //if ((double.Parse(txt_curr_qty.Text) + double.Parse(txt_off_qty.Text)) < double.Parse(txt_ztsl.Text))
        //{   
        //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "$.confirm('零托,确认下料吗？', function () { $('#btn_wc').click(); }, function () {});", true);
        //}
        //else
        //{
            save("下料");
           
        //}


    }




    protected void txt_xmh_SelectedIndexChanged(object sender, EventArgs e)
    {
        Bind_reperter();
    }

    protected void btn_bind_data_Click(object sender, EventArgs e)
    {
        string dh = dh_record.Text;
       
        DataRow drow = dt_append.NewRow();
        string sql = "";
        string strsql = "select sku,lot_no,cast(qty-off_qty as decimal(18,4)) as need_off_qty,need_no from Mes_App_WorkOrder_Wip where 1=1 and loading_type=1 ";
        dh = dh.Substring(1, dh.Length - 1)+",";
        string[] strdh = dh.Split(',');
        int strdh_lenth = strdh.Length;
        DataTable dt = new DataTable();

        for (int i = 0; i < strdh.Length - 1; i++)
        {
           
                sql = strsql+ " and lot_no='" + strdh[i].ToString() + "'";
                DataTable dt_ = SQLHelper.Query(sql).Tables[0];
                if (dt_.Rows.Count == 0 || dt_ == null)
                {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", @"$.toptip('来源单号不存在',3000); $('#source_dh').val('') ", true);
                    return;
                }
            
        }
                
              strsql += " and lot_no in  (select *  from dbo.StrToTable('" + dh.Substring(0, dh.Length - 1)+"'))";
             dt = SQLHelper.Query(strsql).Tables[0];
           
        
             ViewState["DT_Source"] = dt;
            DataTable dtnew = GetAll();
            Repeater_lotno.DataSource = dtnew;
            Repeater_lotno.DataBind();
           


    }
    protected DataTable GetAll()
    {
        DataRow drow = dt_append.NewRow();
       
        DataTable DT_Source = (DataTable)ViewState["DT_Source"];
        if (DT_Source!=null && DT_Source.Rows.Count > 0)
        {
            for (int i = 0; i < DT_Source.Rows.Count; i++)
            {
                drow["sku"] = DT_Source.Rows[i]["sku"].ToString();
                drow["lot_no"] = DT_Source.Rows[i]["lot_no"].ToString();
                drow["need_off_qty"] = DT_Source.Rows[i]["need_off_qty"].ToString();
                drow["need_no"] = DT_Source.Rows[i]["need_no"].ToString();
                drow["idno"] =i;
                dt_append.Rows.Add(drow.ItemArray);
            }
        }
        DataTable dt_grid = (DataTable)ViewState["DT_Grid"];
        if (dt_grid != null && dt_grid.Rows.Count > 0)
        {
            for (int i = 0; i < dt_grid.Rows.Count; i++)
            {
                drow["sku"] = dt_grid.Rows[i]["sku"].ToString();
                drow["lot_no"] = dt_grid.Rows[i]["lot_no"].ToString();
                drow["need_off_qty"] = dt_grid.Rows[i]["need_off_qty"].ToString();
                drow["need_no"] = dt_grid.Rows[i]["need_no"].ToString();
                drow["idno"] = 0;
                dt_append.Rows.Add(drow.ItemArray);
            }
        }
        return dt_append;

    }

    protected void btnzc_Click(object sender, EventArgs e)
    {
        save(btnzc.Text);
    }
    //protected void btn_wc_Click(object sender, EventArgs e)
    //{
    //    save("下料");
       
    //}



    [WebMethod]
    public static string Set_Page(string workorder)
    {

        string result = "";
        string re_sql = @"exec [usp_app_off_num_ver] '{0}',''";
        re_sql = string.Format(re_sql, workorder);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        result = Newtonsoft.Json.JsonConvert.SerializeObject(re_dt);
        return result;
    }

    protected void save(string btn)
    {
        string sqlstr = @"select emp_code+emp_name,pgino,location,id from [dbo].[Mes_App_EmployeeLogin] where emp_code='{0}' and off_date is null";
        sqlstr = string.Format(sqlstr, txt_emp.Text);
        var dt = SQLHelper.reDs(sqlstr).Tables[0];
        if (dt.Rows.Count <= 0)
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert(\"员工未上岗,请跳转至上岗页面\");window.location.href = 'Emp_Login.aspx?workshop=" + _workshop + "'", true);
            return;
        }
        string script = "";
        string dh_source = "";
        string sql = "";
        txt_curr_qty.Text = (double.Parse(txt_qty.Text) - double.Parse(txt_off_qty.Text)).ToString();
        if (double.Parse(txt_curr_qty.Text) <= 0)
        {
            sql = @"exec usp_app_down_material_recover '{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}'";
        }
        else
        { 
         sql = @"exec usp_app_down_material_ver '{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}'";
        }
        if (dh_record.Text.Contains(","))
        { dh_source = dh_record.Text.Substring(1, dh_record.Text.Length - 1); }
        sql = string.Format(sql, txt_dh.Text, txt_emp.Text, txt_xmh.SelectedItem.Text, txt_pn.Text, txt_curr_qty.Text,btn, dh_source, Request.Form["step"], txt_remark.Value);
        DataTable re_dt = SQLHelper.Query(sql).Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        if (flag == "N")
        {
           
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert('" + btn + "完成');window.location.href='/Cjgl1.aspx?workshop=" + _workshop + "'", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert('" + msg + "')", true);
        }
    }

    protected void Bind_reperter()
    {
        string pgino = "";
        DataTable dt1 = new DataTable();
        string sql_his = "select top 1 pgino   from [dbo].[Mes_App_WorkOrder_History] where workorder='{0}'";
        sql_his = string.Format(sql_his, txt_dh.Text);
        DataTable dt_his = SQLHelper.Query(sql_his).Tables[0];
        if (dt_his.Rows.Count > 0)
        {
            pgino = dt_his.Rows[0]["pgino"].ToString();
        }
        if (txt_xmh.Items.Contains(new ListItem(pgino)))
        {
            txt_xmh.SelectedValue = pgino;
            txt_xmh.Attributes.Add("disabled", "disabled");
        }
        

        string sql = @"exec usp_app_off_material_Bind_xmh_ver '{0}','{1}'";
        sql = string.Format(sql, txt_xmh.SelectedValue, txt_emp.Text);
        DataTable redt = SQLHelper.Query(sql).Tables[0];
        //根据项目号取整托数
        if (txt_xmh.SelectedValue != "")
        {
            if (redt.Rows.Count > 0)
            {
                DataRow[] drs2 = redt.Select("pgino = '" + txt_xmh.SelectedItem.Text + "' ");
                if (drs2 != null && drs2.Length > 0)
                {
                    txt_qty.Text = drs2[0]["ztsl"].ToString();
                    txt_pn.Text = drs2[0]["pn"].ToString();
                    txt_ztsl.Text = drs2[0]["ztsl"].ToString();
                }
            }
            dt1 = SQLHelper.Query(sql).Tables[1];

            ViewState["DT_Grid"] = dt1;
            DataTable dtnew = GetAll();
            Repeater_lotno.DataSource = dtnew;
            Repeater_lotno.DataBind();
            string strsql = @"exec usp_app_off_num_ver '{0}','{1}'";
            strsql = string.Format(strsql, txt_dh.Text, txt_xmh.SelectedValue);
            DataTable dt2 = SQLHelper.Query(strsql).Tables[0];

            txt_off_qty.Text = dt2.Rows[0]["off_qty"].ToString();
            txt_curr_qty.Text = (double.Parse(txt_qty.Text) - double.Parse(txt_off_qty.Text)).ToString();
            ViewState["STEPVALUE"] = dt2.Rows[0]["step"].ToString();
            txt_step.Text= dt2.Rows[0]["step"].ToString();
            DataTable dt_record = SQLHelper.Query(strsql).Tables[1];
            if (dt_record.Rows.Count > 0)
            {
                Repeater_record.DataSource = SQLHelper.Query(strsql).Tables[1];
                Repeater_record.DataBind();
            }

        }
    }
    protected void btn_bind_xm_Click(object sender, EventArgs e)
    {
        Bind_reperter();
      

    }

    
}
