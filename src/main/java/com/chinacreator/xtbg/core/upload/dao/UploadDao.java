package com.chinacreator.xtbg.core.upload.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.upload.entity.UploadModel;

public interface UploadDao {
	
	
	/**
	*<b>Summary: </b>
	* deleteUploadByAttachId(根据附件id删除全部附件记录)
	* @param conn
	* @param tableName
	* @param attachId
	* @return
	* @throws SQLException 
	*/
	public boolean deleteUploadByAttachId(Connection conn,String tableName,String attachId) throws SQLException;

	/**
	*<b>Summary: </b>
	* queryUploadListByAttachId(按附件id查询附件列表)
	* @param conn
	* @param tableName
	* @param attach_id
	* @return
	* @throws Exception 
	*/
	public List<Map<String, String>> queryUploadListByAttachId(Connection conn,String tableName,String attach_id) throws Exception;
	/**
	*<b>Summary: </b>
	* deleteUploadById(删除上传文件记录)
	* @param conn
	* @param tableName
	* @param fileid
	* @return
	* @throws SQLException 
	*/
	public boolean deleteUploadById(Connection conn,String tableName,String fileid) throws SQLException;
	/**
	*<b>Summary: </b>
	* queryUploadList(查询上传文件列表)
	* @param model
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception 
	*/
	public PagingBean queryUploadList(UploadModel model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	*<b>Summary: </b>
	* updateUploadFileInfo(更新上传文件信息)
	* @param conn
	* @param uploadModel
	* @return
	* @throws Exception 
	*/
	public boolean updateUploadFileInfo(Connection conn, UploadModel uploadModel)
			throws Exception;
	
	/**
	*<b>Summary: </b>
	* saveUploadFileInfo(保存上传文件信息)
	* @param conn
	* @param uploadModel
	* @return
	* @throws Exception 
	*/
	public boolean saveUploadFileInfo(Connection conn, UploadModel uploadModel)
			throws Exception;
	
	/**
	*<b>Summary: </b>
	* isExsitFile(是否已上传)
	* @param tableName
	* @param serverfilename
	* @param extrainfo
	* @param attach_id
	* @return
	* @throws Exception 
	*/
	public String isExsitFile(String tableName, String serverfilename,
			String extrainfo, String attach_id) throws Exception;
	/**
	 * 得批量下载附件List
	 * @param conn
	 * @param table_name
	 * @param attach_id
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> queryFileUploadBeanList
			(Connection conn,String table_name,String attach_id)throws Exception;
}
