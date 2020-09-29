using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;

public partial class WorkOrder_Loc_Transfer : System.Web.UI.Page
{
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
            emp_code_name.Text = lu.WorkCode + lu.UserName;
            domain.Text = lu.Domain;

            //emp_code_name.Text = "02432何桂勤";
            domain.Text = "200";

        }

    }

    [WebMethod]
    public static string init_data_js(string domain, string emp)
    {
        string result = "";
        string sql = @" exec [usp_app_Loc_Transfer_init_data_js] '" + domain + "','" + emp + "'";
        DataSet ds = SQLHelper.Query(sql);

        DataTable dt_pgino = ds.Tables[0];
        string json_pgino = JsonConvert.SerializeObject(dt_pgino);

        result = "[{\"json_pgino\":" + json_pgino + "}]";
        return result;

    }

    [WebMethod]
    public static string pgino_change(string domain, string pgino, string _ref, string loc)
    {
        string result = ""; string msg = "";
        string xmh_value = "", ref_value = "", loc_value = "", qty_value = "";

        if (pgino == "") { msg = "请先输入物料号"; }

        if (msg == "")
        {
            string sql = @" exec [usp_app_Loc_Transfer_init_data_js] '" + domain + "','','" + pgino + "'";
            DataTable dt_pgino = SQLHelper.Query(sql).Tables[0];
            if (dt_pgino.Rows.Count <= 0)
            {
                msg = "物料号" + pgino + "不存在";
            }

            if (msg == "")
            {
                xmh_value = dt_pgino.Rows[0]["title"].ToString();

                DataTable ldt = new DataTable();
                string sqlStr = "select ld_ref,cast(ld_qty_oh as float)ld_qty_oh,ld_loc from pub.ld_det where ld_domain='{0}' and ld_part='{1}' and ld_qty_oh>0 with (nolock)";
                sqlStr = string.Format(sqlStr, domain, xmh_value);
                ldt = QadOdbcHelper.GetODBCRows(sqlStr);

                if (ldt == null)
                {
                    msg = "项目号" + xmh_value + ",QAD库存不存在";
                }
                else
                {
                    if (ldt.Rows.Count <= 0)
                    {
                        msg = "项目号" + xmh_value + ",QAD库存不存在";
                    }
                }

                if (msg == "")
                {
                    DataRow[] drs = null;
                    if (_ref != "" && loc == "")
                    {
                        drs = ldt.Select("ld_ref='" + _ref + "'");
                        if (drs.Length <= 0)
                        {
                            msg = "项目号" + xmh_value + ",参考号" + _ref + ",QAD库存不存在";
                        }
                    }
                    else if (_ref == "" && loc != "")
                    {
                        drs = ldt.Select("ld_loc='" + loc + "' and ld_ref=''");
                        if (drs.Length <= 0)
                        {
                            msg = "项目号" + xmh_value + ",当前库位" + loc + ",QAD库存不存在";
                        }
                        else if (drs.Length > 1)
                        {
                            msg = "项目号" + xmh_value + ",当前库位" + loc + ",QAD库存存在多笔";
                        }
                    }
                    else if (_ref != "" && loc != "")
                    {
                        drs = ldt.Select("ld_ref='" + _ref + "' and ld_loc='" + loc + "'");
                        if (drs.Length <= 0)
                        {
                            msg = "项目号" + xmh_value + ",参考号" + _ref + ",当前库位" + loc + ",QAD库存不存在";
                        }
                        else if (drs.Length > 1)
                        {
                            msg = "项目号" + xmh_value + ",参考号" + _ref + ",当前库位" + loc + ",QAD库存存在多笔";
                        }
                    }

                    if (msg == "" && drs != null)
                    {
                        if (drs.Length == 1)//多笔的 不自动带出
                        {
                            ref_value = drs[0]["ld_ref"].ToString();
                            qty_value = drs[0]["ld_qty_oh"].ToString();
                            loc_value = drs[0]["ld_loc"].ToString();
                        }
                    }
                }
            }
        }

        result = "[{\"msg\":\"" + msg + "\",\"xmh_value\":\"" + xmh_value + "\",\"ref_value\":\"" + ref_value + "\",\"loc_value\":\"" + loc_value + "\",\"qty_value\":\"" + qty_value + "\"}]";
        return result;

    }

    [WebMethod]
    public static string loc_to_change(string domain, string loc)
    {
        string flag = "N", msg = "";
        string sql = @" exec [usp_app_Loc_Transfer_loc_to_change] '" + domain + "','" + loc + "'";
        DataTable re_dt = SQLHelper.Query(sql).Tables[0];
        flag = re_dt.Rows[0][0].ToString();
        msg = re_dt.Rows[0][1].ToString();

        string result = "[{\"flag\":\"" + flag + "\",\"msg\":\"" + msg + "\"}]";
        return result;

    }


    [WebMethod]
    public static string save(string _emp_code_name, string domain, string pgino, string _ref, string loc, string qty
            , string ref_to, string loc_to,string comment)
    {
        string msg = "";

        try
        {
            Model_SCM_TR en = new Model_SCM_TR();
            en.need_no = "";
            en.sourceid = 0;
            en.historyid = 0;
            en.guid = Guid.NewGuid().ToString();
            en.companycode = domain;
            en.part = pgino;
            en.lotserial_qty = Convert.ToDecimal(qty);
            en.nbr = "";
            en.so_job = "";
            en.rmks = "";
            en.site_from = domain;
            en.loc_from = loc;
            en.lotser_from = "";
            en.lotref_from = _ref;
            en.site_to = domain;
            en.loc_to = loc_to;
            en.lotser_to = "";
            en.lotref_to = ref_to;
            en.ex1 = "";
            en.ex2 = "";
            en.ex3 = "";
            en.ex4 = "";
            en.ex5 = "";
            en.ex6 = "";
            en.cmdtype = "库位转移";


            //-----------------------插入数据库，做log记录
            string re_sql = re_sql = @"exec [usp_app_Loc_Transfer_Log] '{0}','{1}','{2}','{3}','{4}',{5},'{6}','{7}','{8}','{9}'";
            re_sql = string.Format(re_sql, _emp_code_name, domain, pgino, _ref, loc, Convert.ToSingle(qty), ref_to, loc_to, en.guid, comment);
            DataTable re_dt = SQLHelper.Query(re_sql).Tables[0];
            msg = re_dt.Rows[0][0].ToString();


            //-------------------------调用webservice
            if (msg == "")
            {
                string content = GetXmlForTR(en);
                QadWebservices.QADInterfaceSoapClient ser = new QadWebservices.QADInterfaceSoapClient("QADInterfaceSoap");
                string rec_msg = ser.Invoke("SCM", "QAD", en.guid, "TR", content);

                string qad_result = "", qad_msg = "";
                qad_result = ParseResultMessage(rec_msg, out qad_msg);
                if (qad_result != "200") { msg = qad_msg; } //200正确，其他错误

                string sqlStr = "update App_Loc_Transfer set ERR_CODE='" + qad_result + "',ERR_MSG='" + qad_msg + "',qad_updatetime=getdate() where guid_id='" + en.guid + "'";
                SQLHelper.ExSql(sqlStr);
            }
        }
        catch (Exception ex)
        {
            msg = "error:" + ex.Message;
        }

        string result = "[{\"msg\":\"" + msg + "\"}]";
        return result;

    }

    public static string GetXmlForTR(Model_SCM_TR en)
    {
        string result = "";
        XElement rootElement = new XElement("Root", "");
        XDocument xmlDoc = new XDocument(
                                                new XDeclaration("1.0", "UTF-8", null),
                                                rootElement
                                            );

        string sqlStr = "SELECT '" + en.guid + "' AS RequestID,'SCM' AS SourceSystem,'QAD' AS TargetSystem,'TR' AS ServiceName,'123' AS ServiceOperation,'123' AS ServiceVersion";
        DataTable dt_RequestHead = SQLHelper.Query(sqlStr).Tables[0];
        dt_RequestHead.TableName = "RequestHead";
        rootElement.Add(DataTableToXML(dt_RequestHead).Root.Elements());

        XElement RequestBody = new XElement("RequestBody", "");
        XElement elementList = new XElement("List", "");


        elementList.Add(Get_Model_SCM_TR(en).Root.Elements());

        RequestBody.Add(elementList);
        rootElement.Add(RequestBody);
        result = xmlDoc.ToString();
        return result;
    }

    /// <summary>
    /// Datatable转成XML
    /// </summary>
    /// <param name="dt"></param>
    /// <returns></returns>
    public static XDocument DataTableToXML(DataTable dt)
    {
        //XNamespace tcs = "http://www.chinaport.gov.cn/tcs/v2";
        XDocument xDoc = new XDocument();
        //创建xml的根节点
        XElement rootElement = new XElement("root");
        //将根节点加入到xml文件中（Add）
        xDoc.Add(rootElement);
        string elementName = dt.TableName;
        foreach (DataRow dr in dt.Rows)
        {
            //XElement xmlRow = new XElement(tcs + elementName);
            XElement xmlRow = new XElement(elementName);
            rootElement.Add(xmlRow);
            foreach (DataColumn col in dt.Columns)
            {
                //XElement xmlCol = new XElement(tcs + col.ColumnName);
                XElement xmlCol = new XElement(col.ColumnName);
                if (dr[col].ToString() != null && dr[col].ToString() != "")
                {
                    if (dr[col].GetType() == typeof(DateTime))
                    {
                        DateTime dateTime = (DateTime)dr[col];
                        if (dateTime != null && dateTime != DateTime.MinValue)
                        {
                            xmlCol.Value = dateTime.ToString("yyyy-MM-dd HH:mm:ss");
                        }
                        else
                        {
                            xmlCol.Value = "";
                        }
                    }
                    else
                    {
                        xmlCol.Value = dr[col].ToString();
                        if (xmlCol.Value.Contains("\x1f"))
                        {
                            xmlCol.Value = xmlCol.Value.Replace("\x1f", "");
                        }
                    }
                }
                xmlRow.Add(xmlCol);
            }
        }
        XNode rootNode = xDoc.FirstNode;
        return xDoc;
    }
    
    public static XDocument Get_Model_SCM_TR(Model_SCM_TR en)
    {
        XDocument xDoc = new XDocument();
        //创建xml的根节点
        XElement rootElement = new XElement("root");
        //将根节点加入到xml文件中（Add）
        xDoc.Add(rootElement);
        XElement tr = new XElement("TR", "");
        rootElement.Add(tr);
        XElement part = new XElement("part", en.part);
        tr.Add(part);
        XElement lotserial_qty = new XElement("lotserial_qty", en.lotserial_qty);
        tr.Add(lotserial_qty);
        XElement nbr = new XElement("nbr", en.nbr);
        tr.Add(nbr);
        XElement so_job = new XElement("so_job", en.so_job);
        tr.Add(so_job);
        XElement rmks = new XElement("rmks", en.rmks);
        tr.Add(rmks);
        XElement site_from = new XElement("site_from", en.site_from);
        tr.Add(site_from);
        XElement loc_from = new XElement("loc_from", en.loc_from);
        tr.Add(loc_from);
        XElement lotser_from = new XElement("lotser_from", en.lotser_from);
        tr.Add(lotser_from);
        XElement lotref_from = new XElement("lotref_from", en.lotref_from);
        tr.Add(lotref_from);
        XElement site_to = new XElement("site_to", en.site_to);
        tr.Add(site_to);
        XElement loc_to = new XElement("loc_to", en.loc_to);
        tr.Add(loc_to);
        XElement lotser_to = new XElement("lotser_to", en.lotser_to);
        tr.Add(lotser_to);
        XElement lotref_to = new XElement("lotref_to", en.lotref_to);
        tr.Add(lotref_to);
        XElement companycode = new XElement("companycode", en.companycode);
        tr.Add(companycode);
        XElement ex1 = new XElement("ex1", en.ex1);
        tr.Add(ex1);
        XElement ex2 = new XElement("ex2", en.ex2);
        tr.Add(ex2);
        XElement ex3 = new XElement("ex3", en.ex3);
        tr.Add(ex3);
        XElement ex4 = new XElement("ex4", en.ex4);
        tr.Add(ex4);
        XElement ex5 = new XElement("ex5", en.ex5);
        tr.Add(ex5);
        XElement ex6 = new XElement("ex6", en.ex6);
        tr.Add(ex6);
        return xDoc;
    }

    public static string ParseResultMessage(string rec_msg,out string err_msgs)
    {
        string result = "";
        err_msgs = "";
        try
        {
            XmlDocument xdoc = new XmlDocument();
            xdoc.LoadXml(rec_msg);
            XmlNode CorpTaskId = xdoc.SelectSingleNode("root/RequestHead/RequestID");
            string guid = CorpTaskId.InnerText;

            XmlNodeList EportLocationInformations = xdoc.SelectNodes("root/RequestBody/List/QAD");
            foreach (XmlNode item in EportLocationInformations)
            {
                //XmlNode BKF_DOC = item.SelectSingleNode("BKF_DOC");
                XmlNode ERR_CODE = item.SelectSingleNode("ERR_CODE"); //200正确，其他错误
                XmlNode ERR_MSG = item.SelectSingleNode("ERR_MSG");
                result = ERR_CODE.InnerText;
                err_msgs = ERR_MSG.InnerText;
            }
        }
        catch (Exception ex)//解析返回结果出错
        {
            result = "000";
            err_msgs = ex.Message;
        }
        return result;
    }


}