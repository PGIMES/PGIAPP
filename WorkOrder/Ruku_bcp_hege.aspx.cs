using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_Ruku_bcp_hege : System.Web.UI.Page
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

        string re_sql = @"exec [usp_app_Ruku_bcp_hege_workorder_change] '{0}'";
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


    protected void btnsave_Click(object sender, EventArgs e)
    {
        //check qad 库存
        DataTable ldt = new DataTable();
        string sqlStr = @"select sum(cast(cast(ld_qty_oh as numeric(18,4)) as float)) ld_qty_oh from pub.ld_det where ld_ref='{0}' and ld_domain='{1}' with (nolock)";
        sqlStr = string.Format(sqlStr, workorder.Text, domain.Text);
        ldt = QadOdbcHelper.GetODBCRows(sqlStr);
        if (ldt == null)
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('单号" + workorder.Text + ",QAD库存不存在');", true);
            return;
        }
        if (ldt.Rows.Count <= 0)
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "layer.alert('单号" + workorder.Text + ",QAD库存不存在');", true);
            return;
        }
        if (ldt.Rows[0]["ld_qty_oh"].ToString() != act_qty.Text)
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType()
                , "showsuccess", "layer.alert('单号" + workorder.Text + ",库存不一致.QAD库存" + ldt.Rows[0]["ld_qty_oh"].ToString() + "当前待入库" + act_qty.Text + "');"
                , true);
            return;
        }


        string re_sql = re_sql = @"exec usp_app_Ruku_bcp_hege '{0}', '{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}'";
        re_sql = string.Format(re_sql, emp_code_name.Text, workorder.Text, domain.Text, pgino.Text, pn.Text, qty.Text, act_qty.Text, comment.Value, loc_hg.Text);
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
                    url = "/Cjgl1.aspx?workshop=" + _workshop;
                }
                if (_ck == "Y")//仓库的
                {
                    url = "/ck.aspx";
                }
            }
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess"
               , "$.toptip('入库成功', 2000, 'success');var int = self.setTimeout(function(){ self.location='" + url + "'  }, 2000); "
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