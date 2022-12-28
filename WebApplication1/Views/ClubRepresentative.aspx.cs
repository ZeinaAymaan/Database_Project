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
            string viewClubInfoQuery = "select c.ID, c.clubName, c.clubLocation\r\nfrom Club as c inner join clubRepresentative as cr on c.ID=cr.club_ID\r\nwhere cr.clubRepresentativeUsername = '" + username + "'";
            SqlCommand clubinfo = new SqlCommand(viewClubInfoQuery, db.con);
            SqlDataReader clubinforeader = clubinfo.ExecuteReader();
            Label1.Text = (string)clubinforeader["ID"];
            Label2.Text = (string)clubinforeader["clubName"];
            Label3.Text = (string)clubinforeader["clubLocation"];
        }

        // The return type can be changed to IEnumerable, however to support
        // paging and sorting, the following parameters must be added:
        //     int maximumRows
        //     int startRowIndex
        //     out int totalRowCount
        //     string sortByExpression
    }
}