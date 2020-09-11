using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class JianCe_JianCe_Rpt : System.Web.UI.Page
{
    public string connString = System.Configuration.ConfigurationManager.ConnectionStrings["DBJianCe"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        string id = Request.QueryString["id"].ToString();

        DataTable dt_rpt = new DataTable();
        dt_rpt.Columns.Add("num", typeof(string));
        dt_rpt.Columns.Add("filename", typeof(string));
        dt_rpt.Columns.Add("filepath", typeof(string));
        dt_rpt.Columns.Add("Extension", typeof(string));

        string sql = @"select * from App_JC with(nolock) where id={0}";
        sql = string.Format(sql, Convert.ToInt32(id));
        DataTable dt = SQLHelper.Query(sql, connString).Tables[0];

        string path = Server.MapPath(@"/file/");

        if (dt.Rows.Count == 1)
        {
            string filepath = dt.Rows[0]["filepath"].ToString();
            if (Directory.Exists(filepath))
            {
                foreach (string itemFilePath in Directory.GetFiles(filepath))
                {
                    FileInfo fi = new FileInfo(itemFilePath);

                    DataRow dr = dt_rpt.NewRow();
                    dr["num"] = dt_rpt.Rows.Count + 1;
                    dr["filename"] = fi.Name;
                    dr["filepath"] = @"/file/"+itemFilePath.Replace(path, "").Replace(@"\",@"/");
                    dr["Extension"] = fi.Extension.ToLower();
                    dt_rpt.Rows.Add(dr);

                    //创建时间    fi.CreationTime;   
                    //获取上次访问当前目录时间 fi.LastAccessTime   
                    //获取上次写入文件目录的时间 fi.LastWriteTime   
                }
            }
        }

        listBxInfo.DataSource = dt_rpt;
        listBxInfo.DataBind();

    }
}