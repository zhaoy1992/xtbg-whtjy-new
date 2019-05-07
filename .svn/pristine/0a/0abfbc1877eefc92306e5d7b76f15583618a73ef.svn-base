package com.chinacreator.xtbg.core.workbench.list;

import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.workbench.entity.UserSessionBean;
import com.chinacreator.xtbg.core.workbench.session.SessionListener;

/**
 * 
 *<p>Title:OnlineUserList.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-7-1
 */
public class OnlineUserList extends DataInfoImpl{

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getDataList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return 
	  * @see com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl#getDataList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		 List<UserSessionBean> onlineUser = new ArrayList<UserSessionBean>();
		 onlineUser = SessionListener.getOnlineUser();
		 pb.setList(onlineUser);
		 pb.setRecords((long)onlineUser.size());
		return pb;
	}

	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		// TODO Auto-generated method stub
		return null;
	}

}
