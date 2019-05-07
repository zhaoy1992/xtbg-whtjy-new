package com.chinacreator.xtbg.zhangjiajie.inforeported.dao;

import java.sql.SQLException;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoTypeBean;

/**
 *<p>Title:InfoTypeDao.java</p>
 *<p>Description:信息类型Dao接口类</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-2-20
 */
public interface InfoTypeDao {

	/**
	 * @Description 根据条件查询信息类型
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findInfoTypeList(InfoTypeBean infoTypeBean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * @Description 添加信息类型
	 * @param InfoTypeBean 信息类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void addInfoType(InfoTypeBean infoTypeBean) throws SQLException;
	
	/**
	 * @Description  删除信息类型
	 * @param userIds
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean delInfoType(String infotype_id) throws SQLException;
	
	/**
	 * @Description 修改信息类型
	 * @param InfoTypeBean  信息类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void updateInfoType(InfoTypeBean infoTypeBean) throws SQLException;
	
	/**
	 * @Description 根据用户ID获得信息类型
	 * @param userBean 用户Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public InfoTypeBean getInfoTypeBeanById(String id) throws SQLException;
}
