using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;


public partial class WorkOrder_YZ_HSolve : System.Web.UI.Page
{
    public string _workshop = "";
    public string _dh = "";
    public DataTable dt_append;
    protected void Page_Load(object sender, EventArgs e)
    {
        _workshop =  Request.QueryString["workshop"].ToString(); // "四车间";  
        _dh = Request.QueryString["dh"].ToString(); //"W1497589";


        dt_append = new DataTable();
        dt_append.Columns.Add("pgino");
        dt_append.Columns.Add("workorder");
        dt_append.Columns.Add("need_off_qty");;
        dt_append.Columns.Add("idno");



        if (!IsPostBack)
        {
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            txt_emp.Text =   lu.WorkCode;
            txt_dh.Text = _dh;
            ShowValue(txt_emp.Text);

        }
    }
    public void ShowValue(string WorkCode)
    {

        string pgino = "";
        string yzjno = "";
        string sql_str = @"exec usp_app_yz_hsolve_load '{0}','{1}','{2}','{3}'";
        sql_str = string.Format(sql_str, WorkCode, _workshop, txt_dh.Text, txt_xmh.Text);
        DataTable dt = SQLHelper.Query(sql_str).Tables[0];
        //if (dt != null && dt.Rows.Count > 0)
        //{
        //    txt_xmh.DataSource = dt;
        //    txt_xmh.DataTextField = "pgino";
        //    txt_xmh.DataValueField = "pgino";
        //    txt_xmh.DataBind();
        //    if (dt.Rows.Count > 1)
        //    {
        //        txt_xmh.Items.Insert(0, new ListItem("--请选择--", ""));
        //    }

        //}

        string sql_his = "select top 1 yzj_no,pgino,NextStep   from [dbo].[Mes_App_WorkOrder_YZ_HSolve_History] where workorder='{0}'";
        sql_his = string.Format(sql_his, txt_dh.Text);
        DataTable dt_his = SQLHelper.Query(sql_his).Tables[0];
        if (dt_his.Rows.Count > 0)
        {
            pgino = dt_his.Rows[0]["pgino"].ToString();
            yzjno = dt_his.Rows[0]["yzj_no"].ToString();

            //if (!txt_xmh.Items.Contains(new ListItem(pgino)) && dt.Rows.Count > 0)
            //{
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert('请上岗压铸机号" + yzjno + "');", true);
            //    return;
            //}
            pgino = dt_his.Rows[0]["pgino"].ToString();
            // txt_xmh.SelectedValue = pgino;
            txt_xmh.Text = pgino;
            txt_xmh.Attributes.Add("disabled", "disabled");

         
            g2.Attributes.Add("disabled", "disabled");
            g3.Attributes.Add("disabled", "disabled");
            g4.Attributes.Add("disabled", "disabled");
        }


    }
    protected void btn_bind_xm_Click(object sender, EventArgs e)
    {
        Bind_reperter();


    }




    protected void Bind_reperter()
    {

        string sql = @"exec usp_app_yz_hsolve_load_v1 '{0}','{1}','{2}','{3}','{4}'";
        sql = string.Format(sql, txt_emp.Text, _workshop, txt_dh.Text, txt_xmh.Text, dh_record.Text);
        DataSet ds = SQLHelper.Query(sql);
        DataTable dt1 = ds.Tables[0];
        if (dt1.Rows.Count > 0 )
        {
            txt_xmh.Text = dt1.Rows[0]["pgino"].ToString();
            txt_pn.Text = dt1.Rows[0]["pt_desc1"].ToString();
            txt_qty.Text = dt1.Rows[0]["pt_ord_mult"].ToString();
            txt_ztsl.Text = dt1.Rows[0]["pt_ord_mult"].ToString();
            txt_off_qty.Text = dt1.Rows[0]["off_qty"].ToString();
            txt_curr_qty.Text = dt1.Rows[0]["curr_qty"].ToString();
            txt_desc2.Text = dt1.Rows[0]["pt_desc2"].ToString();
        }
        //else
        //{
        //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert('员工未上岗，请先上岗');", true);
        //    return;
        //}
        //ViewState["DT_Grid"] = ds.Tables[1];
        //DataTable dtnew = GetAll();
        Repeater_lotno.DataSource = ds.Tables[1];
        Repeater_lotno.DataBind();
        DataTable dt_record = ds.Tables[2];
        if (dt_record.Rows.Count > 0)
        {
            Repeater_record.DataSource = dt_record;
            Repeater_record.DataBind();
        }
        string stepvalue = ds.Tables[3].Rows[0]["StepValue"].ToString();
        g2.Checked = (stepvalue == "终检") ? true : false;
        g3.Checked = (stepvalue == "GP12") ? true : false;
        g4.Checked = (stepvalue == "入库") ? true : false;
        if (ds.Tables[3].Rows[0]["cz"].ToString() == "Y")
        {
            g2.Attributes.Add("disabled", "disabled");
            g3.Attributes.Add("disabled", "disabled");
            g4.Attributes.Add("disabled", "disabled");
        }

    }

    protected void btn_bind_data_Click(object sender, EventArgs e)
    {
        string dh = dh_record.Text;
        //ViewState["STEPVALUE"] = txt_step.Text.ToString();
        DataRow drow = dt_append.NewRow();
        string sql = "";
        string pgino = "";
        double ztsl = 0;
        string sqlspend = @"select wip.pgino,wip.off_qty,isnull(wip.off_qty,0)-isnull(solve_qty,0)-isnull(ng.qty,0) as need_off_qty,wip.workorder,loading_type  from Mes_App_WorkOrder_YZ_HSolve_Wip wip 
                               left join (SELECT  pgino,workorder_qc,SUM(QTY) qty from   Mes_App_WorkOrder_Ng group by workorder_qc,pgino) ng on wip.pgino=ng.pgino and wip.workorder=workorder_qc
                                   where 1=1";

        string strsql = "select  pgino,pn,off_qty,solve_qty,off_qty-solve_qty as need_off_qty,workorder,loading_type from Mes_App_WorkOrder_YZ_HSolve_Wip where 1=1   ";
        if (dh_record.Text.Contains(","))
        {
            { dh = dh_record.Text.Substring(1, dh_record.Text.Length - 1); }
            string[] strdh = dh.Split(',');
            int strdh_lenth = strdh.Length;
            DataTable dt = new DataTable();
            string status = "";
            string script = "";
            for (int i = 0; i <= strdh.Length - 1; i++)
            {

                sql = strsql + " and workorder='" + strdh[i].ToString() + "'";
                DataTable dt_ = SQLHelper.Query(sql).Tables[0];
                if (dt_.Rows.Count == 0 || dt_ == null)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", @"$.toptip('来源单号不存在',3000); $('#source_dh').val('');$('#dh_record').val('') ", true);
                    return;
                }




            }

            sqlspend += "  and wip.workorder  in  (select *  from dbo.StrToTable('" + dh + "'))";
            dt = SQLHelper.Query(sqlspend).Tables[0];

            for (int i = 0; i < dt.Rows.Count; i++)
            {

                pgino = dt.Rows[0]["pgino"].ToString();
             
                if (pgino != dt.Rows[i]["pgino"].ToString())
                {

                    script = "物料号不一致，不可一起操作！";


                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert('"+ script + "'); $('#source_dh').val('') ", true);
                    return;
                }
                else
                {
                    drow["pgino"] = dt.Rows[i]["pgino"].ToString();
                    drow["workorder"] = dt.Rows[i]["workorder"].ToString();
                    drow["need_off_qty"] = dt.Rows[i]["need_off_qty"].ToString();
                    drow["idno"] = i;
                    dt_append.Rows.Add(drow.ItemArray);
                }
            }

            //ViewState["DT_Source"] = dt;

            //DataTable dtnew = GetAll();
            Bind_reperter();
            //Repeater_lotno.DataSource = dt_append;
            //Repeater_lotno.DataBind();


            //double total = dt_append.AsEnumerable().Select(d => Convert.ToDouble(d.Field<string>("need_off_qty"))).Sum();
            //if(total+double.Parse(txt_off_qty.Text)<double.Parse(txt_qty.Text.ToString()))
            //{
            //    txt_qty.Text = (total + double.Parse(txt_off_qty.Text)).ToString();
            //}
            ////txt_source_sum.Text = total.ToString();

            ////double total = Convert.ToDouble(dt_append.Compute("SUM(need_off_qty)", ""));
            //if (total < ztsl)
            //{
            //    txt_source_sum.Text = total.ToString();// (total - double.Parse(txt_off_qty.Text)).ToString();
            //                                           //ScriptManager.RegisterStartupScript(Page,this.GetType(), "set", "setvalues();",true);
            //}
        }


    }

    protected DataTable GetAll()
    {
        DataRow drow = dt_append.NewRow();

        DataTable DT_Source = (DataTable)ViewState["DT_Source"];
        if (DT_Source != null && DT_Source.Rows.Count > 0)
        {
            for (int i = 0; i < DT_Source.Rows.Count; i++)
            {
                drow["pgino"] = DT_Source.Rows[i]["pgino"].ToString();
                drow["workorder"] = DT_Source.Rows[i]["workorder"].ToString();
                drow["need_off_qty"] = DT_Source.Rows[i]["need_off_qty"].ToString();
                drow["idno"] = i;
                dt_append.Rows.Add(drow.ItemArray);
            }
        }
        DataTable dt_grid = (DataTable)ViewState["DT_Grid"];
        if (dt_grid != null && dt_grid.Rows.Count > 0)
        {
            for (int i = 0; i < dt_grid.Rows.Count; i++)
            {
                drow["pgino"] = dt_grid.Rows[i]["pgino"].ToString();
                drow["workorder"] = dt_grid.Rows[i]["workorder"].ToString();
                drow["need_off_qty"] = dt_grid.Rows[i]["need_off_qty"].ToString();
                drow["idno"] = 0;
                dt_append.Rows.Add(drow.ItemArray);
            }
        }
        return dt_append;

    }

    [WebMethod]
    public static string save2(string _dh, float _curr_qty, string _emp, string _pgino, string _btnms
      , string _dh_record, string _remark, string _stepvalue)
    {
        string flag = "N", msg = "", re_sql = "", _dh_source = "";

        if (_dh_record.Contains(","))
        { _dh_source = _dh_record.Substring(1, _dh_record.Length - 1); }

          

        if (_curr_qty <= 0)
        {
            re_sql = @"exec usp_app_YZ_HSolve_Insert '{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}'";
        }
        else
        {
            re_sql = @"exec usp_app_yz_hsolve_recover '{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}'";
        }

        if (flag == "N")
        {
            re_sql = string.Format(re_sql, _dh, _curr_qty, _emp, _pgino, _btnms, _dh_source, _remark, _stepvalue);
            DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
            flag = re_dt.Rows[0][0].ToString();
            msg = re_dt.Rows[0][1].ToString();
        }
        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }
}