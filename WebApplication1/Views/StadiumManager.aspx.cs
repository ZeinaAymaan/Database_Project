using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1.Views
{
    
    public partial class WebForm9 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            db.openConnection();

            string stadiumInfoQuery = "select s.stadiumName, s.stadiumLocation, s.Capacity, s.stadiumStatus\r\nfrom Stadium s inner join stadiumManager sm on s.ID = sm.Stadium_ID where sm.stadiumManagerUsername = '"+ WebForm1.usernamee +"'";
            SqlCommand stadiumInfoCMD = new SqlCommand(stadiumInfoQuery,db.con);
            SqlDataReader stadiumInfoReader = stadiumInfoCMD.ExecuteReader();
            while (stadiumInfoReader.Read())
            {
                stadiumNameLabel.Text = stadiumInfoReader["stadiumName"].ToString();
                stadiumLocationLabel.Text = stadiumInfoReader["stadiumLocation"].ToString();
                stadiumCapacityLabel.Text = stadiumInfoReader["Capacity"].ToString();
                if (stadiumInfoReader["stadiumStatus"] is true) statusLabel.Text = "Available";
                else statusLabel.Text = "Unavailable";
            }
            stadiumInfoReader.Close();

            string requestsQuery = "select cr.Name 'Club Representative Name', host.clubName 'Host Club', guest.clubName 'Guest Club', m.startTime 'Start Time', m.endTime 'End Time', hr.Status\r\nfrom hostRequest hr inner join clubRepresentative cr on hr.CR_ID = cr.ID\r\n\tinner join stadiumManager sm on sm.ID = hr.SM_ID\r\n\tinner join Match m on m.ID = hr.Match_ID\r\n\tinner join Club host on m.Host_ID = host.ID\r\n\tinner join Club guest on m.guest_ID = guest.ID\r\nwhere sm.stadiumManagerUsername = '"+ WebForm1.usernamee +"'";
            SqlCommand requestsCMD = new SqlCommand(requestsQuery,db.con);
            SqlDataAdapter requestsDA = new SqlDataAdapter(requestsCMD);
            SqlCommandBuilder requestsCMDB = new SqlCommandBuilder(requestsDA);
            DataSet dataSet = new DataSet();
            requestsDA.Fill(dataSet);
            SqlDataReader requestsReader = requestsCMD.ExecuteReader();
            if (requestsReader.HasRows)
            {
                RequestsLabel.Text = "All the requests";
                allRequestsGridView.AutoGenerateColumns = true;
                allRequestsGridView.DataSource = dataSet;
                allRequestsGridView.DataBind();

            }
            else
            {
                RequestsLabel.Text = "There's no requests yet";
            }
            while (requestsReader.Read())
            {
                string status = requestsReader["Status"].ToString();
                if (status == "unhandled")
                {
                    string hostRequest = requestsReader["Host Club"].ToString();
                    string guestRequest = requestsReader["Guest Club"].ToString();
                    string startTime = requestsReader["Start Time"].ToString();
                    string fullrequest = hostRequest + " vs " + guestRequest + " at " + startTime;
                    requestDropDownList.Items.Add(fullrequest);
                }
            }

            requestsReader.Close();
        }

        protected void acceptButton_Click(object sender, EventArgs e)
        {
            string splittingRequest = requestDropDownList.Text;
            String[] spearator = { " vs ", " at " };
            String[] strList = splittingRequest.Split(spearator, 3, StringSplitOptions.RemoveEmptyEntries);

            string host = strList[0];
            string guest = strList[1];
            string startTime = strList[2];

            DateTime sDate = DateTime.Parse(startTime);
            string correctStartTime = sDate.ToString("yyyy/MM/dd HH:mm");

            string checkStatusQuery = "select *\r\nfrom allPendingRequests('"+ WebForm1.usernamee + "') where GuestClubName = '"+ guest +"' and startTime = '"+ correctStartTime +"'";
            SqlCommand checkStatusCMD = new SqlCommand(checkStatusQuery, db.con);
            SqlDataReader checkStatusReader = checkStatusCMD.ExecuteReader();
            while (!checkStatusReader.Read())
            {
                System.Windows.Forms.MessageBox.Show("Request already handeled");
                checkStatusReader.Close();
                return;
            }
            checkStatusReader.Close();

            string acceptQuery = "exec acceptRequest '"+ WebForm1.usernamee +"', '"+ host +"', '"+ guest +"', '"+ correctStartTime +"'";
            SqlCommand acceptCMD = new SqlCommand(acceptQuery, db.con);
            SqlDataReader acceptReader = acceptCMD.ExecuteReader();
            acceptReader.Close();
            System.Windows.Forms.MessageBox.Show("Request Accepted");
            
        }

        protected void rejectButton_Click(object sender, EventArgs e)
        {
            string splittingRequest = requestDropDownList.Text;
            String[] spearator = { " vs ", " at " };
            String[] strList = splittingRequest.Split(spearator, 3, StringSplitOptions.RemoveEmptyEntries);

            string host = strList[0];
            string guest = strList[1];
            string startTime = strList[2];

            DateTime sDate = DateTime.Parse(startTime);
            string correctStartTime = sDate.ToString("yyyy/MM/dd HH:mm");

            string checkStatusQuery = "select *\r\nfrom allPendingRequests('" + WebForm1.usernamee + "') where GuestClubName = '" + guest + "' and startTime = '" + correctStartTime + "'";
            SqlCommand checkStatusCMD = new SqlCommand(checkStatusQuery, db.con);
            SqlDataReader checkStatusReader = checkStatusCMD.ExecuteReader();
            while (!checkStatusReader.Read())
            {
                System.Windows.Forms.MessageBox.Show("Request already handeled");
                checkStatusReader.Close();
                return;
            }
            checkStatusReader.Close();

            string acceptQuery = "exec rejectRequest '" + WebForm1.usernamee + "', '" + host + "', '" + guest + "', '" + correctStartTime + "'";
            SqlCommand acceptCMD = new SqlCommand(acceptQuery, db.con);
            SqlDataReader acceptReader = acceptCMD.ExecuteReader();
            acceptReader.Close();
            System.Windows.Forms.MessageBox.Show("Request Rejected");
        }
    }
}