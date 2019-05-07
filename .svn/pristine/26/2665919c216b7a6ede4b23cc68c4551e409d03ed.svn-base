package com.chinacreator.xtbg.core.common.util;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *<p>Title:DbConnection.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-18
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
	*<b>Summary: </b>
	* getOracleConnection(获取oracle数据库连接)
	* @param url
	* @param user
	* @param password
	* @return
	* @throws Throwable
	 */
	public Connection getOracleConnection(String url, String user, String password) throws Throwable{
		Connection conn = null;
		if(loadDriver(ORACLE_DRIVER_CLASS)){
			conn = DriverManager.getConnection(url, user, password);
		}		
		return conn;
	}
	
	/**
	*<b>Summary: </b>
	* getSqlserver2000Connection(获取sqlserver2000数据库连接)
	* @param url
	* @param user
	* @param password
	* @return
	* @throws Throwable
	 */
	public Connection getSqlserver2000Connection(String url, String user, String password) throws Throwable{
		Connection conn = null;
		if(loadDriver(DRIVER_CLASS)){
			conn = DriverManager.getConnection(url, user, password);
		}		
		return conn;
	}
	
	/**
	*<b>Summary: </b>
	* getMySqlConnection(获取mysql数据库连接)
	* @param url
	* @param user
	* @param password
	* @return
	* @throws Throwable
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
