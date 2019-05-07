package com.chinacreator.xtbg.yimingju.mail.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.transaction.RollbackException;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.chinacreator.business.common.tools.CacheCommonManage;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.sms.entity.SmsBean;
import com.chinacreator.xtbg.pub.sms.service.SmsProxy;
import com.chinacreator.xtbg.pub.sms.service.SmsSendService;
import com.chinacreator.xtbg.pub.sms.service.impl.SmsSendServiceImp;
import com.chinacreator.xtbg.pub.util.DbconnManager;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.mail.constant.EmailConstants;
import com.chinacreator.xtbg.yimingju.mail.constant.EmailConstants.Memory_unit;
import com.chinacreator.xtbg.yimingju.mail.dao.MailConfigDao;
import com.chinacreator.xtbg.yimingju.mail.dao.MailDao;
import com.chinacreator.xtbg.yimingju.mail.entity.MailBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
import com.frameworkset.orm.transaction.TransactionManager;

public class MailDaoImpl implements MailDao{
	private static final Logger LOG = Logger.getLogger(MailDaoImpl.class);
	String userArea = CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");//查询系统区域码
	/**
     * <b>Summary: (邮件保存)</b>
     * @param MailBean --邮件实体bean对象
     * @return boolean
     */
	@Override
	public boolean saveMailInfo(MailBean mailBean) {
		TransactionManager tm=new TransactionManager();
		try {
			tm.begin();
			//获得邮件主键
			String idnum=getMailId();
			//保存邮件基本信息方法
			saveMailDatebase(mailBean,idnum);
			//保存邮件从表,邮件和收件人关系表
			saveMailUser(mailBean.getReceivepid(),mailBean.getReceivepname(),idnum);
			tm.commit();
			//移民局短信提醒
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
		   }
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
		}
	}
	//获取邮件ID
	public String getMailId(){
		PreparedDBUtil pdb = new PreparedDBUtil();
		String idnum="";
		try {
			pdb.preparedSelect("select SEQ_ymj_oa_jbxx_mail.Nextval as idnum from dual");
			pdb.executePrepared();
			idnum=pdb.getString(0,"idnum");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return idnum;
	}
	//保存邮件主表-邮件信息
	public void saveMailDatebase(MailBean mailBean,String idnum){
			PreparedDBUtil pdb = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();	
			sql.append(" insert into ymj_oa_jbxx_mail");
			sql.append(" (mid,");
			sql.append(" title,");
			sql.append(" createtime,"); 
			sql.append(" attachment_id,"); 
			sql.append(" state,");  
			sql.append(" deptid,");
			sql.append(" deptname,");
			sql.append(" sendpid,");
			sql.append(" sendpname,");
			sql.append(" dxtzjsr,");
			sql.append(" content)"); 
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
				// TODO Auto-generated catch block
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
				sql1.append(" insert into ymj_oa_user_mail");
				sql1.append(" (receivepid,");
				sql1.append(" receivepname,"); 
				sql1.append(" readstate,"); 
				sql1.append(" mid)");  
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
	 * <b>Summary: 分页查询邮件<List<Object>></b>
	 * @param MailBean --邮件实体bean对象
	 * @param sortName --排序字段
	 * @param sortOrder --排序方式
	 * @param offset --
	 * @param maxPagesize --
	 * @return PagingBean
	 */
	@Override
	public PagingBean findMailInfoList(
			MailBean mailBean,
			String sortName, String sortOrder, long offset, int maxPagesize) {
		// TODO Auto-generated method stub
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<MailBean> list = new ArrayList<MailBean>();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		int number=0;
		if(mailBean.getReadstate().equals("未读")){
			sql.append(" select * from (");
		}
		sql.append(" select");
		sql.append(" tt.mid,");
		sql.append(" tt.sendpid,");
		sql.append(" tt.sendpname,");
		sql.append(" tt.title,");
		sql.append(" decode(t.readstate,'0','未读','1','已读','') as readstate,");
		sql.append(" tt.createtime");
		sql.append(" from ymj_oa_user_mail t ,ymj_oa_jbxx_mail tt");
		sql.append(" where 1=1 and t.mid=tt.mid ");
		
		sql1.append(" select count(*) as num from ymj_oa_user_mail t ,ymj_oa_jbxx_mail tt where 1=1 and t.mid=tt.mid ");
		if (!StringUtil.nullOrBlank(mailBean.getTitle())) {
			sql.append(" and tt.title like '%"+mailBean.getTitle()+"%'");
			sql1.append(" and tt.title like '%"+mailBean.getTitle()+"%'");
		}
		if (!StringUtil.nullOrBlank(mailBean.getSendpname())) {
			sql.append(" and tt.sendpname like '%"+mailBean.getSendpname()+"%'");
			sql1.append(" and tt.sendpname like '%"+mailBean.getSendpname()+"%'");
		}
		if (!StringUtil.nullOrBlank(mailBean.getUse_starttime())) {
			sql.append(" and tt.createtime>='"+mailBean.getUse_starttime()+"'");
		}
		if (!StringUtil.nullOrBlank(mailBean.getUse_endtime())) {
			sql.append(" and substr(tt.createtime,0,10)<='"+mailBean.getUse_endtime()+"'");
		}
		if (!StringUtil.nullOrBlank(mailBean.getReceivepid())) {
			sql.append(" and t.receivepid='"+mailBean.getReceivepid()+"'");
			sql1.append(" and t.receivepid='"+mailBean.getReceivepid()+"'");
		}
		sql.append(" and t.readstate!='99' ");
		if (!StringUtil.nullOrBlank(mailBean.getState())) {
			sql.append(" and (tt.state='"+mailBean.getState()+"'" +" or tt.state='-1')");
			sql1.append(" and (tt.state='"+mailBean.getState()+"'" +" or tt.state='-1')");
		}
		
		//if (!StringUtil.nullOrBlank(mailBean.getState())) {
		//	sql.append(" and (tt.state='"+mailBean.getState()+"'" +" or tt.state='-1')");
		//}//else{
		//	if (!StringUtil.nullOrBlank(mailBean.getState())) {
		//		sql.append(" and tt.state='"+mailBean.getState()+"'");
		//	}
		// }
		
		
		sql1.append(" and t.readstate = '0' ");
		if(!StringUtil.nullOrBlank(sortName)&&!StringUtil.nullOrBlank(sortOrder)){
			sql.append(" order by "+sortName +" "+ sortOrder);
		}else{
			sql.append(" order by tt.createtime");
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
				MailBean mailBeans = new MailBean();
				if(i==0){
					mailBeans.setNumber(number);
				}else{
					mailBeans.setNumber(0);
				}
				mailBeans.setMid(db.getString(i,"mid"));
				mailBeans.setSendpid(db.getString(i,"sendpid"));
				mailBeans.setSendpname(db.getString(i,"sendpname"));
				mailBeans.setCreatetime(db.getString(i,"createtime"));
				mailBeans.setReadstate(db.getString(i,"readstate"));
				mailBeans.setTitle(db.getString(i,"title"));
				list.add(mailBeans);
			}
		} catch (Exception e) {
			// TODO: handle exception
			LOG.error(e.getMessage());
		}
		pb.setList(list);
		pb.setRecords((long)db.getTotalSize());  
			
		return pb;
	}
	/**
     * <b>Summary: 删除收件箱邮件</b>
     * @param receivepid --接收者ID
     * @param ids --邮件ID
     * @return boolean
     */
	public boolean deleteMailInfo(String receivepid,String ids){
		PreparedDBUtil  db = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		sql.append(" update ymj_oa_user_mail t set readstate='99' ");
		sql.append(" where t.receivepid='"+receivepid+"'"+" and t.mid in("+ids+")"); 
		try {
			db.preparedInsert(sql.toString());
			db.executePrepared();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		return true;
		
	}
	public void deleteMainUserDatabase(String ids){
		PreparedDBUtil  db = new PreparedDBUtil ();
		String sql="delete from ymj_oa_user_mail t where t.mid in("+ids+")";
		try {
			db.executeDelete(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
     * <b>Summary: 删除草稿箱邮件</b>
     * @param ids --邮件ID
     * @return boolean
     */
	public boolean deleteMailInfo1(String ids){
		PreparedDBUtil  db = new PreparedDBUtil ();
		String sql="delete from ymj_oa_jbxx_mail t where t.mid in("+ids+")";
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
	
	public MailBean getArrJsr(String id){
		PreparedDBUtil  db = new PreparedDBUtil ();
		StringBuffer sql1 = new StringBuffer();
		sql1.append(" select");
		sql1.append(" tt.receivepid,");
		sql1.append(" tt.receivepname");
		sql1.append(" from ymj_oa_user_mail tt");
		sql1.append(" where 1=1 and tt.mid = '"+id+"'");
		MailBean mailBean=new MailBean();
		try {
			db.preparedSelect(sql1.toString());
			db.executePrepared();
			String strpid="";
			String strpname="";
			for (int i = 0; i < db.size(); i++) {
				strpid=strpid+db.getString(i,"receivepid")+",";
				strpname=strpname+db.getString(i,"receivepname")+",";
			}
			mailBean.setReceivepid(strpid.substring(0,strpid.length()-1 ));
			mailBean.setReceivepname(strpname.substring(0,strpname.length()-1 ));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mailBean;
	}
	
	/**
     * <b>Summary: 查询邮件对象<Object></b>
     * @param id --邮件ID
     * @return MailBean --邮件实体bean对象
     */
	public MailBean findMailInfo(String id) {
		PreparedDBUtil  db = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		String receivepname=""; //收件人姓名
		String receivepid="";  //收件人ID
		sql.append(" select mid,attachment_id,content,dxtzjsr,title,createtime,receivepname,receivepid,sendpid,sendpname from  ( ");
		sql.append(" select");
		sql.append(" tt.mid,");
		sql.append(" tt.attachment_id,");
		sql.append(" tt.createtime,");
		sql.append(" tt.dxtzjsr,");
		sql.append(" tt.content,");
		sql.append(" tt.title,");
		sql.append(" t.receivepid,");
		sql.append(" t.receivepname,");
		sql.append(" tt.sendpid,");
		sql.append(" tt.sendpname ");
		sql.append(" from ymj_oa_jbxx_mail tt,ymj_oa_user_mail t ");
		sql.append(" where 1=1 and tt.mid=t.mid and tt.mid = '"+id+"' ) a ");
		
		
		MailBean mailBeans = new MailBean();
		try {
			db.preparedSelect(sql.toString());
			db.executePrepared();
			for (int i = 0; i < db.size(); i++) {
				if(i==db.size()-1){
					mailBeans.setMid(db.getString(i,"mid"));
					mailBeans.setTitle(db.getString(i,"title"));
					mailBeans.setContent(db.getString(i,"content"));
					mailBeans.setAttachment_id(db.getString(i,"attachment_id"));
					mailBeans.setCreatetime(db.getString(i,"createtime"));
					mailBeans.setDxtzjsr(db.getString(i,"dxtzjsr"));
					mailBeans.setDxtzjsr(db.getString(i,"receivepid"));
					mailBeans.setSendpid(db.getString(i,"sendpid"));
					mailBeans.setSendpname(db.getString(i,"sendpname"));
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
     * <b>Summary: 修改邮件/草稿转为发送时调用的方法<Object></b>
     * @param MailBean --邮件实体bean对象
     * @return boolean
     */
	@Override
	public boolean updateMailInfo(MailBean mailBean) {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		TransactionManager tm=new TransactionManager();
		try {
			tm.begin();
			//pdb.executeDelete("delete from ymj_oa_user_mail t where  t.mid in("+mailBean.getMid()+")");
			//删除邮件从表信息。
			deleteMainUserDatabase(mailBean.getMid());
			sql.append(" update ymj_oa_jbxx_mail set ");
			sql.append(" title=?,");
			sql.append(" createtime=?,"); 
			sql.append(" attachment_id=?,"); 
			sql.append(" state=?,");  
			sql.append(" deptid=?,");
			sql.append(" deptname=?,");
			sql.append(" sendpid=?,");
			sql.append(" sendpname=?,");
			sql.append(" dxtzjsr=?,");
			sql.append(" content=? "); 
			sql.append(" where mid='"+mailBean.getMid()+"'"); 
		
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
			//移民局短信提醒
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
			 }
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
		}
	}
	/**
	 * <b>Summary: 分页查询已发邮件<List<Object>></b>
	 * @param MailBean --邮件实体bean对象
	 * @param sortName --排序字段
	 * @param sortOrder --排序方式
	 * @param offset --
	 * @param maxPagesize --
	 * @return PagingBean
	 */
	@Override
	public PagingBean findMailInfoListByYjSend(MailBean mailBean,
			String sortName, String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<MailBean> list = new ArrayList<MailBean>();
		StringBuffer sql = new StringBuffer();
		/*sql.append("  select * from ( select mid,max(sendpid) as sendpid ,max(sendpname) as sendpname,max(title) as title,max(createtime) as createtime,wmsys.wm_concat(receivepname) as receivepname from  ( ");
		sql.append(" select ");
		sql.append(" distinct(tt.mid),");
		sql.append(" tt.sendpid,");
		sql.append(" tt.sendpname,");
		sql.append(" tt.title,");
		sql.append(" t.receivepname,");
		sql.append(" tt.createtime");
		sql.append(" from ymj_oa_jbxx_mail tt ");
		if (!StringUtil.nullOrBlank(mailBean.getReceivepname())) {
			sql.append(" (select * from ymj_oa_user_mail where mid in (select u.mid from ymj_oa_user_mail u where u.receivepname like '%"+mailBean.getReceivepname()+"%'))  t");
		}else{
			sql.append("  left join ymj_oa_user_mail t on tt.mid=t.mid");
		}
		
		sql.append(" where 1=1  ");
		if (!StringUtil.nullOrBlank(mailBean.getTitle())) {
			sql.append(" and tt.title like '%"+mailBean.getTitle()+"%'");
		}
		
		if (!StringUtil.nullOrBlank(mailBean.getUse_starttime())) {
			sql.append(" and tt.createtime>='"+mailBean.getUse_starttime()+"'");
		}
		if (!StringUtil.nullOrBlank(mailBean.getUse_endtime())) {
			sql.append(" and tt.createtime<='"+mailBean.getUse_endtime()+"'");
		}
		if (!StringUtil.nullOrBlank(mailBean.getSendpid())) {
			sql.append(" and tt.sendpid='"+mailBean.getSendpid()+"'");
		}
		if (!StringUtil.nullOrBlank(mailBean.getState())) {
			sql.append(" and tt.state='"+mailBean.getState()+"'");
		}
		
		sql.append(" ) a group by a.mid )");
		if(!StringUtil.nullOrBlank(sortName)&&!StringUtil.nullOrBlank(sortOrder)){
			sql.append(" order by "+sortName +" "+ sortOrder);
		}else{
			sql.append(" order by tt.createtime ");
		}*/
		sql.append(" select distinct (mid),sendpid,sendpname,title,createtime,to_char(receivepname) as receivepname from ( ");
		sql.append(" select mid,sendpid,sendpname,title,createtime,'' as receivepname from ( ");
		sql.append(" select * from ( ");
		sql.append(" select tt.mid,");
		sql.append(" tt.sendpid,");
		sql.append(" tt.sendpname,");
		sql.append(" tt.title,");
		sql.append(" t.receivepname,");
		sql.append(" tt.createtime");
		sql.append(" from ymj_oa_jbxx_mail tt ");
		sql.append("  left join ymj_oa_user_mail t on tt.mid=t.mid");
		sql.append(" where 1=1  ");
		
		if (!StringUtil.nullOrBlank(mailBean.getReceivepname())) {
			sql.append(" and t.receivepname like '%"+mailBean.getReceivepname()+"%'");
		}
		if (!StringUtil.nullOrBlank(mailBean.getTitle())) {
			sql.append(" and tt.title like '%"+mailBean.getTitle()+"%'");
		}
		
		if (!StringUtil.nullOrBlank(mailBean.getUse_starttime())) {
			sql.append(" and tt.createtime>='"+mailBean.getUse_starttime()+"'");
		}
		if (!StringUtil.nullOrBlank(mailBean.getUse_endtime())) {
			sql.append(" and substr(tt.createtime,0,10)<='"+mailBean.getUse_endtime()+"'");
		}
		if (!StringUtil.nullOrBlank(mailBean.getSendpid())) {
			sql.append(" and tt.sendpid='"+mailBean.getSendpid()+"'");
		}
		if (!StringUtil.nullOrBlank(mailBean.getState())) {
			sql.append(" and tt.state='"+mailBean.getState()+"'");
		}
		
		sql.append(" ) ) )");
		if(!StringUtil.nullOrBlank(sortName)&&!StringUtil.nullOrBlank(sortOrder)){
			sql.append(" order by "+sortName +" "+ sortOrder);
		}else{
			sql.append(" order by tt.createtime ");
		}
		try {
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.executePrepared();
			for (int i = 0; i < db.size(); i++) {
				MailBean mailBeans = new MailBean();
				mailBeans.setMid(db.getString(i,"mid"));
				mailBeans.setSendpid(db.getString(i,"sendpid"));
				mailBeans.setSendpname(db.getString(i,"sendpname"));
				mailBeans.setCreatetime(db.getString(i,"createtime"));
				mailBeans.setTitle(db.getString(i,"title"));
				String mid = db.getString(i,"mid");
				//查询收件人名称
				HashMap<String,String> replevyUserMap = findReceiveUserMail(mid);
				mailBeans.setReceivepname(replevyUserMap.get("receivepname"));
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
     * <b>Summary: 删除已发送邮件<Object></b>
     * @param id --邮件ID
     * @return boolean
     */
	@Override
	public boolean deleteyjMailInfo(String ids) {
		PreparedDBUtil  db = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		sql.append(" update ymj_oa_jbxx_mail t set state='-1' ");
		sql.append(" where t.mid in("+ids+")"); 
		try {
			db.preparedInsert(sql.toString());
			db.executePrepared();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		return true;
	}
	/**
     * <b>Summary: 由未阅读专为已读<Object></b>
     * @param receivepid --接收者ID
     * @param id --邮件ID
     * @return boolean
     */
	@Override
	public boolean changeReadState(String receivepid, String ids) {
		PreparedDBUtil  db = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		sql.append(" update ymj_oa_user_mail t set readstate='1'   ");
		sql.append(" where t.mid ='"+ids+"'"); 
		sql.append(" and t.receivepid ='"+receivepid+"'"); 
		try {
			db.preparedInsert(sql.toString());
			db.executePrepared();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		return true;
	}
	/**
	 * 短信提醒
	 * @param mettingInfoBean  一会的基本信息
	 * @param Immig_id  会议基本信息编号
	 */
	public void doNoteSend(MailBean mailBean,String idnum){
		List<SmsBean> smsBeanList = new ArrayList<SmsBean>();
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" select u.user_realname ,u.user_mobiletel1,u.user_mobiletel2  ");
		sql.append(" from  td_sm_user u  where u.user_id in ");
		sql.append(" (select ta.RECEIVEPID from ymj_oa_user_mail ta where ");
		sql.append(" ta.mid = ? )");
		try {
			db.preparedSelect(sql.toString());
			db.setString(1,idnum);
			db.executePrepared();
			for(int i=0; i<db.size();i++) {
				SmsSendService smsSendService = new SmsSendServiceImp();
				SmsBean smsBean = new SmsBean();
				if(db.getString(i,"user_mobiletel1").equals(db.getString(i,"user_mobiletel2"))
						&& !"".equals(db.getString(i,"user_mobiletel1"))){
					smsBean.setRECEIVERMOBILENO(db.getString(i,"user_mobiletel1"));
				}else{
						if(!"".equals(db.getString(i,"user_mobiletel1"))) {
							smsBean.setRECEIVERMOBILENO(db.getString(i,"user_mobiletel1"));
						}
						if(!"".equals(db.getString(i,"user_mobiletel2"))) {
							smsBean.setRECEIVERMOBILENOOne(db.getString(i,"user_mobiletel2"));
						}
					}
				smsBean.setMSG("省移民局内网温馨提醒：您有待阅电子邮件，请查阅!  ——〔省局信息分中心〕");
				smsSendService.sendSmsymj(smsBean);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	*<b>Summary: </b>
	* replevyMail(追回 已发邮件)
	* @param userId
	* @param ids
	* @return
	 */
	public boolean replevyMail(String userId,String ids) throws Exception{
		PreparedDBUtil  db = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		sql.append(" update ymj_oa_jbxx_mail t set t.state='0'   ");
		sql.append(" where t.mid in ("+ids+")"); 
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
	*<b>Summary: </b>
	* findreplevyUserMail(查询未查看人员邮件)
	* @param ids
	* @return
	 */
	public HashMap<String,String> findreplevyUserMail(String ids) throws Exception{
		HashMap<String,String> map = new HashMap<String,String>();
		PreparedDBUtil  db = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		String receivepname=""; //收件人姓名
		String receivepid="";  //收件人ID
		sql.append(" select ");
		sql.append("  		t.receivepid,  ");
		sql.append("		t.receivepname ");
		sql.append(" from ymj_oa_jbxx_mail tt, ymj_oa_user_mail t  ");
		sql.append(" where 1 = 1  		   ");
		sql.append(" 		and tt.mid = t.mid						");
		sql.append(" 		and t.readstate <> '1' 				    ");
		sql.append(" and tt.mid ='"+ ids +"'");
		try {
			db.preparedSelect(sql.toString());
			db.executePrepared();
			for (int i = 0; i < db.size(); i++) {
				receivepname += db.getString(i,"receivepname")+",";
				receivepid += db.getString(i,"receivepid")+",";
			}
			if(StringUtils.isBlank(receivepid)){
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
	*<b>Summary: </b>
	* findReceiveUserMail(查询接收人员邮件)
	* @param ids
	* @return
	 */
	public HashMap<String,String> findReceiveUserMail(String ids) throws Exception{
		HashMap<String,String> map = new HashMap<String,String>();
		PreparedDBUtil  db = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		String receivepname=""; //收件人姓名
		String receivepid="";  //收件人ID
		sql.append(" select ");
		sql.append("  		t.receivepid,  ");
		sql.append("		t.receivepname ");
		sql.append(" from ymj_oa_jbxx_mail tt, ymj_oa_user_mail t  ");
		sql.append(" where 1 = 1  		   ");
		sql.append(" 		and tt.mid = t.mid						");
		sql.append(" and tt.mid ='"+ ids +"'");
		try {
			db.preparedSelect(sql.toString());
			db.executePrepared();
			for (int i = 0; i < db.size(); i++) {
				receivepname += db.getString(i,"receivepname")+",";
				receivepid += db.getString(i,"receivepid")+",";
			}
			if(StringUtils.isBlank(receivepid)){
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
	  * <b>Summary: </b>
	  *     复写方法 checkIsEmailBoxMemoryWillBeOverflow
	  * @param userids
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.yimingju.mail.dao.MailDao#checkIsEmailBoxMemoryWillBeOverflow(java.lang.String)
	 */
	public boolean checkIsEmailBoxMemoryWillBeOverflow(String userids) throws Exception {
		
		
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
		int maxAttachSize = 0;
		MailConfigDao mailConfigDao = new MailConfigDaoImpl();
		Map<String,String> resultMap = mailConfigDao.getUserEmailBoxMemoryConfig(userids); 
		if(resultMap != null && resultMap.size() > 0){
			maxAttachSize = Integer.valueOf(resultMap.get(userids.replaceAll("'", "")));
		}
		return maxAttachSize;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* attachSize(获取当前邮件的所有附件大小总和)
	* @return
	* @throws SQLException
	 */
	public int attachSize() throws SQLException{
		PreparedDBUtil  db = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		int attachSize = 0;
		
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

		}
		
		return attachSize;
	}
	
	/**
	*<b>Summary: </b>
	* attach(复制文件信息)
	* @param newDjbh
	* @param oldDjbh
	* @return
	 */
	public boolean copyAttachFile(Connection conn,String newDjbh, String oldDjbh,String creator)throws Exception{
		
		String sql2 ="insert into oa_fc_attach(extend,djbh,dj_sn,filename,attachid,bz,djsn,attachcontent,upload_mode,cc_form_instanceid,creator) ";
		sql2+="    select extend, '"+newDjbh+"' as djbh,dj_sn,   filename,attachid,bz, get_uuid() as djsn,attachcontent,'1' as upload_mode,cc_form_instanceid,'"+creator+"' as creator from oa_fc_attach t where t.djbh = '"+oldDjbh+"' ";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedInsert(sql2);
		pdb.executePrepared(conn);
		return true;
	}
	
}
