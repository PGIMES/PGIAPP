﻿using System;
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
            //--所有工单
            BindBX();
            BindWX();
            BindQR();
            BindWanCheng();
            //---我的工单
            BindBXmy();
            BindWXmy();
            BindQRmy();
            BindWanChengmy();

            //BindMyOrder();
            //BindMyWork();

        }
    }

 
    //已报修
    public void BindBX(string strWhere="")
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("select   id, bx_date, bx_banbie, bx_gonghao, bx_name, bx_banzhu, bx_dh, bx_moju_no, bx_moju_type, bx_part, bx_mo_no, bx_gz_type, bx_gz_desc, bx_sbno, bx_sbname, status,level,b.cellphone,moju_repair ");
        //strSql.Append(" ,cast(datediff(mi,bx_date,getdate())/60 as varchar)+'小时 '+right('00'+cast(datediff(mi,bx_date,getdate())%60  as varchar),2)+' 分' bx_shichang ");
        strSql.Append(" ,cast(cast(datediff(ss, bx_date, getdate()) / 3600 as int) as varchar)+':'+right('00' + cast(cast(datediff(ss, bx_date, getdate()) % 3600 / 60 as int) as varchar), 2) bx_shichang ");
      //  strSql.Append(" ,(select top 1 product_leibie from form3_Sale_Product_MainTable where pgino =(select left(xmh,5)  from [172.16.5.6].report.dbo.MoJu  where mojuno= bx_moju_no) ) as pd_type ");
        strSql.Append(" FROM mes.dbo.MES_SB_BX a join [172.16.5.6].[eHR_DB].dbo.view_hr_emp b on b.employeeid=a.bx_gonghao  where status = '报修完成' order by id asc");
         
        DataSet ds= DbHelperSQL.Query(strSql.ToString());
        listBX.DataSource = ds;
        listBX.DataBind();
    }

    //维修中
    public void BindWX(string strWhere = "")
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("select   id, bx_date, bx_banbie, bx_gonghao, bx_name, bx_banzhu, bx_dh, bx_moju_no, bx_moju_type, bx_part, bx_mo_no, bx_gz_type, bx_gz_desc, bx_sbno, bx_sbname, status,level,b.cellphone,moju_repair");
        strSql.Append(" ,cast(datediff(hh,bx_date,getdate()) as varchar)+':'+right('00'+cast(datediff(mi,bx_date,getdate())%60  as varchar),2) bx_shichang ");
      //  strSql.Append(" ,(select top 1 product_leibie from form3_Sale_Product_MainTable where pgino =(select left(xmh,5)  from [172.16.5.6].report.dbo.MoJu  where mojuno= bx_moju_no) ) as pd_type ");
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
        strSql.Append("select   a.id, bx_date, bx_banbie, b.wx_gonghao, b.wx_name, bx_banzhu, bx_dh, bx_moju_no, bx_moju_type, bx_part, bx_mo_no, bx_gz_type, bx_gz_desc, bx_sbno, bx_sbname, status,level,c.cellphone,moju_repair");
        strSql.Append(" , cast(datediff(hh,bx_date,getdate()) as varchar)+':'+right('00'+cast(datediff(mi,bx_date,getdate())%60  as varchar),2) bx_shichang ");
       // strSql.Append(" ,(select top 1 product_leibie from form3_Sale_Product_MainTable where pgino =(select left(xmh,5)  from [172.16.5.6].report.dbo.MoJu  where mojuno= bx_moju_no) ) as pd_type ");
        strSql.Append(" FROM mes.dbo.MES_SB_BX a  join MES.[dbo].[MES_SB_wx] b on a.bx_dh=b.wx_dh    join [172.16.5.6].[eHR_DB].dbo.view_hr_emp c on c.employeeid=b.wx_gonghao  where 1=1 and status = '维修完成' order by a.id asc");
        //if (strWhere.Trim() != "")
        //{
        //    strSql.Append(" where " + strWhere);
        //}
        DataSet ds = DbHelperSQL.Query(strSql.ToString());
        listQR.DataSource = ds;
        listQR.DataBind();
    }

    //已完成确认
    public void BindWanCheng(string strWhere = "")
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("select     bx_date, bx_banbie, bx_gonghao, bx_name, bx_banzhu, bx_dh, bx_moju_no, bx_moju_type, bx_part, bx_mo_no, bx_gz_type, bx_gz_desc, bx_sbno, bx_sbname, status,level,b.cellphone,moju_repair ");
        //strSql.Append(" ,cast(datediff(mi,bx_date,getdate())/60 as varchar)+'小时 '+right('00'+cast(datediff(mi,bx_date,getdate())%60  as varchar),2)+' 分' bx_shichang ");
        strSql.Append(" ,cast(cast(datediff(ss, bx_date, qr_date) / 3600 as int) as varchar)+':'+right('00' + cast(cast(datediff(ss, bx_date, qr_date) % 3600 / 60 as int) as varchar), 2) bx_shichang ");
       // strSql.Append(" ,(select top 1 product_leibie from form3_Sale_Product_MainTable where pgino =(select left(xmh,5)  from [172.16.5.6].report.dbo.MoJu  where mojuno= bx_moju_no) ) as pd_type ");
        strSql.Append(" FROM mes.dbo.MES_SB_BX a join mes.dbo.MES_SB_QR c on a.bx_dh=c.dh join [172.16.5.6].[eHR_DB].dbo.view_hr_emp b on b.employeeid=a.bx_gonghao  where  dateadd(hh,24,qr_date )>getdate() and status = '确认完成' order by a.id asc");
        //if (strWhere.Trim() != "")
        //{
        //    strSql.Append(" where " + strWhere);
        //}
        DataSet ds = DbHelperSQL.Query(strSql.ToString());
        listWC.DataSource = ds;
        listWC.DataBind();
    }

 //================我的工单=========================================================
    //已报修
    public void BindBXmy(string strWhere = "")
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("select    bx_date, bx_banbie, bx_gonghao, bx_name, bx_banzhu, bx_dh, bx_moju_no, bx_moju_type, bx_part, bx_mo_no, bx_gz_type, bx_gz_desc, bx_sbno, bx_sbname, status,level,b.cellphone,moju_repair ");
        //strSql.Append(" ,cast(datediff(mi,bx_date,getdate())/60 as varchar)+'小时 '+right('00'+cast(datediff(mi,bx_date,getdate())%60  as varchar),2)+' 分' bx_shichang ");
        strSql.Append(" ,cast(cast(datediff(ss, bx_date, getdate()) / 3600 as int) as varchar)+':'+right('00' + cast(cast(datediff(ss, bx_date, getdate()) % 3600 / 60 as int) as varchar), 2) bx_shichang ");
       // strSql.Append(" ,(select top 1 product_leibie from form3_Sale_Product_MainTable where pgino =(select left(xmh,5)  from [172.16.5.6].report.dbo.MoJu  where mojuno= bx_moju_no) ) as pd_type ");
        strSql.Append(" FROM mes.dbo.MES_SB_BX a join [172.16.5.6].[eHR_DB].dbo.view_hr_emp b on b.employeeid=a.bx_gonghao  where status = '报修完成' and a.bx_gonghao='"+WeiXin.GetCookie("workcode")+"' order by a.id asc");
         
        DataSet ds = DbHelperSQL.Query(strSql.ToString());
        listBXmy.DataSource = ds;
        listBXmy.DataBind();
    }

    //维修中
    public void BindWXmy(string strWhere = "")
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("select    bx_date, bx_banbie, bx_gonghao, bx_name, bx_banzhu, bx_dh, bx_moju_no, bx_moju_type, bx_part, bx_mo_no, bx_gz_type, bx_gz_desc, bx_sbno, bx_sbname, status,level,b.cellphone,moju_repair");
        strSql.Append(" ,cast(datediff(hh,bx_date,getdate()) as varchar)+':'+right('00'+cast(datediff(mi,bx_date,getdate())%60  as varchar),2)  bx_shichang ");
       // strSql.Append(" ,(select top 1 product_leibie from form3_Sale_Product_MainTable where pgino =(select left(xmh,5)  from [172.16.5.6].report.dbo.MoJu  where mojuno= bx_moju_no) ) as pd_type ");
        strSql.Append(" FROM mes.dbo.MES_SB_BX a  join mes.dbo.mes_sb_wx c on a.bx_dh=c.wx_dh join [172.16.5.6].[eHR_DB].dbo.view_hr_emp b on b.employeeid=a.bx_gonghao  where 1=1 and status = '维修中' and ( bx_gonghao='" + WeiXin.GetCookie("workcode") + "' or wx_gonghao='" + WeiXin.GetCookie("workcode") + "' )   order by a.id asc");
        //if (strWhere.Trim() != "")
        //{
        //    strSql.Append(" where " + strWhere);
        //}
        DataSet ds = DbHelperSQL.Query(strSql.ToString());
        listWXmy.DataSource = ds;
        listWXmy.DataBind();
    }
    //生产确认
    public void BindQRmy(string strWhere = "")
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("select   a.id, bx_date, bx_banbie, b.wx_gonghao, b.wx_name, bx_banzhu, bx_dh, bx_moju_no, bx_moju_type, bx_part, bx_mo_no, bx_gz_type, bx_gz_desc, bx_sbno, bx_sbname, status,level,c.cellphone,moju_repair");
        strSql.Append(" , cast(datediff(hh,bx_date,getdate()) as varchar)+':'+right('00'+cast(datediff(mi,bx_date,getdate())%60  as varchar),2) bx_shichang ");
       // strSql.Append(" ,(select top 1 product_leibie from form3_Sale_Product_MainTable where pgino =(select left(xmh,5)  from [172.16.5.6].report.dbo.MoJu  where mojuno= bx_moju_no) ) as pd_type ");
        strSql.Append(" FROM mes.dbo.MES_SB_BX a  join MES.[dbo].[MES_SB_wx] b on a.bx_dh=b.wx_dh    join [172.16.5.6].[eHR_DB].dbo.view_hr_emp c on c.employeeid=b.wx_gonghao  where 1=1 and status = '维修完成'  and ( bx_gonghao='" + WeiXin.GetCookie("workcode") + "' or wx_gonghao='" + WeiXin.GetCookie("workcode") + "' )  order by a.id asc");
        //if (strWhere.Trim() != "")
        //{
        //    strSql.Append(" where " + strWhere);
        //}
        DataSet ds = DbHelperSQL.Query(strSql.ToString());
        listQRmy.DataSource = ds;
        listQRmy.DataBind();
    }

    //已完成确认
    public void BindWanChengmy(string strWhere = "")
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("select     bx_date, bx_banbie, bx_gonghao, bx_name, bx_banzhu, bx_dh, bx_moju_no, bx_moju_type, bx_part, bx_mo_no, bx_gz_type, bx_gz_desc, bx_sbno, bx_sbname, status,level,b.cellphone,moju_repair ");
        //strSql.Append(" ,cast(datediff(mi,bx_date,getdate())/60 as varchar)+'小时 '+right('00'+cast(datediff(mi,bx_date,getdate())%60  as varchar),2)+' 分' bx_shichang ");
        strSql.Append(" ,cast(cast(datediff(ss, bx_date, qr_date) / 3600 as int) as varchar)+':'+right('00' + cast(cast(datediff(ss, bx_date, qr_date) % 3600 / 60 as int) as varchar), 2) bx_shichang ");
        //strSql.Append(" ,(select top 1 product_leibie from form3_Sale_Product_MainTable where pgino =(select left(xmh,5)  from [172.16.5.6].report.dbo.MoJu  where mojuno= bx_moju_no) ) as pd_type ");
        strSql.Append(" FROM mes.dbo.MES_SB_BX a join mes.dbo.MES_SB_QR c on a.bx_dh=c.dh  join mes.dbo.mes_sb_wx d on a.bx_dh=d.wx_dh  join [172.16.5.6].[eHR_DB].dbo.view_hr_emp b on b.employeeid=a.bx_gonghao  where  dateadd(hh,24,qr_date )>getdate() ");
        strSql.Append("    and status = '确认完成'  and ( bx_gonghao='" + WeiXin.GetCookie("workcode") + "' or wx_gonghao='" + WeiXin.GetCookie("workcode") + "' or c.qr_gh='" + WeiXin.GetCookie("workcode") + "' )   order by a.id asc");

        DataSet ds = DbHelperSQL.Query(strSql.ToString());
        listWCmy.DataSource = ds;
        listWCmy.DataBind();
    }


    ////发起人工单
    //public void BindMyOrder(string strWhere = "")
    //{
    //    StringBuilder strSql = new StringBuilder();
    //    strSql.Append("select   id, bx_date, bx_banbie, bx_gonghao, bx_name, bx_banzhu, bx_dh, bx_moju_no, bx_moju_type, bx_part, bx_mo_no, bx_gz_type, bx_gz_desc, bx_sbno, bx_sbname, status,level ,b.cellphone");
    //    strSql.Append(" ,cast(datediff(hh,bx_date,getdate()) as varchar)+'小时 '+right('00'+cast(datediff(mi,bx_date,getdate())%60  as varchar),2)+' 分' bx_shichang ");
    //    strSql.Append(" FROM mes.dbo.MES_SB_BX a join [172.16.5.6].[eHR_DB].dbo.view_hr_emp b on b.employeeid=a.bx_gonghao  where 1=1 and status <> '确认完成' and bx_gonghao='{0}'  order by id asc ");
    //    //if (strWhere.Trim() != "")
    //    //{
    //    //    strSql.Append(" where " + strWhere);
    //    //}
    //    DataSet ds = DbHelperSQL.Query(string.Format(strSql.ToString(), WeiXin.GetCookie("workcode")));
    //    listMyOrder.DataSource = ds;
    //    listMyOrder.DataBind();
    //}
    ////已分配的工单
    //public void BindMyWork(string strWhere = "")
    //{
    //    StringBuilder strSql = new StringBuilder();
    //    strSql.Append("select    bx_date, bx_banbie, bx_gonghao, bx_name, bx_banzhu, bx_dh, bx_moju_no, bx_moju_type, bx_part, bx_mo_no, bx_gz_type, bx_gz_desc, bx_sbno, bx_sbname, status,level,c.cellphone ");
    //    strSql.Append(" ,cast(datediff(hh,bx_date,getdate()) as varchar)+'小时 '+right('00'+cast(datediff(mi,bx_date,getdate())%60  as varchar),2)+' 分' bx_shichang ");
    //    strSql.Append(" FROM mes.dbo.MES_SB_BX a  join mes.dbo.MES_SB_WX b on a.bx_dh=b.wx_dh   join [172.16.5.6].[eHR_DB].dbo.view_hr_emp c on c.employeeid=b.wx_gonghao  where 1=1 and status <> '确认完成' and wx_end_date is null and b.wx_gonghao='{0}'  order by a.id asc");
    //    //if (strWhere.Trim() != "")
    //    //{
    //    //    strSql.Append(" where " + strWhere);
    //    //}
    //    DataSet ds = DbHelperSQL.Query(string.Format(strSql.ToString(),WeiXin.GetCookie("workcode")));
    //    listMyWork.DataSource = ds;
    //    listMyWork.DataBind();
    //}

    public static string Right(string param,int length)
    {
        string result = param.Substring(param.Length-length, length);
        return result;
    }

    public static string left(string param, int length)
    {
        string result = param.Substring(0, length-1);
        return result;
    }
}