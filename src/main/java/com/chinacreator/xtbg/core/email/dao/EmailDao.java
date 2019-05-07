package com.chinacreator.xtbg.core.email.dao;

import java.util.HashMap;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.email.entity.EmailBaseBean;


/**
 * 
 *<p>Title:EmailDao.java</p>
 *<p>Description:电子邮件接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-11-19
 */
public interface EmailDao {
	/**
	 * 
	*<b>Summary: </b>
	* findMailInfoList(分页查询邮件)
	* @param mailBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	 */
	public PagingBean findMailInfoList(EmailBaseBean mailBean,String sortName, String sortOrder, long offset, int maxPagesize)throws Exception ;
	/**
	 * 
	*<b>Summary: </b>
	* findMailInfoListByYjSend(分页查询已发邮件)
	* @param mailBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	 */
	public PagingBean findMailInfoListByYjSend(EmailBaseBean mailBean,String sortName, String sortOrder, long offset, int maxPagesize) ;
	/**
	 * 
	*<b>Summary: </b>
	* saveMailInfo(邮件保存)
	* @param mailBean
	* @return
	 */
	public boolean saveMailInfo(EmailBaseBean mailBean);
	
	/**
	 * 
	*<b>Summary: </b>
	* deleteMailInfo(删除收件箱邮件)
	* @param receivepid
	* @param ids
	* @return
	 */
	public boolean deleteMailInfo(String receivepid,String ids);
	/**
	 * 
	*<b>Summary: </b>
	* deleteMailInfo1( 删除草稿箱邮件)
	* @param ids
	* @return
	 */
	public boolean deleteMailInfo1(String ids);
	/**
	 * 
	*<b>Summary: </b>
	* findMailInfo(查询邮件对象)
	* @param id
	* @return
	 */
	public EmailBaseBean findMailInfo(String id) ;
	
	/**
	 * 
	*<b>Summary: </b>
	* updateMailInfo(修改邮件/草稿转为发送时调用的方法)
	* @param mailBean
	* @return
	 */
	public boolean updateMailInfo(EmailBaseBean mailBean) ;
	
	/**
	 * 
	*<b>Summary: </b>
	* deleteyjMailInfo(删除已发送邮件)
	* @param ids
	* @return
	 */
	public boolean deleteyjMailInfo(String ids) ;
	/**
	 * 
	*<b>Summary: </b>
	* changeReadState(由未阅读专为已读)
	* @param receivepid
	* @param ids
	* @return
	 */
	public boolean changeReadState(String receivepid, String ids);
	
	/**
	 * 
	*<b>Summary: </b>
	* replevyMail(追回 已发邮件)
	* @param userId
	* @param ids
	* @return
	* @throws Exception
	 */
	public boolean replevyMail(String userId,String ids) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* findreplevyUserMail(查询未查看人员邮件)
	* @param id
	* @return
	* @throws Exception
	 */
	public HashMap<String,String> findreplevyUserMail(String id)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* checkIsEmailBoxMemoryWillBeOverflow(检查邮箱内存是否将要溢出)
	* @param userids
	* @return
	* @throws Exception
	 */
	public boolean checkIsEmailBoxMemoryWillBeOverflow(String userids) throws Exception ;
}
