﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_bhgp_Apply_list_ck : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        GetData();
    }

    private void GetData()
    {
        DataTable dt_wk = new DataTable();

        string sql = @"exec [usp_app_bhgp_Apply_list_ck]";
        DataSet ds = SQLHelper.Query(sql);

        dt_wk = ds.Tables[0];

        list_go.DataSource = dt_wk;
        list_go.DataBind();

    }

    protected void list_go_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("re_go");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = new DataTable();
            string sql = @"exec [usp_app_bhgp_Apply_list_dv] '{0}','{1}','{2}','{3}'";
            sql = string.Format(sql, item["workshop"].ToString(), item["stepname"].ToString(), item["stepid"].ToString(), "");
            dt_wk = SQLHelper.Query(sql).Tables[0];

            detail.DataSource = dt_wk;
            detail.DataBind();

            Label1.Text = "(" + dt_wk.Rows.Count + ")";


        }
    }

}