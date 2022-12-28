using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace WebApplication1.Views
{
    public partial class WebForm6 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            db.openConnection();
        }

        protected void RegisterFButton_Click(object sender, EventArgs e)
        {
            string Name = NameFTextBox.Text;
            string Username = UsernameFTextBox.Text;
            string Password = PasswordFTextBox.Text;
            string nationalID = NationalIDFTextBox.Text;
            string phoneNumber = PhoneNumberFTextBox.Text;
            string address = AddressFTextBox.Text;
            string birthDate = BirthDateFCalendar.SelectedDate.ToString("yyyy/MM/dd");


            if (nationalID == "" || Password == "" || Username == "" || Name == "" || phoneNumber == "" || address == "")
            {
                MessageBox.Show("Name, Username, Password, National ID, Address, Phone Number fields can't be empty");
                return;
            }
            
            if (Name.Length > 20 || Username.Length > 20 || Password.Length > 20 || address.Length > 20)
            {
                MessageBox.Show("Name, Username, Password, and Address can't be more than 20 charactars");
                return;
            }

            if (!Regex.IsMatch(nationalID, @"^\d+$") || !Regex.IsMatch(phoneNumber, @"^\d+$"))
            {
                MessageBox.Show("Only numbers accepted in National ID and Phone Number");
                return;
            }

            if (nationalID.Length != 14)
            {
                MessageBox.Show("Invalid National ID");
                return ;
            }

            //check for date

            int now = int.Parse(DateTime.Now.ToString("yyyyMMdd"));
            int dob = int.Parse(BirthDateFCalendar.SelectedDate.ToString("yyyyMMdd"));
            int age = (now - dob);

            if (age < 160000)
            {
                MessageBox.Show("Age less than 16 ");
                return ;
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

            string addFanQuery = "exec addFan '"+ Name +"', '"+ Username +"', '"+ Password +"', '"+ nationalID +"', '"+ birthDate +"', '"+ address +"', " + phoneNumber;
            SqlCommand addFanCMD = new SqlCommand(addFanQuery, db.con);
            SqlDataReader addFanReader = addFanCMD.ExecuteReader();
            addFanReader.Close();
            MessageBox.Show("Fan added successfully");
        }
    }
}