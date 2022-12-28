using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace WebApplication1.Views
{
    public partial class WebForm14 : System.Web.UI.Page
    {

        //WebForm10 fan2 = new WebForm10();
        //public WebForm10.matchTime time { get; set; }

        //public WebForm14(WebForm10.matchTime time)
        //{
        //    this.time = time;

        //}

        protected void Page_Load(object sender, EventArgs e)
        {
            db.openConnection();

            matchStartTimeLabel.Text = WebForm10.st;

            //sql query to get the number of available tickets

            SqlDataSource1.SelectCommand = "SELECT availableMatchesToAttend_1.ID, availableMatchesToAttend_1.Host, availableMatchesToAttend_1.Guest, availableMatchesToAttend_1.stadiumName, Stadium.stadiumLocation \r\nFROM Stadium INNER JOIN dbo.availableMatchesToAttend(" + WebForm10.stDate +") AS availableMatchesToAttend_1 ON Stadium.stadiumName = availableMatchesToAttend_1.stadiumName";
            string counter = "";

            string counterQuery = "select count(ID) as ID\r\nfrom availableMatchesToAttend('"+ WebForm10.stDate +"')";
            SqlCommand counterCMD = new SqlCommand(counterQuery, db.con);
            SqlDataReader counterReader = counterCMD.ExecuteReader();
            while (counterReader.Read())
            {
                counter = counterReader["ID"].ToString();
            }
            counterReader.Close();

            for(int i = 0; i < Convert.ToInt32(counter); i++)
            {
                ListItem matchID = new ListItem("" + i);
                selectedMatchDropDownList.Items.Add(matchID);
            }

            string counterTickets = "";
            string matchSelected = selectedMatchDropDownList.Text;

            string counterTicketsQuery = "select count(Ticket.ID) as ID\r\nfrom Ticket t inner join availableMatchesToAttend('"+ WebForm10.stDate +"') ama on ama.matchID = t.Match_ID\r\nwhere t.ticketStatus = '1' and ama.ID = "+ Convert.ToInt32(matchSelected);
            SqlCommand counterTicketsCMD = new SqlCommand(counterTicketsQuery, db.con);
            SqlDataReader counterTicketsReader = counterTicketsCMD.ExecuteReader();
            while (counterTicketsReader.Read())
            {
                counterTickets = counterTicketsReader["ID"].ToString();
            }
            counterTicketsReader.Close();

            for (int i = 00; i < Convert.ToInt32(counterTickets); i++)
            {
                ListItem tickets = new ListItem("" + i);
                TicketsDropDownList.Items.Add(tickets);
            }

        }

        protected void BuyButton_Click(object sender, EventArgs e)
        {
            //name of match
            //no of tickets
            //buy it





        }
    }
}