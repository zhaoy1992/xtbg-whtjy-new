package com.chinacreator.xtbg.pub.flowinfoconif.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.flowinfoconif.dao.FlowInfoDao;
import com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowWfactUser;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;

public class FlowActUserList implements DataInfoImpl{

	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(FlowActUserList.class);
	

	/**
	 * @Description  查询文件列表
	 * 
	 * @param request
	 * @param response
	 * @return  返回JOSNOBJECT
	 * @exception 
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		FlowWfactUser flowWfactUserBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			flowWfactUserBean = (FlowWfactUser) JSONObject.parseObject(parmjson, FlowWfactUser.class);
		}
		
		try {
			FlowInfoDao fInfodao = (FlowInfoDao)DaoImplClassUtil.getDaoImplClass("flowInfoDaoImpl");
			pb = fInfodao.findFlowWfactionUserInfoList(flowWfactUserBean, sortName, sortOrder, offset, maxPagesize);
			
		} catch (Exception e) {
			LOG.error(e);
		}
		return pb;
	}


	public PagingBean getDataList(String parmStr, String sortName, String sortOrder) {
		
		return null;
	}


}
