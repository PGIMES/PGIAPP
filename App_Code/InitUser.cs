using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

/// <summary>
///BaseFun 的摘要说明
/// </summary>
public abstract class InitUser
{
	public InitUser()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}
    /// <summary>
    /// V1.0获取指定人员详细信息：工号，职称（建议使用V2.0）
    /// </summary>
    /// <param name="pg"></param>
    /// <param name="LOGON_USER"></param>
    public static void  GetLoginUserInfo(Page pg,string LOGON_USER)
    {        
        
            string strUser = LOGON_USER;
            pg.Session["loginUser"] = strUser.Substring(strUser.IndexOf(@"\") + 1);
            string loginUser = "";
            if (pg.Session["loginUser"] != null)
            {
                loginUser = pg.Session["loginUser"].ToString();
            }
            //object empid = DbHelperSQL.GetSingle("select empid from AD_ACCOUNT where lower(ADAccount)=lower('" + loginUser + "') ");

          //  object empid = SQLHelper.GetSingle("SELECT workcode FROM V_HRM_EMP_MES where lower(ADAccount)=lower('" + loginUser + "') ");
           // object job = SQLHelper.GetSingle("SELECT jobtitlename FROM V_HRM_EMP_MES where lower(ADAccount)=lower('" + loginUser + "') ");

          //  pg.Session["empid"] = empid == null ? "" : empid.ToString();
          //  pg.Session["job"] = job == null ? "" : job.ToString();
        
    }
    /// <summary>
    /// V2.0获取指定人员详细信息：工号，姓名，包括部门，职称，直属主管，组别
    /// </summary>
    /// <param name="WorkCode">工号(2参数至少输入一个)</param>
    /// <param name="wxuserid">登入微信账号(2参数至少输入一个)</param>
    /// <returns>LoginUser</returns>
    public static LoginUser GetLoginUserInfo(string WorkCode, string wxuserid)
    {
         
        //if (AdAccount.IndexOf(@"\") >= 0)
        //{   //如果传入参数是完整 域名\AD,则格式化
        //    AdAccount = AdAccount.Substring(AdAccount.IndexOf(@"\") + 1);
        //}

        LoginUser model = null;
        DataTable dt = SQLHelper.reDs(string.Format("select a.* from  [172.16.5.26].MES.[dbo].[HRM_EMP_MES_ALL] a join wx_user b on a.workcode=b.workcode where b.wxuserid='{0}' and a.workcode<>''", wxuserid)).Tables[0];
        if (dt.Rows.Count > 0)
        {
            DataRow dr= dt.Rows[0];
            model = new LoginUser();
            model.WXUserId = wxuserid;
            model.WorkCode = dr["workcode"].ToString();
            model.UserName = dr["lastname"].ToString();
           // model.ADAccount = dr["ADAccount"].ToString();
           // model.JobTitleId = dr[""].ToString();
           // model.JobTitleName = dr["JobTitleName"].ToString();
           // model.SuperviserId = dr["manager_workcode"].ToString();
           // model.SuperviserName = dr["manager_name"].ToString();
           // model.ManagerId = dr["zg_workcode"].ToString();
           // model.ManagerName = dr["zg_name"].ToString();
           // model.ManagerADAccount = dr["manager_ad_account"].ToString();
            // model.DepartId = dr[""].ToString();
           // model.DepartName = dr["dept_name"].ToString();
           // model.GroupName = dr["departmentname"].ToString();
            model.Domain= dr["domain"].ToString();
            model.DomainName= dr["gc"].ToString();
           // model.Telephone= dr["telephone"].ToString();
        }
        return model;
    }
    ////是否存在该员工,且是该角色的人员
    //public static bool IsRoleUser(string modelName,string RoleName,string loginUser)
    //{
    //    bool result = false;//select * from z_UserRole a where a.modelName='' and EmpName=''
    //    object obj = DbHelperSQL.GetSingle("SELECT  Count(1) FROM  z_UserRole where enable=1 and modelName='"+ modelName + "' and rolename='"+ RoleName + "' and EmpName= lower('" + loginUser + "')  ");
    //    if(obj.ToString()=="1")
    //    {
    //        result = true;
    //    }
    //    return result;
    //}




     /// <summary>
     /// 根据部门取部门主管
     /// </summary>
     /// <returns></returns>
    //public static string getDeptLeaderByDept(string domain ,string dept)
    //{
    //    StringBuilder sb = new StringBuilder();
    //    sb.Append("  select 'u_'+cast(id as varchar)from RoadFlowWebForm.dbo.users where account=");
    //    sb.Append("   (SELECT  distinct Manager_workcode FROM [dbo].[HR_EMP_MES]  where (domain='"+domain+ "' or '" + domain + "'='') and  (dept_name='" + dept + "' ) )");
    //    object obj = DbHelperSQL.GetSingle(sb.ToString());
    //    return obj==null?"":obj.ToString();
    //}
    /// <summary>
    /// 根据部门取部门分管副总
    /// </summary>
    /// <returns></returns>
    //public static string getDeptChargeLeaderByDept(string domain, string dept)
    //{
    //    StringBuilder sb = new StringBuilder();
        
    //    if (domain == "100")
    //    {
    //        sb.Append("  select 'u_'+cast(id as varchar)from RoadFlowWebForm.dbo.users where account=");
    //        sb.Append("   (SELECT  distinct Manager_workcode FROM [dbo].[HR_EMP_MES]  where   workcode='00024' )");// 汤晓燕 00024
    //    }
    //    else//(domain == "200")
    //    {
    //        sb.Append("  select 'u_'+cast(id as varchar)from RoadFlowWebForm.dbo.users where account=");
    //        sb.Append("   (SELECT  distinct Manager_workcode FROM [dbo].[HR_EMP_MES]  where (domain='" + domain + "' or '" + domain + "'='') and  (dept_name='" + dept + "' ) )");
    //    }
    //    object obj = DbHelperSQL.GetSingle(sb.ToString());
    //    return obj == null ? "" : obj.ToString();
    //}

}