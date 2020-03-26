using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;



public partial class Load_Material : System.Web.UI.Page
{
    public string _workshop = "";

    //定义对象
    public string timestamp;//签名的时间戳
    public string noncestr;//签名的随机串
    public string ent_signature;//企业签名        
    public string ent_ticket;//企业的jsapi_ticket         
    public string uri;//url


    protected void Page_Load(object sender, EventArgs e)
    {
        _workshop = Request.QueryString["workshop"].ToString();

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>layer.alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }


        if (!IsPostBack)
        {
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();

            ShowValue(lu.WorkCode);
            //ShowValue("02432");

            timestamp = DateTime.Now.Ticks.ToString().Substring(0, 10);
            noncestr = new Random().Next(10000).ToString();
            uri = Request.Url.ToString().Replace("#", "").Replace(WeiXin.Port, ""); //本地地址                
            string entAccessTicket = WeiXin.GetEntAccessToken();//企业AccessTicket
            ent_ticket = WeiXin.GetEntJsapi_Ticket(entAccessTicket);
            ent_signature = WeiXin.GetSignature(ent_ticket, noncestr, timestamp, uri);//企业签名
        }
    }


    public void ShowValue(string WorkCode)
    {
        //取当前登录者
        string sql = @"select emp_code+emp_name,pgino,location from [dbo].[Mes_App_EmployeeLogin] where emp_code='{0}' and off_date is null";
        sql = string.Format(sql, WorkCode);
        var value = SQLHelper.reDs(sql).Tables[0];
        if (value != null && value.Rows.Count > 0)
        {
            txt_emp.Text = value.Rows[0][0].ToString();
            txt_xmh.Text = value.Rows[0][1].ToString();
            txt_location.Text = value.Rows[0][2].ToString();

            string strsql = "select  ROUTING,BOM FROM [172.16.5.26].[Production].[dbo].[mes_pginosetting]where pgino = '{0}'";
            strsql = string.Format(strsql, txt_xmh.Text);
            var value_rout = SQLHelper.reDs(strsql).Tables[0];
            txt_routing.Text = value_rout.Rows[0][0].ToString();
            txt_Bom.Text = value_rout.Rows[0][1].ToString();
        }
        else
        {

            ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "layer.alert(\"员工未上岗,请跳转至上岗页面\");window.location.href = 'Emp_Login.aspx?workshop="+_workshop+ "'", true);
            return;
        }


    }

    //protected void txt_lotno_TextChanged(object sender, EventArgs e)
    //{
    //    string re_sql = @"exec [usp_app_load_material_lot_change] '{0}', '{1}'";
    //    re_sql = string.Format(re_sql, txt_xmh.Text, txt_lotno.Text);
    //    DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
    //    string flag = re_dt.Rows[0][0].ToString();

    //    if (flag == "N")
    //    {
    //        txt_qty.Text = re_dt.Rows[0]["tr_qty_chg"].ToString();
    //        txt_wlh.Text = re_dt.Rows[0]["tr_part"].ToString();
    //    }
    //    else
    //    {
    //        string msg = re_dt.Rows[0][1].ToString();
    //        ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert('" + msg + "')", true);
    //        return;
    //    }
        
    //}

    [WebMethod]
    public static string lotno_change(string pgino,string lotno)
    {

        string re_sql = @"exec [usp_app_load_material_lot_change] '{0}', '{1}'";
        re_sql = string.Format(re_sql, pgino, lotno);
        DataSet ds = SQLHelper.Query(re_sql);

        DataTable re_dt = ds.Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        string qty = "", wlh = "";
        if (flag == "N")
        {
            DataTable dt= ds.Tables[1];
            qty = dt.Rows[0]["tr_qty_chg"].ToString();
            wlh = dt.Rows[0]["tr_part"].ToString();
        }

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\",\"qty\":\"" + qty + "\",\"wlh\":\"" + wlh + "\"}]";
        return result;

    }



    protected void btnsave_Click(object sender, EventArgs e)
    {
        string sql = @"exec usp_app_load_material '{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}'";
        sql = string.Format(sql, txt_emp.Text, txt_location.Text, txt_xmh.Text, txt_lotno.Text, txt_wlh.Text, txt_qty.Text, txt_routing.Text, txt_Bom.Text);
        var value = SQLHelper.reDs(sql).Tables[0];

        if (value != null && value.Rows.Count > 0)
        {
            if (value.Rows[0][0].ToString() == "Y")
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "layer.alert(\"上料完成.\");$('#txt_lotno').val('');$('#txt_wlh').val('');$('#txt_qty').val('');", true);
                //btnsave.Style.Add("disabled", "true");
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "layer.alert(\"失败，请重新提交.\")", true);
            }
        }
    }


}
