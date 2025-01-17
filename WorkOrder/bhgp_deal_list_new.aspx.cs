﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class bhgp_deal_list_new : System.Web.UI.Page
{
    public string _workshop = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        _workshop = Request.QueryString["workshop"].ToString();

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        //if (!IsPostBack)
        //{
        GetData();
        //}
    }

    private void GetData()
    {
        DataTable dt_wcl = new DataTable();
        DataTable dt_ycl = new DataTable();
        DataTable dt_ywc = new DataTable();

        string sql = @"exec [usp_app_workorder_ng_list_new] ''";
        dt_wcl = SQLHelper.Query(sql).Tables[0];
        dt_ycl = SQLHelper.Query(sql).Tables[1];
        dt_ywc = SQLHelper.Query(sql).Tables[2];

        DataList1.DataSource = dt_wcl;
        DataList1.DataBind();
        Label1.Text = Label1.Text + "(" + dt_wcl.Rows.Count + ")";

        DataList2.DataSource = dt_ycl;
        DataList2.DataBind();
        Label2.Text = Label2.Text + "(" + dt_ycl.Rows.Count + ")";

        DataList3.DataSource = dt_ywc;
        DataList3.DataBind();
        Label3.Text = Label3.Text + "(" + dt_ywc.Rows.Count + ")";

    }
}


