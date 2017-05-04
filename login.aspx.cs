using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Xml;
using System.Xml.XPath;

public partial class login : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {        
        /*
            verificar se tem usuário armazenado no cookie
        */        
        if (Request.Cookies["ssbuscausuario"] != null && String.IsNullOrEmpty(txtUsuario.Text))
        {
            txtUsuario.Text = Request.Cookies["ssbuscausuario"].Value;
            
            if (!String.IsNullOrEmpty(txtUsuario.Text))
            {
                myonoffswitch.Checked = true;
                txtSenha.Focus();
            }
            else
            {
                txtUsuario.Focus();
            }
        }
        else
        {
            txtUsuario.Focus();
        }

        /*
            Carrega o CopyRight do Portal...
        */
        copyright.InnerText = DateTime.Now.Year.ToString() + " © SS Sistemas";

        /*
            Carregar o arquivo de configuração do layout
        */

        XmlTextReader reader = new XmlTextReader(AppDomain.CurrentDomain.BaseDirectory + "config.xml");
        while (reader.Read())
        {
            if (reader.NodeType == XmlNodeType.Element && reader.Name == "descricao")
            {
                lblconfigdescricaocliente.Text = (reader.ReadString());
            }

            if (reader.NodeType == XmlNodeType.Element && reader.Name == "title")
            {
                this.Title = (reader.ReadString());
                
            }

            if (reader.NodeType == XmlNodeType.Element && reader.Name == "fundo")
            {
                bodylogin.Style["background-image"] = "url(img/"+(reader.ReadString())+ ".png)";
            }


        }

        reader.Dispose();
    }

    protected void btLogar_Click(object sender, EventArgs e)
    {
        /* Verificar Login*/
        //verificar se login está correto
        String sLogin;
        String sPasswd;

        sLogin  = "";
        sPasswd = "";

        try
        {
            sLogin = txtUsuario.Text;
            sPasswd = txtSenha.Text;
        }
        catch (ArgumentNullException ex)
        {
            getErrorServer();
        }

        if (String.IsNullOrEmpty(sLogin))
        {
            // vamos mostrar a mensagem que     
        }
        else
        {
            int    eof = 0;
            String codigo = "";
            String empace = "";            
            int    numeroacessoweb = 0;

            // login de demonstração... DEIXEI FIXO :(
            if ((sLogin.ToLower() == "demonstracao" && sPasswd.ToLower() == "jesus") || (sLogin.ToLower() == "sssistemas" && sPasswd.ToLower() == "jesus"))
            {
                eof = 1;
            }
            else
            {
                SqlDataSourceLogin.SelectCommand = "select codigo, passwordweb, coalesce(nroacessoweb,0), empaceweb from pccdcli0 " +
                                                   "where ativo = 1 and cast(lpad(cast(cgc1 as varchar(8)),8,'0')||lpad(cast(cgc2 as varchar(4)),4, '0')||lpad(cast(cgc3 as varchar(2)),2,'0') as varchar(14)) = '" + sLogin + "' and passwordweb = md5('" + sPasswd + "') and empaceweb is not null and empaceweb <> '' ";

                try
                {
                    DataView dv = (DataView)SqlDataSourceLogin.Select(DataSourceSelectArguments.Empty);
                    eof = dv.Count;
                    if (eof == 1)
                    {
                        codigo = dv[0][0].ToString();
                        empace = dv[0][3].ToString();                        

                        if (String.IsNullOrEmpty(dv[0][2].ToString()))
                        {
                            numeroacessoweb = 0;
                        }
                        else
                        {
                            numeroacessoweb = Int32.Parse(dv[0][2].ToString());
                        }

                        dv.Dispose();                        
                        
                    }
                }
                catch
                {
                    getErrorServer();
                }              
              
            }

            /*Verificar pois caso retorne mais de um cliente por um único CNPJ o sistema emite falha na autenticação...*/
            if (eof == 1)
            {
                if (Session["Clicks"] == null)
                {
                    Session["Clicks"] = "login.busca.sssistemas.com";                    
                    HttpCookie cookieLogin = new HttpCookie("sslogin8");
                    cookieLogin.Value = "logado";
                    DateTime dtnow = DateTime.Now;
                    TimeSpan tsminute = new TimeSpan(0, 0, 5, 0);
                    cookieLogin.Expires = dtnow + tsminute;
                    Response.Cookies.Add(cookieLogin);
                    HttpContext.Current.Response.Cookies.Set(cookieLogin);
                }

                /*Carrega em uma Session a empresa selecionado*/
                Session["empace"] = empace;
                
                /* Captura o valor do checkbox */
                bool bLembrarSenha;
                bLembrarSenha = myonoffswitch.Checked;

                /* Verifica se é pra lembrar a senha ou não, gravar e um cookie..*/
                if (bLembrarSenha)
                {
                    Response.Cookies["ssbuscausuario"].Value = sLogin;
                }
                else
                {
                    /*Se não é para lembrar mais senha apagar o cookie*/
                    Response.Cookies["ssbuscausuario"].Value = String.Empty;
                }

                Session["CodCli"] = codigo;

                if ((numeroacessoweb == 0) && (sLogin.ToLower() !=  "demonstracao") && (sLogin.ToLower() != "sssistemas"))
                {                    
                    Response.Redirect("changepass.aspx");
                }
                else
                {
                    // contador de acessos.                    
                    try
                    {
                        SqlDataSourceLogin.UpdateCommand = "update pccdcli0 set nroacessoweb = coalesce(nroacessoweb,0) + 1 where codigo = '" + codigo + "'";
                        SqlDataSourceLogin.Update();
                    }
                    catch
                    {
                        getErrorServer();
                    }

                    Response.Redirect("Default.aspx");
                } 
            }
            else
            {
                
                if (eof > 1)
                {
                    /*Apenas para identificação de que estão tentando logar no CNPJ (duplicado)
                      ou seja o CNPJ de login é repetido para mais de um cliente ... 
                    */
                    lblResultado.Text = "Seu Login falhou, verifique suas credenciais (#CNPJ)";
                }
                else
                {
                    lblResultado.Text = "Seu Login falhou, verifique suas credenciais";
                        
                }

            }

            txtUsuario.Focus();

        }
    }

    protected void getErrorServer()
    {
        /*Caso ocorra qualquer erro algum tratamento através do try-catch chama a pagina padrão de erros*/
        /*        Response.Redirect("error.aspx"); */
    }

}