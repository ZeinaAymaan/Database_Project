<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="homePage.aspx.cs" Inherits="WebApplication1.Views.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="~/lib/bootstrap/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="~/css/site.css" asp-append-version="true" />
    <link rel="stylesheet" href="~/db_proje.styles.css" asp-append-version="true" />
</head>
<body style="height: 350px">
    <header>
        <nav class="navbar navbar-expand-sm navbar-toggleable-sm navbar-light bg-white border-bottom box-shadow mb-3">
            <div class="container-fluid">
                <a class="navbar-brand" asp-area="" asp-controller="Home" asp-action="">Home Page</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target=".navbar-collapse" aria-controls="navbarSupportedContent"
                        aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="navbar-collapse collapse d-sm-inline-flex justify-content-between">
                    <ul class="navbar-nav flex-grow-1">
                        <div class="nav-item">
                            <button class="nav-link text-dark" href="/homePage/RegisterAsSportsAssoc">Sports Associaton Manager Registeration</button>
                        </div>
                        <div class="nav-item">
                            <button class="nav-link text-dark" href="/homePage/RegisterAsClubRep">Club Representative Registeration</button>
                        </div>
                        <div class="navbar-item">
                            <button class="nav-link text-dark" href="/homePage/RegisterAsStadMan">Stadium Manager Registeration</button>
                        </div>
                        <div class="navbar-item">
                            <button class="nav-link text-dark" href="/homePage/RegisterAsFan">Fan Registeration</button>
                        </div>
                    </ul>
                </div>
            </div>
        </nav>
    </header>
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
