package com.chinacreator.xtbg.core.process.dbmanager.service;

import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.dssave.entity.MdColumnBean;
import com.chinacreator.xtbg.core.dssave.entity.MdTableBean;

/**
 *<p>Title:MdServiceIfc.java</p>
 *<p>Description:数据元服务层接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-6-6
 */
public interface MdServiceIfc {
	
	
	/**
	*<b>Summary: </b>
	* createMdTables(新增表方法
	* 1.insert 主表 数据元表
	* 2.insert 从表 数据元字段表
	* 3.create 业务表 设置主键等)
	* @param mdtablejson 数据元表json串序列
	* @param mdcolumnlistjson 数据元字段表json串序列
	* @return 
	*/
	public boolean createMdTables(String mdtablejson, String mdcolumnlistjson);
	
	/**
	*<b>Summary: </b>
	* saveMdColumnsForm(
	* 更新表字段 　根据updatetype的值分为新增字段和修改字段两种情况
	* )
	* @param jsonparam
	* @param updatetype 变量状态只能是add或edit
	* @return 
	*/
	public String saveMdColumnsForm(String jsonparam, String updatetype);
	
	/**
	*<b>Summary: </b>
	* findMdColumnsById(根据主键id查询数据元字段表)
	* @param column_id
	* @return MdColumnBean实体类对象
	*/
	public MdColumnBean findMdColumnsById(String column_id);
	
	/**
	*<b>Summary: </b>
	* deleteMdTable(删除表
	* 1.由于主从表外键约束，故先delete数据元字段表记录，再delete数据元表记录；
	* 2.drop业务表；
	* 3.采用了事务管理；
	* 4.由于drop 不能回滚，故删除列时每次只能处理一条，并且要先执行delete脚本（因为delete可以回滚）)
	* @param table_id oa_md_table的主键
	* @param table_code 业务表名
	* @return 返回一个布尔值供前台提示alert结果
	*/
	public boolean deleteMdTables(String table_id,String table_code);
	
	
	/**
	*<b>Summary: </b>
	* findMdTableList(查询数据元表)
	* @param mdTableBean
	* @return
	* @throws Exception 
	*/
	public List<MdTableBean> findMdTableList(MdTableBean mdTableBean) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* findPkNameList(查询主键名称列表)
	* @param mdTableBean
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> findPkNameList(MdTableBean mdTableBean) throws Exception;
	
	
	/**
	*<b>Summary: </b>
	* deleteMdColumns(删除字段：
	* 1.delete数据元字段表记录；
	* 2.drop业务表字段；
	* 3.采用了事务管理
	* 4.由于drop 不能回滚，故删除列时每次只能处理一条，并且要先执行delete脚本（因为delete可以回滚）
	* )
	* @param mdColunmListData 实体对象 包括oa_md_columns主键和业务表字段名
	* @return 返回一个布尔值供前台提示alert结果
	*/
	public boolean deleteMdColumns(String mdColunmListData);
}
