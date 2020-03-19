using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using Maticsoft.DBUtility;
public partial class MoJu_BXMonitor : System.Web.UI.Page
{
    public DataTable bxdt = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        //Response.Write("<div class=''>"+WeiXin.GetCookie("workcode")+"</div>");
        if (!Page.IsPostBack)
        {
            BindBX();
            BindWX();
            BindQR();
            BindMyOrder();
            BindMyWork();
        }
    }

 
    //已报修
    public void BindBX(string strWhere="")
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("select   id, bx_date, bx_banbie, bx_gonghao, bx_name, bx_banzhu, bx_dh, bx_moju_no, bx_moju_type, bx_part, bx_mo_no, bx_gz_type, bx_gz_desc, bx_sbno, bx_sbname, status,level,b.cellphone ");
        //strSql.Append(" ,cast(datediff(mi,bx_date,getdate())/60 as varchar)+'小时 '+right('00'+cast(datediff(mi,bx_date,getdate())%60  as varchar),2)+' 分' bx_shichang ");
        strSql.Append(" ,cast(cast(datediff(ss, bx_date, getdate()) / 3600 as int) as varchar)+'小时 '+right('00' + cast(cast(datediff(ss, bx_date, getdate()) % 3600 / 60 as int) as varchar), 2)+' 分' bx_shichang ");
         
        strSql.Append(" FROM mes.dbo.MES_SB_BX a join [172.16.5.6].[eHR_DB].dbo.view_hr_emp b on b.employeeid=a.bx_gonghao  where status = '报修完成' order by id asc");
        //if (strWhere.Trim() != "")
        //{
        //    strSql.Append(" where " + strWhere);
        //}
        DataSet ds= DbHelperSQL.Query(strSql.ToString());
        listBX.DataSource = ds;
        listBX.DataBind();
    }
    //维修中
    public void BindWX(string strWhere = "")
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("select   id, bx_date, bx_banbie, bx_gonghao, bx_name, bx_banzhu, bx_dh, bx_moju_no, bx_moju_type, bx_part, bx_mo_no, bx_gz_type, bx_gz_desc, bx_sbno, bx_sbname, status,level,b.cellphone");
        strSql.Append(" ,cast(datediff(hh,bx_date,getdate()) as varchar)+'小时 '+right('00'+cast(datediff(mi,bx_date,getdate())%60  as varchar),2)+' 分' bx_shichang ");
        strSql.Append(" FROM mes.dbo.MES_SB_BX a join [172.16.5.6].[eHR_DB].dbo.view_hr_emp b on b.employeeid=a.bx_gonghao  where 1=1 and status = '维修中' order by id asc");
        //if (strWhere.Trim() != "")
        //{
        //    strSql.Append(" where " + strWhere);
        //}
        DataSet ds = DbHelperSQL.Query(strSql.ToString());
        listWX.DataSource = ds;
        listWX.DataBind();
    }
    //生产确认
    public void BindQR(string strWhere = "")
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("select   a.id, bx_date, bx_banbie, b.wx_gonghao, b.wx_name, bx_banzhu, bx_dh, bx_moju_no, bx_moju_type, bx_part, bx_mo_no, bx_gz_type, bx_gz_desc, bx_sbno, bx_sbname, status,level,c.cellphone");
        strSql.Append(" , cast(datediff(hh,bx_date,getdate()) as varchar)+'小时 '+right('00'+cast(datediff(mi,bx_date,getdate())%60  as varchar),2)+' 分' bx_shichang ");
        strSql.Append(" FROM mes.dbo.MES_SB_BX a  join MES.[dbo].[MES_SB_wx] b on a.bx_dh=b.wx_dh    join [172.16.5.6].[eHR_DB].dbo.view_hr_emp c on c.employeeid=b.wx_gonghao  where 1=1 and status = '维修完成' order by a.id asc");
        //if (strWhere.Trim() != "")
        //{
        //    strSql.Append(" where " + strWhere);
        //}
        DataSet ds = DbHelperSQL.Query(strSql.ToString());
        listQR.DataSource = ds;
        listQR.DataBind();
    }

    //发起人工单
    public void BindMyOrder(string strWhere = "")
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("select   id, bx_date, bx_banbie, bx_gonghao, bx_name, bx_banzhu, bx_dh, bx_moju_no, bx_moju_type, bx_part, bx_mo_no, bx_gz_type, bx_gz_desc, bx_sbno, bx_sbname, status,level ,b.cellphone");
        strSql.Append(" ,cast(datediff(hh,bx_date,getdate()) as varchar)+'小时 '+right('00'+cast(datediff(mi,bx_date,getdate())%60  as varchar),2)+' 分' bx_shichang ");
        strSql.Append(" FROM mes.dbo.MES_SB_BX a join [172.16.5.6].[eHR_DB].dbo.view_hr_emp b on b.employeeid=a.bx_gonghao  where 1=1 and status <> '确认完成' and bx_gonghao='{0}'  order by id asc ");
        //if (strWhere.Trim() != "")
        //{
        //    strSql.Append(" where " + strWhere);
        //}
        DataSet ds = DbHelperSQL.Query(string.Format(strSql.ToString(), WeiXin.GetCookie("workcode")));
        listMyOrder.DataSource = ds;
        listMyOrder.DataBind();
    }
    //已分配的工单
    public void BindMyWork(string strWhere = "")
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("select    bx_date, bx_banbie, bx_gonghao, bx_name, bx_banzhu, bx_dh, bx_moju_no, bx_moju_type, bx_part, bx_mo_no, bx_gz_type, bx_gz_desc, bx_sbno, bx_sbname, status,level,c.cellphone ");
        strSql.Append(" ,cast(datediff(hh,bx_date,getdate()) as varchar)+'小时 '+right('00'+cast(datediff(mi,bx_date,getdate())%60  as varchar),2)+' 分' bx_shichang ");
        strSql.Append(" FROM mes.dbo.MES_SB_BX a  join mes.dbo.MES_SB_WX b on a.bx_dh=b.wx_dh   join [172.16.5.6].[eHR_DB].dbo.view_hr_emp c on c.employeeid=b.wx_gonghao  where 1=1 and status <> '确认完成' and wx_end_date is null and b.wx_gonghao='{0}'  order by a.id asc");
        //if (strWhere.Trim() != "")
        //{
        //    strSql.Append(" where " + strWhere);
        //}
        DataSet ds = DbHelperSQL.Query(string.Format(strSql.ToString(),WeiXin.GetCookie("workcode")));
        listMyWork.DataSource = ds;
        listMyWork.DataBind();
    }
}