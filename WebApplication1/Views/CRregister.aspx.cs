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
            string ClubName = ClubNameDropDownList.Text;

            if (Password == "" || Username == "" || Name == "" || ClubName == "Select")
            {
                MessageBox.Show("Name, Username, Password, Club Name fields can't be empty");
                return;
            }

            if (Name.Length > 20 || Username.Length > 20 || Password.Length > 20)
            {
                MessageBox.Show("Name, Username, and Password can't be more than 20 charactars");
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

            string checkClubWithoutRepresentative = "SELECT c.clubName, cr.club_ID FROM Club AS c LEFT OUTER JOIN clubRepresentative AS cr ON c.ID = cr.club_ID WHERE (cr.club_ID IS NULL)";
            SqlCommand checkClubWithoutRepresentativeCMD = new SqlCommand(checkClubWithoutRepresentative, db.con);
            SqlDataReader checkClubWithoutRepresentativeReader = checkClubWithoutRepresentativeCMD.ExecuteReader();
            bool flag = false;
            while (checkClubWithoutRepresentativeReader.Read())
            {
                if(ClubName == checkClubWithoutRepresentativeReader["clubName"].ToString()) flag = true;
            }
            checkClubWithoutRepresentativeReader.Close();
            if (!flag)
            {
                MessageBox.Show("Club already has a Representative");
                return;
            }

            string addClubRepresentativeQuery = "exec addRepresentative '"+ Name +"', '"+ ClubName +"', '"+ Username +"', '"+ Password +"'";
            SqlCommand addClubRepresentativeCMD = new SqlCommand(addClubRepresentativeQuery, db.con);
            SqlDataReader addClubRepresentativeReader = addClubRepresentativeCMD.ExecuteReader();
            addClubRepresentativeReader.Close();
            MessageBox.Show("Club Representative added successfully");
        }
    }
}