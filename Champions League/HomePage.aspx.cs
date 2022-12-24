using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Xceed.Wpf.Toolkit;

namespace Champions_League
{
    //class db
    //{
    //    public static SqlConnection con = new SqlConnection("Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=ehnaawi;Integrated Security=True");
    //    public static SqlCommand cmd = new SqlCommand("", con);
    //    public static string sqlQuery;

    //    public static void openConnection()
    //    {
    //        try
    //        {
    //            if (con.State == ConnectionState.Closed)
    //            {
    //                con.Open();
    //                //MessageBox.Show("Connection Successful and it's: " + con.State.ToString());
    //            }
    //        }
    //        catch (Exception ex)
    //        {
    //            //MessageBox.Show("Open Connection Failed: " + ex);

    //        }
    //    }

    //    public static void closeConnection()
    //    {
    //        try
    //        {
    //            if (con.State == ConnectionState.Open)
    //            {
    //                con.Close();
    //                //MessageBox.Show("Connection Successful and it's: " + con.State.ToString());
    //            }
    //        }
    //        catch (Exception ex)
    //        {
    //            //MessageBox.Show("Close Connection Failed: " + ex);

    //        }
    //    }

    //}
    public partial class homePage : basePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            db.openConnection();
        }

        public void loginButton_Click(object sender, EventArgs e)
        {


            public static string username = usernameTextBox;
            string loginQuery = "select su.username, su.systemUserPassword" +
            " from systemUser su" +
            " where su.username = " + username + " and su.password = " + password;

            string registerQuery = "exec addAssociationManager '" + username + "', '" + username + "', '" + password + "';";

        }

        internal void show()
        {
            throw new NotImplementedException();
        }

    }
}