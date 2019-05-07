package com.chinacreator.xtbg.core.paper.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.paper.dao.PaperDao;
import com.chinacreator.xtbg.core.paper.entity.PaperBean;
/**
 * 
 *<p>Title:PaperCountList.java</p>
 *<p>Description:信息统计查询列表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-9-22
 */
public class PaperCountList extends DataInfoImpl {

	private static final Logger LOG = Logger.getLogger(PaperCountList.class);
	PaperDao paperdao = (PaperDao)LoadSpringContext.getApplicationContext().getBean("paperDaoImpl");
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
		PaperBean model = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			model = (PaperBean) JSONObject.parseObject(parmjson, PaperBean.class);
		}
		try {
			pb = paperdao.selCountPaperList(model, sortName, sortOrder, offset, maxPagesize);
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
