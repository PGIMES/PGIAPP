using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class JiaJu_Monitor : System.Web.UI.Page
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
        //调整中
        BindData1();
        //检测中
        BindData2();
        //检测结果待确认
        BindData3();
        //换夹完成（30天内）
        BindData4();
         
    }
    //调整中
    private void BindData1()
    {
        string sql = string.Format(@"exec [usp_app_JiaJu_Monitor] '{0}','{1}','{2}'",  Request["workshop"],"0" ,WeiXin.GetCookie("workcode"));
        DataSet ds= SQLHelper.Query(sql);
         
        DataTable dt_data = ds.Tables[0];
        ViewState["dt_data_1"] = dt_data;
      
    }


    //检测中
    private void BindData2()
    {
        string sql = string.Format(@"exec [usp_app_JiaJu_Monitor] '{0}','{1}','{2}'",  Request["workshop"], "1", WeiXin.GetCookie("workcode") );
        DataSet ds = SQLHelper.Query(sql);
        
        DataTable dt_data = ds.Tables[0];
        ViewState["dt_data_2"] = dt_data;
         

       
    }
    //检测结果待确认
    private void BindData3()
    {
        string sql = string.Format(@"exec [usp_app_JiaJu_Monitor] '{0}','{1}','{2}'",  Request["workshop"], "2", WeiXin.GetCookie("workcode") );
        DataSet ds = SQLHelper.Query(sql);
        
        DataTable dt_data = ds.Tables[0];
        ViewState["dt_data_3"] = dt_data;
      
        
    }

    //换夹完成（30天内）
    private void BindData4()
    {
        string sql = string.Format(@"exec [usp_app_JiaJu_Monitor] '{0}','{1}','{2}'",  Request["workshop"], "9", WeiXin.GetCookie("workcode") );
        DataSet ds = SQLHelper.Query(sql);
        
        DataTable dt_data = ds.Tables[0];
        ViewState["dt_data_4"] = dt_data;
       
    }
 
   
    protected void BindInnerRepeat(RepeaterItemEventArgs e, string innerRepeatId, string viewstateDataTable)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater detail = (Repeater)e.Item.FindControl(innerRepeatId);
            // DataRowView item = (DataRowView)e.Item.DataItem;
            // var line = item["line"].ToString();

            var line = e.Item.DataItem.ToString();
            DataTable dt_all = ViewState[viewstateDataTable] as DataTable;

            dt_all.DefaultView.RowFilter = "line='" + line + "'";
            //dt_all.DefaultView.Sort = " ordertime desc";
            detail.DataSource = dt_all;
            detail.DataBind();

        }
    }
  


     
}