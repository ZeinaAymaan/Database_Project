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
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            db.openConnection();
        }

        protected void registerSAMButton_Click(object sender, EventArgs e)
        {
            string name = SAMnameTextBox.Text;
            string username = SAMusernameTextBox2.Text;
            string password = SAMpasswordTextBox3.Text;

            if (name == "" || username == "" || password == "")
            {
                MessageBox.Show("Name, Username, and Password fields can't be empty");
                return;
            }

            if(name.Length > 20 || password.Length > 20 || username.Length > 20)
            {
                MessageBox.Show("Name, Username, and Password can't be more than 20 charactars");
                return ;
            }

            string checkUsernameValidQuery = "select username\r\nfrom systemUser\r\nwhere username = '"+ username +"'";
            SqlCommand checkUsernameValidCMD = new SqlCommand(checkUsernameValidQuery, db.con);
            SqlDataReader checkUsernameValidReader = checkUsernameValidCMD.ExecuteReader();
            while (checkUsernameValidReader.Read())
            {
                MessageBox.Show("Username invalid");
                checkUsernameValidReader.Close();
                return ;
            }
            checkUsernameValidReader.Close();

            string addSAMquery = "exec addAssociationManager '"+ name +"', '"+ username +"', '"+ password +"'";
            SqlCommand addSAMcmd = new SqlCommand(addSAMquery, db.con);
            SqlDataReader addSAMreader = addSAMcmd.ExecuteReader();
            addSAMreader.Close();
            MessageBox.Show("Sports Association Manager added successfully");
        }
    }
}