using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Xml;
using System.Xml.XPath;

public partial class password : System.Web.UI.Page
{   

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Clicks"] == null)
        {
            Response.Redirect("login.aspx");
        }

        lblInfo.Text = "Por segurança no seu primeiro acesso altere sua senha";
        lblconfigdescricaocliente.Text = "SS Search Parts Anywhere";
        txtsenha.Focus();
    }
    
    protected void salvarSenha()
    {
        /*AQUI*/
        lblResultado.Text = "teste";
    }

    protected void alterarSenha(object sender, EventArgs e)
    {
        /* Verificar Login*/
        //verificar se login está correto
        String sPassword;
        String sPasswordConfirmar;      

        sPassword          = txtsenha.Text;
        sPasswordConfirmar = txtsenhaconfirma.Text;
        

        if (sPassword != sPasswordConfirmar)
        {
            lblResultado.Text = "Senhas não conferem !";
        }
        else
        {
            if (sPassword.Length < 6)
            {
                lblResultado.Text = "Senhas devem possuir no mínimo 6 dígitos letras e números";
            }
            else
            {
                if (Session["CodCli"] != null){
                    lblResultado.Text = "senhas alteradas com sucesso !";
                    String ccodigo = Session["CodCli"].ToString();
                    try
                    {                        
                        SqlDataSourceTrocaSenha.UpdateCommand = "update pccdcli0 set nroacessoweb = coalesce(nroacessoweb,0) + 1, passwordweb = md5('" + sPassword + "') where codigo = '" + ccodigo + "'";
                        SqlDataSourceTrocaSenha.Update();                        
                    }
                    catch
                    {
                        getErrorServer();
                    }
                    Session["CodCli"] = null;
                    Response.Redirect("Default.aspx");
                }
                else
                {
                    Response.Redirect("login.aspx");
                }
            }            
        }        
        
    }

    protected void getErrorServer()
    {
        /*Caso ocorra qualquer erro algum tratamento através do try-catch chama a pagina padrão de erros*/
        Response.Redirect("error.aspx");
    }

}