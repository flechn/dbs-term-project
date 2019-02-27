using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

// 新增的命名空间
using System.Data.Odbc;

namespace takeawayDB
{
    public partial class StoreMsg : Form
    {
        COdbcOper dbOper = new COdbcOper();
        OdbcConnection DbCon = null;
        OdbcCommandBuilder ocb;
        string strOdbcCon, Uid;

        public StoreMsg(OdbcConnection dbCon, string strOdbcConn, string U)
        {
            DbCon = dbCon;
            strOdbcCon = strOdbcConn;
            Uid = U;  // 此处功能是将Uid,Dbcon,strOdbcCon等传进来
            InitializeComponent();
        }

        DataSet ds = new DataSet();
        OdbcDataAdapter oda;

        public void label1_Click(object sender, EventArgs e)
        {

        }

        public void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        public void label2_Click(object sender, EventArgs e)
        {

        }

        public void label4_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            oda.Update(ds,"takeawayDB");
            ds.Tables[0].AcceptChanges();
            MessageBox.Show("保存成功", "Success");
        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void StoreMsg_Load(object sender, EventArgs e)
        {
            
            ds = new DataSet();
            string getStoreMsg = string.Format("SELECT Sname 店名, Mname 店主名, Maddr 地址, Mtel 联系方式, Mtime 营业时间, Mcont 经营内容 FROM merchant WHERE Mno='{0}';", Uid);
            oda = new OdbcDataAdapter(getStoreMsg, DbCon);
            ocb = new OdbcCommandBuilder(oda);
            oda.Fill(ds, "takeawayDB");
            dataGridView1.DataSource = ds.Tables["takeawayDB"];
            ds.Dispose(); // 显示数据
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
