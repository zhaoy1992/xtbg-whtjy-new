package com.chinacreator.xtbg.core.workbench.cache;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.workbench.dao.OnlineTopDao;
import com.chinacreator.xtbg.core.workbench.dao.UserLoginInfoDao;
import com.chinacreator.xtbg.core.workbench.entity.OnlineTopBean;
import com.chinacreator.xtbg.core.workbench.entity.UserCacheBean;
import com.chinacreator.xtbg.core.workbench.support.WorkbenchConstants;

/**
 *<p>Title:WorkbenchUserCache.java</p>
 *<p>Description:工作台用户信息缓存</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-25
 */
public class WorkbenchUserCache {
	
	private static final Log LOG = LogFactory.getLog(WorkbenchUserCache.class);
	
	private static Map<String, UserCacheBean> userCacheMap = null;//工作台用户缓存数据
	
	private static Map<String, Timestamp> userLoginTimeMap = new HashMap<String, Timestamp>();//记录用户新的登陆时间
	
	private static OnlineTopBean onlineTopBean = null; //系统最高在线用户数缓存
	
	private UserLoginInfoDao userLoginInfoDao = null;
	private OnlineTopDao onlineTopDao = null;
	
	public void setUserLoginInfoDao(UserLoginInfoDao userLoginInfoDao) {
		this.userLoginInfoDao = userLoginInfoDao;
	}

	public void setOnlineTopDao(OnlineTopDao onlineTopDao) {
		this.onlineTopDao = onlineTopDao;
	}

	/**
	*<b>Summary: </b>
	* getUserCache(根据用户id获取用户缓存数据)
	* @param userId
	* @return
	*/
	public static UserCacheBean getUserCache(String userId) {
		if(userCacheMap != null){
			return userCacheMap.get(userId);
		}else{
			return null;
		}
	}
	
	/**
	*<b>Summary: </b>
	* getOnlineTopBean(获取最高在线用户数缓存)
	* @return
	*/
	public static OnlineTopBean getOnlineTopBean() {
		return onlineTopBean;
	}

	/**
	*<b>Summary: </b>
	* setOnlineTopBean(设置最高现用户数缓存)
	* @param onlineTopBean
	*/
	public static void setOnlineTopBean(OnlineTopBean onlineTopBean) {
		WorkbenchUserCache.onlineTopBean = onlineTopBean;
	}

	/**
	*<b>Summary: </b>
	* init(缓存数据初始化)
	* @throws Exception
	*/
	@PostConstruct
	public void init() throws Exception {
		Connection conn = null;
		try{
			conn = DbManager.getInstance().getConnection();
			userCacheMap = new HashMap<String, UserCacheBean>();
			List<UserCacheBean> list = userLoginInfoDao.queryAllUserLoginInfo(conn);
			for(UserCacheBean bean : list){
				userCacheMap.put(bean.getUserid(), bean);
			}
			
			onlineTopBean = onlineTopDao.queryOnlineTop(conn);
			LOG.info("加载用户登陆信息缓存成功");
		}catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(),e);
			throw e;
		}finally{
			DbManager.closeConnection(conn);
		}
	}
	
	/**
	*<b>Summary: </b>
	* userLoginIn(用户登录)
	* @param userID 用户id
	* @param userName	用户名
	* @param loginIp	登陆ip
	*/
	public static void userLoginIn(String userID,String userName,String loginIp){
		String action = "";//操作类型
		int loginnumber = 1; // 登录次数
		Timestamp lastlogin = new Timestamp(System.currentTimeMillis()); // 最后登录时间
		userLoginTimeMap.put(userID, lastlogin);
		UserCacheBean userCacheBean = new UserCacheBean();
		if(userCacheMap.containsKey(userID)){//用户登录过系统  ,更新操作
			action = WorkbenchConstants.LOGIN_IN_UPDATE;
			UserCacheBean bean = userCacheMap.get(userID);
			loginnumber = bean.getLoginnumber() + 1;//登陆次数加一
			bean.setLoginnumber(loginnumber);//缓存中的登录次数加一
			
			userCacheBean.setAction(action);
			userCacheBean.setLastlogin(lastlogin);
			userCacheBean.setLastloginip(loginIp);
			userCacheBean.setLoginnumber(loginnumber);
			userCacheBean.setUserid(userID);
			userCacheBean.setUsername(userName);
			
		}else{
			action = WorkbenchConstants.ADD;
			userCacheBean.setAction(action);
			userCacheBean.setLastlogin(lastlogin);
			userCacheBean.setLastloginip(loginIp);
			userCacheBean.setLoginnumber(loginnumber);
			userCacheBean.setUserid(userID);
			userCacheBean.setUsername(userName);
			
			userCacheMap.put(userID, userCacheBean);//将用户登录数据放到缓存中
		}
		UserLoginInfoThread.addTask(userCacheBean);//添加任务
	}
	
	/**
	*<b>Summary: </b>
	* userLoginOut(用户退出登录)
	* @param userID
	* @param userName
	*/
	public static void userLoginOut(String userID,String userName) {
		UserCacheBean userCacheBean = new UserCacheBean();
		userCacheBean.setAction(WorkbenchConstants.LOGIN_OUT_UPDATE);
		userCacheBean.setLastout( new Timestamp(System.currentTimeMillis()));
		userCacheBean.setUserid(userID);
		if(userLoginTimeMap.containsKey(userID)){
			UserCacheBean bean = userCacheMap.get(userID);
			if(bean != null){
				bean.setLastlogin(userLoginTimeMap.get(userID));//退出登录时更新缓存中的上次登录时间
			}else{
				LOG.error("用户退出时，userCacheMap 没有用户登陆信息缓存。");//出现此错误，那就是缓存出现问题
			}
		}else{
			LOG.error("用户退出时，userLoginTimeMap 没有用户登陆时间。");//出现此错误，那就是缓存出现问题
		}
		UserLoginInfoThread.addTask(userCacheBean);//添加任务
	}
}
