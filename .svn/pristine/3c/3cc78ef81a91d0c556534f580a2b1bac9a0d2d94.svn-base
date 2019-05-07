package com.chinacreator.xtbg.yimingju.mail.dao.impl;

import java.util.HashMap;
import java.util.Map;

import com.chinacreator.xtbg.pub.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.yimingju.mail.dao.MailConfigDao;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:MailConfigDaoImpl.java</p>
 *<p>Description:邮件配置实现</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *@author 夏天
 *@version 1.0
 *2013-10-30
 */
public class MailConfigDaoImpl extends XtDbBaseDao implements MailConfigDao{
	
	@Override
	public Map<String, String> getUserEmailBoxMemoryConfig(String userids) throws Exception {
		Map<String,String> resultMap = new HashMap<String,String>();
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select user_id,memory from oa_mail_memoryconfig o where o.user_id in ("+userids+")");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		
		for(int i = 0 ; i < pdb.size() ; i++){
			resultMap.put(pdb.getString(i, "user_id"), pdb.getString(i, "memory"));
		}
		return resultMap;
	}
	
}
