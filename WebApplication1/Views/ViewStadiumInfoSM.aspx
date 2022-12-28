<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewStadiumInfoSM.aspx.cs" Inherits="WebApplication1.Views.WebForm15" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="stadiumName" HeaderText="stadiumName" SortExpression="stadiumName" />
                    <asp:BoundField DataField="stadiumLocation" HeaderText="stadiumLocation" SortExpression="stadiumLocation" />
                    <asp:BoundField DataField="Capacity" HeaderText="Capacity" SortExpression="Capacity" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ehnaawiConnectionString %>" SelectCommand="SELECT Stadium.stadiumName, Stadium.stadiumLocation, Stadium.Capacity FROM Stadium INNER JOIN stadiumManager ON Stadium.ID = stadiumManager.Stadium_ID"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
