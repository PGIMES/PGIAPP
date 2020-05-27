using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Maticsoft.DBUtility;

public partial class WorkOrder_Quantity_Checked : System.Web.UI.Page
{

    public string _workshop = "";
    public string _dh= ""; //生产完成单号
    public DataTable dt_append;

    protected void Page_Load(object sender, EventArgs e)
    {
        _workshop =  Request.QueryString["workshop"].ToString(); // "四车间";//
        _dh =   Request.QueryString["dh"].ToString();// "W0000456";
        // lotno = "G0000301";
        //_dh = "W0000450";

        dt_append = new DataTable();
        dt_append.Columns.Add("pgino");
        dt_append.Columns.Add("workorder");
        dt_append.Columns.Add("need_off_qty");
        //dt_append.Columns.Add("need_no");
        dt_append.Columns.Add("idno");

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>layer.alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }
       


        if (!IsPostBack)
        {
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            txt_emp.Text =  lu.WorkCode;
            txt_dh.Text = _dh;
            ViewState["STEPVALUE"] = "";

        }
    }

    [WebMethod]
    public static string Set_Page(string workorder,string sourceorder)
    {
        
        string result = "";
        string re_sql = "";
        DataTable re_dt;
        //string dh = "";
        //if (sourceorder == "")
        //{ dh = workorder; }
        //else { dh = sourceorder; }
         re_sql = @"exec [usp_app_source_ver] '{0}','{1}'";
        re_sql = string.Format(re_sql, workorder,sourceorder);
         re_dt = SQLHelper.Query(re_sql).Tables[0];
        if(re_dt.Rows[0]["pgino"].ToString()!="")
        { 
        result = Newtonsoft.Json.JsonConvert.SerializeObject(re_dt);
        }
        
        return result;
    }




   


    protected void save(int btn)
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
        string ms = "";
        string dh_source = "";
        txt_curr_qty.Text = (double.Parse(txt_qty.Text) - double.Parse(txt_off_qty.Text)).ToString();



        string sql = @"exec usp_app_qc_Insert_V1 '{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}'";
        if (dh_record.Text.Contains(","))
        { dh_source = dh_record.Text.Substring(1, dh_record.Text.Length - 1); }
        sql = string.Format(sql, txt_dh.Text, txt_curr_qty.Text, txt_emp.Text, txt_pgino.Text,  btn, dh_source, txt_remark.Value, Request.Form["step"]);
        DataTable re_dt = SQLHelper.Query(sql).Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();
        if (btn == 0) { ms = "部分"; }
        if (flag == "N")
        {
            if(Request.Form["step"]=="入库")
            {
                script = "已"+ms+"完成，待入库";
            }
            else
            {
                script = "已"+ms+"完成，待GP12";

            }
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert('"+script+"');window.location.href='/Cjgl1.aspx?workshop=" + _workshop + "'", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert('" + msg + "')", true);
        }
    }
    protected void btn_bind_data_Click(object sender, EventArgs e)
    {
        string dh = dh_record.Text;
        ViewState["STEPVALUE"] =  txt_step.Text.ToString();
        DataRow drow = dt_append.NewRow();
        string sql = "";
        string pgino = "";
        double ztsl = 0;
        string sqlspend = @"select wip.pgino,wip.off_qty,isnull(wip.off_qty,0)-isnull(hege_qty,0)-isnull(ng.qty,0) as need_off_qty,wip.workorder,loading_type  from Mes_App_WorkOrder_QC_Wip wip 
                               left join (SELECT  pgino,workorder_qc,SUM(QTY) qty from   Mes_App_WorkOrder_Ng group by workorder_qc,pgino) ng on wip.pgino=ng.pgino and wip.workorder=workorder_qc
                                   where 1=1";

        string strsql = "select  pgino,pn,off_qty,hege_qty,off_qty-hege_qty as need_off_qty,workorder,loading_type from Mes_App_WorkOrder_QC_Wip where 1=1   ";
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
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", @"$.toptip('来源单号不存在',3000); $('#source_dh').val('') ", true);
                    dh_record.Text = "";
                    return;
                }
               
               


            }

            sqlspend += "  and wip.workorder  in  (select *  from dbo.StrToTable('" + dh + "'))";
            dt = SQLHelper.Query(sqlspend).Tables[0];
            string re_sql = @"exec [usp_app_source_ver] '{0}','{1}'";
            re_sql = string.Format(re_sql, txt_dh.Text, dh);
            //string re_sql = @"exec [usp_app_source] '{0}'";
            //re_sql = string.Format(re_sql, dh);
            DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
            if (re_dt.Rows.Count > 0)
            {
                ztsl = double.Parse(re_dt.Rows[0]["pt_ord_mult"].ToString());

            }
            for (int i = 0; i < dt.Rows.Count; i++)
            {
               
                status = dt.Rows[0]["loading_type"].ToString();
                pgino = dt.Rows[0]["pgino"].ToString();
                if (status != dt.Rows[i]["loading_type"].ToString())
                {
                    if (status == "9")
                    {
                        script = "该单号为GP12,请勿重复终检";
                    }
                    else
                    {
                        script = "该单号为终检,不可GP12";

                    }
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", @"$.toptip('" + script + "',30000); $('#source_dh').val('') ", true);
                    return;
                }
                if (pgino != dt.Rows[i]["pgino"].ToString())
                {
                    
                        script = "物料号不一致，不可一起操作！";
                    
                    
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", @"$.toptip('" + script + "',30000); $('#source_dh').val('') ", true);
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
            //txt_pgino.Text = dt_append.Rows[0]["pgino"].ToString();
            Repeater_lotno.DataSource = dt_append;
            Repeater_lotno.DataBind();


            double total = dt_append.AsEnumerable().Select(d => Convert.ToDouble(d.Field<string>("need_off_qty"))).Sum();
            //txt_source_sum.Text = total.ToString();

            //double total = Convert.ToDouble(dt_append.Compute("SUM(need_off_qty)", ""));
            if (total < ztsl)
            {
                txt_source_sum.Text = total.ToString();// (total - double.Parse(txt_off_qty.Text)).ToString();
               //ScriptManager.RegisterStartupScript(Page,this.GetType(), "set", "setvalues();",true);
            }
        }


    }
    protected void btnzc_Click(object sender, EventArgs e)
    {
        save(0);
    }
    protected void btn_wc_Click(object sender, EventArgs e)
    {
        save(1);

    }
    protected void btnsave_Click(object sender, EventArgs e)
    {
        //txt_curr_qty.Text = (double.Parse(txt_qty.Text) - double.Parse(txt_off_qty.Text)).ToString();
        //if ((double.Parse(txt_curr_qty.Text) + double.Parse(txt_off_qty.Text)) < double.Parse(txt_ztsl.Text))
        //{
        //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "$.confirm('零托,确认执行下一步吗？', function () { $('#btn_wc').click(); }, function () {});", true);
        //}
        //else
        //{
            save(1);

        //}


    }

 



}