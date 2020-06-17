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
        dt_append.Columns.Add("ps_qty_per");



        if (WeiXin.GetCookie("workcode") == null)
        {
           Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        if (!IsPostBack)
        {
            ViewState["STEPVALUE"] = "";
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            txt_emp.Text =  lu.WorkCode;
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

            if (!txt_xmh.Items.Contains(new ListItem(pgino)) && dt.Rows.Count > 0)
            {
                // btnsave.Attributes.Add("disabled", "disabled");
                // btnzc.Attributes.Add("disabled", "disabled");
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert('请上岗" + pgino + "岗位');", true);
                return;
            }
           
        }

    }






    //protected void btnsave_Click(object sender, EventArgs e)
    //{
    //    //txt_curr_qty.Text = (double.Parse(txt_qty.Text) - double.Parse(txt_off_qty.Text)).ToString();
    //    //if ((double.Parse(txt_curr_qty.Text) + double.Parse(txt_off_qty.Text)) < double.Parse(txt_ztsl.Text))
    //    //{   
    //    //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "$.confirm('零托,确认下料吗？', function () { $('#btn_wc').click(); }, function () {});", true);
    //    //}
    //    //else
    //    //{
    //        save("下料");
           
    //    //}


    //}




    protected void txt_xmh_SelectedIndexChanged(object sender, EventArgs e)
    {
        Bind_reperter();
    }

    protected void btn_bind_data_Click(object sender, EventArgs e)
    {
        string dh = dh_record.Text;
       
        DataRow drow = dt_append.NewRow();
        string sql = "";
        string strsql = @"select sku,lot_no,cast(qty-off_qty as decimal(18,4)) as need_off_qty,need_no,cast(ps_qty_per as decimal(18,4))ps_qty_per from Mes_App_WorkOrder_Wip wip
                          join[172.16.5.26].QAD.DBO.QAD_PS_MSTR ps on wip.sku = ps_comp and wip.domain = ps_domain
                          where 1 = 1 and loading_type = 1 and ps_par='" + txt_xmh.SelectedValue+"' ";
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
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert(\"来源单号不存在\"); $('#source_dh').val('') ", true);
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
                drow["ps_qty_per"] = DT_Source.Rows[i]["ps_qty_per"].ToString();
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
                drow["ps_qty_per"] = dt_grid.Rows[i]["ps_qty_per"].ToString();
                drow["idno"] = 0;
                dt_append.Rows.Add(drow.ItemArray);
            }
        }
        return dt_append;

    }

    //protected void btnzc_Click(object sender, EventArgs e)
    //{
    //    save(btnzc.Text);
    //}
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
         sql = @"exec usp_app_down_material '{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}'";
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
            txt_xmh.SelectedValue = pgino;
            txt_xmh.Attributes.Add("disabled", "disabled");
        }
        //if (txt_xmh.Items.Contains(new ListItem(pgino)))
        //{
           
        //}
        

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
            //if (double.Parse(txt_qty.Text) - double.Parse(txt_off_qty.Text) < 0)
            //{
            //    txt_qty.Text = txt_off_qty.Text;
            //    txt_curr_qty.Text = "0";
            //}
            //else
            //{
                txt_curr_qty.Text = (double.Parse(txt_qty.Text) - double.Parse(txt_off_qty.Text)).ToString();
            if(double.Parse(txt_qty.Text) <double.Parse(txt_off_qty.Text))
            {
                txt_qty.Text = txt_off_qty.Text;
                txt_curr_qty.Text = "0";
            }
            //}

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

    [WebMethod]
    public static string save2(string _dh, string _emp, string _pgino, string _pn, float _curr_qty, string _btnms
       , string _dh_record, string _stepvalue, string _remark)
    {
        string flag = "N", msg = "",re_sql = "", _dh_source = "";
       
        if (_dh_record.Contains(","))
        { _dh_source = _dh_record.Substring(1, _dh_record.Length - 1); }
        if (_curr_qty <= 0)
        {
            re_sql = @"exec usp_app_down_material_recover '{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}'";
        }
        else
        {
            re_sql = @"exec usp_app_down_material_ver1 '{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}'";
        }
        

        if (flag == "N")
        {
            re_sql = string.Format(re_sql, _dh, _emp, _pgino, _pn, _curr_qty, _btnms, _dh_source, _stepvalue, _remark);
            DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
            flag = re_dt.Rows[0][0].ToString();
            msg = re_dt.Rows[0][1].ToString();
        }
        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }


    [WebMethod]
    public static string Check_GP(string pgino)
    {

        string result = "";
        string re_sql = @" if exists (SELECT top 1 1  FROM [172.16.5.26].qad.dbo.qad_ro_det WHERE   ro_routing='{0}' AND ro_milestone='1' AND ro_end IS NULL) SELECT 'Y' ELSE  SELECT 'N' ";
        re_sql = string.Format(re_sql, pgino + "-GP12");
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        result = "[{\"flag\":\"" + flag + "\"}]";
        return result;
    }
}
