﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Adjust_sign : System.Web.UI.Page
{
    public string _formno = "";
    public string _stepid = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>layer.alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        _formno = Request.QueryString["formno"].ToString();
        _stepid = Request.QueryString["stepid"].ToString();

        if (!IsPostBack)
        {
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            emp_code_name.Text = lu.WorkCode + lu.UserName;
            //emp_code_name.Text = "02432何桂勤";

            formno.Text = _formno; stepid.Text = _stepid;
            init_data(_formno, _stepid);
        }

    }

    void init_data(string formno, string stepid)
    {
        string sql = @"exec [usp_app_Adjust_sign_init] '{0}','{1}'";
        sql = string.Format(sql, formno, stepid);
        DataSet ds = SQLHelper.Query(sql);

        listBxInfo.DataSource = ds.Tables[0];
        listBxInfo.DataBind();

        Repeater_sg.DataSource = ds.Tables[1];
        Repeater_sg.DataBind();
    }


    [WebMethod]
    public static string init_btn(string stepid, string formno, string emp)
    {
        string re_sql = @"exec [usp_app_Adjust_sign_init_btn] '{0}', '{1}', '{2}'";
        re_sql = string.Format(re_sql, stepid, formno, emp);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];

        string btn_sure = re_dt.Rows[0][0].ToString();
        string btn_cancel = re_dt.Rows[0][1].ToString();

        string result = "[{\"btn_sure\":\"" + btn_sure + "\",\"btn_cancel\":\"" + btn_cancel + "\"}]";
        return result;

    }

    [WebMethod]
    public static string sure2(string _emp_code_name, string _formno, string _stepid, string _sign_comment)
    {
        string flag = "N", msg = "";

        string re_sql = @"exec [usp_app_Adjust_sign] '{0}','{1}','{2}','{3}'";
        re_sql = string.Format(re_sql, _emp_code_name, _formno, _stepid, _sign_comment);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        flag = re_dt.Rows[0][0].ToString();
        msg = re_dt.Rows[0][1].ToString();

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }

    [WebMethod]
    public static string cancel2(string _emp_code_name, string _formno, string _stepid, string _sign_comment)
    {
        string flag = "N", msg = "";

        string re_sql = @"exec [usp_app_Adjust_sign_cancel] '{0}','{1}','{2}','{3}'";
        re_sql = string.Format(re_sql, _emp_code_name, _formno, _stepid, _sign_comment);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        flag = re_dt.Rows[0][0].ToString();
        msg = re_dt.Rows[0][1].ToString();

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }
}