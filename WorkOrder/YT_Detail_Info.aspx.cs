using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class YT_Detail_Info : System.Web.UI.Page
{
    public string _need_t_no = "";
    public DataTable dtDetail;
    protected void Page_Load(object sender, EventArgs e)
    {
        _need_t_no = Request.QueryString["need_t_no"].ToString();

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        GetData();
       
    }

    private void GetData()
    {
                 
        string sql = string.Format(@"select t.*,hr.cellphone ,workshop+'/'+line+'/'+location as worklocation
                                    ,case when datediff(mi, req_date, need_date) <10 then '立即'
	                                        when datediff(mi, req_date, need_date) >20 and datediff(mi, req_date, need_date) <=30 then '半小时内'
	                                        when datediff(mi, req_date, need_date) >30 and datediff(mi, req_date, need_date) <=60 then '1小时内'
	                                        when datediff(mi, req_date, need_date) >60 and datediff(mi, req_date, need_date) <=120 then '2小时内'
	                                        when datediff(mi, req_date, need_date) >120 and datediff(mi, req_date, need_date) <=240 then '4小时内'
	                                        when datediff(mi, req_date, need_date) >240 and datediff(mi, req_date, need_date) <=480 then '8小时内'
                                        end d
                                    ,cast(cast(datediff(ss, req_date, need_date)/3600 as int) as varchar)+':'+right('00' + cast(cast(datediff(ss, req_date, need_date) %3600/60 as int) as varchar), 2) as times
                                    from Mes_App_NeedSku t left join  [172.16.5.6].[eHR_DB].[dbo].[View_HR_Emp] hr  on  t.emp_code=hr.employeeid where  need_no='{0}' ", _need_t_no);
        DataTable dt  = SQLHelper.Query(sql).Tables[0];     
         
        dtMain.DataSource = dt ;
        dtMain.DataBind();

        sql = string.Format("usp_app_YL_detail_timeLine '{0}'", _need_t_no);
        dtDetail = SQLHelper.Query(sql).Tables[0];
    }
}