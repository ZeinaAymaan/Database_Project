using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace WebApplication1.Views
{
    public partial class WebForm10 : System.Web.UI.Page
    {
        //public static DateTime matchDate;
        //public static DateTime matchStartTime;

        public static string matchStartTime;
        //public static DateTime endTime;

        protected void Page_Load(object sender, EventArgs e)
        {
            db.openConnection();

            for (int i = 0; i < 60; i++)
            {
                if (i < 10)
                {
                    ListItem minutes = new ListItem("0" + i);
                    SMinutesDropDownList.Items.Add(minutes);
                }
                else
                {
                    ListItem minutes = new ListItem("" + i);
                    SMinutesDropDownList.Items.Add(minutes);
                }


                //EMinutesDropDownList.Items.Add(minutes);
            }

            for (int i = 0; i < 24; i++)
            {
                if (i < 10)
                {
                    ListItem hours = new ListItem("0" + i);
                    SHoursDropDownList.Items.Add(hours);
                }
                else
                {
                    ListItem hours = new ListItem("" + i);
                    SHoursDropDownList.Items.Add(hours);
                }

                //EHoursDropDownList.Items.Add(hours);
            }
        }

        protected void ShowMatchesButton_Click(object sender, EventArgs e)
        {
            DateTime matchDate = FanCalendar.SelectedDate;
            matchStartTime = matchDate.ToString("yyyy/MM/dd") + " " + SHoursDropDownList.Text + ":" + SMinutesDropDownList.Text;
            //matchStartTime = DateTime.ParseExact();
            //endTime = DateTime.ParseExact(EHoursDropDownList.Text + ":" + EMinutesDropDownList.Text, "HH:mm", CultureInfo.InvariantCulture);

            //startTimeDateTime = matchDate.ToString("yyyy/MM/dd ") + matchStartTime.ToString();
            //MessageBox.Show(dateTime);
            //return;

            if (matchDate < DateTime.Now)
            {
                MessageBox.Show("No avilable matches before today");
                return;
            }

            //if(date == DateTime.Now && startTime <= DateTime.Now)
            //{
            //    MessageBox.Show("Matchs ended :(");
            //    return;
            //}
        }
    }
}