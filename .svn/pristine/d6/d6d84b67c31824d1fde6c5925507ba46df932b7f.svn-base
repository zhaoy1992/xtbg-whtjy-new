package com.chinacreator.xtbg.wangcheng.virtualappmanager.dao;

import java.sql.SQLException;
import java.util.HashMap;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.wangcheng.virtualappmanager.entity.AppStoreBean;




/**
 * @description 应用商店信息Dao
 * @author yin.liu
 * @date 2012-1-31
 */
public interface AppStoreDao {
	/**
	 * @Description 根据条件查询应用商店信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findAppStoreList(AppStoreBean appStoreBean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * @Description 根据条件查询未分配的应用商店信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findAppStoreList_grant(AppStoreBean appStoreBean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * @Description 添加应用商店信息
	 * @param appStoreBean 应用商店Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void addAppStore(AppStoreBean appStoreBean) throws SQLException;
	
	/**
	 * @Description  删除应用商店信息
	 * @param appIds
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean delAppStore(String appIds) throws SQLException;
	
	/**
	 * @Description 修改应用商店信息
	 * @param appStoreBean 应用商店Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void updateAppStore(AppStoreBean appStoreBean) throws SQLException;
	
	/**
	 * @Description 根据应用ID获得应用信息
	 * @param appid 应用商店id
	 * @return boolean
	 * @throws SQLException 
	 */
	public AppStoreBean getAppStoreBeanById(String appid) throws SQLException;
	
	/**
	 * 获取图标集合
	 * @return
	 * @throws Exception
	 */
	public HashMap<String,String> getAppIconMap() throws Exception;
	
	/**
	 * 获取应用类别集合
	 * @return
	 * @throws Exception
	 */
	public HashMap<String,String> getAppTypeMap() throws Exception;
	
	/**
	 * 获取应用class类集合
	 * @return
	 * @throws Exception
	 */
	public HashMap<String,String> getClassNameMap() throws Exception;
	
	
}
