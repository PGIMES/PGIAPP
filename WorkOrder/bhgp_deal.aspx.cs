using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class bhgp_deal : System.Web.UI.Page
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
            Response.Write("<script>alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }

        if (!IsPostBack)
        {
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            emp_code_name.Text = lu.WorkCode + lu.UserName;
            //emp_code_name.Text = "02432何桂勤";

            bind_pgino();
            bind_source("");

            timestamp = DateTime.Now.Ticks.ToString().Substring(0, 10);
            noncestr = new Random().Next(10000).ToString();
            uri = Request.Url.ToString().Replace("#", "").Replace(WeiXin.Port, ""); //本地地址                
            string entAccessTicket = WeiXin.GetEntAccessToken();//企业AccessTicket
            ent_ticket = WeiXin.GetEntJsapi_Ticket(entAccessTicket);
            ent_signature = WeiXin.GetSignature(ent_ticket, noncestr, timestamp, uri);//企业签名
        }
        
    }

    void bind_pgino()
    {
        string sql = "select '' pgino union all select distinct pgino from Mes_App_WorkOrder_Wip";
        DataTable re_dt = SQLHelper.Query(sql).Tables[0];
        pgino.DataSource = re_dt;
        pgino.DataTextField = "pgino";
        pgino.DataValueField = "pgino";
        pgino.DataBind();
    }
    void bind_op(string pgino)
    {
        string sql = @"select '' op 
            union all select right(op,len(op)-2) op 
                    from MES.dbo.V_PGI_GYLX 
                    where b_flag=1 and pgi_no_t=(select top 1 routing from Mes_App_WorkOrder_Wip where pgino='{0}')";
        sql = string.Format(sql, pgino);
        DataTable re_dt = SQLHelper.Query(sql).Tables[0];
        op.DataSource = re_dt;
        op.DataTextField = "op";
        op.DataValueField = "op";
        op.DataBind();
    }
    protected void pgino_SelectedIndexChanged(object sender, EventArgs e)
    {
        bind_op(pgino.SelectedValue);
    }

    //来源
    void bind_source(string domain)//--请选择--
    {
        string sql = @"select '' code,'' desc1
                    union all select '生产现场' code,'生产现场' desc1
                    union all select '线边库' code,'线边库' desc1
                    union all select '终检' code,'终检' desc1";
        DataTable re_dt = SQLHelper.Query(sql).Tables[0];
        b_source.DataSource = re_dt;
        b_source.DataTextField = "desc1";
        b_source.DataValueField = "code";
        b_source.DataBind();
    }

    protected void btnsave_Click(object sender, EventArgs e)
    {
        //string _b_source = "";
        //if (b_source1.Checked)
        //    _b_source = b_source1.Value;
        //if (b_source2.Checked)
        //    _b_source = b_source2.Value;
        //if (b_source3.Checked)
        //    _b_source = b_source3.Value;

        string _b_source = b_source.SelectedValue;

        string re_sql = @"exec usp_app_workorder_ng_save '{0}', '{1}','{2}','{3}','{4}','{5}'";
        re_sql = string.Format(re_sql, emp_code_name.Text, workorder.Text, pgino.SelectedValue, _b_source, op.SelectedValue, qty.Text);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        if (flag=="N")
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "alert('" + msg + "')", true);
            Response.Redirect("/workorder/bhgp_deal_list_new.aspx");
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", "alert('失败："+ msg + "')", true);
        }

    }

}
