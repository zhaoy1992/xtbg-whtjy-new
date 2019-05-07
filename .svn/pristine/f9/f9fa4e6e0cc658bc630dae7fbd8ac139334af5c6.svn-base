package com.chinacreator.xtbg.core.workbench.session;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.workbench.cache.WorkbenchUserCache;
import com.chinacreator.xtbg.core.workbench.dao.OnlineTopDao;
import com.chinacreator.xtbg.core.workbench.entity.OnlineTopBean;
import com.chinacreator.xtbg.core.workbench.entity.UserSessionBean;
/**
 *<p>Title:SessionListener.java</p>
 *<p>Description:系统session监听类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-26
 */
public class SessionListener implements HttpSessionAttributeListener{
	
	private static final Logger LOG = Logger.getLogger(SessionListener.class);
	
	private final static String ONLINE_USER = "ONLINE_USER"; //登陆用户信息  map对象 session中key值 
	
	//key 为sessionid
    private static Map<String,UserSessionBean> onlineUserSessionMap = new HashMap<String,UserSessionBean>();
    
    //key 为用户id
    private static Map<String,UserSessionBean> onlineUserIdMap = new HashMap<String,UserSessionBean>();
    
    //当前在线用户数
    private static List<UserSessionBean> onlineUser = new ArrayList<UserSessionBean>();
    
    /**
    *<b>Summary: </b>
    * getOnlineUser(获取当前在线用户数)
    * @return
    */
	public static List<UserSessionBean> getOnlineUser() {
		return onlineUser;
	}
   
    /**
      * <b>Summary: 监听session添加属性</b>
      *     复写方法 attributeAdded
      * @param sbe 
      * @see javax.servlet.http.HttpSessionAttributeListener#attributeAdded(javax.servlet.http.HttpSessionBindingEvent)
     */
	@Override
	public synchronized void attributeAdded(HttpSessionBindingEvent sbe) {
		try {
	    	//获得登录用户数据
	    	if(ONLINE_USER.equals(sbe.getName())){
				UserSessionBean userSessionBean = (UserSessionBean) sbe.getValue();
	    		String sessionId = userSessionBean.getSession_id();
	    		String userId = userSessionBean.getUser_id();
	    		if(!"1".equals(userId) && !onlineUserIdMap.containsKey(userId)){//不是admin && 用户没有同时多次重复登录
	    			onlineUserIdMap.put(userId, userSessionBean);
	    			onlineUserSessionMap.put(sessionId, userSessionBean);
		    		onlineUser.add(userSessionBean);
	    		}
	    		
	    		int onlineTopCount = WorkbenchUserCache.getOnlineTopBean().getPersonnum();
	    		if(onlineTopCount < onlineUser.size()){//新的最大在线用户数 数据库中做记录
	    			OnlineTopDao onlineTopDao = (OnlineTopDao)LoadSpringContext.getApplicationContext().getBean("onlineTopDao");
	    			OnlineTopBean bean = new OnlineTopBean();
	    			bean.setId(StringUtil.getUUID());
	    			bean.setPersonnum(onlineUser.size());
	    			bean.setRecode_time(new Timestamp(System.currentTimeMillis()));
	    			WorkbenchUserCache.setOnlineTopBean(bean);//更最大在线数据缓存
	    			onlineTopDao.insertOnlineTop(bean, null);
	    		}
	    		WorkbenchUserCache.userLoginIn(userSessionBean.getUser_id(), userSessionBean.getUser_name(), userSessionBean.getLogin_ip());
	    	}
    	} catch (Exception e) {
    		LOG.error(e.getMessage(),e);
		} 		
	}

	/**
	  * <b>Summary: 监听session失效方法</b>
	  *     复写方法 attributeRemoved
	  * @param sbe 
	  * @see javax.servlet.http.HttpSessionAttributeListener#attributeRemoved(javax.servlet.http.HttpSessionBindingEvent)
	 */
	@Override
	public synchronized void attributeRemoved(HttpSessionBindingEvent sbe) {
		//获得失效sessionid
		if("SESSIONID_CACHE_KEY".equals(sbe.getName())){
			String sessionId = (String)sbe.getValue();//失效的sessionid
			UserSessionBean userSessionBean = onlineUserSessionMap.get(sessionId);
			if(userSessionBean != null && !"1".equals(userSessionBean.getUser_id())){
				onlineUserIdMap.remove(userSessionBean.getUser_id());
				WorkbenchUserCache.userLoginOut(userSessionBean.getUser_id(), userSessionBean.getUser_name());
			}
			onlineUser.remove(userSessionBean);
			onlineUserSessionMap.remove(sessionId);
			
    	}
	}
	
	/**
     * 监听session替换方法
     */
	@Override
	public void attributeReplaced(HttpSessionBindingEvent sbe) {
		
	}
}
