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
    public partial class GoodsMana : Form
    {
        COdbcOper dbOper = new COdbcOper();
        OdbcConnection DbCon = null;
        OdbcCommandBuilder ocb;
        string strOdbcCon, Uid;

        public GoodsMana(OdbcConnection dbCon, string strOdbcConn, string U)
        {
            Uid = U;
            DbCon = dbCon;
            strOdbcCon = strOdbcConn;// 此处功能是将Uid,Dbcon,strOdbcCon等传进来
            InitializeComponent();
        }

        DataSet ds = new DataSet();
        OdbcDataAdapter oda;

        private void GoodsMana_Load(object sender, EventArgs e)
        {
            ds = new DataSet();
            string getgoods = string.Format("SELECT Mno, Gno 商品号, Gname 商品名, Gprice 商品价格 FROM goods WHERE Mno='{0}';", Uid);
            oda = new OdbcDataAdapter(getgoods, DbCon);
            ocb = new OdbcCommandBuilder(oda);
            oda.Fill(ds, "takeawayDB");
            dataGridView1.DataSource = ds.Tables["takeawayDB"];
            dataGridView1.Columns[0].Visible = false;
            ds.Dispose(); // 显示数据
        }

        private void load()
        {
            ds = new DataSet();
            string getgoods = string.Format("SELECT Mno, Gno 商品号, Gname 商品名, Gprice 商品价格 FROM goods WHERE Mno='{0}';", Uid);
            oda = new OdbcDataAdapter(getgoods, DbCon);
            ocb = new OdbcCommandBuilder(oda);
            oda.Fill(ds, "takeawayDB");
            dataGridView1.DataSource = ds.Tables["takeawayDB"];
            dataGridView1.Columns[0].Visible = false; // 不对商家显示商家号，对更新操作有帮助
            ds.Dispose(); // 显示数据
        }

        private void button2_Click(object sender, EventArgs e)
        {
            oda.Update(ds, "takeawayDB");
            ds.Tables[0].AcceptChanges();
            MessageBox.Show("保存成功", "Success");
        }

        private void button3_Click(object sender, EventArgs e)
        {
            MessageBox.Show("确认删除吗？", "删除确认", MessageBoxButtons.OKCancel, MessageBoxIcon.Asterisk);
            int index = 0;//dataGridView1中ID列的索引
            string temp = string.Format("DELETE goods where Gno='{0}'", dataGridView1[index, dataGridView1.SelectedCells[0].RowIndex].Value);
            OdbcCommand oCmd = new OdbcCommand(temp, DbCon);
            oCmd.ExecuteNonQuery();
            MessageBox.Show("数据删除成功 ", "成功");
            load();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            string Gno = this.textBox1.Text;
            string Gname = this.textBox2.Text;
            string Gprice = this.textBox3.Text;

            try
            {
                string temp = string.Format("INSERT INTO goods VALUES('{0}','{1}','{2}','{3}');", Gno, Uid, Gname, Gprice);
                OdbcCommand oCmd = new OdbcCommand(temp, DbCon);
                oCmd.ExecuteNonQuery();
                MessageBox.Show("数据插入成功 ", "成功");
                load();
            }
            catch (Exception es) // 查明原因，与函数定义中EventArgs e重名！先前写的都没有try和catch
            {
                MessageBox.Show("删除数据错误! " + es.ToString(), "错误");
            }
        }

    }
}
