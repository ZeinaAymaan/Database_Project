using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;

namespace WebApplication1.Views
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            db.openConnection();
        }

        protected void RegisterCRButton_Click(object sender, EventArgs e)
        {
            string Name = NameCRTextBox.Text;
            string Username = UsernameCRTextBox.Text;
            string Password = PasswordCRTextBox.Text;
            string ClubName = ClubNameCRTextBox.Text;

            if (ClubName == "" || Password == "" || Username == "" || Name == "")
            {
                MessageBox.Show("Name, Username, Password, Club Name fields can't be empty");
                return;
            }

            if (Name.Length > 20 || Username.Length > 20 || Password.Length > 20 || ClubName.Length > 20)
            {
                MessageBox.Show("Name, Username, Password, and Club Name can't be more than 20 charactars");
                return;
            }

            string checkUsernameValidQuery = "select username\r\nfrom systemUser\r\nwhere username = '" + Username + "'";
            SqlCommand checkUsernameValidCMD = new SqlCommand(checkUsernameValidQuery, db.con);
            SqlDataReader checkUsernameValidReader = checkUsernameValidCMD.ExecuteReader();
            while (checkUsernameValidReader.Read())
            {
                MessageBox.Show("Username invalid");
                checkUsernameValidReader.Close();
                return;
            }
            checkUsernameValidReader.Close();

            string checkClubExistsQuery = "select clubName \r\nfrom Club\r\nwhere clubName = '" + ClubName + "';";
            SqlCommand checkClubExistsCMD = new SqlCommand(checkClubExistsQuery, db.con);
            SqlDataReader checkClubExistsReader = checkClubExistsCMD.ExecuteReader();
            while (!checkClubExistsReader.Read())
            {
                MessageBox.Show("Club doesn't exists");
                checkClubExistsReader.Close();
                return;
            }

            checkClubExistsReader.Close();
            string addClubQuery = "exec addRepresentative '"+ Name +"', '"+ ClubName +"', '"+ Username +"', '"+ Password +"'";
            SqlCommand addClubCMD = new SqlCommand(addClubQuery, db.con);
            SqlDataReader addClubReader = addClubCMD.ExecuteReader();
            addClubReader.Close();
            MessageBox.Show("Club Representative added successfully");
        }
    }
}