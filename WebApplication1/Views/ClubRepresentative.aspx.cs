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


namespace WebApplication1.Views
{
    public partial class WebForm8 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { 
            db.openConnection();
            string username = WebForm1.usernamee;
            string viewClubInfoQuery = "select c.ID, c.clubName, c.clubLocation\r\nfrom Club as c inner join clubRepresentative as cr on c.ID=cr.club_ID\r\nwhere cr.clubRepresentativeUsername  = '"+ username +"';";
            SqlCommand clubinfo = new SqlCommand(viewClubInfoQuery, db.con);
            SqlDataReader clubinforeader = clubinfo.ExecuteReader();
            while(clubinforeader.Read())
            {
                Label1.Text = clubinforeader["ID"].ToString();
                Label2.Text = (string)clubinforeader["clubName"];
                Label3.Text = (string)clubinforeader["clubLocation"];
            }
            clubinforeader.Close();

            MultiView1.ActiveViewIndex = 0;
            string viewUpcominClubMatchesQuery = "select c1name as 'Host club', c2name as 'Guest club', m.startTime as 'Start Time', m.endTime 'End Time'\r\n" +
           "from upcomingMatchesOfClub ('" + Label2.Text + "') inner join Club c on c1name= c.clubName inner join Match m on c.ID=m.Host_ID";
            SqlCommand viewUpcomingClubinfo = new SqlCommand(viewUpcominClubMatchesQuery, db.con);
            SqlDataReader clubUpcominginforeader = viewUpcomingClubinfo.ExecuteReader();
            if (clubUpcominginforeader.Read())
            {
                GridView1.DataSource = clubUpcominginforeader;
                GridView1.DataBind();
            }
            else
            {
                Label4.Text = "Your Club Has No Upcoming Matches";
            }
        }

      

        // The return type can be changed to IEnumerable, however to support
        // paging and sorting, the following parameters must be added:
        //     int maximumRows
        //     int startRowIndex
        //     out int totalRowCount
        //     string sortByExpression
    }
}