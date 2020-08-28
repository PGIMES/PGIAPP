using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Trace_byCode : System.Web.UI.Page
{
    public DataSet ds;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }


        TraceByDH(Request.QueryString["dh"].ToString());

    }

    public   void  TraceByDH(string dh)
    {

        string sql = @"MES_APP_TraceByCode '{0}'";
        ds  = SQLHelper.Query(string.Format(sql, dh)) ;
        

    }


}
