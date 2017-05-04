<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Default2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <asp:Table ID="Table1" runat="server" Width="100%"> 
    <asp:TableRow runat="server">
        <asp:TableCell runat="server" HorizontalAlign="Center">
            <asp:GridView ID="gv" runat="server" Width="50%"></asp:GridView>
        </asp:TableCell>
    </asp:TableRow>
</asp:Table>
</body>
</html>
