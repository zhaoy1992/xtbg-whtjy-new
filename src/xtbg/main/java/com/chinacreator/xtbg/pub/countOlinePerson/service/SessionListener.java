package com.chinacreator.xtbg.pub.countOlinePerson.service;

import java.sql.Connection;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.transaction.RollbackException;

import org.apache.log4j.Logger;

import com.chinacreator.business.common.tools.CacheCommonManage;
import com.chinacreator.security.authorization.AuthPrincipal;
import com.chinacreator.xtbg.pub.countOlinePerson.dao.SessionListenerDao;
import com.chinacreator.xtbg.pub.countOlinePerson.entity.CountOnlineBean;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.frameworkset.orm.transaction.TransactionManager;
import com.ibm.icu.text.SimpleDateFormat;
/**
 * 
 * @author weiwei.liu
 * 每当session的属性被修改时此监听器都会进行捕获触发事件
 *
 */
public class SessionListener implements HttpSessionAttributeListener{
	public static final Logger logger = Logger.getLogger(SessionListener.class.getName());
	/** 
     * 定义存储客户登录session的集合. 
     * sessionSet主要用它的size来记录当天在线人数
     * sessionMap保存每个用户和session的对应的记录
     */  
    private static Set<Object> sessionSet = new HashSet<Object>();  
    
    //add by 王博 2013-4-8
    private static Map<String,String> onlineuser = new HashMap<String,String>();
    
    public static Map<String, String> getOnlineuser() {
		return onlineuser;
	}
    
	public static void setOnlineuser(Map<String, String> onlineuser) {
		SessionListener.onlineuser = onlineuser;
	}
   //add end
    
    
    
   
	private static Map<String,String> sessionMap= new HashMap<String, String>();
    /**
     * 用户名和密码
     * 因需要经过多次执行此监听器，才能捕获到username和session等其他属性
     * 所有设置为静态变量
     */
    private static String username="";
    private static String sessionId="";
    private static String outsessionId="";
    private static String ip="";
    /** 
     * 定义监听的session属性名. 
     */  
    public final static String LISTENER_NAME = "PRINCIPAL_INDEXS";  
    public final static String LISTENER_NAME1 = "SESSIONID_CACHE_KEY";  
    /**
     * 监听session加入方法
     */
    @Override
	public synchronized void attributeAdded(HttpSessionBindingEvent sbe) {
    	/*Connection conn = null;*/
    	TransactionManager tm=new TransactionManager();
		try {
			tm.begin();
		
			/*conn = DbconnManager.getInstance().getTransactionConnection();*/
			String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
			SessionListenerDao dao = (SessionListenerDao) DaoImplClassUtil.getDaoImplClass("sessionListenerDaoImpl");
	    	//获得登录用户名
	    	if(LISTENER_NAME.equals(sbe.getName())){
	    		Map map=new  HashMap();
	    		map= (Map) sbe.getValue();
	    		AuthPrincipal authPrincipal=(AuthPrincipal) map.get("console");
	    		if(!"admin".equals(authPrincipal.getName())){
	    		  sessionSet.add(authPrincipal.getName());
	    		  //add by 王博 2013-4-8
	    		  onlineuser.put(authPrincipal.getName(),(String) sbe.getSession().getAttribute("USER_ID"));
	    		//add end
	    		}
	    		String top= dao.queryTop();
	    		if(!"".equals(top)){
	    			if(sessionSet.size()>Integer.parseInt(top)){
	    				dao.saveTopInfo(Integer.toString(sessionSet.size()));
	    			}
	    		}else{
	    			dao.saveTopInfo(Integer.toString(sessionSet.size()));
	    		}
	    		username=authPrincipal.getName();
	    		//System.out.println(authPrincipal.getName()+"@当前在线人数："+sessionSet.size());
	    	}
	    	//获得sessionId
	    	if(LISTENER_NAME1.equals(sbe.getName())){
				sessionId = (String) sbe.getValue();
			}
	    	//获得登录ip
	    	if("REMOTEADDR_CACHE_KEY".equals(sbe.getName())){
	    		ip=(String) sbe.getValue();
	    		System.out.println("最后ip："+sbe.getValue());
	    	}
	    	
	    	//将每次登录的username和sessionId放入map中，sessionId为key，username为value
	    	if(!"".equals(username)&&!"".equals(sessionId)){
	    			sessionMap.put(sessionId, username);
					CountOnlineBean countOnlineBean=new CountOnlineBean();
					countOnlineBean.setUsername(username);
					countOnlineBean.setSessionid(sessionId);
					countOnlineBean.setLogin_ip(ip);
					countOnlineBean.setLogin_time(queryCurrentdate());
					/*if(!"431003".equals(userArea)){*/
						//dao.saveLoginInfo(countOnlineBean, "0");
						if(dao.queryUser(countOnlineBean)){
							dao.saveUserLoginInfo(countOnlineBean);
						}else{
							dao.updateLoginInfo(countOnlineBean, "0");
						}
					/*}*/
		    		sessionId="";
		    		username="";
		    		ip="";
	    	}
	    	tm.commit();
	    	} catch (Exception e) {
	    		logger.error(e.getMessage());
	    		try {
					tm.rollback();
				} catch (RollbackException e1) {
					logger.error(e1.getMessage());
					e1.printStackTrace();
				}
			} 		
	    	
	    	
		/*} catch (Exception e) {
			if(conn != null){
				DbconnManager.rollback(conn);
			}
			e.printStackTrace();
			logger.info(e.getMessage());
		}finally{
			if(conn != null){
				DbconnManager.closeConnection(conn);
			}
		}*/
	}
    /**
     * 监听session失效方法
     */
	@Override
	public synchronized void attributeRemoved(HttpSessionBindingEvent sbe) {
		//获得失效sessionid
		if(LISTENER_NAME1.equals(sbe.getName())){
			sessionSet.removeAll(sessionSet);
			outsessionId = (String) sbe.getValue();
			 //add by 王博 2013-4-8
			onlineuser.remove(sessionMap.get(outsessionId));
			//add end
			sessionMap.remove(outsessionId);
			Collection<String> c = sessionMap.values();
		    Iterator it = c.iterator();
		    for (; it.hasNext();) {
		    	Object o = it.next(); 
		    	String value = o.toString(); 
		        sessionSet.add(value);
		    }
//		    System.out.println("退出时当前人数:"+sessionSet.size());
		}
		//当获得失效的sessionid和ip地址后更新
    	if(!"".equals(outsessionId)){
    		CountOnlineBean countOnlineBean=new CountOnlineBean();
    		try {
				SessionListenerDao dao = (SessionListenerDao) DaoImplClassUtil.getDaoImplClass("sessionListenerDaoImpl");
				countOnlineBean.setSessionid(outsessionId);
				countOnlineBean.setLogin_ip(ip);
				countOnlineBean.setOut_time(queryCurrentdate());
				//dao.saveLoginInfo(countOnlineBean, "1");
				dao.updateLoginInfo(countOnlineBean, "1");
			} catch (Exception e) {
				e.printStackTrace();
				logger.info(e.getMessage());
			}
    		outsessionId="";
    	}
	}
	/**
     * 监听session替换方法
     */
	@Override
	public void attributeReplaced(HttpSessionBindingEvent sbe) {
		
	}
	/** 
     * 返回当前客户登录session的集合. 
     * @return sessionList
     */  
    public static Set<Object> getSessions() {  
        return  sessionSet;  
    }  
    /**
     * 返回最高在线人数
     */
    public String queryPeakNum(Connection conn){
    	String top="";
    	try {
			SessionListenerDao dao = (SessionListenerDao) DaoImplClassUtil.getDaoImplClass("sessionListenerDaoImpl");
			top=dao.queryTop();
		} catch (Exception e) {
			e.printStackTrace();
			logger.info(e.getMessage());
		}
    	return top;
    }
    /**
     * 查询当前登录用户的总登录次数和上次登录ip
     */
    public String queryPersonInfo(String username,Connection conn){
    	String info="";
    	try {
			SessionListenerDao dao = (SessionListenerDao) DaoImplClassUtil.getDaoImplClass("sessionListenerDaoImpl");
			info= dao.queryPsersonInfo(username);
		} catch (Exception e) {
			e.printStackTrace();
			logger.info(e.getMessage());
		}
    	return info;
    }
    
    /**
     * 获得当前时间
     */
    public String queryCurrentdate(){
    	Date date =new Date();
    	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	String datestr= sdf.format(date);
    	return datestr;
    }
}
