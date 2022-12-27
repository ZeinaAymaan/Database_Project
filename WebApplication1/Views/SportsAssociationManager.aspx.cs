using System;
using System.Collections.Generic;
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
    }
}