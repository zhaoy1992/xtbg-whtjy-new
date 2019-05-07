package com.chinacreator.xtbg.core.personwork.dao;

import java.sql.SQLException;
import java.util.List;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.personwork.entity.PGroupBean;
import com.chinacreator.xtbg.core.personwork.entity.PriManageBean;

/**
 * 
 *<p>Title:PriManageDao.java</p>
 *<p>Description:权限管理</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-6-14
 */
public interface PriManageDao {
	/**
	 * 
	 *<b>Summary: 查询分页信息</b> queryGroup(请用一句话描述这个方法的作用)
	 * 
	 * @param pbGroupBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 */
	public PagingBean queryGroup(PGroupBean pbGroupBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws SQLException;

	/**
	 * 
	 *<b>Summary: 根据条件查询流程信息 分页显示</b> findPriManageBeanList(请用一句话描述这个方法的作用)
	 * 
	 * @param prBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 */
	public PagingBean findPriManageBeanList(PriManageBean prBean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws SQLException;

	/**
	 * 
	 *<b>Summary: 插入权限条目</b> insertPrivilege(请用一句话描述这个方法的作用)
	 * 
	 * @param prBean
	 * @return
	 */
	boolean insertPrivilege(PriManageBean prBean) throws SQLException;

	/**
	 * 
	 *<b>Summary: 根据条件查询分组集合</b> queryGroup4List(请用一句话描述这个方法的作用)
	 * 
	 * @param pbGroupBean
	 * @return
	 */
	public List<PGroupBean> queryGroup4List(PGroupBean pbGroupBean) throws SQLException ;

	/**
	 * 
	*<b>Summary: 根据分组id查询分组信息</b>
	* queryGroup(请用一句话描述这个方法的作用)
	* @param groupId  通讯录分组的id
	* @return  分组对象
	* @throws SQLException
	 */
	public PGroupBean queryGroup(String groupId) throws SQLException;
}
