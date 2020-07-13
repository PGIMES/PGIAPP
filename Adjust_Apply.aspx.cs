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

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["formno"] != null) { _formno = Request.QueryString["formno"].ToString(); }

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

            formno.Text = _formno;
            //init_data(_formno);
        }
    }



    [WebMethod]
    public static string dh_change(string dh, string source)
    {
        string flag = "N", msg = "";
        string pgino = "", pn = "", from_qty = "", flagwhere = "", need_no = "";

        string re_sql = @"exec [usp_app_Adjust_Apply_dh_change] '{0}','{1}'";
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

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\",\"pgino\":\"" + pgino + "\",\"pn\":\"" + pn + "\",\"from_qty\":\"" + from_qty 
            + "\",\"flagwhere\":\"" + flagwhere + "\",\"need_no\":\"" + need_no + "\"}]";
        return result;
    }

    [WebMethod]
    public static string save2(string _emp_code_name, string _source, string _dh, string _pgino, string _pn, string _from_qty
        , string _adj_qty, string _comment, string _flagwhere, string _need_no)
    {
        string flag = "N", msg = "";
        string re_sql = "";
        if (_source == "二车间" || _source == "四车间")
        {
            re_sql = @"exec usp_app_Adjust_Apply '{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}'";
        }
        else
        {
            flag = "Y"; msg = "开发中.....";
        }

        if (flag == "N")
        {
            re_sql = string.Format(re_sql, _emp_code_name, _source, _dh, _pgino, _pn, _from_qty, _adj_qty
           , _comment, _flagwhere, _need_no);
            DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
            flag = re_dt.Rows[0][0].ToString();
            msg = re_dt.Rows[0][1].ToString();
        }
        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }
}