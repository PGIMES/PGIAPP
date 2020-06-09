using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkOrder_prod_qcc_wait_detail_v : System.Web.UI.Page
{
    public string _workshop = "";
    public string _emp = "";//当前登入
    public string _para = "";


    public DataTable dtGP12;
    public DataTable dtGP12_m;
    public DataTable dtGP12_dtl;


    public DataTable dtMain;
    public DataSet ds;
    public DataTable dtQC;
    public DataTable dtQC_m;
    public DataTable dtQC_dtl;

    protected void Page_Load(object sender, EventArgs e)
    {
        // _workshop = Request.QueryString["workshop"].ToString();
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

        string dh = Request["dh"].ToString();//终检单号或者是完工单号
        string laiyuan = Request["laiyuan"].ToString();

        string sql = string.Format(@"exec usp_app_prod_qcc_wait_detail '{0}','{1}'", dh, laiyuan);
        dtMain = SQLHelper.Query(sql).Tables[0];
        rptMain.DataSource = dtMain;
        rptMain.DataBind();

        sql = string.Format("[usp_app_prod_qcc_wait_detail_dtl] '{0}','{1}'", dh, laiyuan);
        DataSet ds = SQLHelper.Query(sql);

        dtGP12 = ds.Tables[0];  //GP12完成  
        dtGP12_m = ds.Tables[1];  //GP12完成   
        dtGP12_dtl = ds.Tables[2];  //GP12完成      

        dtQC = ds.Tables[3]; //终检完成  
        dtQC_m = ds.Tables[4]; //终检完成           
        dtQC_dtl = ds.Tables[5]; //终检完成       




    }
}