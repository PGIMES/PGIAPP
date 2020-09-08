using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class JianCe_Monitor : System.Web.UI.Page
{
    public string _workshop = "";
    public string line1 = "";
    public   string connString = System.Configuration.ConfigurationManager.ConnectionStrings["DBJianCe"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        //_workshop = Request.QueryString["workshop"].ToString();
        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }
        // ---------0:申请中   1:待检中   2:检测中   3:待取用  9:完成(24Hour)
        //申请中
        BindData1();
        //1:待检中
        BindData2();
        //检测中
        BindData3();
        //3:待取用
        BindData4();
        //9:完成(24Hour)
        BindData9();

    }
    // 0:申请中
    private void BindData1()
    {
        string sql = string.Format(@"exec [usp_app_JC_Monitor] '{0}','{1}'", _workshop, "0" );
        
        DataSet ds= SQLHelper.Query(sql, connString);
         
        DataTable dt_data = ds.Tables[0];
        ViewState["dt_data_1"] = dt_data;
      
    }


    //1:待检中
    private void BindData2()
    {
        string sql = string.Format(@"exec [usp_app_JC_Monitor] '{0}','{1}'", _workshop, "1");
        DataSet ds = SQLHelper.Query(sql, connString);
        
        DataTable dt_data = ds.Tables[0];
        ViewState["dt_data_2"] = dt_data;
         

       
    }
    //2:检测中
    private void BindData3()
    {
        string sql = string.Format(@"exec [usp_app_JC_Monitor] '{0}','{1}'", _workshop, "2" );
        DataSet ds = SQLHelper.Query(sql, connString);
        
        DataTable dt_data = ds.Tables[0];
        ViewState["dt_data_3"] = dt_data;
      
        
    }
    //3:待取用
    private void BindData4()
    {
        string sql = string.Format(@"exec [usp_app_JC_Monitor] '{0}','{1}'", _workshop, "3");
        DataSet ds = SQLHelper.Query(sql, connString);

        DataTable dt_data = ds.Tables[0];
        ViewState["dt_data_4"] = dt_data;


    }
    //9:完成(24Hour)
    private void BindData9()
    {
        string sql = string.Format(@"exec [usp_app_JC_Monitor] '{0}','{1}'", _workshop, "9" );
        DataSet ds = SQLHelper.Query(sql, connString);
        
        DataTable dt_data = ds.Tables[0];
        ViewState["dt_data_9"] = dt_data;
       
    }
 
   

  


     
}