package com.chinacreator.xtbg.pub.common;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.jboss.logging.Logger;

import com.chinacreator.business.common.bean.FristBean;
import com.chinacreator.business.common.bean.FristBean.PendingItem.DataClass.MethodParams;
import com.chinacreator.business.common.exception.ExceptionAbstract;
import com.chinacreator.business.common.exception.SystemException;
import com.chinacreator.business.common.publuc.SysErrorCodeDictionary;
import com.chinacreator.business.common.tools.CacheCommonManage;
import com.chinacreator.business.common.tools.CacheCommonManageProxy;
import com.chinacreator.task.Execute;
import com.chinacreator.xtbg.pub.countOlinePerson.service.SessionListener;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DbconnManager;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:IndexCache.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-4-8
 */
public class IndexCache implements Execute{
	
	private static final Logger LOG = Logger.getLogger(IndexCache.class);
	private static final long serialVersionUID = 1L;
	private static Map<String, Map<String, Object>> userIndexMap;//在线用户 首页缓存
	
	public static Map<String, Map<String, Object>> getUserIndexMap() {
		return userIndexMap;
	}

	public static void setUserIndexMap(String user_id,Map<String, Object> indexData) {
		if(userIndexMap == null){
			userIndexMap = new HashMap<String, Map<String,Object>>();
		}
		userIndexMap.put(user_id, indexData);
	}

	/**
	  * <b>Summary:刷新在线用户缓存数据 </b>
	  *     复写方法 execute
	  * @param arg0 
	  * @see com.chinacreator.task.Execute#execute(java.util.Map)
	 */
	@Override
	public void execute(Map arg0) {
		Map<String, String> onlineuserMap =  SessionListener.getOnlineuser();
		Set<String> keySet = onlineuserMap.keySet();
		for(String userName : keySet){
			String userid= onlineuserMap.get(userName);
			try {
				userIndexMap.put(userid, queryUserIndexData(userid, userName));
			} catch (SQLException e) {
				continue;
			}
		}
	
	}
	/**
	 * 
	*<b>Summary: </b>
	* updateUserIndexData(根据当前登录的用户id,跟用户名称来刷新)
	* @param userid
	* @param userName
	 */
	public void updateUserIndexData(String userid,String userName){
		try {
			userIndexMap.remove(userid);
			userIndexMap.put(userid, queryUserIndexData(userid, userName));
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
	}
	/*
	public static void initIndexCache() {
		Connection conn = null;
		try {
			conn = DbconnManager.getInstance().getTransactionConnection();
			PreparedDBUtil pdb = new PreparedDBUtil();
			String sql = "select u.user_id,u.user_name from td_sm_user u where u.user_name != 'admin'";
			pdb.preparedSelect(sql);
			pdb.executePrepared(conn);
			
			for (int i = 0; i < pdb.size(); i++) {
				userIndexMap.put(pdb.getString(i, "user_id"), queryUserIndexData(pdb.getString(i, "user_id"), pdb.getString(i, "user_name"),conn));
			}
		} catch (SQLException e) {
			DbconnManager.rollback(conn);
			e.printStackTrace();
		} finally {
			DbconnManager.closeConnection(conn);
		}
	}*/
	
	
	public static HashMap<String, Object> queryUserIndexData(String user_id,String user_name) throws SQLException {
		HashMap<String, Object> result = new HashMap<String, Object>();
		Connection conn = null;
		try{
			PreparedDBUtil db = new PreparedDBUtil();
			conn = DbconnManager.getInstance().getTransactionConnection();
			
			//result.put("userName", bean.getUserName());
			SessionListener sessionListener = new SessionListener();
			String inSystemTotal = String.valueOf(SessionListener.getSessions().size());
			String topInSysTotal = sessionListener.queryPeakNum(conn);
			String sysTotal[] = sessionListener.queryPersonInfo(user_name,conn).split(",");//TODO 添加连接事物
			result.put("loginTotal", sysTotal[1]);
			result.put("lastTime", sysTotal[0]);
			result.put("inSystemTotal", inSystemTotal);
			result.put("topInSysTotal", topInSysTotal);
			/*result.put("userID", bean.getUserID());
			result.put("userRealName", bean.getUserName());
			result.put("userName", bean.getUserKey());
			result.put("orgID", bean.getUserDeptID());*/
			result.put("sysName",
					CacheCommonManageProxy.getSystemParam("firstPage_SYS_NAME"));
			result.put("weatherURL", CacheCommonManageProxy.getSystemParam("firstPage_weather_forecast_url"));

			// 读取首页配置
			FristBean fristBean = CacheCommonManage.getInstance().getFrist();
			// 1.显示侍办事项与内容
			ArrayList<FristBean.PendingItem> pendingList = fristBean.getPending();

			Map<String,String> classRequestParams = new HashMap<String,String>();
			classRequestParams.put("userid", user_id);
			classRequestParams.put("username", user_name);
			if (null != pendingList) {
				ArrayList<Object> list = new ArrayList<Object>();
				result.put("pending", list);
				Map<String, String> map = null;
				int total = 0;
				for (FristBean.PendingItem item : pendingList) {
					int rowTotal = 0;
					try {
						if (null != item.getRuleSql()
								&& !"".equals(item.getRuleSql().trim())) {
							db.preparedSelect(item.getRuleSql());
							db.setString(1, user_id);
							db.executePrepared(conn);
							if (db.size() == 0) {
								continue;
							}
						}
						map = new HashMap<String, String>();
						map.put("param", item.getUrlParam());
						map.put("name", item.getName());
						map.put("url", item.getClickurl());
						map.put("id", item.getId());
						map.put("clickType", item.getClickType());
						String param[] = null;
						if (null != item.getUrlParam()
								&& !"".equals(item.getUrlParam().trim())) {
							param = item.getUrlParam().split(",");
						}
						/****2013.5.29 modified by 夏天      新增一种获取待办总数的方式，在配置文件中可以指定 获取总数的类和方法，如果存在则通过指定的类中的方法去获取总数，否则通过sql获取总数************/
						if(null != item.getDataClass() && !StringUtil.nullOrBlank(item.getDataClass().getClassname()) && !StringUtil.nullOrBlank(item.getDataClass().getMethod())){
							List<MethodParams> methodParamsList = item.getDataClass().getMethodparams();
							for(MethodParams params : methodParamsList){//可以在配置文件中配置调用方法时传入的参数
								classRequestParams.put(params.getName(), params.getValue());
							}
							rowTotal = Integer.parseInt(getTotalByClass(classRequestParams,item.getDataClass().getClassname(),item.getDataClass().getMethod()).toString());
						}else{
							db.preparedSelect(item.getSql());
							int lenght  = item.getSql().split("[?]").length;
							for(int i = 1;i<lenght;i++){
								db.setString(i, user_id);
							}
							db.executePrepared(conn);
							if (db.size() > 0) {
								rowTotal = db.getInt(0, "total");
								if (null != param) {
									for (String p : param)
										map.put(p, db.getString(0, p));
								}
							}
						}
						
					} catch (Exception e) {
						System.out.println(item.getSql() + ":" + user_id);
						e.printStackTrace();
					}
					total = rowTotal + total;
					map.put("total", rowTotal + "");
					list.add(map);
				}
				result.put("waitingTotal", total);
			}
			// 2.显示首页的详细信息
			ArrayList<FristBean.ShowItem> showList = fristBean.getItem();
			if (null != showList) {
				ArrayList<Object> list = new ArrayList<Object>();
				result.put("item", list);
				Map<String, Object> map = null;
				for (FristBean.ShowItem item : showList) {
					try {
						if (null != item.getRuleSql()
								&& !"".equals(item.getRuleSql().trim())) {
							db.preparedSelect(item.getRuleSql());
							db.setString(1, user_id);
							db.executePrepared(conn);
							if (db.size() == 0) {
								continue;
							}
						}
						map = new HashMap<String, Object>();
						map.put("param", item.getUrlParam());
						map.put("name", item.getName());
						map.put("showType", item.getShowType());
						map.put("viewType", item.getViewType());
						map.put("id", item.getId());
						map.put("clickType", item.getClickType());
						map.put("moreUrl", item.getMoreUrl());
						map.put("url", item.getClickurl());
						map.put("row", item.getShowRow());
						String[] showType = item.getShowType().split(",");
						String param[] = null;
						if (null != item.getUrlParam()
								&& !"".equals(item.getUrlParam().trim())) {
							param = item.getUrlParam().split(",");
						}
						db.preparedSelect(item.getSql());
						db.setString(1, user_id);
						db.executePrepared();
						ArrayList<Object> showItemList = new ArrayList<Object>();
						map.put("itemList", showItemList);
						Map<String, Object> itemMap = null;
						for (int i = 0; i < db.size(); i++) {
							itemMap = new HashMap<String, Object>();
							for (String type : showType) {
								itemMap.put(type, db.getString(i, type));
							}
							if (null != param)
								for (String p : param)
									itemMap.put(p, db.getString(i, p));
							showItemList.add(itemMap);
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
					list.add(map);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			LOG.error(e.getMessage(), e);
		}
		finally{
			DbconnManager.closeConnection(conn);
		}
		return result;
	}
	/**
	 * 
	*<b>Summary: 根据指定的类中的方法获得待办统计总数</b>
	* @param classRequestParams
	* @param classNameId
	* @param methodName
	* @return
	* @throws Exception
	 */
	public static Object getTotalByClass(Map classRequestParams,String classNameId,String methodName) throws Exception{
		Object obj = DaoImplClassUtil.getDaoImplClass(classNameId);

		if(null == obj){
			throw new SystemException(SysErrorCodeDictionary.NO_CLASS_ERROR);
		}
		Method method = null;
		try {
			method = obj.getClass().getDeclaredMethod(methodName,
					Map.class);
		} catch (SecurityException e) {
			throw new SystemException(SysErrorCodeDictionary.FUN_ERROR,e.getMessage());
		} catch (NoSuchMethodException e) {
			throw new SystemException(SysErrorCodeDictionary.FUN_ERROR);
		}
		try {
			obj = method.invoke(obj, new Object[] { classRequestParams });
		} catch (IllegalArgumentException e) {
			throw new SystemException(SysErrorCodeDictionary.FUN_ERROR);
		} catch (IllegalAccessException e) {
			throw new SystemException(SysErrorCodeDictionary.FUN_ERROR);
		} catch (InvocationTargetException e) {
			if( e.getTargetException() instanceof ExceptionAbstract){
				throw ((ExceptionAbstract) e.getTargetException());
			}else{
				throw new SystemException(SysErrorCodeDictionary.FUN_INVOKE_ERROR);
			}
		}
		return obj;
	}
}
