package com.chinacreator.xtbg.core.dssave.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.chinacreator.xtbg.core.archive.entity.FlowDocmentFileBean;
import com.chinacreator.xtbg.core.archive.tag.ColumnDisplayBean;
import com.chinacreator.xtbg.core.dssave.entity.MdTableBean;
import com.chinacreator.xtbg.core.dssave.entity.ViewListBean;


/**
 * 
 *<p>Title:OperArchiveDao.java</p>
 *<p>Description:公文通用接口</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-4-7
 */
public interface DsCRUDDao {
	/**
	 * 
	*<b>Summary: </b>
	* save(保存方法)
	* @return
	* @throws Exception
	 */
	public boolean save(List<Map<String,List<Map<String, String>>>> datalist,Map<String,String> datemap, Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* update(更新方法)
	 * @param businessType 
	* @return
	* @throws Exception
	 */
	public boolean update(List<Map<String,List<Map<String, String>>>> datalist,Connection conn, String businessType,Map<String,String> datemap) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getDateList(根据request 获取业务封装数据)
	* @param request
	* @return
	 */
	public List<Map<String, List<Map<String, String>>>> getDateList(HttpServletRequest request) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getMdTableInfo(根据业务类型获取结构信息)
	* @param businessType
	* @return
	* @throws Exception
	 */
	public List<MdTableBean> getMdTableInfo(String businessType) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getBusinessDada(根据表名，主键名，主键值查询出业务数据。)
	* @param tableName
	* @param tablePk
	* @param businessid
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> getBusinessDada(MdTableBean archiveMdTableBean,String tablePk, String businessid)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getActColStauts(获取页面控制配置信息 流程活动表单元素状态表(环节字段状态表))
	* @param nodeid
	* @param archiveMdTableBean
	* @return
	* @throws Exception
	 */
	public Map<String, ColumnDisplayBean> getActColStauts(String action_id,String tableId)throws Exception;
	
	
	
	/**
	 * 
	*<b>Summary: </b>
	* getView(根据实例ID在ta_oa_ins_viewlist 意见表中查询出意见信息。)
	* @param insID
	* @return
	* @throws Exception
	 */
	public List<ViewListBean> getView(String insID)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getTextContorlInfo(根据环节ID查询出正文配置信息)
	* @param action_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String,String> getTextContorlInfo(String action_id,Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getActColStauts(获取默认页面控制配置信息 流程活动表单元素状态表(环节字段状态表))
	* @param nodeid
	* @param archiveMdTableBean
	* @return
	* @throws Exception
	 */
	public Map<String, ColumnDisplayBean> getDefaultActColStauts(String tableId,Connection conn)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* del(删除数据，同时删除业务类型对应的主表跟子表。)
	* @param conn
	* @param businessType
	* @return
	* @throws Exception
	 */
	public boolean del(Connection conn, String businessType,String busi_id)throws Exception;

	
	/**
	*<b>Summary: </b>
	* hasText(查看该文档是否存在，oa_document_File表中)
	* @param mRecordID
	* @return 
	*/
	public boolean hasText(String mRecordID)throws Exception;
	/**
	*<b>Summary: </b>
	* hasText(查看该文档是否存在，oa_document_File表中)
	* @param mRecordID
	* @return 
	*/
	public Boolean[] hasTextSign(String mRecordID)throws Exception;

	
	/**
	*<b>Summary: </b>
	* getPublicConfig(获取是否公开配置)
	* @param ins_id 
	 * @throws Exception 
	*/
	public String getPublicConfig(String ins_id) throws Exception;

	
	/**
	*<b>Summary: </b>
	* updatePublicConfig(更新是否公开)
	* @param is_open
	* @return 
	*/
	public boolean updatePublicConfig(String is_open,String ins_id ,Connection conn)throws Exception;
	/**
	*<b>Summary: </b>
	* getInfoTypeConfig(获取是否信息分类)
	* @param ins_id 
	 * @throws Exception 
	*/
	public String getInfoTypeConfig(String ins_id) throws Exception;

	
	/**
	*<b>Summary: </b>
	* updateInfoTypeConfig(更新是否公开)
	* @param is_infotype
	* @return 
	*/
	public boolean updateInfoTypeConfig(String is_infotype,String ins_id ,Connection conn)throws Exception;
	/**
	*<b>Summary: </b>
	* updateChiefConfig(更新督办时间)
	* @param chief_endtime
	* @return 
	*/
	public boolean updateChiefConfig(String chief_endtime,String ins_id ,Connection conn)throws Exception;
	/**
	*<b>Summary: </b>
	* getChiefConfig(获取督办时间)
	* @param ins_id 
	 * @throws Exception 
	*/
	public String getChiefConfig(String ins_id) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* findTable(根据ins_id得到相应的表名和字段名)
	* @param ins_id
	* @return
	* @throws Exception
	 */
	public Map<String , String> findTable(String ins_id) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* findRecordIDs(根据table_id得到相应的column_id的值)
	* @param table_id
	* @param column_id
	* @return
	* @throws Exception
	 */
	public String findRecordIDs(String table_id,String column_id,String busi_id) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* saveAsText(备份正文WORD信息)
	* @param recordid
	* @param flowDocmentFileBean
	* @param conn
	* @return
	 */
	public boolean saveAsText(String recordid,FlowDocmentFileBean flowDocmentFileBean, Connection conn)throws SQLException;

	public boolean updateFile(FlowDocmentFileBean flowDocmentFileBean, Connection conn)throws SQLException;
	/**
	 * 
	*<b>Summary: </b>
	* getFlowActId(查找流程环节实例ID)
	* @param ins_id
	* @param action_id
	* @param conn
	* @return
	 */
	public String getFlowActId(String ins_id, String action_id, Connection conn)throws Exception;
}
