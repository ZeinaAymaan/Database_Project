using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;
using System.Windows.Forms;
using System.Text.RegularExpressions;

namespace WebApplication1.Views
{
    public partial class WebForm8 : System.Web.UI.Page
    {
        string username = WebForm1.usernamee;
        string cname = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            db.openConnection();

            string viewClubInfoQuery = "select c.ID, c.clubName, c.clubLocation\r\nfrom Club as c inner join clubRepresentative as cr on c.ID=cr.club_ID\r\nwhere cr.clubRepresentativeUsername  = '" + username + "';";
            SqlCommand clubinfo = new SqlCommand(viewClubInfoQuery, db.con);
            using (SqlDataReader clubinforeader = clubinfo.ExecuteReader())
            {
                while (clubinforeader.Read())
                {
                    Label1.Text = clubinforeader["ID"].ToString();
                    Label2.Text = (string)clubinforeader["clubName"];
                    Label3.Text = (string)clubinforeader["clubLocation"];
                }
                clubinforeader.Close();
            }
            cname = Label2.Text.ToString();
            loadC();
            return;
        }
        protected void loadC()
        {   MultiView1.ActiveViewIndex = 0;
            //MultiView1.ActiveViewIndex= 1;
            string viewUpcominClubMatchesQuery = "select c1name as 'Host club', c2name as 'Guest club', m.startTime as 'Start Time', m.endTime 'End Time', stadiumname as 'Stadium Name'\r\n" +
           "from upcomingMatchesOfClub ('" + cname + "') inner join Club c on c1name= c.clubName inner join Match m on c.ID=m.Host_ID";
            SqlCommand viewUpcomingClubinfo = new SqlCommand(viewUpcominClubMatchesQuery, db.con);
            SqlDataAdapter da = new SqlDataAdapter(viewUpcomingClubinfo);
            SqlCommandBuilder cb = new SqlCommandBuilder(da);
            DataSet dataSet = new DataSet();
            da.Fill(dataSet);
            SqlDataReader clubUpcominginforeader = viewUpcomingClubinfo.ExecuteReader();
            if (clubUpcominginforeader.Read())
            {
                Label4.Text = "Your Club Upcoming Matches:";
                GridView1.AutoGenerateColumns = true;
                GridView1.DataSource = dataSet;
                GridView1.DataBind();
            }
            else
            {
                Label4.Text = "Your Club Has No Upcoming Matches";
            }
            clubUpcominginforeader.Close();
            MultiView2.ActiveViewIndex = 0;
            for (int i = 0; i < 60; i++)
            {
                if (i < 10)
                {
                    ListItem minutes = new ListItem("0" + i);
                    DropDownList2.Items.Add(minutes);
                }
                else
                {
                    ListItem minutes = new ListItem("" + i);
                    DropDownList2.Items.Add(minutes);
                }
            }

            for (int i = 0; i < 24; i++)
            {
                if (i < 10)
                {
                    ListItem hours = new ListItem("0" + i);
                    DropDownList1.Items.Add(hours);
                }
                else
                {
                    ListItem hours = new ListItem("" + i);
                    DropDownList1.Items.Add(hours);
                }
            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            DateTime stadiumDate = Calendar1.SelectedDate;

            if (DropDownList1.Text == "Hours" || DropDownList2.Text == "Minutes")
            {
                MessageBox.Show("Time can't be empty");
                return;
            }
            if (stadiumDate < DateTime.Now)
            {
                MessageBox.Show("No avilable stadiums before today");
                return;
            }

            MultiView2.ActiveViewIndex++;
            string st = stadiumDate.ToString("yyyy/MM/dd") + " " + DropDownList1.Text + ":" + DropDownList2.Text +":00";
            string viewAvailableStadQuery = "select sname 'Stadium Name', sloc 'Stadium Location', cap 'Capacity' from viewAvailableStadiumsOn('" + st +"')";
            SqlCommand viewStadinfo = new SqlCommand(viewAvailableStadQuery, db.con);
            SqlDataAdapter StadInfoDA = new SqlDataAdapter(viewStadinfo);
            SqlCommandBuilder cb = new SqlCommandBuilder(StadInfoDA);
            DataSet dataSet2 = new DataSet();
            StadInfoDA.Fill(dataSet2);
            SqlDataReader Stadinforeader = viewStadinfo.ExecuteReader();
            if (Stadinforeader.HasRows)
            {
                Label6.Text = "Available Stadiums Starting " + st + ":";
                GridView2.AutoGenerateColumns = true;
                GridView2.DataSource = dataSet2;
                GridView2.DataBind();

            }
            
            else
            {
                Label6.Text = "There are no available stadiums on "+st+".";
                
            }
            Stadinforeader.Close();

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            MultiView3.ActiveViewIndex=0;
            Button2.Visible= false;
            string viewAllStadQuery = "select stadiumName from Stadium s inner join stadiumManager sm on s.ID=sm.Stadium_ID";
            SqlCommand viewAllStadinfo = new SqlCommand(viewAllStadQuery, db.con);
            SqlDataAdapter allStadInfoDA = new SqlDataAdapter(viewAllStadinfo);
            SqlCommandBuilder cb = new SqlCommandBuilder(allStadInfoDA);
            DataSet stadiumsDataSet = new DataSet();
            allStadInfoDA.Fill(stadiumsDataSet);
            SqlDataReader allStadinforeader = viewAllStadinfo.ExecuteReader();
            while (allStadinforeader.Read())
            {
                DropDownList3.Items.Add(allStadinforeader["stadiumName"].ToString());
            }
            allStadinforeader.Close();
            string matchInfoQuery = "select c1.clubName 'Host',c2.clubName 'Guest', Match.startTime \r\n from Match inner join Club c1 on c1.ID = Match.host_ID inner join Club c2 on c2.ID = Match.guest_ID \r\n where Match.startTime > CURRENT_TIMESTAMP AND Match.stadium_Id IS NULL AND c1.clubName ='" + cname + "'";
            SqlCommand matchInfoCMD = new SqlCommand(matchInfoQuery, db.con);
            SqlDataReader matchInfoReader = matchInfoCMD.ExecuteReader();
            while (matchInfoReader.Read())
            {
                string hostName = matchInfoReader["Host"].ToString();
                string guestName = matchInfoReader["Guest"].ToString();
                string startTime = matchInfoReader["startTime"].ToString();
                //string stadiumName = matchInfoReader["stadiumName"].ToString();
                //string stadiumLocation = matchInfoReader["stadiumLocation"].ToString();
                string matchInfo = hostName + " vs " + guestName + " starts at: " + startTime;
                DropDownList4.Items.Add(matchInfo);
            }
            matchInfoReader.Close();
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            if(DropDownList3.Text.Equals("Stadium Name")|| DropDownList4.Text.Equals("Match to Host"))
            {
                MessageBox.Show("Please Select a Stadium Name And a Match Before Proceeding");
                return;
            }
            string st="";
           
            string getTeamss = DropDownList4.Text.ToString();
            string[] separator = { " vs ", " starts at: " };
            String[] getTeams=getTeamss.Split(separator,3,StringSplitOptions.RemoveEmptyEntries);
            string team1 = getTeams[0];
            string team2 = getTeams[1];
            st = getTeams[2];
            //int j = 0;
            //for (j=0 ; j <= getTeams.Length - 1; j++)
            //{
            //    if (getTeams[j].Equals("vs"))
            //        break;
            //    team1 += getTeams[j];
            //}
            //j++;
            //while (j < getTeams.Length)
            //{
            //    if (getTeams[j].Equals("starts"))
            //        break;
            //    team2 += getTeams[j];
            //}
            //j+=3;
            //while (j < getTeams.Length)
            //{
            //    st+= getTeams[j];
            //}
            DateTime stDate = DateTime.Parse(st);
            string stCorrect = stDate.ToString("yyyy/MM/dd HH:mm");
            string crname="";
            string viewClubRepNameQuery = "select Name \r\n from allClubRepresentatives \r\n where Username  = '" + username + "';";
            SqlCommand viewClubRepinfo = new SqlCommand(viewClubRepNameQuery, db.con);
            SqlDataReader clubrepinforeader = viewClubRepinfo.ExecuteReader();
            while (clubrepinforeader.Read())
            {
                crname= (string)clubrepinforeader["Name"];
            }
            clubrepinforeader.Close();

            string staduser = "";
            string viewStadUserQuery = "select Username from allStadiumManagers Where [Stadium Managed]='" + DropDownList3.Text + "'";
            SqlCommand stadUserCommand = new SqlCommand(viewStadUserQuery, db.con);
            SqlDataReader stadUserreader = stadUserCommand.ExecuteReader();
            while(stadUserreader.Read())
            {
                staduser = stadUserreader["Username"].ToString();
                break;
            }
            stadUserreader.Close();
            string alreadyCheckQuery = "select * from allPendingRequests('"+staduser+"') WHERE rname='" + crname + "' AND gcname='"+team2+"' AND starttime='"+st+"'";
            SqlCommand alreadyCommand=new SqlCommand(alreadyCheckQuery, db.con);
            SqlDataReader alreadyreader=alreadyCommand.ExecuteReader();
            if(alreadyreader.HasRows)
            {

                MessageBox.Show("You Have already sent a request to Host This Match");
                return;
            }
            alreadyreader.Close();
            
            string matchInfoQuery = "exec addHostRequest '"+cname+"', '" + DropDownList3.Text +"', '"+stCorrect+"'";
            SqlCommand matchInfoCMD = new SqlCommand(matchInfoQuery, db.con);
            SqlDataReader matchreader = matchInfoCMD.ExecuteReader();
            matchreader.Close();
            MessageBox.Show("Request Sent Successfully");
            return;
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            loadC();
            return;
        }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {

        }
    }
}
