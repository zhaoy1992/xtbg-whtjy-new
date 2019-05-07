package com.chinacreator.xtbg.core.common.util;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.UUID;

import org.apache.log4j.Logger;

import com.frameworkset.common.poolman.DBUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>
 * Title:DaoUtil.java
 * </p>
 *<p>
 * Description:Dao工具类
 * </p>
 *<p>
 * Copyright:Copyright (c) 2011
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author yiping.huang
 *@version 1.0
 *@date 2011-7-6
 */

public class DaoUtil {

	private static final Logger LOG = Logger.getLogger(DaoUtil.class);

	/**
	 * 根据SQL返回一个某字段值
	 * 
	 * @param sqlStr
	 *            ,dbName数据源
	 * @return
	 * @throws Exception
	 */
	public static String sqlToField(String sql) throws SQLException {
		PreparedDBUtil preparedDBUtil = new PreparedDBUtil();
		String strR = "";
		try {
			preparedDBUtil.executeSelect(sql);
			if ((preparedDBUtil != null) && (preparedDBUtil.size() > 0)) {
				strR = preparedDBUtil.getString(0, 0);
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return strR;
	}

	public static String sqlToField(String sql,Connection conn) throws SQLException {
		PreparedDBUtil preparedDBUtil = new PreparedDBUtil();
		String strR = "";
		try {
			preparedDBUtil.executeSelect(sql,conn);
			if ((preparedDBUtil != null) && (preparedDBUtil.size() > 0)) {
				strR = preparedDBUtil.getString(0, 0);
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return strR;
	}
	/**
	 * 根据SQL返回一个某字段值
	 * 
	 * @param sqlStr
	 *            ,dbName数据源
	 * @return
	 * @throws Exception
	 */
	public static String updateSql(String sql) throws SQLException {
		PreparedDBUtil preparedDBUtil = new PreparedDBUtil();
		String strR = "";
		try {
			preparedDBUtil.executeUpdate(sql);
			if ((preparedDBUtil != null) && (preparedDBUtil.size() > 0)) {
				strR = preparedDBUtil.getString(0, 0);
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return strR;
	}

	/**
	 * 根据序列名称查询当前序列值
	 * 
	 * @param sequencsName
	 *            序列名称
	 * @return 序列数值
	 * @throws Exception
	 */
	public synchronized static String findBySequencsName(String sequencsName,
			Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select ").append(sequencsName).append(".nextval from dual");
		DBUtil db = new DBUtil();
		db.executeSelect(sql.toString(), conn);
		return db.getString(0, 0);
	}

	/**
	 * 获得UUID的值
	 * 
	 * @return uuid序列值
	 * @throws Exception
	 */
	public static String getUUID() {
		String uuid = UUID.randomUUID().toString();
		return uuid;
	}

	/**
	 * 根据SQL返回Stirng数组
	 * 
	 * @param sqlStr
	 *            ,dbName数据源
	 * @return
	 * @throws Exception
	 */
	public static String[][] sqlToFieldsArray(PreparedDBUtil preparedDBUtil)
			throws SQLException {
		String[][] results = null;
		int iSize = preparedDBUtil.getMeta().getColumnCount();
		results = new String[preparedDBUtil.size()][iSize];
		for (int j = 0; j < preparedDBUtil.size(); j++) {
			for (int i = 0; i < iSize; i++) {
				results[j][i] = preparedDBUtil.getString(j, preparedDBUtil
						.getMeta().getColumnName(i + 1));
			}
		}
		return results;
	}
	/**
	 * 根据SQL返回String
	 * @param sql
	 * @return
	 * @throws SQLException
	 */
	public static String[][] sqlToFieldsArray(String sql) throws SQLException {
		String[][] results = null;
		PreparedDBUtil preparedDBUtil = new PreparedDBUtil();
		preparedDBUtil.executeSelect(sql);
		int iSize = preparedDBUtil.getMeta().getColumnCount();
		results = new String[preparedDBUtil.size()][iSize];
		for(int j = 0; j < preparedDBUtil.size(); j++){
			for(int i=0; i<iSize; i++){
				results[j][i] = preparedDBUtil.getString(j, preparedDBUtil.getMeta().getColumnName(i+1));
			}
		}
		return results;
	}
	/**
	 * 根据SQL返回String
	 * @param sql
	 * @return
	 * @throws SQLException
	 */
	public static String[][] sqlToFieldsArray(String sql,Connection conn) throws SQLException {
		String[][] results = null;
		PreparedDBUtil preparedDBUtil = new PreparedDBUtil();
		preparedDBUtil.executeSelect(sql,conn);
		int iSize = preparedDBUtil.getMeta().getColumnCount();
		results = new String[preparedDBUtil.size()][iSize];
		for(int j = 0; j < preparedDBUtil.size(); j++){
			for(int i=0; i<iSize; i++){
				results[j][i] = preparedDBUtil.getString(j, preparedDBUtil.getMeta().getColumnName(i+1));
			}
		}
		return results;
	}
}
