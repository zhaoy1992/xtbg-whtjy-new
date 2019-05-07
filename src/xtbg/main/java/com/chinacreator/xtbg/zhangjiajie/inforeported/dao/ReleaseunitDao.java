package com.chinacreator.xtbg.zhangjiajie.inforeported.dao;

import java.sql.SQLException;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.ReleaseunitBean;

/**
 *<p>Title:ReleaseunitDao.java</p>
 *<p>Description:发布栏目Dao接口类</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-2-20
 */
public interface ReleaseunitDao {

	/**
	 * @Description 根据条件查询发布栏目
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findReleaseunitList(ReleaseunitBean releaseunitBean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * @Description 添加发布栏目
	 * @param ReleaseunitBean 发布栏目Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void addReleaseunit(ReleaseunitBean releaseunitBean) throws SQLException;
	
	/**
	 * @Description  删除发布栏目
	 * @param releaseunit_id
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean delReleaseunit(String releaseunit_id) throws SQLException;
	
	/**
	 * @Description 修改发布栏目
	 * @param ReleaseunitBean  发布栏目Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void updateReleaseunit(ReleaseunitBean releaseunitBean) throws SQLException;
	
	/**
	 * @Description 根据用户ID获得发布栏目信息
	 * @return boolean
	 * @throws SQLException 
	 */
	public ReleaseunitBean getReleaseunitBeanById(String id) throws SQLException;
}
