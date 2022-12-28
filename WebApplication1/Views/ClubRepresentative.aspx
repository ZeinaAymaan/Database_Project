<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClubRepresentative.aspx.cs" Inherits="WebApplication1.Views.WebForm8" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        Club ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label1" runat="server"></asp:Label>
        <br />
        Club Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label2" runat="server" ></asp:Label>
        <br />
        Club Location&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label3" runat="server" ></asp:Label>
        <asp:MultiView ID="MultiView1" runat="server" >
            <asp:View ID="View1" runat="server">
                <br />
                <br />
                <asp:Label ID="Label4" runat="server"></asp:Label>
                <asp:GridView ID="GridView1" runat="server">
                </asp:GridView>
            </asp:View>
        </asp:MultiView>
    </form>
</body>
</html>
