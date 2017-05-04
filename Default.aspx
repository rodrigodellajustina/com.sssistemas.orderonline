<%@ Page  EnableEventValidation="false"  Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" inherits="_Default " MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server" >
        <link href="plugins/bootstrap/bootstrap.css" rel="stylesheet">
		<link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
		<link href='http://fonts.googleapis.com/css?family=Righteous' rel='stylesheet' type='text/css'>
		<%--<link href="plugins/fancybox/jquery.fancybox.css" rel="stylesheet">--%>
		<link href="css/style_v2.css" rel="stylesheet">
		<link href="plugins/chartist/chartist.min.css" rel="stylesheet">
        <link href='support/style.css' rel='stylesheet' />
        <link href='css/nprogress.css' rel='stylesheet' />
        <script src="https://code.jquery.com/jquery-1.11.2.min.js"></script>
        <script src='js/nprogress.js'></script>
        <link rel="icon" href="~/img/favicon.ico">
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
        
        <script src="js/bootbox.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script>
            function MessageBoxAplicacao(message) {                
                bootbox.alert(message, function () {
                    
                });
            }         
            
           function MessageBoxImagem(produto, tamanho) {
                bootbox.alert({
                    title: "Imagem do Produto",
                    size : "medium",
                    message: '<img src="img/'+produto+'" width="800px" align="center"/><br/>'
                });
           }

        </script>
       
    

    <title>Busca de Produtos Online</title>      
    <style type="text/css">
        #TextArea1 {
            height: 71px;
            width: 344px;
        }
    </style>

</head>
<body id="bodydefault" runat="server">

    <div class="modal fade" id="imagemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" data-dismiss="modal">
      <div class="modal-content"  >              
        <div class="modal-body">
          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
             <img src="" class="imagepreview" style="width: 100%;" >
        </div> 
     <div class="modal-footer">
       <div class="col-xs-12">
           <p class="text-left">1. line of description<br>2. line of description <br>3. line of description</p>
       </div>
     </div>         
   </div>
 </div>
</div>
    
    <!-- Navigation -->
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header" >
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>              
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">                    
                    <li>                       
                        <a href="logout.aspx" class="fa fa-power-off"> Sair</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

    <!-- Page Content -->
    <div class="container">
        <div class="row">
            <div class="col-lg-offset-12">              
                <h1>.</h1>
                <p></p>
            </div>
        </div>
    </div>    
    <table>
        <tr>
            <td>..</td>
        </tr>
    </table>
    <!-- /.container -->

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script> 

    <form class="form" role="form" id="form1" runat="server">            

                 
            <table align="center" width="80%">
                <tr align="center">
                    <td width="95%" align="left"><div id="search">
                                        <asp:TextBox id="txtBusca" runat="server" OnTextChanged="txtBusca_TextChanged" placeholder="Informe nome, código ou parte da descrição da peça desejada !!!" ></asp:TextBox>                                        
                                    </div> </td>
                    <td width="5%" align="left" valign="middle">                        
                        <asp:Button id="btnBuscar" runat="server" Text="Buscar" OnClick="GridView1_Load" CssClass="btn btn-success"/></td>
                </tr>
            </table>
    <table>
        <tr>
            <td>..</td>
        </tr>
    </table>
           
        <asp:SqlDataSource ID="SqlDataSource1" 
                           runat="server" 
                           ConnectionString="<%$ ConnectionStrings:dipaConnectionString %>"                            
                           ProviderName="<%$ ConnectionStrings:dipaConnectionString.ProviderName %>"
                           SelectCommand=""
                           EnableCaching = "true" CacheDuration ="1800">
        </asp:SqlDataSource>    
               
        <asp:SqlDataSource ID="SqlDataSourceImagemAplicacao" 
                           runat="server" 
                           ConnectionString="<%$ ConnectionStrings:dipaConnectionString %>"                            
                           ProviderName="<%$ ConnectionStrings:dipaConnectionString.ProviderName %>"
                           SelectCommand=""
                           >        
        </asp:SqlDataSource>    
    
        <asp:GridView   ID="GridView1"                        
                        runat="server"                         
                        AllowSorting="True" 
                        DataSourceID="SqlDataSource1" 
                        BackColor="Window" 
                        BorderColor="Window" 
                        AlternatingRowStyle-BackColor="#99ff99" 
                        BorderStyle="None" 
                        GridLines="None"
                        AllowPaging="True"
                        PageSize="35" 
                        OnSorted="GridView1_Load"
                        AutoGenerateSelectButton="False"
                        SelectedRowStyle-BackColor="#ff3300"
                        AutoGenerateColumns="False"    
                        onrowdatabound ="GridView1_RowDataBound"
                        CellPadding="0" 
                        Font-Overline="False" 
                        Font-Size="Small" 
                        RowHeaderColumn="codigo" 
                        Width="80%"
                        CssClass="table-responsive"
                        ShowFooter="true"     
                        onpageindexchanging="GridView1_PageIndexChanging"                       
                        
                        
            HeaderStyle-CssClass="table-responsive ct-grid " HeaderStyle-HorizontalAlign="NotSet" HeaderStyle-VerticalAlign="NotSet" AlternatingRowStyle-VerticalAlign="NotSet" AlternatingRowStyle-HorizontalAlign="NotSet" HorizontalAlign="Center" ShowHeaderWhenEmpty="true">
            <AlternatingRowStyle BackColor="#99ff99" />
            <Columns>              
                <asp:BoundField DataField="codigo" HeaderText="Código" SortExpression="codigo" Visible="false" />
                <asp:BoundField DataField="basico" HeaderText="Código Fabricante" SortExpression="basico" />
                <asp:BoundField DataField="marca" HeaderText="Marca" SortExpression="marca" />
                <asp:BoundField DataField="descr1" HeaderText="Descrição" SortExpression="descr1"/>
                <asp:TemplateField HeaderText="Detalhes" FooterStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:ImageButton id="btnPopup" runat="server" CommandName="enviaparametro"  CommandArgument='<%#Eval("codigo") + "," + Container.DataItemIndex %>'  OnClick="PopupAplicacao" ImageUrl="~/img/top4.png" />
                    </ItemTemplate>
                </asp:TemplateField>                
                <asp:TemplateField HeaderText="Fotos" FooterStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:ImageButton id="btnFoto" runat="server" CommandName="enviaparametro"  CommandArgument='<%#Eval("codigo")+"," %>' OnClick="PopupImagem"  ImageUrl="~/img/foto1.png"  />
                    </ItemTemplate>
                </asp:TemplateField>                
                <asp:BoundField DataField="unidad" HeaderText="Unidade" SortExpression="unidad" FooterStyle-HorizontalAlign="Right"/>
                <asp:BoundField DataField="prvist" HeaderText="Preço" SortExpression="prvist" HeaderStyle-HorizontalAlign="Right"/>
                <asp:BoundField DataField="estoque" HeaderText="Estoque" SortExpression="estoque" />
                <asp:ButtonField Text="Enviar Pedido" CommandName="eviarparapedido" />
            </Columns>
            
            <HeaderStyle BackColor="#009933" ForeColor="White" />
            <PagerSettings Mode="NumericFirstLast" />
            <PagerStyle HorizontalAlign="Center" VerticalAlign="Bottom" />
            <SelectedRowStyle BackColor="#009900" Wrap="True" />
         
        </asp:GridView>       
                
        <script>
            $('body').show();
            $('.version').text(NProgress.version);
            NProgress.start();
            setTimeout(function() { NProgress.done(); $('.fade').removeClass('out'); }, 10);
        </script>

        <table align="center" width="100%">
                <tr align="center">
                    <td width="95%" align="center">
                        <div id="small">
                            <asp:Label id="lblResultado" text="" runat="server" CssClass="small"></asp:Label>                                        
                        </div> 

                    </td>
                </tr>
        </table>        
                      
        <script>var HN=[];HN.factory=function(e){return function(){HN.push([e].concat(Array.prototype.slice.call(arguments,0)))};},HN.on=HN.factory("on"),HN.once=HN.factory("once"),HN.off=HN.factory("off"),HN.emit=HN.factory("emit"),HN.load=function(){var e="hn-button.js";if(document.getElementById(e))return;var t=document.createElement("script");t.id=e,t.src="//hn-button.herokuapp.com/hn-button.js";var n=document.getElementsByTagName("script")[0];n.parentNode.insertBefore(t,n)},HN.load();</script>
        
</form>
 
</body>
</html>
