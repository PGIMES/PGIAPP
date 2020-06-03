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
    public DataTable dtQC;
    public DataTable dtQC_m;
    public DataTable dtQC_dtl;

    public DataTable dtGP12;
    public DataTable dtGP12_m;
    public DataTable dtGP12_dtl;

    public DataTable dtProd;
    public DataTable dtProd_m;
    public DataTable dtProd_dtl;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        GetData();
       
    }

    private void GetData()
    {           
        string sql = string.Format("[usp_app_prod_timeLine_V3] '{0}'", Request["dh"].ToString());
        DataSet ds = SQLHelper.Query(sql);
                 
        dtMain.DataSource = ds.Tables[0];// 入库 
        dtMain.DataBind();

        dtGP12 = ds.Tables[1];  //GP12完成  
        dtGP12_m = ds.Tables[2];  //GP12完成   
        dtGP12_dtl = ds.Tables[3];  //GP12完成      

        dtQC = ds.Tables[4]; //终检完成  
        dtQC_m = ds.Tables[5]; //终检完成           
        dtQC_dtl = ds.Tables[6]; //终检完成       

        dtProd = ds.Tables[7];//生产完成    
        dtProd_m = ds.Tables[8];//生产完成
        dtProd_dtl = ds.Tables[9];//生产完成
    }
 
}