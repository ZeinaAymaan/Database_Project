using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1.Views
{
    public partial class WebForm14 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            db.openConnection();



            //sql query to get the number of available tickets

            for (int i = 00; i < 60; i++)
            {
                ListItem tickets = new ListItem("" + i);
                TicketsDropDownList.Items.Add(tickets);
            }
        }

        protected void BuyButton_Click(object sender, EventArgs e)
        {
            //name of match
            //no of tickets
            //buy it
        }
    }
}