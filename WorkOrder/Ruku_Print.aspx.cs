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
    public void bind_gv()
    {
        DataTable dt = (DataTable)ViewState["xbq_data"];
        GridView1.DataSource = dt;
        GridView1.DataBind();
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        this.GridView1.PageIndex = e.NewPageIndex;
        bind_gv();
    }

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        DataTable dt = (DataTable)ViewState["xbq_data"];
        for (int i = dt.Rows.Count - 1; i >= 0; i--)
        {
            if (GridView1.DataKeys[e.RowIndex].Value.ToString() == dt.Rows[i]["num"].ToString()) { dt.Rows.RemoveAt(i); }
        }

        ViewState["xbq_data"] = dt;
        bind_gv();
    }

    protected void btn_bind_data_Click(object sender, EventArgs e)
    {
        string _xbq_con = xbq_con.Text;
        string[] arr_xbq_con = _xbq_con.Split(new Char[] { '|' }, StringSplitOptions.RemoveEmptyEntries);
        if (arr_xbq_con.Length != 3)
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('标签" + _xbq_con + "格式不正确',{},function(index){layer.close(index);	$('#img_sm_xbq').click();})", true);
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

        DataTable dt = (DataTable)ViewState["xbq_data"];
        DataRow[] drs;
        if (dt == null)
        {
            dt = new DataTable();
            dt.Columns.Add("num", typeof(Int32));
            dt.Columns.Add("pgino", typeof(string));
            dt.Columns.Add("serialno", typeof(string));
            dt.Columns.Add("qty", typeof(string));
        }
        else
        {
            drs = dt.Select("pgino='" + _pgino + "' and serialno='" + _serialno + "'");
            if (drs.Length != 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('标签" + _xbq_con + "已存在',{},function(index){layer.close(index);$('#img_sm_xbq').click();})", true);
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

        bind_gv();
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "$('#img_sm_xbq').click();", true);
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