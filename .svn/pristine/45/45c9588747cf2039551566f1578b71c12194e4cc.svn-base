package com.chinacreator.xtbg.core.vote.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.vote.dao.VoteViewDao;
import com.chinacreator.xtbg.core.vote.entity.VotePaperBean;

/**
 * 
 *<p>
 * Title:VotePaperOperateList.java
 * </p>
 *<p>
 * Description:用户可以填写的问卷，跟人员评测列表
 * </p>
 *<p>
 * Copyright:Copyright (c) 2010
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author shuqi.liu
 *@version 1.0 2013-5-15
 */
public class VoteCompleteList extends DataInfoImpl {
	private static final Logger LOG = Logger
			.getLogger(VotePaperOperateList.class);

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getDataList
	 * 
	 * @param parmjson
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @see com.chinacreator.xtbg.pub.common.DataInfoImpl#getDataList(java.lang.String,
	 *      java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		VotePaperBean bean = null;
		PagingBean pb = null;
		// 获得查询参数
		if (!StringUtil.isBlank(parmjson)) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			bean = (VotePaperBean) JSONObject.parseObject(parmjson,
					VotePaperBean.class);
		}
		try {
			VoteViewDao dao = (VoteViewDao) LoadSpringContext
					.getApplicationContext().getBean("voteViewDaoImpl");
			pb = dao.findCompletePaginBean(bean, sortName, sortOrder, offset,
					maxPagesize);
		} catch (Exception e) {
			LOG.error("查询问卷分页信息出现异常", e);
		}
		return pb;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getDataList
	 * 
	 * @param parmjson
	 * @param sortName
	 * @param sortOrder
	 * @return
	 * @see com.chinacreator.xtbg.pub.common.DataInfoImpl#getDataList(java.lang.String,
	 *      java.lang.String, java.lang.String)
	 */
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		return null;
	}

}
