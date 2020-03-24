using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class YL : System.Web.UI.Page
{
    //定义对象
    public string timestamp;//签名的时间戳
    public string noncestr;//签名的随机串
    public string ent_signature;//企业签名        
    public string ent_ticket;//企业的jsapi_ticket         
    public string uri;//url

    protected void Page_Load(object sender, EventArgs e)
    {
        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>layer.alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        if (!IsPostBack)
        {
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();

            timestamp = DateTime.Now.Ticks.ToString().Substring(0, 10);
            noncestr = new Random().Next(10000).ToString();
            uri = Request.Url.ToString().Replace("#", "").Replace(WeiXin.Port, ""); //本地地址                
            string entAccessTicket = WeiXin.GetEntAccessToken();//企业AccessTicket
            ent_ticket = WeiXin.GetEntJsapi_Ticket(entAccessTicket);
            ent_signature = WeiXin.GetSignature(ent_ticket, noncestr, timestamp, uri);//企业签名
        }

    }


    [WebMethod]
    public static string pgino_change(string pgino)
    {

        string re_sql = @"exec [usp_app_YL_pgino_change] '{0}'";
        re_sql = string.Format(re_sql, pgino);
        DataSet ds = SQLHelper.Query(re_sql);

        DataTable re_dt = ds.Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        string qty = "";
        if (flag == "N")
        {
            DataTable dt = ds.Tables[1];
            qty = dt.Rows[0]["pt_ord_mult"].ToString();
        }

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\",\"qty\":\"" + qty + "\"}]";
        return result;

    }

    protected void btnsave_Click(object sender, EventArgs e)
    {
        ////string _b_source = "";
        ////if (b_source1.Checked)
        ////    _b_source = b_source1.Value;
        ////if (b_source2.Checked)
        ////    _b_source = b_source2.Value;
        ////if (b_source3.Checked)
        ////    _b_source = b_source3.Value;

        //string _b_source = b_source.SelectedValue;

        //string re_sql = @"exec usp_app_workorder_ng_save '{0}', '{1}','{2}','{3}','{4}','{5}'";
        //re_sql = string.Format(re_sql, emp_code_name.Text, workorder.Text, pgino.SelectedValue, _b_source, op.SelectedValue, qty.Text);
        //DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        //string flag = re_dt.Rows[0][0].ToString();
        //string msg = re_dt.Rows[0][1].ToString();

        //if (flag == "N")
        //{
        //    ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('" + msg + "')", true);
        //    Response.Redirect("/workorder/bhgp_deal_list_new.aspx");
        //}
        //else
        //{
        //    ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "layer.alert('失败：" + msg + "')", true);
        //}

    }
}