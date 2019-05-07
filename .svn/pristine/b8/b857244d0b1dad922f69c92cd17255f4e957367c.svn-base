package com.chinacreator.xtbg.core.guestreception.dao;

import java.util.List;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.guestreception.entity.GuestReceiveBean;
import com.chinacreator.xtbg.core.guestreception.entity.GuestreceptionBean;
import com.chinacreator.xtbg.core.guestreception.entity.QueryBean;
/**
 * 
 *<p>Title:GuestreceptionDao.java</p>
 *<p>Description:接待管理实体接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-9-5
 */
public interface GuestreceptionDao {

	
	 /**
	  * 
	 *<b>Summary: </b>
	 * queryGuestInfo(查询接待管理信息列表)
	 * @param guestreceptionBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param pagesize
	 * @return
	 * @throws Exception
	  */
	 public PagingBean queryGuestInfo(GuestreceptionBean guestreceptionBean,
				String sortName, String sortOrder, long offset, int pagesize) throws Exception;
	 /**
	  * 
	 *<b>Summary: </b>
	 * queryViewGuestInfo(查询接收人的接待管理信息列表)
	 * @param guestreceptionBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	  */
	 public PagingBean queryViewGuestInfo(GuestreceptionBean guestreceptionBean,
				String sortName, String sortOrder, long offset, int maxPagesize) throws Exception;
	
	 /**
	  * 查询联系人电话号码
	  */
	public String queryUserPhone(String userId)throws Exception;
	/**
	 * 查询性别
	 */
	public List<GuestReceiveBean> queryUserBaseInfo(String userid)throws Exception;
	/*
	 * 查询基本信息
	 */
	public QueryBean queryGuestInfoAll(String grinfoId)throws Exception;
	/*
	 * 变更查看状态
	 */
	public void changeViewState(String grinfoId,String userId,String stateValue)throws Exception;
}
