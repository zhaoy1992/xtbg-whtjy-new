package com.chinacreator.xtbg.caizhengting.ibrary.service;

import java.util.List;

import com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryBorrowInfoBean;

/**
 *<p>Title:IbraryBorrowInfoService.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛
 *@version 1.0
 *2013-9-3
 */
public interface IbraryBorrowInfoService {
	/**
	 * 
	*<b>Summary: </b>
	* addIbraryTree(增加图书分类信息)
	* @param bean
	* @return
	 */
	public String addbean(IbraryBorrowInfoBean bean);
	
	/**
	 * 
	*<b>Summary: </b>
	* getbeanbyid(根据ID 获取BEAN)
	* @param id
	* @return
	 */
	public IbraryBorrowInfoBean getbeanbyid(String id);
	
	/**
	 * 
	*<b>Summary: </b>
	* getlistbybookid(根据图书ID 查询所有借阅历史)
	* @param id
	* @return
	 */
	public List<IbraryBorrowInfoBean> getlistbybookid(String id);
	
	/**
	 * 
	*<b>Summary: </b>
	* getAgreementExpireRemindTime(获取系统参数设置 归还时间天数)
	* @return
	 */
	public String getAgreementExpireRemindTime();
	
	/**
	 * 
	*<b>Summary: </b>
	* updatebean(根据ID 更新归还时间 或者 归还图书操作)
	* @return
	 */
	public String updatebean(IbraryBorrowInfoBean bean);
	
	
	/**
	 * 
	*<b>Summary: </b>
	* delteBookBorrowinfobyBookId(删除图书时 同时删除借阅历史)
	* @param id
	* @return
	 */
	public String delteBookBorrowinfobyBookId(String id);
}
