using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace WebApplication1.Views
{
    public partial class WebForm7 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            db.openConnection();
        }

        protected void AddSAMButton_Click(object sender, EventArgs e)
        {
            string HostClubName = HostClubNameDropDownList.Text;
            string GuestClubName = GuestClubNameDropDownList.Text;
            string StartTime = StartTimeSAMTextBox.Text;
            string EndTime = EndTimeSAMTextBox.Text;

            if (HostClubName == "" || GuestClubName == "" || StartTime == "" || EndTime == "" )
            {
                MessageBox.Show("Host Club Name or Guest Club Name or Start Time or End Time fields can't be empty");
                return;
            }
            if(Equals(HostClubName , GuestClubName))
            {
                MessageBox.Show("Host Club Name and Guest Club Name can't be the same");
                return;
            }

            if (HostClubName.Length > 20 || GuestClubName.Length > 20 || StartTime.Length > 20 || EndTime.Length > 20)
            {
                MessageBox.Show("Host Club Name or Guest Club Name or Start Time or End Time can't be more than 20 charactars");
                return;
            }

            string checkMatchExistsQuery = "select  c.MatchName\r\nfrom Match m inner join Match c on m.Host_ID = c.ID\r\nwhere c.MatchName = 'hostName' and m.startTime = 'sTime' and m.endTime = 'eTime'";
            SqlCommand checkMatchExistsCMD = new SqlCommand(checkMatchExistsQuery, db.con);
            SqlDataReader checkMatchExistsReader = checkMatchExistsCMD.ExecuteReader();
            while (checkMatchExistsReader.Read())
            {
                MessageBox.Show("Match already exists");
                checkMatchExistsReader.Close();
                return;
            }
            db.openConnection();
            for(int i = 00; i < 60; i++)
            {
                ListItem minutes = new ListItem("" + i);
                SMinutsDropDownList.Items.Add(minutes);
                EMinutesDropDownList.Items.Add(minutes);
            }

            checkMatchExistsReader.Close();
            string addMatchQuery = "exec addMatch '" + HostClubName + "', '" + GuestClubName + "', '" + StartTime + "', '" + EndTime + "';";
            SqlCommand addMatchCMD = new SqlCommand(addMatchQuery, db.con);
            SqlDataReader addMatchReader = addMatchCMD.ExecuteReader();
            addMatchReader.Close();
            MessageBox.Show("Match added successfully");


        }

        protected void DeleteSAMButton_Click(object sender, EventArgs e)
        {
            string HostClubName = HostClubNameDropDownList.Text;
            string GuestClubName = GuestClubNameDropDownList.Text;
            string StartTime = StartTimeSAMTextBox.Text;
            string EndTime = EndTimeSAMTextBox.Text;

            if (HostClubName == "" || GuestClubName == "" || StartTime == "" || EndTime == "")
            {
                MessageBox.Show("Host Club Name or Guest Club Name or Start Time or End Time fields can't be empty");
                return;
            }

            string checkMatchExistsQuery = "select  c.MatchName\r\nfrom Match m inner join Match c on m.Host_ID = c.ID\r\nwhere c.MatchName = 'hostName' and m.startTime = 'sTime' and m.endTime = 'eTime'";
            SqlCommand checkMatchExistsCMD = new SqlCommand(checkMatchExistsQuery, db.con);
            SqlDataReader checkMatchExistsReader = checkMatchExistsCMD.ExecuteReader();

            while (!checkMatchExistsReader.Read())
            {
                MessageBox.Show("Match doesn't exists");
                checkMatchExistsReader.Close();
                return;

            }

            checkMatchExistsReader.Close();
            string deleteMatchQuery = "exec deleteMatch '" + HostClubName + "', '" + GuestClubName + "', '" + StartTime + "', '" + EndTime + "';";
            SqlCommand deleteMatchCMD = new SqlCommand(deleteMatchQuery, db.con);
            SqlDataReader deleteMatchReader = deleteMatchCMD.ExecuteReader();
            deleteMatchReader.Close();
            MessageBox.Show("Match deleted successfully");
            for (int i = 00; i < 24; i++)
            {
                ListItem hours = new ListItem("" + i);
                SHoursDropDownList.Items.Add(hours);
                EHoursDropDownList.Items.Add(hours);
            }
        }
    }
}