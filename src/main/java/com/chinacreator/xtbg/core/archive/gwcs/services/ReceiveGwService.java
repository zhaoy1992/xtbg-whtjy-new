package com.chinacreator.xtbg.core.archive.gwcs.services;

import java.util.Map;

import com.chinacreator.xtbg.core.archive.gwcs.bean.GwreceiveBean;

/**
 * 
 *<p>Title:ReceiveGwService.java</p>
 *<p>Description:公文接收服务接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-12-13
 */
public interface ReceiveGwService {

	/**
	 * 
	*<b>Summary: </b>
	* findAttachid(根据附件id和文件名称,查询出附件表的djsn)
	* @param attach_id
	* @param filename
	* @return
	 */
	public String findAttachid(String attach_id,String filename);
	/**
	 * 
	*<b>Summary: </b>
	* findReceiveGw(根据id查询接收公文信息)
	* @param id
	* @return
	 */
	public Map<String, String> findReceiveGw(String id);
	/**
	 * 
	 * @param deleteArr
	 * @return
	 */
	public boolean deleteGwreceiveBeanByIds(String[] deleteArr);
	
	/**
	 * 
	 * @param bean
	 * @return
	 */
	public String insertOrUpdateGwreceiveBean(GwreceiveBean bean);
}
