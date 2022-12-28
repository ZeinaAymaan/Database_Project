<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Fan.aspx.cs" Inherits="WebApplication1.Views.WebForm10" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>Fan</h1>
            <p>&nbsp;</p>
            <h3>Avilable Matches on</h3>
            <p>
                <asp:Calendar ID="FanCalendar" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px">
                    <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                    <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                    <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                    <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                    <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                    <WeekendDayStyle BackColor="#CCCCFF" />
                </asp:Calendar>
            </p>
            <p>Start Time:
                <asp:DropDownList ID="SHoursDropDownList" runat="server">
                    <asp:ListItem Text ="Hours"></asp:ListItem>
                </asp:DropDownList>
&nbsp;
                <asp:DropDownList ID="SMinutesDropDownList" runat="server">
                    <asp:ListItem Text ="Minutes"></asp:ListItem>
                </asp:DropDownList>
            </p>
            <p>&nbsp;</p>
            <p>
                <asp:Button ID="ShowMatchesButton" runat="server" OnClick="ShowMatchesButton_Click" Text="Show" />
            </p>
            <p>
                &nbsp;</p>
        </div>
    </form>
</body>
</html>
