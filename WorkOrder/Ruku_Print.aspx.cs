using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_Ruku_Print : System.Web.UI.Page
{
    public string _workshop = "";
    public string _dh = "";//仓库接收 扫码进来
    public string _ck = "";//仓库接收 扫码进来  上级菜单是 仓库

    public DataTable dtQC;
    public DataTable dtQC_m;
    public DataTable dtQC_dtl;

    public DataTable dtGP12;
    public DataTable dtGP12_m;
    public DataTable dtGP12_dtl;

    public DataTable dtProd;
    public DataTable dtProd_m;
    public DataTable dtProd_dtl;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["workshop"] != null) { _workshop = Request.QueryString["workshop"].ToString(); }
        if (Request.QueryString["dh"] != null) { _dh = Request.QueryString["dh"].ToString(); }
        if (Request.QueryString["ck"] != null) { _ck = Request.QueryString["ck"].ToString(); }

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>layer.alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        if (!IsPostBack)
        {
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            emp_code_name.Text = lu.WorkCode + lu.UserName;
            //emp_code_name.Text = "02432何桂勤";
        }
        GetData();
    }

    private void GetData()
    {
        string sql = string.Format("[usp_app_Ruku_Print_infor_V1] '{0}'", _dh);
        DataSet ds = SQLHelper.Query(sql);
      
        dtGP12 = ds.Tables[0];  //GP12完成  
        dtGP12_m = ds.Tables[1];  //GP12完成   
        dtGP12_dtl = ds.Tables[2];  //GP12完成      
         
        dtQC = ds.Tables[3]; //终检完成  
        dtQC_m = ds.Tables[4]; //终检完成           
        dtQC_dtl = ds.Tables[5]; //终检完成       

        dtProd = ds.Tables[6];//生产完成    
        dtProd_m = ds.Tables[7];//生产完成
        dtProd_dtl = ds.Tables[8];//生产完成
    }

    [WebMethod]
    public static string workorder_change(string workorder)
    {

        string re_sql = @"exec [usp_app_Ruku_Print_workorder_change] '{0}'";
        re_sql = string.Format(re_sql, workorder);
        DataSet ds = SQLHelper.Query(re_sql);

        DataTable re_dt = ds.Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        string domain = "", pgino = "", pn = "", qty = "";

        if (flag == "N")
        {
            DataTable re_dt_2 = ds.Tables[1];
            domain = re_dt_2.Rows[0]["domain"].ToString();
            pgino = re_dt_2.Rows[0]["pgino"].ToString();
            pn = re_dt_2.Rows[0]["pn"].ToString();
            qty = re_dt_2.Rows[0]["qty"].ToString();
        }

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\",\"domain\":\"" + domain + "\",\"pgino\":\"" + pgino + "\",\"pn\":\"" + pn + "\",\"qty\":\"" + qty + "\"}]";
        return result;

    }
    public void bind_gv(string para, string pgino, string serialno, string qty)
    {
        DataTable dt = (DataTable)ViewState["xbq_data"];
        GridView1.DataSource = dt;
        GridView1.DataBind();

        string msg = "";
        if (dt != null)
        {
            if (dt.Rows.Count > 0)
            {
                msg = "已扫箱数:<font color=#10AEFF>" + dt.Rows.Count.ToString() + "</font>已扫数量:<font color=#10AEFF>" + dt.Compute("Sum(qty)", "true").ToString() + "</font>";
            }
        }
        if (para == "1")//扫描成功之后的绑定数据
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess"
                , "$('#lbl_bq').html('" + msg + "'); $('#xbq_pgino').val('" + pgino + "'); $('#xbq_serialno').val('" + serialno + "'); $('#xbq_qty').val('" + qty + "');$('#xbq_qty_ori').val('" + qty + "');setTimeout(function(){ $('#img_sm_xbq').click(); }, 500);"
                , true); 
        }
        else if(para == "2")//翻页
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "$('#lbl_bq').html('" + msg + "');", true);
        }
        else if (para == "3")//清空数据绑定
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess"
                , "$('#lbl_bq').html('" + msg + "'); $('#xbq_pgino').val('" + pgino + "');$('#xbq_serialno').val('" + serialno + "'); $('#xbq_qty').val('" + qty + "');$('#xbq_qty_ori').val('" + qty + "');"
                , true);
        }
        else if (para == "4")//修改数据的绑定
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess"
                , "$.toptip('修改成功', 'success');$('#lbl_bq').html('" + msg + "'); $('#xbq_pgino').val('" + pgino + "');$('#xbq_serialno').val('" + serialno + "'); $('#xbq_qty').val('" + qty + "');"
                , true);
        }

    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        this.GridView1.PageIndex = e.NewPageIndex;
        bind_gv("2", "", "", "");
    }

    protected void btn_bind_data_Click(object sender, EventArgs e)
    {
        string _xbq_con = xbq_con.Text;
        string[] arr_xbq_con = _xbq_con.Split(new Char[] { '|' }, StringSplitOptions.RemoveEmptyEntries);
        if (arr_xbq_con.Length != 3)
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('标签" + _xbq_con + "格式不正确',{},function(index){layer.close(index); $('#img_sm_xbq').click();});", true);
            return;
        }
        string _pgino = arr_xbq_con[0].ToString();
        string _qty = arr_xbq_con[1].ToString();
        string _serialno = arr_xbq_con[2].ToString();

        if (_pgino != pgino.Text)
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('物料号" + _pgino + "不正确',{},function(index){layer.close(index);$('#img_sm_xbq').click();});", true);
            return;
        }
        int _serialno_tmp;
        if (!int.TryParse(_serialno, out _serialno_tmp))
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('数量" + _serialno + "不是整数类型',{},function(index){layer.close(index);$('#img_sm_xbq').click();});", true);
            return;
        }

        DataTable dt = (DataTable)ViewState["xbq_data"];
        DataRow[] drs;
        if (dt == null)
        {
            dt = new DataTable();
            dt.Columns.Add("num", typeof(Int32));
            dt.Columns.Add("pgino", typeof(string));
            dt.Columns.Add("serialno", typeof(string));
            dt.Columns.Add("qty", typeof(int));
        }
        else
        {
            drs = dt.Select("pgino='" + _pgino + "' and serialno='" + _serialno + "'");
            if (drs.Length != 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('标签" + _xbq_con + "已存在',{},function(index){layer.close(index);$('#img_sm_xbq').click();});", true);
                return;
            }
        }

        //--验证唯一性
        string re_sql = "select * from Mes_APP_WorkOrder_CKSH_Hege_Detail where pgino='{0}' and serialno='{1}'";
        re_sql = string.Format(re_sql, _pgino, _serialno);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        if (re_dt.Rows.Count > 0)
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('标签" + _xbq_con + "已被入库单" + re_dt.Rows[0]["dh"].ToString() + "使用',{},function(index){layer.close(index);$('#img_sm_xbq').click();})", true);
            return;
        }

        DataRow dr = dt.NewRow();
        dr["num"] = dt.Rows.Count <= 0 ? 1 : Convert.ToInt32(dt.Rows[dt.Rows.Count - 1]["num"]) + 1;
        dr["pgino"] = _pgino;
        dr["serialno"] = _serialno;
        dr["qty"] = _qty;

        dt.Rows.Add(dr);
        ViewState["xbq_data"] = dt;

        bind_gv("1", _pgino, _serialno, _qty);
    }

    protected void btn_bind_data_c_Click(object sender, EventArgs e)
    {
        ViewState["xbq_data"] = null;
        bind_gv("3", "", "", "");
    }

    protected void btn_bind_data_e_Click(object sender, EventArgs e)
    {
        DataTable dt = (DataTable)ViewState["xbq_data"];
        int max_row = dt.Rows.Count - 1;

        string _pgino = dt.Rows[max_row]["pgino"].ToString();
        string _serialno = dt.Rows[max_row]["serialno"].ToString();

        if (_pgino != xbq_pgino.Text)
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('物料号" + _pgino + " 与 页面物料号" + xbq_pgino.Text + "不一致');", true);
            return;
        }
        if (_serialno != xbq_serialno.Text)
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('Serial No:" + _serialno + " 与 页面Serial No:" + xbq_serialno.Text + "不一致');", true);
            return;
        }
        if (Convert.ToInt32(xbq_qty.Text) > Convert.ToInt32(xbq_qty_ori.Text))
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('QTY:" + xbq_qty.Text + " 不可大于原QTY:" + xbq_qty_ori.Text + "');", true);
            return;
        }

        dt.Rows[max_row]["qty"] = xbq_qty.Text;
        dt.AcceptChanges();
        ViewState["xbq_data"] = dt;

        bind_gv("4", xbq_pgino.Text, xbq_serialno.Text, xbq_qty.Text);
    }

    protected void btnsave_Click(object sender, EventArgs e)
    {
        //string re_sql = re_sql = @"exec usp_app_Ruku_Print '{0}', '{1}','{2}','{3}','{4}','{5}','{6}','{7}'";
        //re_sql = string.Format(re_sql, emp_code_name.Text, workorder.Text, domain.Text, pgino.Text, pn.Text, qty.Text, act_qty.Text, comment.Value);
        //DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        Ruku_Print_Class bdn = new Ruku_Print_Class();
        DataTable re_dt = bdn.save_data((DataTable)ViewState["xbq_data"], emp_code_name.Text, workorder.Text, domain.Text, pgino.Text, pn.Text, qty.Text, act_qty.Text, comment.Value);

        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        if (flag == "N")
        {
            string url = "";
            if (_dh != "")
            {
                if (_ck == "N")//车间的
                {
                    url = "/Cjgl1.aspx?workshop=" + _workshop;
                }
                if (_ck == "Y")//仓库的
                {
                    url = "/ck.aspx";
                }
            }
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess"
            //    , "$.toptip('打印成功,入库单号" + msg + "', 3000, 'success');var int = self.setTimeout(function(){ self.location='" + url + "'  }, 3000); "
            //    , true);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess"
                , "layer.alert('打印成功,入库单号" + msg + "', {}, function (index) {window.location.href='" + url + "'; }); "
                , true);
            return;
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('失败：" + msg + "');", true);
            return;
        }
    }

}


public class Ruku_Print_Class
{
    public Ruku_Print_Class()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }
    SQLHelper SQLHelper = new SQLHelper();

    public DataTable save_data(DataTable dt, string emp_code_name, string workorder, string domain, string pgino, string pn, string qty, string act_qty, string comment)
    {
        SqlParameter[] param = new SqlParameter[]
      {
            new SqlParameter("@dt",dt),
            new SqlParameter("@emp",emp_code_name),
            new SqlParameter("@workorder",workorder),
            new SqlParameter("@domain",domain),
            new SqlParameter("@pgino",pgino),
            new SqlParameter("@pn",pn),
            new SqlParameter("@qty",qty),
            new SqlParameter("@act_qty",act_qty),
            new SqlParameter("@comment",comment)
      };
        return SQLHelper.GetDataTable("usp_app_Ruku_Print_V1", param);

    }
}