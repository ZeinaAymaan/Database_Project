using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Management;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;


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

        }

        protected void DeleteClubButton_Click(object sender, EventArgs e)
        {
            string clubName = ClubNameTextBox.Text;

            string checkClubExistsQuery = "select clubName \r\nfrom Club\r\nwhere clubName = '" + clubName + "';";
            SqlCommand checkCkubExistsCMD = new SqlCommand(checkClubExistsQuery, db.con);
            SqlDataReader checkCkubExistsReader = checkCkubExistsCMD.ExecuteReader();
            MessageBox.Show("Test before while");

            while (!checkCkubExistsReader.Read())
            {
                MessageBox.Show("Test while");
                MessageBox.Show("Club doesn't exists");
                checkCkubExistsReader.Close();
                return;

            }

            checkCkubExistsReader.Close();
            string deleteClubQuery = "exec deleteClub '"+ clubName +"';";
            SqlCommand deleteClubCMD = new SqlCommand(deleteClubQuery, db.con);
            SqlDataReader deleteClubReader = deleteClubCMD.ExecuteReader();
            deleteClubReader.Close();
        }

        protected void AddStadiumButton_Click(object sender, EventArgs e)
        {
            string stadiumName = StadiumNameTextBox.Text;
            string stadiumLocation = StadiumLocationTextBox.Text;
            string stadiumCapacityString = StadiumCapacityTextBox.Text;
            int stadiumCapacity = Convert.ToInt32(stadiumCapacityString);

            string checkStadiumExistsQuery = "select StadiumName \r\nfrom Stadium\r\nwhere StadiumName = '" + stadiumName + "';";
            SqlCommand checkCkubExistsCMD = new SqlCommand(checkStadiumExistsQuery, db.con);
            SqlDataReader checkCkubExistsReader = checkCkubExistsCMD.ExecuteReader();
            while (checkCkubExistsReader.Read())
            {
                MessageBox.Show("Stadium already exists");
                checkCkubExistsReader.Close();
                return;
            }

            checkCkubExistsReader.Close();
            string addStadiumQuery = "exec addStadium '"+ stadiumName +"', '"+ stadiumLocation +"', "+ stadiumCapacity +"";
            SqlCommand addStadiumCMD = new SqlCommand(addStadiumQuery, db.con);
            SqlDataReader addStadiumReader = addStadiumCMD.ExecuteReader();
            addStadiumReader.Close();
        }
    }
}