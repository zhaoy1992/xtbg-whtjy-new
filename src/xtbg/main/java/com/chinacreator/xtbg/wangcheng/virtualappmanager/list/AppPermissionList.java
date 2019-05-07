package com.chinacreator.xtbg.wangcheng.virtualappmanager.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.wangcheng.virtualappmanager.dao.AppPermissionDao;
import com.chinacreator.xtbg.wangcheng.virtualappmanager.dao.imploracle.AppPermissionDaoImpl;
import com.chinacreator.xtbg.wangcheng.virtualappmanager.entity.AppPermissionBean;

/**
 * description 应用注册列表
 * author yin.liu
 * date 2012-2-2
 */
public class AppPermissionList  implements DataInfoImpl {
	
	private static final Logger LOG = Logger.getLogger(AppPermissionList.class);
	
	/**
	 * 查询应用注册列表(分页)
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		AppPermissionBean bean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			bean = (AppPermissionBean)JSONObject.parseObject(parmjson,AppPermissionBean.class);
		}
		try {
			AppPermissionDao dao = new AppPermissionDaoImpl();
			pb = dao.findAppPermissionList(bean, sortName, sortOrder, offset, maxPagesize);
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
