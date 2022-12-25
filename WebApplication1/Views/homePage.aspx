<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="homePage.aspx.cs" Inherits="WebApplication1.Views.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="height: 350px">
    <form id="form1" runat="server">
        <div> class="text-center">
            <h1 class="display-4">Welcome To The Golden Square</h1>
            <asp:Label ID="UsernameLabel" runat="server" Text="Username"></asp:Label>
            <br />
            <asp:TextBox ID="UsernameTextBox" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="PasswordLabel" runat="server" Text="Password"></asp:Label>
            <br />
            <asp:TextBox ID="PasswordTextBox" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="LoginButton" runat="server" OnClick="LoginButton_Click" Text="Login" />
            <br />
            <br />
            <br />
            <br />
            <br />
            <asp:Button ID="RegisterSportsAssociationManagerButton" runat="server" Text="Register Sports Association Manager" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="RegisterClubRepresentativeButton" runat="server" style="text-align: right" Text="Register Club Representative" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            <br />
            <asp:Button ID="RegisterStadiumManagerButton" runat="server" Height="27px" Text="Register Stadium Manager" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="RegisterFanButton" runat="server" Text="Register Fan" />
        </div>
    </form>
</body>
</html>
