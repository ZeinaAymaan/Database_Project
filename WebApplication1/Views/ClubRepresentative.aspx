<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClubRepresentative.aspx.cs" Inherits="WebApplication1.Views.WebForm8" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Menu ID="Menu1" runat="server" BackColor="#B5C7DE" DynamicHorizontalOffset="2" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" StaticSubMenuIndent="10px">
            <DynamicHoverStyle BackColor="#284E98" ForeColor="White" />
            <DynamicMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
            <DynamicMenuStyle BackColor="#B5C7DE" />
            <DynamicSelectedStyle BackColor="#507CD1" />
            <Items>
                <asp:MenuItem NavigateUrl="~/Views/homePage.aspx" Text="Home Page" Value="New Item"></asp:MenuItem>
            </Items>
            <StaticHoverStyle BackColor="#284E98" ForeColor="White" />
            <StaticMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
            <StaticSelectedStyle BackColor="#507CD1" />
        </asp:Menu>
        <br />
        Club ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label1" runat="server"></asp:Label>
        <br />
        Club Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label2" runat="server" ></asp:Label>
        <br />
        Club Location&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label3" runat="server" ></asp:Label>
        <asp:Panel ID="Panel1" runat="server" style="margin-bottom: 85px">
            <asp:MultiView ID="MultiView1" runat="server" >
                <asp:View ID="View1" runat="server">
                    <br />
                    <asp:Label ID="Label4" runat="server"></asp:Label>
                    <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px">
                        <FooterStyle BackColor="White" ForeColor="#000066" />
                        <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                        <RowStyle ForeColor="#000066" />
                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#007DBB" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#00547E" />
                    </asp:GridView>
                    <br />
                    <br />
                    <br />
                </asp:View>
            </asp:MultiView>
               <asp:MultiView ID="MultiView2" runat="server">
                   <asp:View ID="View2" runat="server">
                       <br />
                       <asp:Label ID="Label5" runat="server" Text="View Available Stadiums On:"></asp:Label>
                       <br />
                       <br />
                       <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px">
                           <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                           <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                           <OtherMonthDayStyle ForeColor="#999999" />
                           <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                           <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                           <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                           <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                           <WeekendDayStyle BackColor="#CCCCFF" />
                       </asp:Calendar>
                       <br />
                       Start Time:&nbsp;
                       <asp:DropDownList ID="DropDownList1" runat="server">
                           <asp:ListItem Selected="True">Hour</asp:ListItem>
                       </asp:DropDownList>
                       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                       <asp:DropDownList ID="DropDownList2" runat="server">
                           <asp:ListItem Selected="True">Minutes</asp:ListItem>
                       </asp:DropDownList>
                       <br />
                       <br />
                       <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="View" />
                   </asp:View>
                   <asp:View ID="View3" runat="server">
                       <asp:Label ID="Label6" runat="server" ></asp:Label>
                       <asp:GridView ID="GridView2" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical">
                           <AlternatingRowStyle BackColor="#DCDCDC" />
                           <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                           <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                           <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                           <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                           <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                           <SortedAscendingCellStyle BackColor="#F1F1F1" />
                           <SortedAscendingHeaderStyle BackColor="#0000A9" />
                           <SortedDescendingCellStyle BackColor="#CAC9C9" />
                           <SortedDescendingHeaderStyle BackColor="#000065" />
                       </asp:GridView>
                   </asp:View>
        </asp:MultiView>
        </asp:Panel>
       </form>
</body>
</html>
