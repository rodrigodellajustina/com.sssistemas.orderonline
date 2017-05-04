﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="changepass.aspx.cs" Inherits="password" %>

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
    <link href="/css/style_v2.css" rel="stylesheet">   
    <link href="/css/checkboxapple.css" rel="stylesheet"/>
    <link rel="icon" href="~/img/favicon.ico">
</head>
<body>

    <asp:SqlDataSource ID="SqlDataSourceTrocaSenha" 
                           runat="server" 
                           ConnectionString="<%$ ConnectionStrings:dipaConnectionString %>"                            
                           ProviderName="<%$ ConnectionStrings:dipaConnectionString.ProviderName %>"
                           SelectCommand="">

     </asp:SqlDataSource>      


    <form class="formlogin" action="changepass.aspx" role="formlogin" id="form1login" runat="server">        
    <div class="container-fluid">
        <div class="" align="center">
            <img src="/img/logoss5.png" alt="" class="img-responsive">
        </div>
        <div id="" class="row">        
            <div class="col-xs-12 col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3">                
                <div class="box">                                    
                    <div class="box-content">                       

                        <div class="text-center">
                            <small></small><h3 class="page-header"><asp:Label id="lblconfigdescricaocliente" text="" runat="server"></asp:Label> <small>(Alteração de Senha)</small></h3></small>
                        </div>
                        <div id="small">
                            <table align="center" width="100%">
                                <tr align="center">
                                    <td width="95%" align="center">
                                        <div id="small">
                                            <asp:Label id="lblInfo" text="" runat="server" CssClass="bg-info" Width="100%"></asp:Label>
                                        </div> 
                                    </td>                            
                                </tr>
                            </table>                    
                        </div> 
                        <div class="form-group">
                            <label class="control-label">Nova Senha</label>
                            <asp:TextBox TextMode="Password" runat="server" id="txtsenha" class="form-control" name="txtsenha" title="Informe sua senha..." required oninvalid="this.setCustomValidity('Informe sua senha...')"  oninput="setCustomValidity('')"></asp:TextBox> 
                        </div>
                        <div class="form-group">
                            <label class="control-label">Confirmar Nova Senha</label>
                            <asp:textBox TextMode="Password" runat="server" id="txtsenhaconfirma" class="form-control" name="txtsenhaconfirma" title="Confirme sua senha" required oninvalid="this.setCustomValidity('Confirme sua senha')"  oninput="setCustomValidity('')"></asp:textBox> 
                        </div>                                               
                        <div>
                            <h3 class="page-header"></small></h3>
                        </div>
                        <div class="text-center">
                            <asp:Button id="btnalterarsenha" name="btnalterarsenha" runat="server" Text="Alterar" CssClass="btnlogar btn-success" OnClick="alterarSenha"/>                            
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
