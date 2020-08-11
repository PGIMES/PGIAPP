using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Newtonsoft.Json;

public partial class WorkOrder_YZWC : System.Web.UI.Page
{
    public string _workshop = "";
    public string _dh = "";
    public DataTable dt_append;
    protected void Page_Load(object sender, EventArgs e)
    {
        _workshop =   Request.QueryString["workshop"].ToString(); // "四车间";  
        _dh =    Request.QueryString["dh"].ToString(); //"W1497589";


        dt_append = new DataTable();
        dt_append.Columns.Add("zyb");
        dt_append.Columns.Add("lot_no");
        dt_append.Columns.Add("act_qty");
        dt_append.Columns.Add("cl");
        dt_append.Columns.Add("yzj_no");
        dt_append.Columns.Add("zyb_lot");
        dt_append.Columns.Add("idno");



        if (!IsPostBack)
        {
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            txt_emp.Text =   lu.WorkCode;
            txt_dh.Text = _dh;
            ShowValue(txt_emp.Text);

        }
    }
    public void ShowValue( string WorkCode)
    {

        //string pgino = "";
        //string yzjno = "";
        //string sql_str = @"exec usp_app_yz_xmh_sel '{0}','{1}','{2}','{3}'";
        //sql_str = string.Format(sql_str, WorkCode, _workshop, txt_dh.Text, txt_xmh.SelectedValue);
        //DataTable dt = SQLHelper.Query(sql_str).Tables[0];
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

        //string sql_his = "select top 1 yzj_no,pgino,NextStep   from [dbo].[Mes_App_WorkOrder_YZ_History] where workorder='{0}'";
        //sql_his = string.Format(sql_his, txt_dh.Text);
        //DataTable dt_his = SQLHelper.Query(sql_his).Tables[0];
        //if (dt_his.Rows.Count > 0)
        //{
        //    pgino = dt_his.Rows[0]["pgino"].ToString();
        //    yzjno = dt_his.Rows[0]["yzj_no"].ToString();

        //    if (!txt_xmh.Items.Contains(new ListItem(pgino)) && dt.Rows.Count > 0)
        //    {
        //        ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert('请上岗压铸机号" + yzjno + "');", true);
        //        return;
        //    }
        //    pgino = dt_his.Rows[0]["pgino"].ToString();
        //    txt_xmh.SelectedValue = pgino;
        //    txt_xmh.Attributes.Add("disabled", "disabled");

        //    g1.Attributes.Add("disabled", "disabled");
        //    g2.Attributes.Add("disabled", "disabled");
        //    g3.Attributes.Add("disabled", "disabled");
        //    g4.Attributes.Add("disabled", "disabled");
        //}


    }
    protected void btn_bind_xm_Click(object sender, EventArgs e)
    {
        Bind_reperter();


    }




    protected void Bind_reperter()
    {

        string sql = @"exec usp_app_yz_xmh_sel_ver '{0}','{1}','{2}','{3}','{4}'";  
        sql = string.Format(sql, txt_emp.Text, _workshop, txt_dh.Text, txt_pgino.Text, txt_yzj.Text );
        DataSet ds = SQLHelper.Query(sql);
        //DataTable dt1 = ds.Tables[2];
        //if (dt1.Rows.Count > 0 && txt_pgino.Text != "")
        //{
        //    txt_pn.Text = dt1.Rows[0]["pt_desc1"].ToString();
        //    txt_qty.Text = dt1.Rows[0]["pt_ord_mult"].ToString();
        //    txt_ztsl.Text = dt1.Rows[0]["pt_ord_mult"].ToString();
        //    txt_off_qty.Text = dt1.Rows[0]["off_qty"].ToString();
        //    txt_curr_qty.Text = dt1.Rows[0]["curr_qty"].ToString();
        //    txt_desc2.Text = dt1.Rows[0]["pt_desc2"].ToString();
        //}
        ViewState["DT_Grid"] = ds.Tables[3];
        DataTable dtnew = GetAll();
        Repeater_lotno.DataSource = dtnew;
        Repeater_lotno.DataBind();
        DataTable dt_record = ds.Tables[4];
        if (dt_record.Rows.Count > 0)
        {
            Repeater_record.DataSource = dt_record;
            Repeater_record.DataBind();
        }
        string stepvalue = ds.Tables[5].Rows[0]["StepValue"].ToString();
        int op = int.Parse(ds.Tables[5].Rows[0]["op"].ToString());
        g1.Checked = (stepvalue == "后处理完成") ? true : false;
        g2.Checked = (stepvalue == "终检") ? true : false;
        g3.Checked = (stepvalue == "GP12") ? true : false;
        g4.Checked = (stepvalue == "入库") ? true : false;
       if(ds.Tables[5].Rows[0]["cz"].ToString()=="Y")
        {
            g1.Attributes.Add("disabled", "disabled");
            g2.Attributes.Add("disabled", "disabled");
            g3.Attributes.Add("disabled", "disabled");
            g4.Attributes.Add("disabled", "disabled");
        }
        if (op < 600)
        {
            lb2.Visible = false;
            lb3.Visible = false;
        }
        else
        {
            lb2.Visible = true;
            lb3.Visible = true;
        }

        if (op > 600)
        {
            lb4.Visible = false;
        }
        else
        {
            lb4.Visible = true;
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
                drow["zyb"] = DT_Source.Rows[i]["zyb"].ToString();
                drow["lot_no"] = DT_Source.Rows[i]["lot_no"].ToString();
                drow["act_qty"] = DT_Source.Rows[i]["act_qty"].ToString();
                drow["cl"] = DT_Source.Rows[i]["cl"].ToString();
                drow["yzj_no"] = DT_Source.Rows[i]["yzj_no"].ToString();
                drow["zyb_lot"] = DT_Source.Rows[i]["zyb_lot"].ToString();
                drow["idno"] = i;
                dt_append.Rows.Add(drow.ItemArray);
            }
        }
        DataTable dt_grid = (DataTable)ViewState["DT_Grid"];
        if (dt_grid != null && dt_grid.Rows.Count > 0)
        {
            for (int i = 0; i < dt_grid.Rows.Count; i++)
            {
                drow["zyb"] = dt_grid.Rows[i]["zyb"].ToString();
                drow["lot_no"] = dt_grid.Rows[i]["lot_no"].ToString();
                drow["act_qty"] = dt_grid.Rows[i]["act_qty"].ToString();
                drow["cl"] = dt_grid.Rows[i]["cl"].ToString();
                drow["yzj_no"] = dt_grid.Rows[i]["yzj_no"].ToString();
                drow["zyb_lot"] = dt_grid.Rows[i]["zyb_lot"].ToString();
                drow["idno"] = 0;
                dt_append.Rows.Add(drow.ItemArray);
            }
        }
        return dt_append;

    }

    [WebMethod]
    public static string save2(string _dh, string _emp, string _pgino, string _pn, string _descr, float _curr_qty, string _btnms
       , string _lot, string _stepvalue, string _remark,string _workshop,string _dh_record,string _yzjno)
    {
        string flag = "N", msg = "", re_sql = "", _lotno = "" , _dh_source = "";

        if (_dh_record.Contains(","))
        { _dh_source = _dh_record.Substring(1, _dh_record.Length - 1); }

        if (_lot.Contains(","))
        { _lotno = _lot.Substring(0, _lot.Length - 1); }
        if (_curr_qty >0)
        {
            re_sql = @"exec usp_app_yz_off_V2 '{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}'";
        }
        else
        {
            re_sql = @"exec usp_app_yz_off_recover '{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}'";
        }
        if (flag == "N")
        {
            re_sql = string.Format(re_sql, _dh, _emp, _pgino, _pn, _descr,_curr_qty, _btnms, _lotno, _stepvalue, _remark,_workshop, _dh_source,_yzjno);
            DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
            flag = re_dt.Rows[0][0].ToString();
            msg = re_dt.Rows[0][1].ToString();
        }
        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }

    protected void btn_bind_data_Click(object sender, EventArgs e)
    {
        string dh = dh_record.Text;
        //ViewState["STEPVALUE"] = txt_step.Text.ToString();
        DataRow drow = dt_append.NewRow();
        string sql = "";
        string pgino = "";
        double ztsl = 0;
        string sqlspend = "";
        string strsql = "";
         sqlspend = @"select zyb,right(lot_no,8)zyb_lot,zl as act_qty,cl,yzj_no,lot_no,pgino,yzj_no,pn from Mes_App_WorkOrder_YZ_Wip wip where 1=1 ";
        strsql = sqlspend;
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

                sql = strsql + " and workorder_wip='" + strdh[i].ToString() + "'";
                DataTable dt_ = SQLHelper.Query(sql).Tables[0];
                if (dt_.Rows.Count == 0 || dt_ == null)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", @"$.toptip('来源单号不存在',3000); $('#source_dh').val('');$('#dh_record').val('') ", true);
                    return;
                }




            }

            sqlspend += "  and wip.workorder_wip  in  (select *  from dbo.StrToTable('" + dh + "'))";
            dt = SQLHelper.Query(sqlspend).Tables[0];

            for (int i = 0; i < dt.Rows.Count; i++)
            {

                pgino = dt.Rows[0]["pgino"].ToString();

                if (pgino != dt.Rows[i]["pgino"].ToString())
                {

                    script = "物料号不一致，不可一起操作！";


                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert('" + script + "'); $('#source_dh').val('') ", true);
                    return;
                }
                //else
                //{
                //    drow["zyb"] = dt.Rows[i]["zyb"].ToString();
                //    drow["lot_no"] = dt.Rows[i]["lot_no"].ToString();
                //    drow["act_qty"] = dt.Rows[i]["act_qty"].ToString();
                //    drow["cl"] = dt.Rows[i]["cl"].ToString();
                //    drow["yzj_no"] = dt.Rows[i]["yzj_no"].ToString();
                //    drow["zyb_lot"] = dt.Rows[i]["zyb_lot"].ToString();
                //    drow["idno"] = i;
                //    dt_append.Rows.Add(drow.ItemArray);
                //}
            }

            ViewState["DT_Source"] = dt;
            DataTable dtnew = GetAll();
          //  txt_pgino.Text = dt_append.Rows[0]["pgino"].ToString();
            Repeater_lotno.DataSource = dt_append;
            Repeater_lotno.DataBind();

           
                //txt_pgino.Text = dt.Rows[0]["pgino"].ToString();
                //txt_pn.Text = dt.Rows[0]["pn"].ToString();
                //txt_qty.Text = dt.Rows[0]["act_qty"].ToString();


            

        }
       


    }


    [WebMethod]
    public static string init_yzj( string emp , string workshop, string workorder)
    {
        string result = "", equip_no = "", equip_name = "";
        string sql = @"exec [usp_app_yz_xmh_sel_ver] '" + emp + "','" + workshop + "','"+workorder+"','',''";
        DataSet ds = SQLHelper.Query(sql);

        DataTable dt = ds.Tables[0];
        equip_no = dt.Rows[0]["equip_no"].ToString();
        equip_name = dt.Rows[0]["equip_name"].ToString();
        string json = JsonConvert.SerializeObject(dt);
        result = "[{\"json\":" + json + "}]";

        DataTable dt_pgino = ds.Tables[1];
        string json_pgino = JsonConvert.SerializeObject(dt_pgino);

        result = "[{\"equip_no\":\"" + equip_no + "\",\"equip_name\":\"" + equip_name + "\",\"json\":" + json + ",\"json_pgino\":" + json_pgino + "}]";

        return result;

    }




    [WebMethod]
    public static string yzj_change(string emp, string workshop, string workorder, string yzj_no)
    {
        //string pt_desc1 = "", pt_desc2 = ""; double pt_ord_mult = 0, off_qty = 0, curr_qty = 0;
        string sql = @" exec [usp_app_yz_xmh_sel_ver] '" + emp + "','" + workshop + "','" + workorder + "','','" + yzj_no + "'";
        DataSet ds = SQLHelper.Query(sql);



        string json_op = JsonConvert.SerializeObject(ds.Tables[1]);
       string result = "[{\"json_op\":" + json_op + "}]";
        //DataTable dt = ds.Tables[2];
        //pt_desc1 = dt.Rows[0]["pt_desc1"].ToString();
        //pt_desc2 = dt.Rows[0]["pt_desc2"].ToString();
        //pt_ord_mult = double.Parse(dt.Rows[0]["pt_ord_mult"].ToString());
        //off_qty = double.Parse(dt.Rows[0]["off_qty"].ToString());
        //curr_qty = double.Parse(dt.Rows[0]["curr_qty"].ToString());


        //string result = "[{\"pt_desc1\":\"" + pt_desc1
        //    + "\",\"pt_desc2\":\"" + pt_desc2 + "\",\"pt_ord_mult\":\"" + pt_ord_mult + "\",\"off_qty\":\"" + off_qty + "\",\"curr_qty\":\"" + curr_qty + "\",\"json_op\":" + json_op + "}]";
        return result;

    }


    [WebMethod]
    public static string pgino_change(string emp, string workshop, string workorder,string pgino, string yzj_no)
    {
        string pt_desc1 = "", pt_desc2 = ""; double pt_ord_mult = 0, off_qty = 0, curr_qty = 0;
        string sql = @" exec [usp_app_yz_xmh_sel_ver] '" + emp + "','" + workshop + "','" + workorder + "','"+pgino+"','" + yzj_no + "'";
        DataSet ds = SQLHelper.Query(sql);



       // string json_op = JsonConvert.SerializeObject(ds.Tables[1]);

        DataTable dt = ds.Tables[2];
        pt_desc1 = dt.Rows[0]["pt_desc1"].ToString();
        pt_desc2 = dt.Rows[0]["pt_desc2"].ToString();
        pt_ord_mult = double.Parse(dt.Rows[0]["pt_ord_mult"].ToString());
        off_qty = double.Parse(dt.Rows[0]["off_qty"].ToString());
        curr_qty = double.Parse(dt.Rows[0]["curr_qty"].ToString());


        string result = "[{\"pt_desc1\":\"" + pt_desc1
            + "\",\"pt_desc2\":\"" + pt_desc2 + "\",\"pt_ord_mult\":\"" + pt_ord_mult + "\",\"off_qty\":\"" + off_qty + "\",\"curr_qty\":\"" + curr_qty + "\"}]";
        return result;

    }


    [WebMethod]
    public static string yz_source_change(string workorder,string source_dh)
    {
        string sqlspend = "", pgino = "", pt_desc1 = "", pt_desc2 = "", yzj_no = "";
        double pt_ord_mult = 0,off_qty=0,curr_qty = 0;
        string dh = source_dh;
        if (source_dh.Contains(","))
        {
            {
                dh = source_dh.Substring(1, source_dh.Length - 1);
            }
        }
         sqlspend = @" exec [usp_yz_source_gl] '" + workorder + "','" + dh + "'";



        DataSet ds = SQLHelper.Query(sqlspend);



        // string json_op = JsonConvert.SerializeObject(ds.Tables[1]);

        DataTable dt = ds.Tables[0];
        pgino = dt.Rows[0]["pgino"].ToString();
        pt_desc2 = dt.Rows[0]["pn"].ToString();
        pt_ord_mult = double.Parse(dt.Rows[0]["pt_ord_mult"].ToString());
        yzj_no= dt.Rows[0]["yzj_no"].ToString();
        off_qty = double.Parse(dt.Rows[0]["off_qty"].ToString());
        curr_qty = pt_ord_mult- off_qty;


        string result = "[{\"pgino\":\"" + pgino
            + "\",\"pt_desc2\":\"" + pt_desc2 + "\",\"pt_ord_mult\":\"" + pt_ord_mult + "\",\"off_qty\":\"" + off_qty + "\",\"curr_qty\":\"" + curr_qty + "\",\"yzj_no\":\"" + yzj_no + "\"}]";
        return result;

    }
}