using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MoJu_SB_WX_Chart_APP : System.Web.UI.Page
{
    public static string _workshop = "";
    protected void Page_Load(object sender, EventArgs e)
    {//Server.UrlDecode
        _workshop = Request.QueryString["workshop"].ToString();
    }

    public static DataSet Query(string SQLString)
    {
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.AppSettings["connstringAPI"]))
        {
            DataSet ds = new DataSet();
            try
            {
                connection.Open();
                SqlDataAdapter command = new SqlDataAdapter(SQLString, connection);
                command.SelectCommand.CommandTimeout = 0;
                command.Fill(ds, "ds");
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }

    }

    [WebMethod]
    public static string init()
    {

        string sql = @"exec api.dbo.[SheBei_ForMes_Detail_Ver7_chart_APP] '"+ _workshop + "'";
        DataTable dt_day = Query(sql).Tables[0];
        string json_day = JsonConvert.SerializeObject(dt_day);

        DataTable dt_week = Query(sql).Tables[1];
        string json_week = JsonConvert.SerializeObject(dt_week);

        DataTable dt_month = Query(sql).Tables[2];
        string json_month = JsonConvert.SerializeObject(dt_month);

        string result = "[{\"json_day\":" + json_day + ",\"json_week\":" + json_week + ",\"json_month\":" + json_month + "}]";
        return result;

    }
}