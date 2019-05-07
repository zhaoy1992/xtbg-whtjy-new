package com.chinacreator.xtbg.zhangjiajie.inforeported.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.zhangjiajie.inforeported.dao.InfoTypeDao;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoTypeBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.service.InfoTypeServiceIfc;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;

/**
 *<p>Title:InfoTypeServiceImpl.java</p>
 *<p>Description:信息类型服务实现类</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-2-20
 */
public class InfoTypeServiceImpl implements InfoTypeServiceIfc {

	/**
	 * 保存信息类型
	 * @param flowInfoBean
	 * @return
	 */
	public boolean saveInfoType(String paramjosn) throws Exception {
		InfoTypeBean infoTypeBean = new InfoTypeBean();
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			infoTypeBean = (InfoTypeBean) JSONObject.parseObject(paramjosn, InfoTypeBean.class);
		}
		
		InfoTypeDao dao = (InfoTypeDao)DaoImplClassUtil.getDaoImplClass("infoTypeDaoImpl");
		dao.addInfoType(infoTypeBean);
		return true;

	}

	/**
	 * @Description: 修改信息类型
	 * @throws Exception
	 */
	public boolean updateInfoType(String paramjosn) throws Exception {
		InfoTypeBean infoTypeBean = new InfoTypeBean();
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			infoTypeBean = (InfoTypeBean) JSONObject.parseObject(paramjosn, InfoTypeBean.class);
		}
		
		InfoTypeDao dao = (InfoTypeDao)DaoImplClassUtil.getDaoImplClass("infoTypeDaoImpl");
		dao.updateInfoType(infoTypeBean);
		return true;

	}


	public InfoTypeBean getInfoTypeBeanById(String id) throws Exception {
		InfoTypeDao dao = (InfoTypeDao)DaoImplClassUtil.getDaoImplClass("infoTypeDaoImpl");
		return dao.getInfoTypeBeanById(id);
	}

	/**
	 * @Description: 删除信息类型
	 * @throws Exception
	 */
	public boolean delInfoType(String infotype_ids) throws Exception {
		boolean flag = true;
		InfoTypeDao dao = (InfoTypeDao)DaoImplClassUtil.getDaoImplClass("infoTypeDaoImpl");
		flag = dao.delInfoType(infotype_ids);
		return flag;
	
		
	}
	
}
