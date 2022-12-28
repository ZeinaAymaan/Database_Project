<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewStadiumInfoSM.aspx.cs" Inherits="WebApplication1.Views.WebForm15" %>

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
                    <asp:MenuItem NavigateUrl="~/Views/homePage.aspx" Text="Home Page" Value="Back"></asp:MenuItem>
                </Items>
                <StaticHoverStyle BackColor="#284E98" ForeColor="White" />
                <StaticMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
                <StaticSelectedStyle BackColor="#507CD1" />
            </asp:Menu>
            <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="stadiumName" HeaderText="stadiumName" SortExpression="stadiumName" />
                    <asp:BoundField DataField="stadiumLocation" HeaderText="stadiumLocation" SortExpression="stadiumLocation" />
                    <asp:BoundField DataField="Capacity" HeaderText="Capacity" SortExpression="Capacity" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ehnaawiConnectionString %>" SelectCommand="SELECT Stadium.stadiumName, Stadium.stadiumLocation, Stadium.Capacity FROM Stadium INNER JOIN stadiumManager ON Stadium.ID = stadiumManager.Stadium_ID"></asp:SqlDataSource>
            <br />
            <br />
            <asp:GridView ID="GridView2" runat="server" DataSourceID="SqlDataSource2">
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ehnaawiConnectionString %>" SelectCommand="SELECT allPendingRequests_1.RepresentativeName, Club.clubName, allPendingRequests_1.GuestClubName, allPendingRequests_1.startTime, Match.endTime, hostRequest.Status FROM Match INNER JOIN hostRequest ON Match.ID = hostRequest.Match_ID INNER JOIN clubRepresentative INNER JOIN Club ON clubRepresentative.club_ID = Club.ID ON Match.Host_ID = Club.ID INNER JOIN dbo.allPendingRequests() AS allPendingRequests_1 ON clubRepresentative.Name = allPendingRequests_1.RepresentativeName"></asp:SqlDataSource>
            <br />
            <asp:DropDownList ID="DropDownList1" runat="server">
            </asp:DropDownList>
&nbsp;
            <br />
            <br />
            <br />
            <asp:Button ID="AcceptButton" runat="server" Text="Accept" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="RejectButton" runat="server" Text="Reject" />
            <br />
        </div>
    </form>
</body>
</html>
