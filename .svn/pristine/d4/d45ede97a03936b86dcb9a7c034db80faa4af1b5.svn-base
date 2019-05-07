package com.chinacreator.xtbg.wangcheng.androidversion.dao;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.wangcheng.androidversion.entity.AndroidVersionBean;
import com.chinacreator.xtbg.wangcheng.androidversion.entity.AndroidVersionUpGradeLogBean;



/**
 * @description 移动版本控制
 * @author yin.liu
 * @date 2012-3-2
 */
public interface AndroidVersionDao {

	/**
	 * @Description 根据条件查询手机版本信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findAndroidVersionBeanList(AndroidVersionBean bean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * 插入手机版本信息
	 * @param bean
	 */
	public void insertAndroidVersionBean(AndroidVersionBean bean) throws Exception; 
	
	/**
	 * @Description 根据条件查询客户端升级日志列表
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findAndroidVersionUpGradeLogBeanList(AndroidVersionUpGradeLogBean bean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * 根据id删除手机版本信息
	 * @param id
	 * @return
	 */
	public boolean delAndroidVersionBean(String id) throws Exception;
	
	/**
	 * 根据id获取版本信息
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public AndroidVersionBean getAndroidVersionBeanByid(String id) throws Exception;
	
	/**
	 * 根据版本名称查询是否存在
	 * @param name
	 * @return
	 * @throws Exception
	 */
	public boolean isHasByversionName(String name) throws Exception;
	
	/**
	 * 获得当前最新版本的名称
	 * @param userid
	 * @return
	 */
	public String getCurrentMaxVersionName();
	/**
	 * 
	*<b>Summary: </b>
	* saveAndroidVersionBean(保存版本信息)
	* @param bean
	* @return
	 */
	public boolean saveAndroidVersionBean(AndroidVersionBean bean) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* updateAndroidVersionBean(更新版本信息)
	* @param bean
	* @return
	 */
	public boolean updateAndroidVersionBean(AndroidVersionBean bean)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* queryMaxXuHao(查找出最大的序号)
	* @return
	 */
	public int queryMaxXuHao()throws Exception;
}
