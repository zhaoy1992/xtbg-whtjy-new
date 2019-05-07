package com.chinacreator.xtbg.pub.sms.service.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.jboss.logging.Logger;

import com.chinacreator.xtbg.core.common.note.entity.NoteBufferBean;
import com.chinacreator.xtbg.core.common.note.entity.NoteDetailBean;
import com.chinacreator.xtbg.core.common.note.services.NoteService;
import com.chinacreator.xtbg.core.common.note.services.impl.NoteServiceImpl;
import com.chinacreator.xtbg.pub.sms.service.SmsServiceIfc;
import com.chinacreator.xtbg.pub.sms.smsutil.SmsUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:WcSmsServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛
 *@version 1.0
 *2013-6-20
 */
public class WcSmsServiceImpl implements SmsServiceIfc{
	private static final Logger LOG = Logger.getLogger(WcSmsServiceImpl.class);
	@Override
	public void smsDataAssembling(Map<String, String> map, Connection con)
			throws Exception {
		SmsUtil smsUtil = new SmsUtil();
		try {
			if ("dxfs".equals(map.get("type")) && ("Y").equals(map.get("isSend"))) {
				List<NoteDetailBean> txl_list =oneSendPersonPhone(map);
				List<NoteDetailBean>  user_list = (List<NoteDetailBean>) smsUtil.getRecipient(map);
				txl_list.addAll(user_list);
				NoteBufferBean bean = new NoteBufferBean();
				StringBuffer content = new StringBuffer();
				content.append(map.get("content"));
				bean.setContent(content.toString());
				bean.setUser_name(map.get("accepter"));
				NoteService noteService = new NoteServiceImpl();
				noteService.doNoteSend(bean ,txl_list,con);
			}else if("dxfs".equals(map.get("type")) && ("N").equals(map.get("isSend"))) {
				
			}
			else if("Y".equals(map.get("isSend")) && "project_sendmsg".equals(map.get("type"))){
				List<NoteDetailBean>  list = (List<NoteDetailBean>) smsUtil.getRecipient(map);
				if(list.size()>0){
					NoteBufferBean bean = new NoteBufferBean();
					StringBuffer content = new StringBuffer();
					content.append(map.get("content")+"("+map.get("accepter")+"发送)");
					bean.setContent(content.toString());
					bean.setUser_name(map.get("accepter"));
					NoteService noteService = new NoteServiceImpl();
					noteService.doNoteSend(bean ,list,con);
				}
			}else{
				List<NoteDetailBean>  list = (List<NoteDetailBean>) smsUtil.getRecipient(map);
				if(list.size()>0){
					NoteBufferBean bean = new NoteBufferBean();
					StringBuffer content = new StringBuffer();
					content.append(map.get("content")+"("+map.get("accepter")+"发送)");
					bean.setContent(content.toString());
					bean.setUser_name(map.get("accepter"));
					NoteService noteService = new NoteServiceImpl();
					noteService.doNoteSend(bean ,list,con);
				}
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			throw e;
		}
		
	}
	/**
	 * 
	 * @param content 短息内容
	 * @param userid  用户id
	 * @return 组装好数据的集合
	 * @throws SQLException
	 * 发送给别人的数据形式为 phone1   
	 */
	
	public List<NoteDetailBean> oneSendPersonPhone(Map<String, String> map) throws SQLException{
		List<NoteDetailBean> list = new ArrayList<NoteDetailBean>();
		StringBuffer sql = new StringBuffer();
		String endUserid=SplitUserid(map.get("txl_user_id"));//个人和公共通讯录id最终拼接成sqlid
		String enddwid =SplitUserid(map.get("dwid"));//单位通讯录id最终拼接成sqlid
		boolean isNotBlank = !StringUtil.isBlank(endUserid) && !StringUtil.isBlank(enddwid);//判断个人、公共、单位通讯录是否都不为空；
		if(isNotBlank){
			sql.append("select distinct name,commonlymobile from (");
		}
		if(!StringUtil.isBlank(endUserid)){
			sql.append("  select  name,(select t1.field_value from oa_personwork_extrainfo t1");
			sql.append("  where t1.person_id = t.person_id and t1.field_name = '办公手机'");
			sql.append("  and rownum = 1) as commonlymobile   from oa_personwork_personinfo t where t.person_id in("+endUserid+")");
		}
		if(isNotBlank){
			sql.append(" union ");
		}
		if(!StringUtil.isBlank(enddwid)){
			sql.append("select u.user_realname ,u.user_mobiletel1 commonlymobile ");
			sql.append(" from  td_sm_user u  where ");
			sql.append(" u.user_id in("+enddwid+")");
		}
		if(isNotBlank){
			sql.append(" )");
		}
		PreparedDBUtil db = new PreparedDBUtil();
		/*sql.append("  select  name,(select t1.field_value from oa_personwork_extrainfo t1");
		sql.append("  where t1.person_id = t.person_id and t1.field_name = '办公手机'");
		sql.append("  and rownum = 1) as commonlymobile   from oa_personwork_personinfo t where t.person_id in("+endUserid+")");*/
		db.preparedSelect(sql.toString());
		db.executePrepared();
		for(int i=0; i<db.size();i++) {
			NoteDetailBean smsSendBean = new NoteDetailBean();
			if(null != db.getString(i,"commonlymobile") && !"".equals(db.getString(i,"commonlymobile"))){
				smsSendBean.setPhone_num(db.getString(i,"commonlymobile"));
				smsSendBean.setUser_name(db.getString(i,"name"));
				list.add(smsSendBean);
			}
		}
		return 	list;
	}
	public String SplitUserid(String userid ){
		if(StringUtil.isBlank(userid)){
			return userid;
		}
		StringBuffer endUserid = new StringBuffer();
		String[] userIdArry = null;
		userIdArry = userid.split(",");
		
		if(userIdArry.length == 0){
			return "";//长度为0，返回空字符串
		}
		for(int i=0 ;i<userIdArry.length ; i++){
			endUserid.append("'").append(userIdArry[i]).append("'").append(",");
		}
		return endUserid.substring(0,endUserid.length()-1).toString();
	}
}
