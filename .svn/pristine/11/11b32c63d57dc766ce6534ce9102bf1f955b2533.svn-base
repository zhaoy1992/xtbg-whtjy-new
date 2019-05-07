package com.chinacreator.business.common.tools;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.chinacreator.business.common.bean.AuthorityConfig;
import com.chinacreator.business.common.bean.FristBean;
import com.chinacreator.business.common.exception.SystemException;
import com.chinacreator.business.common.publuc.Dictionary;

/**
 * <p>
 * Title:ScheduleServlet.java
 * </p>
 * <p>
 * Description:缓存管理类
 * </p>
 * <p>
 * Company:湖南
 * </p>
 * @author 沈联成
 * @version 1.0 2012-11-20
 */
public class CacheCommonManage {
	private static final Logger logger = Logger.getLogger(CacheCommonManage.class);
	private static final Map<String, Object> SYS = new HashMap<String, Object>();
	private static CacheCommonManage uniqueInstance = null;
    //单例实现
	private CacheCommonManage() {
		logger.debug("init CacheCommonManage .....");
	}

	public static CacheCommonManage getInstance(){
		if (uniqueInstance == null) {
			uniqueInstance = new CacheCommonManage();
			//值对像初始化
			Map<String, Object> action = new HashMap<String, Object>();
			SYS.put(Dictionary.ACTION_MAP_KEY, action);
			Map<String, String> sys = new HashMap<String, String>();
			SYS.put(Dictionary.SYSTEM_DIC, sys);
			
			//uniqueInstance.init();
		}
		return uniqueInstance;
	}
	
	public void init() throws SystemException{
		
		//初始化系统数据
		InitSystemManage.getInstance().initSystemProperties();
		InitSystemManage.getInstance().initActonXml();
		InitSystemManage.getInstance().initFristXML();
		InitSystemManage.getInstance().initAuthXML();
	}
	
	public String getSystemParam(String key){
		return ((Map<String, String>)SYS.get(Dictionary.SYSTEM_DIC)).get(key);
	}
	
	public Object getCacheMap(String key){
		return SYS.get(key);
	}
	
	public Object getAction(String key){
		return ((Map<String, Object>)SYS.get(Dictionary.ACTION_MAP_KEY)).get(key);
	}
	
	public void putFrist(Object obj){
		SYS.put(Dictionary.FRIST_BEAN, obj);
	}
	
	public FristBean getFrist(){
		return (FristBean) SYS.get(Dictionary.FRIST_BEAN);
	}
	
	public void putAuth(Object obj){
		SYS.put("Auth_sys", obj);
	}
	
	public Map<String, AuthorityConfig>  getAuth(){
		return (Map<String, AuthorityConfig> ) SYS.get("Auth_sys");
	}
}
