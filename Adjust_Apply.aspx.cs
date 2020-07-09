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

    protected void Page_Load(object sender, EventArgs e)
    {
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
        }
    }



    [WebMethod]
    public static string dh_change(string pgino, string domain)
    {
        string pn = "", descr = "", b_use_routing = "", b_op_one = "";

        string re_sql = @"exec [usp_app_Adjust_Apply_dh_change] '{0}','{1}'";
        re_sql = string.Format(re_sql, pgino, domain);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];

        pn = re_dt.Rows[0]["pn"].ToString();
        descr = re_dt.Rows[0]["descr"].ToString();
        b_use_routing = re_dt.Rows[0]["b_use_routing"].ToString();
        b_op_one = re_dt.Rows[0]["b_op_one"].ToString();

        string result = "[{\"pn\":\"" + pn + "\",\"descr\":\"" + descr + "\",\"b_use_routing\":\"" + b_use_routing + "\",\"b_op_one\":\"" + b_op_one + "\"}]";
        return result;
    }

    [WebMethod]
    public static string save2(string _emp_code_name, string _workorder, string _pgino, string _pn, string _descr, string _op
        , string _qty, string _reason, string _comment, string _b_use_routing, string _ref_order, string _b_op_one, string _lot_no_fixed)
    {
        string flag = "N", msg = "";
        //int op_code = Convert.ToInt32(_op.Substring(0, _op.IndexOf('-')));
        //string re_sql = "";
        //if (op_code <= 700)
        //{
        //    if (op_code > 100 && op_code < 600)
        //    {
        //        re_sql = @"exec usp_app_bhgp_Apply_V1 '{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{11}','{12}'";
        //    }
        //    else if (op_code >= 600 && op_code < 700)
        //    {
        //        if (_b_use_routing == "0")
        //        {
        //            re_sql = @"exec usp_app_bhgp_Apply_V1 '{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{11}','{12}'";
        //        }
        //        else
        //        {
        //            re_sql = @"exec usp_app_bhgp_Apply_QC_V1 '{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}'";
        //        }
        //    }
        //    else if (op_code == 700)
        //    {
        //        re_sql = @"exec usp_app_bhgp_Apply_QC_V1 '{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}'";
        //    }
        //}
        //else if (op_code == 999 || op_code == 998)//成品库、半成品库
        //{
        //    re_sql = @"exec usp_app_bhgp_Apply_CP '{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{10}'";
        //}
        //else
        //{
        //    flag = "Y"; msg = "开发中.....";
        //}

        //if (flag == "N")
        //{
        //    re_sql = string.Format(re_sql, _emp_code_name, _workorder, _pgino, _pn, _descr, _op
        //   , _qty, _reason, _comment, _b_use_routing, _ref_order, _b_op_one, _lot_no_fixed);
        //    DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        //    flag = re_dt.Rows[0][0].ToString();
        //    msg = re_dt.Rows[0][1].ToString();
        //}
        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }
}