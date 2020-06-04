using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class prod_qcc_wait_detail : System.Web.UI.Page
{
    public string _workshop = "";
    public string _emp = "";//当前登入
    public string _para = "";
     
    public DataTable dtMain;
    public DataSet ds;
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
         
        string type = Request["type"].ToString();
        string dh = Request["dh"].ToString();
        
        string sql = string.Format(@"select workorder,pgino,pn,sum(off_qty) as off_qty,sum(Hege_qty) as hege_qty,isnull(laiyuan,'')laiyuan from Mes_App_WorkOrder_QC_wip  where workorder='{0}' group by workorder,pgino,pn,laiyuan ", dh);
        dtMain  = SQLHelper.Query(sql).Tables[0];

        //if (dt.Rows.Count<=0)
        //{
        //    sql = string.Format(@"select  distinct sku,sku_descr,qty,sum(off_qty) as off_qty,on_date,hr.cellphone ,feed.b_on_m_emp_name as emp_name 
        //                          from Mes_App_WorkOrder_History t
        //                             join Mes_App_FeedSku feed on t.need_no=feed.need_no and t.lot_no=feed.lot_no
        //                             join [172.16.5.6].[eHR_DB].[dbo].[View_HR_Emp] hr  on  feed.b_on_m_emp_code=hr.employeeid  where t.lot_no= '{0}' and t.need_no='{1}' 
        //                          group by sku,sku_descr,qty,on_date,hr.cellphone ,feed.b_on_m_emp_name", dh, need_no);
        //    dt = SQLHelper.Query(sql).Tables[0];
        //}    

        // DataView dataView = dt_hist.DefaultView;
        // DataTable dtMainDistinct = dataView.ToTable(true, "pgino", "pn", "workorder","workorder_part","par_qty");//的第一个参数为是否DISTINCT

        rptMain.DataSource = dtMain;
        rptMain.DataBind();

        //NG Detail
        //sql = string.Format(@"select a.*,hr.cellphone from Mes_App_WorkOrder_Ng_Detail a join [172.16.5.6].[eHR_DB].[dbo].[View_HR_Emp] hr  on  a.emp_code=hr.employeeid  where lot_no= '{0}' ", dh);
        //sql = string.Format(@"select t.* ,hr.cellphone from
        //                        (	
        //                         select workorder   , emp_code , emp_name,pgino,pn,off_qty,hege_qty ,on_date,  '合格品' as opdesc  
        //                            from Mes_App_WorkOrder_qc_History  where workorder='{0}'  
        //                            union all
        //                            select workorder_qc, emp_code , emp_name,pgino,pn,qty    ,qty      ,on_date,'不合格品'  as opdesc
        //                         from Mes_App_WorkOrder_Ng a 
        //                            where workorder= '{0}' 
        //                        )t    join [172.16.5.6].[eHR_DB].[dbo].[View_HR_Emp] hr  on  t.emp_code=hr.employeeid", dh);
        //Version:2
        //cast(datediff(mi,ruku_date_hg,getdate())/60 as varchar)+':'+right('00'+cast(datediff(mi,ruku_date_hg,getdate())%60  as varchar),2)  as times
        //sql = string.Format(@"
        //    if (select count(0) from Mes_App_WorkOrder_QC_History where  loading_type=9 and  qc_dh='{0}')>0
        //        begin
        //      select '终检' as title,* from Mes_App_WorkOrder_QC_History where  loading_type=9 and  qc_dh='{0}'   end
        // else
        //  select '下料' as title,* from Mes_App_WorkOrder_History where workorder='{0}'  order by off_date desc", dh);


        //dtDetail = SQLHelper.Query(sql).Tables[0];

        //DataList1.DataSource = dtDetail;
        //DataList1.DataBind();
        
        //Version:3
        sql = string.Format("[usp_app_Ruku_Print_infor_V1] '{0}'", Request["dh"].ToString());
        DataSet ds = SQLHelper.Query(sql);

        //dtGP12 = ds.Tables[0];  //GP12完成  
        //dtGP12_m = ds.Tables[1];  //GP12完成   
        //dtGP12_dtl = ds.Tables[2];  //GP12完成      

        dtQC = ds.Tables[3]; //终检完成  
        dtQC_m = ds.Tables[4]; //终检完成           
        dtQC_dtl = ds.Tables[5]; //终检完成       

        dtProd = ds.Tables[6];//生产完成    
        dtProd_m = ds.Tables[7];//生产完成
        dtProd_dtl = ds.Tables[8];//生产完成
    }

    //[WebMethod]
    //public static string Reject_Sku(string emp, string needno, string lotno, string reject_qty, string source, string reject_where)
    //{
    //    string result = "";

    //    string re_sql = @"exec [usp_app_Reject] '{0}','{1}','{2}',{3},'{4}','{5}'";
    //    re_sql = string.Format(re_sql, emp, needno, lotno, Convert.ToSingle(reject_qty == "" ? "0" : reject_qty), source, reject_where);
    //    DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
    //    string flag = re_dt.Rows[0][0].ToString();
    //    string msg = re_dt.Rows[0][1].ToString();

    //    result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
    //    return result;

    //}
}