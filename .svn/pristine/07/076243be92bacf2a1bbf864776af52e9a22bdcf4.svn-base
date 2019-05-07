package com.chinacreator.xtbg.zhangjiajie.inforeported.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.zhangjiajie.inforeported.dao.UnitsetupDao;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.UnitsetupBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.service.UnitsetupServiceIfc;
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
public class UnitsetupServiceImpl implements UnitsetupServiceIfc {

	/**
	 * 保存上报单位信息
	 * @param flowInfoBean
	 * @return
	 */
	public boolean saveUnitsetup(String paramjosn) throws Exception {
		UnitsetupBean unitsetupBean = new UnitsetupBean();
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			unitsetupBean = (UnitsetupBean) JSONObject.parseObject(paramjosn, UnitsetupBean.class);
		}
		
		UnitsetupDao dao = (UnitsetupDao)DaoImplClassUtil.getDaoImplClass("unitsetupDaoImpl");
		dao.addUnitsetup(unitsetupBean);
		return true;

	}

	/**
	 * @Description: 修改上报单位信息
	 * @throws Exception
	 */
	public boolean updateUnitsetup(String paramjosn) throws Exception {
		UnitsetupBean unitsetupBean = new UnitsetupBean();
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			unitsetupBean = (UnitsetupBean) JSONObject.parseObject(paramjosn, UnitsetupBean.class);
		}
		
		UnitsetupDao dao = (UnitsetupDao)DaoImplClassUtil.getDaoImplClass("unitsetupDaoImpl");
		dao.updateIUnitsetup(unitsetupBean);
		return true;

	}

	/**
	 * @Description: 查询要修改的上报单位信息
	 * @throws Exception
	 */
	public UnitsetupBean getUnitsetupBeanById(String id) throws Exception {
		UnitsetupDao dao = (UnitsetupDao)DaoImplClassUtil.getDaoImplClass("unitsetupDaoImpl");
		return dao.getUnitsetupBeanById(id);
	}

	/**
	 * @Description: 删除上报单位信息
	 * @throws Exception
	 */
	public boolean delUnitsetup(String unitsetup_ids) throws Exception {
		UnitsetupDao dao = (UnitsetupDao)DaoImplClassUtil.getDaoImplClass("unitsetupDaoImpl");
		dao.delUnitsetup(unitsetup_ids);
		return true;
	
		
	}
	
}
