﻿using LitJson;
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
    public static string connStr_JianCe = System.Configuration.ConfigurationManager.ConnectionStrings["DBJianCe"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        bind_data();

        if (!IsPostBack)
        {
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            emp_code_name.Text = lu.WorkCode + lu.UserName;
        }
    }


    public void bind_data()
    {
        //上岗监视
        string sql = @"select count(1) app_emp from [Mes_App_EmployeeLogin] with(nolock) 
            where off_date is null and on_date is not null and emp_code not in(select EMPLOYEEID from [172.16.5.26].[Production].[dbo].[Hrm_Emp] with(nolock) where dept_name='IT部' )
                and id in (select distinct login_id from Mes_App_EmployeeLogin_Location with(nolock) 
                        where (e_code like 'J%' or e_code like 'Q%' or e_code like 'C%'))";
        DataTable re_dt_j = SQLHelper.Query(sql).Tables[0];

        Label1_j.Text = re_dt_j.Rows[0][0].ToString();

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


    //不合格监视
    [WebMethod]
    public static string bhg_Data()
    {
        int go = 0, end = 0, fg = 0;

        string sql = @"exec [usp_app_bhgp_Apply_list_dv_V1_New] '','','',''";
        DataSet ds = SQLHelper.Query(sql);

        DataTable dt_01 = ds.Tables[0]; DataTable dt_02 = ds.Tables[1]; DataTable dt_03 = ds.Tables[2];
        DataTable dt_04 = ds.Tables[3]; DataTable dt_05 = ds.Tables[4]; DataTable dt_98 = ds.Tables[5];
        DataTable dt_99 = ds.Tables[6];

        go = dt_02.Rows.Count + dt_03.Rows.Count + dt_04.Rows.Count + dt_05.Rows.Count + dt_98.Rows.Count;
        fg = dt_01.Rows.Count;
        end = dt_99.Rows.Count;

        string res = "[{\"go\":\"" + go.ToString() + "\",\"end\":\"" + end.ToString() + "\",\"fg\":\"" + fg.ToString() + "\"}]";
        return res;

    }
    //检测监视
    [WebMethod]
    public static string JianCe_Data()
    {
        //检测监视
        int iCnt1 = 0, iCnt2 = 0, iCnt3 = 0, iCnt4 = 0, iCnt5 = 0;//Cnt1 已申请未完成总数，Cnt2:紧急数 ;  Cnt3  1天完成数 ;Cnt4 
        // 调整中
        string sql = string.Format(@"select  id,status,sj_type,priority from [App_JC]  with(nolock)  where status<>9 and status<>-1");//9：完成；-1：取消\删除
        DataTable dt_data_go = SQLHelper.Query(sql, connStr_JianCe).Tables[0];
        iCnt1 = iCnt1 + dt_data_go.Rows.Count;
        iCnt2 = iCnt2 + dt_data_go.Select(" priority='紧急'").Length;
        //NG
        sql = string.Format(@"[usp_app_JC_Monitor] '','3'");
        dt_data_go = SQLHelper.Query(sql, connStr_JianCe).Tables[0];
        iCnt3 = iCnt3 + dt_data_go.Select("result='NG'").Count();
        iCnt5 = iCnt5 + dt_data_go.Select("result='超内控'").Count();
        //24完成
        sql = string.Format(@"select dh,result from [App_JC]  with(nolock)  where status=9 and complete_date>dateadd(day,-1,getdate())");
        dt_data_go = SQLHelper.Query(sql, connStr_JianCe).Tables[0];
        iCnt3 = iCnt3 + dt_data_go.Select("result='NG'").Length;
        iCnt4 = iCnt4 + Convert.ToInt16(dt_data_go.Rows.Count);
        iCnt5 = iCnt5 + dt_data_go.Select("result='超内控'").Length;
        string res = "[{\"iCnt1\":\"" + iCnt1.ToString() + "\",\"iCnt2\":\"" + iCnt2.ToString() + "\",\"iCnt3\":\"" + iCnt3.ToString() 
            + "\",\"iCnt4\":\"" + iCnt4.ToString() + "\",\"iCnt5\":\"" + iCnt5.ToString() + "\",\"msg\":\"ok\"}]";
        return res;

    }
}