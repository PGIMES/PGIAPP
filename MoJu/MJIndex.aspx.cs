using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MJIndex : PageMain
{
    private static string connReport = System.Configuration.ConfigurationManager.AppSettings["connReport"]; //webconfig中连线字串
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
             
        }
         
    }

    //[WebMethod]
    //public static string init()
    //{

    //    //string sql = @"select count(1) app_ng from Mes_App_WorkOrder_Ng where status<>1";
    //    //DataTable re_dt = SQLHelper.Query(sql).Tables[0];
    //    //string appp_ng = re_dt.Rows[0]["app_ng"].ToString();

    //    //string result = "[{\"appp_ng\":\"" + appp_ng + "\"}]";
    //    //return result;

    //}
    /// <summary>
    /// 模修监视数量
    /// </summary>
    /// <returns></returns>
    public static string getMoXiuCount()
    {
        string result = "0";
        string sql = @"select count(1) from dbo.MES_SB_BX  where status<>'确认完成' ";

        

        result = Maticsoft.DBUtility.DbHelperSQL.GetSingle(sql).ToString();
        //string appp_ng = re_dt.Rows[0]["app_ng"].ToString();

        //string result = "[{\"appp_ng\":\"" + appp_ng + "\"}]";
        return result;

    }
    /// <summary>
    /// 上模监视数量
    /// </summary>
    /// <returns></returns>
    public static string getSMCount()
    {
        string result = "0";
        string sql = @"select sum(cnt) from (
	                        select count(1)cnt from MoJu_ly   where state in('待出库','待上模','待下模')
	                        union all
	                        select COUNT(1)  from   MoJu_LY a join MoJu b on a.moju_id=b.id
			                        join MoJu_Down_apply ap on a.ly_no=ap.ly_no
			                        join MoJu_Down down on a.ly_no=down.ly_no
	                        where   ap.mojian_check='末件要检测' and down.mojian_date  is   null	)t ";

        Maticsoft.DBUtility.DbHelperSQLP helper = new Maticsoft.DBUtility.DbHelperSQLP(connReport);
        result = helper.GetSingle(sql).ToString();
        //string appp_ng = re_dt.Rows[0]["app_ng"].ToString();

        //string result = "[{\"appp_ng\":\"" + appp_ng + "\"}]";
        return result;

    }
    /// <summary>
    /// 保养监视数量
    /// </summary>
    /// <returns></returns>
    public static string getBYCount()
    {
        string result = "0";
        string sql = @" select count(1)  from   MoJu_LY a 
		                    join MoJu_BY_APP app on a.ly_no=app.ly_no
		                    join MoJu_Down_Apply ap on a.ly_no=ap.ly_no		
		                    left join MoJu_BY   on MoJu_BY.by_no=app.by_no	    
		                where ([state]='保养完成' and act_date is not null and app.zg_confirm='Y' and app.zg_confirm_date is null)
		                or state in('待保养','保养中') ";

        Maticsoft.DBUtility.DbHelperSQLP helper = new Maticsoft.DBUtility.DbHelperSQLP(connReport);
        result = helper.GetSingle(sql).ToString();
        //string appp_ng = re_dt.Rows[0]["app_ng"].ToString();

        //string result = "[{\"appp_ng\":\"" + appp_ng + "\"}]";
        return result;

    }
}