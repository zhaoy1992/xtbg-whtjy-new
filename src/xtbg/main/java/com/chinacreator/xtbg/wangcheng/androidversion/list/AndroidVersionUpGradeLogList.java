package com.chinacreator.xtbg.wangcheng.androidversion.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.wangcheng.androidversion.dao.AndroidVersionDao;
import com.chinacreator.xtbg.wangcheng.androidversion.dao.imploracle.AndroidVersionDaoImpl;
import com.chinacreator.xtbg.wangcheng.androidversion.entity.AndroidVersionUpGradeLogBean;

/**
 * @description 移动客户端升级日志列表
 * @author yin.liu
 * @date 2012-11-14
 */
public class AndroidVersionUpGradeLogList implements DataInfoImpl {

	private static final Logger LOG = Logger.getLogger(AndroidVersionUpGradeLogList.class);
	
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		AndroidVersionUpGradeLogBean bean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			bean = (AndroidVersionUpGradeLogBean)JSONObject.parseObject(parmjson,AndroidVersionUpGradeLogBean.class);
		}
		try {
			AndroidVersionDao daojson = new AndroidVersionDaoImpl();
			pb = daojson.findAndroidVersionUpGradeLogBeanList(bean, sortName, sortOrder, offset, maxPagesize);
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
