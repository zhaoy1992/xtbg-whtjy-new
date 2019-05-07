package com.chinacreator.xtbg.yimingju.mail.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.mail.dao.MailDao;
import com.chinacreator.xtbg.yimingju.mail.dao.impl.MailDaoImpl;
import com.chinacreator.xtbg.yimingju.mail.entity.MailBean;
/**
 *<p>Title:邮件--收件箱分页查询</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author dijun.sheng
 *@version 1.0
 *2012-11-15
 */
public class MailList implements DataInfoImpl{
	private static final Logger LOG = Logger.getLogger(MailList.class);
	
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		MailBean mailBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			parmjson = Escape.unescape(parmjson);
			mailBean = (MailBean) JSONObject.parseObject(parmjson, MailBean.class);
		}
		try {
			MailDao  carManageWxbyDao =new MailDaoImpl();
			pb = carManageWxbyDao.findMailInfoList(mailBean, sortName, sortOrder, offset, maxPagesize);	
		} catch (Exception e) {
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
