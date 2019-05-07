package com.chinacreator.xtbg.yimingju.mail.dao;

import java.sql.Connection;
import java.util.HashMap;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.yimingju.mail.entity.MailBean;
/**
 *<p>Title:邮件</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author dijun.sheng
 *@version 1.0
 *2012-11-15
 */
public interface MailDao {
	/**
     * <b>Summary: (邮件保存)</b>
     * @param MailBean --邮件实体bean对象
     * @return boolean
     */
	public boolean saveMailInfo(MailBean mailBean);
	
	/**
	 * <b>Summary: 分页查询邮件<List<Object>></b>
	 * @param MailBean --邮件实体bean对象
	 * @param sortName --排序字段
	 * @param sortOrder --排序方式
	 * @param offset --
	 * @param maxPagesize --
	 * @return PagingBean
	 */
	public PagingBean findMailInfoList(
			MailBean mailBean,
			String sortName, String sortOrder, long offset, int maxPagesize) ;
	/**
     * <b>Summary: 删除收件箱邮件</b>
     * @param receivepid --接收者ID
     * @param ids --邮件ID
     * @return boolean
     */
	public boolean deleteMailInfo(String receivepid,String ids);
	/**
     * <b>Summary: 删除草稿箱邮件</b>
     * @param ids --邮件ID
     * @return boolean
     */
	public boolean deleteMailInfo1(String ids);
	/**
     * <b>Summary: 查询邮件对象<Object></b>
     * @param id --邮件ID
     * @return MailBean --邮件实体bean对象
     */
	public MailBean findMailInfo(String id) ;
	
	/**
     * <b>Summary: 修改邮件/草稿转为发送时调用的方法<Object></b>
     * @param MailBean --邮件实体bean对象
     * @return boolean
     */
	public boolean updateMailInfo(MailBean mailBean) ;
	
	/**
	 * <b>Summary: 分页查询已发邮件<List<Object>></b>
	 * @param MailBean --邮件实体bean对象
	 * @param sortName --排序字段
	 * @param sortOrder --排序方式
	 * @param offset --
	 * @param maxPagesize --
	 * @return PagingBean
	 */
	public PagingBean findMailInfoListByYjSend(
			MailBean mailBean,
			String sortName, String sortOrder, long offset, int maxPagesize) ;
	
	/**
     * <b>Summary: 删除已发送邮件<Object></b>
     * @param id --邮件ID
     * @return boolean
     */
	public boolean deleteyjMailInfo(String ids) ;
	/**
     * <b>Summary: 由未阅读专为已读<Object></b>
     * @param receivepid --接收者ID
     * @param id --邮件ID
     * @return boolean
     */
	public boolean changeReadState(String receivepid, String ids);
	
	/**
	*<b>Summary: </b>
	* replevyMail(追回 已发邮件)
	* @param userId
	* @param ids
	* @return
	 */
	public boolean replevyMail(String userId,String ids) throws Exception;
	
	/**
	*<b>Summary: </b>
	* findreplevyUserMail(查询未查看人员邮件)
	* @param ids
	* @return
	 */
	public HashMap<String,String> findreplevyUserMail(String id)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* checkEmailBoxMemory(检查邮箱内存是否将要溢出)
	* @param username 用户名
	* @return
	 */
	public boolean checkIsEmailBoxMemoryWillBeOverflow(String userids) throws Exception ;
	
	/**
	*<b>Summary: </b>
	* copyAttachFile(复制文件信息)
	* @param newDjbh
	* @param oldDjbh
	* @param creator
	* @return
	 */
	public boolean copyAttachFile(Connection conn,String newDjbh, String oldDjbh,String creator)throws Exception;
}
