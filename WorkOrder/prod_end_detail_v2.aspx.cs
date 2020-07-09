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
        string sql = string.Format(@"select pgino, pn, sum(par_qty)par_qty from Mes_App_WorkOrder_History where workorder='{1}' and prod_line<>'1090' group by pgino, pn", type, dh);
        DataTable dtMainDistinct = SQLHelper.Query(sql).Tables[0];
        //DataView dataView = dt_hist.DefaultView;
        //DataTable dtMainDistinct = dataView.ToTable(true, "pgino", "pn", "workorder","workorder_part","par_qty");//的第一个参数为是否DISTINCT
        dtMain.DataSource = dtMainDistinct;
        dtMain.DataBind();

        sql = string.Format(@"
            select a.emp_name,format(a.off_date,'MM/dd HH:mm') as off_date,sum(off_qty) as off_qty  from Mes_App_WorkOrder_History a left join Mes_App_WorkOrder_Ng_Result b on  workorder_gl=a.lot_no  
            where  a.{0}='{1}'    group by a.emp_name,a.off_date order by off_date ;

            select a.*,iif(b.lot_no is null,'',b.lot_no+'/')+a.lot_no as new_lot,FORMAT(off_Date,'MM/dd HH:mm') as off_date_str,
                cast(datediff(mi,on_date,off_date)/60 as varchar)+':'+right('00'+cast(datediff(mi,on_date,off_date)%60  as varchar),2)  as times from Mes_App_WorkOrder_History a left join Mes_App_WorkOrder_Ng_Result b on  workorder_gl=a.lot_no  where  a.{0}='{1}'    order by off_date", type,dh);
        ds = SQLHelper.Query(sql);     
         
       // DataList1.DataSource =ds.Tables[1] ;
       // DataList1.DataBind();
        //Label1.Text =""+ dh+" " + dt_hist.Rows[0]["pgino"].ToString()+ "  "  + dt_hist.Rows[0]["pn"].ToString() + "  数量:"+dt_hist.Rows[0]["par_qty"].ToString();




    }
}