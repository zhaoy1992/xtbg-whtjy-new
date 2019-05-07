package com.chinacreator.xtbg.core.kbm.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocTypeBean;

/**
 * 
 *<p>Title:KbmDocTypeDao.java</p>
 *<p>Description:知识库文档分类接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-6
 */
public interface KbmDocTypeDao {

	/**
	 * 
	*<b>Summary: </b>
	* selKbmDocTypeList(查询知识库文档分类列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selKbmDocTypeList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getKbmDocType(根据id查询文档分类信息)
	* @param k_type_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getKbmDocType(String k_type_id, Connection conn) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getIsrecursionDataById(根据id查询递归信息)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public Map<String, String> getIsrecursionDataById(Connection conn,String beanId) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* updateChildrenDocTypeByBean(修改知识分类下的子类)
	* @param bean
	* @param conn
	* @return
	 */
	public boolean updateChildrenDocTypeByBean(KbmDocTypeBean bean,Connection conn)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* deleteChildrenDocTypeByBean(根据id删除分类以及子类下的权限信息)
	* @param beanId
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean deleteChildrenDocTypeConfigByBean(String beanId,Connection conn)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* deleteChildrenDocTypeByBean(根据id删除所有子分类下的权限信息)
	* @param beanId
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean deletesonDocTypeConfigByBean(String beanId,Connection conn)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* deleteDocTypeBeansById(根据id删除分类以及子类)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deleteDocTypeBeansById(Connection conn,String beanId)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getSonDocTypeBeansById(根据id 查询所有子类)
	* @param beanId
	* @return
	* @throws Exception
	 */
	public List<Map<String,String>>  getSonDocTypeBeansById(String beanId)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* isKbmDocBean(判断分类是否被引用)
	* @param beanId
	* @return
	* @throws Exception
	 */
	public int isKbmDocBean(Connection conn,String beanId)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getKbmDocById(根据分类id查询所有该分类下的资料信息)
	* @param beanId
	* @return
	* @throws Exception
	 */
	public List<Map<String,String>>  getKbmDocById(String beanId)throws Exception;
}
