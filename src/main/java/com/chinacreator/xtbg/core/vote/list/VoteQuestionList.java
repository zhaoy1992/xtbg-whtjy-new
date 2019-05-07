package com.chinacreator.xtbg.core.vote.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.vote.dao.VotePaperDao;
import com.chinacreator.xtbg.core.vote.entity.OAVoteQuestionBean;

/**
 * 
 *<p>
 * Title:VoteQuestionList.java
 * </p>
 *<p>
 * Description:查询问卷问题列表
 * </p>
 *<p>
 * Copyright:Copyright (c)2013
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 戴连春
 *@version 1.0 2013-5-16
 */
public class VoteQuestionList extends DataInfoImpl {
	private static final Logger LOG = Logger.getLogger(VoteQuestionList.class);

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
		OAVoteQuestionBean bean = null;
		PagingBean pb = null;
		try {
			// 获得查询参数
			if (!StringUtil.isBlank(parmjson)) {
				parmjson = DataControlUtil.replaceStr(parmjson);
				bean = JSONObject.parseObject(parmjson,
						OAVoteQuestionBean.class);
			}

			VotePaperDao dao = (VotePaperDao) LoadSpringContext
					.getApplicationContext().getBean("votePaperDaoImpl");
			// 查询问题列表
			pb = dao.findQuestionPaginBean(bean, sortName, sortOrder, offset,
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
		// TODO Auto-generated method stub
		return null;
	}

}
