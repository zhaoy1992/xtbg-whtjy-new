package com.chinacreator.xtbg.wangcheng.virtualappmanager.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.wangcheng.virtualappmanager.dao.AppStoreDao;
import com.chinacreator.xtbg.wangcheng.virtualappmanager.dao.imploracle.AppStoreDaoImpl;
import com.chinacreator.xtbg.wangcheng.virtualappmanager.entity.AppStoreBean;


/**
 * description 未分配应用商店列表
 * author yin.liu
 * date 2012-1-31
 */
public class AppStoreGrantList implements DataInfoImpl {

	private static final Logger LOG = Logger.getLogger(AppStoreGrantList.class);
	
	/**
	 * 查询未分配应用商店列表(分页)
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		AppStoreBean appStoreBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			appStoreBean = (AppStoreBean)JSONObject.parseObject(parmjson,AppStoreBean.class);
		}
		try {
			AppStoreDao daojson = new  AppStoreDaoImpl();
			pb = daojson.findAppStoreList_grant(appStoreBean, sortName, sortOrder, offset, maxPagesize);
		}catch (Exception e) {
			LOG.error(e);
		}
		return pb;
	}

	
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		return null;
	}

}
