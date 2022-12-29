﻿using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;
using System.Windows.Forms;
using System.Text.RegularExpressions;

namespace WebApplication1.Views
{
    public partial class WebForm8 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            db.openConnection();
            string username = WebForm1.usernamee;
            string viewClubInfoQuery = "select c.ID, c.clubName, c.clubLocation\r\nfrom Club as c inner join clubRepresentative as cr on c.ID=cr.club_ID\r\nwhere cr.clubRepresentativeUsername  = '" + username + "';";
            SqlCommand clubinfo = new SqlCommand(viewClubInfoQuery, db.con);
            SqlDataReader clubinforeader = clubinfo.ExecuteReader();
            while (clubinforeader.Read())
            {
                Label1.Text = clubinforeader["ID"].ToString();
                Label2.Text = (string)clubinforeader["clubName"];
                Label3.Text = (string)clubinforeader["clubLocation"];
            }
            clubinforeader.Close();

            MultiView1.ActiveViewIndex = 0;
            //MultiView1.ActiveViewIndex= 1;
            string viewUpcominClubMatchesQuery = "select c1name as 'Host club', c2name as 'Guest club', m.startTime as 'Start Time', m.endTime 'End Time', stadiumname as 'Stadium Name'\r\n" +
           "from upcomingMatchesOfClub ('" + Label2.Text + "') inner join Club c on c1name= c.clubName inner join Match m on c.ID=m.Host_ID";
            SqlCommand viewUpcomingClubinfo = new SqlCommand(viewUpcominClubMatchesQuery, db.con);
            SqlDataAdapter da = new SqlDataAdapter(viewUpcomingClubinfo);
            SqlCommandBuilder cb = new SqlCommandBuilder(da);
            DataSet dataSet = new DataSet();
            da.Fill(dataSet);
            SqlDataReader clubUpcominginforeader = viewUpcomingClubinfo.ExecuteReader();
            if (clubUpcominginforeader.Read())
            {
                Label4.Text = "Your Club Upcoming Matches:";
                GridView1.AutoGenerateColumns = true;
                GridView1.DataSource = dataSet;
                GridView1.DataBind();
            }
            else
            {
                Label4.Text = "Your Club Has No Upcoming Matches";
            }
            clubUpcominginforeader.Close();
            MultiView2.ActiveViewIndex = 0;
            for (int i = 0; i < 60; i++)
            {
                if (i < 10)
                {
                    ListItem minutes = new ListItem("0" + i);
                    DropDownList2.Items.Add(minutes);
                }
                else
                {
                    ListItem minutes = new ListItem("" + i);
                    DropDownList2.Items.Add(minutes);
                }
            }

            for (int i = 0; i < 24; i++)
            {
                if (i < 10)
                {
                    ListItem hours = new ListItem("0" + i);
                    DropDownList1.Items.Add(hours);
                }
                else
                {
                    ListItem hours = new ListItem("" + i);
                    DropDownList1.Items.Add(hours);
                }
            }


        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            DateTime stadiumDate = Calendar1.SelectedDate;

            if (DropDownList1.Text == "Hours" || DropDownList2.Text == "Minutes")
            {
                MessageBox.Show("Time can't be empty");
                return;
            }
            if (stadiumDate < DateTime.Now)
            {
                MessageBox.Show("No avilable stadiums before today");
                return;
            }

            MultiView2.ActiveViewIndex++;
            string st = stadiumDate.ToString("yyyy/MM/dd") + " " + DropDownList1.Text + ":" + DropDownList2.Text +":00";
            string viewAvailableStadQuery = "select sname 'Stadium Name', sloc 'Stadium Location', cap 'Capacity' from viewAvailableStadiumsOn('" + st +"')";
            SqlCommand viewStadinfo = new SqlCommand(viewAvailableStadQuery, db.con);
            SqlDataAdapter StadInfoDA = new SqlDataAdapter(viewStadinfo);
            SqlCommandBuilder cb = new SqlCommandBuilder(StadInfoDA);
            DataSet dataSet2 = new DataSet();
            StadInfoDA.Fill(dataSet2);
            SqlDataReader Stadinforeader = viewStadinfo.ExecuteReader();
            if (Stadinforeader.Read())
            {
                Label6.Text = "Available Stadiums Starting "+ st + ":";
                GridView2.AutoGenerateColumns = true;
                GridView2.DataSource = dataSet2;
                GridView2.DataBind();
            }
            else
            {
                Label6.Text = "There are no available stadiums on "+st+".";
            }
            Stadinforeader.Close();
        }
    }
}