<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="Champions_League.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <p>
            <asp:Label ID="usernameLabel" runat="server" Text="Username"></asp:Label>
        </p>
        <asp:TextBox ID="usernameTextBox" runat="server"></asp:TextBox>
        <p>
            <asp:Label ID="passwordLabel" runat="server" Text="Password"></asp:Label>
        </p>
        <asp:TextBox ID="passwordTextBox" runat="server" AutoPostBack="True"></asp:TextBox>
        <p>
            <asp:Button ID="loginButton" runat="server" OnClick="loginButton_Click" Text="Login" />
            <asp:Button ID="RegisterButton" runat="server" Text="Register" OnClick="RegisterButton_Click" />
        </p>
    </form>
</body>
</html>
