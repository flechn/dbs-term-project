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
    public partial class Main : Form
    {
        COdbcOper dbOper = new COdbcOper(); // 新建对象,用dbOper调用COdbcOper中函数
        string Uid, Pwd, strOdbcCon; // 为登录后记录Uid, Pwd（line 33）的值作准备
        OdbcConnection DbCon = null; // 为登录后记录DbCon（line 35）作准备
        DataSet ds; // 为后面数据的查询等操作作准备（line 64等）

        public Main(string U, string P, OdbcConnection dbCon)
        {
            Uid = U; // 即用户名
            Pwd = P; // 密码，可不传
            DbCon = dbCon; // 此处功能是将Uid,Pwd,Dbcon,strOdbcCon等传进来
            strOdbcCon = string.Format(@"DSN=takeawayDB;Uid={0};Pwd={1};", Uid, Pwd);
            InitializeComponent();
        }

        private void 店铺信息ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            StoreMsg f3 = new StoreMsg(DbCon, strOdbcCon, Uid); // 转到新窗口StoreMsg实现
            f3.Show();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            // 显示数据
        }

        private void 退出系统ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void 断开数据库ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DbCon.Close();
            MessageBox.Show("断开成功", "成功");
        }

        private void 商品管理ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            GoodsMana f5 = new GoodsMana(DbCon, strOdbcCon, Uid); // 转到新窗口GoodsMana实现
            f5.Show();
        }

        private void 订单管理ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            OrderMana f4 = new OrderMana(DbCon, strOdbcCon, Uid); // 转到新窗口OrderMana实现
            f4.Show();
        }


        private void pictureBox1_Click(object sender, EventArgs e)
        {

        }

        private void 连接数据库ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DbCon.Open();
            if (DbCon != null) MessageBox.Show("连接成功", "成功");
        }

        private void 关于ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MessageBox.Show("外卖平台商家端V1.0\nCopyright 2018 丑团外卖", "关于");
        }
    }
}
