using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Xceed.Wpf.AvalonDock.Layout;

namespace Champions_League
{
    class db
    {
        public static SqlConnection con = new SqlConnection("Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=ehnaawi;Integrated Security=True");
        public static SqlCommand cmd = new SqlCommand("", con);
        public static string sqlQuery;

        public static void openConnection()
        {
            try
            {
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                    //MessageBox.Show("Connection Successful and it's: " + con.State.ToString());
                }
            }
            catch (Exception ex)
            {
                //MessageBox.Show("Open Connection Failed: " + ex);

            }
        }

        public static void closeConnection()
        {
            try
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                    //MessageBox.Show("Connection Successful and it's: " + con.State.ToString());
                }
            }
            catch (Exception ex)
            {
                //MessageBox.Show("Close Connection Failed: " + ex);

            }
        }

        //homePage homePage = new homePage();
        

    }
    public partial class basePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            //homePage home = new homePage();
           // home.show();
            //home.loginButton_Click();
            
            SystemAdminPage systemAdminPage = new SystemAdminPage();
            //systemAdminPage.show();
        }
    }
}