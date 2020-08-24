using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_Jiaju_Apply : System.Web.UI.Page
{
    public string _workshop = "";
    public string _formno = "";
    public string _stepid = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        _workshop = Request.QueryString["workshop"].ToString();
        if (Request.QueryString["formno"] != null) { _formno = Request.QueryString["formno"].ToString(); }

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>layer.alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        if (!IsPostBack)
        {
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            //emp_code_name.Text = lu.WorkCode + lu.UserName;
            //domain.Text = lu.Domain;
            emp_code_name.Text = "02432何桂勤";
            domain.Text = "200";


            formno.Text = _formno; 

            if (_formno != "")
            {
                init_data(_formno);
            }

        }
    }

    void init_data(string formno)
    {
        string sql = @"exec [usp_app_Jiaju_Apply_init] '{0}'";
        sql = string.Format(sql, formno);
        DataSet ds = SQLHelper.Query(sql);

        DataTable dt = ds.Tables[0];
        if (dt.Rows.Count == 1)
        {
            _stepid = dt.Rows[0]["status"].ToString(); stepid.Text = _stepid;
            //    emp_code_name_db.Text = dt.Rows[0]["emp_code"].ToString() + dt.Rows[0]["emp_name"].ToString();
            //    source.Text = dt.Rows[0]["source"].ToString();
            //    dh.Text = dt.Rows[0]["lot_no"].ToString();
            //    pgino.Text = dt.Rows[0]["pgino"].ToString();
            //    pn.Text = dt.Rows[0]["pn"].ToString();
            //    from_qty_db.Text = "原数量" + dt.Rows[0]["from_qty"].ToString(); from_qty_db.Visible = true;
            //    adj_qty.Text = dt.Rows[0]["adj_qty"].ToString();
            //    comment.Value = dt.Rows[0]["remark"].ToString();

            //    //改三个字段proc重新复制喽
            //    if (dt.Rows[0]["flagwhere"].ToString() != "QAD")
            //    {
            //        from_qty.Text = dt.Rows[0]["from_qty_cur"].ToString();
            //        need_no.Text = dt.Rows[0]["need_no"].ToString();
            //        flagwhere.Text = dt.Rows[0]["flagwhere"].ToString();
            //        loc.Text = dt.Rows[0]["loc"].ToString();
            //    }
            //    else
            //    {
            //        DataTable ldt = new DataTable();
            //        string sqlStr = @"select ld_part,ld_loc,cast(cast(ld_qty_oh as numeric(18,4)) as float) ld_qty_oh 
            //                        from pub.ld_det where ld_ref='{0}' and ld_domain='200' and ld_loc='{1}' with (nolock)";
            //        sqlStr = string.Format(sqlStr, dt.Rows[0]["lot_no"].ToString(), dt.Rows[0]["loc"].ToString());
            //        ldt = QadOdbcHelper.GetODBCRows(sqlStr);
            //        if (ldt == null) { }
            //        else if (ldt.Rows.Count <= 0) { }
            //        else//QAD存在
            //        {
            //            from_qty.Text = ldt.Rows[0]["ld_qty_oh"].ToString();
            //            flagwhere.Text = "QAD";
            //            need_no.Text = "";
            //            loc.Text = ldt.Rows[0]["ld_loc"].ToString();
            //        }
            //    }
            listBxInfo.DataSource = dt;
            listBxInfo.DataBind();
        }

        DataTable dt_sg = ds.Tables[1];
        Repeater_sg.DataSource = dt_sg;
        Repeater_sg.DataBind();
    }

    [WebMethod]
    public static string init_sb_pgino(string domain, string workshop, string emp)
    {
        string result = "";
        string sql = @" exec [usp_app_Jiaju_Apply_sb_pgino] '" + domain + "','" + workshop + "','" + emp + "'";
        DataSet ds = SQLHelper.Query(sql);

        DataTable dt_sb = ds.Tables[0];
        string json_sb = JsonConvert.SerializeObject(dt_sb);

        DataTable dt_pgino = ds.Tables[1];
        string json_pgino = JsonConvert.SerializeObject(dt_pgino);

        result = "[{\"json_sb\":" + json_sb + ",\"json_pgino\":" + json_pgino + "}]";
        return result;

    }

    [WebMethod]
    public static string sb_change(string sb_code, string workshop)
    {
        string result = "";
        string sql = @"select distinct e_code,location,line
	                from Mes_App_Base_Location 
	                where workshop='{0}' and e_code like 'M%' and e_code='{1}'";
        sql = string.Format(sql, workshop, sb_code);
        DataTable dt = SQLHelper.Query(sql).Tables[0];

        string e_code = "", location = "", line = "";
        if (dt.Rows.Count == 1)
        {
            e_code = dt.Rows[0]["e_code"].ToString();
            location = dt.Rows[0]["location"].ToString();
            line = dt.Rows[0]["line"].ToString();
        }

        //换下夹具默认最后一次的换上夹具
        string off_pgino = "", off_jiaju_no = "", off_jiaju_name = "";
        sql = @"select top 1 on_pgino,on_jiaju_no,on_jiaju_name from Mes_App_Jiaju  where status=9 and  workshop='{0}' and sb_code='{1}' order by complete_date desc";
        sql = string.Format(sql, workshop, sb_code);
        DataTable dt_pgino = SQLHelper.Query(sql).Tables[0];
        if (dt_pgino.Rows.Count == 1)
        {
            off_pgino = dt_pgino.Rows[0]["on_pgino"].ToString();
            off_jiaju_no = dt_pgino.Rows[0]["on_jiaju_no"].ToString();
            off_jiaju_name = dt_pgino.Rows[0]["on_jiaju_name"].ToString();
        }

        result = "[{\"e_code\":\"" + e_code + "\",\"location\":\"" + location + "\",\"line\":\"" + line 
            + "\",\"off_pgino\":\"" + off_pgino + "\",\"off_jiaju_no\":\"" + off_jiaju_no + "\",\"off_jiaju_name\":\"" + off_jiaju_name + "\"}]";
        return result;
    }

    [WebMethod]
    public static string pgino_change(string pgino, string domain)
    {
        string result = "";
        string sql = @"select jiajuno title,type value from [172.16.5.26].mes.dbo.JiaJu_List where isnull(status,'')<>'封存' and comp='{0}' and pn like '%{1}%'";
        sql = string.Format(sql, domain, pgino.Substring(2, 3));//"P0599BA"->"599"
        DataTable dt_jj = SQLHelper.Query(sql).Tables[0];
        string json_jj = JsonConvert.SerializeObject(dt_jj);

        result = "[{\"json_jj\":" + json_jj + "}]";
        return result;

    }

    [WebMethod]
    public static string save2(string _emp_code_name, string _workshop, string _sb_code, string _sb_desc, string _line, string _off_pgino, string _off_jiaju_no
        , string _off_jiaju_name, string _on_pgino, string _on_jiaju_no, string _on_jiaju_name, string _formno, string _stepid)
    {
        string flag = "N", msg = "";
        string re_sql = @"";

        if (_formno == "")
        {
            re_sql = @"exec usp_app_Jiaju_Apply '{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}'";
            re_sql = string.Format(re_sql, _emp_code_name, _workshop, _sb_code, _sb_desc, _line, _off_pgino, _off_jiaju_no, _off_jiaju_name
                , _on_pgino, _on_jiaju_no, _on_jiaju_name);
        }
        
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        flag = re_dt.Rows[0][0].ToString();
        msg = re_dt.Rows[0][1].ToString();

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }


}