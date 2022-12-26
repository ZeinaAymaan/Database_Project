<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SAMregisteration.aspx.cs" Inherits="WebApplication1.Views.WebForm3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="homePageSAMButton" runat="server" Text="Home Page" />
            <br />
            <br />
            <asp:Label ID="SAMnameLabel" runat="server" Text="Name"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="SAMusernameLabel" runat="server" Text="Username"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="SAMpasswordLabel" runat="server" Text="Password"></asp:Label>
            <br />
            <asp:TextBox ID="SAMnameTextBox" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="SAMusernameTextBox2" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="SAMpasswordTextBox3" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="registerSAMButton" runat="server" OnClick="registerSAMButton_Click" Text="Register" />
        </div>
    </form>
</body>
</html>
