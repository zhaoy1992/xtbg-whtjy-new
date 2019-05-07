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
 *<p>Description:教育考试院公文传输发文持久层实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 夏天
 *@version 1.0
 *2013-4-24
 */
public class JyksySendGwDaoImpl extends SendGwDao {
	private static final Logger logger = Logger.getLogger(JyksySendGwDaoImpl.class);
	
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

		sql.append("select send_id, ");
		sql.append("   send_title, ");
		sql.append("   send_word, ");
		sql.append("   send_wall, ");
		sql.append("   sign_send, ");
		sql.append("   send_approve, ");
		sql.append("   send_orgname, ");
		sql.append("   send_orgid, ");
		sql.append("   send_draft, ");
		sql.append("   send_verify, ");
		sql.append("   send_efficacy, ");
		sql.append("   send_bao, ");
		sql.append("   send_bao_id, ");
		sql.append("   send_fa, ");
		sql.append("   send_chao, ");
		sql.append("   send_chao_id, ");
		sql.append("   send_date, ");
		sql.append("   receive_content, ");
		sql.append("   content_html, ");
		sql.append("   receive_affix, ");
		sql.append("   send_year, ");
		sql.append("   send_secret, ");
		sql.append("   send_bmhuiqian, ");
		sql.append("   send_officeverify, ");
		sql.append("   send_count, ");
		sql.append("   send_urgency ");
		sql.append("from jyksy_oa_document_send ");
		sql.append(" where send_id = ? ");
		try{
			pdb.preparedSelect(sql.toString());
			pdb.setString(1, sendId);
			pdb.executePrepared();
			if(pdb.size() > 0){
				gwsBean.setTitle(pdb.getString(0,"send_title"));
				gwsBean.setDispatch_type("通知");//自定义
				gwsBean.setPrefix("湘教考");
				gwsBean.setSymbol("〔"+pdb.getString(0,"send_year")+"〕");
				gwsBean.setSerial_number(pdb.getString(0,"send_wall")+"号");
				gwsBean.setSecrecy_grade(pdb.getString(0,"send_secret"));
				gwsBean.setUrgency_grade(pdb.getString(0,"send_urgency"));
				gwsBean.setCaption(pdb.getString(0,"send_word"));
				//有章无章
				gwsBean.setIssign("true");//默认设置成true
				//gwsBean.setKeyword("");
				gwsBean.setSender(pdb.getString(0,"send_draft"));
				gwsBean.setCreate_date(DateUtil.GetTimeString(pdb.getTimestamp(0,"send_date")) );
				gwsBean.setFile_type(DOCFILETYPE);
				//查询定稿是否
				String count = DaoUtil.SqlToField("select count(*) from document_file where recordid = '"+ pdb.getString(0,"receive_content")+"_ding" + "'");
				if(Integer.valueOf(count)>0){
					gwsBean.setFile_name(pdb.getString(0,"receive_content")+"_ding."+DOCFILETYPE);
					gwsBean.setWordcontent_id(pdb.getString(0,"receive_content")+"_ding");
				} else{
					gwsBean.setWordcontent_id(pdb.getString(0,"receive_content"));
					gwsBean.setFile_name(pdb.getString(0,"receive_content")+"."+DOCFILETYPE);
				}
				
				gwsBean.setAttach_id(pdb.getString(0,"receive_affix"));
				
				
				//获得发文单位机构名称
				String org_id = pdb.getString(0,"send_orgid");
				String[] result = getSendGwOrg(org_id);
				//发文单位机构名称
				gwsBean.setSend_org_name(result[0]);
				//发文单位20位地址码
				gwsBean.setSend_org_addr(result[1]);
				
				String send_bao_id= pdb.getString(0,"send_bao_id");
				String send_bao = pdb.getString(0,"send_bao");
				ArrayList<HashMap<String, String>> addrinfor = new ArrayList<HashMap<String, String>>();
				//主送
				if(!StringUtil.isBlank(send_bao_id)){
					//如果是选择各地方州市，则是发送所有的州市
					if(send_bao_id.indexOf("gw_orgid")>-1){
						String[] results =getSendOrgId();
						send_bao_id = results[0];
						send_bao = results[1];
					}
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
				
				String send_chao_id = pdb.getString(0,"send_chao_id");
				String send_chao = pdb.getString(0,"send_chao");
				//抄送
				if(!StringUtil.isBlank(send_chao_id)){
					//如果是选择各地方州市，则是发送所有的州市
					if(send_chao_id.indexOf("gw_orgid")>-1){
						String[] results =getSendOrgId();
						send_chao_id = results[0];
						send_chao = results[1];
					}
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
			logger.error(e);
		}
		setGwSendBean(gwsBean);
		
	}

	/**
	 * 
	*<b>Summary: </b>
	* getSendGwOrg(根据ID 获得公文传输的机构名称和地址)
	* @param org_id
	* @return
	 */
	private String[] getSendGwOrg(String org_id) throws SQLException{
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from td_oa_gw_organization t, ta_oagw_org oa");
		sql.append(" where t.org_id = oa.gw_orgid");
		sql.append("   and oa.oa_orgid in");
		sql.append("       (select o.org_id");
		sql.append("          from td_sm_organization o");
		sql.append("         start with o.org_id = '"+org_id+"'");
		sql.append("        connect by prior o.parent_id = o.org_id)");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		String [] result = new String[2];
		if(pdb.size() > 0){
			result[0] = pdb.getString(0,"org_name");
			result[1] = pdb.getString(0,"org_addr");
		}
		return result;
	}
	
	/**
	*<b>Summary: </b>
	* getSendOrgId(根据OA机构ID,获取发送OA机构ID。如果选择各地方州市，则是所有公文传输的机构ID)
	* @param sendOrgId
	* @return
	 */
	private String[] getSendOrgId() throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select * from td_oa_gw_organization t where t.org_addr!='00000000000000000000' ");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		String[]  result = new String[2];
		for (int i = 0; i < pdb.size(); i++) {
			if( i==0 ){
				result[0] = pdb.getString(i,"org_id");
				result[1] = pdb.getString(i,"org_name");
			} else {
				result[0] = result[0]+"," + pdb.getString(i,"org_id");
				result[1] = result[1]+"," + pdb.getString(i,"org_name");
			}
		}
		return result;
	}
	
}
