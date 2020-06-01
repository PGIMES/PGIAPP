using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class prod_qcc_part_detail : System.Web.UI.Page
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

        string sql = string.Format(@"select pgino,pn, sum(hege_qty) as qty from Mes_App_WorkOrder_QC_History where qc_status=0 and loading_type={0} and qc_dh='{1}' group by pgino,pn", type, dh);
        DataTable dtMainDistinct = SQLHelper.Query(sql).Tables[0];
        //DataView dataView = dt_hist.DefaultView;
        //DataTable dtMainDistinct = dataView.ToTable(true, "pgino", "pn", "workorder","workorder_part","par_qty");//的第一个参数为是否DISTINCT
        dtMain.DataSource = dtMainDistinct;
        dtMain.DataBind(); 
        
                

        sql = string.Format(@"select * from Mes_App_WorkOrder_QC_History where qc_status=0 and loading_type={0} and qc_dh='{1}'", type,dh);
        DataTable dt_hist = SQLHelper.Query(sql).Tables[0];     
         
        DataList1.DataSource = dt_hist;
        DataList1.DataBind();




    }
}