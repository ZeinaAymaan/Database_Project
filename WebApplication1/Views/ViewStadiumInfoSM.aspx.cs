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
            SqlDataSource1.SelectCommand = "SELECT Stadium.stadiumName, Stadium.stadiumLocation, Stadium.Capacity FROM Stadium INNER JOIN stadiumManager ON Stadium.ID = stadiumManager.Stadium_ID AND stadiumManager.stadiumManagerName = "+;

        }
    }
}