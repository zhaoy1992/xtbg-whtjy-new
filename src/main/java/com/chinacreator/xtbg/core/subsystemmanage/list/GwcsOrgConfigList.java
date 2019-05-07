package com.chinacreator.xtbg.core.subsystemmanage.list;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.subsystemmanage.dao.SubSystemOrgConfigDao;

/**
 * 
 *<p>Title:GwcsOrgConfigList.java</p>
 *<p>Description:公文传输配置列表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 夏天
 *@version 1.0
 *2013-5-2
 */
public class GwcsOrgConfigList extends DataInfoImpl{

	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(GwcsOrgConfigList.class);
	
	
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
	  * @see com.chinacreator.xtbg.pub.common.DataInfoImpl#getDataList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	@SuppressWarnings("unchecked")
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		 Map<String,String> map = new HashMap<String,String>();
		 PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			parmjson = Escape.unescape(parmjson);
			map = JSONObject.parseObject(parmjson, HashMap.class);
		}
		try {
			SubSystemOrgConfigDao dao = (SubSystemOrgConfigDao)LoadSpringContext.getApplicationContext().getBean("gwcsOrgConfigDaoImpl");
			pb = dao.findSubSystemOrgConfigList(map, sortName, sortOrder, offset, maxPagesize);

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
