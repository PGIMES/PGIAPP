using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class prod_qcc_timeline_info_v3 : System.Web.UI.Page
{
    public string _workshop = "";
    public string _emp = "";//当前登入
    public string _para = "";
    public DataTable dtDetail;
    public DataTable dtQC;
    public DataTable dtGP12;
    public DataTable dtProd; 
    protected void Page_Load(object sender, EventArgs e)
    {
        //_workshop = Request.QueryString["workshop"].ToString();
       // _para = Request.QueryString["para"].ToString();

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

      //  LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
       // _emp = lu.WorkCode + lu.UserName;
        //_emp = "02432何桂勤";

        GetData();
       
    }

    private void GetData()
    {           
        string dh= Request["dh"].ToString();
        string sql = string.Format("[usp_app_prod_timeLine] '{0}'", dh);
        DataSet ds = SQLHelper.Query(sql);
        DataTable dt  = ds.Tables[0];   // 入库 
        dtDetail = new DataTable();//SQLHelper.Query(sql).Tables[1];  
                 
        dtMain.DataSource = dt ;
        dtMain.DataBind();
        //GP12完成
        dtGP12= ds.Tables[1];

        //终检完成
        dtQC = ds.Tables[2];
       
        //生产完成
        dtProd = ds.Tables[3];

        if (dtGP12.Rows.Count > 0)
        {
            dtQC.Rows.Clear();
            dtProd.Rows.Clear();
        }
        if (dtQC.Rows.Count > 0)
        {           
            dtProd.Rows.Clear();
        }

    }
 
}