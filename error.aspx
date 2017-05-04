<%@ Page Language="C#" AutoEventWireup="true" CodeFile="error.aspx.cs" Inherits="error" %>

<!DOCTYPE html>
<html lang="en" >
	
    <head runat="server">
		<meta charset="utf-8">
		<title>SS Search Parts Anywhere</title>
		<meta name="description" content="description">
		<meta name="author" content="Evgeniya">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="../plugins/bootstrap/bootstrap.css" rel="stylesheet">
		<link href="http://netdna.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.css" rel="stylesheet">
		<link href="/css/style_v2.css" rel="stylesheet">
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
				<script src="http://getbootstrap.com/docs-assets/js/html5shiv.js"></script>
				<script src="http://getbootstrap.com/docs-assets/js/respond.min.js"></script>
		<![endif]-->
	</head>

    <body id="bodyerror" runat="server">
        <div>
	        <div>
		        <div id="page-500" class="col-xs-12 text-center">
			        <h1 class="box-branco">Ops!!!</h1>
			        <h3 class="box-branco">Ocorreu um erro interno em nossos servidores, tente novamente...</h3>
			        <img src="../img/logoss5.png" alt="" />
			        <a href="../login.aspx" class="btnlogar btn-success"><span><i class="fa fa-reply"></i></span> Tentar novamente </a>
		        </div>
	        </div>
        </div>
    </body>

</html>