<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SystemAdminPage.aspx.cs" Inherits="Champions_League.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="clubNameLabel" runat="server" Text="Club name"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="clubLocationLabel" runat="server" Text="Club Location"></asp:Label>
        </div>
        <asp:TextBox ID="clubnametextBox" runat="server" OnTextChanged="clubnametextBox_TextChanged"></asp:TextBox>
&nbsp;&nbsp;
        <asp:TextBox ID="clubLocationTextBox" runat="server"></asp:TextBox>
        <br />
        <asp:Button ID="addClubButton" runat="server" Text="Add" />
        <asp:Button ID="deleteClubButton" runat="server" Text="Delete" />
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        <asp:Label ID="stadiumNameLabel" runat="server" Text="Stadium Name"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="stadiumLocationLabel" runat="server" Text="Stadium Location"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="stadiumCapacityLabel" runat="server" Text="Stadium Capacity"></asp:Label>
        <br />
        <asp:TextBox ID="stadiumNameTextBox" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="stadiumLocationTextBox" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="stadiumCapacityTextBox" runat="server" OnTextChanged="TextBox3_TextChanged"></asp:TextBox>
        <br />
        <asp:Button ID="addStadiumButton" runat="server" Text="Add" />
        <asp:Button ID="deleteStadiumButton" runat="server" Text="Delete" />
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        <asp:Label ID="fanNationalIDLabel" runat="server" Text="Fan Nationa ID"></asp:Label>
        <br />
        <asp:TextBox ID="fanNationalIDTextBox" runat="server"></asp:TextBox>
        <br />
        <asp:Button ID="blockFanButton" runat="server" Text="Block" />
        <asp:Button ID="unblockFanButton" runat="server" Text="Unblock" />
    </form>
</body>
</html>
