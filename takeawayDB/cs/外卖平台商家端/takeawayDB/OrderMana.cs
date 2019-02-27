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
    public partial class OrderMana : Form
    {
        COdbcOper dbOper = new COdbcOper();
        OdbcConnection DbCon = null;
        OdbcCommandBuilder ocb;
        string strOdbcCon, Uid;

        public OrderMana(OdbcConnection dbCon, string strOdbcConn, string U)
        {
            Uid = U;
            DbCon = dbCon;
            strOdbcCon = strOdbcConn; // 此处功能是将Uid,Dbcon,strOdbcCon等传进来
            InitializeComponent();
        }

        DataSet ds = new DataSet();
        OdbcDataAdapter oda;

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void label5_Click(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void OrderMana_Load(object sender, EventArgs e)
        {
            ds = new DataSet();
            string getOrder = string.Format("SELECT Tno 订单号, Cno 顾客号, Dno 骑手号, Gno 商品号, Ttime 下单时间, Tstat 订单状态 FROM Torder WHERE Mno='{0}';", Uid);
            oda = new OdbcDataAdapter(getOrder, DbCon);
            ocb = new OdbcCommandBuilder(oda);
            oda.Fill(ds, "takeawayDB");
            dataGridView1.DataSource = ds.Tables["takeawayDB"];
            ds.Dispose(); // 显示数据
        }

        private void load()
        {
            ds = new DataSet();
            string getOrder = string.Format("SELECT Tno 订单号, Cno 顾客号, Dno 骑手号, Gno 商品号, Ttime 下单时间, Tstat 订单状态 FROM Torder WHERE Mno='{0}';", Uid);
            oda = new OdbcDataAdapter(getOrder, DbCon);
            ocb = new OdbcCommandBuilder(oda);
            oda.Fill(ds, "takeawayDB");
            dataGridView1.DataSource = ds.Tables["takeawayDB"];
            ds.Dispose(); // 显示数据
        }

        private void button2_Click(object sender, EventArgs e)
        {
            oda.Update(ds, "takeawayDB");
            ds.Tables[0].AcceptChanges();
            MessageBox.Show("保存成功", "Success");
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string Cno = this.textBox1.Text;
            string Dno = this.textBox2.Text;
            string Gno = this.textBox3.Text;
            string Ttime = this.textBox4.Text;
            string Tstate = this.textBox5.Text;
            string Mno = Uid; // 商家号自动填写，商家无法进行修改
            string Tno = Cno + Ttime; // 订单号生成逻辑，与时间结合，保证无重复
            // 时间可考虑从系统直接获取，目前暂未实现【Optional!!】

            try
            {
                string temp = string.Format("INSERT INTO Torder VALUES('{0}','{1}','{2}','{3}','{4}','{5}','{6}');", Tno, Mno, Cno, Dno, Gno, Ttime, Tstate);
                OdbcCommand oCmd = new OdbcCommand(temp, DbCon);
                oCmd.ExecuteNonQuery();
                MessageBox.Show("数据插入成功 ", "成功");
                load();
            }
            catch (Exception es) // 查明原因，与函数定义中EventArgs e重名了！
            {
                MessageBox.Show("删除数据错误! " + es.ToString(), "错误");
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            MessageBox.Show("确认删除吗？", "删除确认", MessageBoxButtons.OKCancel, MessageBoxIcon.Asterisk);
            int index = 0;//dataGridView1中ID列的索引
            string temp = string.Format("DELETE Torder where TNO='{0}'", dataGridView1[index, dataGridView1.SelectedCells[0].RowIndex].Value);
            OdbcCommand oCmd = new OdbcCommand(temp, DbCon);
            oCmd.ExecuteNonQuery();
            MessageBox.Show("数据删除成功 ", "成功");
            load();
        }
    }
}