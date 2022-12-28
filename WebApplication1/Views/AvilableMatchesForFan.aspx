<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AvilableMatchesForFan.aspx.cs" Inherits="WebApplication1.Views.WebForm14" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1></h1>
            <asp:Menu ID="Menu1" runat="server" BackColor="#B5C7DE" DynamicHorizontalOffset="2" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" StaticSubMenuIndent="10px">
                <DynamicHoverStyle BackColor="#284E98" ForeColor="White" />
                <DynamicMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
                <DynamicMenuStyle BackColor="#B5C7DE" />
                <DynamicSelectedStyle BackColor="#507CD1" />
                <Items>
                    <asp:MenuItem NavigateUrl="~/Views/Fan.aspx" Text="Back" Value="Back"></asp:MenuItem>
                </Items>
                <StaticHoverStyle BackColor="#284E98" ForeColor="White" />
                <StaticMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
                <StaticSelectedStyle BackColor="#507CD1" />
            </asp:Menu>
            <h1>Available Matches From
                <asp:Label ID="matchStartTimeLabel" runat="server" Text="Label"></asp:Label>
            </h1>
            <br />
            <h3>Select your match</h3>
            <asp:DropDownList ID="selectedMatchDropDownList" runat="server">
                <asp:ListItem Text ="Match"></asp:ListItem>
            </asp:DropDownList>
            <br />
            <h3>Select your tickets</h3>
            <asp:DropDownList ID="TicketsDropDownList" runat="server">
                <asp:ListItem Text ="No of tickets"></asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
            <asp:Button ID="BuyButton" runat="server" OnClick="BuyButton_Click" Text="Buy" />
            <br />
        </div>
    </form>
</body>
</html>
