using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Maticsoft.DBUtility;



public partial class Load_Material : System.Web.UI.Page
{
    public string _workshop = "";
    public string lotno = "";

    //定义对象
    public string timestamp;//签名的时间戳
    public string noncestr;//签名的随机串
    public string ent_signature;//企业签名        
    public string ent_ticket;//企业的jsapi_ticket         
    public string uri;//url


    protected void Page_Load(object sender, EventArgs e)
    {
        //_workshop = Request.QueryString["workshop"].ToString();
       // lotno= Request.QueryString["lotno"].ToString();
        lotno = "00338125";
        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>layer.alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }


        if (!IsPostBack)
        {
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            txt_emp.Text = lu.WorkCode;
            ShowValue(lu.WorkCode);
            //ShowValue("02432");

            timestamp = DateTime.Now.Ticks.ToString().Substring(0, 10);
            noncestr = new Random().Next(10000).ToString();
            uri = Request.Url.AbsoluteUri.ToString().Replace("#", "").Replace(WeiXin.Port, ""); //本地地址                
            string entAccessTicket = WeiXin.GetEntAccessToken();//企业AccessTicket
            ent_ticket = WeiXin.GetEntJsapi_Ticket(entAccessTicket);
            ent_signature = WeiXin.GetSignature(ent_ticket, noncestr, timestamp, uri);//企业签名
            
           
        }
    }


    public void ShowValue(string WorkCode)
    {
        //取当前登录者
        string gw = "";
        string sql = @"select emp_code+emp_name,pgino,location,id from [dbo].[Mes_App_EmployeeLogin] where emp_code='{0}' and off_date is null";
        sql = string.Format(sql, txt_emp.Text);
        var value = SQLHelper.reDs(sql).Tables[0];
        if (value.Rows.Count <= 0)
        {

            ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert(\"员工未上岗,请跳转至上岗页面\");window.location.href = 'Emp_Login.aspx?workshop=" + _workshop + "'", true);
            return;
        }
        else
        {
            string strsql = "select workshop+'/'+line+'/'+location as location from Mes_App_EmployeeLogin_Location where login_id='{0}'";
            strsql = string.Format(strsql, value.Rows[0]["id"].ToString());
            var dt = SQLHelper.reDs(strsql).Tables[0];
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                    gw += dt.Rows[i][0].ToString() + "<br/>";
                

            }
            
            
            txt_location.Text = gw;
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
    public static string lotno_change(string pgino, string lotno)
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
            DataTable dt = ds.Tables[1];
            qty = dt.Rows[0]["tr_qty_chg"].ToString();
            wlh = dt.Rows[0]["tr_part"].ToString();
        }

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\",\"qty\":\"" + qty + "\",\"wlh\":\"" + wlh + "\"}]";
        return result;

    }


    [WebMethod]
    public static string Set_Lotno(string lotno)
    {
        
        string result = "";
        string re_sql = @"exec [usp_app_load_material_lotno_change] '{0}'";
        re_sql = string.Format(re_sql, lotno);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        result = Newtonsoft.Json.JsonConvert.SerializeObject(re_dt);

        return result;




    }
    [WebMethod]
    public static string Get_pn(string pgino, string domain)
    {
        string result = "";
        string pn = "";
        string bom = "";
        string routing = "";
        string re_sql = @"select  bom,routing,pt_desc1 as pn FROM [172.16.5.26].[Production].[dbo].[mes_pginosetting] p   
	                       JOIN [172.16.5.26].qad.dbo.qad_pt_mstr pt on pt.pt_part=p.pgino where pgino ='{0}' and pt_domain='{1}'";
        re_sql = string.Format(re_sql, pgino, domain);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];


        if (re_dt.Rows.Count > 0)
        {
            bom = re_dt.Rows[0][0].ToString();
            routing = re_dt.Rows[0][1].ToString();
            pn = re_dt.Rows[0][2].ToString();
        }
        result = "[{\"pn\":\"" + pn + "\",\"routing\":\"" + routing + "\",\"bom\":\"" + bom + "\"}]";
        return result;

    }

    protected void btnsave_Click(object sender, EventArgs e)
    {

        string sql = @"exec usp_app_load_material_Insert '{0}','{1}'";
        sql = string.Format(sql, txt_emp.Text,lotno);
        var value = SQLHelper.reDs(sql).Tables[0];

        if (value != null && value.Rows.Count > 0)
        {
            if (value.Rows[0][0].ToString() == "Y")
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert(\"上料完成.\");window.location.href = 'YL_List_new.aspx?workshop=" + _workshop + "'", true);

            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "setinfo", "alert(\"失败，请重新提交.\")", true);
            }
        }
    }

    //void init_data(string lotno )
    //{
    //    string sql = @"exec [usp_app_load_material_lotno_change] '{0}'";
    //    sql = string.Format(sql, lotno);
    //    DataTable dt = SQLHelper.Query(sql).Tables[0];

    //    listBxInfo.DataSource = dt;
    //    listBxInfo.DataBind();
    //}


}
