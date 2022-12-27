using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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

        protected void UpcomingMatchesButton_Click(object sender, EventArgs e)
        {
            string upcomingMatchesQuery = "select c1.clubName as Host,c2.clubName as Guest, m.startTime, m.endTime\r\nfrom Match m inner join club c1 on m.Host_ID = c1.ID\r\n\t\t\tleft outer join club c2 on c2.ID = m.guest_ID\r\nwhere m.startTime > CURRENT_TIMESTAMP and m.stadium_ID is not null";
            SqlCommand upcomingMatchesCMD = new SqlCommand(upcomingMatchesQuery, db.con);
            SqlDataReader upcomingMatchesReader = upcomingMatchesCMD.ExecuteReader();
            while (upcomingMatchesReader.Read())
            {
                UpcomeingMatchesTable.Rows.Add(upcomingMatchesReader["Host"]);
                UpcomeingMatchesTable.Rows.Add();
            }
        }
    }
}