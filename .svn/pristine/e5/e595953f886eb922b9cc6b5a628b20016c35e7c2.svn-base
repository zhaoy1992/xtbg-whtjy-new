package com.chinacreator.xtbg.yimingju.mail.service.impl;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.pub.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.yimingju.mail.dao.MailConfigDao;
import com.chinacreator.xtbg.yimingju.mail.dao.impl.MailConfigDaoImpl;
import com.chinacreator.xtbg.yimingju.mail.dao.impl.MailDaoImpl;
import com.chinacreator.xtbg.yimingju.mail.entity.MailBoxMemoryConfigBean;
import com.chinacreator.xtbg.yimingju.mail.service.MailConfigServiceIfc;

/**
 * 
 *<p>Title:MailConfigServiceImpl.java</p>
 *<p>Description:邮箱配置服务实现</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *@author 夏天
 *@version 1.0
 *2013-10-30
 */
public class MailConfigServiceImpl implements MailConfigServiceIfc {

	private static final Logger LOG = Logger.getLogger(MailConfigServiceImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveMailConfigInfo
	  * @param user_ids
	  * @param memory
	  * @return 
	  * @see com.chinacreator.xtbg.yimingju.mail.service.MailConfigServiceIfc#saveMailConfigInfo(java.lang.String, java.lang.String)
	 */
	public boolean saveMailConfigInfo(String user_ids, String memory) {
		MailConfigDao mailConfigDao = new MailConfigDaoImpl();
		MailBoxMemoryConfigBean mailBoxMemoryConfigBean = new MailBoxMemoryConfigBean();
		mailBoxMemoryConfigBean.setUpdateKey("user_id");
		mailBoxMemoryConfigBean.setUser_id(user_ids);
		mailBoxMemoryConfigBean.setMemory(memory);
		boolean flag = false;
		try {
			((BaseDao)mailConfigDao).update(mailBoxMemoryConfigBean);
			flag = true;
		} catch (Exception e) {
			LOG.error(e.getMessage());
		}
		return flag;
	}
	
	
}
