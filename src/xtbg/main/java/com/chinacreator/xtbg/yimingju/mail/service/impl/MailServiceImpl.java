package com.chinacreator.xtbg.yimingju.mail.service.impl;


import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.msgcenter.services.MessageCenterService;
import com.chinacreator.xtbg.core.common.msgcenter.services.impl.MessageCenterServiceImpl;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.yimingju.mail.dao.MailDao;
import com.chinacreator.xtbg.yimingju.mail.dao.impl.MailDaoImpl;
import com.chinacreator.xtbg.yimingju.mail.entity.MailBean;

import com.chinacreator.xtbg.yimingju.mail.service.MailServiceIfc;
/**
 *<p>Title:邮件</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author dijun.sheng
 *@version 1.0
 *2012-11-15
 */
public class MailServiceImpl implements MailServiceIfc{
	private static final Logger LOG = Logger.getLogger(MailServiceImpl.class);
	/**
     * <b>Summary: (邮件保存)</b>
     * @param MailBean --邮件实体bean对象
     * @return boolean
     */
	public boolean saveMailInfo(MailBean mb){
		boolean result = false;
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	        String surveyTime=sdf.format(new Date());
			mb.setCreatetime(surveyTime);
		try {
			MailDao md=new MailDaoImpl();
			result=md.saveMailInfo(mb);
			MessageCenterService mesService=new MessageCenterServiceImpl();
			List<String> list =new ArrayList<String>();
			String[] receivepid = mb.getReceivepid().split(",");
			for(int i=0;i<receivepid.length;i++){
				list.add(receivepid[i]);
			}
			String content="有一封邮件";
			mesService.sendMessage(mb.getSendpid(),list, content);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getStackTrace());
			LOG.error(e.getMessage());
			result = false;
		}
		return result;
	}
	/**
     * <b>Summary: 删除收件箱邮件</b>
     * @param receivepid --接收者ID
     * @param ids --邮件ID
     * @return boolean
     */
	public boolean deleteMailInfo(String receivepid,String ids){
		MailDao md=new MailDaoImpl();
		return md.deleteMailInfo(receivepid,ids);
	}
	/**
     * <b>Summary: 删除草稿箱邮件</b>
     * @param ids --邮件ID
     * @return boolean
     */
	public boolean deleteMailInfo1(String ids){
		MailDao md=new MailDaoImpl();
		return md.deleteMailInfo1(ids);
	}
	/**
     * <b>Summary: 查询邮件对象<Object></b>
     * @param id --邮件ID
     * @return MailBean --邮件实体bean对象
     */
	@Override
	public MailBean findMailInfo(String id) {
		MailDao md=new MailDaoImpl();
		return md.findMailInfo(id);
	}
	/**
     * <b>Summary: 修改邮件/草稿转为发送时调用的方法<Object></b>
     * @param MailBean --邮件实体bean对象
     * @return boolean
     */
	@Override
	public boolean updateMailInfo(MailBean mb) {
		boolean result = false;
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	        String surveyTime=sdf.format(new Date());
			mb.setCreatetime(surveyTime);
		try {
			MailDao md=new MailDaoImpl();
			result=md.updateMailInfo(mb);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getStackTrace());
			LOG.error(e.getMessage());
			result = false;
		}
		return result;
	}
	/**
     * <b>Summary: 删除已发送邮件<Object></b>
     * @param id --邮件ID
     * @return boolean
     */
	//删除已发送的邮件
	@Override
	public boolean deleteyjMailInfo(String ids) {
		MailDao md=new MailDaoImpl();
		return md.deleteyjMailInfo(ids);
	}
	/**
     * <b>Summary: 由未阅读专为已读<Object></b>
     * @param receivepid --接收者ID
     * @param id --邮件ID
     * @return boolean
     */
	@Override
	public boolean changeReadState(String receivepid, String ids) {
		MailDao md=new MailDaoImpl();
		return md.changeReadState(receivepid,ids);
	}
	
	public int selectReadStateNumber(String paramjosn){
		return 1;
	}/**
	*<b>Summary: </b>
	* replevyMail(追回 已发邮件)
	* @param userId
	* @param ids
	* @return
	 */
	public boolean replevyMail(String userId,String ids){
		try {
			MailDao md=new MailDaoImpl();
			return  md.replevyMail(userId,ids);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			return false;
		}

	}
	
	/**
	*<b>Summary: </b>
	* findreplevyUserMail(查询未查看人员邮件)
	* @param ids
	* @return
	 */
	
	public HashMap<String,String> findreplevyUserMail(String ids){
		try {
			MailDao md=new MailDaoImpl();
			return md.findreplevyUserMail(ids);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			return null;
		}
	}
	
	/**
	*<b>Summary: </b>
	* copyAttach(复制附件信息)
	* @param newDjbh
	* @param oldDjbh
	* @param creator
	* @return
	 */
	public boolean copyAttach(String newDjbh, String oldDjbh,String creator){
		Connection conn = null;
		boolean sucess = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			MailDao md= new MailDaoImpl();
			sucess = md.copyAttachFile(conn,newDjbh,oldDjbh,creator);
			conn.commit();
		} catch (Exception e) {
			sucess = false;
			LOG.error(e.getMessage(),e);
			DbManager.rollBackNoThrow(conn);
		}finally{
			DbManager.closeConnection(conn);
		}
		return sucess;
	}
	
}
