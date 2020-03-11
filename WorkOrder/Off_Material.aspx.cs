using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PGI_APP
{
    public partial class Off_Material : System.Web.UI.Page
    {
        string uid = "01764";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ShowValue();
            }
        }


        public void ShowValue()
        {
            //取当前登录者
            string sql = @"select emp_code+emp_name,pgino,location from [dbo].[Mes_App_EmployeeLogin] 
                            where emp_code='{0}' and off_date is null   ";
            sql = string.Format(sql, uid);
            var value = SQLHelper.reDs(sql).Tables[0];
            if (value != null && value.Rows.Count > 0)
            {
                txt_emp.Text = value.Rows[0][0].ToString();
                txt_xmh.Text = value.Rows[0][1].ToString();
                txt_location.Text = value.Rows[0][2].ToString();
              
            }
            else
            {

                ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert(\"员工未上岗,请跳转至上岗页面\");window.location.href = 'Emp_Login.aspx'", true);
                return;
            }
           
        }

       


        protected void btnsave_Click(object sender, EventArgs e)
        {
            string sql = @"exec  off_app_material '{0}','{1}','{2}','{3}'";
            sql = string.Format(sql, txt_emp.Text, txt_location.Text, txt_xmh.Text, txt_qty.Text);
            var value = SQLHelper.reDs(sql).Tables[0];

            if (value != null && value.Rows.Count > 0)
            {
                if (value.Rows[0][0].ToString() == "Y")
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert(\"下料完成.\")", true);
                    btnsave.Style.Add("disabled", "true");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert(\"失败，请重新提交.\")", true);
                }
            }
        }

        protected void txt_qty_TextChanged(object sender, EventArgs e)
        {
            string strsql = @"select lot_no as [Lot No],qty as 已上料数,qty-off_qty as 生产中,off_qty as 已下料数 from Mes_App_WorkOrder_Wip  where pgino='{0}'";
            strsql = string.Format(strsql, txt_xmh.Text);
            var value = SQLHelper.reDs(strsql).Tables[0];
            if (value != null && value.Rows.Count > 0)
            {
                GridView1.DataSource = value;
                GridView1.DataBind();
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert(\"当前产品无上料数，请确认.\")", true);
            }
        }
    }
}