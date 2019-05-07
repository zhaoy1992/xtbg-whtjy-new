package com.chinacreator.xtbg.core.email.service.impl;

import java.util.Date;
import java.util.HashMap;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.email.dao.EmailDao;
import com.chinacreator.xtbg.core.email.dao.impl.EmailDaoImpl;
import com.chinacreator.xtbg.core.email.entity.EmailBaseBean;
import com.chinacreator.xtbg.core.email.service.EmailService;
import com.ibm.icu.text.SimpleDateFormat;
/**
 * 
 *<p>Title:EmailServiceImpl.java</p>
 *<p>Description:邮件服务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-11-19
 */
public class EmailServiceImpl implements EmailService {

	private static final Log LOG=LogFactory.getLog(EmailServiceImpl.class);
	/**
	 * 
	  * <b>Summary:邮件保存 </b>
	  *     复写方法 saveMailInfo
	  * @param mb
	  * @return 
	  * @see com.chinacreator.xtbg.core.email.service.EmailService#saveMailInfo(com.chinacreator.xtbg.core.email.entity.EmailBaseBean)
	 */
	public boolean saveMailInfo(EmailBaseBean mb){
		boolean result = false;
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	        String surveyTime=sdf.format(new Date());
			mb.setCreatetime(surveyTime);
		try {
			EmailDao md=new EmailDaoImpl();
			result=md.saveMailInfo(mb);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getStackTrace());
			LOG.error(e.getMessage());
			result = false;
		}
		return result;
	}
	/**
	 * 删除收件箱邮件
	  * <b>Summary: </b>
	  *     复写方法 deleteMailInfo
	  * @param receivepid
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.email.service.EmailService#deleteMailInfo(java.lang.String, java.lang.String)
	 */
	public boolean deleteMailInfo(String receivepid,String ids){
		EmailDao md=new EmailDaoImpl();
		return md.deleteMailInfo(receivepid,ids);
	}
	/**
	 * 删除草稿箱邮件
	  * <b>Summary: </b>
	  *     复写方法 deleteMailInfo1
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.email.service.EmailService#deleteMailInfo1(java.lang.String)
	 */
	public boolean deleteMailInfo1(String ids){
		EmailDao md=new EmailDaoImpl();
		return md.deleteMailInfo1(ids);
	}
	/**
	 * 查询邮件对象
	  * <b>Summary: </b>
	  *     复写方法 findMailInfo
	  * @param id
	  * @return 
	  * @see com.chinacreator.xtbg.core.email.service.EmailService#findMailInfo(java.lang.String)
	 */
	@Override
	public EmailBaseBean findMailInfo(String id) {
		EmailDao md=new EmailDaoImpl();
		return md.findMailInfo(id);
	}
	/**
	 * 修改邮件/草稿转为发送时调用的方法
	  * <b>Summary: </b>
	  *     复写方法 updateMailInfo
	  * @param mb
	  * @return 
	  * @see com.chinacreator.xtbg.core.email.service.EmailService#updateMailInfo(com.chinacreator.xtbg.core.email.entity.EmailBaseBean)
	 */
	public boolean updateMailInfo(EmailBaseBean mb) {
		boolean result = false;
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	        String surveyTime=sdf.format(new Date());
			mb.setCreatetime(surveyTime);
		try {
			EmailDao md=new EmailDaoImpl();
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
	 * 删除已发送邮件
	  * <b>Summary: </b>
	  *     复写方法 deleteyjMailInfo
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.email.service.EmailService#deleteyjMailInfo(java.lang.String)
	 */
	public boolean deleteyjMailInfo(String ids) {
		EmailDao md=new EmailDaoImpl();
		return md.deleteyjMailInfo(ids);
	}
	/**
	 * 由未阅读专为已读
	  * <b>Summary: </b>
	  *     复写方法 changeReadState
	  * @param receivepid
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.email.service.EmailService#changeReadState(java.lang.String, java.lang.String)
	 */
	public boolean changeReadState(String receivepid, String ids) {
		EmailDao md=new EmailDaoImpl();
		return md.changeReadState(receivepid,ids);
	}
	
	public int selectReadStateNumber(String paramjosn){
		return 1;
	}
	/**
	 * 
	  * <b>Summary:追回 已发邮件 </b>
	  *     复写方法 replevyMail
	  * @param userId
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.email.service.EmailService#replevyMail(java.lang.String, java.lang.String)
	 */
	public boolean replevyMail(String userId,String ids){
		try {
			EmailDao md=new EmailDaoImpl();
			return  md.replevyMail(userId,ids);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			return false;
		}

	}
	
	/**
	 * 查询未查看人员邮件
	  * <b>Summary: </b>
	  *     复写方法 findreplevyUserMail
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.email.service.EmailService#findreplevyUserMail(java.lang.String)
	 */
	public HashMap<String,String> findreplevyUserMail(String ids){
		try {
			EmailDao md=new EmailDaoImpl();
			return md.findreplevyUserMail(ids);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			return null;
		}
	}
}
