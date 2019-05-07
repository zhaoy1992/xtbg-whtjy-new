package com.chinacreator.xtbg.pub.util;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import javax.transaction.UserTransaction;
import org.apache.log4j.Logger;

import com.frameworkset.common.poolman.DBUtil;

/**
 *<p>Title:DbconnManager.java</p>
 *<p>Description:连接对象类</p>
 *<p>Copyright:Copyright (c) 2011 </p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-2-1
 */
public class DbconnManager {

	private static final Logger LOG = Logger.getLogger(DbconnManager.class);

	private static final String datacent = "jdbc/xtbg";
	
	private static DbconnManager instance = null;

	protected DbconnManager() {
	}

	public static DbconnManager getInstance() {
		if (instance == null) {
			synchronized (DbconnManager.class) {
				if (instance == null) {
					instance = new DbconnManager();
				}
			}
		}
		return instance;
	}

	/**
	 * 获取非事物性连接
	 * 
	 * @return
	 * @throws SQLException
	 */

	public Connection getConnection() throws SQLException {
		return this.getPoolManConnection();
	}

	/**
	 * 获取JNDI连接
	 * 
	 * @param jndi
	 * @return
	 * @throws SQLException
	 */
	public Connection getJndiConnection(String jndi) throws SQLException {
		 Connection conn = null;
		 try {
			 InitialContext context = new InitialContext();
			 Context envContext = (Context) context.lookup("java:comp/env");
			 DataSource ds = (DataSource) envContext.lookup(datacent);
			 conn = ds.getConnection();
			 conn.setAutoCommit(false);
		 } catch (Exception e) {
			 LOG.error(e);
		 }
		 return conn;
	}
	
	/**
	 * 从poolman中取连接对象
	 * 
	 * @return Connection
	 * @throws SQLException
	 */

	public Connection getPoolManConnection() throws SQLException {
		
		Connection conn = null;
		try {
			conn = DBUtil.getConection();
		} catch (Exception e) {
			 LOG.error(e);
		}
		return conn;
	}
	
	/**
	 * 获取事务型数据库连接
	 * 
	 * @return Connection
	 */
	public Connection getTransactionConnection() throws SQLException {
		Connection conn = this.getPoolManConnection(); 
		conn.setAutoCommit(false);
		return conn;
	}

	/**
	 * 关闭事务型数据库连接
	 * 
	 * @return Connection
	 */
	public static void closeTransactionConnection(Connection conn,
			boolean abortTransaction) {
		// 判断数据源是否存在
		if (conn != null) {
			try {
				DatabaseMetaData metaData = conn.getMetaData();
				if (metaData.supportsTransactions()) {
					// 回滚/提交数据
					if (abortTransaction) {
						conn.commit();
					} else {
						conn.rollback();
					}
					conn.setAutoCommit(true);
				}
				conn.close();
				conn = null;
			} catch (SQLException e) {
				LOG.error(e);
			}
		}
	}

	/**
	 * 关闭非事务性数据库连接
	 * 
	 * @return Connection
	 */
	public static void closeConnection(Connection con) {
		try {
			if (con != null) {
				con.close();
				con = null;
			}
		} catch (SQLException e) {
			LOG.error(e);
		}
	}
	
	/**
	 * 事物回滚
	 * 
	 * @return Connection
	 */
	public static void rollback(Connection con) {
		try {
			if(con  != null){
				con.rollback();
			}
		} catch (SQLException e) {
			LOG.error(e);
		}
	}

	/**
	 * 关闭连接语句
	 * 
	 * @return Connection
	 */
	public static void closePreparedStatement(PreparedStatement pstmt) {
		try {
			if (pstmt != null) {
				pstmt.close();
			}
		} catch (SQLException e) {
			LOG.error(e);
		}
	}

	/**
	 * 关闭连接语句
	 * 
	 * @return Connection
	 */
	public static void closeStatement(Statement stmt) {
		try {
			if (stmt != null) {
				stmt.close();
			}
		} catch (SQLException e) {
			LOG.error(e);
		}
	}

	/**
	 * 关闭查询结果集
	 * 
	 * @return Connection
	 */
	public static void closeResultSet(ResultSet rst) {
		try {
			if (rst != null) {
				rst.close();
			}
		} catch (SQLException e) {
			LOG.error(e);
		}
	}

	/**
	 * 关闭所有对象（普通的数据库连接）
	 * 
	 * @return Connection
	 */
	public static void closeResource(Connection conn, PreparedStatement pstmt,
			ResultSet rst) {
		closeResultSet(rst);
		closePreparedStatement(pstmt);
		closeConnection(conn);
	}

	/**
	 * 关闭所有对象（普通的数据库连接）
	 * 
	 * @return Connection
	 */
	public static void closeResource(Connection conn, PreparedStatement pstmt) {
		closePreparedStatement(pstmt);
		closeConnection(conn);
	}

	/**
	 * 关闭所有对象（带事务的数据库连接）
	 * 
	 * @return Connection
	 */
	public static void closeResource(Connection conn, PreparedStatement pstmt,
			boolean bool) {
		closePreparedStatement(pstmt);
		closeTransactionConnection(conn, bool);
	}

	/**
	 * 关闭JTA控制事务
	 * 
	 * @return UserTransaction
	 */
	public static void closeUserTransaction(UserTransaction tx, boolean bool) {
		try {
			if (tx != null) {
				if (bool) {
					tx.rollback();
				} else {
					tx.commit();
				}
			}
		} catch (Exception e) {
			LOG.error(e);
		}
	}

	/**
	 * 关闭存储过程语句
	 * 
	 * @param callableStatement
	 *            CallableStatement
	 */
	public static void closeCallableStatement(
			CallableStatement callableStatement) {
		try {
			if (callableStatement != null) {
				callableStatement.close();
			}
		} catch (SQLException e) {
			LOG.error(e);
		}
	}

	final static String sDBDriver = "oracle.jdbc.driver.OracleDriver";

	final static String sConnStr = "jdbc:oracle:thin:@172.16.168.134:1521:gwcs";

	/**
	 * 通过thin方式获得Oracle数据库的连接.
	 */
	private Connection getConn() {
		Connection conn = null;
		try {
			Class.forName(sDBDriver);
			conn = DriverManager.getConnection(sConnStr, "xzsp", "xzsp");
		} catch (Exception e) {
			LOG.error(e);
		}
		return conn;
	}

}
