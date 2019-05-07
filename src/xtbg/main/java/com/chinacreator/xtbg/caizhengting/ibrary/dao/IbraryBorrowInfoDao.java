package com.chinacreator.xtbg.caizhengting.ibrary.dao;

import java.sql.Connection;
import java.util.List;

import com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryBorrowInfoBean;
import com.chinacreator.xtbg.pub.common.PagingBean;

/**
 *<p>Title:IbraryBorrowInfoDao.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛
 *@version 1.0
 *2013-9-3
 */
public interface IbraryBorrowInfoDao {
	public String addbean(IbraryBorrowInfoBean bean,Connection con)throws Exception;
	public PagingBean list(IbraryBorrowInfoBean bean,String sortName, String sortOrder, long offset, int maxPagesize,Connection con) throws Exception ;
	public IbraryBorrowInfoBean getbeanbyid(String id,Connection con)throws Exception;
	public List<IbraryBorrowInfoBean> getlistbybookid(String id,Connection con)throws Exception;
	public String getAgreementExpireRemindTime(Connection conn)throws Exception;
	public String updatebean(IbraryBorrowInfoBean bean,Connection con)throws Exception;;
	public String delteBookBorrowinfobyBookId(String id,Connection con)throws Exception;;
	/**
	 * 我借阅的读书list
	*<b>Summary: </b>
	* myList(请用一句话描述这个方法的作用)
	* @param bean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @param con
	* @return
	* @throws Exception
	 */
	public PagingBean myList(IbraryBorrowInfoBean bean,String sortName, String sortOrder, long offset, int maxPagesize,Connection con) throws Exception ;
}
