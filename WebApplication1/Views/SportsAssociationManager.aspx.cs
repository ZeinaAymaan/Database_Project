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

            for(int i = 00; i < 60; i++)
            {
                ListItem minutes = new ListItem("" + i);
                SMinutsDropDownList.Items.Add(minutes);
                EMinutesDropDownList.Items.Add(minutes);
            }

            for (int i = 00; i < 24; i++)
            {
                ListItem hours = new ListItem("" + i);
                SHoursDropDownList.Items.Add(hours);
                EHoursDropDownList.Items.Add(hours);
            }
        }

        protected void AddMatchSAMButton_Click(object sender, EventArgs e)
        {
            string HostClubName = HostClubNameDropDownList.Text;
            string GuestClubName = GuestClubNameDropDownList.Text;
            string StartTimeDate = StartDateCalender.SelectedDate.ToString("yyyy/MM/dd");
            string EndTimeDate = EndDateCalender.SelectedDate.ToString("yyyy/MM/dd");
            string StartTimeHours = SHoursDropDownList.Text;
            string StartTimeMinutes = SMinutsDropDownList.Text;
            string EndTimeHours = EHoursDropDownList.Text;
            string EndTimeMinutes = EMinutesDropDownList.Text;

            if (HostClubName == "Select" || GuestClubName == "Select" || StartTimeMinutes == "Minutes" || StartTimeHours == "Hours" || EndTimeMinutes == "Minutes" || EndTimeHours == "Hours")
            {
                MessageBox.Show("Host Club Name or Guest Club Name or Start Time or End Time fields can't be empty");
                return;
            }

            if(Equals(HostClubName , GuestClubName))
            {
                MessageBox.Show("Host Club Name and Guest Club Name can't be the same");
                return;
            }

            string startTime = StartTimeDate + " " + StartTimeHours + " : " + StartTimeMinutes; 
            string endTime = EndTimeDate + " " + EndTimeHours + " : " + EndTimeMinutes;

            if(endTime.CompareTo(startTime) > 0)
            {
                MessageBox.Show("End time can't be before start time");
                return;
            }

            string checkMatchExistsQuery = "select  c.clubName\r\nfrom Match m inner join Club c on m.Host_ID = c.ID\r\nwhere c.clubName = '"+ HostClubName +"' and m.startTime = '"+ startTime +"' and m.endTime = '"+ endTime +"'";
            SqlCommand checkMatchExistsCMD = new SqlCommand(checkMatchExistsQuery, db.con);
            SqlDataReader checkMatchExistsReader = checkMatchExistsCMD.ExecuteReader();
            while (checkMatchExistsReader.Read())
            {
                MessageBox.Show("Match already exists");
                checkMatchExistsReader.Close();
                return;
            }
            checkMatchExistsReader.Close();

            string addMatchQuery = "exec addNewMatch '" + HostClubName + "', '" + GuestClubName + "', '" + startTime + "', '" + endTime + "';";
            SqlCommand addMatchCMD = new SqlCommand(addMatchQuery, db.con);
            SqlDataReader addMatchReader = addMatchCMD.ExecuteReader();
            addMatchReader.Close();
            MessageBox.Show("Match added successfully");


        }

        protected void DeleteMatchSAMButton_Click(object sender, EventArgs e)
        {
            string HostClubName = HostClubNameDropDownList.Text;
            string GuestClubName = GuestClubNameDropDownList.Text;
            string StartTimeDate = StartDateCalender.SelectedDate.ToString("yyyy/MM/dd");
            string EndTimeDate = EndDateCalender.SelectedDate.ToString("yyyy/MM/dd");
            string StartTimeHours = SHoursDropDownList.Text;
            string StartTimeMinutes = SMinutsDropDownList.Text;
            string EndTimeHours = EHoursDropDownList.Text;
            string EndTimeMinutes = EMinutesDropDownList.Text;

            if (HostClubName == "Select" || GuestClubName == "Select" || StartTimeMinutes == "Minutes" || StartTimeHours == "Hours" || EndTimeMinutes == "Minutes" || EndTimeHours == "Hours")
            {
                MessageBox.Show("Host Club Name or Guest Club Name or Start Time or End Time fields can't be empty");
                return;
            }

            string startTime = StartTimeDate + " " + StartTimeHours + " : " + StartTimeMinutes;
            string endTime = EndTimeDate + " " + EndTimeHours + " : " + EndTimeMinutes;

            if (endTime.CompareTo(startTime) < 0)
            {
                MessageBox.Show("End time can't be before start time");
                return;
            }

            string checkMatchExistsQuery = "select  c.clubName\r\nfrom Match m inner join Club c on m.Host_ID = c.ID\r\nwhere c.clubName = '"+ HostClubName +"' and m.startTime = '"+ startTime +"' and m.endTime = '"+ endTime +"'";
            SqlCommand checkMatchExistsCMD = new SqlCommand(checkMatchExistsQuery, db.con);
            SqlDataReader checkMatchExistsReader = checkMatchExistsCMD.ExecuteReader();

            while (!checkMatchExistsReader.Read())
            {
                MessageBox.Show("Match doesn't exists");
                checkMatchExistsReader.Close();
                return;

            }
            checkMatchExistsReader.Close();



            string deleteMatchQuery = "exec deleteMatch '" + HostClubName + "', '" + GuestClubName + "', '" + startTime + "', '" + endTime + "';";
            SqlCommand deleteMatchCMD = new SqlCommand(deleteMatchQuery, db.con);
            SqlDataReader deleteMatchReader = deleteMatchCMD.ExecuteReader();
            deleteMatchReader.Close();
            MessageBox.Show("Match deleted successfully");

        }


    }
}