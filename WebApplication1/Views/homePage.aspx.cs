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
            string loginQuery = "select su.username, su.systemUserPassword\r\nfrom systemUser su\r\nwhere username = " + username + " and systemUserPassword = " + password + ";";
            

            try
            {
                SqlCommand loginCMD = new SqlCommand(loginQuery, db.con);
                //SqlDataReader loginDataReader = loginCMD.ExecuteReader();
                MessageBox.Show(loginCMD.ToString());
                if (loginCMD.ToString() == "")
                {
                    System.Windows.Forms.MessageBox.Show("Username or Password does not exist");
                    Console.WriteLine("null");
                    return;
                }
                else
                {
                    MessageBox.Show("username and password exists");
                    Console.WriteLine("done");
                }
            }
            catch (Exception)
            {
                MessageBox.Show("failed");

            }
        }
    }
}