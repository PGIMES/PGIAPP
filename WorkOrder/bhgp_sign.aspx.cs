﻿using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_bhgp_sign : System.Web.UI.Page
{
    public string _workshop = "";
    public string _workorder = "";
    public string _workorder_f = "";
    public string _stepid = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        _workshop = Request.QueryString["workshop"].ToString();

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>layer.alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        _workorder = Request.QueryString["workorder"].ToString();
        _workorder_f = Request.QueryString["workorder_f"].ToString();
        _stepid = Request.QueryString["stepid"].ToString();

        if (!IsPostBack)
        {
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            emp_code_name.Text = lu.WorkCode + lu.UserName;
            domain.Text = lu.Domain;
            //emp_code_name.Text = "02432何桂勤";
            //domain.Text = "200";

            workorder.Text = _workorder; workorder_f.Text = _workorder_f; stepid.Text = _stepid;
            init_data(_workorder, _workorder_f);
        }
    }

    //void init_data(string workorder,string workorder_f)
    //{
    //    string sql = @"exec [usp_app_bhgp_deal_sign_init] '{0}','{1}'";
    //    sql = string.Format(sql, workorder, _workorder_f);
    //    DataSet ds = SQLHelper.Query(sql);

    //    DataTable dt = ds.Tables[0];
    //    listBxInfo.DataSource = dt;
    //    listBxInfo.DataBind();

    //    DataTable dt1 = ds.Tables[1];
    //    Repeater_cz.DataSource = dt1;
    //    Repeater_cz.DataBind();
    //}

    void init_data(string workorder, string workorder_f)
    {
        string sql = @"exec [usp_app_bhgp_sign_init] '{0}','{1}'";
        sql = string.Format(sql, workorder, _workorder_f);
        DataSet ds = SQLHelper.Query(sql);

        DataTable dt = ds.Tables[0];
        listBxInfo.DataSource = dt;
        listBxInfo.DataBind();
        lbl_fg.Text = dt.Rows[0]["cur_result"].ToString();
        pgino.Text = dt.Rows[0]["pgino"].ToString();
        workorder_qc.Text = dt.Rows[0]["workorder_qc"].ToString();

        DataTable dt1 = ds.Tables[1];
        Repeater_cz_one.DataSource = dt1;
        Repeater_cz_one.DataBind();

        DataTable dt2 = ds.Tables[2];
        Repeater_fg.DataSource = dt2;
        Repeater_fg.DataBind();

        DataTable dt3 = ds.Tables[3];
        Repeater_cz_again.DataSource = dt3;
        Repeater_cz_again.DataBind();

        DataTable dt4 = ds.Tables[4];
        Repeater_fx.DataSource = dt4;
        Repeater_fx.DataBind();

        DataTable dt5 = ds.Tables[5];
        Repeater_cz_fx_again.DataSource = dt5;
        Repeater_cz_fx_again.DataBind();

        ViewState["dt1"] = dt1.Rows.Count.ToString();
        ViewState["dt2"] = dt2.Rows.Count.ToString();
        ViewState["dt3"] = dt3.Rows.Count.ToString();
        ViewState["dt4"] = dt4.Rows.Count.ToString();
        ViewState["dt5"] = dt5.Rows.Count.ToString();
    }

    [WebMethod]
    public static string init_btn(string stepid, string workshop, string pgino,string emp)
    {
        string re_sql = @"exec [usp_app_bhgp_sign_init_btn] '{0}', '{1}', '{2}', '{3}'";
        re_sql = string.Format(re_sql, stepid, workshop, pgino, emp);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];

        string btn_sure = re_dt.Rows[0][0].ToString();
        string btn_cancel = re_dt.Rows[0][1].ToString();

        string result = "[{\"btn_sure\":\"" + btn_sure + "\",\"btn_cancel\":\"" + btn_cancel + "\"}]";
        return result;

    }

    protected void listBxInfo_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl("listBx_lotno");
            DataRowView item = (DataRowView)e.Item.DataItem;

            DataTable dt_wk = new DataTable();
            string sql = @"select id,lot_no,qty,workorder from Mes_App_WorkOrder_Ng_Detail where workorder='{0}' order by id";
            sql = string.Format(sql, item["workorder"].ToString());
            dt_wk = SQLHelper.Query(sql).Tables[0];

            detail.DataSource = dt_wk;
            detail.DataBind();
        }
    }

    protected void Repeater_cz_one_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView item = (DataRowView)e.Item.DataItem;

            Repeater detail = (Repeater)e.Item.FindControl("Repeater_cz_one_dt");
            DataTable dt_wk = new DataTable();
            string sql = @"select * from Mes_App_WorkOrder_Ng_deal_Detail where workorder_f='{0}' order by num";
            sql = string.Format(sql, item["workorder_f"].ToString());
            dt_wk = SQLHelper.Query(sql).Tables[0];

            detail.DataSource = dt_wk;
            detail.DataBind();

            Repeater detail_sg = (Repeater)e.Item.FindControl("Repeater_sg_one_dt");
            DataTable dt_wk_sg = new DataTable();
            string sql_sg = @"exec [usp_app_bhgp_sign_record] '{0}'";
            sql_sg = string.Format(sql_sg, item["workorder_f"].ToString());
            dt_wk_sg = SQLHelper.Query(sql_sg).Tables[0];

            detail_sg.DataSource = dt_wk_sg;
            detail_sg.DataBind();
        }
    }


    protected void Repeater_fg_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView item = (DataRowView)e.Item.DataItem;

            Repeater detail = (Repeater)e.Item.FindControl("Repeater_fg_dt");
            DataTable dt_wk = new DataTable();
            string sql = @"select * from Mes_App_WorkOrder_Ng_deal_Detail where workorder_f='{0}' order by num";
            sql = string.Format(sql, item["workorder_f"].ToString());
            dt_wk = SQLHelper.Query(sql).Tables[0];

            detail.DataSource = dt_wk;
            detail.DataBind();

            Repeater detail_sg = (Repeater)e.Item.FindControl("Repeater_fg_sg_dt");
            DataTable dt_wk_sg = new DataTable();
            string sql_sg = @"exec [usp_app_bhgp_sign_record] '{0}','返工'";
            sql_sg = string.Format(sql_sg, item["workorder_f"].ToString());
            dt_wk_sg = SQLHelper.Query(sql_sg).Tables[0];

            detail_sg.DataSource = dt_wk_sg;
            detail_sg.DataBind();
        }
    }

    protected void Repeater_cz_again_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView item = (DataRowView)e.Item.DataItem;

            Repeater detail = (Repeater)e.Item.FindControl("Repeater_cz_again_dt");
            DataTable dt_wk = new DataTable();
            string sql = @"select * from Mes_App_WorkOrder_Ng_deal_Detail where workorder_f='{0}' order by num";
            sql = string.Format(sql, item["workorder_f"].ToString());
            dt_wk = SQLHelper.Query(sql).Tables[0];

            detail.DataSource = dt_wk;
            detail.DataBind();

            Repeater detail_sg = (Repeater)e.Item.FindControl("Repeater_sg_again_dt");
            DataTable dt_wk_sg = new DataTable();
            string sql_sg = @"exec [usp_app_bhgp_sign_record] '{0}'";
            sql_sg = string.Format(sql_sg, item["workorder_f"].ToString());
            dt_wk_sg = SQLHelper.Query(sql_sg).Tables[0];

            detail_sg.DataSource = dt_wk_sg;
            detail_sg.DataBind();
        }
    }
   

    protected void Repeater_fx_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView item = (DataRowView)e.Item.DataItem;

            Repeater detail = (Repeater)e.Item.FindControl("Repeater_fx_dt");
            DataTable dt_wk = new DataTable();
            string sql = @"select * from Mes_App_WorkOrder_Ng_deal_Detail where workorder_f='{0}' order by num";
            sql = string.Format(sql, item["workorder_f"].ToString());
            dt_wk = SQLHelper.Query(sql).Tables[0];

            detail.DataSource = dt_wk;
            detail.DataBind();

            Repeater detail_sg = (Repeater)e.Item.FindControl("Repeater_fx_sg_dt");
            DataTable dt_wk_sg = new DataTable();
            string sql_sg = @"exec [usp_app_bhgp_sign_record] '{0}','分选'";
            sql_sg = string.Format(sql_sg, item["workorder_f"].ToString());
            dt_wk_sg = SQLHelper.Query(sql_sg).Tables[0];

            detail_sg.DataSource = dt_wk_sg;
            detail_sg.DataBind();
        }
    }

    protected void Repeater_cz_fx_again_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView item = (DataRowView)e.Item.DataItem;

            Repeater detail = (Repeater)e.Item.FindControl("Repeater_cz_fx_again_dt");
            DataTable dt_wk = new DataTable();
            string sql = @"select * from Mes_App_WorkOrder_Ng_deal_Detail where workorder_f='{0}' order by num";
            sql = string.Format(sql, item["workorder_f"].ToString());
            dt_wk = SQLHelper.Query(sql).Tables[0];

            detail.DataSource = dt_wk;
            detail.DataBind();

            Repeater detail_sg = (Repeater)e.Item.FindControl("Repeater_sg_fx_again_dt");
            DataTable dt_wk_sg = new DataTable();
            string sql_sg = @"exec [usp_app_bhgp_sign_record] '{0}'";
            sql_sg = string.Format(sql_sg, item["workorder_f"].ToString());
            dt_wk_sg = SQLHelper.Query(sql_sg).Tables[0];

            detail_sg.DataSource = dt_wk_sg;
            detail_sg.DataBind();
        }
    }

    //protected void Repeater_cz_ItemDataBound(object sender, RepeaterItemEventArgs e)
    //{
    //    if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
    //    {
    //        DataRowView item = (DataRowView)e.Item.DataItem;

    //        Repeater detail = (Repeater)e.Item.FindControl("Repeater_cz_dt");
    //        DataTable dt_wk = new DataTable();
    //        string sql = @"select * from Mes_App_WorkOrder_Ng_deal_Detail where workorder_f='{0}' order by num";
    //        sql = string.Format(sql, item["workorder_f"].ToString());
    //        dt_wk = SQLHelper.Query(sql).Tables[0];

    //        detail.DataSource = dt_wk;
    //        detail.DataBind();

    //        Repeater detail_sg = (Repeater)e.Item.FindControl("Repeater_sg_dt");
    //        DataTable dt_wk_sg = new DataTable();
    //        string sql_sg = @"exec [usp_app_bhgp_sign_record] '{0}'";
    //        sql_sg = string.Format(sql_sg, item["workorder_f"].ToString());
    //        dt_wk_sg = SQLHelper.Query(sql_sg).Tables[0];

    //        detail_sg.DataSource = dt_wk_sg;
    //        detail_sg.DataBind();
    //    }
    //}

    protected void btn_sure_Click(object sender, EventArgs e)
    {
        btn_sign.Text = "确认中。。。。"; btn_sign.Enabled = false;

        string _fg_comment = "";
        if (_stepid == "0001")//需返工
        {
            _fg_comment = fg_comment.Value.Trim();
            if (_fg_comment == "")
            {
                btn_sign.Text = "确认"; btn_sign.Enabled = true;
                ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('【返工说明】不可为空')", true);
                return;
            }
        }
        string _sign_comment = sign_comment.Value.Trim();

        string re_sql = @"exec [usp_app_bhgp_sign] '{0}', '{1}','{2}','{3}','{4}','{5}','{6}'";
        re_sql = string.Format(re_sql, emp_code_name.Text, workorder.Text, workorder_f.Text, stepid.Text, _fg_comment, _sign_comment, workorder_qc.Text);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        if (flag == "N")
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('" + msg + "');", true);
            Response.Redirect("/workorder/bhgp_Apply_list.aspx?workshop=" + _workshop);
        }
        else
        {
            btn_sign.Text = "确认"; btn_sign.Enabled = true;
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('失败：" + msg + "')", true);
        }


    }

    protected void btn_cancel_Click(object sender, EventArgs e)
    {
        btn_cancel.Text = "退回中。。。。"; btn_cancel.Enabled = false;

        string _sign_comment = sign_comment.Value.Trim();
        if (_sign_comment == "")
        {
            btn_cancel.Text = "退回"; btn_cancel.Enabled = true;
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('【签核意见】不可为空')", true);
            return;
        }

        string re_sql = @"exec [usp_app_bhgp_sign_cancel] '{0}', '{1}','{2}','{3}','{4}'";
        re_sql = string.Format(re_sql, emp_code_name.Text, workorder.Text, workorder_f.Text, stepid.Text, _sign_comment);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        if (flag == "N")
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('" + msg + "');", true);
            Response.Redirect("/workorder/bhgp_Apply_list.aspx?workshop=" + _workshop);
        }
        else
        {
            btn_cancel.Text = "退回"; btn_cancel.Enabled = true;
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('失败：" + msg + "')", true);
        }

    }


}

