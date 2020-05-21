using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class YL_Detail_Show : System.Web.UI.Page
{
    public string _workshop = "";
    public string _emp = "";//当前登入
    public string _para = "";
    public DataTable dtDetail;
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
         
       // string type = Request["type"].ToString();         
        string need_no= Request["need_no"].ToString();
        string sql = string.Format(@"select t.*,hr.cellphone ,workshop+'/'+line+'/'+location as worklocation
                                    ,case when datediff(mi, req_date, need_date) <10 then '立即'
	                                        when datediff(mi, req_date, need_date) >20 and datediff(mi, req_date, need_date) <=30 then '半小时内'
	                                        when datediff(mi, req_date, need_date) >30 and datediff(mi, req_date, need_date) <=60 then '1小时内'
	                                        when datediff(mi, req_date, need_date) >60 and datediff(mi, req_date, need_date) <=120 then '2小时内'
	                                        when datediff(mi, req_date, need_date) >120 and datediff(mi, req_date, need_date) <=240 then '4小时内'
	                                        when datediff(mi, req_date, need_date) >240 and datediff(mi, req_date, need_date) <=480 then '8小时内'
                                        end d
                                    ,cast(cast(datediff(ss, req_date, need_date)/3600 as int) as varchar)+':'+right('00' + cast(cast(datediff(ss, req_date, need_date) %3600/60 as int) as varchar), 2) as times
                                    from Mes_App_NeedSku t left join  [172.16.5.6].[eHR_DB].[dbo].[View_HR_Emp] hr  on  t.emp_code=hr.employeeid where  need_no='{0}' ", need_no);
        DataTable dt  = SQLHelper.Query(sql).Tables[0];     
         
       // DataView dataView = dt_hist.DefaultView;
       // DataTable dtMainDistinct = dataView.ToTable(true, "pgino", "pn", "workorder","workorder_part","par_qty");//的第一个参数为是否DISTINCT
       
        dtMain.DataSource = dt ;
        dtMain.DataBind();
        //NG Detail
        //sql = string.Format(@"select a.*,hr.cellphone from Mes_App_WorkOrder_Ng_Detail a join [172.16.5.6].[eHR_DB].[dbo].[View_HR_Emp] hr  on  a.emp_code=hr.employeeid  where lot_no= '{0}' ", dh);
        //sql = string.Format(@"select t.* ,hr.cellphone from
        //                    (select   isnull(workorder,workorder_part)workorder, emp_code , emp_name,pgino,pn, sku,sku_Descr,off_qty as qty,off_date,par_qty,'下料' as opdesc  
        //                    from Mes_App_WorkOrder_History  where lot_no='{0}' and need_no='{1}'
        //                    union all
        //                    select workorder, emp_code , emp_name,pgino,pn, sku,sku_Descr,qty,on_date,qty/ps_qty_per  as par_qty,'不合格品' from Mes_App_WorkOrder_Ng_Detail a 
        //                    where lot_no= '{0}' and need_no='{1}')t
        //                    join [172.16.5.6].[eHR_DB].[dbo].[View_HR_Emp] hr  on  t.emp_code=hr.employeeid", dh,need_no);

        //sql = string.Format(@"select t.* ,hr.cellphone,hr2.cellphone as onphone
        //                        ,cast(cast(datediff(ss, need_date, act_date)/3600 as int) as varchar)+':'+right('00' + cast(cast(abs(datediff(ss, need_date, act_date)) %3600/60 as int) as varchar), 2) as shichang
        //                        from   [Mes_App_FeedSku] t 
        //                         join Mes_App_NeedSku need on t.need_no=need.need_no
        //                         left join [172.16.5.6].[eHR_DB].[dbo].[View_HR_Emp] hr  on  t.emp_code=hr.employeeid
        //                            left join [172.16.5.6].[eHR_DB].[dbo].[View_HR_Emp] hr2  on  t.b_on_m_emp_code=hr2.employeeid where t.need_no='{0}'", need_no);
        sql = string.Format("usp_app_YL_detail_timeLine '{0}'", need_no);
        dtDetail = SQLHelper.Query(sql).Tables[0];

       // DataList1.DataSource = dt ;
      //  DataList1.DataBind();
        //Label1.Text =""+ dh+" " + dt_hist.Rows[0]["pgino"].ToString()+ "  "  + dt_hist.Rows[0]["pn"].ToString() + "  数量:"+dt_hist.Rows[0]["par_qty"].ToString();




    }

    [WebMethod]
    public static string Reject_Sku(string emp, string needno, string lotno, string reject_qty, string source, string reject_where)
    {
        string result = "";

        string re_sql = @"exec [usp_app_Reject] '{0}','{1}','{2}',{3},'{4}','{5}'";
        re_sql = string.Format(re_sql, emp, needno, lotno, Convert.ToSingle(reject_qty == "" ? "0" : reject_qty), source, reject_where);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }
}