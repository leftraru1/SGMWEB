using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class calendario2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Calendar1_SelectionChanged(object sender, EventArgs e)
    {
        String obj = Request.QueryString["textbox"];
        if(obj!="")
        {
            String strScript = "<script>window.opener.document.getElementById ('" + obj + "').value = '";
            strScript += Calendar1.SelectedDate.ToString("dd-MM-yyyy");
            strScript += "';self.close();";
            strScript += "</" + "script>";

            Response.Write(strScript);
           
        }
        
    }
}