<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SystemAdmin.aspx.cs" Inherits="WebApplication1.Views.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="ClubNameLabel" runat="server" Text="Club Name"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="ClubLocationLabel" runat="server" Text="Club Location"></asp:Label>
        </div>
        <asp:TextBox ID="ClubNameTextBox" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="ClubLocationTextBox" runat="server"></asp:TextBox>
        <p>
            <asp:Button ID="AddClubButton" runat="server" OnClick="AddClubButton_Click" Text="ADD" />
&nbsp;
            <asp:Button ID="DeleteClubButton" runat="server" OnClick="DeleteClubButton_Click" Text="DELETE" />
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Label ID="StadiumNameLabel" runat="server" Text="Stadium Name"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="StadiumLocationLabel" runat="server" Text="Stadium Location"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="StadiumCapacityLabel" runat="server" Text="Stadium Capacity"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="StadiumNameTextBox" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="StadiumLocationTextBox" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="StadiumCapacityTextBox" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="AddStadiumButton" runat="server" OnClick="AddStadiumButton_Click" Text="ADD" />
&nbsp;
            <asp:Button ID="DeleteStadiumButton" runat="server" Text="DELETE" />
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Label ID="FanNationalIDLabel" runat="server" Text="Fan National ID"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="FanNationalIDTextBox" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="BlockFanButton" runat="server" Text="BLOCK" />
&nbsp;
            <asp:Button ID="UnblockFanButton" runat="server" Text="UNBLOCK" />
        </p>
    </form>
</body>
</html>
