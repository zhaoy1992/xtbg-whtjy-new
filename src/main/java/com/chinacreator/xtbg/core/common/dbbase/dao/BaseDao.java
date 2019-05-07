package com.chinacreator.xtbg.core.common.dbbase.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>
 * Title:BaseDao.java
 * </p>
 *<p>
 * Description:dao层的基本接口，支持基本的增删改方法
 * </p>
 *<p>
 * Copyright:Copyright (c) 2013
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 夏天
 *@version 1.0 2013-4-28
 */
public interface BaseDao {
	/**
	 * TODO 插入持久对象bean中的数据到Db <b>Summary:插入持久对象bean中的数据到Db</b></br>
	 * 注意事项：</br>1、insert(所需的bean中必须继承XtDbBaseBean，必须设置tableName属性，它是指定的表名)</br>
	 * <b>bean中可以有与表字段不相关的字段！</b>暂时支持属性类型：String##java.sql.Timestamp
	 * 
	 * @param dbBaseBean
	 *            持久对象bean
	 * @throws Exception
	 */
	@Deprecated
	public void insert(XtDbBaseBean xtdbBaseBean) throws Exception;

	/**
	 * TODO 插入持久对象bean中的数据到Db<b>带数据连接对象</b></br>
	 * <b>Summary:插入持久对象bean中的数据到Db</b></br>
	 * 注意事项：</br>1、insert(所需的bean中必须继承XtDbBaseBean，必须设置tableName属性，它是指定的表名)</br>
	 * <b>bean中可以有与表字段不相关的字段！</b>暂时支持属性类型：String##java.sql.Timestamp
	 * 
	 * @param dbBaseBean
	 *            持久对象bean
	 * @throws Exception
	 */
	public void insert(XtDbBaseBean xtdbBaseBean, Connection con)
			throws Exception;
		
	
	/**
	 *<b>Summary:【批量】插入持久对象bean中的数据到Db</b></br>
	 * 注意事项：</br>1、insertBatch(所需的bean中必须继承XtDbBaseBean，必须设置tableName属性，它是指定的表名)</br>
	 * <b>bean中可以有与表字段不相关的字段！</b>暂时支持属性类型：String##java.sql.Timestamp
	 * 
	 * @param xtdbBaseBeanlist
	 *            持久对象bean的list
	 * @throws Exception
	 */
	public void insertBatch(List<? extends XtDbBaseBean> xtdbBaseBeanlist,Connection con) throws Exception;

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
	@Deprecated
	public void update(XtDbBaseBean xtdbBaseBean) throws Exception;

	/**
	 * TODO 更新持久对象bean中的数据到数据库<b>带数据连接对象</b> <b>Summary:
	 * 更新持久对象bean中的数据到数据库</b></br> 注意事项：</br>1、持久对象bean必须继承XtDbBaseBean,</br>
	 * 2、bean中必须设置tableName指定表名,</br>
	 * 参数说明：</br>1、可选择的设置updateKey:指定更新的主key，如果没有则更新所有数据</br>
	 * 2、属性中，值为null的不会被更新，值为""（空字符串）的会被更新
	 * <b>bean中可以有与表字段不相关的字段！</b>暂时支持属性类型：String##java.sql.Timestamp
	 * 
	 * @param dbBaseBean
	 *            持久对象bean
	 * @throws Exception
	 */
	public void update(XtDbBaseBean xtdbBaseBean, Connection con)
			throws Exception;

	/**
	 * TODO 删除持久对象bean在数据库中的数据 <b>Summary: 删除持久对象bean在数据库中的数据</b></br>
	 * 注意事项：</br>1、持久对象bean必须继承XtDbBaseBean,</br> 2、bean中必须设置tableName指定表名,</br>
	 * 参数说明：</br>1、可选择的设置deleteKey:指定删除的主key，如果没有则【删除所有数据】</br>
	 * 
	 * @param dbBaseBean
	 *            持久对象bean
	 * @throws Exception
	 */
	@Deprecated
	public void delete(XtDbBaseBean xtdbBaseBean) throws Exception;
	
	/**
	 * TODO 删除持久对象bean在数据库中的数据 <b>Summary: 删除持久对象bean在数据库中的数据</b></br>
	 * 注意事项：</br>1、持久对象bean必须继承XtDbBaseBean,</br> 2、bean中必须设置tableName指定表名,</br>
	 * 参数说明：</br>1、可选择的设置deleteKey:指定删除的主key，如果没有则【删除所有数据】</br>
	 * 
	 * @param dbBaseBean
	 *            持久对象bean
	 * @param con 数据库连接
	 * @throws Exception
	 */
	public void delete(XtDbBaseBean xtdbBaseBean,Connection con) throws Exception;

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
	@Deprecated
	public void deleteListById(XtDbBaseBean xtdbBaseBean, String... ids)
			throws Exception;

	/**
	 * 
	 *<b>Summary:根据id进行批量删除 </b> deleteList(请用一句话描述这个方法的作用)
	 * 
	 * @param xtdbBaseBean
	 *            删除操作的bean
	 * @param conn
	 *            数据库连接
	 * @param ids
	 *            in语句里面需要调用的id列表，以'id','id','id'的形式进行拼接
	 */
	public void deleteListById(XtDbBaseBean xtdbBaseBean, Connection conn,
			String... ids) throws Exception;;

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
	@Deprecated
	public XtDbBaseBean queryToBean(XtDbBaseBean xtdbBaseBean) throws Exception;

	/**
	 * 
	 *<b>Summary: 根据xtdbBaseBean信息查询结果并封装成一个XtDbBaseBean,用于显示数据</b></br>
	 * 注意！！：必须要设置主键的值否则，只查出所有数据中的第一条记录
	 * 
	 * @param xtdbBaseBean
	 *            底层持久对象
	 * @param 数据库连接对象
	 * @return XtDbBaseBean
	 * @throws Exception
	 */
	public XtDbBaseBean queryToBean(XtDbBaseBean xtdbBaseBean, Connection conn)
			throws Exception;
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
	public Map<String, String> queryToSingleMap(XtDbBaseBean xtdbBaseBean,Connection conn)
			throws Exception;
}
