using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class MoJu_MoJu_BX : System.Web.UI.Page
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

           // LoginUser lu = (LoginUser)WeiXin.GetUserModeCookie();
           // txt_empname.Text = lu.WorkCode + lu.UserName;
            txt_empname.Text = "01744孙娟";
            bind_sb(txt_empname.Text);
            show_value();



        }
    }

    void bind_sb(string uid )
    {
        string strSQL = @"select '' equip_no union all select equip_no  from mes.dbo.MES_Equipment where equip_type='压铸机'  and 
                          equip_no in (select  emp_shebei from mes.dbo.MES_EmpLogin  where logoffdate is null and emp_no='{0}')  
                          order by equip_no";
        strSQL = string.Format(strSQL,txt_empname.Text.Substring(0,5));
        DataTable re_dt = SQLHelper.Query(strSQL).Tables[0];
        ddl_sbname.DataSource = re_dt;
        ddl_sbname.DataTextField = "equip_no";
        ddl_sbname.DataValueField = "equip_no";
        ddl_sbname.DataBind();
        


    }

    void bind_moju(string sbno )
    {
        string strSQL = @"select '' moju_no union all select moju_no from mes.[dbo].[MES_YZ_MoJu] where equip_no='{0}'  and status=0";
        strSQL = string.Format(strSQL, sbno);
        DataTable re_dt = SQLHelper.Query(strSQL).Tables[0];
        ddl_mojuno.DataSource = re_dt;
        ddl_mojuno.DataTextField = "moju_no";
        ddl_mojuno.DataValueField = "moju_no";
        ddl_mojuno.DataBind();


    }

    void show_value()
    {
        string strSQL = @"select ''base_value union all select  base_value from mes.dbo.MES_Base_code where base_code='MOJU_BX_TYPE'";
        strSQL = string.Format(strSQL);
        DataTable re_dt = SQLHelper.Query(strSQL).Tables[0];
        ddl_gz.DataSource = re_dt;
        ddl_gz.DataTextField = "base_value";
        ddl_gz.DataValueField = "base_value";
        ddl_gz.DataBind();


    }
    protected void btnsave_Click(object sender, EventArgs e)
    {
        string sqlStr = "select iif(COUNT(1)>0,0,1) as IsInUse  from MES_SB_BX where   status<>'确认完成' and bx_moju_no='{0}'";
        sqlStr = string.Format(sqlStr,ddl_mojuno.SelectedValue);
        var dt = SQLHelper.Query(sqlStr).Tables[0];
        if (dt.Rows[0][0].ToString()=="0")
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "alert(''此模具正在维修确认中,请勿重复报修！')", true);
        }
        else
        {
            string strbz= "select emp_banbie,emp_banzhu from mes.dbo.MES_EmpLogin where  emp_shebei='{0}' and emp_no='{1}' and status=1 ";
            strbz = string.Format(strbz,ddl_sbname.SelectedValue,txt_empname.Text.Substring(0,5));
            var bzdt  = SQLHelper.Query(sqlStr).Tables[0];
            string banbie = bzdt.Rows[0][0].ToString();
            string banzu= bzdt.Rows[0][1].ToString();
            int totalmoci = int.Parse(bcmoci.Text) + int.Parse(txt_summoci.Text);
            string nowtime  =System.DateTime.Now.ToString("yyyy/MM/dd") + " " + System.DateTime.Now.ToString("HH:mm:ss");
            string sql = @"exec mes.MES_MoJu_BX_Insert '{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}','{13}','{14}','{15}','{16}','{17}'";
            sql = string.Format(sql,1,txt_empname.Text.Substring(0,5),txt_empname.Text.Substring(6),banbie,banzu,ddl_mojuno.SelectedValue,ddl_sbname.SelectedValue,txt_mojutype.Text,
                txt_pn.Text,txt_mono.Text,ddl_gz.SelectedValue,txt_gz_ms.Text, nowtime, Is_stop.SelectedValue, bcmoci.Text, totalmoci);
        }
    }

    protected void ddl_mojuno_SelectedIndexChanged(object sender, EventArgs e)
    {
        string sql = "select * from mes.dbo.[MES_YZ_MoJu] where equip_no='{0}'  and status=0 and moju_no='{1}'";
        sql = string.Format(sql,ddl_sbname.SelectedValue,ddl_mojuno.SelectedValue);
        var dt= SQLHelper.Query(sql).Tables[0];
        if(dt.Rows.Count>0)
        {
            txt_pn.Text = dt.Rows[0]["part"].ToString();
            txt_mono.Text= dt.Rows[0]["mo_no"].ToString();
            txt_mojutype.Text= dt.Rows[0]["moju_type"].ToString();
        }
        string strSQL = "SELECT moci FROM [172.16.5.6].report.dbo.moju where mojuno='{0}'";
        strSQL = string.Format(strSQL,ddl_mojuno.SelectedValue);
        DataTable tbl2 = SQLHelper.Query(strSQL).Tables[0];
        txt_summoci.Text = tbl2.Rows[0][0].ToString();
    }

    protected void ddl_sbname_SelectedIndexChanged(object sender, EventArgs e)
    {
        bind_moju(ddl_sbname.SelectedValue);
    }
}