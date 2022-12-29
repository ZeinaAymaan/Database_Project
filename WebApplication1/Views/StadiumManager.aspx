<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StadiumManager.aspx.cs" Inherits="WebApplication1.Views.WebForm9" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Menu ID="Menu1" runat="server" BackColor="#B5C7DE" DynamicHorizontalOffset="2" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" StaticSubMenuIndent="10px">
                <DynamicHoverStyle BackColor="#284E98" ForeColor="White" />
                <DynamicMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
                <DynamicMenuStyle BackColor="#B5C7DE" />
                <DynamicSelectedStyle BackColor="#507CD1" />
                <Items>
                    <asp:MenuItem NavigateUrl="~/Views/homePage.aspx" Text="Home Page" Value="Home Page"></asp:MenuItem>
                </Items>
                <StaticHoverStyle BackColor="#284E98" ForeColor="White" />
                <StaticMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
                <StaticSelectedStyle BackColor="#507CD1" />
            </asp:Menu>
            <br />
            <h1>Stadium Manager</h1>
            <br />
            <asp:Label ID="Label1" runat="server" Text="Stadium Name:"></asp:Label>
&nbsp;&nbsp;
            <asp:Label ID="stadiumNameLabel" runat="server" Text="Label"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label3" runat="server" Text="Location:"></asp:Label>
&nbsp;&nbsp;
            <asp:Label ID="stadiumLocationLabel" runat="server" Text="Label"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label5" runat="server" Text="Capacity"></asp:Label>
&nbsp;
            <asp:Label ID="stadiumCapacityLabel" runat="server" Text="Label"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label6" runat="server" Text="Status:"></asp:Label>
&nbsp;&nbsp;
            <asp:Label ID="statusLabel" runat="server" Text="Label"></asp:Label>
            <br />
            <br />
            <asp:Label ID="RequestsLabel" runat="server" Text="Label"></asp:Label>
            <br />
            <br />
            <asp:GridView ID="allRequestsGridView" runat="server" AutoGenerateColumns="False" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None">
                <AlternatingRowStyle BackColor="PaleGoldenrod" />
                <FooterStyle BackColor="Tan" />
                <HeaderStyle BackColor="Tan" Font-Bold="True" />
                <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                <SortedAscendingCellStyle BackColor="#FAFAE7" />
                <SortedAscendingHeaderStyle BackColor="#DAC09E" />
                <SortedDescendingCellStyle BackColor="#E1DB9C" />
                <SortedDescendingHeaderStyle BackColor="#C2A47B" />
            </asp:GridView>
            <br />
            <asp:Label ID="chooseRequestLabel" runat="server" Text="Choose Request"></asp:Label>
            <br />
            <br />
            <asp:DropDownList ID="requestDropDownList" runat="server">
                <asp:ListItem>Choose Request</asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
            <asp:Button ID="acceptButton" runat="server" OnClick="acceptButton_Click" Text="Accept" />
&nbsp;&nbsp;
            <asp:Button ID="rejectButton" runat="server" Text="Reject" OnClick="rejectButton_Click" />
        </div>
    </form>
    <p>
        &nbsp;</p>
</body>
</html>
