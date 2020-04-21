using System;
using System.Data;
using System.Configuration;
using System.Data.OleDb;
using System.Collections.Generic;
using System.Data.Odbc;
using System.Data.Sql;
using System.Data.SqlClient;
using System.IO;
using System.Security.Cryptography;
using System.Reflection;
using System.Diagnostics;
using System.Text;
//using Pgi.Public;

//namespace Pgi.Data
//{
   public class QadOdbcHelper
    {

        public static string SQLErrorString;
        public static string ODBCCSRead = "Dsn=mfgprod_read;uid=sysprogress;pwd=sysprogress";
        public static string ODBCCS = "Dsn=mfgtrain_write;uid=sysprogress;pwd=sysprogress";

        /// <summary>
        /// 使用ODBC连接查询结果集合返回DataTable
        /// </summary>
        public static System.Data.DataTable GetODBCRows(string sql)
        {
            SQLErrorString = "";
            OdbcConnection _connection = new OdbcConnection(ODBCCSRead);
            OdbcDataAdapter currDataAdapter = null;
            System.Data.DataTable dt = new System.Data.DataTable();
            try
            {
                currDataAdapter = new OdbcDataAdapter(sql, _connection);
                currDataAdapter.Fill(dt);
                return dt;

            }
            catch (Exception e)
            {
                SQLErrorString = e.Message.ToString();
                //Logger.Info("查询QAD语句"+sql);
                //Logger.Info(e.StackTrace);
                return null;
            }
            finally
            {
                currDataAdapter.Dispose();
                _connection.Close();
                _connection = null;
            }
        }

    }
//}
