package com.chinacreator.xtbg.core.archive.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.archive.dao.FlowOperExtDao;
import com.chinacreator.xtbg.core.archive.entity.DoBackBean;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.StringUtil;

/**
 * 
 *<p>Title:DoBackList.java</p>
 *<p>Description:查询回退列表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-11-14
 */
public class DoBackList extends DataInfoImpl{

	private static final Logger LOG = Logger.getLogger(DoBackList.class);
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
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		DoBackBean bean = null;
		if (!StringUtil.isBlank(parmjson) ) {
			bean = (DoBackBean) JSONObject.parseObject(parmjson, DoBackBean.class);
			String next_actdefId = bean.getNext_actdefId();
			String next_actdefIds = "";
			if(!StringUtil.isBlank(next_actdefId)) {
				String next_actdefIdArray[] = next_actdefId.split(",");
				for(int i = 0; i < next_actdefIdArray.length; i++) {
					next_actdefIds += "'" +next_actdefIdArray[i].split("#")[0]+ "',";
				}
				bean.setNext_actdefId(next_actdefIds.substring(0, next_actdefIds.length() - 1));
			}
		}
		FlowOperExtDao noticeBaseInfoDao = (FlowOperExtDao)LoadSpringContext.getApplicationContext().getBean("flowOperExtDaoImpl");
		try {
			pb = noticeBaseInfoDao.selDoBackList(bean, sortName, sortOrder, offset, maxPagesize);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		
		return pb;
	}

	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		// TODO Auto-generated method stub
		return null;
	}

}
