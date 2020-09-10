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
        dt_rpt.Columns.Add("filename", typeof(string));

        string sql = @"select * from App_JC with(nolock) where id={0}";
        sql = string.Format(sql, Convert.ToInt32(id));
        DataTable dt = SQLHelper.Query(sql, connString).Tables[0];

        if (dt.Rows.Count == 1)
        {
            string filepath = dt.Rows[0]["filepath"].ToString();
            string folderPath = Server.MapPath(filepath);

            if (Directory.Exists(folderPath))
            {
                foreach (string itemFilePath in Directory.GetFiles(folderPath))
                {
                    FileInfo fi = new FileInfo(itemFilePath);

                    DataRow dr = dt_rpt.NewRow();
                    dr["filename"] = fi.Name;
                    dt_rpt.Rows.Add(dr);

                    //创建时间    fi.CreationTime;   
                    //获取上次访问当前目录时间 fi.LastAccessTime   
                    //获取上次写入文件目录的时间 fi.LastWriteTime   

                    //string Extension = fi.Extension.ToLower();
                    //if (Extension.Equals(".jpg") || Extension.Equals(".jpge") || Extension.Equals(".gif") || Extension.Equals(".pdf"))
                    //{
                    //    isTp = true;
                    //    break;
                    //}
                    //else {
                    //    isTp = false;
                    //}
                }
            }
        }

        listBxInfo.DataSource = dt_rpt;
        listBxInfo.DataBind();

    }
}