﻿using LitJson;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ck : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        bind_data();
    }

    public void bind_data()
    {
        //要料监视
        DataTable dt_go = new DataTable();

        string sql = @"exec [usp_app_YL_list_new] '',''";
        dt_go = SQLHelper.Query(sql).Tables[0];

        int count_yl = dt_go.Rows.Count;
        Label1.Text = count_yl.ToString();


        //不合格监视
        //sql = @"exec [usp_app_bhgp_Apply_list_dv] '','','9998',''";
        //DataTable dt_06 = SQLHelper.Query(sql).Tables[0];
        //int count_bhg = dt_06.Rows.Count;

        sql = @"exec [usp_app_bhgp_Apply_list_dv_V1_New] '','','9998'";
        DataTable dt_98 = SQLHelper.Query(sql).Tables[0];
        int count_bhg = dt_98.Rows.Count;

        Label2.Text = count_bhg.ToString();
    }
}