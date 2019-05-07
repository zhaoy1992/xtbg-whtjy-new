package com.chinacreator.xtbg.core.vote.dao;

import java.sql.Connection;
import java.sql.SQLException;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>
 * Title:MessageSendDao.java
 * </p>
 *<p>
 * Description:网上投票短信发送接口
 * </p>
 *<p>
 * Copyright:Copyright (c)2013
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 戴连春
 *@version 1.0 2013-5-21
 */
public interface MessageSendDao<T extends XtDbBaseBean> {
	/**
	 * 
	*<b>Summary:发送短信，具体处理方式让具体的子类实现 </b>
	* sendMsg(请用一句话描述这个方法的作用)
	* @param msg 短信发送成功还是失败
	* @return
	 */
	public boolean sendMsg(T msg, Connection con)
	throws SQLException;
}
