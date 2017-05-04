<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <meta charset="utf-8">
    <title>SS Search Parts Anywhere</title>
    <meta name="description" content="description">
    <meta name="author" content="Evgeniya">
    <meta name="keyword" content="keywords">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="/plugins/bootstrap/bootstrap.css" rel="stylesheet">
    <link href="http://netdna.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Righteous' rel='stylesheet' type='text/css'>    
    <link href="/css/checkboxapple.css" rel="stylesheet"/>
    <link href="/css/style_v2.css" rel="stylesheet">   
    <link rel="icon" href="~/img/favicon.ico">    
</head>
<body id="bodylogin" runat="server">

    <asp:SqlDataSource ID="SqlDataSourceLogin" 
                           runat="server" 
                           ConnectionString="<%$ ConnectionStrings:dipaConnectionString %>"                            
                           ProviderName="<%$ ConnectionStrings:dipaConnectionString.ProviderName %>"
                           SelectCommand="">
     </asp:SqlDataSource> 
         
    <form class="formlogin" action="login.aspx" role="form1login" id="form1login" runat="server">        
    <div class="container-fluid">
        <div class="" align="center">
            <img src="/img/logoss5.png" alt="" class="img-responsive">
        </div>
        <div class="row">        
            <div class="col-xs-12 col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3">                
                <div class="box">                                    
                    <div class="box-content">
                        <div class="text-center">
                            <h3 class="page-header"><asp:Label id="lblconfigdescricaocliente" text="" runat="server"></asp:Label> <small>(Beta 1)</small></h3>
                        </div>
                        <div class="form-group">
                            <label class="control-label">Login</label>
                            <asp:TextBox runat="server" id="txtUsuario" class="form-control" name="txtUsuario" title="Informe o CNPJ da sua empresa para efetuar o login" required oninvalid="this.setCustomValidity('Informe o CNPJ da sua empresa para efetuar o login')"  oninput="setCustomValidity('')"></asp:TextBox> 
                        </div>
                        <div class="form-group">
                            <label class="control-label">Senha</label>
                            <asp:textBox TextMode="Password" runat="server" id="txtSenha" class="form-control" name="txtSenha" title="Informe sua senha" required oninvalid="this.setCustomValidity('Informe sua senha')"  oninput="setCustomValidity('')"></asp:textBox> 
                        </div>
                        <small>Lembrar da minha credencial</small>
                        <div class="toggle-switch">
							<div class="toggle-switch toggle-switch-success">
							<label>
								<input type="checkbox" runat="server" name="onoffswitch" id="myonoffswitch">
								<div class="toggle-switch-inner"></div>
								<div class="toggle-switch-switch"><i class="fa fa-check"></i></div>
							</label>
						</div>
                        </div>
                        <div>
                            <h3 class="page-header"></small></h3>
                        </div>
                        <div class="text-center">
                            <asp:Button id="btLogar" name="btnLogar" runat="server" Text="Acessar" CssClass="btnlogar btn-success" OnClick="btLogar_Click"/>                            
                        </div>                      
                        <div id="small">
                            <label id="lblinformacao"></label>
                        </div>
                        <div id="small">
                            <table align="center" width="100%">
                                <tr align="center">
                                    <td width="95%" align="center">
                                        <div id="small">
                                            <asp:Label id="lblResultado" text="" runat="server" CssClass="bg-danger" Width="100%"></asp:Label>
                                        </div> 
                                    </td>                            
                                </tr>
                            </table>                    
                        </div> 
                    </div>
                </div>
            </div>
         </div>       
    </div>
    </form>
    <div id="small" class="text-center" align="center">
        <label id="Label1" runat="server" class="col-lg-12"></label>
        <label id="Label2" runat="server" class="col-lg-12"></label>
        <label id="Label3" runat="server" class="col-lg-12"></label>
        <a id="copyright" href="http://www.sssistemas.com" runat="server" target="_blank">...</a>
    </div>
</body>
</html>
