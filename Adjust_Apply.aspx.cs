using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Adjust_Apply : System.Web.UI.Page
{
    public string _formno = "";
    public string _stepid = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["formno"] != null) { _formno = Request.QueryString["formno"].ToString(); }
        if (Request.QueryString["stepid"] != null) { _stepid = Request.QueryString["stepid"].ToString(); }

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

            formno.Text = _formno; stepid.Text = _stepid;

            if (_formno != "")
            {
                init_data(_formno, _stepid);
            }
            
        }
    }

    void init_data(string formno, string stepid)
    {
        string sql = @"exec [usp_app_Adjust_Apply_init_V1] '{0}','{1}'";
        sql = string.Format(sql, formno, stepid);
        DataSet ds = SQLHelper.Query(sql);

        DataTable dt = ds.Tables[0];
        if (dt.Rows.Count == 1)
        {
            emp_code_name_db.Text = dt.Rows[0]["emp_code"].ToString() + dt.Rows[0]["emp_name"].ToString();
            source.Text = dt.Rows[0]["source"].ToString();
            dh.Text = dt.Rows[0]["lot_no"].ToString(); 
            pgino.Text = dt.Rows[0]["pgino"].ToString();
            pn.Text = dt.Rows[0]["pn"].ToString();
            from_qty_db.Text = "原数量"+dt.Rows[0]["from_qty"].ToString(); from_qty_db.Visible = true;
            adj_qty.Text = dt.Rows[0]["adj_qty"].ToString();
            comment.Value = dt.Rows[0]["remark"].ToString();

            //改三个字段proc重新复制喽
            if (dt.Rows[0]["flagwhere"].ToString() != "QAD")
            {
                from_qty.Text = dt.Rows[0]["from_qty_cur"].ToString();
                need_no.Text = dt.Rows[0]["need_no"].ToString();
                flagwhere.Text = dt.Rows[0]["flagwhere"].ToString();
                loc.Text = dt.Rows[0]["loc"].ToString();
            }
            else
            {
                DataTable ldt = new DataTable();
                string sqlStr = @"select ld_part,ld_loc,cast(cast(ld_qty_oh as numeric(18,4)) as float) ld_qty_oh 
                                from pub.ld_det where ld_ref='{0}' and ld_domain='200' and ld_loc='{1}' with (nolock)";
                sqlStr = string.Format(sqlStr, dt.Rows[0]["lot_no"].ToString(), dt.Rows[0]["loc"].ToString());
                ldt = QadOdbcHelper.GetODBCRows(sqlStr);
                if (ldt == null) { }
                else if (ldt.Rows.Count <= 0) { }
                else//QAD存在
                {
                    from_qty.Text = ldt.Rows[0]["ld_qty_oh"].ToString();
                    flagwhere.Text = "QAD";
                    need_no.Text = "";
                    loc.Text = ldt.Rows[0]["ld_loc"].ToString();
                }
            }
        }

        DataTable dt_sg = ds.Tables[1];
        Repeater_sg.DataSource = dt_sg;
        Repeater_sg.DataBind();
    }


    [WebMethod]
    public static string dh_change(string dh, string source)
    {
        string flag = "N", msg = "";
        string pgino = "", pn = "", from_qty = "", flagwhere = "", need_no = "", loc = "";

        #region 车间

        if (source == "二车间" || source == "三车间" || source == "四车间")
        {
            string re_sql = @"exec [usp_app_Adjust_Apply_dh_change_V1] '{0}','{1}'";
            re_sql = string.Format(re_sql, dh, source);
            DataSet ds = SQLHelper.Query(re_sql);

            flag = ds.Tables[0].Rows[0][0].ToString();
            msg = ds.Tables[0].Rows[0][1].ToString();

            if (flag == "N")
            {
                DataTable re_dt = ds.Tables[1];
                pgino = re_dt.Rows[0]["pgino"].ToString();
                pn = re_dt.Rows[0]["pn"].ToString();
                from_qty = re_dt.Rows[0]["from_qty"].ToString();
                flagwhere = re_dt.Rows[0]["flagwhere"].ToString();
                need_no = re_dt.Rows[0]["need_no"].ToString();
            }

            if (flag == "Y1")
            {
                //再次判断是否是QAD的参考号
                DataTable ldt = new DataTable();
                string sqlStr = @"select ld_part,ld_loc,ld_status,cast(cast(ld_qty_oh as numeric(18,4)) as float) ld_qty_oh 
                                from pub.ld_det where ld_ref='{0}' and ld_domain='200' with (nolock)";
                sqlStr = string.Format(sqlStr, dh);
                ldt = QadOdbcHelper.GetODBCRows(sqlStr);
                if (ldt == null)
                {
                    flag = "Y"; msg = msg + "/QAD";
                }
                else if (ldt.Rows.Count <= 0)
                {
                    flag = "Y"; msg = msg + "/QAD";
                }
                else//QAD存在
                {
                    //零件号
                    string sql_s = @"select pt_desc1,pt_prod_line from [172.16.5.26].qad.dbo.qad_pt_mstr where pt_part='" + ldt.Rows[0]["ld_part"].ToString() + "' and pt_domain='200'";
                    DataTable dt_s = SQLHelper.Query(sql_s).Tables[0];

                    if (dt_s == null)
                    {
                        flag = "Y"; msg = "物料号" + ldt.Rows[0]["ld_part"].ToString() + ",对应的零件号不存在";
                    }
                    else if (dt_s.Rows.Count <= 0)
                    {
                        flag = "Y"; msg = "物料号" + ldt.Rows[0]["ld_part"].ToString() + "对应的零件号不存在";
                    }
                    else//QAD存在
                    {
                        pn = dt_s.Rows[0]["pt_desc1"].ToString();

                        if (source == "二车间" || source == "四车间")
                        {
                            if (ldt.Rows[0]["ld_loc"].ToString() != "9000" && ldt.Rows[0]["ld_status"].ToString().ToUpper() != "WIP")
                            {
                                flag = "Y"; msg = "单号" + dh + ",库位不是9000、状态WIP";
                            }
                        }
                        if (source == "三车间")
                        {
                            if (dt_s.Rows[0]["pt_prod_line"].ToString().StartsWith("3"))
                            {
                                if (ldt.Rows[0]["ld_loc"].ToString() != "9000")
                                {
                                    flag = "Y"; msg = "单号" + dh + ",库位不是9000";
                                }
                            }
                            if (dt_s.Rows[0]["pt_prod_line"].ToString().StartsWith("2"))
                            {
                                if (ldt.Rows[0]["ld_loc"].ToString() != "4009")
                                {
                                    flag = "Y"; msg = "单号" + dh + ",库位不是4009";
                                }
                            }
                        }

                        if (flag == "Y1")
                        {
                            flag = "N"; msg = "";
                            pgino = ldt.Rows[0]["ld_part"].ToString();
                            from_qty = ldt.Rows[0]["ld_qty_oh"].ToString();
                            flagwhere = "QAD";
                            need_no = "";
                            loc = ldt.Rows[0]["ld_loc"].ToString();
                        }
                    }
                }

            }

        }
        #endregion


        #region 库内

        if (source == "原材料库" || source == "成品库" || source == "半成品库")
        {
            //再次判断是否是QAD的参考号
            DataTable ldt = new DataTable();
            string sqlStr = @"select ld_part,ld_loc,ld_status,cast(cast(ld_qty_oh as numeric(18,4)) as float) ld_qty_oh 
                            from pub.ld_det where ld_ref='{0}' and ld_domain='200' with (nolock)";
            sqlStr = string.Format(sqlStr, dh);
            ldt = QadOdbcHelper.GetODBCRows(sqlStr);
            if (ldt == null)
            {
                flag = "Y"; msg = "单号:" + dh + ",地点:" + source + ",不存在QAD";
            }
            else if (ldt.Rows.Count <= 0)
            {
                flag = "Y"; msg = "单号:" + dh + ",地点:" + source + ",不存在QAD";
            }
            else//QAD存在
            {
                //零件号
                string sql_s = @"select pt_desc1,pt_prod_line from [172.16.5.26].qad.dbo.qad_pt_mstr where pt_part='" + ldt.Rows[0]["ld_part"].ToString() + "' and pt_domain='200'";
                DataTable dt_s = SQLHelper.Query(sql_s).Tables[0];

                if (dt_s == null)
                {
                    flag = "Y"; msg = "物料号" + ldt.Rows[0]["ld_part"].ToString() + ",对应的零件号不存在";
                }
                else if (dt_s.Rows.Count <= 0)
                {
                    flag = "Y"; msg = "物料号" + ldt.Rows[0]["ld_part"].ToString() + "对应的零件号不存在";
                }
                else//QAD存在
                {
                    pn = dt_s.Rows[0]["pt_desc1"].ToString();

                    if (source == "原材料库")
                    {
                        if (dt_s.Rows[0]["pt_prod_line"].ToString().StartsWith("1") == false)
                        {
                            flag = "Y"; msg = "物料号" + ldt.Rows[0]["ld_part"].ToString() + "不是原材料,不能选择【原材料库】.";
                        }
                    }
                    if (source == "半成品库")
                    {
                        if (dt_s.Rows[0]["pt_prod_line"].ToString().StartsWith("2") == false)
                        {
                            flag = "Y"; msg = "物料号" + ldt.Rows[0]["ld_part"].ToString() + "不是半成品,不能选择【半成品库】.";
                        }
                    }
                    if (source == "成品库")
                    {
                        if (dt_s.Rows[0]["pt_prod_line"].ToString().StartsWith("3") == false)
                        {
                            flag = "Y"; msg = "物料号" + ldt.Rows[0]["ld_part"].ToString() + "不是成品,不能选择【成品库】.";
                        }
                    }

                    if (flag == "N")
                    {
                        flag = "N"; msg = "";
                        pgino = ldt.Rows[0]["ld_part"].ToString();
                        from_qty = ldt.Rows[0]["ld_qty_oh"].ToString();
                        flagwhere = "QAD";
                        need_no = "";
                        loc = ldt.Rows[0]["ld_loc"].ToString();
                    }
                }
            }
        }

        #endregion

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\",\"pgino\":\"" + pgino + "\",\"pn\":\"" + pn + "\",\"from_qty\":\"" + from_qty
            + "\",\"flagwhere\":\"" + flagwhere + "\",\"need_no\":\"" + need_no + "\",\"loc\":\"" + loc + "\"}]";
        return result;
    }

    [WebMethod]
    public static string save2(string _emp_code_name, string _source, string _dh, string _pgino, string _pn, string _from_qty
        , string _adj_qty, string _comment, string _flagwhere, string _need_no, string _formno, string _stepid, string _loc)
    {
        string flag = "N", msg = "";
        string re_sql = "";

        if (_flagwhere != "QAD")
        {
            re_sql = @"exec usp_app_Adjust_Apply '{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}'";
        }
        else
        {
            DataTable ldt = new DataTable();
            string sqlStr = @"select ld_part,ld_loc,cast(cast(ld_qty_oh as numeric(18,4)) as float) ld_qty_oh 
                                from pub.ld_det where ld_ref='{0}' and ld_domain='200' and ld_loc='{1}' with (nolock)";
            sqlStr = string.Format(sqlStr, _dh, _loc);
            ldt = QadOdbcHelper.GetODBCRows(sqlStr);
            if (ldt == null) { flag = "Y"; msg = "单号:" + _dh + ",地点:" + _source + ",QAD不存在.请重新打开页面申请."; }
            else if (ldt.Rows.Count <= 0) { flag = "Y"; msg = "单号:" + _dh + ",地点:" + _source + ",QAD不存在.请重新打开页面申请."; }
            else//QAD存在
            {
                if (_from_qty != ldt.Rows[0]["ld_qty_oh"].ToString())
                {
                    flag = "Y"; msg = "单号:" + _dh + ",地点:" + _source + ",QAD【数量】发生异动.请重新打开页面申请.";
                }
                else
                {
                    re_sql = @"exec usp_app_Adjust_Apply_QAD '{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}'";
                }
            }
        }

        if (flag == "N")
        {
            re_sql = string.Format(re_sql, _emp_code_name, _source, _dh, _pgino, _pn, _from_qty, _adj_qty
           , _comment, _flagwhere, _need_no, _formno, _stepid, _loc);
            DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
            flag = re_dt.Rows[0][0].ToString();
            msg = re_dt.Rows[0][1].ToString();
        }
        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }

    [WebMethod]
    public static string cancel2(string _emp_code_name, string _formno, string _stepid, string _comment)
    {
        string flag = "N", msg = "";

        string re_sql = @"exec usp_app_Adjust_Apply_cancel '{0}','{1}','{2}','{3}'";
        re_sql = string.Format(re_sql, _emp_code_name, _formno, _stepid, _comment);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        flag = re_dt.Rows[0][0].ToString();
        msg = re_dt.Rows[0][1].ToString();

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }
}