using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;



namespace WebApplication1.Views
{

    class db
    {
        public static SqlConnection con = new SqlConnection("Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=ehnaawi;Integrated Security=True");
        //public static SqlCommand loginCMD = new SqlCommand();

        public static void openConnection()
        {
            try
            {
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                    MessageBox.Show("opened connection successfully");
                }
            }
            catch (Exception ex)
            {

                MessageBox.Show("opening connection failed " + ex);
            }
          
        }

        public static void closeConnection()
        {
            try
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                    MessageBox.Show("closed connection successfully");
                }
            }
            catch (Exception ex)
            {

                MessageBox.Show("closing connection failed " + ex);
            }
        }
    }

    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            db.openConnection();
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {

            string username = UsernameTextBox.Text;
            string password = PasswordTextBox.Text;

            string loginQuery = "select su.username, su.systemUserPassword\r\nfrom systemUser su\r\nwhere username = '" + username + "' and systemUserPassword = '" + password + "';";
            string systemAdminLogin = "select sa.systemAdminUsername\r\nfrom systemAdmin sa\r\nwhere sa.systemAdminUsername = '"+ username +"';";
            string sportsAssocitionManagerLogin = "select sam.sportsAssociationManagerUsername\r\nfrom sportsAssociationManager sam\r\nwhere sam.sportsAssociationManagerUsername = '"+ username +"';";
            string stadiumManagerLogin = "select sm.stadiumManagerUsername\r\nfrom stadiumManager sm\r\nwhere sm.stadiumManagerUsername = '"+ username +"';";
            string clubRepresentativeLogin = "select cr.Username\r\nfrom clubRepresentative cr\r\nwhere cr.Username = '"+ username +"';";
            string fanLogin = "select username\r\nfrom fan \r\nwhere username = '"+ username +"';";
            
            string usernameReader = "";

            SqlCommand loginCMD = new SqlCommand(loginQuery, db.con);
            SqlCommand systemAdminCMD = new SqlCommand(systemAdminLogin, db.con);
            SqlCommand sportsAssociationManagerCMD = new SqlCommand(sportsAssocitionManagerLogin, db.con);
            SqlCommand stadiumManagerCMD =  new SqlCommand(stadiumManagerLogin, db.con);
            SqlCommand clubRepresentativeCMD = new SqlCommand(clubRepresentativeLogin, db.con);
            SqlCommand fanCMD = new SqlCommand(fanLogin, db.con);

            SqlDataReader loginReader = loginCMD.ExecuteReader();

            while (loginReader.Read())
            {
                usernameReader = loginReader["username"].ToString();
            }

            loginReader.Close();


            //ig it's easier done with cases
            //they all need while loops

            if (usernameReader == "") MessageBox.Show("username or password doesn't exist");
            else
            {
                SqlDataReader systemAdminReader = systemAdminCMD.ExecuteReader();
                while (systemAdminReader.Read())
                {
                    if (usernameReader == systemAdminReader["systemAdminUsername"].ToString())
                    {
                        MessageBox.Show("system admin");
                        return;
                        
                    }
                }
                systemAdminReader.Close();

                SqlDataReader sportsAssociationManagerReader = sportsAssociationManagerCMD.ExecuteReader();
                while (sportsAssociationManagerReader.Read())
                {
                    if (usernameReader == sportsAssociationManagerReader["sportsAssociationManagerUsername"].ToString())
                    {
                        MessageBox.Show("sports association manager");
                        return ;
                    }
                }
                sportsAssociationManagerReader.Close();

                SqlDataReader stadiumManagerReader = stadiumManagerCMD.ExecuteReader();
                while (stadiumManagerReader.Read())
                {
                    if (usernameReader == stadiumManagerReader["stadiumManagerUsername"].ToString())
                    {
                        MessageBox.Show("stadium manager");
                        return;
                    }
                }
                stadiumManagerReader.Close();

                SqlDataReader clubRepresentativeReader = clubRepresentativeCMD.ExecuteReader();
                while (clubRepresentativeReader.Read())
                {
                    if (usernameReader == clubRepresentativeReader["Username"].ToString())
                    {
                        MessageBox.Show("club representative");
                        return;
                    }

                }
                clubRepresentativeReader.Close();

                SqlDataReader fanReader = fanCMD.ExecuteReader();
                while (fanReader.Read())
                {
                    if (usernameReader == fanReader["username"].ToString())
                    {
                        MessageBox.Show("fan");
                        return;
                    }

                }
                fanReader.Close();
            }   

        }


    }
}