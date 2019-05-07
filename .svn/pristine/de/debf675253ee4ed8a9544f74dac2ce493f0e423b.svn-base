package com.chinacreator.xtbg.core.archive.service;

import java.util.List;

import com.chinacreator.xtbg.core.archive.entity.DocumentComideaBean;

/**
 * 
 *<p>Title:ComideaService.java</p>
 *<p>Description:常用意见服务接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-11-20
 */
public interface ComideaService {
	/**
	 * 
	*<b>Summary: </b>
	* saveComidea(保存常用意见)
	* @param bean
	* @return
	 */
	public boolean saveComidea(DocumentComideaBean bean);
	/**
	 * 
	*<b>Summary: </b>
	* delComidea(根据内容删除常用内容)
	* @param content
	* @return
	 */
	public boolean delComidea(String  content,String user_id);
	/**
	 * 得常用内容列表
	 * @param user_id
	 * @return
	 */
	public List<DocumentComideaBean> getList(String user_id);
}
