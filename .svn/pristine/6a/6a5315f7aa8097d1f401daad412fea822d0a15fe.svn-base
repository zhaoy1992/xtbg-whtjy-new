package com.chinacreator.xtbg.wangcheng.virtualappmanager.service;

import java.util.HashMap;

import com.chinacreator.xtbg.wangcheng.virtualappmanager.entity.AppStoreBean;




/**
 * description 应用商店service接口层
 * author yin.liu
 * date 2012-1-31
 */
public interface AppStoreServiceIfc {

	/**
	 * @Description  保存应用信息
	 * 
	 * @param paramjosn  要保存的数据对象
	 * @return  boolean
	 * @exception 
	 */
	public boolean saveAppStore(String paramjosn);
	
	/**
	 * @Description  根据用户ID获得应用对象
	 * 
	 * @param id  应用ID
	 * @return  InstanceBean 应用对象
	 * @exception 
	 */
	public AppStoreBean getAppStoreBeanById(String id);
	
	/**
	 * @Description  修改应用信息
	 * 
	 * @param paramjosn  要修改的数据对象
	 * @return  boolean
	 * @exception 
	 */
	public boolean updateAppStore(String paramjosn);
	
	/**
	 * @Description  删除应用信息
	 * 
	 * @param ids  //要删除的应用ID
	 * @return  boolean
	 * @exception 
	 */
	public boolean delAppStore(String ids);
	
	/**
	 * 获取图标集合
	 * @return
	 * @throws Exception
	 */
	public HashMap<String,String> getAppIconMap();
	
	/**
	 * 获取应用类别集合
	 * @return
	 * @throws Exception
	 */
	public HashMap<String,String> getAppTypeMap();
	
	/**
	 * 获取应用class类集合
	 * @return
	 * @throws Exception
	 */
	public HashMap<String,String> getClassNameMap();
}
