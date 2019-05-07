package com.chinacreator.xtbg.core.common.util;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.transaction.UserTransaction;

import org.apache.log4j.Logger;

import com.frameworkset.common.poolman.DBUtil;
/**
 *<p>Title:DbconnManager.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2012-5-5
 */
public class DbManager {
	
	private static Logger LOG = Logger.getLogger(DbManager.class);

	private static DbManager instance = null;

	protected DbManager() {
	}

	public static DbManager getInstance() {
		synchronized (com.chinacreator.xtbg.core.common.util.DbManager.class) {
			if (instance == null) {
				instance = new com.chinacreator.xtbg.core.common.util.DbManager();
			}
		}
		return instance;
	}

	/**
	 * 获取非事物性连接
	 * 
	 * @return
	 * @throws java.sql.SQLException
	 */

	public Connection getConnection() throws SQLException{
		return this.getPoolManConnection();
	}

	/**
	 * 从poolman中取连接对象
	 * 
	 * @return Connection
	 * @throws SQLException
	 */

	public Connection getPoolManConnection() throws SQLException{
		Connection conn = null;
		conn = DBUtil.getConection();
		return conn;
	}
	

	/**
	 * 获取事务型数据库连接
	 * 
	 * @return Connection
	 * @throws SQLException 
	 */
	public Connection getTransactionConnection() throws SQLException{
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
			} catch (SQLException e) {
				LOG.error(e.getMessage(),e);
			}finally{
				try {
					DBUtil.closeConection(conn);
				} catch (SQLException e) {
					LOG.error(e.getMessage(),e);
				}
				conn = null;
			}
		}
	}
	
	/**
	*<b>Summary: </b>
	* rollBack(事务回滚)
	* @param conn
	 */
	public static void rollBackNoThrow(Connection conn){
		if (conn != null) {
			try {
				conn.rollback();
			} catch (SQLException e) {
				LOG.error(e.getMessage(),e);
			}
		}
	}

	/**
	 * 关闭非事务性数据库连接
	 * 
	 * @return Connection
	 */
	public static void closeConnection(Connection conn) {
		try {
			if (conn != null) {
				if (!conn.getAutoCommit()) {
					conn.commit();
					conn.setAutoCommit(true);
				}
			}
		} catch (SQLException e) {
			LOG.error(e.getMessage(),e);
		}finally{
			try {
				if(conn != null){
					DBUtil.closeConection(conn);
					//conn.close();
				}
			} catch (SQLException e) {
				LOG.error(e.getMessage(),e);
			}
			conn = null;
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
			LOG.error(e.getMessage(),e);
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
			LOG.error(e.getMessage(),e);
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
			LOG.error(e.getMessage(),e);
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
			LOG.error(e.getMessage(),e);
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
			LOG.error(e.getMessage(),e);
		}
	}
	
	/**
	 * 返回序列值
	 * 
	 * @param conn
	 *            Connection 数据库连接，可以为null
	 * @param sequence
	 *            String 数据库序列名称
	 * @return String
	 * @throws SQLException
	 */
	public String getSequence(Connection conn, String sequence)
			throws SQLException {
		boolean hasConn = false;
		PreparedStatement pstmt = null;
		ResultSet rst = null;
		try {
			if (conn == null) {
				conn = DbManager.getInstance().getConnection();
			} else {
				hasConn = true;
			}
			String sql = "select " + sequence + ".nextVal from dual";
			pstmt = conn.prepareStatement(sql);
			rst = pstmt.executeQuery();
			if (rst.next()) {
				return rst.getString(1);
			}
		} finally {
			closeObject(conn, pstmt, rst, hasConn);
		}
		return "0";
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* getSequences(获取序列的值，可以是多个序列，多个序列之间用,分隔)
	* @param conn	数据库连接
	* @param sequences	序列名称组合的字符串，多个序列之间用,分隔
	* @return
	* @throws SQLException
	 */
	public String[] getSequences(Connection conn, String sequences)
		throws SQLException {
		//返回的序列值的数组
		String[] valueArray = null;
		//如果序列名称组合的字符串不为空，则获取序列的值
		if(!StringUtil.isBlank(sequences)) {
			//将序列名称组合的字符串分隔成字符串数组
			String[] sequenceArray = sequences.split(",");
			boolean hasConn = false;
			PreparedStatement pstmt = null;
			ResultSet rst = null;
			try {
				if (conn == null) {
					//获取数据库连接
					conn = DbManager.getInstance().getConnection();
				} else {
					hasConn = true;
				}
				//拼接获取序列值的SQL语句
				StringBuffer sql = new StringBuffer();
				sql.append("select ");
				//循环序列名称数组
				for(int i=0,len=sequenceArray.length;i<len;i++) {
					if(!StringUtil.isBlank(sequenceArray[i])) {
						sql.append(sequenceArray[i]);
						sql.append(".nextVal");
						if(i != len-1) {
							sql.append("||','||");
						}
					}
				}
				sql.append(" from dual");
				//预编译SQL语句
				pstmt = conn.prepareStatement(sql.toString());
				//执行并返回结果
				rst = pstmt.executeQuery();
				//若有结果返回，则进行处理
				if (rst.next()) {
					//将返回的结果分隔成字符串数组
					valueArray = rst.getString(1).split(",");
				}
			} finally {
				//释放数据库连接等资源
				closeObject(conn, pstmt, rst, hasConn);
			}
		}
		return valueArray;
	}

	/**
	 * 释放资源
	 * 
	 * @param conn
	 *            Connection 数据库连接
	 * @param pstmt
	 *            PreparedStatement
	 * @param rst
	 *            ResultSet
	 * @param hasConn
	 *            boolean
	 */
	private void closeObject(Connection conn, PreparedStatement pstmt,
			ResultSet rst, boolean hasConn) {
	
		DbManager.closeResultSet(rst);
		DbManager.closePreparedStatement(pstmt);
		if (!hasConn) {
			DbManager.closeConnection(conn);
		}
	}
}
