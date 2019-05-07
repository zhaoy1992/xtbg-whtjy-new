package com.chinacreator.xtbg.zhangjiajie.inforeported.dao;

import java.sql.SQLException;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.UnitsetupBean;

/**
 *<p>Title:UnitsetupDao.java</p>
 *<p>Description:上报单位Dao接口类</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-2-20
 */
public interface UnitsetupDao {

	/**
	 * @Description 根据条件查询上报单位
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findUnitsetupList(UnitsetupBean unitsetupBean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * @Description 添加上报单位
	 * @param UnitsetupBean 上报单位Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void addUnitsetup(UnitsetupBean unitsetupBean) throws SQLException;
	
	/**
	 * @Description  删除上报单位
	 * @param unitsetup_id
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean delUnitsetup(String unitsetup_id) throws SQLException;
	
	/**
	 * @Description 修改上报单位
	 * @param UnitsetupBean  上报单位Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void updateIUnitsetup(UnitsetupBean unitsetupBean) throws SQLException;
	
	/**
	 * @Description 根据用户ID获得上报单位信息
	 * @throws SQLException 
	 */
	public UnitsetupBean getUnitsetupBeanById(String id) throws SQLException;
	
	/**
	 * 判断当前机构在数据库中是否已被使用
	 * @param orgid
	 * @return
	 * @throws SQLException
	 */
	public boolean isExsitUnitsetupInfo4Org(String orgid) throws SQLException;
}
