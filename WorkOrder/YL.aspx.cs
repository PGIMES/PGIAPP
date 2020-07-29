using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class YL : System.Web.UI.Page
{
    public string _workshop = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        _workshop = Request.QueryString["workshop"].ToString();

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
            lbl_emp.Text = lu.Telephone + lu.UserName;
            if (string.IsNullOrEmpty( lu.Telephone))//增加手机号的获取，因为cookIE里的手机号有可能会是空值
            {
                string strsql = "select * from [172.16.5.6].[eHR_DB].[dbo].[View_HR_Emp] where employeeid = '" + lu.WorkCode + "'";
                var value_rout = SQLHelper.reDs(strsql).Tables[0];
                if (value_rout != null && value_rout.Rows.Count > 0)
                {
                    lbl_emp.Text = value_rout.Rows[0]["cellphone"].ToString() + lu.UserName;
                }
            }
           

            //emp_code_name.Text = "02432何桂勤";
            domain.Text = "200";
            //lbl_emp.Text = "15850349106何桂勤";

            //绑定岗位
            ShowValue(lu.WorkCode);
            //ShowValue("02432");
        }

    }

    public void ShowValue(string WorkCode)
    {
        //取当前登录者
        string sql = @"select id,domain from [dbo].[Mes_App_EmployeeLogin] where emp_code='{0}' and off_date is null";
        sql = string.Format(sql, WorkCode);
        var value = SQLHelper.reDs(sql).Tables[0];
        if (value != null && value.Rows.Count > 0)
        {
            string id = value.Rows[0]["id"].ToString();
            if (domain.Text == "100" || domain.Text == "")
            {
                domain.Text = value.Rows[0]["domain"].ToString();
            }

            string strsql = "select * from [dbo].Mes_App_EmployeeLogin_Location where login_id = '{0}'";
            strsql = string.Format(strsql, id);
            var value_rout = SQLHelper.reDs(strsql).Tables[0];

            for (int i = 0; i < value_rout.Rows.Count; i++)
            {
                lbl_location.Text += value_rout.Rows[i]["workshop"].ToString() + "/" + value_rout.Rows[i]["line"].ToString() + "/" + value_rout.Rows[i]["op"].ToString();
                if (i != value_rout.Rows.Count - 1) { lbl_location.Text += "<br />"; }
            } 
        }
        else
        {
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "layer.alert(\"员工未上岗,请跳转至上岗页面\");window.location.href = 'Emp_Login.aspx?workshop=" + _workshop + "'", true);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "$('#btn_save2').hide();$.toptip('员工未上岗,请先上岗', 3000, 'warning');", true);
            return;
        }


    }


    [WebMethod]
    public static string pgino_change(string pgino, string domain)
    {

        string re_sql = @"exec [usp_app_YL_pgino_change] '{0}','{1}'";
        re_sql = string.Format(re_sql, pgino, domain);
        DataSet ds = SQLHelper.Query(re_sql);

        DataTable re_dt = ds.Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        string pn = "", descr = "", qty = "", pt_prod_line = "";
        if (flag == "N")
        {
            DataTable dt = ds.Tables[1];
            pn = dt.Rows[0]["pt_desc1"].ToString();
            descr = dt.Rows[0]["pt_desc2"].ToString();
            qty = dt.Rows[0]["pt_ord_mult"].ToString();
            pt_prod_line = dt.Rows[0]["pt_prod_line"].ToString();
        }

        string ld_ref = "", ld_qty_oh = "";
        DataTable ldt = new DataTable();

        /* 
        string sqlStr = @"";//送料信息里，第一笔 绑定库存明细里的
        if (pt_prod_line != "1090")
        {
            sqlStr = @"select top 1 ld_part,ld_ref,ld_loc,cast(cast(ld_qty_oh as numeric(18,4)) as float) ld_qty_oh from pub.ld_det 
                            where ld_status in('FG-ZONE','RM-ZONE') and ld_part='{0}' and ld_qty_oh>0
                            order by ld_date,ld_ref 
                            with (nolock)";
        }
        else
        {
            sqlStr = @"select top 1 ld_part,ld_ref,ld_loc,cast(cast(ld_qty_oh as numeric(18,4)) as float) ld_qty_oh from pub.ld_det 
                            where ld_status in('FG-ZONE','RM-ZONE') and ld_part='{0}' and ld_qty_oh>0
                            order by ld_date,ld_ref,ld_qty_oh 
                            with (nolock)";
        }
        sqlStr = string.Format(sqlStr, pgino);
        ldt = QadOdbcHelper.GetODBCRows(sqlStr);
        if (ldt.Rows.Count > 0)
        {
            ld_ref = ldt.Rows[0]["ld_ref"].ToString();
            ld_qty_oh = ldt.Rows[0]["ld_qty_oh"].ToString();
        }
        */

        string sqlStr = @"select ld_ref title,cast(cast(ld_qty_oh as numeric(18,4)) as float) value
                    from pub.ld_det where ld_status in('FG-ZONE','RM-ZONE') and ld_part='{0}' and ld_qty_oh>0";

        if (pt_prod_line != "1090")
        {
            sqlStr = sqlStr + @" order by ld_date,ld_ref";
        }
        else
        {
            sqlStr = sqlStr + @" order by ld_date,ld_ref,ld_qty_oh";
        }
        sqlStr = sqlStr + @" with (nolock)";

        sqlStr = string.Format(sqlStr, pgino);
        ldt = QadOdbcHelper.GetODBCRows(sqlStr);
        if (ldt.Rows.Count > 0)
        {
            ld_ref = ldt.Rows[0]["title"].ToString();
            ld_qty_oh = ldt.Rows[0]["value"].ToString();
        }

        DataTable ldt_n = UpdateDataTable(ldt);
        string json_lot = JsonConvert.SerializeObject(ldt_n);

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\",\"pn\":\"" + pn + "\",\"descr\":\"" + descr + "\",\"qty\":\"" + qty
            + "\",\"ld_ref\":\"" + ld_ref + "\",\"ld_qty_oh\":\"" + ld_qty_oh + "\",\"json_lot\":" + json_lot + "}]";
        return result;

    }

    private static DataTable UpdateDataTable(DataTable argDataTable)
    {
        DataTable dtResult = new DataTable();
        //克隆表结构
        dtResult = argDataTable.Clone();
        foreach (DataColumn col in dtResult.Columns)
        {
            col.ColumnName = col.ColumnName.ToLower();
            if (col.ColumnName.ToLower() == "value")
            {
                //修改列类型
                col.DataType = typeof(string);
            }
        }
        foreach (DataRow row in argDataTable.Rows)
        {
            DataRow rowNew = dtResult.NewRow();
            rowNew["title"] = row["title"]+","+ row["value"];
            rowNew["value"] = row["value"];
            dtResult.Rows.Add(rowNew);
        }
        return dtResult;
    }


    [WebMethod]
    public static string nd_change(string nd_jg)
    {
        string time = "";
        time = DateTime.Now.AddMinutes(Convert.ToDouble(nd_jg)).ToString("yyyy-MM-dd HH:mm");

        string result = "[{\"time\":\"" + time + "\"}]";
        return result;

    }

    protected bool IsNum(string text)
    {
        for (int i = 0; i < text.Length; i++)
        {
            if (!Char.IsNumber(text, i))
            {
                return true; //输入的不是数字  
            }
        }
        return false; //否则是数字

    }

    [WebMethod]
    public static string save2(string _emp_code_name, string pgino, string domain, string pn, string descr, string need_qty, string need_date, string need_date_dl
                    , string ld_ref, string ld_qty_oh)
    {
        string flag = "N", msg = "";

        DateTime date = DateTime.MinValue;
        bool bf = DateTime.TryParse(need_date, out date);

        if (!bf)
        {
            flag = "Y"; msg = "【送到时间】日期格式不正确";
        }


        if (flag == "N")
        {
            string re_sql = @"exec [usp_app_YL] '{0}', '{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}'";
            re_sql = string.Format(re_sql, _emp_code_name, pgino, domain, pn, descr, need_qty, need_date, need_date_dl, ld_ref, ld_qty_oh == "" ? "0" : ld_qty_oh);
            DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
            flag = re_dt.Rows[0][0].ToString();
            msg = re_dt.Rows[0][1].ToString();
        }

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }

    /*
    protected void btnsave_Click(object sender, EventArgs e)
    {
        DateTime date = DateTime.MinValue;
        bool bf = DateTime.TryParse(need_date.Text, out date);

        if (!bf)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('【送到时间】日期格式不正确')", true);
            return;
        }

        if (IsNum(need_qty.Text))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('【要料数量】格式不正确')", true);
            return;
        }
        else if(Convert.ToInt32(need_qty.Text)<=0)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('【要料数量】必须大于0')", true);
            return;
        }

        string re_sql = @"exec [usp_app_YL] '{0}', '{1}','{2}','{3}','{4}','{5}','{6}','{7}'";
        re_sql = string.Format(re_sql, emp_code_name.Text, pgino.Text, domain.Text, pn.Text, descr.Text, need_qty.Text, need_date.Text, need_date_dl.Value);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        if (flag == "N")
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('" + msg + "');", true);
            Response.Redirect("/workorder/YL_list_new.aspx?workshop=" + _workshop);
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('失败：" + msg + "')", true);
        }

    }*/


}