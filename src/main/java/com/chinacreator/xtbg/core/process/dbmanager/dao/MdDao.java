package com.chinacreator.xtbg.core.process.dbmanager.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.dssave.entity.MdTableBean;
import com.chinacreator.xtbg.core.dssave.entity.MdColumnBean;
/**
 *<p>Title:MdDao.java</p>
 *<p>Description:数据元数据访问层接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-6-6
 */
public interface MdDao {
	
	
	
	/**
	*<b>Summary: </b>
	* insertMdTable(新增记录至数据元表)
	* @param conn
	* @param model
	* @return 返回插入生成table_id
	* @throws SQLException 
	*/
	public String insertMdTable(Connection conn, MdTableBean model)
			throws SQLException;
	
	
	/**
	*<b>Summary: </b>
	* createMdTable(新建表)
	* @param conn
	* @param list
	* @param pkname
	* @param pk
	* @param havepk
	* @throws SQLException 
	*/
	public void createMdTable(Connection conn, List<MdColumnBean> list,MdTableBean model)
			throws SQLException;
	
	
	/**
	*<b>Summary: </b>
	* insertMdColumn(新增记录至数据元字段表)
	* @param conn
	* @param model
	* @throws SQLException 
	*/
	public void insertMdColumn(Connection conn, MdColumnBean model)
			throws SQLException;
	
	/**
	*<b>Summary: </b>
	* addMdColumn(添加字段至业务表)
	* @param conn
	* @param model
	* @throws SQLException 
	*/
	public void addMdColumn(Connection conn, MdColumnBean model)
		throws SQLException;
	
	/**
	*<b>Summary: </b>
	* updateMdColumn(请用一句话描述这个方法的作用)
	* @param conn
	* @param model
	* @throws SQLException 
	*/
	public void updateMdColumn(Connection conn, MdColumnBean model)
			throws SQLException;
	
	/**
	*<b>Summary: </b>
	* modifyMdColumn(请用一句话描述这个方法的作用)
	* @param conn
	* @param model
	* @throws SQLException 
	*/
	public void modifyMdColumn(Connection conn, MdColumnBean model)
			throws SQLException;
	
	/**
	*<b>Summary: </b>
	* findMdColumnById(根据主键id查询数据元字段表)
	* @param column_id
	* @return
	* @throws SQLException 
	*/
	public MdColumnBean findMdColumnById(String column_id) throws SQLException;
	
	/**
	*<b>Summary: </b>
	* deleteMdTable(删除数据元表记录 for delete)
	* @param conn
	* @param table_id
	* @throws SQLException 
	*/
	public void deleteMdTable(Connection conn, String table_id) throws Exception;
	
	
	/**
	*<b>Summary: </b>
	* dropMdTable(删除业务表 for drop)
	* @param conn
	* @param table_name
	* @throws SQLException 
	*/
	public void dropMdTable(Connection conn, String table_name) throws Exception;
	
	/**
	*<b>Summary: </b>
	* deleteMdColumn(删除数据元字段表记录 for delete)
	* @param conn
	* @param column_id
	* @throws SQLException 
	*/
	public void deleteMdColumn(Connection conn, String column_id)
			throws SQLException;
	
	/**
	*<b>Summary: </b>
	* deleteMdColumnByTableId(根据外键table_id删除数据元字段表关联记录)
	* @param conn
	* @param table_id
	* @throws SQLException 
	*/
	public void deleteMdColumnByTableId(Connection conn, String table_id)
			throws Exception;
	
	/**
	*<b>Summary: </b>
	* dropTableColumn(删除业务表的列 for drop)
	* @param conn
	* @param model
	* @throws SQLException 
	*/
	public void dropTableColumn(Connection conn, MdColumnBean model)
			throws SQLException;
	
	/**
	*<b>Summary: </b>
	* findMdTableList(查询数据元表)
	* @param model
	* @return
	* @throws Exception 
	*/
	public List<MdTableBean> findMdTableList(MdTableBean mdTableBean) throws SQLException;
	/**
	 * 
	*<b>Summary: </b>
	* findPkNameList(查询主键名称列表)
	* @param mdTableBean
	* @return
	* @throws SQLException
	 */
	public List<Map<String, String>> findPkNameList(MdTableBean mdTableBean) throws SQLException;
	
	/**
	*<b>Summary: </b>
	* findMdColumnList(查询数据元字段表并通过系统表列出字段相关信息)
	* @param mdTableBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception 
	*/
	public PagingBean findMdColumnList(MdColumnBean mdTableBean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws SQLException;

}
