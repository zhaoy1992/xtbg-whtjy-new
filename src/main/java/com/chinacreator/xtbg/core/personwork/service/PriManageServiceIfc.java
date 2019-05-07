
package com.chinacreator.xtbg.core.personwork.service;

import com.chinacreator.xtbg.core.personwork.entity.PriManageBean;

/**
 * 
 *<p>Title:PriManageServiceIfc.java</p>
 *<p>Description:通讯录权限配置</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-6-14
 */
public interface PriManageServiceIfc {
	/**
	 * 
	*<b>Summary: 添加权限信息</b>
	* priManageAdd(请用一句话描述这个方法的作用)
	* @param paramjosn
	* @return
	 */
	 boolean priManageAdd(String paramjosn);
	
	 /**
	  * 
	 *<b>Summary: 查询</b>
	 * querySingle(请用一句话描述这个方法的作用)
	 * @param pBean
	 * @return
	  */
	 PriManageBean querySingle(PriManageBean pBean);
}
