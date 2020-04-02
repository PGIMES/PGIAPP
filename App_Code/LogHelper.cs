using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Net;
namespace Common
{
    public class LogHelper
    {
        static string path = System.Web.HttpContext.Current.Server.MapPath("/") + @"\Log\";
        public static void Write(string str)
        {
            //try
            //{
            //    string fileName = DateTime.Now.ToShortDateString().Replace("/", "") + ".txt";
            //    if (!File.Exists(path + fileName))
            //    {
            //        File.Create(path + fileName);
            //    }
            //    FileStream fs = new FileStream(path + fileName, FileMode.Append);
            //    StreamWriter sw = new StreamWriter(fs);
            //    //开始写入
            //    sw.WriteLine(str + "-----" + DateTime.Now.ToString() + "\r\n");
            //    //清空缓冲区
            //    sw.Flush();
            //    //关闭流
            //    sw.Close();
            //    fs.Close();



            //}
            //catch(Exception e)
            //{

            //}


            try
            {
                //bool flag = !Directory.Exists(path + "\\Log");
                //if (flag)
                //{
                //    Directory.CreateDirectory(path );
                //}
                //string fileName = path +  DateTime.Now.ToString("yyyyMMdd") + ".Log";
                //FileInfo fileInfo = new FileInfo(fileName);
                //StreamWriter streamWriter = fileInfo.AppendText();
                //streamWriter.BaseStream.Seek(0L, SeekOrigin.End);
                //streamWriter.WriteLine(DateTime.Now.ToString("yyyyMMdd HH:mm:ss:fff") + "-" + str);
                //streamWriter.Close();
            }
            catch
            {
            }

        }
    }
}