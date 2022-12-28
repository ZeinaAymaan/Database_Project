using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace WebApplication1.Views
{
    public partial class WebForm14 : System.Web.UI.Page
    {

        //WebForm10 fan2 = new WebForm10();
        //public WebForm10.matchTime time { get; set; }

        //public WebForm14(WebForm10.matchTime time)
        //{
        //    this.time = time;

        //}

        protected void Page_Load(object sender, EventArgs e)
        {
            db.openConnection();

            //WebForm10 fan = new WebForm10();


            matchStartTimeLabel.Text = WebForm10.st;

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