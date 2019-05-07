
 /**
 * [Product]
  *     tjy_xtbg168
  * [Copyright]
  *     Copyright © 2015 ICSS All Rights Reserved.
  * [FileName]
  *     DoneAnswersList.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2015-2-3   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.answers.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowSearchBean;
import com.chinacreator.xtbg.tjy.answers.dao.FlowAnswersBusiSearchDao;

/**
 *<p>Title:DoneAnswersList.java</p>
 *<p>Description:查询有问必答待办数据</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2015-2-3
 */
public class DoneAnswersList extends DataInfoImpl{
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(DoneAnswersList.class);
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
		
		WorkFlowSearchBean workFlowSearchBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			workFlowSearchBean = (WorkFlowSearchBean) JSONObject.parseObject(parmjson, WorkFlowSearchBean.class);
		}
		
		try {
			FlowAnswersBusiSearchDao fInfodao = (FlowAnswersBusiSearchDao)LoadSpringContext.getApplicationContext().getBean("flowAnswersBusiSearchDaoImpl");
			pb = fInfodao.findDoneWorkList(workFlowSearchBean, sortName, sortOrder, offset, maxPagesize);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return pb;
	}


	public PagingBean getDataList(String parmStr, String sortName, String sortOrder) {
		
		return null;
	}
}
