package com.chinacreator.xtbg.core.kbm.service;

import com.chinacreator.xtbg.core.kbm.entity.*;

/**
 *<p>Title:KbmDocService.java</p>
 *<p>Description:知识库文档管理服务接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-8-7
 */
public interface KbmDocService {
	
	
	/**
	*<b>Summary: </b>
	* checkKbmDocBean(审核文档)
	* @param kbmDocBean
	* @return 
	*/
	public boolean checkKbmDocBean(KbmDocBean kbmDocBean);
	
	/**
	*<b>Summary: </b>
	* updateKbmDocBean(更新文件管理实体bean)
	* @param kbmDocBean
	* @return 
	*/
	public boolean updateKbmDocBean(KbmDocBean kbmDocBean);
	
	
	/**
	*<b>Summary: </b>
	* getKbmDocBeanById(按主键id值得到实体bean对象)
	* @param k_doc_id
	* @return 
	*/
	public KbmDocBean getKbmDocBeanById(String k_doc_id);
	
	
	/**
	*<b>Summary: </b>
	* deleteKbmDocBean(按ids批量删除)
	* @param ids
	* @return 
	*/
	public boolean deleteKbmDocBeanByIds(String ids,KbmDocBean kbmDocBean);
	
	
	/**
	*<b>Summary: </b>
	* updatekdcount(更新文档下载数)
	* @param k_doc_id
	* @return 
	*/
	public boolean updatekdcount(String k_doc_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* isWordAndOnlyOne(是否只有一个附件并且该附件为word格式 是则返回文档ID 不是则返回“no”)    add by  jia.tong  2013-11-12
	* @param k_doc_id
	* @return
	 */
	public String isWordAndOnlyOne(String k_doc_id);
	/**
	 * 删除更新通知
	 * @param ids
	 * @return
	 */
	public boolean deleteUpdate(String ids);
	
}
