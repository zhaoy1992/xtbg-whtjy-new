/**
 * [Product]
 *     tjy_xtbg168
 * [Copyright]
 *     Copyright © 2014 ICSS All Rights Reserved.
 * [FileName]
 *     ElectInfoTjList.java
 * [History]
 *     Version  Date      Author     Content
 *     -------- --------- ---------- ------------------------
 *     1.0.0    2014-7-7   Administrator    最初版本
 */
package com.chinacreator.xtbg.suxian.electroniccheck.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.suxian.electroniccheck.dao.imploracle.ElectInfoDaoImpl;
import com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectInfoCountSearchBean;
/**
 * <p>
 * Title:ElectInfoTjList.java
 * Description:电子考勤统计
 * Copyright:Copyright (c) 2013
 * Company:湖南科创
 * @author 邱炼
 * @version 1.0 2014-7-7
 */
public class ElectInfoTjList implements DataInfoImpl {

	private static final Logger LOG = Logger.getLogger(ElectInfoTjList.class);

	
	
	/**
	 * @Description  任务交办统计列表
	 * 
	 * @param request
	 * @param response
	 * @return  返回JOSNOBJECT
	 * @exception 
	 */
	public PagingBean getDataList(String paramjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		
		ElectInfoCountSearchBean bean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(paramjson)) {
			paramjson = DataControlUtil.replaceStr(paramjson);
			bean = (ElectInfoCountSearchBean) JSONObject.parseObject(paramjson,ElectInfoCountSearchBean.class);
		}
		try {

//			ElectInfoDao daojson = (ElectInfoDao) DaoImplClassUtil.getDaoImplClass("electInfoDaoImpls");
			ElectInfoDaoImpl impl = new ElectInfoDaoImpl();
			pb = impl.ta_oa_attendanceleave(bean, sortName, sortOrder,
					offset, maxPagesize);

		} catch (Exception e) {
			LOG.error(e);
		}
		return pb;
	}

/**
 * 
  * <b>Summary: </b>
  *     复写方法 getDataList
  * @param parmStr
  * @param sortName
  * @param sortOrder
  * @return 
  * @see com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl#getDataList(java.lang.String, java.lang.String, java.lang.String)
 */
	public PagingBean getDataList(String parmStr, String sortName, String sortOrder) {
		return null;
	}
}
