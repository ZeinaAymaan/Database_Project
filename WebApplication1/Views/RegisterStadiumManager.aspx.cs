using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace WebApplication1.Views
{
    public partial class WebForm5 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            db.openConnection();
        }

        protected void RegisterSMButton_Click(object sender, EventArgs e)
        {
            string Name = NameSMTextBox.Text;
            string Username = UsernameSMTextBox.Text;
            string Password = PasswordSMTextBox.Text;
            string stadiumName = StadiumNameDropDownList.Text;

            if (stadiumName == "" || Password == "" || Username == "" || Name == "")
            {
                MessageBox.Show("Name, Username, Password, Stadium Name fields can't be empty");
                return;
            }

            if (Name.Length > 20 || Username.Length > 20 || Password.Length > 20 || stadiumName.Length > 20)
            {
                MessageBox.Show("Name, Username, Password, and Stadium Name can't be more than 20 charactars");
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

            string checkStadiumWithoutRepresentative = "SELECT c.StadiumName, cr.Stadium_ID FROM Stadium AS c LEFT OUTER JOIN stadiumManager AS cr ON c.ID = cr.Stadium_ID WHERE (cr.Stadium_ID IS NULL)";
            SqlCommand checkStadiumWithoutRepresentativeCMD = new SqlCommand(checkStadiumWithoutRepresentative, db.con);
            SqlDataReader checkStadiumWithoutRepresentativeReader = checkStadiumWithoutRepresentativeCMD.ExecuteReader();
            bool flag = false;
            while (checkStadiumWithoutRepresentativeReader.Read())
            {
                if (stadiumName == checkStadiumWithoutRepresentativeReader["StadiumName"].ToString()) flag = true;
            }
            checkStadiumWithoutRepresentativeReader.Close();
            if (!flag)
            {
                MessageBox.Show("Stadium already has a Manager");
                return;
            }

            string addStadiumManagerQuery = "exec addStadiumManager '" + Name + "', '" + stadiumName + "', '" + Username + "', '" + Password + "'";
            SqlCommand addStadiumManagerCMD = new SqlCommand(addStadiumManagerQuery, db.con);
            SqlDataReader addStadiumManagerReader = addStadiumManagerCMD.ExecuteReader();
            addStadiumManagerReader.Close();
            MessageBox.Show("Stadium Manager added successfully");
        }
    }
}