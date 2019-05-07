package com.chinacreator.xtbg.core.kbm.dao;
import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocBean;
/**
 *<p>Title:KbmDocDao.java</p>
 *<p>Description:知识库管理Dao接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-8-6
 */
public interface KbmDocDao {
	
	/**
	*<b>Summary: </b>
	* queryKbmDocList(查询知识库查询列表--未发布，即未送审或审核不通过等)
	* @param model
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception 
	*/
	public PagingBean queryKbmDocList(KbmDocBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	
	/**
	*<b>Summary: </b>
	* queryKbmDocList4Where(知识库查询)
	* @param model
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception 
	*/
	public PagingBean queryKbmDocList4Where(KbmDocBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* queryAllKbmDocList(查询新增和热点文档列表)
	* @param model
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean queryAllKbmDocList(KbmDocBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* queryKbmUploadTopList(上传排行榜列表)
	* @param model
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean queryKbmUploadTopList(KbmDocBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* queryKbmDocSuggestList(推荐文档查询列表)
	* @param model
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean queryKbmDocSuggestList(KbmDocBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* queryKbmDocFavoritesList(我的收藏查询列表)
	* @param model
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean queryKbmDocFavoritesList(KbmDocBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	
	/**
	*<b>Summary: </b>
	* getKbmDocListByIds(由主键得列表list，暂供打印时用)
	* @param ids
	* @return
	* @throws Exception 
	*/
	public List<Map<String, String>> getKbmDocListByIds(String ids)
			throws Exception;
	
	
	
	/**
	*<b>Summary: </b>
	* getKbmDocRssByKey(得到关键字文档的订阅者)
	* @param keys
	* @return
	* @throws Exception 
	*/
	public List<Map<String, String>> getKbmDocRssByKey(String keys,String k_type_id) throws Exception;
	
	
	/**
	*<b>Summary: </b>
	* updatekdcount(更新文档下载数)
	* @param k_doc_id
	* @return
	* @throws Exception 
	*/
	public boolean updatekdcount(String k_doc_id,Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* selKbmDocByCode(查询编码是否已存在数据)
	* @param k_code
	* @return
	* @throws Exception 
	*/
	public boolean selKbmDocByCode(String k_code) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getAcceptInfo(根据文档ID获取其对应附件的信息)
	* @param k_doc_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> getAcceptInfo(String k_doc_id) throws Exception;
	/**
	 * 删除更新通知
	 * @param ids
	 * @return
	 * @throws Exception
	 */
	public boolean deleteUpdate(String ids,Connection conn) throws Exception;
}
