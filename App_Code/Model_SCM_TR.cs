using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


public class Model_SCM_TR
{
    public Model_SCM_TR()
    {

    }

    public string cmdtype { get; set; }

    public int id { get; set; }
    public int sourceid { get; set; }
    public int historyid { get; set; }
    public string guid { get; set; }
    public string need_no { get; set; }
    //<part>P0066AA</part>
    public string part { get; set; }
    //<lotserial_qty>2</lotserial_qty>
    public decimal lotserial_qty { get; set; }
    //<nbr></nbr>
    public string nbr { get; set; }
    //<so_job></so_job>
    public string so_job { get; set; }
    //<rmks></rmks>
    public string rmks { get; set; }
    //<site_from>200</site_from>
    public string site_from { get; set; }
    //<loc_from>9000</loc_from>
    public string loc_from { get; set; }
    //<lotser_from></lotser_from>
    public string lotser_from { get; set; }
    //<lotref_from>W1335535</lotref_from>
    public string lotref_from { get; set; }
    //<site_to>200</site_to>
    public string site_to { get; set; }
    //<loc_to>9060</loc_to>
    public string loc_to { get; set; }
    //<lotser_to></lotser_to>
    public string lotser_to { get; set; }
    //<lotref_to>T1335535</lotref_to>
    public string lotref_to { get; set; }
    //<companycode>200</companycode>
    public string companycode { get; set; }
    //<ex1></ex1>
    public string ex1 { get; set; }
    //<ex2></ex2>
    public string ex2 { get; set; }
    //<ex3></ex3>
    public string ex3 { get; set; }
    //<ex4></ex4>
    public string ex4 { get; set; }
    //<ex5></ex5>
    public string ex5 { get; set; }
    //<ex6></ex6>
    public string ex6 { get; set; }
}

