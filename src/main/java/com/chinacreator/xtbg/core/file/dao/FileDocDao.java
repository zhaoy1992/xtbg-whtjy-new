package com.chinacreator.xtbg.core.file.dao;



import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.file.entity.FileDocBean;
import com.chinacreator.xtbg.core.file.entity.FileDocBeforeArchiveBean;
import com.chinacreator.xtbg.core.file.entity.FileDocPhotoBean;
import com.chinacreator.xtbg.core.file.entity.FileDocPhotoInfoBean;

/**
 *<p>Title:FileDocDao.java</p>
 *<p>Description:文件管理Dao接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-7-16
 */
public interface FileDocDao {
	
	/**
	*<b>Summary: </b>
	* queryFileDocList(查询文件管理列表)
	* @param model
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception 
	*/
	public PagingBean queryFileDocList(FileDocBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	*<b>Summary: </b>
	* queryFileDocList(查询部门接收)
	* @param model
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception 
	*/
	public PagingBean queryFileDocToDeptList(FileDocBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	
	/**
	 * 查询文件管理列表
	 *<b>Summary: </b>
	 * queryFileDocPhotoList(查询文件管理列表)
	 * @param model
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean queryFileDocPhotoList(FileDocPhotoBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 查询文件管理列表
	 *<b>Summary: </b>
	 * queryFileDocDiskList(请用一句话描述这个方法的作用)
	 * @param model
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean queryFileDocDiskList(FileDocPhotoBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * queryFileDocVideoList(请用一句话描述这个方法的作用)
	 * @param model
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean queryFileDocVideoList(FileDocPhotoBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * queryFileDocPhotoBeanList(查询一个照片组内的照片文件)
	 * @param model
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean queryFileDocPhotoBeanList(FileDocPhotoInfoBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* queryFileDocList(根据文件ID查询)
	* @param model
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean queryFileDocListbyid(String doc_id, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * queryFileDocBeforeArchiveList(查询待归档的列表)
	 * @param model
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean queryFileDocBeforeArchiveList(FileDocBeforeArchiveBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * getfileDocBeforeArchiveBeanById(获取待归档信息)
	 * @param id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public Map<String,String> getfileDocBeforeArchiveBeanById(String id,Connection conn)
	 throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * insertAttachForFileDoc(为归档的创建附件)
	 * @param id
	 * @param conn
	 * @throws Exception
	 */
	public void insertAttachForFileDoc(String userId,String mFilePath,Map<String, String> bean,String fjId,Connection conn)
	 throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * updateFileDocBeforeArchiveBeanById(修改待归档数据的状态,归档人,归档时间)
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public String updateFileDocBeforeArchiveBeanByBean(
			FileDocBeforeArchiveBean bean, Connection conn) throws Exception;
}
