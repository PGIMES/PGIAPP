using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
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
        ////生产中
        //BindData1();
        ////生产完成24小时
        //BindData24();
        ////待终检
        //BindData2();
        ////待GP12
        //BindData3();
        ////待入库
        //BindData4();
        ////入库完成24小时
        //// BindData5();

        string _workcode = WeiXin.GetCookie("workcode");
        //1.new方式实例化一个Task，需要通过Start方法启动
        Task<DataTable> task = new Task<DataTable>(() =>
        {            
            return GetdtData1(_workcode);
        });
        task.Start();

        ////2.Task.Factory.StartNew(Func func)创建和启动一个Task
        Task<DataTable> task24 = Task.Factory.StartNew<DataTable>(() =>
        {
            return GetdtData24(_workcode);
        });
        Task<DataTable> task2 = Task.Factory.StartNew<DataTable>(() =>
        {
            return GetdtData2(_workcode);
        });
        Task<DataTable> task3 = Task.Factory.StartNew<DataTable>(() =>
        {
            return GetdtData3(_workcode);
        });
        Task<DataTable> task4 = Task.Factory.StartNew<DataTable>(() =>
        {
            return GetdtData4(_workcode);
        });
        //////3.Task.Run(Func func)将任务放在线程池队列，返回并启动一个Task
        //Task<string> task3 = Task.Run<string>(() =>
        //{
        //    //return $"hello, task3的ID为{ Thread.CurrentThread.ManagedThreadId}";
        //});

        //Console.WriteLine("执行主线程！");
        //Console.WriteLine(task.Result);
        //Console.WriteLine(task2.Result);
        //Console.WriteLine(task3.Result);
        ViewState["dt_data_1"] = task.Result;
        ViewState["dt_data_24"] = task24.Result;
        ViewState["dt_data_2"] = task2.Result;
        ViewState["dt_data_3"] = task3.Result;
        ViewState["dt_data_4"] = task4.Result;
    }
    //生产中
    private void BindData1()
    {
        string sql = string.Format(@"exec [usp_app_wip_list_prod] '{0}','{1}'",  Request["workshop"], WeiXin.GetCookie("workcode"));
        DataSet ds= SQLHelper.Query(sql);
        DataTable dt_line = ds.Tables[0];
        DataTable dt_data = ds.Tables[1];
        ViewState["dt_data_1"] = dt_data;
       // var rowsline1 = dt_line.AsEnumerable().Select(r => ((string)r["line"]).ToString()).Distinct();

       // DataList1_line.DataSource = rowsline1;
       // DataList1_line.DataBind();
    }
    private void BindData24()
    {
        string sql = string.Format(@"exec [usp_app_wip_list_prod_End] '{0}','{1}'", Request["workshop"], WeiXin.GetCookie("workcode"));
        DataSet ds = SQLHelper.Query(sql);        
        DataTable dt_data = ds.Tables[0];
        ViewState["dt_data_24"] = dt_data;
         
    }
    //零箱返线
    private void BindData6()
    {
        string sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}", Request["workshop"], WeiXin.GetCookie("workcode"), 6 );
        DataSet ds = SQLHelper.Query(sql);
        //DataTable dt_line = ds.Tables[0];
        DataTable dt_data = ds.Tables[0];
        ViewState["dt_data_6"] = dt_data;
        // var rowsline1 = dt_line.AsEnumerable().Select(r => ((string)r["line"]).ToString()).Distinct();

        // DataList1_line.DataSource = rowsline1;
        // DataList1_line.DataBind();
    }
    //待终检
    private void BindData2()
    {
        string sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}",  Request["workshop"], WeiXin.GetCookie("workcode"), 2 );
        DataSet ds = SQLHelper.Query(sql);
        //DataTable dt_line = ds.Tables[0];
        DataTable dt_data = ds.Tables[0];
        ViewState["dt_data_2"] = dt_data;
        //var rowsline1 = dt_data.AsEnumerable().Select(r => ((string)r["line"]).ToString()).Distinct();

       
    }
    //待GP12
    private void BindData3()
    {
        string sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}",  Request["workshop"], WeiXin.GetCookie("workcode"), 3 );
        DataSet ds = SQLHelper.Query(sql);
       // DataTable dt_line = ds.Tables[0];
        DataTable dt_data = ds.Tables[0];
        ViewState["dt_data_3"] = dt_data;
       // var rowsline1 = dt_data.AsEnumerable().Select(r => ((string)r["line"]).ToString()).Distinct();

        
    }
    
    //待入库
    private void BindData4()
    {
        string sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}",  Request["workshop"], WeiXin.GetCookie("workcode"), 4 );
        DataSet ds = SQLHelper.Query(sql);
       // DataTable dt_line = ds.Tables[0];
        DataTable dt_data = ds.Tables[0];
        ViewState["dt_data_4"] = dt_data;
        //var rowsline1 = dt_data.AsEnumerable().Select(r => ((string)r["line"]).ToString()).Distinct();

        //DataList4_line.DataSource = rowsline1;
        //DataList4_line.DataBind();
    }
    //入库完成
    private void BindData5()
    {
        string sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}",  Request["workshop"], WeiXin.GetCookie("workcode"), 5 );
        DataSet ds = SQLHelper.Query(sql);
       // DataTable dt_line = ds.Tables[0];
        DataTable dt_data = ds.Tables[0];
        ViewState["dt_data_5"] = dt_data;
         
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

    //=============task 使用=============================================   
    //生产中
    private DataTable GetdtData1(string workcode)
    {
        string sql = string.Format(@"exec [usp_app_wip_list_prod] '{0}','{1}'", Request["workshop"], workcode);
        DataSet ds = SQLHelper.Query(sql);        
        DataTable dt_data = ds.Tables[1];
        return dt_data;
    }
    private DataTable GetdtData24(string workcode)
    {
        string sql = string.Format(@"exec [usp_app_wip_list_prod_End] '{0}','{1}'", Request["workshop"], workcode);
        DataSet ds = SQLHelper.Query(sql);
        DataTable dt_data = ds.Tables[0];
        return dt_data;
    }
     
    //待终检
    private DataTable GetdtData2(string workcode)
    {
        string sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}", Request["workshop"], workcode, 2);
        DataSet ds = SQLHelper.Query(sql);        
        DataTable dt_data = ds.Tables[0];
        return dt_data;

    }
    //待GP12
    private DataTable GetdtData3(string workcode)
    {
        string sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}", Request["workshop"], workcode, 3);
        DataSet ds = SQLHelper.Query(sql);        
        DataTable dt_data = ds.Tables[0];        
        return dt_data;
    }

    //待入库
    private DataTable GetdtData4(string workcode)
    {
        string sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}", Request["workshop"], workcode, 4);
        DataSet ds = SQLHelper.Query(sql);        
        DataTable dt_data = ds.Tables[0];
        return dt_data;
    }


}