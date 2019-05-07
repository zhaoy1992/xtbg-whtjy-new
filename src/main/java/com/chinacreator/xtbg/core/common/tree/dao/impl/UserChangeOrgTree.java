package com.chinacreator.xtbg.core.common.tree.dao.impl;

import com.chinacreator.xtbg.core.common.tree.entity.TreeBean;
import com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo;
/**
 * 
 *<p>Title:UserChangeOrgTree.java</p>
 *<p>Description:用户调动部门拖动人员机构树</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-11-11
 */
public class UserChangeOrgTree extends TreeDataInfo{

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getTreeDateInfo
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo#getTreeDateInfo()
	 */
	public Object getTreeDateInfo() throws Exception {
		TreeBean bean=new TreeBean();
		bean.setRequest(request);
		bean.setOrgID("");
		bean.setUserID("");
		return CommonTreeDaoImpl.inqueryTreePerson(bean);
	}

}
