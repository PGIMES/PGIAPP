using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


    
    public partial class Load_Material : System.Web.UI.Page
    {
        //定义对象
        public string timestamp;//签名的时间戳
        public string noncestr;//签名的随机串
        public string ent_signature;//企业签名        
        public string ent_ticket;//企业的jsapi_ticket         
        public string uri;//url

        string uid = "01764";
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {

                ShowValue();

                timestamp = DateTime.Now.Ticks.ToString().Substring(0, 10);
                noncestr = new Random().Next(10000).ToString();               
                //uri = Request.Url.ToString().Replace("#", "").Replace(PGI_APP.App_Code.WeiXin.Port, ""); //本地地址                
                //string entAccessTicket = PGI_APP.App_Code.WeiXin.GetEntAccessToken();//企业AccessTicket
                //ent_ticket = PGI_APP.App_Code.WeiXin.GetEntJsapi_Ticket(entAccessTicket);                
                //ent_signature = PGI_APP.App_Code.WeiXin.GetSignature(ent_ticket, noncestr, timestamp, uri);//企业签名
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
                string strsql = "select  ROUTING,BOM FROM [172.16.5.26].[Production].[dbo].[mes_pginosetting]where pgino = '{0}'";
                strsql = string.Format(strsql,txt_xmh.Text);
                var value_rout = SQLHelper.reDs(strsql).Tables[0];
                txt_routing.Text = value_rout.Rows[0][0].ToString();
                txt_Bom.Text = value_rout.Rows[0][1].ToString();
            }
            else
            {
               
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert(\"员工未上岗,请跳转至上岗页面\");window.location.href = 'Emp_Login.aspx'", true);
                return;
            }
               

        }

        protected void txt_lotno_TextChanged(object sender, EventArgs e)
        {
            string sql_no = "select top 1 1 from  Mes_App_WorkOrder_Wip where lot_no='{0}'";
            sql_no = string.Format(sql_no, txt_lotno.Text);
            var value_no = SQLHelper.reDs(sql_no).Tables[0];
            if (value_no != null && value_no.Rows.Count > 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert(\"Lot No已存在，请重新输入！.\")", true);
                return;
            }
             string sql = @"select tr_qty_chg,tr_part from [172.16.5.26].qad.dbo.qad_tr_hist 
             where tr_ref = '{0}' AND tr_type = 'RCT-TR'";
            sql = string.Format(sql, txt_lotno.Text);
            var value = SQLHelper.reDs(sql).Tables[0];
            if(value!=null && value.Rows.Count>0)
            {
            txt_qty.Text = value.Rows[0][0].ToString();
            txt_wlh.Text = value.Rows[0][1].ToString();
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert(\"请输入正确的Lot No.\")", true);
                return;

            }
        }


        protected void btnsave_Click(object sender, EventArgs e)
        {
            string sql = @"exec  load_app_material '{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}'";
            sql = string.Format(sql,txt_emp.Text,txt_location.Text,txt_xmh.Text,txt_lotno.Text,txt_wlh.Text,txt_qty.Text,txt_routing.Text,txt_Bom.Text);
            var value = SQLHelper.reDs(sql).Tables[0];

            if (value != null && value.Rows.Count > 0)
            {
                if(value.Rows[0][0].ToString()=="Y")
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert(\"上料完成.\")", true);
                    btnsave.Style.Add("disabled","true");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert(\"失败，请重新提交.\")", true);
                }
            }
        }
    }
