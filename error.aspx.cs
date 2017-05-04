using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Xml;
using System.Xml.XPath;

public partial class error : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {        
      
        XmlTextReader reader = new XmlTextReader(AppDomain.CurrentDomain.BaseDirectory + "config.xml");
        while (reader.Read())
        {
 
            if (reader.NodeType == XmlNodeType.Element && reader.Name == "title")
            {
                this.Title = (reader.ReadString());                
            }

            if (reader.NodeType == XmlNodeType.Element && reader.Name == "fundo")
            {
                bodyerror.Style["background-image"] = "url(img/"+(reader.ReadString())+ ".png)";
            }


        }
        reader.Dispose();

    }
}