using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_SL : System.Web.UI.Page
{
    public string _workshop = "";
    public string _need_no = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        _workshop = Request.QueryString["workshop"].ToString();

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>layer.alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        _need_no = Request.QueryString["need_no"].ToString();

        if (!IsPostBack)
        {
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            emp_code_name.Text = lu.WorkCode + lu.UserName;
            //emp_code_name.Text = "02432何桂勤";

            need_no.Text = _need_no;
            init_data(_need_no);
        }
    }

    void init_data(string need_no)
    {
        string sql = @"exec [usp_app_SL_init] '{0}'";
        sql = string.Format(sql, need_no);
        DataSet ds = SQLHelper.Query(sql);

        DataTable dt = ds.Tables[0];
        listBxInfo.DataSource = dt;
        listBxInfo.DataBind();

        pgino.Text = dt.Rows[0]["pgino"].ToString();
        pn.Text = dt.Rows[0]["pn"].ToString();
        domain.Text = dt.Rows[0]["domain"].ToString();

        txt_sy_qty.Text= dt.Rows[0]["sy_qty"].ToString(); cur_sy_qty.Text = dt.Rows[0]["sy_qty"].ToString();
        txt_act_date.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm");

        sku_area.Text = dt.Rows[0]["sku_area"].ToString();

        listBx_lotno.DataSource = ds.Tables[1];
        listBx_lotno.DataBind();
    }

    [WebMethod]
    public static string lotno_change(string pgino, string lotno,string need_no, string domain)
    {
        string re_sql = @"exec [usp_app_SL_lot_change_qad_V1] '{0}', '{1}', '{2}'";
        re_sql = string.Format(re_sql, pgino, lotno, need_no);
        DataSet ds = SQLHelper.Query(re_sql);

        DataTable re_dt = ds.Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        string qty = "", loc_from = "", loc_to = "", pgino_yn = "";
        if (flag == "N")
        {
            DataTable dt = ds.Tables[1];
            loc_to = dt.Rows[0][0].ToString();
            pgino_yn = ds.Tables[2].Rows[0][0].ToString();

            DataTable ldt = new DataTable();
            string sqlStr = ""; string ldt_source = "";
            if (pgino_yn == "Y")
            {
                sqlStr = @"select ld_loc,ld_qty_oh from pub.ld_det where ld_status in('FG-ZONE','RM-ZONE') and ld_part='{0}' and ld_ref='{1}' with (nolock)";
                sqlStr = string.Format(sqlStr, pgino, lotno);
                ldt = QadOdbcHelper.GetODBCRows(sqlStr);

                ldt_source = "1";
            }

            //1，未获取到高架库位的参考号，需要继续获取线边库的 2，直接需要获取线边库的参考号
            if (ldt.Rows.Count == 0)
            {
                //sqlStr = @"select ld_loc,ld_qty_oh from pub.ld_det where ld_status='WIP' and ld_part='" + pgino + "' and ld_ref='" + lotno + "' and ld_loc='" + loc_to + "' with (nolock)";
                sqlStr = @"select ld_loc,ld_qty_oh,ld_part,ld_status from pub.ld_det where ld_ref='" + lotno + "' with (nolock)";
                ldt = QadOdbcHelper.GetODBCRows(sqlStr);

                ldt_source = "2";
            }

            if (ldt == null)
            {
                flag = "Y"; msg = "Lot No:" + lotno + "不存在";
            }
            else if (ldt.Rows.Count <= 0)
            {
                flag = "Y"; msg = "Lot No:" + lotno + "不存在";
            }
            else
            {
                if (ldt_source == "1")
                {
                    flag = "N"; msg = "";                    
                }
                else if (ldt_source == "2")
                {
                    if (ldt.Rows[0]["ld_part"].ToString() != pgino)
                    {
                        flag = "Y"; msg = "物料号不一致.QAD物料号:" + ldt.Rows[0]["ld_part"].ToString() + " 当前物料号:" + pgino;
                    }
                    else if (ldt.Rows[0]["ld_loc"].ToString() != loc_to)
                    {
                        flag = "Y"; msg = "库位不一致.QAD库位:" + ldt.Rows[0]["ld_loc"].ToString() + " 当前库位:" + loc_to;
                    }
                    else if (ldt.Rows[0]["ld_status"].ToString().ToUpper() != "WIP")
                    {
                        flag = "Y"; msg = "QAD状态不是WIP.当前QAD状态:" + ldt.Rows[0]["ld_status"].ToString();
                    }
                    else
                    {
                        flag = "N"; msg = "";
                    }
                }
            }


            if (flag == "N")
            {
                loc_from = ldt.Rows[0]["ld_loc"].ToString();
                float qty_c = Convert.ToSingle(ldt.Rows[0]["ld_qty_oh"].ToString());

                string sql_q = @"exec [usp_app_SL_lot_change_qad_qty] '{0}', '{1}', {2}, '{3}', '{4}'";
                sql_q = string.Format(sql_q, pgino, lotno, qty_c, need_no, domain);
                DataTable re_dt_q = SQLHelper.Query(sql_q).Tables[0];

                flag = re_dt_q.Rows[0][0].ToString();
                msg = re_dt_q.Rows[0][1].ToString();

                if (flag == "N")
                {
                    qty = qty_c.ToString();
                }
            }
        }

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\",\"qty\":\"" + qty + "\",\"loc_from\":\"" + loc_from + "\",\"loc_to\":\"" + loc_to + "\",\"pgino_yn\":\"" + pgino_yn + "\"}]";
        return result;

    }
    
    protected void lk_lotno_qad_Click(object sender, EventArgs e)
    {
        if (listBx_lotno_qad.Visible == true)
        {
            listBx_lotno_qad.Visible = false;
            return;
        }
        else
        {
            listBx_lotno_qad.Visible = true;
        }

        DataTable ldt = new DataTable();

        //送料信息里，第一笔 绑定库存明细里的
        string sqlStr = @"select top 2 ld_part,ld_ref,ld_loc,cast(cast(ld_qty_oh as numeric(18,4)) as float) ld_qty_oh from pub.ld_det 
                            where ld_status in('FG-ZONE','RM-ZONE') and ld_part='{0}' and ld_qty_oh>0
                            order by ld_date,ld_ref 
                            with (nolock)";
        sqlStr = string.Format(sqlStr, pgino.Text);
        ldt = QadOdbcHelper.GetODBCRows(sqlStr);

        string flag = "N";
        string msg = "";

        if (ldt.Rows.Count <= 0)
        {
            flag = "Y"; msg = "没有符合条件的Lot No";
        }

        if (flag == "Y")
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "$.toptip('没有符合条件的Lot No', 'warning');", true);
            return;
        }

        
        string re_sql = @"exec [usp_app_SL_lot_change_loc] '{0}'";
        re_sql = string.Format(re_sql, pgino.Text);
        DataSet ds = SQLHelper.Query(re_sql);

        DataTable re_dt = ds.Tables[0];
        flag = re_dt.Rows[0][0].ToString();
        msg = re_dt.Rows[0][1].ToString();

        if (flag == "Y")
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsuccess", "$.toptip('"+ msg + "', 'warning');", true);
            return;
        }

        DataTable dt = ds.Tables[1];
        string loc_to = dt.Rows[0][0].ToString();

        ldt.Columns.Add("sku_area", typeof(string)); ldt.Columns.Add("loc_to", typeof(string));
        foreach (DataRow row in ldt.Rows)
        {
            row["sku_area"] = sku_area.Text; row["loc_to"] = loc_to;
        }

        listBx_lotno_qad.DataSource = ldt;
        listBx_lotno_qad.DataBind();

    }

    [WebMethod]
    public static string sure2(string _emp_code_name, string need_no, string lotno, string act_qty, string pgino, string pn
        , string comment, string loc_from, string loc_to, string sku_area, string pgino_yn)
    {
        string flag = "N", msg = "";

        //判断是否是数据库第一笔数据
        if (pgino_yn == "Y")
        {
            if (loc_from != loc_to)
            {
                DataTable ldt = new DataTable();
                string sqlStr = @"select top 1 ld_ref,ld_loc,ld_qty_oh from pub.ld_det where ld_status in('FG-ZONE','RM-ZONE') and ld_part='{0}' and ld_qty_oh>0
                            order by ld_date,ld_ref  with (nolock)";
                sqlStr = string.Format(sqlStr, pgino);
                ldt = QadOdbcHelper.GetODBCRows(sqlStr);

                if (ldt.Rows.Count <= 0)
                {
                    flag = "Y"; msg = "QAD没有可移到线边库的Lot No";
                }
                else
                {
                    if (ldt.Rows[0]["ld_ref"].ToString() == lotno)
                    {
                        //验证高架库位及数量是否相等
                        if (ldt.Rows[0]["ld_loc"].ToString() != loc_from)
                        {
                            flag = "Y"; msg = "库位不一致,QAD:" + ldt.Rows[0]["ld_loc"].ToString() + "当前:" + loc_from;
                        }
                        if ((Convert.ToSingle(ldt.Rows[0]["ld_qty_oh"].ToString())).ToString() != act_qty)
                        {
                            flag = "Y"; msg = "数量不相等,QAD:"+ (Convert.ToSingle(ldt.Rows[0]["ld_qty_oh"].ToString())).ToString() + "当前:" + act_qty;
                        }
                    }
                    else//提示出来，询问是否继续送料
                    {
                        flag = "Y_S"; msg = "QAD第一笔Lot No" + ldt.Rows[0]["ld_loc"].ToString() + ",当前:"+ lotno;
                    }
                }

            }
        }

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }

    [WebMethod]
    public static string sl2(string _emp_code_name, string need_no, string lotno, string act_qty, string pgino, string pn
        , string comment, string loc_from, string loc_to, string sku_area, string pgino_yn)
    {
        string flag = "N", msg = "";

        string re_sql = @"exec [usp_app_SL] '{0}', '{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}'";
        re_sql = string.Format(re_sql, _emp_code_name, need_no, lotno, act_qty, pgino, pn, comment, loc_from, loc_to, sku_area);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        flag = re_dt.Rows[0][0].ToString();
        msg = re_dt.Rows[0][1].ToString();

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }
    [WebMethod]
    public static string cancel2(string _emp_code_name, string need_no)
    {
        string flag = "N", msg = "";

        string re_sql = @"exec [usp_app_SL_cancel] '{0}', '{1}'";
        re_sql = string.Format(re_sql, _emp_code_name, need_no);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        flag = re_dt.Rows[0][0].ToString();
        msg = re_dt.Rows[0][1].ToString();

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }


    /*
    protected void btn_sl_Click(object sender, EventArgs e)
    {
        btn_sl.Text = "送料中。。。。"; btn_sl.Enabled = false;

        string re_sql = @"exec [usp_app_SL] '{0}', '{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}'";
        re_sql = string.Format(re_sql, emp_code_name.Text, need_no.Text,lot_no.Text,act_qty.Text, pgino.Text, pn.Text,comment.Value,loc_from.Text, loc_to.Text, sku_area.Text);
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
            btn_sl.Text = "送料"; btn_sl.Enabled = true;
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('失败：" + msg + "')", true);
        }

    }

    protected void btn_cancel_Click(object sender, EventArgs e)
    {
        btn_cancel.Text = "取消送料中。。。。"; btn_cancel.Enabled = false;

        string re_sql = @"exec [usp_app_SL_cancel] '{0}', '{1}'";
        re_sql = string.Format(re_sql, emp_code_name.Text, need_no.Text);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        if (flag == "N")
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('" + msg + "');", true);
            Response.Redirect("/workorder/YL_list_new.aspx?workshop="+_workshop);
        }
        else
        {
            btn_cancel.Text = "取消送料"; btn_cancel.Enabled = true;
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('失败：" + msg + "')", true);
        }
    }
    */
}