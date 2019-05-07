package com.chinacreator.xtbg.core.archive.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.archive.dao.WordArchiveDao;
import com.chinacreator.xtbg.core.archive.entity.ArchiveDispatchBean;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
/**
 * 
 *<p>Title:UnionArchiveFeedBackList.java</p>
 *<p>Description:联合发文监控</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-12-4
 */
public class UnionArchiveFeedBackList extends DataInfoImpl {

	private static final Logger LOG = Logger.getLogger(UnionArchiveFeedBackList.class);
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
		ArchiveDispatchBean archiveDispatchBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			archiveDispatchBean = (ArchiveDispatchBean) JSONObject.parseObject(parmjson, ArchiveDispatchBean.class);
			archiveDispatchBean.setUnion_archive("1");
		}
			
		try {
			WordArchiveDao dao = (WordArchiveDao)LoadSpringContext.getApplicationContext().getBean("wordArchiveDaoImpl");
			//UnionArchiveFeedBackThread unionArchiveFeedBackThread = (UnionArchiveFeedBackThread)LoadSpringContext.getApplicationContext().getBean("unionArchiveFeedBackThread");
			//unionArchiveFeedBackThread.feedback();
			pb = dao.findArchiveDispatchBeanList(archiveDispatchBean, sortName, sortOrder, offset, maxPagesize);
			
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
