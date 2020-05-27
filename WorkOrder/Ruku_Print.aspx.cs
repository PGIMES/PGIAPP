using System;
using System.Collections.Generic;
using System.Data;
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
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('小标签" + _xbq_con + "格式不正确')", true);
            return;
        }
        string _pgino = arr_xbq_con[0].ToString();
        string _qty = arr_xbq_con[1].ToString();
        string _serialno = arr_xbq_con[2].ToString();

        if (_pgino != pgino.Text)
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('物料号" + _pgino + "不正确')", true);
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
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('【小标签】已存在')", true);
                return;
            }
        }

        //--验证唯一性
        string re_sql = "select * from Mes_APP_WorkOrder_CKSH_Hege_Detail where pgino='{0}' and serialno='{1}'";
        re_sql = string.Format(re_sql, _pgino, _serialno);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        if (re_dt.Rows.Count > 0)
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('【小标签】已被入库单" + re_dt.Rows[0]["dh"].ToString() + "使用')", true);
            return;
        }

        DataRow dr = dt.NewRow();
        dr["num"] = dt.Rows.Count <= 0 ? 1 : Convert.ToInt32(dt.Rows[dt.Rows.Count - 1]["id"]) + 1;
        dr["pgino"] = _pgino;
        dr["serialno"] = _serialno;
        dr["qty"] = _qty;

        dt.Rows.Add(dr);
        ViewState["xbq_data"] = dt;

        bind_gv();
    }

    protected void btnsave_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('1212'); ", true);
        return;
        string re_sql = re_sql = @"exec usp_app_Ruku_Print '{0}', '{1}','{2}','{3}','{4}','{5}','{6}','{7}'";
        re_sql = string.Format(re_sql, emp_code_name.Text, workorder.Text, domain.Text, pgino.Text, pn.Text, qty.Text, act_qty.Text, comment.Value);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        if (flag == "N")
        {
            string url = "";
            if (_dh != "")
            {
                if (_ck == "N")//车间的
                {
                    //Response.Redirect("/Cjgl1.aspx?workshop=" + _workshop);
                    url = "/Cjgl1.aspx?workshop=" + _workshop;
                }
                if (_ck == "Y")//仓库的
                {
                    //Response.Redirect("/ck.aspx");
                    url = "/ck.aspx";
                }
            }
            //ClientScript.RegisterStartupScript(this.GetType(), "showsuccess"
            //    , "$.toptip('打印成功,入库单号" + msg + "', 3000, 'success');var int = self.setTimeout(function(){ self.location='"+url+"'  }, 3000); "
            //    , true);
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
            //ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('失败：" + msg + "');", true);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('失败：" + msg + "');", true);
            return;
        }
    }

}