package com.chinacreator.xtbg.core.kbm.service;

import java.util.Map;

import com.chinacreator.xtbg.core.kbm.entity.KbmDocTypeBean;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocTypeRightConfig;

/**
 * 
 *<p>Title:KbmDocTypeServiceIfc.java</p>
 *<p>Description:知识库文档分类服务接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-6
 */
public interface KbmDocTypeServiceIfc {

	/**
	 * 
	*<b>Summary: </b>
	* getKbmDocTypeBean(根据文档分类Id查询文档信息)
	* @param k_type_id
	* @return
	 */
	public Map<String, String> getKbmDocTypeBean(String k_type_id);
	/**
	 * 
	*<b>Summary: </b>
	* getIsrecursionDataForInsert(根据id查询递归的数据)
	* @param parentId
	* @return
	 */
	public KbmDocTypeBean getIsrecursionDataForInsert(String parentId);
	/**
	 * 
	*<b>Summary: </b>
	* insertOrUpdateKbmDocTypeBean(增加和修改知识分类信息)
	* @param bean
	* @return
	 */
	public String insertOrUpdateKbmDocTypeBean(KbmDocTypeBean bean);
	/**
	 * 
	*<b>Summary: </b>
	* deleteDocTypeInfoByIds(根据Ids批量删除知识分类)
	* @param beanIdArr
	* @return
	 */
	public String deleteDocTypeInfoByIds(String[] beanIdArr);
	/**
	 * 
	*<b>Summary: </b>
	* getMaxFilePurviewNum(获得密级的个数)
	* @return
	 */
	public int getMaxDocTypeConfigNum();
	/**
	 * 
	*<b>Summary: </b>
	* getDocTypeConfigBeanById(根据id查询知识库分类密级信息)
	* @param beanId
	* @return
	 */
	public Map<String, String> getDocTypeConfigBeanById(String beanId);
	/**
	 * 
	*<b>Summary: </b>
	* insertOrUpdateDocConfigBean(添加和修改知识库分类权限设置)
	* @param bean
	* @return
	 */
	public boolean insertOrUpdateDocConfigBean(KbmDocTypeRightConfig bean);
	/**
	 * 
	*<b>Summary: </b>
	* deleteDocTypeConfigInfoByIds(根据id删除分类权限)
	* @param beanIdArr
	* @return
	 */
	public boolean deleteDocTypeConfigInfoByIds(String[] beanIdArr);
}
