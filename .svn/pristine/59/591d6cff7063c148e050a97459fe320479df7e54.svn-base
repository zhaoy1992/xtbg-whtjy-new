package com.chinacreator.xtbg.pub.oagwcs.dao.imploracle;

import java.sql.SQLException;

import com.chinacreator.xtbg.pub.oagwcs.dao.SendGwDao;
import com.chinacreator.xtbg.pub.oagwcs.entity.GwSendBean;
import com.chinacreator.xtbg.pub.util.DateUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:YmjSendGwDaoImpl.java</p>
 *<p>Description:移民局公文传输发文持久层实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 夏天
 *@version 1.0
 *2013-4-24
 */
public class YmjSendGwDaoImpl extends SendGwDao {
	
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getGwSendInfoBySendId
	  * @param sendId 
	  * @see com.chinacreator.xtbg.pub.oagwcs.dao.SendGwDao#getGwSendInfoBySendId(java.lang.String)
	 */
	protected void getGwSendInfoBySendId(String sendId,String user_id) {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		GwSendBean gwsBean = new GwSendBean();
		sql.append("select send_date, ");
		sql.append("   content_html, ");
		sql.append("   send_title, ");
		sql.append("       send_zs, ");
		sql.append("       send_cs, ");
		sql.append("       send_word, ");
		sql.append("       send_num, ");
		sql.append("       send_typewrite, ");
		sql.append("       send_efficacy, ");
		sql.append("       send_wall, ");
		sql.append("       secretlevel_name, ");
		sql.append("       urgencylevel_name, ");
		sql.append("       draft_username, ");
		sql.append("       draft_userid, ");
		sql.append("       send_countersign, ");
		sql.append("       send_responsible, ");
		sql.append("       send_verify, ");
		sql.append("       send_sponsor, ");
		sql.append("       send_office, ");
		sql.append("       sign_send, ");
		sql.append("       receive_affix, ");
		sql.append("       send_typeword, ");
		sql.append("       receive_content, ");
		sql.append("       send_year ");
		sql.append("  from ymj_oa_document_sendymj ");
		sql.append(" where send_id = ? ");
		try{
			pdb.preparedSelect(sql.toString());
			pdb.setString(1, sendId);
			pdb.executePrepared();
			if(pdb.size() > 0){
				gwsBean.setTitle(pdb.getString(0,"send_title"));

				gwsBean.setDispatch_type("1");//自定义
				gwsBean.setPrefix(pdb.getString(0,"send_typeword"));
				gwsBean.setSymbol("〔"+pdb.getString(0,"send_year")+"〕");
				gwsBean.setSerial_number(pdb.getString(0,"send_wall")+"号");
				gwsBean.setSecrecy_grade(pdb.getString(0,"secretlevel_name"));
				gwsBean.setUrgency_grade(pdb.getString(0,"urgencylevel_name"));
				gwsBean.setCaption(pdb.getString(0,"send_word"));
				gwsBean.setKeyword("");
				gwsBean.setSender(pdb.getString(0,"draft_username"));
				gwsBean.setCreate_date(DateUtil.GetTimeString(pdb.getTimestamp(0,"send_date")) );
				gwsBean.setFile_type(DOCFILETYPE);
				gwsBean.setFile_name(pdb.getString(0,"receive_content")+"."+DOCFILETYPE);
				gwsBean.setAttach_id(pdb.getString(0,"receive_affix"));
				gwsBean.setWordcontent_id(pdb.getString(0,"receive_content"));
			}
		}catch(SQLException e){
			
		}
		setGwSendBean(gwsBean);
		
	}


	public static void main(String[] args) {
		SendGwDao sendGwDao = new YmjSendGwDaoImpl();
		sendGwDao.createSendArchiveRequestBeanBySendId("503","");
		
		
	}
	

}
