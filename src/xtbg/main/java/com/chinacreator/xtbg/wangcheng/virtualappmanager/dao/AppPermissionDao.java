package com.chinacreator.xtbg.wangcheng.virtualappmanager.dao;

import java.sql.SQLException;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.wangcheng.virtualappmanager.entity.AppPermissionBean;



/**
 * description Ӧ��ע��Dao
 * author yin.liu
 * date 2012-2-2
 */
public interface AppPermissionDao {

	/**
	 * @Description ����������ѯ�ѷ����Ӧ��ע����Ϣ
	 * ��ҳ��ʾ
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findAppPermissionList(AppPermissionBean appPermission, String sortName, String sortOrder, long offset, int maxPagesize);

	/**
	 * @Description ���Ӧ��ע����Ϣ
	 * @param appPermission Ӧ��ע��Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void addAppPermission(AppPermissionBean appPermission) throws SQLException;
	
	/**
	 * @Description  ɾ��Ӧ��ע����Ϣ
	 * @param pids
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean delAppPermission(String pids) throws SQLException;
	/**
	 * 
	*<b>Summary: </b>
	* insertAppToWait(���²˵���ȡ��ʶ)
	* @param orgid
	* @throws SQLException
	 */
	public void insertAppToWait(String orgid) throws SQLException;
}
