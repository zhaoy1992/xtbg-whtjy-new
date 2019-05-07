package com.chinacreator.xtbg.pub.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *<p>Title:</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author Creator
 *@version 3.0
 *@date 2008-1-06
 */
public class DbConnection {
	
	private static DbConnection instance = null;
	
	private static final String DRIVER_CLASS = "net.sourceforge.jtds.jdbc.Driver";
	
	private static final String ORACLE_DRIVER_CLASS = "oracle.jdbc.driver.OracleDriver";
	
	private static final String MYSQL_DRIVER_CLASS = "com.mysql.jdbc.Driver";
	
	protected DbConnection(){
		
	}
	
	public static DbConnection getInstrance(){		
			synchronized(DbConnection.class){
				if(instance == null){
					instance = new DbConnection();
				}
			}
		return instance;
	}
	
	/**
	 * 获取oracle数据库连接
	 * @param url
	 * @param user
	 * @param password
	 * @return
	 * @throws Throwable
	 */
	public Connection getOracleTargetConnection(String url, String user, String password) throws Throwable{
		Connection conn = null;
		if(loadDriver(ORACLE_DRIVER_CLASS)){
			conn = DriverManager.getConnection(url, user, password);
		}		
		return conn;
	}
	
	/**
	 * 获取sqlserver2000数据库连接
	 * @param url
	 * @param user
	 * @param password
	 * @return
	 * @throws Throwable 
	 */
	public Connection getTargetConnection(String url, String user, String password) throws Throwable{
		Connection conn = null;
		if(loadDriver(DRIVER_CLASS)){
			conn = DriverManager.getConnection(url, user, password);
		}		
		return conn;
	}
	
	/**
	 * 获取mysql数据库连接
	 * @param url
	 * @param user
	 * @param password
	 * @return
	 * @throws Throwable 
	 * @throws SQLException 
	 */
	public Connection getMySqlConnection(String url, String user, String password) throws Throwable{
		Connection conn = null;
		if(loadDriver(MYSQL_DRIVER_CLASS)){
			conn = DriverManager.getConnection(url, user, password);
		}		
		return conn;
	}
	
	private boolean loadDriver(String driverClassName) throws Throwable {
        try {
            Class.forName(driverClassName).newInstance();
            return true;
        } catch (ClassNotFoundException e) {
            throw e;

        } catch (IllegalAccessException e) {
            return true;

        } catch (InstantiationException e) {
        	throw e;
        } catch (Throwable e) {
        	throw e;
        }
    } 
}
