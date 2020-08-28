using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class prod_wip_list_v4 : System.Web.UI.Page
{
    public string _workshop = "";
    public string line1 = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        _workshop = Request.QueryString["workshop"].ToString();
        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }
        //生产中
       // BindData1();
     
        //待终检
        BindData2();
        //待GP12
        BindData3();
        //待入库
        BindData4();
        //入库完成24小时
        //BindData5();
    }
     
     
    //待终检
    private void BindData2()
    {
        string sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}",  "二车间", WeiXin.GetCookie("workcode"), 2 );
        DataSet ds = SQLHelper.Query(sql);
         
        DataTable dt_data = ds.Tables[0];
        ViewState["dt_data_qc2"] = dt_data;

        sql = string.Format(@"exec [usp_app_YZ_monitor] '{0}','{1}',{2}", "三车间", WeiXin.GetCookie("workcode"), 2);
        ds = SQLHelper.Query(sql);
        
        dt_data = ds.Tables[0];
        ViewState["dt_data_qc3"] = dt_data;

        sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}", "四车间", WeiXin.GetCookie("workcode"), 2);
        ds = SQLHelper.Query(sql);

        dt_data = ds.Tables[0];
        ViewState["dt_data_qc4"] = dt_data;
    }
    //待GP12
    private void BindData3()
    {
        string sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}", "二车间", WeiXin.GetCookie("workcode"), 3 );
        DataSet ds = SQLHelper.Query(sql);
        
        DataTable dt_data = ds.Tables[0];
        ViewState["dt_data_gp2"] = dt_data;

        sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}", "三车间", WeiXin.GetCookie("workcode"), 3);
        ds = SQLHelper.Query(sql);

        dt_data = ds.Tables[0];
        ViewState["dt_data_gp3"] = dt_data;

        sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}", "四车间", WeiXin.GetCookie("workcode"), 3);
        ds = SQLHelper.Query(sql);

        dt_data = ds.Tables[0];
        ViewState["dt_data_gp4"] = dt_data;

    }
    
    //待入库
    private void BindData4()
    {
        string sql = string.Format(@"exec usp_app_monitor_zl" );
        DataSet ds = SQLHelper.Query(sql);

        DataTable dt2 = ds.Tables[0];
        DataTable dt4 = ds.Tables[1];
        DataTable dt3 = ds.Tables[2];
        dt3.Columns.Remove(dt3.Columns["pt_prod_line"]);
        dt3.Columns.Remove(dt3.Columns["href"]);

        DataTable db = null;
        DataTable dt = ds.Tables[0];
        //datatable进行合并
        db = dt.Copy();
        DataRow[] dt4Rows = dt4.Select();
        for (int i = 0; i < dt4Rows.Length; i++)
        {
            db.ImportRow(dt4Rows[i]);
        }
        DataRow[] dt3Rows = dt3.Select();
        for (int i = 0; i < dt3Rows.Length; i++)
        {
            db.ImportRow(dt3Rows[i]);
        }

        db.DefaultView.Sort = "usetime desc";
        DataTable dt_= db.DefaultView.ToTable();

        ViewState["dt_data_drk"] = dt_;
         
    }
     



}