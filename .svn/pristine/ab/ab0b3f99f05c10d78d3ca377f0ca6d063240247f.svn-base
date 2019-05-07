package com.chinacreator.iWebOffice2009;

import com.chinacreator.business.common.tools.CacheCommonManageProxy;
import com.chinacreator.epp.util.EgpManager;
import com.frameworkset.common.poolman.DBUtil;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import org.apache.log4j.Logger;

public class iDBManager2000
{
  private static final Logger logger = Logger.getLogger(iDBManager2000.class.getName());
  public String ClassString = null;
  public String ConnectionString = null;
  public String UserName = null;
  public String PassWord = null;
  private String dbName = null;
  public Connection Conn;
  public Statement Stmt;

  public iDBManager2000()
  {
    this.ClassString = "oracle.jdbc.driver.OracleDriver";
    this.ConnectionString = CacheCommonManageProxy.getSystemParam("url");
    this.UserName = CacheCommonManageProxy.getSystemParam("userName");
    this.PassWord = CacheCommonManageProxy.getSystemParam("passWord");
  }

  public iDBManager2000(String dbName)
  {
    this.dbName = dbName;
  }

  public boolean OpenConnection()
  {
    try {
      String dbName = this.dbName;
      if ((dbName == null) || ("".equals(dbName))) {
        dbName = EgpManager.getAppDBName();
      }
      this.Conn = DBUtil.getConection(dbName);
      this.Stmt = this.Conn.createStatement();
      return true;
    }
    catch (SQLException e) {
      if (this.Conn != null) {
        try {
          this.Conn.close();
        } catch (SQLException localSQLException1) {
        }
        this.Conn = null;
      }
      e.printStackTrace();
    }return false;
  }

  public void CloseConnection()
  {
    if (this.Stmt != null) {
      try {
        this.Stmt.close();
      }
      catch (SQLException e) {
        logger.info("关闭stmt对象出错！");
        e.printStackTrace();
      }
      this.Stmt = null;
    }
    if (this.Conn != null) {
      try {
        this.Conn.close();
      }
      catch (SQLException e1) {
        logger.info("关闭Conn对象出错！");
        e1.printStackTrace();
      }
      this.Conn = null;
    }
  }

  public String GetDateTime()
  {
    Calendar cal = Calendar.getInstance();
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String mDateTime = formatter.format(cal.getTime());
    return mDateTime;
  }

  public Date GetDate()
  {
    Calendar cal = Calendar.getInstance();
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    String mDateTime = formatter.format(cal.getTime());
    return Date.valueOf(mDateTime);
  }

  public int GetMaxID(String vTableName, String vFieldName)
  {
    int mResult = 0;
    String mSql = new String();
    iDBManager2000 DbaObj = new iDBManager2000();
    mSql = "select max(" + vFieldName + ")+1 as MaxID from " + vTableName;
    if (DbaObj.OpenConnection())
    {
      try
      {
        ResultSet result = DbaObj.ExecuteQuery(mSql);
        if (result.next())
        {
          mResult = result.getInt("MaxID");
        }
        if (mResult == 0) mResult = 1;

        result.close();
      }
      catch (Exception e)
      {
        logger.info(e.toString());
      }
      DbaObj.CloseConnection();
    }
    return mResult;
  }

  public ResultSet ExecuteQuery(String SqlString)
  {
    ResultSet result = null;
    try
    {
      result = this.Stmt.executeQuery(SqlString);
    }
    catch (Exception e)
    {
      logger.info(e.toString());
    }
    return result;
  }

  public int ExecuteUpdate(String SqlString)
  {
    int result = 0;
    try
    {
      result = this.Stmt.executeUpdate(SqlString);
    }
    catch (Exception e)
    {
      logger.info(e.toString());
    }
    return result;
  }
}