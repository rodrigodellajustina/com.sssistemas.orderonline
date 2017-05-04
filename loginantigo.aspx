<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" inherits="_Default " %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server" >
        <link href="plugins/bootstrap/bootstrap.css" rel="stylesheet">
		<link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
		<link href='http://fonts.googleapis.com/css?family=Righteous' rel='stylesheet' type='text/css'>
		<link href="plugins/fancybox/jquery.fancybox.css" rel="stylesheet">
		<link href="css/style_v2.css" rel="stylesheet">
		<link href="plugins/chartist/chartist.min.css" rel="stylesheet">
        <link href='support/style.css' rel='stylesheet' />
        <link href='css/nprogress.css' rel='stylesheet' />
        <script src="https://code.jquery.com/jquery-1.11.2.min.js"></script>
        <script src='js/nprogress.js'></script>
        <link rel="icon" href="img/ss.ico">
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
        


        <script src="bootbox.min.js"></script>
        <script>
            $(document).on("click", ".alert", function(e) {
                bootbox.alert("Hello world!", function() {
                    console.log("Alert Callback");
                });
            });
        </script>
       
    <script>if(location.hostname.match(/ricostacruz\.com$/)){var _gaq=_gaq||[];_gaq.push(["_setAccount","UA-20473929-1"]),_gaq.push(["_trackPageview"]),function(){var a=document.createElement("script");a.type="text/javascript",a.async=!0,a.src=("https:"==document.location.protocol?"https://ssl":"http://www")+".google-analytics.com/ga.js";var b=document.getElementsByTagName("script")[0];b.parentNode.insertBefore(a,b)}()}</script>

    <title>Busca de Produtos Online</title>      
    <style type="text/css">
        #TextArea1 {
            height: 71px;
            width: 344px;
        }
    </style>
    
</head>
<body style="display: none">    

    <form class="form" role="form" id="form1" runat="server">              
            <table align="center" width="80%">
                <tr align="center">
                    <td width="95%" align="left"><div id="search">
                                        <asp:TextBox id="txtBusca" runat="server" OnTextChanged="txtBusca_TextChanged" placeholder="Informe nome, código ou parte da descrição da peça desejada !!!" ></asp:TextBox>                                        
                                    </div> </td>
                    <td width="5%" align="left" valign="middle">                        
                        <asp:Button id="btnBuscar" runat="server" Text="Buscar" OnClick="GridView1_Load" CssClass="btn btn-success"/></td>
                </tr>

           
        <asp:SqlDataSource ID="SqlDataSource1" 
                           runat="server" 
                           ConnectionString="<%$ ConnectionStrings:dipaConnectionString %>"                            
                           ProviderName="<%$ ConnectionStrings:dipaConnectionString.ProviderName %>"
                           SelectCommand="select 'False' as selecao, codigo, basico, marca, descr1, unidad, prvist from super_busca_ite_view where 1=1 order by descr1 limit 50">
        
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
                        OnSelectedIndexChanged="teste"                  
                        OnSelectedIndexChanging="teste"
                        AutoGenerateSelectButton="False"
                        AutoGenerateColumns="False"                        
                        CellPadding="0" 
                        Font-Overline="False" 
                        Font-Size="Small" 
                        RowHeaderColumn="codigo" 
                        Width="80%"
                        CssClass="table-responsive table fa-font"
                        ShowFooter="true"
                       
                        
            HeaderStyle-CssClass="table-responsive ct-grid" HeaderStyle-HorizontalAlign="NotSet" HeaderStyle-VerticalAlign="NotSet" AlternatingRowStyle-VerticalAlign="NotSet" AlternatingRowStyle-HorizontalAlign="NotSet" HorizontalAlign="Center">
            <AlternatingRowStyle BackColor="#99FF99" />
            <Columns>
                <asp:BoundField DataField="codigo" HeaderText="Código" SortExpression="codigo"/>
                <asp:BoundField DataField="basico" HeaderText="Fabricante" SortExpression="basico" />
                <asp:BoundField DataField="marca" HeaderText="Marca" SortExpression="marca" />
                <asp:BoundField DataField="descr1" HeaderText="Descrição" SortExpression="descr1"/>
                <asp:TemplateField HeaderText="Aplicação" FooterStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:ImageButton id="btnPopup" runat="server" ImageUrl="~/img/top3.png"/>
                    </ItemTemplate>
                </asp:TemplateField>                
                <asp:BoundField DataField="unidad" HeaderText="Unidade" SortExpression="unidad" FooterStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="prvist" HeaderText="Preço" SortExpression="prvist" />
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
