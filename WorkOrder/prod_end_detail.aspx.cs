using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class prod_end_detail : System.Web.UI.Page
{
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
        string sql = string.Format(@"select   pgino,pn,  sum(par_qty) as par_qty  from Mes_App_WorkOrder_History where    {0}='{1}' group by pgino,pn  ", type,dh);
        DataTable dt_hist = SQLHelper.Query(sql).Tables[0];

        dtMain.DataSource = dt_hist;
        dtMain.DataBind();
        //Label1.Text =""+ dh+" " + dt_hist.Rows[0]["pgino"].ToString()+ "  "  + dt_hist.Rows[0]["pn"].ToString() + "  数量:"+dt_hist.Rows[0]["par_qty"].ToString();

        sql = string.Format(@"select * from Mes_App_WorkOrder_History where    {0}='{1}'  order by off_date asc", type, dh);
        dt_hist = SQLHelper.Query(sql).Tables[0];
        //DataView dataView = dt_hist.DefaultView;
        //DataTable dtMainDistinct = dataView.ToTable(true, "pgino", "pn", "workorder","workorder_part","par_qty");//的第一个参数为是否DISTINCT
        DataList1.DataSource = dt_hist;
        DataList1.DataBind();


    }
}