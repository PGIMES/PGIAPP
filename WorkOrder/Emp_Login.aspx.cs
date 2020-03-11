using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace PGI_APP
{
    public partial class Emp_Login : System.Web.UI.Page
    {
        string Inlogin = "N";
        string uid = "01764";
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {
                Setddl_value(ddl_position);
                txt_emp.Text = "01764马见彪";
            }
            setButton();

        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            string sql = @"exec  ry_app_login '{0}','{1}','{2}','{3}','{4}'";
            sql = string.Format(sql, Inlogin, uid, txt_emp.Text, ddl_position.SelectedValue, txt_part.Text);
            bool i = SQLHelper.ExSql(sql);
           
                if (i == true)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "alert('提交成功')", true);
                }
               
          
        }

        public void setButton()
        {
            //取当前登录者工号
            // bool btnok = false;
            string sql = @"if exists(select TOP 1 emp_code from Mes_App_EmployeeLogin 
                          WHERE emp_code = '{0}' AND on_date is not null and off_date IS NULL) 
                           select 'Y' ELSE SELECT 'N'    ";
            sql = string.Format(sql, uid);
            var value = SQLHelper.reDs(sql).Tables[0];
            //Y代表已上岗，未离岗;   N代表未上岗
            if (value.Rows[0][0].ToString() == "Y")
            {
                Inlogin = "Y";
                Button1.Text = "离岗确认";
            }

        }
        public void Setddl_value( DropDownList drop)
        {
            
            string strSQL = @"select location from Mes_App_Base_Location ";
            var value = SQLHelper.reDs(strSQL).Tables[0];
            drop.DataSource = value;
            drop.DataValueField = value.Columns[0].ColumnName.ToString();
            drop.DataTextField = value.Columns[0].ColumnName.ToString();
            drop.DataBind();
            drop.Items.Insert(0, new ListItem("--请选择--", ""));
        }

        protected void ddl_position_TextChanged(object sender, EventArgs e)
        {
            string strSQL = @"select pgino  from Mes_App_Base_Location where location='{0}'";
            strSQL = string.Format(strSQL,ddl_position.SelectedItem.Text);
            txt_part.Text = SQLHelper.reDs(strSQL).Tables[0].Rows[0][0].ToString();
        }
    }
}