package com.chinacreator.xtbg.core.common.dbbase.dao;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;
import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbConstant;
import com.chinacreator.xtbg.core.common.dbbase.entity.XtShowInfoHashMap;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringSplitUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>
 * Title:持久层处理类的基本类
 * </p>
 *<p>
 * Description:持久层处理类的基本类，提供基本保存，更新，删除
 * </p>
 *<p>
 * Copyright:Copyright (c) 2013
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 夏天
 *@version 1.1 2013-4-17 version 1.1 新增功能 <b>bean中可以有与表字段不相关的字段！</b>
 */
public abstract class XtDbBaseDao implements BaseDao {
	private static final Logger logger = Logger.getLogger(XtDbBaseDao.class.getName());
	private XtDbBaseBean dbBaseBean = null;
	//protected PreparedDBUtil pdb = null;

	/**
	 *<b>Summary:插入持久对象bean中的数据到Db</b></br>
	 * 注意事项：</br>1、insert(所需的bean中必须继承XtDbBaseBean，必须设置tableName属性，它是指定的表名)</br>
	 * <b>bean中可以有与表字段不相关的字段！</b>暂时支持属性类型：String##java.sql.Timestamp
	 * 
	 * @param dbBaseBean
	 *            持久对象bean
	 * @throws Exception
	 */
	public void insert(XtDbBaseBean xtdbBaseBean) throws Exception {
		insert(xtdbBaseBean, null);
	}

	/**
	 *<b>Summary:插入持久对象bean中的数据到Db</b></br>
	 * 注意事项：</br>1、insert(所需的bean中必须继承XtDbBaseBean，必须设置tableName属性，它是指定的表名)</br>
	 * <b>bean中可以有与表字段不相关的字段！</b>暂时支持属性类型：String##java.sql.Timestamp
	 * 
	 * @param dbBaseBean
	 *            持久对象bean
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void insert(XtDbBaseBean xtdbBaseBean, Connection con)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();// 插入语句的sql
		StringBuffer placeHolder = new StringBuffer();// 占位符字符串

		Map<String, Object> initDBMap = initDBMap(xtdbBaseBean);
		String tableName = (String) initDBMap.get("tableName");
		Field[] fields = (Field[]) initDBMap.get("fields");
		Class clazz = (Class) initDBMap.get("clazz");

		String errorStr = "";
		Map<String, Object> columnMap = getTableColumns(tableName, pdb);
		String[] tableColumns = (String[]) columnMap.get("column_names");
		Map<String, String> columnTypeMap = (Map<String, String>) columnMap
				.get("column_types");
		List<String> canInsertFieldList = new ArrayList<String>();// 可以被插入的字段

		sql.append("insert into ");
		sql.append(tableName);
		sql.append(" (");

		for (Field f : fields) {
			f.setAccessible(true);
			if (null != f.get(dbBaseBean)
					&& !"null".equals(f.get(dbBaseBean))
					&& StringSplitUtil.isHave(tableColumns, f.getName()
							.toLowerCase())
					&& f.getModifiers() == Modifier.PRIVATE) {// 1,字段要在表中存在，2，只有私有变量才会被加载进来
				sql.append(f.getName().toLowerCase().trim() + ",");// 拼接bean中的属性
				placeHolder.append("?,");// 拼接预编译语句中的?问号，占位符
				canInsertFieldList.add(f.getName());
			}
		}
		sql = new StringBuffer(sql.substring(0, sql.length() - 1));// 去除多余的逗号
		sql.append(") values (");

		if (StringUtil.nullOrBlank(placeHolder.toString())) {// 如果占位符为空，则说明没有可以插入的属性，
			throw new Exception(getClassErrorStr(dbBaseBean, "中没有可以插入的属性！"));
		}
		sql.append(placeHolder.substring(0, placeHolder.length() - 1));// 去除多余的占位符中的逗号
		sql.append(")");

		try {
			pdb.preparedInsert(sql.toString());
			for (int i = 0; i < canInsertFieldList.size(); i++) {
				Field f = clazz.getDeclaredField(canInsertFieldList.get(i));
				;
				if (StringSplitUtil.isHave(tableColumns, f.getName()
						.toLowerCase())
						&& f.getModifiers() == Modifier.PRIVATE) {// 1,字段要在表中存在，2，只有私有变量才会被加载进来
					setPreparedValue(i + 1, f, columnTypeMap, pdb);
				}
			}
			if (null != con)
				pdb.executePrepared(con);
			else
				pdb.executePrepared();
		} catch (SQLException e) {
			errorStr = e.getMessage();
			showError(errorStr);
			throw e;
		}
	}
	
	
	/**
	 *<b>Summary:【批量】插入持久对象bean中的数据到Db</b></br>
	 * 注意事项：</br>1、insertBatch(所需的bean中必须继承XtDbBaseBean，必须设置tableName属性，它是指定的表名)</br>
	 * <b>bean中可以有与表字段不相关的字段！</b>暂时支持属性类型：String##java.sql.Timestamp
	 * 
	 * @param xtdbBaseBeanlist
	 *            持久对象bean的list
	 * @throws Exception
	 */
	public void insertBatch(List<? extends XtDbBaseBean> xtdbBaseBeanlist,Connection con) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();// 插入语句的sql
		StringBuffer placeHolder = new StringBuffer();// 占位符字符串
		
		Map<String, Object> initDBMap = initDBMap(xtdbBaseBeanlist.get(0));
		String tableName = (String) initDBMap.get("tableName");
		Field[] fields = (Field[]) initDBMap.get("fields");
		Class clazz = (Class) initDBMap.get("clazz");

		String errorStr = "";
		Map<String, Object> columnMap = getTableColumns(tableName, pdb);
		String[] tableColumns = (String[]) columnMap.get("column_names");
		Map<String, String> columnTypeMap = (Map<String, String>) columnMap
				.get("column_types");
		List<String> canInsertFieldList = new ArrayList<String>();// 可以被插入的字段

		sql.append("insert into ");
		sql.append(tableName);
		sql.append(" (");

		for (Field f : fields) {
			f.setAccessible(true);
			if (null != f.get(dbBaseBean)
					&& !"null".equals(f.get(dbBaseBean))
					&& StringSplitUtil.isHave(tableColumns, f.getName()
							.toLowerCase())
					&& f.getModifiers() == Modifier.PRIVATE) {// 1,字段要在表中存在，2，只有私有变量才会被加载进来
				sql.append(f.getName().toLowerCase().trim() + ",");// 拼接bean中的属性
				placeHolder.append("?,");// 拼接预编译语句中的?问号，占位符
				canInsertFieldList.add(f.getName());
			}
		}
		sql = new StringBuffer(sql.substring(0, sql.length() - 1));// 去除多余的逗号
		sql.append(") values (");

		if (StringUtil.nullOrBlank(placeHolder.toString())) {// 如果占位符为空，则说明没有可以插入的属性，
			throw new Exception(getClassErrorStr(dbBaseBean, "中没有可以插入的属性！"));
		}
		sql.append(placeHolder.substring(0, placeHolder.length() - 1));// 去除多余的占位符中的逗号
		sql.append(")");
		try {
			for(int j = 0 ; j < xtdbBaseBeanlist.size() ; j++){
				pdb.preparedInsert(sql.toString());
				dbBaseBean = xtdbBaseBeanlist.get(j);
				for (int i = 0; i < canInsertFieldList.size(); i++) {
					Field f = clazz.getDeclaredField(canInsertFieldList.get(i));
					;
					if (StringSplitUtil.isHave(tableColumns, f.getName()
							.toLowerCase())
							&& f.getModifiers() == Modifier.PRIVATE) {// 1,字段要在表中存在，2，只有私有变量才会被加载进来
						setPreparedValue(i + 1, f, columnTypeMap, pdb);
					}
				}
				pdb.addPreparedBatch();
			}
			
			if (null != con)
				pdb.executePreparedBatch(con);
			else
				pdb.executePreparedBatch();
		} catch (SQLException e) {
			errorStr = e.getMessage();
			showError(errorStr);
			throw e;
		}

	}

	/**
	 * TODO 更新持久对象bean中的数据到数据库 <b>Summary: 更新持久对象bean中的数据到数据库</b></br>
	 * 注意事项：</br>1、持久对象bean必须继承XtDbBaseBean,</br> 2、bean中必须设置tableName指定表名,</br>
	 * 参数说明：</br>1、可选择的设置updateKey:指定更新的主key，如果没有则更新所有数据</br>
	 * 2、属性中，值为null的不会被更新，值为""（空字符串）的会被更新
	 * <b>bean中可以有与表字段不相关的字段！</b>暂时支持属性类型：String##java.sql.Timestamp
	 * 
	 * @param dbBaseBean
	 *            持久对象bean
	 * @throws Exception
	 */
	public void update(XtDbBaseBean xtdbBaseBean) throws Exception {
		update(xtdbBaseBean, null);
	}

	/**
	 * TODO 更新持久对象bean中的数据到数据库 <b>Summary: 更新持久对象bean中的数据到数据库</b></br>
	 * 注意事项：</br>1、持久对象bean必须继承XtDbBaseBean,</br> 2、bean中必须设置tableName指定表名,</br>
	 * 参数说明：</br>1、可选择的设置updateKey:指定更新的主key，如果没有则更新所有数据</br>
	 * 2、属性中，值为null的不会被更新，值为""（空字符串）的会被更新
	 * <b>bean中可以有与表字段不相关的字段！</b>暂时支持属性类型：String##java.sql.Timestamp
	 * 
	 * @param dbBaseBean
	 *            持久对象bean
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void update(XtDbBaseBean xtdbBaseBean, Connection con)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();// 插入语句的sql

		Map<String, Object> initDBMap = initDBMap(xtdbBaseBean);
		String tableName = (String) initDBMap.get("tableName");
		Field[] fields = (Field[]) initDBMap.get("fields");
		Class clazz = (Class) initDBMap.get("clazz");
		Class superClazz = (Class) initDBMap.get("superClazz");
		List<String> updateKey = null;
		String errorStr = "";
		Map<String, Object> columnMap = getTableColumns(tableName, pdb);
		String[] tableColumns = (String[]) columnMap.get("column_names");
		Map<String, String> columnTypeMap = (Map<String, String>) columnMap.get("column_types");

		sql.append("update ");
		updateKey = (List<String>) getBeanValue(superClazz, "updateKey");
		sql.append(tableName);
		sql.append(" set ");
		List<String> canUpdateFieldList = new ArrayList<String>();// 可以被更新的字段

		for (Field f : fields) {
			if (StringSplitUtil.isHave(tableColumns, f.getName().toLowerCase())
					&& f.getModifiers() == Modifier.PRIVATE) {// 1,字段要在表中存在，2，只有私有变量才会被加载进来
				f.setAccessible(true);
				if (!updateKey.contains(f.getName().toLowerCase().trim())) {
					if (null != f.get(dbBaseBean)
							&& !"null".equals(f.get(dbBaseBean))) {// 如果当前属性有值才更新
						sql.append(f.getName().toLowerCase().trim() + " = ?,");// 拼接bean中的属性
						canUpdateFieldList.add(f.getName());
					}
				}
			}
		}
		sql = new StringBuffer(sql.substring(0, sql.length() - 1));// 去除多余的逗号
		if (canUpdateFieldList.size() == 0) {// 如果可以被更新的字段集合为空，则说明没有可以更新的属性，
			throw new Exception(getClassErrorStr(dbBaseBean, "中没有可以更新的属性！"));
		}
		sql.append(createSqlConditionStr(updateKey, XtDbConstant.DBSQL_AND));
		for (String str : updateKey) {
			canUpdateFieldList.add(str);
		}
		try {
			pdb.preparedUpdate(sql.toString());

			for (int i = 0; i < canUpdateFieldList.size(); i++) {
				Field f = clazz.getDeclaredField(canUpdateFieldList.get(i));
				setPreparedValue(i + 1, f, columnTypeMap, pdb);
			}
			if (null != con)
				pdb.executePrepared(con);
			else
				pdb.executePrepared();
		} catch (SQLException e) {
			errorStr = e.getMessage();
			showError(errorStr);
			throw e;
		}
	}

	/**
	 * TODO 简化的删除数据的方法 <b>Summary: 简化的删除数据的方法</b></br>
	 * 参数说明：</br>1、可选择的设置deleteKey:指定删除的主key，如果没有则删除所有数据</br>
	 * 
	 * @param deleteSql
	 *            删除数据的sql
	 * @param values
	 *            对应到sql中的占位符位置的值集合
	 * @throws Exception
	 */

	public void delete(String deleteSql, String... values) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			pdb.preparedDelete(deleteSql);
			for (int i = 0; i < values.length; i++) {
				pdb.setString(i + 1, values[i]);
			}
			pdb.executePrepared();
		} catch (SQLException e) {
			showError(e.getMessage());
			throw e;
		}

	}
	/**
	 * TODO 简化的删除数据的方法 <b>Summary: 简化的删除数据的方法</b></br>
	 * 参数说明：</br>1、可选择的设置deleteKey:指定删除的主key，如果没有则删除所有数据</br>
	 * 
	 * @param deleteSql
	 *            删除数据的sql
	 * @param conn 数据库连接
	 * @param values
	 *            对应到sql中的占位符位置的值集合
	 * @throws Exception
	 */
	public void delete(String deleteSql,Connection conn,String... values) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			pdb.preparedDelete(deleteSql);
			for (int i = 0; i < values.length; i++) {
				pdb.setString(i + 1, values[i]);
			}
			pdb.executePrepared(conn);
		} catch (SQLException e) {
			showError(e.getMessage());
			throw e;
		}

	}

	/**
	 * TODO 删除持久对象bean在数据库中的数据 <b>Summary: 删除持久对象bean在数据库中的数据</b></br>
	 * 注意事项：</br>1、持久对象bean必须继承XtDbBaseBean,</br> 2、bean中必须设置tableName指定表名,</br>
	 * 参数说明：</br>1、可选择的设置deleteKey:指定删除的主key，如果没有则【删除所有数据】</br>
	 * 
	 * @param dbBaseBean
	 *            持久对象bean
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void delete(XtDbBaseBean xtdbBaseBean) throws Exception {
		delete(xtdbBaseBean,null);

	}
	
	/**
	 * TODO 删除持久对象bean在数据库中的数据 <b>Summary: 删除持久对象bean在数据库中的数据</b></br>
	 * 注意事项：</br>1、持久对象bean必须继承XtDbBaseBean,</br> 2、bean中必须设置tableName指定表名,</br>
	 * 参数说明：</br>1、可选择的设置deleteKey:指定删除的主key，如果没有则【删除所有数据】</br>
	 * 
	 * @param dbBaseBean
	 *            持久对象bean
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void delete(XtDbBaseBean xtdbBaseBean,Connection con) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();// 插入语句的sql

		Map<String, Object> initDBMap = initDBMap(xtdbBaseBean);
		String tableName = (String) initDBMap.get("tableName");
		Class clazz = (Class) initDBMap.get("clazz");
		Class superClazz = (Class) initDBMap.get("superClazz");
		List<String> deleteKey = null;
		String errorStr = "";

		sql.append("delete ");
		deleteKey = (List<String>) getBeanValue(superClazz, "deleteKey");
		sql.append(tableName);
		sql.append(createSqlConditionStr(deleteKey, XtDbConstant.DBSQL_AND));

		try {
			pdb.preparedDelete(sql.toString());

			for (int i = 0; i < deleteKey.size(); i++) {
				Field f = clazz.getDeclaredField(deleteKey.get(i));
				setPreparedValue(i + 1, f, pdb);
			}
			if (null != con)
				pdb.executePrepared(con);
			else
				pdb.executePrepared();
		} catch (SQLException e) {
			errorStr = e.getMessage();
			showError(errorStr);
			throw e;
		}

	}
	/**
	 * 
	 *<b>Summary:根据id进行批量删除 </b> deleteList(请用一句话描述这个方法的作用)
	 * 
	 * @param xtdbBaseBean
	 *            删除操作的bean
	 * 
	 * @param ids
	 *            in语句里面需要调用的id列表，以'id','id','id'的形式进行拼接
	 */
	@SuppressWarnings("unchecked")
	public void deleteListById(XtDbBaseBean xtdbBaseBean, String... ids)
			throws Exception {

		Map<String, Object> initDBMap = initDBMap(xtdbBaseBean);
		// 得到表名
		String tableName = (String) initDBMap.get("tableName");
		// 得到删除的key集合
		List<String> deleteKey = (List<String>) getBeanValue((Class) initDBMap
				.get("superClazz"), "deleteKey");

		if (StringUtil.nullOrBlank(tableName)) {
			throw new SQLException("没有设置删除的表");
		}
		if (deleteKey.isEmpty()) {
			throw new SQLException("没有设置删除的key列");
		} else if (deleteKey.size() != ids.length) {
			throw new SQLException("设置删除的key列数与传入的value数不匹配");
		}

		StringBuffer sql = new StringBuffer("delete from " + tableName
				+ " where 1=1 ");

		// 拼接sql
		for (int i = 0; i < deleteKey.size(); i++) {
			// 为了兼容以前带单引号的拼接方式，id替换掉所有单引号
			sql.append(" and  instr ('," + ids[i].replaceAll("'", "")
					+ ",',','||" + deleteKey.get(i) + "||',')>0 ");
		}
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedDelete(sql.toString());
		db.executePrepared();
	}

	/**
	 * 
	 * <b>Summary: 批量删除</b> 复写方法 deleteListById
	 * 
	 * @param xtdbBaseBean
	 * @param conn
	 * @param ids
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao#deleteListById(com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean,
	 *      java.sql.Connection, java.lang.String[])
	 */
	@SuppressWarnings("unchecked")
	public void deleteListById(XtDbBaseBean xtdbBaseBean, Connection conn,
			String... ids) throws Exception {

		Map<String, Object> initDBMap = initDBMap(xtdbBaseBean);
		// 得到表名
		String tableName = (String) initDBMap.get("tableName");
		// 得到删除的key集合
		List<String> deleteKey = (List<String>) getBeanValue((Class) initDBMap
				.get("superClazz"), "deleteKey");

		if (StringUtil.nullOrBlank(tableName)) {
			throw new SQLException("没有设置删除的表");
		}
		if (deleteKey.isEmpty()) {
			throw new SQLException("没有设置删除的key列");
		} else if (deleteKey.size() != ids.length) {
			throw new SQLException("设置删除的key列数与传入的value数不匹配");
		}

		StringBuffer sql = new StringBuffer("delete from " + tableName
				+ " where 1=1 ");

		// 拼接sql
		for (int i = 0; i < deleteKey.size(); i++) {
			// 为了兼容以前带单引号的拼接方式，id替换掉所有单引号
			sql.append(" and  instr ('," + ids[i].replaceAll("'", "")
					+ ",',','||" + deleteKey.get(i) + "||',')>0 ");
		}
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedDelete(sql.toString());
		if (null != conn) {
			db.executePrepared(conn);
		} else {			
			db.executePrepared();
		}
    }
	
	/**
	 * 
	 *<b>Summary: 根据sql查询结果并封装成一个Map<String,String>,用于显示数据</b>
	 * 
	 * @param sql
	 * @param values
	 *            占位符对应的value值
	 * @return Map<String,String>
	 * @throws Exception
	 */
	public Map<String, String> queryToSingleMap(String sql, String... values)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		pdb.preparedSelect(sql.toString());
		Map<String, String> viewMap = new XtShowInfoHashMap();
		for (int i = 0; i < values.length; i++) {
			pdb.setString(i + 1, values[i]);
		}
		pdb.executePrepared();
		if (pdb.size() > 0) {
			viewMap = putResultToMap(0, true, pdb);
		}
		return viewMap;
	}

	/**
	 * 
	 *<b>Summary: 根据sql查询结果并封装成一个Map<String,String>,用于显示数据</b>
	 * 
	 * @param sql
	 * @param values
	 *            占位符对应的value值
	 * @return Map<String,String>
	 * @throws Exception
	 */
	public Map<String, String> queryToSingleMap(Connection conn, String sql,
			String... values) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		pdb.preparedSelect(sql.toString());
		Map<String, String> viewMap = new XtShowInfoHashMap();
		for (int i = 0; i < values.length; i++) {
			pdb.setString(i + 1, values[i]);
		}
		if (null != conn) {
			pdb.executePrepared(conn);
		} else {
			pdb.executePrepared();
		}
		if (pdb.size() > 0) {
			viewMap = putResultToMap(0, true, pdb);
		}
		return viewMap;
	}
	
	/**
	 * 
	 *<b>Summary: 根据xtdbBaseBean信息查询结果并封装成一个Map<String,String>,用于显示数据</b></br>
	 * 注意！！：必须要设置主键的值否则，只查出所有数据中的第一条记录
	 * 
	* @param xtdbBaseBean 持久层对象
	* @return
	* @throws Exception
	 */
	public Map<String, String> queryToSingleMap(XtDbBaseBean xtdbBaseBean)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			return queryToSingleMap(xtdbBaseBean, conn);
		} finally {
			DbManager.closeConnection(conn);
		}

	}

	/**
	 * 
	 *<b>Summary: 根据xtdbBaseBean信息查询结果并封装成一个Map<String,String>,用于显示数据</b></br>
	 * 注意！！：必须要设置主键的值否则，只查出所有数据中的第一条记录
	 * 
	 * @param xtdbBaseBean 底层持久对象
	 * @param conn 数据库连接        
	 * @return Map<String,String>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, String> queryToSingleMap(XtDbBaseBean xtdbBaseBean,Connection conn)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		Map<String, Object> initDBMap = initDBMap(xtdbBaseBean);
		String tableName = (String) initDBMap.get("tableName");
		Class clazz = (Class) initDBMap.get("clazz");
		Class superClazz = (Class) initDBMap.get("superClazz");
		List<String> pKey = (List<String>) getBeanValue(superClazz, "pKey");
		sql.append("select * from " + tableName);
		sql.append(createSqlConditionStr(pKey, XtDbConstant.DBSQL_AND));
		pdb.preparedSelect(sql.toString());
		Map<String, String> viewMap = new XtShowInfoHashMap();
		for (int i = 0; i < pKey.size(); i++) {
			Field f = clazz.getDeclaredField(pKey.get(i));
			setPreparedValue(i + 1, f, pdb);
		}
		pdb.executePrepared(conn);
		if (pdb.size() > 0) {
			viewMap = putResultToMap(0, true, pdb);
		}
		return viewMap;
	}

	/**
	 * 
	 *<b>Summary: 根据xtdbBaseBean信息查询结果并封装成一个XtDbBaseBean,用于显示数据</b></br>
	 * 注意！！：必须要设置主键的值否则，只查出所有数据中的第一条记录
	 * 
	 * @param xtdbBaseBean
	 *            底层持久对象
	 * @return XtDbBaseBean 如果没查询到任何相应的值，则返回为空
	 * @throws Exception
	 */
	public XtDbBaseBean queryToBean(XtDbBaseBean xtdbBaseBean,Connection conn) throws Exception {
		Map<String,String> map = queryToSingleMap(xtdbBaseBean,conn);
		if(map.isEmpty()){//如果查询出来的map为空，则说明没查到匹配的数据，理应返回空；
			xtdbBaseBean = null;
		}else{
			BeanUtils.copyProperties(xtdbBaseBean, map);
		}
		return xtdbBaseBean;
	}
	
	/**
	 * 
	 *<b>Summary: 根据xtdbBaseBean信息查询结果并封装成一个XtDbBaseBean,用于显示数据</b></br>
	 * 注意！！：必须要设置主键的值否则，只查出所有数据中的第一条记录
	 * 
	 * @param xtdbBaseBean
	 *            底层持久对象
	 * @return XtDbBaseBean
	 * @throws Exception
	 */
	public XtDbBaseBean queryToBean(XtDbBaseBean xtdbBaseBean) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			return queryToBean(xtdbBaseBean, conn);
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	 *<b>Summary: 根据sql查询结果并封装成一个List<BaseBean>,用于显示数据</b>
	 * 
	 * @param sql
	 * @param values
	 *            占位符对应的value值
	 * @return List<Map<String,String>>
	 * @throws Exception
	 */
	public List<? extends XtDbBaseBean> queryToListBean(
			XtDbBaseBean xtdbBaseBean, String sql, String... values)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		pdb.preparedSelect(sql.toString());
		return executePreparedAndParseResultToBean(values, xtdbBaseBean, pdb);
	}

	/**
	 * 
	 *<b>Summary: 根据sql查询结果并封装成一个List<Map<String,String>>,用于显示数据</b>
	 * 
	 * @param sql
	 * @param values
	 *            占位符对应的value值
	 * @return List<Map<String,String>>
	 * @throws Exception
	 */
	public List<Map<String, String>> queryToListMap(String sql,
			String... values) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		pdb.preparedSelect(sql.toString());
		return executePreparedAndParseResultToMap(values, pdb);
	}

	/**
	 * 
	 *<b>Summary: 根据sql查询结果并封装成一个List<Map<String,String>>,用于显示数据</b>
	 * 
	 * @param sql
	 * @param values
	 *            占位符对应的value值
	 * @return List<Map<String,String>>
	 * @throws Exception
	 */
	public List<Map<String, String>> queryToListMap(String sql,
			List<String> values) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		pdb.preparedSelect(sql.toString());
		return executePreparedAndParseResultToMap(values.toArray(), pdb);
	}
	
	/**
	 * 
	*<b>Summary: 根据sql查询结果并拼接成一个List<Map<String,String>>用于显示数据</b>
	* queryToListMap()
	* @param sql
	* @param conn
	* @param values
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryToListMap(String sql,
			Connection conn ,String... values) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		pdb.preparedSelect(sql.toString());
		return executePreparedAndParseResultToMap(values,conn, pdb);
	}
	/**
	 * 
	*<b>Summary: 根据sql查询结果并拼接成一个List<Map<String,String>>用于显示数据</b>
	* queryToListMap()
	* @param sql
	* @param conn
	* @param values
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryToListMap(String sql,
			Connection conn ,List<String> values) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		pdb.preparedSelect(sql.toString());
		return executePreparedAndParseResultToMap(values.toArray(),conn, pdb);
	}

	/**
	 * 
	 *<b>Summary: 根据sql查询结果并封装成一个List<Map<String,String>>,用于显示数据</b>
	 * 
	 * @param sql
	 * @param values
	 *            占位符对应的value值
	 * @return List<Map<String,String>>
	 * @throws Exception
	 */
	public List<Map<String, String>> queryToListMap(String sql, long offset,
			int pagesize, String... values) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		pdb.preparedSelect(sql.toString(), offset, pagesize);
		return executePreparedAndParseResultToMap(values, pdb);
	}

	/**
	 * 
	*<b>Summary: </b>
	* queryToListMap(根据sql查询结果并封装成一个List<Map<String,String>>,用于显示数据)
	* @param sql
	* @param offset
	* @param pagesize
	* @param conn
	* @param values 占位符对应的value值
	* @return List<Map<String,String>>
	* @throws Exception
	 */
	public PagingBean queryToPagingBean(String sql, long offset, int pagesize, Connection conn, String... values) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		pdb.preparedSelect(sql.toString(), offset, pagesize);
		List<Map<String, String>> listMap = executePreparedAndParseResultToMap(values, conn, pdb);
		PagingBean pb = new PagingBean();
		pb.setList(listMap);
		pb.setRecords((long) pdb.getTotalSize());
		return pb;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* queryToListMap(根据sql查询结果并封装成一个List<Map<String,String>>,用于显示数据)
	* @param sql
	* @param offset
	* @param pagesize
	* @param conn
	* @param values 占位符对应的value值
	* @return List<Map<String,String>>
	* @throws Exception
	 */
	public PagingBean queryToPagingBean(String sql, Connection conn, String... values) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		pdb.preparedSelect(sql.toString());
		List<Map<String, String>> listMap = executePreparedAndParseResultToMap(values, conn, pdb);
		PagingBean pb = new PagingBean();
		pb.setList(listMap);
		pb.setRecords((long) pdb.getTotalSize());
		return pb;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* queryToListMap(根据sql查询结果并封装成一个List<Map<String,String>>,用于显示数据)
	* @param sql
	* @param offset
	* @param pagesize
	* @param conn
	* @param values 占位符对应的value值
	* @return List<Map<String,String>>
	* @throws Exception
	 */
	public PagingBean queryToPagingBean(String sql, long offset, int pagesize, Connection conn, List<String> values) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		pdb.preparedSelect(sql.toString(), offset, pagesize);
		List<Map<String, String>> listMap = executePreparedAndParseResultToMap(values.toArray(), conn, pdb);
		PagingBean pb = new PagingBean();
		pb.setList(listMap);
		pb.setRecords((long) pdb.getTotalSize());
		return pb;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* queryToListMap(根据sql查询结果并封装成一个List<Map<String,String>>,用于显示数据)
	* @param sql
	* @param offset
	* @param pagesize
	* @param conn
	* @param values 占位符对应的value值
	* @return List<Map<String,String>>
	* @throws Exception
	 */
	public List<Map<String, String>> queryToListMap(String sql, long offset,
			int pagesize, Connection conn, String... values) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		pdb.preparedSelect(sql.toString(), offset, pagesize);
		return executePreparedAndParseResultToMap(values, conn, pdb);
	}
	
	/**
	 * 
	 *<b>Summary: 根据sql查询结果并封装成一个List<Map<String,String>>,用于显示数据</b>
	 * 
	 * @param sql
	 * @param values
	 *            占位符对应的value值
	 * @return List<Map<String,String>>
	 * @throws Exception
	 */
	public List<Map<String, String>> queryToListMap(String sql, long offset,
			int pagesize, List<String> values) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		pdb.preparedSelect(sql.toString(), offset, pagesize);
		return executePreparedAndParseResultToMap(values.toArray(), pdb);
	}
	

	/**
	 * 
	*<b>Summary: </b>
	* queryToListMap( 根据sql查询结果并封装成一个List<Map<String,String>>,用于显示数据)
	* @param sql
	* @param offset
	* @param pagesize
	* @param conn
	* @param values 占位符对应的value值
	* @return List<Map<String,String>>
	* @throws Exception
	 */
	public List<Map<String, String>> queryToListMap(String sql, long offset,
			int pagesize,Connection conn, List<String> values) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		pdb.preparedSelect(sql.toString(), offset, pagesize);
		return executePreparedAndParseResultToMap(values.toArray(), conn, pdb);
	}

	/**
	 * 
	*<b>Summary: 根据sql查询，结果封装成一个List<List<String>>,用于显示数据</b>
	* queryToListList()
	* @param sql
	* @param conn
	* @param values 占位符对应的value值
	* @return
	* @throws Exception
	 */
	public List<List<String>> queryToListList(String sql, Connection conn,
			List<String> values) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		pdb.preparedSelect(sql.toString());
		return executePreparedAndParseResultToList(values.toArray(), conn, pdb);
	}
	
	/**
	 * 
	*<b>Summary: 根据sql查询，结果封装成一个List<List<String>>,用于显示数据</b>
	* queryToListList()
	* @param sql
	* @param conn
	* @param values 占位符对应的value值
	* @return
	* @throws Exception
	 */
	public List<List<String>> queryToListList(String sql, Connection conn,
			String... values) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		pdb.preparedSelect(sql.toString());
		return executePreparedAndParseResultToList(values, conn, pdb);
	}

	/**
	 * 
	*<b>Summary: 根据sql查询，结果封装成一个List<List<String>>,用于显示数据</b>
	* queryToListList()
	* @param sql
	* @param offset  分页起始页数
	* @param pagesize 每页显示数据
	* @param conn
	* @param values 占位符对应的值
	* @return
	* @throws Exception
	 */
	public List<List<String>> queryToListList(String sql, long offset,
			int pagesize, Connection conn,
			List<String> values) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		pdb.preparedSelect(sql.toString());
		return executePreparedAndParseResultToList(values.toArray(), conn, pdb);
	}
	
	/**
	 *<b>Summary: 执行sql并且将结果集转换成Map</b>
	 * 
	 * @param values
	 * @return 结果集的Map
	 * @throws Exception
	 */
	private List<XtDbBaseBean> executePreparedAndParseResultToBean(
			Object[] values, XtDbBaseBean xtDbBaseBean, PreparedDBUtil pdb) throws Exception {
		List<XtDbBaseBean> viewBeanList = new ArrayList<XtDbBaseBean>();
		for (int i = 0; i < values.length; i++) {
			pdb.setString(i + 1, (String) values[i]);
		}
		pdb.executePrepared();
		for (int j = 0; j < pdb.size(); j++) {
			Map<String, String> viewMap = putResultToMap(j, false, pdb);
			XtDbBaseBean xtDbBaseBeanTemp = (XtDbBaseBean) BeanUtils
					.cloneBean(xtDbBaseBean);
			BeanUtils.copyProperties(xtDbBaseBeanTemp, viewMap);
			viewBeanList.add(xtDbBaseBeanTemp);
		}
		return viewBeanList;
	}
	
	

	/**
	 *<b>Summary: 执行sql并且将结果集转换成Map</b>
	 * 
	 * @param values
	 * @return 结果集的Map
	 * @throws Exception
	 */
	private List<Map<String, String>> executePreparedAndParseResultToMap(
			Object[] values, PreparedDBUtil pdb) throws Exception {
		List<Map<String, String>> viewMapList = new ArrayList<Map<String, String>>();
		for (int i = 0; i < values.length; i++) {
			pdb.setString(i + 1, (String) values[i]);
		}
		pdb.executePrepared();
		for (int j = 0; j < pdb.size(); j++) {
			Map<String, String> viewMap = putResultToMap(j, true, pdb);
			viewMapList.add(viewMap);
		}
		return viewMapList;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* executePreparedAndParseResultToMap(执行sql并且将结果集转换成Map)
	* @param values
	* @param conn
	* @return 结果集的Map
	* @throws Exception
	 */
	private List<Map<String, String>> executePreparedAndParseResultToMap(Object[] values, Connection conn, PreparedDBUtil pdb) throws Exception {
		List<Map<String, String>> viewMapList = new ArrayList<Map<String, String>>();
		for (int i = 0; i < values.length; i++) {
			pdb.setString(i + 1, (String) values[i]);
		}
		pdb.executePrepared(conn);
		for (int j = 0; j < pdb.size(); j++) {
			Map<String, String> viewMap = putResultToMap(j, true, pdb);
			viewMapList.add(viewMap);
		}
		return viewMapList;
	}

	/**
	 * 
	*<b>Summary: </b>
	* executePreparedAndParseResultToMap(执行sql并且将结果集转换成Map)
	* @param values
	* @param conn
	* @return 结果集的Map
	* @throws Exception
	 */
	private List<List<String>> executePreparedAndParseResultToList(Object[] values, Connection conn, PreparedDBUtil pdb) throws Exception {
		List<List<String>> viewList = new ArrayList<List<String>>();
		for (int i = 0; i < values.length; i++) {
			pdb.setString(i + 1, (String) values[i]);
		}
		pdb.executePrepared(conn);
		for (int j = 0; j < pdb.size(); j++) {
			List<String > list = putResultToList(j, true, pdb);
			viewList.add(list);
		}
		return viewList;
	}
	

	/**
	 * 
	*<b>Summary: 将当前行的结果集放入list</b>
	* putResultToList()
	* @param index
	* @param isShowNullDate
	* @param pdb
	* @return
	* @throws SQLException
	 */
	@SuppressWarnings("static-access")
	private List<String> putResultToList(int index, boolean isShowNullDate,PreparedDBUtil pdb)
			throws SQLException {
		List<String> viewMap = new ArrayList<String>();
		for (int z = 0; z < pdb.getMeta().getColumnCount(); z++) {
			if (!pdb.getMeta().getColumnName(z + 1).equals("ROWNO_")) {
				String column_string = pdb.getMeta().getColumnName(z + 1)
						.toLowerCase();
				String column_type = pdb.getJavaType(null,
						pdb.getMeta().getColumnType(z + 1)).toLowerCase();
				if (column_type.equals("date")) {// 如果当前列的数据类型为日期型，则把它转换为
					if (null != pdb.getTimestamp(index, column_string)) {
						viewMap.add(DateUtil.getTimeStringFull(pdb
								.getTimestamp(index, column_string)));
					} else {
						if (isShowNullDate) {// 是否把空值的date也添加到map中去
							viewMap.add(DateUtil.getTimeStringFull(pdb
									.getTimestamp(index, column_string)));
						}
					}
				} else {
					viewMap.add(pdb.getString(index, column_string));
				}
			}
		}
		return viewMap;
	}
	
	/**
	 * 
	 *<b>Summary: 将当前行的结果集放入map中</b>
	 * 
	 * @param index
	 *            当前行数
	 * @param isShowNullDate
	 *            是否把空值的date也添加到map中去
	 * @return Map<String,String>
	 * @throws SQLException
	 */
	@SuppressWarnings("static-access")
	private Map<String, String> putResultToMap(int index, boolean isShowNullDate,PreparedDBUtil pdb)
			throws SQLException {
		Map<String, String> viewMap = new XtShowInfoHashMap();
		for (int z = 0; z < pdb.getMeta().getColumnCount(); z++) {
			if (!pdb.getMeta().getColumnName(z + 1).equals("ROWNO_")) {
				String column_string = pdb.getMeta().getColumnName(z + 1)
						.toLowerCase();
				String column_type = pdb.getJavaType(null, pdb.getMeta().getColumnType(z + 1)).toLowerCase();
				if (column_type.equals("date")) {// 如果当前列的数据类型为日期型，则把它转换为
					if (null != pdb.getTimestamp(index, column_string)) {
						viewMap.put(column_string, DateUtil
								.getTimeStringFull(pdb.getTimestamp(index,
										column_string)));
					} else {
						if (isShowNullDate) {// 是否把空值的date也添加到map中去
							viewMap.put(column_string, DateUtil
									.getTimeStringFull(pdb.getTimestamp(index,
											column_string)));
						}
					}
				} else {
					viewMap.put(column_string, pdb.getString(index,
							column_string));
				}
			}
		}
		return viewMap;
	}

	/**
	 * 
	 *<b>Summary: 根据条件数组conditions以及条件之间的连接标识connectMark构建sql的条件字符串</b>
	 * 
	 * @param conditions
	 *            条件数组
	 * @param connectMark
	 *            条件之间的连接标识 具体在XtDbConstant有常量表示
	 * @return
	 */
	private String createSqlConditionStr(List<String> conditions,
			String connectMark) {
		StringBuffer sql = new StringBuffer();
		if (conditions != null && conditions.size() > 0) {// 根据更新主键的字符串数组，拼接当前更新语句的where条件
			sql.append(" where ");
			for (int j = 0; j < conditions.size(); j++) {
				if (j != conditions.size() - 1) {
					sql.append(conditions.get(j) + " = ? " + connectMark + " ");
				} else {
					sql.append(conditions.get(j) + " = ?");
				}
			}
		}
		return sql.toString();
	}

	/**
	 * 
	 *<b>Summary:
	 * 获取数据库操作类中的初始化数据Map，</br>并设置xtdbBaseBean为全局dbBaseBean数据持久bean</b>
	 * 
	 * @param xtdbBaseBean
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	private Map<String, Object> initDBMap(XtDbBaseBean xtdbBaseBean)
			throws Exception {
		dbBaseBean = xtdbBaseBean;// 设置当前数据库处理Dao的全局变量dbBaseBean
		//pdb = new PreparedDBUtil();// 初始化数据库连接
		Class clazz = dbBaseBean.getClass();
		Class superClazz = clazz.getSuperclass();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String tableName = "";
		Field[] fields = clazz.getDeclaredFields();// 根据Class对象获得属性 私有的也可以获得
		if (fields.length <= 0) {// 如果没有属性则返回
			throw new Exception(getClassErrorStr(dbBaseBean, "中没有设置属性！"));
		}
		tableName = (String) getBeanValue(superClazz, "tableName");

		if (StringUtil.nullOrBlank(tableName)) {
			throw new Exception(getClassErrorStr(dbBaseBean, "中缺失表名！"));
		}
		resultMap.put("clazz", clazz);
		resultMap.put("superClazz", superClazz);
		resultMap.put("tableName", tableName);
		resultMap.put("fields", fields);
		return resultMap;
	}

	/**
	 * 
	 *<b>Summary: 设置指定的属性值f到PreparedDbUtil中指定的占位符位置index</b>
	 * 
	 * @param pdb
	 *            PreparedDbUtil
	 * @param index
	 *            指定的占位符位置
	 * @param f
	 *            指定的属性值f
	 * @throws Exception
	 */
	private void setPreparedValue(int index, Field f, PreparedDBUtil pdb) throws Exception {
		setPreparedValue(index, f, null,pdb);
	}

	/**
	 * 
	 *<b>Summary: 设置指定的属性值f到PreparedDbUtil中指定的占位符位置index</b>
	 * 
	 * @param pdb
	 *            PreparedDbUtil
	 * @param index
	 *            指定的占位符位置
	 * @param f
	 *            指定的属性值f
	 * @throws Exception
	 */
	private void setPreparedValue(int index, Field f,
			Map<String, String> columnTypeMap, PreparedDBUtil pdb) throws Exception {
		if (null == columnTypeMap) {
			columnTypeMap = new HashMap<String, String>();
		}
		f.setAccessible(true);
		try {
			if (String.class == f.getType()) {// String类型的值
				if ("clob".equals(columnTypeMap.get(f.getName()))) {
					pdb.setClob(index, (String) f.get(dbBaseBean));// 设置每一个属性的值,
				} else {
					pdb.setString(index, (String) f.get(dbBaseBean));// 设置每一个属性的值,
				}
			} else if (Timestamp.class == f.getType()) {// Timestamp类型的值
				pdb.setTimestamp(index, (Timestamp) f.get(dbBaseBean));
			} else if (Object.class == f.getType()) {
				if(f.get(dbBaseBean) instanceof Timestamp){
					pdb.setTimestamp(index, (Timestamp) f.get(dbBaseBean));
				}else {
					pdb.setString(index, (String) f.get(dbBaseBean));
				}
			} else if (int.class == f.getType()) {
				pdb.setInt(index, (Integer) f.get(dbBaseBean));
			}
		} catch (IllegalArgumentException e) {
			showError(getClassErrorStr(dbBaseBean, "的" + f.getName()
					+ "不是声明底层字段（或者其子类或实现者）的类或接口的实例,当前此字段类型：" + f.getType()));
			throw e;
		} catch (SQLException e) {
			showError(e.getMessage());
			throw e;
		} catch (IllegalAccessException e) {
			showError(getClassErrorStr(dbBaseBean, "中的" + f.getName()
					+ "字段是不可访问的。"));
			throw e;
		}
	}

	/**
	 * 
	 *<b>Summary: 从指定当前全局数据持久bean中获取指定的key的值</b>
	 * 
	 * @param superClazz
	 *            dbBaseBean的父类型
	 * @param Key
	 *            指定key
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	private Object getBeanValue(Class dbBaseBean_superClazz, String Key)
			throws Exception {
		Object values = null;
		try {
			Field KeyField = dbBaseBean_superClazz.getDeclaredField(Key);// 根据key获取
			KeyField.setAccessible(true);// 开放当前字段的访问权限
			values = KeyField.get(dbBaseBean);// 获取Key字段，它对应的数据
		} catch (IllegalArgumentException e) {
			showError(getClassErrorStr(dbBaseBean, "的" + Key
					+ "不是声明底层字段（或者其子类或实现者）的类或接口的实例！"));
			throw e;
		} catch (IllegalAccessException e) {
			showError(getClassErrorStr(dbBaseBean, "中的" + Key + "字段是不可访问的！"));
			throw e;
		} catch (NoSuchFieldException e) {
			showError(getClassErrorStr(dbBaseBean, "中缺失" + Key + "属性！"));
			throw e;
		}
		return values;
	}

	/**
	 * 
	 *<b>Summary: 获取指定表的相关字段信息，返回一个map，里面包含内容：column_names所有字段名称的数组，
	 * column_types所有字段类型的map</b>
	 * 
	 * @param tableName
	 * @return
	 * @throws Exception
	 */
	private Map<String, Object> getTableColumns(String tableName, PreparedDBUtil pdb)
			throws Exception {
		pdb.preparedSelect("select wm_concat(NLS_LOWER(t.column_name)) as column_name,wm_concat(NLS_LOWER(t.DATA_TYPE)) as column_type  from USER_TAB_COLS t where t.table_name = NLS_UPPER(?)");
		pdb.setString(1, tableName.toUpperCase());
		pdb.executePrepared();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (pdb.size() > 0) {
			String[] columnNameArry = pdb.getString(0, "column_name")
					.split(",");
			String[] columnTypeArry = pdb.getString(0, "column_type")
					.split(",");
			Map<String, String> columnTypeMap = new HashMap<String, String>();
			for (int i = 0; i < columnNameArry.length - 1; i++) {
				columnTypeMap.put(columnNameArry[i], columnTypeArry[i]);
			}
			resultMap.put("column_names", columnNameArry);
			resultMap.put("column_types", columnTypeMap);
		}
		return resultMap;
	}

	/**
	 * 
	 *<b>Summary: </b> getClassErrorStr(显示当前class的错误信息) ""持久bean:DbBaseBean中""
	 * 
	 * @param errorStr
	 *            传入的独立错误信息
	 * @return
	 */
	private String getClassErrorStr(XtDbBaseBean dbBaseBean, String errorStr) {
		return "持久bean:" + dbBaseBean.getClass().getName() + "中" + errorStr;
	}

	/**
	 * 
	 *<b>Summary: </b> showError(显示错误)
	 * 
	 * @param errorStr
	 */
	private void showError(String errorStr) {
		logger.error(errorStr);
		System.out.println(errorStr);
	}

	public static void main(String[] args) {

	}

}
