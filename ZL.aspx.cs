using LitJson;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ZL : System.Web.UI.Page
{
    public string _workshop = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            emp_code_name.Text = lu.WorkCode + lu.UserName;
        }
    }

    //检验监视
    [WebMethod]
    public static string ProdList_Data()
    {        
        int iPart = 0, iWip = 0, iNg = 0,iSh=0; //iPart部分，iWip在制数，iNg不合格返线数   iSh  待入库数
        //待终检
        string sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}", "二车间", WeiXin.GetCookie("workcode"), 2);
        DataSet ds = SQLHelper.Query(sql);
        DataTable dt_data_qc = ds.Tables[0];
        iPart = iPart + dt_data_qc.Select("ispartof='部分'").Count();
        iWip = iWip + dt_data_qc.Select("ispartof<>'部分'  and  isnull(workorder_wip,'') =''").Count();
        iNg = iNg + dt_data_qc.Select(" isnull(workorder_wip,'') <>''").Count();

        sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}", "三车间", WeiXin.GetCookie("workcode"), 2);
        ds = SQLHelper.Query(sql);
        dt_data_qc = ds.Tables[0];
        iPart = iPart + dt_data_qc.Select("ispartof='部分'").Count();
        iWip = iWip + dt_data_qc.Select("ispartof<>'部分'  and  isnull(workorder_wip,'') =''").Count();
        iNg = iNg + dt_data_qc.Select(" isnull(workorder_wip,'') <>''").Count();

        sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}", "四车间", WeiXin.GetCookie("workcode"), 2);
        ds = SQLHelper.Query(sql);
        dt_data_qc = ds.Tables[0];
        iPart = iPart + dt_data_qc.Select("ispartof='部分'").Count();
        iWip = iWip + dt_data_qc.Select("ispartof<>'部分'  and  isnull(workorder_wip,'')  =''").Count();
        iNg = iNg + dt_data_qc.Select(" isnull(workorder_wip,'') <>''").Count();


        //待GP12
        sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}", "二车间", WeiXin.GetCookie("workcode"), 3);
        ds = SQLHelper.Query(sql);
        DataTable dt_data_GP = ds.Tables[0];
        iPart = iPart + dt_data_GP.Select("ispartof='部分'").Count();
        iWip = iWip + dt_data_GP.Select("ispartof<>'部分'  and  isnull(workorder_wip,'') =''").Count();
        iNg = iNg + dt_data_GP.Select(" isnull(workorder_wip,'') <>''").Count();

        sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}", "三车间", WeiXin.GetCookie("workcode"), 3);
        ds = SQLHelper.Query(sql);
        dt_data_GP = ds.Tables[0];
        iPart = iPart + dt_data_GP.Select("ispartof='部分'").Count();
        iWip = iWip + dt_data_GP.Select("ispartof<>'部分'  and  isnull(workorder_wip,'')  =''").Count();
        iNg = iNg + dt_data_GP.Select(" isnull(workorder_wip,'') <>''").Count();

        sql = string.Format(@"exec [usp_app_wip_list_Qcc] '{0}','{1}',{2}", "四车间", WeiXin.GetCookie("workcode"), 3);
        ds = SQLHelper.Query(sql);
        dt_data_GP = ds.Tables[0];
        iPart = iPart + dt_data_GP.Select("ispartof='部分'").Count();
        iWip = iWip + dt_data_GP.Select("ispartof<>'部分'  and  isnull(workorder_wip,'')  =''").Count();
        iNg = iNg + dt_data_GP.Select(" isnull(workorder_wip,'') <>''").Count();

        //end qc,gp12
        sql = string.Format(@"usp_app_monitor_zl");
        DataSet ds_ = SQLHelper.Query(sql);
        iSh =  ds_.Tables[0].Rows.Count+ ds_.Tables[1].Rows.Count+ds_.Tables[2].Rows.Count;       
         

        string res = "[{\"wip\":\"" + iWip.ToString() + "\",\"part\":\"" + iPart.ToString() + "\",\"ng\":\"" + iNg.ToString() + "\",\"sh\":\"" + iSh.ToString() + "\",\"msg\":\"ok\"}]";
        return res;

    }
   



}