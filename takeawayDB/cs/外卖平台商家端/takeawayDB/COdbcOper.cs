using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//新增命名空间
using System.Data;
using System.Data.Odbc;
using System.Windows.Forms;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Data.Common;

/* 
 * 由于时间问题，可能有较多函数未能整合到此类中
 * 而是在诸如OrderMana等直接进行实现
 * 此处有部分函数是以前遗留下来的操作
 * 均能正常执行
 */

namespace takeawayDB
{
    class COdbcOper
    {
        public OdbcConnection DbCon = null;
        string Uid, Pwd, strOdbcCon;
        //登录
        public bool ConnDb(string U,string P)
        {
            Uid = U;
            Pwd = P;
            OdbcConnection DbCon = null;
            strOdbcCon = string.Format(@"DSN=takeawayDB;Uid={0};Pwd={1};", Uid, Pwd);
            DbCon = new OdbcConnection(strOdbcCon);

            if (DbCon == null)
            {
                MessageBox.Show("输入有误！请检查用户名或密码！");
                return false;
            }
            else
            {
                MessageBox.Show("登录成功 ", "成功");
                Main form2 = new Main(Uid,Pwd,DbCon); // 转到主窗体
                form2.Show();
                return true;
            }
        }

        //断开数据库
        public void DisconDb()
        {
            if (DbCon == null)
                return;
            DbCon.Close(); // 【Attention!!!】暂未实现
        }
       
    }
}
