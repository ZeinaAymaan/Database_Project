using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Champions_League
{
    public partial class SystemAdminPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void TextBox3_TextChanged(object sender, EventArgs e)
        {

        }

        internal void show()
        {
            throw new NotImplementedException();
        }

        protected void clubnametextBox_TextChanged(object sender, EventArgs e)
        {
            string clubName = clubnametextBox.Text;
        }
    }
}