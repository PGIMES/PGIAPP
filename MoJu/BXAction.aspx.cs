using Maticsoft.DBUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MoJu_BXAction : System.Web.UI.Page
{
    public string bx_shichang  ;
    public string qr_shichang;
    public string qr_date;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string dh = Request["dh"];
            DataTable dtBX = GetBXData(dh).Tables[0];
            if (dtBX.Rows.Count > 0)
            {
                bx_shichang = dtBX.Rows[0]["bx_shichang"].ToString();
                listBxInfo.DataSource = dtBX;
                listBxInfo.DataBind();
            }

            ViewState["state"] = dtBX.Rows[0]["status"].ToString();

            setVisibleState(dtBX.Rows[0]["status"].ToString(),dh,dtBX.Rows[0]["level"].ToString());
            //showpanel();


        }
    }

    private void BindWX(string dh)
    {
        DataTable dtWX = GetWXData(dh).Tables[0];
        if (dtWX.Rows.Count > 0)
        {
            listWXInfo.DataSource = dtWX;
            listWXInfo.DataBind();
            if(dtWX.Rows[0]["wx_end_date"] is DBNull)
            {
                enableBtn(false,true,false);
            }
                
        }
        else
        {

        }
    }

    private void BindQR(string dh)
    {
        DataTable dt = GetQRData(dh).Tables[0];
        if (dt.Rows.Count > 0)
        {
            //listQRInfo.DataSource = dt;
            //listQRInfo.DataBind();
            txtQr_Remark.Value = dt.Rows[0]["qr_remark"].ToString();
             
            qr_date = Convert.ToDateTime(dt.Rows[0]["qr_date"]).ToString("MM/dd HH:mm");
            qr_shichang= dt.Rows[0]["qr_shichang"].ToString();
            bx_shichang = dt.Rows[0]["bx_shichang"].ToString();
        }
        else
        {

        }
    }

    private void setVisibleState(string status,string dh,string level)
    {
         
        string workcode = WeiXin.GetCookie("workcode");
         
        if (status == "报修完成")
        {

            enableBtn(true, false, false);
            VisibleBtn(true, false, false);

        }
        else if (status == "维修中")
        {
            BindWX( dh);
            enableBtn(false, true, false);
            VisibleBtn(false, true, false);
            string script = "$('#PageWX').removeAttr('hidden'); ";
            ClientScript.RegisterStartupScript(this.GetType(), "show", script, true);            

             
            
        }
        else if (status == "维修完成")
        {

            //DataTable dt = fun.Get_WX_Record(gv.Cells[1].Text);
            //txtWX_CS.Value = dt.Rows[0]["wx_cs"].ToString();
            //dropResult.Text = dt.Rows[0]["wx_result"].ToString();
            //txtMo_Down_cs.Value = dt.Rows[0]["mo_down_cs"].ToString();
            BindWX(dh);
            enableBtn(false, false, true);
            VisibleBtn(false, false, true);
            string script = "$('#PageWX').removeAttr('hidden');$('#PageQR').removeAttr('hidden');";             
            ClientScript.RegisterStartupScript(this.GetType(), "show", script, true);
        }
        else if(status == "确认完成")
        {
            BindWX(dh);
            BindQR(dh);
            string script = "$('#PageWX').removeAttr('hidden');$('#PageQR').removeAttr('hidden');";
            ClientScript.RegisterStartupScript(this.GetType(), "show", script, true);
            enableBtn(false, false, false);
            VisibleBtn(false, false, false);
        }

        SetRole(workcode, level);

    }

    
    public void enableBtn(Boolean blnStart, Boolean blnEnd, Boolean blnConfirm)
    {
         
        this.btnStart.Enabled = blnStart;
        if(blnStart==false)
        btnStart.CssClass = "weui-btn weui-btn_disabled  ";

        this.btnEnd.Enabled = blnEnd;
        if (blnEnd == false)
            btnEnd.CssClass = "weui-btn weui-btn_disabled  ";

        this.btnConfirm.Enabled = blnConfirm;
        if (blnConfirm == false)
            btnConfirm.CssClass = "weui-btn weui-btn_disabled  ";
    }
    public void VisibleBtn(Boolean blnStart, Boolean blnEnd, Boolean blnConfirm)
    {

        this.btnStart.Visible = blnStart;

        this.btnEnd.Visible = blnEnd;

        this.btnConfirm.Visible = blnConfirm;

    }

    public DataSet GetBXData(string dh,string strWhere="")
    {
        
        StringBuilder strSql = new StringBuilder();
        strSql.Append("select   id, bx_date, bx_banbie, bx_gonghao, bx_name, bx_banzhu, bx_dh, bx_moju_no, bx_moju_type, bx_part, bx_mo_no, bx_gz_type, bx_gz_desc, bx_sbno, bx_sbname, status,level,b.cellphone  ");
        strSql.Append(" ,cast(datediff(mi,bx_date,getdate())/60 as varchar)+'小时 '+right('00'+cast(datediff(mi,bx_date,getdate())%60  as varchar),2)+'分' bx_shichang ");
        strSql.Append(" ,(select top 1 product_leibie from form3_Sale_Product_MainTable where pgino =(select left(xmh,5)  from [172.16.5.6].report.dbo.MoJu  where mojuno= bx_moju_no ) ) as pd_type ");
        strSql.Append(" FROM  mes.dbo.MES_SB_BX a join [172.16.5.6].[eHR_DB].dbo.view_hr_emp b on b.employeeid=a.bx_gonghao where bx_dh='{0}'");
        
        return DbHelperSQL.Query(string.Format(strSql.ToString(),dh));
    }

    public DataSet GetWXData(string dh, string strWhere = "")
    {

        StringBuilder strSql = new StringBuilder();
        strSql.Append("select  wx_dh,wx_gonghao,wx_name,wx_banzhu,wx_banbie,wx_cs,wx_result,mo_down_cs,wx_begin_date,wx_end_date,b.cellphone   ");
        strSql.Append(" ,cast(datediff(mi,bx_date,isnull(wx_begin_date,getdate()))/60 as varchar)+'小时 '+right('00'+cast(datediff(mi,bx_date,isnull(wx_begin_date,getdate()) )%60  as varchar),2)+'分' jx_shichang ");
        strSql.Append(" ,cast(cast(datediff(mi, wx_begin_date, isnull(wx_end_date,getdate())) / 60 as int) as varchar)+'小时 '+right('00'+cast(datediff(mi,wx_begin_date,isnull(wx_end_date,getdate()) )%60  as varchar),2)+'分' wx_shichang ");
         //         cast(cast(datediff(ss, @starttime, @endtime) / 3600 as int) as varchar) + ':' + right('00' + cast(cast(datediff(ss, @starttime, @endtime) % 3600 / 60 as int) as varchar), 2)
         //cast(datediff(mi,wx_begin_date,isnull(wx_end_date,getdate()))/60 as varchar)
        strSql.Append(" FROM  mes.dbo.MES_SB_WX a join mes.dbo.MES_SB_BX c on a.wx_dh=c.bx_dh join [172.16.5.6].[eHR_DB].dbo.view_hr_emp b on b.employeeid=a.wx_gonghao where wx_dh='{0}'");

        return DbHelperSQL.Query(string.Format(strSql.ToString(), dh));
    }

    public DataSet GetQRData(string dh, string strWhere = "")
    {

        StringBuilder strSql = new StringBuilder();
        strSql.Append("select  a.* ");
        strSql.Append(" ,cast(datediff(mi,bx_date,qr_date)/60 as varchar)+'小时 '+right('00'+cast(datediff(mi,bx_date,qr_date )%60  as varchar),2)+'分' bx_shichang ");
        strSql.Append(" ,cast(datediff(mi,wx_end_date,qr_date)/60 as varchar)+'小时 '+right('00'+cast(datediff(mi,wx_end_date,qr_date )%60  as varchar),2)+'分' qr_shichang ");
        strSql.Append(" FROM  mes.dbo.MES_SB_QR a join mes.dbo.mes_sb_wx b  on b.wx_dh=a.dh   join mes.dbo.mes_sb_bx c on  a.dh=c.bx_dh  where dh='{0}'");

        return DbHelperSQL.Query(string.Format(strSql.ToString(), dh));
    }

    protected void btnStart_Click(object sender, EventArgs e)
    {
        MES.Model.MES_SB_WX m = new MES.Model.MES_SB_WX();
        string wx_dh = Request["dh"];
        //txtHidden.Value = wx_dh;
        m.wx_dh = wx_dh;
        m.wx_begin_date = DateTime.Now;
        m.wx_banbie = "";//txtBanBie.Value;
        m.wx_banzhu = "";//txtBanZu.Value;
        m.wx_gonghao = WeiXin.GetCookie("workcode");//dropWXGongHao.SelectedValue;
        m.wx_name =  ((LoginUser)WeiXin.GetJsonCookie()).UserName;
        m.p_status = "维修中";
        MES.DAL.MES_SB_WX dal = new MES.DAL.MES_SB_WX();
        try
        {            

            if (DbHelperSQL.GetSingle("select count(1) from MES.[dbo].[MES_SB_wx] where wx_dh='" + wx_dh + "'").ToString() == "0")
            {
                int result = dal.Add(m);//因经常出现资料未插入事件
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", @"alert('接修成功.');self.location='BXMonitor.aspx';  ", true);
                 

            }

        }
        catch (Exception ex)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", @"layer.alert('失败，请重试.[ex:" + ex.Message + "]'); ", true);
        }
        finally { }
    }

    public void btnEnd_Click(object sender, EventArgs e)
    {
        MES.Model.MES_SB_WX m = new MES.Model.MES_SB_WX();
        string wx_dh = Request["dh"];
        foreach (RepeaterItem item in listWXInfo.Items)
        {
            TextBox txt = (TextBox)item.FindControl("wx_cs");
            m.wx_cs  = txt.Text;
        }
        m.wx_dh = wx_dh;
        m.wx_end_date = DateTime.Now;        
        foreach (RepeaterItem item in listWXInfo.Items)
        {
            TextBox txt = (TextBox)item.FindControl("wx_cs");              
            m.wx_result =  txt.Text;
        }        
        m.mo_down_cs = "";
        m.p_status = "维修完成";
        MES.DAL.MES_SB_WX dal = new MES.DAL.MES_SB_WX();
        dal.Update(m);

        Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", @"alert('提交完成成功.');self.location='BXMonitor.aspx';  ", true);

    }

    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        MES.Model.MES_SB_QR m = new MES.Model.MES_SB_QR();
        string wx_dh = Request["dh"];// GridView1.SelectedRow.Cells[1].Text.Trim();
        m.dh = wx_dh;
        m.qr_date = DateTime.Now;
        m.qr_banbie = "";// txtBanBie.Value;
        m.qr_banzhu = "";// txtBanZu.Value;
        m.qr_gh = WeiXin.GetCookie("workcode");
        m.qr_name = ((LoginUser)WeiXin.GetJsonCookie()).UserName; 
        m.qr_remark = this.txtQr_Remark.Value;
        m.p_status = "确认完成";
        

        MES.DAL.MES_SB_WX dal = new MES.DAL.MES_SB_WX();
        if (dal.IsExitsQR(m.dh) == 0)//--确认是否重复确认
        {
            dal.Add(m);
        }

        string strSQL = "update MES_SB_BX set [status]='" + m.p_status + "' where bx_dh='" + m.dh + "';";
        DbHelperSQL.ExecuteSql(strSQL);//因经常会无法更新到状态，固在此重复更新一次

          
        strSQL = "SELECT wx_result FROM MES_SB_WX WHERE wx_dh='" + wx_dh + "'  ";
        DataTable tbl = DbHelperSQL.Query(strSQL).Tables[0];
        if (tbl.Rows[0][0].ToString() == "需下模维修")
        {
            string str = "alert('维修结果为：需下模维修，请至电脑端进换模页面进行维护信息.');self.location='BXMonitor.aspx';";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", str, true);

        }
        else
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('确认成功.');self.location='BXMonitor.aspx';", true);
        }

    }

    public void SetRole(string workcode,string level)
    {
         
        string strSQL = @" select dept.UNITNAME from[172.16.5.6].[ehr_db].dbo.psnaccount
                        left join[172.16.5.6].[eHR_DB].dbo.ORGSTDSTRUCT on PSNACCOUNT.BRANCHID=ORGSTDSTRUCT.UNITID
                        left join[172.16.5.6].[eHR_DB].dbo.ORGSTDSTRUCT dept on left(ORGSTDSTRUCT.UNITCODE,8)=dept.UNITCODE and dept.ISTEMPUNIT=0
                        where PSNACCOUNT.accessionstate in(1,2,6) and employeeid = '{0}'";
        strSQL = string.Format(strSQL, workcode);
        DataTable dt = DbHelperSQL.Query(strSQL).Tables[0];
        string dept = dt.Rows[0][0].ToString();
        if (dept.Contains("生产三部")  )
        {
            if( level == "一级")
            {
                enableBtn(true, true, true);
            }
            else
            {
                enableBtn(false, false, true);
            }
           
        }
        else if(dept.Contains("压铸技术部") ) //接修 / 完成
        {
            if (level == "一级")
            {
                enableBtn(false, false, false);
            }
            else
            {
                enableBtn(true, true, false);
            }
        }
        else if (dept.Contains("IT"))
        {
            enableBtn(true, true, true);
        }
        else
        {
            enableBtn(false, false, false);
        }
        

    }

}