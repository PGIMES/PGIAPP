using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class YL : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

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