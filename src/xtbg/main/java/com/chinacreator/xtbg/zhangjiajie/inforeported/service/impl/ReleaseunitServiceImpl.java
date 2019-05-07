package com.chinacreator.xtbg.zhangjiajie.inforeported.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.zhangjiajie.inforeported.dao.InfoTypeDao;
import com.chinacreator.xtbg.zhangjiajie.inforeported.dao.ReleaseunitDao;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoTypeBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.ReleaseunitBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.service.InfoTypeServiceIfc;
import com.chinacreator.xtbg.zhangjiajie.inforeported.service.ReleaseunitServiceIfc;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;

/**
 *<p>Title:ReleaseunitServiceImpl.java</p>
 *<p>Description:信息类型服务实现类</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-2-20
 */
public class ReleaseunitServiceImpl implements ReleaseunitServiceIfc {

	/**
	 * 保存发布栏目信息
	 * @param paramjosn
	 * @return
	 */
	public boolean saveReleaseunit(String paramjosn) throws Exception {
		ReleaseunitBean releaseunitBean = new ReleaseunitBean();
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			releaseunitBean = (ReleaseunitBean) JSONObject.parseObject(paramjosn, ReleaseunitBean.class);
		}
		
		ReleaseunitDao dao = (ReleaseunitDao)DaoImplClassUtil.getDaoImplClass("releaseunitDaoImpl");
		dao.addReleaseunit(releaseunitBean);
		return true;

	}

	/**
	 * @Description: 修改发布栏目信息
	 * @throws Exception
	 */
	public boolean updateReleaseunit(String paramjosn) throws Exception {
		ReleaseunitBean releaseunitBean = new ReleaseunitBean();
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			releaseunitBean = (ReleaseunitBean) JSONObject.parseObject(paramjosn, ReleaseunitBean.class);
		}
		
		ReleaseunitDao dao = (ReleaseunitDao)DaoImplClassUtil.getDaoImplClass("releaseunitDaoImpl");
		dao.updateReleaseunit(releaseunitBean);
		return true;

	}


	/**
	 * @Description: 查询要修改的发布栏目信息
	 * @throws Exception
	 */
	public ReleaseunitBean getReleaseunitBeanById(String id) throws Exception {
		ReleaseunitDao dao = (ReleaseunitDao)DaoImplClassUtil.getDaoImplClass("releaseunitDaoImpl");
		return dao.getReleaseunitBeanById(id);
	}

	/**
	 * @Description: 删除发布栏目信息
	 * @throws Exception
	 */
	public boolean delReleaseunit(String releaseunit_ids) throws Exception {
		ReleaseunitDao dao = (ReleaseunitDao)DaoImplClassUtil.getDaoImplClass("releaseunitDaoImpl");
		dao.delReleaseunit(releaseunit_ids);
		return true;
	
		
	}
	
}
