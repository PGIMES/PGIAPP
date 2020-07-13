using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Maticsoft.DBUtility;

public partial class Sure_Material : System.Web.UI.Page
{
    public string _workshop = "";
    public string _lotno = "";
    public string _needno = "";
    public string _emp = "";
    public DataTable dt_infor;

    protected void Page_Load(object sender, EventArgs e)
    {
        _workshop = Request.QueryString["workshop"].ToString();
        _lotno = Request.QueryString["lotno"].ToString();
        _needno= Request.QueryString["need_no"].ToString();

        if (WeiXin.GetCookie("workcode") == null)
        {
            Response.Write("<script>layer.alert('登入信息过期，请退出程序重新进入。');window.history.back();location.reload();</script>");
            return;
        }


        if (!IsPostBack)
        {
            LoginUser lu = (LoginUser)WeiXin.GetJsonCookie();
            _emp = lu.WorkCode + lu.UserName;

            load_data();
        }
    }

    void load_data()
    {
        string re_sql = @"exec [usp_app_sure_material_load_data] '{0}','{1}'";
        re_sql = string.Format(re_sql, _lotno, _needno);
        DataSet ds = SQLHelper.Query(re_sql);

        DataTable dt0 = ds.Tables[0];
        listBxInfo_YL.DataSource = dt0;
        listBxInfo_YL.DataBind();

        dt_infor = ds.Tables[1];
    }


    [WebMethod]
    public static string Set_Lotno(string lotno, string needno, string emp)
    {

        string result = "";
        string re_sql = @"exec [usp_app_sure_material_lotno_change] '{0}','{1}'";
        re_sql = string.Format(re_sql, lotno, needno);
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        result = Newtonsoft.Json.JsonConvert.SerializeObject(re_dt);

        return result;
    }


    [WebMethod]
    public static string Sure_Sku(string emp, string needno, string lotno, string reject_qty)
    {
        string result = "";

        string re_sql = @"exec [usp_app_Sure_Sku] '{0}','{1}','{2}',{3}";
        re_sql = string.Format(re_sql, emp, needno, lotno, Convert.ToSingle(reject_qty == "" ? "0" : reject_qty));
        DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
        string flag = re_dt.Rows[0][0].ToString();
        string msg = re_dt.Rows[0][1].ToString();

        result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }

}
