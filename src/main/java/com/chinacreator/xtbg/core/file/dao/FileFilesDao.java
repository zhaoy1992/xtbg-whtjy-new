package com.chinacreator.xtbg.core.file.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PageInfoBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.file.entity.FileDocBean;
import com.chinacreator.xtbg.core.file.entity.FileFilesBean;

/**
 * 
 *<p>
 * Title:FileFilesDao.java
 * </p>
 *<p>
 * Description:档案管理数据库操作接口
 * </p>
 *<p>
 * Copyright:Copyright (c)2013
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 戴连春
 *@version 1.0 2013-7-15
 */
public interface FileFilesDao {
	/**
	 * 
	 *<b>Summary: 查询档案信息</b> findTasksList()
	 * 
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean findFilesPageBean(FileFilesBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;

	/**
	 * 
	 *<b>Summary: 根据字典类型编号查询对应的记录</b> queryDictByCode()
	 * 
	 * @param code
	 *            编号
	 * @return List<Map<String,String>>形式的字典数据
	 * @throws Exception
	 */
	public List<Map<String, String>> queryDictByCode(String code)
			throws Exception;

	/**
	 * 
	 *<b>Summary: 根据单位id查询全宗号列表</b> queryListFondsno()
	 * 
	 * @param orgId
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> queryListFondsno(String orgId)
			throws Exception;

	/**
	 * 
	 *<b>Summary: 查询档案对应的文件信息</b> findDocPageBean()
	 * 
	 * @param map
	 *            查询条件
	 * @return 分页对象
	 * @throws Exception
	 */
	public PagingBean findDocPageBeanForFiles(Map<String, String> map)
			throws Exception;

	/**
	 * 
	 *<b>Summary: 批量更新档案信息</b> updateListFiles()
	 * 
	 * @param map
	 * @param conn
	 * @throws Exception
	 */
	public void updateListFiles(Map<String, Object> map, Connection conn)
			throws Exception;

	/**
	 * 
	 *<b>Summary: 入卷时进行查询</b> findDocPageBean4AddToFile()
	 * 
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean findDocPageBean4AddToFile(FileDocBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception;

	/**
	 * 
	 *<b>Summary:批量修改文件信息 </b> updateListDoc()
	 * 
	 * @param map
	 * @param conn
	 * @throws Exception
	 */
	public void updateListDoc(Map<String, Object> map, Connection conn)
			throws Exception;

	/**
	 * 
	 *<b>Summary: 根据档案类型id查询得到程序界面的信息</b> queryProgramByTypeId()
	 * 
	 * @param typeId
	 *            档案类型id
	 * @param conn
	 *            数据库连接
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> queryProgramByTypeId(String typeId,
			Connection conn) throws Exception;

	/**
	 * 
	 *<b>Summary: 查询会计档案列表（汇帐凭证）</b> findFilesPageBean4acc()
	 * 
	 * @param bean
	 *            档案对象
	 * @param page
	 *            分页对象
	 * @param fileMonth
	 *            档案年月
	 * @return
	 * @throws Exception
	 */
	public PagingBean findFilesPageBean4acc(FileFilesBean bean,
			PageInfoBean page) throws Exception;

	/**
	 * 
	 *<b>Summary:根据配置的备考表模板查询键值对信息 </b> queryDictDataByTemp()
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> queryDictDataByTemp(String temp,
			String dictTypeId, Connection conn) throws Exception;

	/**
	 * 
	 *<b>Summary:根据表单id查询得到其对应的表及所有子表 </b> queryTables()
	 * 
	 * @param id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> queryTables(String id, Connection conn)
			throws Exception;

	/**
	 * 
	 *<b>Summary: 根据档案表或者档案扩展表的表名以及档案id查询数据</b> queryByTableName()
	 * 
	 * @param table
	 *            表名
	 * @param filesId
	 *            档案id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> queryByTableName(String table, String filesId,
			Connection conn) throws Exception;

	/**
	 * 
	 *<b>Summary:根据档案的档号生成文件档号，文件档号为档案档号+“_件号” </b> createDocFileno()
	 * 
	 * @param fileno
	 * @throws Exception
	 */
	public void updateDocFileno(String filesId, String fileno, Connection conn)
			throws Exception;

	/**
	 * 
	 *<b>Summary:根据档案id查询该档案类的照片详情，用于 导出</b> queryDocTip()
	 * 
	 * @param filesId
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> queryDocDesc4Export(String filesId,
			Connection conn) throws Exception;

	/**
	 * 
	 *<b>Summary:根据档案id查询该档案内的光盘详情，用于 导出</b> queryDocTip()
	 * 
	 * @param filesId
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> queryDocDesc4ExportDisk(String filesId,
			Connection conn) throws Exception;

	/**
	 * 
	 *<b>Summary:更新文件状态为未归档 </b> updateDocStateByFileIds()
	 * 
	 * @param ids
	 * @param userId
	 * @param conn
	 * @throws SQLException
	 */
	public void updateDocStateByFileIds(String ids, Connection conn)
			throws SQLException;

	/**
	 * 
	 *<b>Summary: 删除备考表信息</b> deleteFileNote()
	 * 
	 * @param ids
	 *            档案id列表
	 * @param userId
	 *            用户id
	 * @param conn
	 * @throws SQLException
	 */
	public void deleteFileNote(String ids, Connection conn) throws SQLException;

	/**
	 * 
	 *<b>Summary:删除档案和文件对应关系表数据 </b> deleteListDocFiles()
	 * 
	 * @param ids
	 *            档案id
	 * @param userId
	 *            用户id
	 * @param isManager
	 *            是否档案管理员
	 * @param conn
	 * @throws SQLException
	 */
	public void deleteListDocFiles(String ids, Connection conn)
			throws SQLException;

	/**
	 * 
	 *<b>Summary:更新照片的档号 (照片的档号等于要入档的档案档号+组号+照片号)</b> updateDocFileno4pic()
	 * 
	 * @param filesId
	 *            档案id
	 * @param fileno
	 *            档号
	 * @param conn
	 *            数据库连接对象
	 * @throws Exception
	 */
	public void updateDocFileno4pic(String filesId, String fileno,
			Connection conn) throws Exception;

	/**
	 * 
	 *<b>Summary: 判断用户是否为某个档案类型或者其父类型的管理员</b> isFileTypeAdmin()
	 * 
	 * @param userId
	 * @param typeId
	 * @param conn
	 * @return
	 * @throws SQLException
	 */
	public boolean isFileTypeAdmin(String userId, String typeId, Connection conn)
			throws SQLException;

	/**
	 * 
	 *<b>Summary: 批量修改案卷状态</b> updateListFileState()
	 * 
	 * @param state
	 * @param fileIds
	 * @throws SQLException
	 */
	public void updateListFileState(String state, String stateName,
			String fileIds, Connection conn) throws SQLException;

	/**
	 * 
	 *<b>Summary:复制会计档案 </b> copyFileAcc()
	 * 
	 * @throws SQLException
	 */
	public void copyFileAcc(String oldFileId, String newFileId, Connection conn)
			throws SQLException;

	/**
	 * 
	 *<b>Summary: 批量更新案卷时，查询案卷列表用于更新档号</b> queryListFile4update()
	 * 
	 * @param map
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> queryListFile4update(
			Map<String, Object> map, Connection conn) throws Exception;

	/**
	 * 
	 *<b>Summary:获得当前类型最大的案卷号，并自增1 </b>
	 * 
	 * @param typeId
	 *            档案类型id
	 * @param orgId
	 *            单位id
	 * @param conn
	 *            数据库连接对象
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> queryMaxFileNo(String typeId, String orgId,
			Connection conn) throws Exception;

	/**
	 * 
	 *<b>Summary:查询卷内文件的最大件号+1 </b> queryMaxDocNo()
	 * 
	 * @param fileId
	 *            档案编号
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> queryMaxDocNo(String fileId, Connection conn)
			throws Exception;
	
	/**
	 * 
	 *<b>Summary: </b>
	 * updateFilesListOrder(排序)
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean updateFilesListOrder(FileFilesBean bean,Connection conn)
		throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * updateFileListInFilesOrder(排序)
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean updateFileListInFilesOrder(FileFilesBean bean,Connection conn)
	throws Exception;
}