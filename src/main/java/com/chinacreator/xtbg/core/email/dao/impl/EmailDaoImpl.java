package com.chinacreator.xtbg.core.email.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.transaction.RollbackException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.MessageUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.email.dao.EmailDao;
import com.chinacreator.xtbg.core.email.entity.EmailBaseBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
import com.frameworkset.orm.transaction.TransactionManager;
import com.chinacreator.xtbg.core.common.note.support.NoteConstants;
/**
 * 
 *<p>Title:EmailDaoImpl.java</p>
 *<p>Description:电子邮件接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-11-19
 */
public class EmailDaoImpl extends XtDbBaseDao implements EmailDao {

	private static final Log LOG=LogFactory.getLog(EmailDaoImpl.class);
	/**
	 * 
	  * <b>Summary: 分页查询邮件</b>
	  *     复写方法 findMailInfoList
	  * @param mailBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.email.dao.EmailDao#findMailInfoList(com.chinacreator.xtbg.core.email.entity.EmailBaseBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findMailInfoList(EmailBaseBean mailBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<EmailBaseBean> list = new ArrayList<EmailBaseBean>();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		int number=0;
		if(mailBean.getReadstate().equals("未读")){
			sql.append(" select * from (");
		}
		sql.append(" select");
		sql.append(" b.m_id,");
		sql.append(" b.m_sendpid,");
		sql.append(" b.m_sendpname,");
		sql.append(" b.m_title,");
		sql.append(" b.m_createtime,");
		sql.append(" decode(u.readstate, '0', '未读', '1', '已读', '') as readstate");
		sql.append(" from oa_email_base b, oa_email_user u");
		sql.append(" where b.m_id = u.m_id ");
		
		sql1.append(" select count(*) as num from oa_email_base b, oa_email_user u where b.m_id = u.m_id ");
		if (!StringUtil.nullOrBlank(mailBean.getTitle())) {
			sql.append(" and b.m_title like '%"+mailBean.getTitle()+"%'");
			sql1.append(" and b.m_title like '%"+mailBean.getTitle()+"%'");
		}
		if (!StringUtil.nullOrBlank(mailBean.getSendpname())) {
			sql.append(" and b.m_sendpname like '%"+mailBean.getSendpname()+"%'");
			sql1.append(" and b.m_sendpname like '%"+mailBean.getSendpname()+"%'");
		}
		if (!StringUtil.nullOrBlank(mailBean.getUse_starttime())) {
			sql.append(" and b.m_createtime>='"+mailBean.getUse_starttime()+"'");
		}
		if (!StringUtil.nullOrBlank(mailBean.getUse_endtime())) {
			sql.append(" and substr(b.m_createtime,0,10)<='"+mailBean.getUse_endtime()+"'");
		}
		if (!StringUtil.nullOrBlank(mailBean.getReceivepid())) {
			sql.append(" and u.receivepid='"+mailBean.getReceivepid()+"'");
			sql1.append(" and u.receivepid='"+mailBean.getReceivepid()+"'");
		}
		sql.append(" and u.readstate!='99' ");
		if (!StringUtil.nullOrBlank(mailBean.getState())) {
			sql.append(" and (b.m_state='"+mailBean.getState()+"'" +" or b.m_state='-1')");
			sql1.append(" and (b.m_state='"+mailBean.getState()+"'" +" or b.m_state='-1')");
		}
		
		//if (!StringUtil.nullOrBlank(mailBean.getState())) {
		//	sql.append(" and (tt.state='"+mailBean.getState()+"'" +" or tt.state='-1')");
		//}//else{
		//	if (!StringUtil.nullOrBlank(mailBean.getState())) {
		//		sql.append(" and tt.state='"+mailBean.getState()+"'");
		//	}
		// }
		
		
		sql1.append(" and u.readstate = '0' ");
		if(!StringUtil.nullOrBlank(sortName)&&!StringUtil.nullOrBlank(sortOrder)){
			sql.append(" order by "+sortName +" "+ sortOrder);
		}else{
			sql.append(" order by b.m_createtime");
		}
			
		try {
			db.preparedSelect(sql1.toString());
			db.executePrepared();
			if(db.size()>0){
				number=db.getInt(0,"num");
			}
			if(mailBean.getReadstate().equals("未读")){
				sql.append("  ) a where readstate='未读'");
			}
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.executePrepared();
			for (int i = 0; i < db.size(); i++) {
				EmailBaseBean mailBeans = new EmailBaseBean();
				if(i==0){
					mailBeans.setNumber(number);
				}else{
					mailBeans.setNumber(0);
				}
				mailBeans.setMid(db.getString(i,"m_id"));
				mailBeans.setSendpid(db.getString(i,"m_sendpid"));
				mailBeans.setSendpname(db.getString(i,"m_sendpname"));
				mailBeans.setCreatetime(db.getString(i,"m_createtime"));
				mailBeans.setReadstate(db.getString(i,"readstate"));
				mailBeans.setTitle(db.getString(i,"m_title"));
				list.add(mailBeans);
			}
		} catch (Exception e) {
			LOG.error(e.getMessage());
		}
		pb.setList(list);
		pb.setRecords((long)db.getTotalSize());  
			
		return pb;
	}
	/**
	 * 
	  * <b>Summary:分页查询已发邮件 </b>
	  *     复写方法 findMailInfoListByYjSend
	  * @param mailBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return 
	  * @see com.chinacreator.xtbg.core.email.dao.EmailDao#findMailInfoListByYjSend(com.chinacreator.xtbg.core.email.entity.EmailBaseBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findMailInfoListByYjSend(EmailBaseBean mailBean,
			String sortName, String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<EmailBaseBean> list = new ArrayList<EmailBaseBean>();
		StringBuffer sql = new StringBuffer();
		
		sql.append(" select distinct (m_id),m_sendpid,m_sendpname,m_title,m_createtime,to_char(receivepname) as receivepname from ( ");
		sql.append(" select m_id,m_sendpid,m_sendpname,m_title,m_createtime,wmsys.wm_concat(receivepname) over (partition by m_id) as receivepname from ( ");
		sql.append(" select * from ( ");
		sql.append(" select tt.m_id,");
		sql.append(" tt.m_sendpid,");
		sql.append(" tt.m_sendpname,");
		sql.append(" tt.m_title,");
		sql.append(" t.receivepname,");
		sql.append(" tt.m_createtime");
		sql.append(" from oa_email_base tt ");
		sql.append("  left join oa_email_user t on tt.m_id=t.m_id");
		sql.append(" where 1=1  ");
		
		if (!StringUtil.nullOrBlank(mailBean.getReceivepname())) {
			sql.append(" and t.receivepname like '%"+mailBean.getReceivepname()+"%'");
		}
		if (!StringUtil.nullOrBlank(mailBean.getTitle())) {
			sql.append(" and tt.m_title like '%"+mailBean.getTitle()+"%'");
		}
		
		if (!StringUtil.nullOrBlank(mailBean.getUse_starttime())) {
			sql.append(" and tt.m_createtime>='"+mailBean.getUse_starttime()+"'");
		}
		if (!StringUtil.nullOrBlank(mailBean.getUse_endtime())) {
			sql.append(" and substr(tt.m_createtime,0,10)<='"+mailBean.getUse_endtime()+"'");
		}
		if (!StringUtil.nullOrBlank(mailBean.getSendpid())) {
			sql.append(" and tt.m_sendpid='"+mailBean.getSendpid()+"'");
		}
		if (!StringUtil.nullOrBlank(mailBean.getState())) {
			sql.append(" and tt.m_state='"+mailBean.getState()+"'");
		}
		
		sql.append(" ) ) )");
		if(!StringUtil.nullOrBlank(sortName)&&!StringUtil.nullOrBlank(sortOrder)){
			sql.append(" order by "+sortName +" "+ sortOrder);
		}else{
			sql.append(" order by tt.m_createtime ");
		}
		try {
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.executePrepared();
			for (int i = 0; i < db.size(); i++) {
				EmailBaseBean mailBeans = new EmailBaseBean();
				mailBeans.setMid(db.getString(i,"m_id"));
				mailBeans.setSendpid(db.getString(i,"m_sendpid"));
				mailBeans.setSendpname(db.getString(i,"m_sendpname"));
				mailBeans.setCreatetime(db.getString(i,"m_createtime"));
				mailBeans.setTitle(db.getString(i,"m_title"));
				mailBeans.setReceivepname(db.getString(i,"receivepname"));
				list.add(mailBeans);
			}
		} catch (Exception e) {
			e.printStackTrace();
			LOG.error(e.getMessage());
		}
		pb.setList(list);
		pb.setRecords((long)db.getTotalSize());  
		return pb;
	}
	/**
	 * 
	  * <b>Summary:邮件保存 </b>
	  *     复写方法 saveMailInfo
	  * @param mailBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.email.dao.EmailDao#saveMailInfo(com.chinacreator.xtbg.core.email.entity.EmailBaseBean)
	 */
	public boolean saveMailInfo(EmailBaseBean mailBean) {
		TransactionManager tm=new TransactionManager();
		Connection conn=null;
		try {
			tm.begin();
			//获得邮件主键
			String idnum=StringUtil.getUUID();
			//保存邮件基本信息方法
			saveMailDatebase(mailBean,idnum);
			//保存邮件从表,邮件和收件人关系表
			saveMailUser(mailBean.getReceivepid(),mailBean.getReceivepname(),idnum);
			
			tm.commit();
			
			
			conn =DbManager.getInstance().getConnection();
			String []userids=mailBean.getReceivepid().split(",");
			List<String> useridlist=new ArrayList<String>();
			for (String userid : userids) {
				useridlist.add(userid);
			}
			MessageUtil util=new MessageUtil();
			util.sendSms(mailBean.getMid(),"你有一封邮件待阅读", mailBean.getSendpid(), useridlist,"",NoteConstants.SEND_EMAIL, conn);
			/*//移民局短信提醒
		   if (("421000").equals(StringUtil.deNull(userArea))) {//移民局的短信提醒
				if (mailBean.getIsType().equalsIgnoreCase("y")){
						// 调用短息提醒的方法
					doNoteSend(mailBean, idnum);
					}
			}
		   if (("421005").equals(StringUtil.deNull(userArea))) {//望城短信提醒  tao.ren
			   if (mailBean.getIsType().equalsIgnoreCase("y") && ("1").equals(mailBean.getState())){
					Connection con = DbconnManager.getInstance().getTransactionConnection();
				    PreparedDBUtil db = new PreparedDBUtil();
				    String user_id ="";
				    String sql ="select ta.receivepid from ymj_oa_user_mail ta where ta.mid = ?";
					try {
						db.preparedSelect(sql.toString());
						db.setString(1, idnum);
						db.executePrepared();
						for(int i=0; i<db.size();i++) {
							user_id+=db.getString(i,"receivepid");
							user_id+=",";
						}
						Map<String, String> map = new HashMap<String, String>();
						map.put("conferenceNotice", "conferenceNotice");
						map.put("user_id", user_id);
						map.put("content", mailBean.getMessage_info());
						map.put("accepter", mailBean.getSendpname());
						SmsProxy.doSendMesg(map, con);
						con.commit();
					} catch (Exception e) {
						LOG.error("电子邮件=发送短信 失败"+e.getMessage());
						con.rollback();
					}finally{
						con.close();
					}
				}
		   }*/
			return true;
		}  catch (Exception e) {
			try {
				e.printStackTrace();
				tm.rollback();//transaction rollback
				return false;
			}catch (RollbackException e1) { //rollbackException
				e.printStackTrace();
				LOG.error("电子邮件=保存邮件失败："+e.getMessage());
				return false;
			}
		}finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
	}
	//保存邮件主表-邮件信息
	public void saveMailDatebase(EmailBaseBean mailBean,String idnum){
			PreparedDBUtil pdb = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();	
			sql.append(" insert into oa_email_base");
			sql.append(" (m_id,");
			sql.append(" m_title,");
			sql.append(" m_createtime,"); 
			sql.append(" m_attachment_id,"); 
			sql.append(" m_state,");  
			sql.append(" m_deptid,");
			sql.append(" m_deptname,");
			sql.append(" m_sendpid,");
			sql.append(" m_sendpname,");
			sql.append(" m_dxtzjsr,");
			sql.append(" m_content)"); 
			sql.append(" values");
			sql.append(" (?,");
			sql.append(" ?,");
			sql.append(" ?,");  
			sql.append(" ?,?,?,?,?,?,?,?)");
			int i = 1;
			try {
				pdb.preparedInsert(sql.toString());
				pdb.setString(i++, StringUtil.deNull(idnum));
				pdb.setString(i++, StringUtil.deNull(mailBean.getTitle()));
				pdb.setString(i++, StringUtil.deNull(mailBean.getCreatetime()));
				pdb.setString(i++, StringUtil.deNull(mailBean.getAttachment_id()));
				pdb.setString(i++, StringUtil.deNull(mailBean.getState()));
				pdb.setString(i++, StringUtil.deNull(mailBean.getDeptid()));
				pdb.setString(i++, StringUtil.deNull(mailBean.getDeptname()));
				pdb.setString(i++, StringUtil.deNull(mailBean.getSendpid()));
				pdb.setString(i++, StringUtil.deNull(mailBean.getSendpname()));
				pdb.setString(i++, StringUtil.deNull(mailBean.getDxtzjsr()));
				pdb.setString(i++, StringUtil.deNull(mailBean.getContent()));
				pdb.executePrepared();		
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	//邮件收件人关系表保存
	public void saveMailUser(String Receivepid,String Receivepname,String idnum){
		PreparedDBUtil pdb = new PreparedDBUtil();
		if(Receivepid!=null&&!"".equals(Receivepid)){
			String []ids=Receivepid.split(",");
			String []names=Receivepname.split(",");
			for(int j=0;j<ids.length;j++){
				StringBuffer sql1 = new StringBuffer();
				sql1.append(" insert into oa_email_user");
				sql1.append(" (receivepid,");
				sql1.append(" receivepname,"); 
				sql1.append(" readstate,"); 
				sql1.append(" m_id)");  
				sql1.append(" values");
				sql1.append(" (?,?,?,?)");
				int k = 1;
				try {
					pdb.preparedInsert(sql1.toString());
					pdb.setString(k++, ids[j]);
					pdb.setString(k++, names[j]);
					pdb.setString(k++, "0");//未读
					pdb.setString(k++, idnum);
					pdb.executePrepared();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
			}
		}
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteMailInfo
	  * @param receivepid
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.email.dao.EmailDao#deleteMailInfo(java.lang.String, java.lang.String)
	 */
	public boolean deleteMailInfo(String receivepid, String ids) {
		PreparedDBUtil  db = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		sql.append(" update oa_email_user t set readstate='99' ");
		sql.append(" where t.receivepid='"+receivepid+"'"+" and t.m_id in("+ids+")"); 
		try {
			db.preparedInsert(sql.toString());
			db.executePrepared();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	public void deleteMainUserDatabase(String ids){
		PreparedDBUtil  db = new PreparedDBUtil ();
		String sql="delete from oa_email_user t where t.m_id in("+ids+")";
		try {
			db.executeDelete(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteMailInfo1
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.email.dao.EmailDao#deleteMailInfo1(java.lang.String)
	 */
	public boolean deleteMailInfo1(String ids) {
		PreparedDBUtil  db = new PreparedDBUtil ();
		String sql="delete from oa_email_base t where t.m_id in("+ids+")";
		//String sql1="delete from ymj_oa_user_mail t where t.mid in("+ids+")";
		//根据邮件ID删除邮件从表信息
		deleteMainUserDatabase(ids);
		try {
			db.executeDelete(sql);
		}catch (Exception e) {
			e.printStackTrace();
			LOG.error(e.getMessage());
			return false;
		}
		return true;
	}
	public EmailBaseBean findMailInfo(String id) {
		PreparedDBUtil  db = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		String receivepname=""; //收件人姓名
		String receivepid="";  //收件人ID
		sql.append(" select m_id,m_attachment_id,m_content,m_dxtzjsr,m_title,m_createtime,receivepname,receivepid,m_sendpid,m_sendpname from  ( ");
		sql.append(" select");
		sql.append(" tt.m_id,");
		sql.append(" tt.m_attachment_id,");
		sql.append(" tt.m_createtime,");
		sql.append(" tt.m_dxtzjsr,");
		sql.append(" tt.m_content,");
		sql.append(" tt.m_title,");
		sql.append(" t.receivepid,");
		sql.append(" t.receivepname,");
		sql.append(" tt.m_sendpid,");
		sql.append(" tt.m_sendpname ");
		sql.append(" from oa_email_base tt,oa_email_user t ");
		sql.append(" where 1=1 and tt.m_id=t.m_id and tt.m_id = '"+id+"' ) a ");
		
		
		EmailBaseBean mailBeans = new EmailBaseBean();
		try {
			db.preparedSelect(sql.toString());
			db.executePrepared();
			for (int i = 0; i < db.size(); i++) {
				if(i==db.size()-1){
					mailBeans.setMid(db.getString(i,"m_id"));
					mailBeans.setTitle(db.getString(i,"m_title"));
					mailBeans.setContent(db.getString(i,"m_content"));
					mailBeans.setAttachment_id(db.getString(i,"m_attachment_id"));
					mailBeans.setCreatetime(db.getString(i,"m_createtime"));
					mailBeans.setDxtzjsr(db.getString(i,"m_dxtzjsr"));
					mailBeans.setReceivepid(db.getString(i,"receivepid"));
					mailBeans.setSendpid(db.getString(i,"m_sendpid"));
					mailBeans.setSendpname(db.getString(i,"m_sendpname"));
				}
				receivepname += db.getString(i,"receivepname")+",";
				receivepid += db.getString(i,"receivepid")+",";
				mailBeans.setReceivepname(receivepname.substring(0, receivepname.length()-1));
				mailBeans.setReceivepid(receivepid.substring(0, receivepid.length()-1));
			}
		} catch (Exception e) {
			LOG.error(e.getMessage());
		}
		return mailBeans;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateMailInfo
	  * @param mailBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.email.dao.EmailDao#updateMailInfo(com.chinacreator.xtbg.core.email.entity.EmailBaseBean)
	 */
	public boolean updateMailInfo(EmailBaseBean mailBean) {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		TransactionManager tm=new TransactionManager();
		Connection conn=null;
		try {
			tm.begin();
			//pdb.executeDelete("delete from ymj_oa_user_mail t where  t.mid in("+mailBean.getMid()+")");
			//删除邮件从表信息。
			deleteMainUserDatabase(StringUtil.returnParam(mailBean.getMid(), ","));
			sql.append(" update oa_email_base set ");
			sql.append(" m_title=?,");
			sql.append(" m_createtime=?,"); 
			sql.append(" m_attachment_id=?,"); 
			sql.append(" m_state=?,");  
			sql.append(" m_deptid=?,");
			sql.append(" m_deptname=?,");
			sql.append(" m_sendpid=?,");
			sql.append(" m_sendpname=?,");
			sql.append(" m_dxtzjsr=?,");
			sql.append(" m_content=? "); 
			sql.append(" where m_id='"+mailBean.getMid()+"'"); 
		
			int i = 1;
			pdb.preparedInsert(sql.toString());
			pdb.setString(i++, StringUtil.deNull(mailBean.getTitle()));
			pdb.setString(i++, StringUtil.deNull(mailBean.getCreatetime()));
			pdb.setString(i++, StringUtil.deNull(mailBean.getAttachment_id()));
			pdb.setString(i++, StringUtil.deNull(mailBean.getState()));
			pdb.setString(i++, StringUtil.deNull(mailBean.getDeptid()));
			pdb.setString(i++, StringUtil.deNull(mailBean.getDeptname()));
			pdb.setString(i++, StringUtil.deNull(mailBean.getSendpid()));
			pdb.setString(i++, StringUtil.deNull(mailBean.getSendpname()));
			pdb.setString(i++, StringUtil.deNull(mailBean.getDxtzjsr()));
			pdb.setString(i++, StringUtil.deNull(mailBean.getContent()));
			pdb.executePrepared();
			//保存邮件和接收人信息方法
			saveMailUser(mailBean.getReceivepid(),mailBean.getReceivepname(),mailBean.getMid());
			tm.commit();
			
			conn =DbManager.getInstance().getConnection();
			String []userids=mailBean.getReceivepid().split(",");
			List<String> useridlist=new ArrayList<String>();
			for (String userid : userids) {
				useridlist.add(userid);
			}
			MessageUtil util=new MessageUtil();
			util.sendSms(mailBean.getMid(),"你有一封邮件待阅读", mailBean.getSendpid(), useridlist,"", NoteConstants.SEND_EMAIL,conn);
			
			/*//移民局短信提醒
			if (("421000").equals(StringUtil.deNull(userArea))) {//移民局的短信提醒
				if (mailBean.getIsType().equalsIgnoreCase("y")){
						// 调用短息提醒的方法
					String idnum = mailBean.getMid();
					doNoteSend(mailBean, idnum);
					}
			}
			 if (("421005").equals(StringUtil.deNull(userArea))) {//望城短信提醒  tao.ren
				   if (mailBean.getIsType().equalsIgnoreCase("y") && ("1").equals(mailBean.getState())){
						Connection con = DbconnManager.getInstance().getTransactionConnection();
					    PreparedDBUtil db = new PreparedDBUtil();
					    String user_id ="";
					    String sqls ="select ta.receivepid from ymj_oa_user_mail ta where ta.mid = ?";
						try {
							db.preparedSelect(sqls.toString());
							db.setString(1, mailBean.getMid());
							db.executePrepared();
							for(int k=0; k<db.size();k++) {
								user_id+=db.getString(k,"receivepid");
								user_id+=",";
							}
							Map<String, String> map = new HashMap<String, String>();
							map.put("conferenceNotice", "conferenceNotice");
							map.put("user_id", user_id);
							map.put("content", mailBean.getMessage_info());
							map.put("accepter", mailBean.getSendpname());
							SmsProxy.doSendMesg(map, con);
							con.commit();
						} catch (Exception e) {
							LOG.error("电子邮件=发送短信 失败"+e.getMessage());
							con.rollback();
						}finally{
							con.close();
						}
					}
			 }*/
			return true;
		} catch (Exception e) {
			try {
				e.printStackTrace();
				tm.rollback();//transaction rollback
				return false;
			}catch (RollbackException e1) { //rollbackException
				e.printStackTrace();
				LOG.error("电子邮件=保存邮件失败："+e.getMessage());
				return false;
			}
		}finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
	}
	/**
	 * 
	  * <b>Summary: 删除已发送邮件</b>
	  *     复写方法 deleteyjMailInfo
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.email.dao.EmailDao#deleteyjMailInfo(java.lang.String)
	 */
	public boolean deleteyjMailInfo(String ids) {
		PreparedDBUtil  db = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		sql.append(" update oa_email_base t set m_state='-1' ");
		sql.append(" where t.m_id in("+ids+")"); 
		try {
			db.preparedInsert(sql.toString());
			db.executePrepared();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	/**
	 * 
	  * <b>Summary: 由未阅读专为已读</b>
	  *     复写方法 changeReadState
	  * @param receivepid
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.email.dao.EmailDao#changeReadState(java.lang.String, java.lang.String)
	 */
	public boolean changeReadState(String receivepid, String ids) {
		PreparedDBUtil  db = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		sql.append(" update oa_email_user t set readstate='1'   ");
		sql.append(" where t.m_id ='"+ids+"'"); 
		sql.append(" and t.receivepid ='"+receivepid+"'"); 
		try {
			db.preparedInsert(sql.toString());
			db.executePrepared();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	/**
	 * 
	  * <b>Summary:追回 已发邮件 </b>
	  *     复写方法 replevyMail
	  * @param userId
	  * @param ids
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.email.dao.EmailDao#replevyMail(java.lang.String, java.lang.String)
	 */
	public boolean replevyMail(String userId, String ids) throws Exception {
		PreparedDBUtil  db = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		sql.append(" update oa_email_base t set t.m_state='0'   ");
		sql.append(" where t.m_id in ("+ids+")"); 
		try {
			db.preparedInsert(sql.toString());
			db.executePrepared();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	/**
	 * 
	  * <b>Summary: 查询未查看人员邮件</b>
	  *     复写方法 findreplevyUserMail
	  * @param id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.email.dao.EmailDao#findreplevyUserMail(java.lang.String)
	 */
	public HashMap<String, String> findreplevyUserMail(String ids)
			throws Exception {
		HashMap<String,String> map = new HashMap<String,String>();
		PreparedDBUtil  db = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		String receivepname=""; //收件人姓名
		String receivepid="";  //收件人ID
		sql.append(" select ");
		sql.append("  		t.receivepid,  ");
		sql.append("		t.receivepname ");
		sql.append(" from oa_email_base tt, oa_email_user t  ");
		sql.append(" where 1 = 1  		   ");
		sql.append(" 		and tt.m_id = t.m_id						");
		sql.append(" 		and t.readstate <> '1' 				    ");
		sql.append(" and tt.m_id ='"+ ids +"'");
		try {
			db.preparedSelect(sql.toString());
			db.executePrepared();
			for (int i = 0; i < db.size(); i++) {
				receivepname += db.getString(i,"receivepname")+",";
				receivepid += db.getString(i,"receivepid")+",";
			}
			if(StringUtil.isBlank(receivepid)){
				map.put("receivepid", "");
				map.put("receivepname", "");
			} else {
				map.put("receivepid", receivepid.substring(0, receivepid.length()-1));
				map.put("receivepname", receivepname.substring(0, receivepname.length()-1));
			}
		} catch (Exception e) {
			LOG.error(e.getMessage());
			throw e;
		}
		return map;
	}
	/**
	 * 
	  * <b>Summary:检查邮箱内存是否将要溢出 </b>
	  *     复写方法 checkIsEmailBoxMemoryWillBeOverflow
	  * @param userids
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.email.dao.EmailDao#checkIsEmailBoxMemoryWillBeOverflow(java.lang.String)
	 */
	public boolean checkIsEmailBoxMemoryWillBeOverflow(String userids)
			throws Exception {
		userids = "'1'";//此处先写死，后续扩展
		int maxAttachSize = getMaxAttachSize(userids);
		int attachSize = attachSize();
		
		if(attachSize >= maxAttachSize)
			return true;

		return false;
	}
	/**
	 * 
	*<b>Summary: </b>
	* getMaxAttachSize(获取允许的最大附件容量)
	* @return
	 * @throws Exception 
	 */
	public int getMaxAttachSize(String userids) throws Exception{
		/*MailConfigDao mailConfigDao = new MailConfigDaoImpl();
		Map<String,String> resultMap = mailConfigDao.getUserEmailBoxMemoryConfig(userids); 
		int maxAttachSize = Integer.valueOf(resultMap.get(userids.replaceAll("'", "")));*/
		return 0;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* attachSize(获取当前邮件的所有附件大小总和)
	* @return
	* @throws SQLException
	 */
	public int attachSize() throws Exception{
		PreparedDBUtil  db = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		int attachSize = 0;
		/*
		sql.append(" select sum(length(a.attachcontent))");
		sql.append("   from ymj_oa_jbxx_mail t");
		sql.append("  inner join fc_attach a");
		sql.append("     on trim(a.djbh) = trim(t.attachment_id)");
		
		db.preparedSelect(sql.toString());
		db.executePrepared();
		if(db.size() > 0){
			//根据当前使用的内存单元进行内存大小转换
			if(Memory_unit.M.equals(EmailConstants.CHECKEMAIL_MEMORY_UNIT)){
				attachSize = (int)(db.getLong(0, 0) / (EmailConstants.MEMORY_BASEUNIT * EmailConstants.MEMORY_BASEUNIT));
			}

		}*/
		
		return attachSize;
	}

}
