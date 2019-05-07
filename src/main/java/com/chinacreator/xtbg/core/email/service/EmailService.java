package com.chinacreator.xtbg.core.email.service;

import java.util.HashMap;

import com.chinacreator.xtbg.core.email.entity.EmailBaseBean;

/**
 * 
 *<p>Title:EmailService.java</p>
 *<p>Description:邮件服务接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-11-19
 */
public interface EmailService {
	/**
	 * 
	*<b>Summary: </b>
	* saveMailInfo(邮件保存)
	* @param mb
	* @return
	 */
	public boolean saveMailInfo(EmailBaseBean mb);
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
	* deleteMailInfo1(删除草稿箱邮件)
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
	public EmailBaseBean findMailInfo(String id);
    /**
     * 
    *<b>Summary: </b>
    * updateMailInfo(修改邮件/草稿转为发送时调用的方法)
    * @param mb
    * @return
     */
	public boolean updateMailInfo(EmailBaseBean mb);
	/**
	 * 
	*<b>Summary: </b>
	* deleteyjMailInfo(删除已发送邮件)
	* @param ids
	* @return
	 */
	public boolean deleteyjMailInfo(String ids);
	/**
	 * 
	*<b>Summary: </b>
	* changeReadState(由未阅读专为已读)
	* @param receivepid
	* @param ids
	* @return
	 */
	public boolean changeReadState(String receivepid,String ids);
	
	public int selectReadStateNumber(String paramjosn);
	
	/**
	 * 
	*<b>Summary: </b>
	* replevyMail(追回 已发邮件)
	* @param userId
	* @param ids
	* @return
	 */
	public boolean replevyMail(String userId,String ids);
	
	/**
	 * 
	*<b>Summary: </b>
	* findreplevyUserMail(查询未查看人员邮件)
	* @param id
	* @return
	 */
	
	public HashMap<String,String> findreplevyUserMail(String id);
}
