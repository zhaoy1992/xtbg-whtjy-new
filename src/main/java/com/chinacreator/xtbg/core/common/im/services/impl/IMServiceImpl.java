package com.chinacreator.xtbg.core.common.im.services.impl;

import org.jivesoftware.smack.Chat;
import org.jivesoftware.smack.Connection;
import org.jivesoftware.smack.ConnectionConfiguration;
import org.jivesoftware.smack.XMPPConnection;

import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.im.entity.IMBean;
import com.chinacreator.xtbg.core.common.im.services.IMService;
/**
 *<p>Title:IMServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-8-8
 */
public class IMServiceImpl implements IMService {
	
	private String ip; //openfire 服务器ip
    private Integer port; //openfire 服务端口
    private String domain; //openfire 服务器 域

	public void setIp(String ip) {
		this.ip = ip;
	}

	public void setPort(Integer port) {
		this.port = port;
	}

	public void setDomain(String domain) {
		this.domain = domain;
	}

	/**
	  * <b>Summary: </b>
	  *     复写方法 sendMsg
	  * @param imBean
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.im.services.IMService#sendMsg(com.chinacreator.xtbg.core.common.im.entity.IMBean, java.sql.Connection)
	 */
	@Override
	public boolean sendMsg(IMBean imBean, java.sql.Connection conn) throws Exception {
		String send_user = UserCache.getUserCacheBean(imBean.getSend_user()).getUser_name();
		String send_user_pwd = UserCache.getUserCacheBean(imBean.getSend_user()).getUser_password();
		String recv_user = UserCache.getUserCacheBean(imBean.getRecv_user()).getUser_name()+domain;
		Connection con = getConnection();  
        con.connect();  
        con.login(send_user, send_user_pwd); 
        Chat mychat = con.getChatManager().createChat(recv_user,null);  
        mychat.sendMessage(imBean.getMsg()); // 发送信息  
        con.disconnect(); // 断开连接  
		return true;
	}
	
	private Connection getConnection() {  
        ConnectionConfiguration config = new ConnectionConfiguration(ip, port);  
        Connection connection = new XMPPConnection(config);  
        return connection;  
    }  

}
