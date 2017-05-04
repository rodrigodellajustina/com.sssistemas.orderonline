using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Xml;
using System.Xml.XPath;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        String parametroCodigoCliente = "";
        String parametroEmpresaSelecionada = "";
        /*
            Carregar o arquivo de configuração do layout
            falta terminar....
        */

        XmlTextReader reader = new XmlTextReader(AppDomain.CurrentDomain.BaseDirectory + "config.xml");
        while (reader.Read())
        {

            if (reader.NodeType == XmlNodeType.Element && reader.Name == "title")
            {
                this.Title = (reader.ReadString());

            }

            if (reader.NodeType == XmlNodeType.Element && reader.Name == "fundo")
            {
                string c = reader.ReadString();
                //bodydefault.Style["background-image"] = "url(img/" + c + ".png)";

                if (c == "laranja")
                {
                    GridView1.HeaderStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#d46829");
                }

                if (c == "amarelo")
                {
                    GridView1.HeaderStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#c7c20f");
                }

                if (c == "vermelho")
                {
                    GridView1.HeaderStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#c70f0f");
                    GridView1.AlternatingRowStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9d9d");
                }

                if (c == "azulescuro")
                {
                    GridView1.HeaderStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#1e34d4");
                }

                if (c == "azulclaro")
                {
                    GridView1.HeaderStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#008bef");
                }

            }




        }

        reader.Dispose();



        if (Session["Clicks"] == null)
        {
            Response.Redirect("login.aspx");
        }
        
        try
        {
            parametroEmpresaSelecionada = Session["empace"].ToString();
            parametroCodigoCliente = Session["CodCli"].ToString();

            
            // apenas para o ambiente de teste verifiar uma forma de remover isso ...
            if (parametroEmpresaSelecionada.Trim() == "")
            {
                parametroEmpresaSelecionada = "0001";
            }

            if (parametroCodigoCliente.Trim() == "")
            {
                parametroCodigoCliente = "0045306";
            }

        }
        catch
        {
            Response.Redirect("login.aspx");
        }

        SqlDataSource1.SelectCommand = "select * from (SELECT  " +
                                        "    sup_busca.codigo, " +
                                        "    sup_busca.basico, " +
                                        "    sup_busca.marca , " +
                                        "    sup_busca.descr1, " +
                                        "    sup_busca.unidad, " +
                                        "    CAST(f_getprecodescontoespecialmarkup(sup_busca.codigo, '" + parametroCodigoCliente + "', '" + parametroEmpresaSelecionada + "') AS NUMERIC(8,2)) as prvist, " +
                                        "    case when saldo_estoque('F', '" + parametroEmpresaSelecionada + "', sup_busca.codigo, '', current_date) > 0 then " +
                                        "        cast('DISPONÍVEL' as varchar(20)) " +
                                        "    else " +
                                        "        cast('INDISPONIVEL' as varchar(20)) " +
                                        "    end as estoque, " +
                                        "    (SELECT cast(arquivo as text) FROM imagem_produto where imagem_produto.codigo = sup_busca.codigo LIMIT 1) as arquivo " +
                                        "FROM " +
                                        "    super_busca_ite_view as sup_busca " +
                                        "WHERE " +
                                        "    ativo     = 1 and " +
                                        "    cancelado = false and " +
                                        "    prvist    > 0     " +
                                        "LIMIT " +
                                        "    50) as tmp " +
                                        "ORDER BY " +
                                        "    estoque, tmp.descr1 ";

    }

    protected void GridView1_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            String parametroBusca = "" ;
            String parametroEmpresaSelecionada = "";
            String parametroCodigoCliente = "";

            GridView1.SelectedIndex = -1;
            /* #1232 - Della Justina*/
            /* Troca os valores das variáveis de ' ' <vazio> para % para realizar uma busca contida usando like*/
            parametroBusca = txtBusca.Text;
            parametroBusca = parametroBusca.ToUpper();
            parametroBusca = parametroBusca.Replace(' ', '%');
            parametroBusca = parametroBusca.Replace("'", "");
            parametroBusca = parametroBusca.Trim();
            lblResultado.Text = "";

            /*Carrega parâmetros de login ...*/
            try
            {
                parametroEmpresaSelecionada = Session["empace"].ToString();
                parametroCodigoCliente = Session["CodCli"].ToString();
            }
            catch
            {
                Response.Redirect("login.aspx");
            }

            /*#1232 - Della Justina*/
            /**/
            int i;
            bool isparametronumerico = int.TryParse(parametroBusca, out i);


            if (parametroBusca.Length > 0)
            {
                /*Tenta encontrar pelo código de fabrincante....*/
                SqlDataSource1.SelectCommand = "SELECT  " +
                                               "    sup_busca.codigo, " +
                                               "    sup_busca.basico, " +
                                               "    sup_busca.marca , " +
                                               "    sup_busca.descr1, " +
                                               "    sup_busca.unidad, " +
                                               "    CAST(f_getprecodescontoespecialmarkup(sup_busca.codigo, '"+parametroCodigoCliente+"', '"+parametroEmpresaSelecionada+"') AS NUMERIC(8,2)) as prvist, " +
                                               "    case when saldo_estoque('F', '"+parametroEmpresaSelecionada+"', sup_busca.codigo, '', current_date) > 0 then " +
                                               "        cast('DISPONÍVEL' as varchar(20)) " +
                                               "    else " +
                                               "        cast('INDISPONIVEL' as varchar(20)) " +
                                               "    end as estoque, " +
                                               "    (SELECT cast(arquivo as text) FROM imagem_produto where imagem_produto.codigo = sup_busca.codigo LIMIT 1) as arquivo " +
                                               "FROM " +
                                               "    super_busca_ite_view as sup_busca " + 
                                               "WHERE " +
                                               "    sup_busca.basico like '%" + (parametroBusca) + "%' and " +
                                               "    ativo     = 1 and " + 
                                               "    cancelado = false and " + 
                                               "    prvist    > 0     " +
                                               "ORDER BY " +
                                               "    estoque, sup_busca.descr1 " + 
                                               "LIMIT " + 
                                               "    50";

                DataView dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
                int eof = dv.Count;
                dv.Dispose();

                if (eof == 0){
                    /*Tenta encontrar pela chave da view...*/
                    SqlDataSource1.SelectCommand = "SELECT  " +
                                                   "    sup_busca.codigo, " +
                                                   "    sup_busca.basico, " +
                                                   "    sup_busca.marca , " +
                                                   "    sup_busca.descr1, " +
                                                   "    sup_busca.unidad, " +
                                                   "    CAST(f_getprecodescontoespecialmarkup(sup_busca.codigo, '" + parametroCodigoCliente + "', '" + parametroEmpresaSelecionada + "') AS NUMERIC(8,2)) as prvist, " +
                                                   "    case when saldo_estoque('F', '" + parametroEmpresaSelecionada + "', sup_busca.codigo, '', current_date) > 0 then " +
                                                   "        cast('DISPONÍVEL' as varchar(20)) " +
                                                   "    else " +
                                                   "        cast('INDISPONIVEL' as varchar(20)) " +
                                                   "    end as estoque, " +
                                                   "    (SELECT cast(arquivo as text) FROM imagem_produto where imagem_produto.codigo = sup_busca.codigo LIMIT 1) as arquivo " +
                                                   "FROM " +
                                                   "    super_busca_ite_view as sup_busca " +
                                                   "WHERE " +
                                                   "    sup_busca.chave like '%" + (parametroBusca) + "%' and " + 
                                                   "    ativo     = 1 and " + 
                                                   "    cancelado = false and " +
                                                   "    prvist    > 0 " +
                                                   "ORDER BY " +
                                                   "    estoque, sup_busca.descr1 " +
                                                   "LIMIT " + 
                                                   "    50";

                    DataView dv2 = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
                    eof = dv2.Count;
                    dv2.Dispose();

                    if (eof == 0)
                    {
                        lblResultado.Text = "Não encontramos nenhuma peça pela busca... (" + txtBusca.Text + ")";
                    }

                }

            }
            else
            {
                SqlDataSource1.SelectCommand = "SELECT  " +
                                               "    sup_busca.codigo, " +
                                               "    sup_busca.basico, " +
                                               "    sup_busca.marca,  " +
                                               "    sup_busca.descr1, " +
                                               "    sup_busca.unidad, " +
                                               "    CAST(f_getprecodescontoespecialmarkup(sup_busca.codigo, '" + parametroCodigoCliente + "', '" + parametroEmpresaSelecionada + "') AS NUMERIC(8,2)) as prvist, " +
                                               "    case when saldo_estoque('F', '" + parametroEmpresaSelecionada + "', sup_busca.codigo, '', current_date) > 0 then " +
                                               "        cast('DISPONÍVEL' as varchar(20)) " +
                                               "    else " +
                                               "        cast('INDISPONIVEL' as varchar(20)) " +
                                               "    end as estoque, " +
                                               "    (SELECT cast(arquivo as text) FROM imagem_produto where imagem_produto.codigo = sup_busca.codigo LIMIT 1) as arquivo " +
                                               "FROM " +
                                               "    super_busca_ite_view as sup_busca " +
                                               "WHERE  " +
                                               "    ativo     = 1 and " + 
                                               "    cancelado = false and " +
                                               "    prvist    > 0 " +
                                               "ORDER BY " +
                                               "    estoque, sup_busca.descr1 " +
                                               "LIMIT " + 
                                               "    50";

            }

            SqlDataSource1.DataBind();
            GridView1.DataBind();           
                
        }
    }

    protected void teste(object sender, EventArgs e)
    {
               
    }

    protected void txtBusca_TextChanged(object sender, EventArgs e)
    {

    }
    /// <summary>
    /// Método responsável por acionar e exibir a aplicação no formato de Popup no cliente.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>

    protected void PopupAplicacao(object sender, ImageClickEventArgs e)
    {
        string titulo = "<b>Esse item pode ser aplicado<b><br><br>";

        ImageButton objImage = (ImageButton)sender;
        string[] commandArgs = objImage.CommandArgument.ToString().Split(new char[] { ',' });
        string codigo    = commandArgs[0];
        string posicao   = commandArgs[1];
        string aplicacao = "";
       

        // busca a aplicação no momento em que necessita exibir e não carregar para todos os produtos no momento de pesquisa
        // do produto
        SqlDataSourceImagemAplicacao.SelectCommand = "select aplica from pccdapl0 where codigo = '" + codigo + "'";
        DataView aplic = (DataView)SqlDataSourceImagemAplicacao.Select(DataSourceSelectArguments.Empty);
        int eof = aplic.Count;

        if (eof == 0)
        {
            aplicacao =  "Produto sem aplicação cadastrada";
        }
        else
        {
            aplicacao = aplicacao + aplic[0][0].ToString();
        }
        
        // substituir espaço e enter.
        aplicacao = aplicacao.Replace("\r\n", "&#13;&#10;");
        aplicacao = aplicacao.Replace("\r", "&#13;&#10;");
        
        // monta a string.
        aplicacao = "<div class=form-group><textarea disabled class=form-control2 rows=20 cols=140 style=font - family:Times New Roman; color:#003399;white-space:pre-wrap> " + aplicacao + "</textarea></div>";

        // faz a chamda do javascript em tela.
        Page.ClientScript.RegisterStartupScript(this.GetType(), "foi", "MessageBoxAplicacao('" +titulo+aplicacao+ "')", true);
        GridView1.SelectedIndex = Convert.ToInt32(posicao);
    }

    /// <summary>
    /// Método responsável por por abrir popup de imagens, exibir imagens relacionadas aos produtos
    /// </summary>
    /// <param name="sender">Não necessita de envio parâmetro</param>
    /// <param name="e">Não necessita de envio parâmetro</param>
    protected void PopupImagem(object sender, ImageClickEventArgs e)
    {

        ImageButton objImage2 = (ImageButton)sender;
        string[] commandArgs = objImage2.CommandArgument.ToString().Split(new char[] { ',' });
        string ccodigoProduto = commandArgs[0];
        // caso nao exista uma imagem relacionada exibirá que produto sem foto.
        String imgName = "productnotfound.png";
        
        // atribuir um diretório para salvar as imagens.
        String dirPath = HttpContext.Current.Request.PhysicalApplicationPath + "img\\";

        SqlDataSourceImagemAplicacao.SelectCommand = "SELECT arquivo as arquivo FROM imagem_produto where codigo = '" + ccodigoProduto + "' limit 1";
        DataView imagem = (DataView)SqlDataSourceImagemAplicacao.Select(DataSourceSelectArguments.Empty);

        int eof = imagem.Count;
        if (eof > 0)
        {
            // captura e atribui para varíavel byte img o dado vindo do banco.
            Byte[] img = (Byte[])imagem[0][0];
            // converte para o arquivo binário do arquivo.
            string s = System.Text.Encoding.UTF8.GetString(img, 0, img.Length);
                        
            // atribuir um arquivo para salvar, no caso o código do arquivo.
            imgName = ccodigoProduto+".jpg";

            // converte a string a string com os dados binário para uma um byte array.
            byte[] imgByteArray = Convert.FromBase64String(s);

            // gera o arquivo com base
            File.WriteAllBytes(dirPath + imgName, imgByteArray);
        }
        

        // efetua o cálculo pra saber o tamanho de resolução de imagem...
        //Image imgFile = Image.FromFile(dirPath + imgName);
        System.Drawing.Image ximg = System.Drawing.Image.FromFile(dirPath + imgName);
        String intArqLargura = ximg.PhysicalDimension.Width.ToString(); // largura original
        String intArqAltura = ximg.PhysicalDimension.Height.ToString(); // altura original
        ximg.Dispose();


        // efetua a chamada sempre para mostrar o produto selecionado ou produto nao existente. 
        // por padrão na pasta imagens irá uma pasta chamada productnotfound();
        Page.ClientScript.RegisterStartupScript(this.GetType(), "", "MessageBoxImagem('" + imgName + "')", true);

    }
    
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onmouseover"] = "this.style.cursor='hand';";
            e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";
            e.Row.Attributes["onclick"] = ClientScript.GetPostBackClientHyperlink(this.GridView1, "Select$" + e.Row.RowIndex);
        }
    }


    /// <summary>
    /// Método pré implementando para exportar imagem de produto.
    /// </summary>
    /// <param name="dt"></param>
    private void download(DataTable dt)
    {
        Byte[] bytes = (Byte[])dt.Rows[0]["arquivo"];
        Response.Buffer = true;
        Response.Charset = "";
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ContentType = "image/jpg";
        Response.AddHeader("content-disposition", "attachment;filename="+ "rodrigo.jpg");
        Response.BinaryWrite(bytes);
        Response.Flush();
        Response.End();
    }

    /// <summary>
    /// Esse método serve para indexar paginas alteradas
    /// </summary>
    /// <param name="sender">DEVE ENVIAR</param>
    /// <param name="e"></param>

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.SelectedIndex = -1;

    }


    
       

}