package com.chinacreator.xtbg.core.directory.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.directory.dao.DirectoryDao;
import com.chinacreator.xtbg.core.directory.entity.DirectoryBean;

public class BirthdayList extends DataInfoImpl{
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(BirthdayList.class);

	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		DirectoryBean directoryBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			directoryBean = (DirectoryBean) JSONObject.parseObject(parmjson, DirectoryBean.class);
		}
		
		try {
			DirectoryDao daojson = (DirectoryDao)LoadSpringContext.getApplicationContext().getBean("directoryDaoImpl");
			pb = daojson.getBirthdayList(directoryBean, sortName, sortOrder, offset, maxPagesize);
			
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return pb;
	}

	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		// TODO Auto-generated method stub
		return null;
	}

}
