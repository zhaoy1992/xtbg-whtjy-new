package com.chinacreator.xtbg.core.kbm.list;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.kbm.dao.KbmDocRssDao;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocRssBean;
/**
 * 
 *<p>Title:KbmDocRssList.java</p>
 *<p>Description:知识库订阅文档列表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-13
 */
public class KbmDocRssList extends DataInfoImpl {

	private static final Log LOG=LogFactory.getLog(KbmDocRssList.class);
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
		KbmDocRssBean model = new KbmDocRssBean();
		PagingBean pb = null;
		KbmDocRssDao dao = (KbmDocRssDao)LoadSpringContext.getApplicationContext().getBean("kbmDocRssDaoImpl");
		if (!StringUtil.isBlank(parmjson) ) {
			model = (KbmDocRssBean) JSONObject.parseObject(parmjson, KbmDocRssBean.class);
		}
		try {
			pb = dao.queryKbmDocRssList(model, sortName, sortOrder, offset, maxPagesize);
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
