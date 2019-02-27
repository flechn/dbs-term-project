using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

using System.Data.SqlClient;

//新增命名空间
using System.Data.Odbc;

namespace takeawayDB
{

    public partial class Login : Form
    {
       // OdbcConnection DbCon = null;
        COdbcOper dbOper = new COdbcOper();

        public Login()
        {
            InitializeComponent();
        }

        private void Login_Load(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {

        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        public void button1_Click(object sender, EventArgs e)
        {
            string Uid = this.textBox1.Text;
            string Pwd = this.textBox2.Text;
            if (Uid == "" || Pwd == "") {
                MessageBox.Show("账号密码不能为空");
                this.textBox2.Focus();
                this.textBox1.Focus();
            }
            else if (dbOper.ConnDb(Uid, Pwd) == true) this.Hide();
        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
