using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Maticsoft.DBUtility;
public partial class RegInfo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
             wxuserid.Text =  WeiXin.GetCookie("userid");
        }
    }

    protected void workcode_TextChanged(object sender, EventArgs e)
    {        
        SQLHelper helper = new SQLHelper();
        string P1 = workcode.Text;
        var sql = string.Format(" select a.* from  [172.16.5.6].ehr_db.dbo.view_hr_emp a where a.EMPLOYEEID='{0}'  ", P1);
        var dt = DbHelperSQL.Query(sql).Tables[0];
         
        if (dt.Rows.Count == 0)
        {               
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alertinfo", "$(\"input[id*=workcode]\").val('');alert('暂未发现您提供工号【" + P1 + "】对应姓名或此人已离职，请确认工号是否正确（工号为5位数字如:02067）。如多次输入仍不行，请及时联系 IT 帮忙确认.')", true);
            return;
        }
        else
        {
            name.Text = dt.Rows[0]["truename"].ToString();
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alertinfo", "alert('你输入的人员为【" + P1 + " " + name.Text + "】.请确认是否你本人，无误再点确定保存.')", true);
        }
    }

    protected void registerBtn_Click(object sender, EventArgs e)
    {
        var sql = string.Format("update dbo.WX_User set workcode = '{0}' where wxuserid = '{1}'  ", workcode.Text,wxuserid.Text);
        bool i = SQLHelper.ExSql(sql);
        if (i == false)
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alertinfo", "alert('保存数据失败，请再试试。如果多次不行，请及时联系 IT 帮忙确认.')", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alertinfo", "alert('保存数据成功，请退出程序，重新进入。如仍有问题，请及时联系 IT 帮忙确认.')", true);
        }
    }
}