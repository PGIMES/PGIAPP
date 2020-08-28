using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class prod_end_detail_v2 : System.Web.UI.Page
{
    public DataSet ds;
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
         
        string type = Request["type"].ToString();
        string dh = Request["dh"].ToString();

        //头不统计配件数量 prod_line<>'1090'  明细显示配件
        string sql = string.Format(@"select pgino, pn, sum(qty)par_qty from Mes_App_WorkOrder_Hege where workorder='{1}'   group by pgino, pn", type, dh);
        DataTable dtMainDistinct = SQLHelper.Query(sql).Tables[0];

        dtMain.DataSource = dtMainDistinct;
        dtMain.DataBind();

        sql = string.Format(@"
            select a.emp_name,format(a.off_date,'MM/dd HH:mm') as off_date,sum(qty) as off_qty  from Mes_App_WorkOrder_Hege a /*left join Mes_App_WorkOrder_Ng_Result b on  workorder_gl=a.lot_no  */
            where  a.workorder='{1}' /* and prod_line<>'1090' */   group by a.emp_name,a.off_date order by off_date ;

            select a.*,iif(b.lot_no is null,'',b.lot_no+'/')+a.lot_no as new_lot,FORMAT(off_Date,'MM/dd HH:mm') as off_date_str,
                cast(datediff(mi,on_date,off_date)/60 as varchar)+':'+right('00'+cast(datediff(mi,on_date,off_date)%60  as varchar),2)  as times from Mes_App_WorkOrder_History a 
            left join Mes_App_WorkOrder_Ng_Result b on  workorder_gl=a.lot_no  where  a.{0}='{1}'     
            order by  case when prod_line='1090' then '配件' else prod_line end,off_date", type, dh);

        ds = SQLHelper.Query(sql);

        //20.07.23
        //    string sql = string.Format(@"select pgino, pn, sum(qty)par_qty from Mes_App_WorkOrder_Hege where workorder='{0}' and virtual_data is null   group by pgino, pn",  dh);
        //    DataTable dtMainDistinct = SQLHelper.Query(sql).Tables[0];

        //    dtMain.DataSource = dtMainDistinct;
        //    dtMain.DataBind();

        //    sql = string.Format(@"
        //        select a.emp_name,format(a.off_date,'MM/dd HH:mm') as off_date,sum(a.qty) as off_qty  from Mes_App_WorkOrder_Hege a left join Mes_App_WorkOrder_Ng_Result b on  workorder_gl=a.lot_no  
        //        where  a.workorder='{0}'    and virtual_data is null  group by a.emp_name,a.off_date order by off_date ;

        //        select a.*,iif(b.lot_no is null,'',b.lot_no+'/')+a.lot_no as new_lot,FORMAT(off_Date,'MM/dd HH:mm') as off_date_str,
        //            cast(datediff(mi,off_date,off_date)/60 as varchar)+':'+right('00'+cast(datediff(mi,off_date,off_date)%60  as varchar),2)  as times
        //            ,a.qty as off_qty 
        //from Mes_App_WorkOrder_Hege a left join Mes_App_WorkOrder_Ng_Result b on  workorder_gl=a.lot_no  where  a.workorder='{0}' and virtual_data is null   order by off_date",  dh);
        //    ds = SQLHelper.Query(sql);





    }
}