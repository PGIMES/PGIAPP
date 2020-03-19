using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Services;
using Maticsoft.DBUtility;
public partial class MoJu_MoJu_BX_APP : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }
        if (!IsPostBack)
        {

            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            txt_empname.Value = lu.WorkCode + lu.UserName;
            // txt_empname.Value = "01744孙娟";
            bind_sb();
        }
    }




    protected void btnsave_Click(object sender, EventArgs e)
    {
        string sqlStr = "select iif(COUNT(1)>0,0,1) as IsInUse  from mes.dbo.MES_SB_BX where   status<>'确认完成' and bx_moju_no='{0}'";
        sqlStr = string.Format(sqlStr,ddl_mojuno.SelectedValue);
        var dt = SQLHelper.Query(sqlStr).Tables[0];
        if (dt.Rows[0][0].ToString() == "0")
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "alert('此模具正在维修确认中,请勿重复报修！')", true);
           
        }
        else
        {
            string level = "";
            if(g1.Checked==true)
            {
                level = "一级";
            }
            else
            { level = "二级"; }
            string sql = @"exec mes.dbo.MES_MoJu_BX_Insert_app  '{0}','{1}','{2}','{3}','{4}','{5}','{6}'";
            sql = string.Format(sql, txt_empname.Value, ddl_mojuno.SelectedValue, ddl_equip.SelectedItem.Text,
                gztype.Value, gxms.Value,  0, level);
            int b_flag = DbHelperSQL.ExecuteSql(sql);
            if (b_flag>0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "alert('报修成功！');window.location.href = 'BXMonitor.aspx'", true);

            }
        }
    }

    
    [WebMethod]
    public static string sel_sbno()
    {

        string result = "";
        var sql = @"select '' value,'请选择' text 
                      union all
                    select distinct m.equip_no as value,e.equip_name as text from mes.[dbo].[MES_YZ_MoJu] m join mes.dbo.MES_Equipment e on m.equip_no = e.equip_no 
                    where status = 0 and e.equip_type = '压铸机'";

        var value = DbHelperSQL.Query(sql).Tables[0];
        if (value.Rows.Count > 0)
        {
            result = Newtonsoft.Json.JsonConvert.SerializeObject(value);
        }
        return result;

    }

    [WebMethod]
    public static string sel_Mojuno(string sbno)
    {

        string result = "";
        var sql = @"select '' value  union all select rtrim(moju_no) as value  from mes.[dbo].[MES_YZ_MoJu] 
                   where equip_no='{0}'  and status=0";
        sql = string.Format(sql,sbno);
        var value = DbHelperSQL.Query(sql).Tables[0];
        if (value.Rows.Count > 0)
        {
            result = Newtonsoft.Json.JsonConvert.SerializeObject(value);
        }
        return result;

    }

    [WebMethod]
    public static string sel_gz()
    {

        string result = "";
        string strSQL = @"select '' value,'' text union all select  base_value as value,base_value as text 
                           from mes.dbo.MES_Base_code where base_code='MOJU_BX_TYPE'";
        var value = DbHelperSQL.Query(strSQL).Tables[0];
        if (value.Rows.Count > 0)
        {
            result = Newtonsoft.Json.JsonConvert.SerializeObject(value);
        }
        return result;

    }

    void bind_sb()
    {
        string strSQL = @"select '' value,'请选择' text 
                      union all
                    select distinct m.equip_no as value,e.equip_name as text from mes.[dbo].[MES_YZ_MoJu] m join mes.dbo.MES_Equipment e on m.equip_no = e.equip_no 
                    where status = 0 and e.equip_type = '压铸机'";
        strSQL = string.Format(strSQL);
        DataTable re_dt = DbHelperSQL.Query(strSQL).Tables[0];
        ddl_equip.DataSource = re_dt;
        ddl_equip.DataTextField = "text";
        ddl_equip.DataValueField = "value";
        ddl_equip.DataBind();



    }


    protected void ddl_equip_SelectedIndexChanged(object sender, EventArgs e)
    {
        bind_moju(ddl_equip.SelectedValue);
        txt_pn.Value = "";
    }
    void bind_moju(string sbno)
    {
        string strSQL = @"select '' value,'请选择'  text union all select moju_no as value,moju_no+' '+moju_type as text
                         from mes.[dbo].[MES_YZ_MoJu] where equip_no='{0}'  and status=0";
        strSQL = string.Format(strSQL, sbno);
        DataTable re_dt = DbHelperSQL.Query(strSQL).Tables[0];
        ddl_mojuno.DataSource = re_dt;
        ddl_mojuno.DataTextField = "text";
        ddl_mojuno.DataValueField = "value";
        ddl_mojuno.DataBind();


    }

    protected void ddl_mojuno_SelectedIndexChanged(object sender, EventArgs e)
    {
        string sql = "select part from mes.dbo.[MES_YZ_MoJu] where equip_no='{0}'  and status=0 and moju_no='{1}'";
        sql = string.Format(sql, ddl_equip.SelectedValue, ddl_mojuno.SelectedValue);
        var dt = DbHelperSQL.Query(sql).Tables[0];
        if (dt.Rows.Count > 0)
        {
            txt_pn.Value = dt.Rows[0]["part"].ToString();
        }
    }
}