using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Management;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;
using System.Xml.Linq;
using System.Text.RegularExpressions;

namespace WebApplication1.Views
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            db.openConnection();
        }

        protected void AddClubButton_Click(object sender, EventArgs e)
        {
            string clubName = ClubNameTextBox.Text;
            string clubLocation = ClubLocationTextBox.Text;

            if (clubName == "" || clubLocation == "")
            {
                MessageBox.Show("name or location fields can't be empty");
                return;
            }

            if (clubName.Length > 20 || clubLocation.Length > 20)
            {
                MessageBox.Show("Name and Location can't be more than 20 charactars");
                return;
            }

            string checkClubExistsQuery = "select clubName \r\nfrom Club\r\nwhere clubName = '" + clubName + "';";
            SqlCommand checkCkubExistsCMD = new SqlCommand(checkClubExistsQuery,db.con);
            SqlDataReader checkCkubExistsReader = checkCkubExistsCMD.ExecuteReader();
            while (checkCkubExistsReader.Read())
            {
                MessageBox.Show("Club already exists");
                checkCkubExistsReader.Close();
                return;
            }

            checkCkubExistsReader.Close();
            string addClubQuery = "exec addClub '"+ clubName +"', '"+ clubLocation +"';";
            SqlCommand addClubCMD = new SqlCommand(addClubQuery, db.con);
            SqlDataReader addClubReader = addClubCMD.ExecuteReader();
            addClubReader.Close();
            MessageBox.Show("Club added successfully");


        }

        protected void DeleteClubButton_Click(object sender, EventArgs e)
        {
            string clubName = ClubNameTextBox.Text;

            if (clubName == "")
            {
                MessageBox.Show("name field can't be empty");
                return;
            }

            string checkClubExistsQuery = "select clubName \r\nfrom Club\r\nwhere clubName = '" + clubName + "';";
            SqlCommand checkCkubExistsCMD = new SqlCommand(checkClubExistsQuery, db.con);
            SqlDataReader checkCkubExistsReader = checkCkubExistsCMD.ExecuteReader();

            while (!checkCkubExistsReader.Read())
            {
                MessageBox.Show("Club doesn't exists");
                checkCkubExistsReader.Close();
                return;

            }

            checkCkubExistsReader.Close();
            string deleteClubQuery = "exec deleteClub '"+ clubName +"';";
            SqlCommand deleteClubCMD = new SqlCommand(deleteClubQuery, db.con);
            SqlDataReader deleteClubReader = deleteClubCMD.ExecuteReader();
            deleteClubReader.Close();
            MessageBox.Show("Club deleted successfully");
        }

        protected void AddStadiumButton_Click(object sender, EventArgs e)
        {
            string stadiumName = StadiumNameTextBox.Text;
            string stadiumLocation = StadiumLocationTextBox.Text;
            string stadiumCapacityString = StadiumCapacityTextBox.Text;

            if (stadiumName == "" || stadiumLocation == "" || stadiumCapacityString == "")
            {
                MessageBox.Show("name, location, and capacity fields can't be empty");
                return;
            }

            if(!Regex.IsMatch(stadiumCapacityString, @"^\d+$"))
            {
                MessageBox.Show("Only numbers accepted in capacity");
                return ;
            }
            
            if (stadiumName.Length > 20 || stadiumLocation.Length > 20)
            {
                MessageBox.Show("Name and Location can't be more than 20 charactars");
                return;
            }

            int stadiumCapacity = Convert.ToInt32(stadiumCapacityString);

            if(stadiumCapacity < 1)
            {
                MessageBox.Show("Stadium's capacity can't be less than 1");
                return;
            }

            string checkStadiumExistsQuery = "select StadiumName \r\nfrom Stadium\r\nwhere StadiumName = '" + stadiumName + "';";
            SqlCommand checkStadiumExistsCMD = new SqlCommand(checkStadiumExistsQuery, db.con);
            SqlDataReader checkStadiumExistsReader = checkStadiumExistsCMD.ExecuteReader();
            while (checkStadiumExistsReader.Read())
            {
                MessageBox.Show("Stadium already exists");
                checkStadiumExistsReader.Close();
                return;
            }

            checkStadiumExistsReader.Close();
            string addStadiumQuery = "exec addStadium '"+ stadiumName +"', '"+ stadiumLocation +"', "+ stadiumCapacity;
            SqlCommand addStadiumCMD = new SqlCommand(addStadiumQuery, db.con);
            SqlDataReader addStadiumReader = addStadiumCMD.ExecuteReader();
            addStadiumReader.Close();
            MessageBox.Show("Stadium added successfully");
        }

        protected void DeleteStadiumButton_Click(object sender, EventArgs e)
        {
            string stadiumName = StadiumNameTextBox.Text;

            if (stadiumName == "")
            {
                MessageBox.Show("name field can't be empty");
                return;
            }

            string checkStadiumExistsQuery = "select StadiumName \r\nfrom Stadium\r\nwhere StadiumName = '" + stadiumName + "';";
            SqlCommand checkStadiumExistsCMD = new SqlCommand(checkStadiumExistsQuery, db.con);
            SqlDataReader checkStadiumExistsReader = checkStadiumExistsCMD.ExecuteReader();
            while (!checkStadiumExistsReader.Read())
            {
                MessageBox.Show("Stadium doesn't exists");
                checkStadiumExistsReader.Close();
                return;
            }

            checkStadiumExistsReader.Close();
            string deleteStadiumQuery = "exec deleteStadium '"+ stadiumName +"'";
            SqlCommand deleteStadiumCMD = new SqlCommand(deleteStadiumQuery, db.con);
            SqlDataReader deleteStadiumReader = deleteStadiumCMD.ExecuteReader();
            deleteStadiumReader.Close();
            MessageBox.Show("Stadium deleted successfully");
        }

        protected void BlockFanButton_Click(object sender, EventArgs e)
        {
            string nationalID = FanNationalIDTextBox.Text;

            if (nationalID == "")
            {
                MessageBox.Show("National ID field can't be empty");
                return;
            }

            if (!Regex.IsMatch(nationalID, @"^\d+$"))
            {
                MessageBox.Show("Only numbers accepted in National ID");
                return;
            }

            string checkFanExistsQuery = "select NationaID\r\nfrom Fan\r\nwhere NationaID = '"+ nationalID +"'";
            SqlCommand checkFanExistsCMD = new SqlCommand(checkFanExistsQuery, db.con);
            SqlDataReader checkFanExistsReader = checkFanExistsCMD.ExecuteReader();
            while (!checkFanExistsReader.Read())
            {
                MessageBox.Show("Fan doesn't exists");
                checkFanExistsReader.Close();
                return;
            }

            checkFanExistsReader.Close();

            string checkFanNotBlocked = "select Status\r\nfrom Fan\r\nwhere NationaID = '"+ nationalID +"'";
            SqlCommand checkFanNotBlockedCMD = new SqlCommand(checkFanNotBlocked, db.con);
            SqlDataReader checkFanNotBlockedReader = checkFanNotBlockedCMD.ExecuteReader();
            while (checkFanNotBlockedReader.Read())
            {
                bool status = (bool) checkFanNotBlockedReader["Status"];
                if (status == false)
                {
                    MessageBox.Show("Fan is already Blocked");
                    checkFanNotBlockedReader.Close();
                    return;
                }
            }

            checkFanNotBlockedReader.Close();
            string blockFanQuery = "exec blockFan '"+ nationalID +"'";
            SqlCommand blockFanCMD = new SqlCommand(blockFanQuery, db.con);
            SqlDataReader blockFanReader = blockFanCMD.ExecuteReader();
            blockFanReader.Close();
            MessageBox.Show("Fan blocked successfully");
        }

        protected void UnblockFanButton_Click(object sender, EventArgs e)
        {
            string nationalID = FanNationalIDTextBox.Text;

            if (nationalID == "")
            {
                MessageBox.Show("National ID field can't be empty");
                return;
            }

            if (!Regex.IsMatch(nationalID, @"^\d+$"))
            {
                MessageBox.Show("Only numbers accepted in National ID");
                return;
            }

            string checkFanExistsQuery = "select NationaID\r\nfrom Fan\r\nwhere NationaID = '" + nationalID + "'";
            SqlCommand checkFanExistsCMD = new SqlCommand(checkFanExistsQuery, db.con);
            SqlDataReader checkFanExistsReader = checkFanExistsCMD.ExecuteReader();
            while (!checkFanExistsReader.Read())
            {
                MessageBox.Show("Fan doesn't exists");
                checkFanExistsReader.Close();
                return;
            }

            checkFanExistsReader.Close();

            string checkFanNotBlocked = "select Status\r\nfrom Fan\r\nwhere NationaID = '" + nationalID + "'";
            SqlCommand checkFanNotBlockedCMD = new SqlCommand(checkFanNotBlocked, db.con);
            SqlDataReader checkFanNotBlockedReader = checkFanNotBlockedCMD.ExecuteReader();
            while (checkFanNotBlockedReader.Read())
            {
                bool status = (bool)checkFanNotBlockedReader["Status"];
                if (status == true)
                {
                    MessageBox.Show("Fan is already unblocked");
                    checkFanNotBlockedReader.Close();
                    return;
                }
            }

            checkFanNotBlockedReader.Close();
            string blockFanQuery = "exec unblockFan '" + nationalID + "'";
            SqlCommand blockFanCMD = new SqlCommand(blockFanQuery, db.con);
            SqlDataReader blockFanReader = blockFanCMD.ExecuteReader();
            blockFanReader.Close();
            MessageBox.Show("Fan unblocked successfully");

        }
    }
}