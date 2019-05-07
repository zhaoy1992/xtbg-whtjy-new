package com.chinacreator.xtbg.pub.oagwcs.dao.imploracle;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.log4j.Logger;
import com.chinacreator.xtbg.pub.oagwcs.dao.SendGwDao;
import com.chinacreator.xtbg.pub.oagwcs.entity.GwSendBean;
import com.chinacreator.xtbg.pub.util.DaoUtil;
import com.chinacreator.xtbg.pub.util.DateUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:HuaihuaSendGwDaoImpl.java</p>
 *<p>Description:怀化公文传输发文持久层实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 夏天
 *@version 1.0
 *2013-4-24
 */
public class HuaihuaSendGwDaoImpl extends SendGwDao {
	private static final Logger logger = Logger.getLogger(HuaihuaSendGwDaoImpl.class);
	
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
		sql.append("select  ");
		sql.append("  send_id,send_title,send_word,send_wall,");
		sql.append("   send_year,send_fileno,draft_dept,draft_user, ");
		sql.append("   draft_userid,first_send_user,first_send_username,second_send_user,second_send_username, ");
		sql.append("   copy_num,secretlevel_name,draft_fuzeren,reviewed_idea,");
		sql.append("   verify_idea,send_countersign,sign_send,receive_affix,receive_content,");
		sql.append("   remark1,draft_deptid,send_time,doc_title");
		sql.append("  from hh_oa_document_send ");
		sql.append(" where send_id = ? ");
		try{
			pdb.preparedSelect(sql.toString());
			pdb.setString(1, sendId);
			pdb.executePrepared();
			if(pdb.size() > 0){
				gwsBean.setTitle(pdb.getString(0,"send_title"));
				gwsBean.setDispatch_type("通知");//自定义
				gwsBean.setPrefix(pdb.getString(0,"send_fileno"));
				gwsBean.setSymbol("〔"+pdb.getString(0,"send_year")+"〕");
				gwsBean.setSerial_number(pdb.getString(0,"send_wall")+"号");
				gwsBean.setSecrecy_grade(pdb.getString(0,"secretlevel_name"));
				//有章无章
				gwsBean.setIssign("true");//默认设置成true
				//用户名称 上传用户名称
				String userName = DaoUtil.SqlToField("select t.user_realname from td_sm_user t where t.user_id ='"+user_id+"'");
				gwsBean.setSendusername(userName);//发文操作的用户名称（要有对应关系）
				
				//当前机构的信息
				String [] orgs = getOrgByUserId(user_id);
				gwsBean.setSend_org_name(orgs[0]);//发文单位机构名称（要有对应关系）
				gwsBean.setSend_org_addr(orgs[1]);//发文单位20位地址码（要有对应关系）
				
				gwsBean.setCaption(pdb.getString(0,"send_word"));
				gwsBean.setSender(pdb.getString(0,"draft_user"));
				gwsBean.setCreate_date(DateUtil.GetTimeString(pdb.getTimestamp(0,"send_time")) );
				gwsBean.setFile_type(DOCFILETYPE);
				gwsBean.setFile_name(pdb.getString(0,"receive_content")+"."+DOCFILETYPE);
				gwsBean.setAttach_id(pdb.getString(0,"receive_affix"));
				gwsBean.setWordcontent_id(pdb.getString(0,"receive_content"));
				
				String send_bao_id= pdb.getString(0,"first_send_user");
				String send_bao = pdb.getString(0,"first_send_username");
				ArrayList<HashMap<String, String>> addrinfor = new ArrayList<HashMap<String, String>>();
				//主送
				if(!StringUtil.isBlank(send_bao_id)){
					String[] temp_send_id = null;
					String[] temp_send_name = null;
					if(send_bao_id.indexOf(",")!=-1){
						 temp_send_id = send_bao_id.split(",");
						 temp_send_name = send_bao.split(",");
						
					} else {
						temp_send_id = new String[1];
						temp_send_name =new String[1];
						temp_send_id[0]= send_bao_id;
						temp_send_name[0] = send_bao;
					}
					for(int i=0;i<temp_send_id.length;i++){
						String receiveraddr =DaoUtil.SqlToField("select t.org_addr from td_oa_gw_organization t where t.org_id ='"+temp_send_id[i]+"'");
						if(!StringUtil.isBlank(receiveraddr)){
							HashMap<String, String> map = new HashMap<String, String>();
							map.put("receiveraddr", receiveraddr);
							map.put("receivername", temp_send_name[i]);
							map.put("print_num", "1");
							if(!StringUtil.isBlank(StringUtil.deNull(pdb.getString(0,"send_wall")))){
								map.put("num", StringUtil.deNull(pdb.getString(0,"send_wall")));
							} else {
								map.put("num", "0");
							}
							
							map.put("send_type", "m");//主送
							addrinfor.add(map);
						}
					}
				}
				
				String send_chao_id = pdb.getString(0,"second_send_user");
				String send_chao = pdb.getString(0,"second_send_username");
				//抄送
				if(!StringUtil.isBlank(send_chao_id)){
					String[] temp_chao_id = null;
					String[] temp_chao_name = null;
					if(send_chao_id.indexOf(",")!=-1){
						temp_chao_id = send_chao_id.split(",");
						temp_chao_name = send_chao.split(",");
						
					} else {
						temp_chao_id = new String[1];
						temp_chao_name =new String[1];
						temp_chao_id[0]= send_chao_id;
						temp_chao_name[0] = send_chao;
					}
					for(int i=0;i<temp_chao_id.length;i++){
						String receiveraddr =DaoUtil.SqlToField("select t.org_addr from td_oa_gw_organization t where t.org_id ='"+temp_chao_id[i]+"'");
						if(!StringUtil.isBlank(receiveraddr)){
							HashMap<String, String> map1 = new HashMap<String, String>();
							map1.put("receiveraddr", receiveraddr);
							map1.put("receivername", temp_chao_name[i]);
							map1.put("print_num", "1");
							if(!StringUtil.isBlank(StringUtil.deNull(pdb.getString(0,"send_wall")))){
								map1.put("num", StringUtil.deNull(pdb.getString(0,"send_wall")));
							} else {
								map1.put("num", "0");
							}
							map1.put("send_type", "c");//抄送
							addrinfor.add(map1);
						}
					}
				}
				gwsBean.setAddrinfor(addrinfor);//收文单位的相关信息
			}
		}catch(SQLException e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		setGwSendBean(gwsBean);
	}
	
	/**
	*<b>Summary: </b>
	* getOrgByUserId(得到当前用户的父级机构)
	* @param userId
	* @return
	 */
	public  String[] getOrgByUserId(String userId) {
		String [] result = new String[2];
		try{
			PreparedDBUtil pdb = new PreparedDBUtil();
			StringBuffer sql = new StringBuffer();
			
			sql.append("select *");
			sql.append("  from td_oa_gw_organization t, ta_oagw_org oa");
			sql.append(" where t.org_id = oa.gw_orgid");
			sql.append("   and oa.oa_orgid in");
			sql.append("       (select o.org_id");
			sql.append("          from td_sm_organization o");
			sql.append("         start with o.org_id = (select t.org_id from td_sm_orguser t where t.user_id='"+userId+"')");
			sql.append("        connect by prior o.parent_id = o.org_id)");
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
			
			if(pdb.size() > 0){
				result[0] = pdb.getString(0,"org_name");
				result[1] = pdb.getString(0,"org_addr");
			}
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		return result;
	}

}
