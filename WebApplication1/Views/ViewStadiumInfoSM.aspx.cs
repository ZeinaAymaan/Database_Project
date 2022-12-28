using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1.Views
{
    public partial class WebForm15 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT Stadium.stadiumName, Stadium.stadiumLocation, Stadium.Capacity FROM Stadium INNER JOIN stadiumManager ON Stadium.ID = stadiumManager.Stadium_ID AND stadiumManager.stadiumManagerName = '" + WebForm1.usernamee + "'";
            SqlDataSource2.SelectCommand = "SELECT allPendingRequests_1.RepresentativeName, Club.clubName, allPendingRequests_1.GuestClubName, allPendingRequests_1.startTime, Match.endTime, hostRequest.Status\r\nFROM     Match INNER JOIN\r\n                  hostRequest ON Match.ID = hostRequest.Match_ID INNER JOIN\r\n                  clubRepresentative INNER JOIN\r\n                  Club ON clubRepresentative.club_ID = Club.ID ON Match.Host_ID = Club.ID INNER JOIN\r\n                  dbo.allPendingRequests('"+ WebForm1.usernamee +"') AS allPendingRequests_1 ON clubRepresentative.Name = allPendingRequests_1.RepresentativeName";
        }
    }
}