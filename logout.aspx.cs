using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Xml;
using System.Xml.XPath;

public partial class logout : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        Session["Clicks"] = null;
        Session["empace"] = null;
        Session["CodCli"] = null;
        Response.Redirect("login.aspx");

    }

    protected void getErrorServer()
    {
        /*Caso ocorra qualquer erro algum tratamento através do try-catch chama a pagina padrão de erros*/
        Response.Redirect("error.aspx");
    }

}