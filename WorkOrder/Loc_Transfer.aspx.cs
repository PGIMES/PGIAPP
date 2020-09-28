using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_Loc_Transfer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>layer.alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }
        if (!IsPostBack)
        {
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            emp_code_name.Text = lu.WorkCode + lu.UserName;
            domain.Text = lu.Domain;

            //emp_code_name.Text = "02432何桂勤";
            domain.Text = "200";

        }

    }

    [WebMethod]
    public static string init_data_js(string domain, string emp)
    {
        string result = "";
        string sql = @" exec [usp_app_Loc_Transfer_init_data_js] '" + domain + "','" + emp + "'";
        DataSet ds = SQLHelper.Query(sql);

        DataTable dt_pgino = ds.Tables[0];
        string json_pgino = JsonConvert.SerializeObject(dt_pgino);

        result = "[{\"json_pgino\":" + json_pgino + "}]";
        return result;

    }

    [WebMethod]
    public static string pgino_change(string domain, string pgino, string _ref, string loc)
    {
        string result = ""; string msg = "";
        string xmh_value = "", ref_value = "", loc_value = "", qty_value = "";

        if (pgino == "") { msg = "请先输入物料号"; }

        if (msg == "")
        {
            string sql = @" exec [usp_app_Loc_Transfer_init_data_js] '" + domain + "','','" + pgino + "'";
            DataTable dt_pgino = SQLHelper.Query(sql).Tables[0];
            if (dt_pgino.Rows.Count <= 0)
            {
                msg = "物料号" + pgino + "不存在";
            }

            if (msg == "")
            {
                xmh_value = dt_pgino.Rows[0]["title"].ToString();

                DataTable ldt = new DataTable();
                string sqlStr = "select ld_ref,cast(ld_qty_oh as float)ld_qty_oh,ld_loc from pub.ld_det where ld_domain='{0}' and ld_part='{1}' and ld_qty_oh>0 with (nolock)";
                sqlStr = string.Format(sqlStr, domain, xmh_value);
                ldt = QadOdbcHelper.GetODBCRows(sqlStr);

                if (ldt == null)
                {
                    msg = "项目号" + xmh_value + ",QAD库存不存在";
                }
                else
                {
                    if (ldt.Rows.Count <= 0)
                    {
                        msg = "项目号" + xmh_value + ",QAD库存不存在";
                    }
                }

                if (msg == "")
                {
                    DataRow[] drs = null;
                    if (_ref != "" && loc == "")
                    {
                        drs = ldt.Select("ld_ref='" + _ref + "'");
                        if (drs.Length <= 0)
                        {
                            msg = "项目号" + xmh_value + ",参考号" + _ref + ",QAD库存不存在";
                        }
                    }
                    else if (_ref == "" && loc != "")
                    {
                        drs = ldt.Select("ld_loc='" + loc + "' and ld_ref=''");
                        if (drs.Length <= 0)
                        {
                            msg = "项目号" + xmh_value + ",当前库位" + loc + ",QAD库存不存在";
                        }
                        else if (drs.Length > 1)
                        {
                            msg = "项目号" + xmh_value + ",当前库位" + loc + ",QAD库存存在多笔";
                        }
                    }
                    else if (_ref != "" && loc != "")
                    {
                        drs = ldt.Select("ld_ref='" + _ref + "' and ld_loc='" + loc + "'");
                        if (drs.Length <= 0)
                        {
                            msg = "项目号" + xmh_value + ",参考号" + _ref + ",当前库位" + loc + ",QAD库存不存在";
                        }
                        else if (drs.Length > 1)
                        {
                            msg = "项目号" + xmh_value + ",参考号" + _ref + ",当前库位" + loc + ",QAD库存存在多笔";
                        }
                    }

                    if (msg == "" && drs.Length == 1)//多笔的 不自动带出
                    {
                        ref_value = drs[0]["ld_ref"].ToString();
                        qty_value = drs[0]["ld_qty_oh"].ToString();
                        loc_value = drs[0]["ld_loc"].ToString();
                    }
                }
            }
        }

        result = "[{\"msg\":\"" + msg + "\",\"xmh_value\":\"" + xmh_value + "\",\"ref_value\":\"" + ref_value + "\",\"loc_value\":\"" + loc_value + "\",\"qty_value\":\"" + qty_value + "\"}]";
        return result;

    }

    [WebMethod]
    public static string loc_to_change(string domain, string loc)
    {
        string flag = "N", msg = "";
        string sql = @" exec [usp_app_Loc_Transfer_loc_to_change] '" + domain + "','" + loc + "'";
        DataTable re_dt = SQLHelper.Query(sql).Tables[0];
        flag = re_dt.Rows[0][0].ToString();
        msg = re_dt.Rows[0][1].ToString();

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }


    [WebMethod]
    public static string sign(string _emp_code_name)
    {
        string flag = "N", msg = "";
        //string re_sql = re_sql = @"exec usp_app_JC_sign_V1 '{0}'";
        //re_sql = string.Format(re_sql, _emp_code_name);

        //DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        //flag = re_dt.Rows[0][0].ToString();
        //msg = re_dt.Rows[0][1].ToString();

        QadWebservices.QADInterfaceSoapClient ser = new QadWebservices.QADInterfaceSoapClient("QADInterfaceSoap");
        string recmsg = "";
        //recmsg = ser.Invoke("SCM", "QAD", guid, "TR", content);

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }
}