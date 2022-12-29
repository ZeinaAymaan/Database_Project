using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace WebApplication1.Views
{
    public partial class WebForm14 : System.Web.UI.Page
    {
        public string hostName = "";
        public string guestName = "";
        public string stadiumName = "";
        public string startTime = "";
        public string stadiumLocation = "";
        public string matchInfo = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            db.openConnection();

            matchStartTimeLabel.Text = WebForm10.st;

            //sql query to get the number of available tickets

            //SqlDataSource1.SelectCommand = "SELECT availableMatchesToAttend_1.ID, availableMatchesToAttend_1.Host, availableMatchesToAttend_1.Guest, availableMatchesToAttend_1.stadiumName, Stadium.stadiumLocation \r\nFROM Stadium INNER JOIN dbo.availableMatchesToAttend('" + WebForm10.st +"') AS availableMatchesToAttend_1 ON Stadium.stadiumName = availableMatchesToAttend_1.stadiumName";
            //string counter = "";

            //string dataSourceQuery = "SELECT ama.Host, ama.Guest, ama.stadiumName, s.stadiumLocation \r\nFROM Stadium s INNER JOIN dbo.availableMatchesToAttend('"+ WebForm10.st +"') AS ama ON s.stadiumName = ama.stadiumName\r\n";
            //SqlDataSource1.SelectCommand = dataSourceQuery;

            

            string matchInfoQuery = "select Host, Guest, ama.startTime, s.stadiumName, s.stadiumLocation\r\nfrom availableMatchesToAttend('"+ WebForm10.st +"') ama inner join stadium s on s.stadiumName = ama.stadiumName";
            //System.Windows.Forms.MessageBox.Show(WebForm10.stDate + "");
            //string guestNameQuery = "select Guest\r\nfrom availableMatchesToAttend('" + WebForm10.stDate + "')";
            //string startTimeQuery = "select startTime\r\nfrom availableMatchesToAttend('" + WebForm10.stDate + "')";

            //SqlCommand matchInfoDCMD = new SqlCommand(dataSourceQuery, db.con);
            //SqlDataAdapter matchInfoDa = new SqlDataAdapter(matchInfoDCMD);
            //SqlCommandBuilder matchInfoDCB = new SqlCommandBuilder(matchInfoDa);
            //DataSet matchInfoDataSet = new DataSet();
            //matchInfoDa.Fill(matchInfoDataSet);
            //GridView1.DataSource = matchInfoDataSet;
            //GridView1.DataBind();

            SqlCommand matchInfoCMD = new SqlCommand(matchInfoQuery, db.con);
            SqlDataAdapter matchInfoDA = new SqlDataAdapter(matchInfoCMD);
            SqlCommandBuilder matchInfoCMDB = new SqlCommandBuilder(matchInfoDA);
            DataSet dataSet = new DataSet();
            matchInfoDA.Fill(dataSet);
            SqlDataReader matchInfoReader = matchInfoCMD.ExecuteReader();
            if (matchInfoReader.HasRows)
            {
                //matchInfoLabel.Text = "All the matchInfo";
                availableMatchesGridView.AutoGenerateColumns = true;
                availableMatchesGridView.DataSource = dataSet;
                availableMatchesGridView.DataBind();

            }
            else
            {
                checkLabel.Text = "There's no matches available";
            }

            //SqlCommand matchInfoCMD = new SqlCommand(matchInfoQuery, db.con);
            //SqlDataReader matchInfoReader = matchInfoCMD.ExecuteReader();
            while (matchInfoReader.Read())
            {
                hostName = matchInfoReader["Host"].ToString();
                guestName = matchInfoReader["Guest"].ToString();
                startTime = matchInfoReader["startTime"].ToString();
                stadiumName = matchInfoReader["stadiumName"].ToString();
                stadiumLocation = matchInfoReader["stadiumLocation"].ToString();
                matchInfo = hostName + " vs " + guestName + " starts at: " + startTime + " on " + stadiumName + ", " + stadiumLocation;
                selectedMatchDropDownList.Items.Add(matchInfo);
            }
            matchInfoReader.Close();


            //string counterTickets = "";
            //string matchSelected = selectedMatchDropDownList.Text;




            //for (int i = 1; i < 11; i++)
            //{
            //    ListItem tickets = new ListItem("" + i);
            //    TicketsDropDownList.Items.Add(tickets);
            //}


        }

        protected void BuyButton_Click(object sender, EventArgs e)
        {
            //name of match
            //no of tickets
            //buy it

            //if(TicketsDropDownList.Text == "No of tickets")
            //{
            //    MessageBox.Show("please select the number of tickets you'd live to buy");
            //    return;
            //}



            string nationaID = "";

            string nationalIDquery = "select [National ID]\r\nfrom allFans \r\nwhere Username = '"+ WebForm1.usernamee +"'";
            SqlCommand nationalIDCMD = new SqlCommand(nationalIDquery, db.con);
            SqlDataReader nationaIDReader = nationalIDCMD.ExecuteReader();
            while (nationaIDReader.Read())
            {
                nationaID = nationaIDReader["National ID"].ToString();
            }
            nationaIDReader.Close();

            if(selectedMatchDropDownList.Text == "Match")
            {
                MessageBox.Show("Select your match");
                return;
            }

            if(startTime == "")
            {
                MessageBox.Show("Tickets are sold out :(");
                return ;
            }

            DateTime sTime = DateTime.Parse(startTime);
            string sTimeRight = sTime.ToString("yyyy/MM/dd HH:mm");

            string checkTicketQuery = "select t.*\r\nfrom Ticket t inner join Match m on m.ID = t.ID\r\n\tinner join Club host on m.Host_ID = host.ID\r\nwhere m.startTime = '" + sTimeRight + "' and host.clubName = '" + hostName + "'";
            SqlCommand checkTicketCMD = new SqlCommand(checkTicketQuery, db.con);
            SqlDataReader checkTicketReader = checkTicketCMD.ExecuteReader();
            if (!checkTicketReader.Read())
            {
                MessageBox.Show("Tickets are sold out :(");
                checkTicketReader.Close();
                return;
            }
            checkTicketReader.Close();

            //for(int i = 0; i < noOfTickets; i++)
            //{
            //    int counterTickets = 0;
            //    string counterTicketsQuery = "select count(*) as ID\r\nfrom Ticket t inner join availableMatchesToAttend('" + WebForm10.st + "') ama on ama.matchID = t.Match_ID\r\nwhere t.ticketStatus = '1'";
            //    SqlCommand counterTicketsCMD = new SqlCommand(counterTicketsQuery, db.con);
            //    SqlDataReader counterTicketsReader = counterTicketsCMD.ExecuteReader();
            //    while (counterTicketsReader.Read())
            //    {
            //        counterTickets = Convert.ToInt32(counterTicketsReader["ID"].ToString());
            //    }
            //    counterTicketsReader.Close();

            //    if(counterTickets < 1)
            //    {
            //        MessageBox.Show("Tickets are sold out :(");
            //        MessageBox.Show("purchased " + i+1 + " tickets");
            //        return;
            //    }



            string buyQuery = "exec purchaseTicket '" + nationaID + "', '" + hostName + "', '" + guestName + "', '" + sTimeRight + "'";
            SqlCommand buyCMD = new SqlCommand(buyQuery, db.con);
            SqlDataReader buyReader = buyCMD.ExecuteReader();
            buyReader.Close();
            //}


            MessageBox.Show("Purchased a ticket successfully");



            //SqlDataReader nationaIDReader = nationaIDCMD.ExecuteReader();
            //while (nationaIDReader.Read())
            //{

            //    nationaID = nationaIDReader["National ID"].ToString();
            //}
            //nationaIDReader.Close();



        }
    }
}