<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterStadiumManager.aspx.cs" Inherits="WebApplication1.Views.WebForm5" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="HomePageSMButton" runat="server" Text="Home Page" />
            <br />
            <asp:Label ID="Label1" runat="server" Text="Name"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label2" runat="server" Text="Username"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label3" runat="server" Text="Password"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label4" runat="server" Text="Stadium Name"></asp:Label>
            <br />
            <asp:TextBox ID="NameSMTextBox" runat="server"></asp:TextBox>
&nbsp;
            <asp:TextBox ID="UsernameSMTextBox" runat="server"></asp:TextBox>
&nbsp;&nbsp;
            <asp:TextBox ID="PasswordSMTextBox" runat="server"></asp:TextBox>
&nbsp;
            <asp:TextBox ID="StadiumNameSMTextBox" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="RegisterSMButton" runat="server" OnClick="RegisterSMButton_Click" Text="Register" />
        </div>
    </form>
</body>
</html>
