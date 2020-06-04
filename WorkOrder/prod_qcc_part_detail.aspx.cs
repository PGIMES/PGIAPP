using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class prod_qcc_part_detail : System.Web.UI.Page
{
    public string _workshop = "";
    public string _dh = "";//仓库接收 扫码进来
    public string _ck = "";//仓库接收 扫码进来  上级菜单是 仓库

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

        if (Request.QueryString["workshop"] != null) { _workshop = Request.QueryString["workshop"].ToString(); }
        if (Request.QueryString["dh"] != null) { _dh = Request.QueryString["dh"].ToString(); }
        if (Request.QueryString["ck"] != null) { _ck = Request.QueryString["ck"].ToString(); }

        GetData();
       
    }

    private void GetData()
    {

        string sql = string.Format("[usp_app_Ruku_Print_infor_V1] '{0}'", _dh);
        DataSet ds = SQLHelper.Query(sql);

        dtGP12 = ds.Tables[0];  //GP12完成  
        dtGP12_m = ds.Tables[1];  //GP12完成   
        dtGP12_dtl = ds.Tables[2];  //GP12完成      

        dtQC = ds.Tables[3]; //终检完成  
        dtQC_m = ds.Tables[4]; //终检完成           
        dtQC_dtl = ds.Tables[5]; //终检完成       

        dtProd = ds.Tables[6];//生产完成    
        dtProd_m = ds.Tables[7];//生产完成
        dtProd_dtl = ds.Tables[8];//生产完成





        //string type = Request["type"].ToString();
        //string dh = Request["dh"].ToString();

        //string sql = string.Format(@"select pgino,pn, sum(hege_qty) as qty from Mes_App_WorkOrder_QC_History where qc_status=0 and loading_type={0} and qc_dh='{1}' group by pgino,pn", type, dh);
        //DataTable dtMainDistinct = SQLHelper.Query(sql).Tables[0];
        ////DataView dataView = dt_hist.DefaultView;
        ////DataTable dtMainDistinct = dataView.ToTable(true, "pgino", "pn", "workorder","workorder_part","par_qty");//的第一个参数为是否DISTINCT
        //dtMain.DataSource = dtMainDistinct;
        //dtMain.DataBind(); 
        
                

        //sql = string.Format(@"select * from Mes_App_WorkOrder_QC_History where qc_status=0 and loading_type={0} and qc_dh='{1}'", type,dh);
        //DataTable dt_hist = SQLHelper.Query(sql).Tables[0];     
         
        //DataList1.DataSource = dt_hist;
        //DataList1.DataBind();
        





    }
}