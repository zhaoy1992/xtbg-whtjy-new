package com.chinacreator.xtbg.wangcheng.androidversion.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.wangcheng.androidversion.dao.AndroidVersionDao;
import com.chinacreator.xtbg.wangcheng.androidversion.dao.imploracle.AndroidVersionDaoImpl;
import com.chinacreator.xtbg.wangcheng.androidversion.entity.AndroidVersionBean;

/**
 * @description 移动版本控制列表
 * @author yin.liu
 * @date 2012-3-2
 */
public class AndroidVersionList implements DataInfoImpl {

	private static final Logger LOG = Logger.getLogger(AndroidVersionList.class);
	
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		AndroidVersionBean bean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			bean = (AndroidVersionBean)JSONObject.parseObject(parmjson,AndroidVersionBean.class);
		}
		try {
			AndroidVersionDao daojson = new AndroidVersionDaoImpl();
			pb = daojson.findAndroidVersionBeanList(bean, sortName, sortOrder, offset, maxPagesize);
		}catch (Exception e) {
			LOG.error(e);
		}
		return pb;
	}

	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		return null;
	}

}
