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

        public static string st;
        public static DateTime stDate;
        
        //public static DateTime endTime;

        //public class matchTime
        //{
        //    public string matchStartTime { get; set; }

        //}
        

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

            

            if(SHoursDropDownList.Text == "Hours" || SMinutesDropDownList.Text == "Minutes")
            {
                MessageBox.Show("Time can't be empty");
                return;
            }

            st = matchDate.ToString("yyyy/MM/dd") + " " + SHoursDropDownList.Text + ":" + SMinutesDropDownList.Text;
            stDate = DateTime.Parse(st);


            //var matchTime = new matchTime();
            //matchTime.matchStartTime = st;

            //WebForm14 avilableMatches = new WebForm14(matchTime);

            //matchStartTime = DateTime.ParseExact();
            //endTime = DateTime.ParseExact(EHoursDropDownList.Text + ":" + EMinutesDropDownList.Text, "HH:mm", CultureInfo.InvariantCulture);

            //startTimeDateTime = matchDate.ToString("yyyy/MM/dd ") + matchStartTime.ToString();
            //MessageBox.Show(matchStartTime +" " );
            //return;

            if (matchDate < DateTime.Now)
            {
                MessageBox.Show("No avilable matches before today");
                return;
            }

            ShowMatchesButton.PostBackUrl = "~/Views/AvilableMatchesForFan.aspx";

            //if(date == DateTime.Now && startTime <= DateTime.Now)
            //{
            //    MessageBox.Show("Matchs ended :(");
            //    return;
            //}
        }
    }
}