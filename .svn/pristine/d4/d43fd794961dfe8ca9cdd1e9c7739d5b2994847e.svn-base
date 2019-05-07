package com.chinacreator.xtbg.pub.sms.smsutil;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.chinacreator.xtbg.core.common.note.entity.NoteDetailBean;
import com.chinacreator.xtbg.pub.sms.dao.SmsSenddao;
import com.chinacreator.xtbg.pub.sms.dao.impl.SmsSenddaoImp;
import com.chinacreator.xtbg.pub.sms.entity.SmsBean;
import com.chinacreator.xtbg.pub.sms.entity.SmsSendBean;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class SmsUtil {
	
	private static final int  PHONE_MAX = 100;
	public  List<SmsBean> DataAssemble (String content,String userid) throws Exception{
		String startUserid  = null;
		List<SmsBean> smsBeanList = new ArrayList<SmsBean>();
		startUserid = SplitUserid(userid);
		smsBeanList = AssemblePhone(startUserid.toString(),content);
		return smsBeanList;
		
	}
	/**
	 * 
	 * @param startUserid  用户id
	 * @param content   短信内容
	 * @return  组装好数据的集合
	 * @throws SQLException
	 * 发送给别人数据形式为phone1;phone2  110;120
	 * 已分号隔开，作为一条数据发送
	 */
	public  List<SmsBean> AssemblePhone(String startUserid,String content) throws SQLException{
		List<SmsBean> list = new ArrayList<SmsBean>();
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil db = new PreparedDBUtil();
		sql.append("select u.user_realname ,u.user_mobiletel1,u.user_mobiletel2  ");
		sql.append(" from  td_sm_user u  where u.user_id in ("+startUserid+")");
		db.preparedSelect(sql.toString());
		db.executePrepared();
		for(int j = 0; j<db.size() ; j++){
			StringBuffer phoneNum = new StringBuffer();//保存的为当前用户的电话号码
			SmsBean smsBean = new SmsBean();
			if(!"".equals(db.getString(j,"user_mobiletel1"))) {
				phoneNum.append(db.getString(j,"user_mobiletel1")).append(";");
			}
			if(!"".equals(db.getString(j,"user_mobiletel2"))) {
				phoneNum.append(db.getString(j,"user_mobiletel2")).append(";");
			}
			if(phoneNum.length()>0){
				smsBean.setTel(phoneNum.substring(0,phoneNum.length() - 1));
				smsBean.setContent(content);
				list.add(smsBean);
			}
		}
		return list;
	}
	/**
	 * 
	 * @param content 短息内容
	 * @param userid  用户id
	 * @return 组装好数据的集合
	 * @throws SQLException
	 * 发送给别人的数据形式为 phone1   phone2   
	 * 发送两条数据
	 */
	
	public List<SmsBean> AloneSendPhone(String content,String userid ) throws SQLException{
		List<SmsBean> list = new ArrayList<SmsBean>();
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil db = new PreparedDBUtil();
		String endUserid = SplitUserid(userid);
		sql.append("select u.user_realname ,u.user_mobiletel1,u.user_mobiletel2  ");
		sql.append(" from  td_sm_user u  where u.user_id in ("+endUserid+")");
		db.preparedSelect(sql.toString());
		db.executePrepared();
		for(int i=0; i<db.size();i++) {
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
				smsBean.setMSG(content);
				list.add(smsBean);
		}
			return 	list;
	}
	
	public void SendPhone(List<SmsBean> list) throws Exception{
		SmsSenddao smsDao = new SmsSenddaoImp();
		for(int k =0; k < list.size(); k++){
				SmsBean smsBean = list.get(k);
				smsDao.sendSms(smsBean);
			}
		}
	
	public String SplitUserid(String userid ){
		StringBuffer endUserid = new StringBuffer();
		String[] userIdArry = null;
		userIdArry = userid.split(",");
		for(int i=0 ;i<userIdArry.length ; i++){
			endUserid.append("'").append(userIdArry[i]).append("'").append(",");
		}
		
		return endUserid.substring(0,endUserid.length()-1).toString();
	}
	
	
    
    /**
     * 
    *<b>Summary: </b>
    * getTelNum(得到手机号码:100个号码为一组)
    * @param list
    * @return
     */
    public String[] getTelNum(List<SmsBean> list) {
    	String[] phones = null;
    	if(list != null) {
    		if(list.size() > 0){
    			int length = (list.size()+PHONE_MAX-1) /PHONE_MAX ; 
    			phones = new String[length] ;
    			int k = 0 ; //定义一个变量记录数组的下标
    			StringBuffer phone = new StringBuffer();
    			for(int i=0; i<list.size(); i++) {
    				phone.append(((SmsBean)list.get(i)).getTel()) ;
    				phone.append(";") ;
    				if(i != 0 && (i+1)%PHONE_MAX==0) {
    					phones[k++] = phone.toString().substring(0, phone.length()-1) ;
    					phone.delete(0, phone.length()) ;
    					continue ;
    				} else if(i+1 == list.size()) {
    					phones[k++] = phone.toString().substring(0, phone.length()-1) ;
    					phone.delete(0, phone.length()) ;
    					continue ;
    				}
    			}
    			
    		}
    	}
    	return phones;
    }
    
    /**为以后做统计使用
	 * 将发送的数据插入的ta_oa_sms表中
	 * @param subCode   编码
	 * @param type_code 业务类型编码
	 */
	public void insertSms(int subCode,String type_code,String seq,String str) {
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil db = new PreparedDBUtil();
		sql.append(" insert into TA_OA_SMS SMS ( SMS.ID,SMS.SUBCODE,SMS.SMS_DATE,SMS.TYPE_CODE )")
		.append("values (?,?,sysdate,?)");
		try {
			db.preparedInsert(sql.toString());
			db.setString(1,seq);
			db.setString(2,String.valueOf(subCode));
			db.setString(3,type_code+str);//加上业务数据的标识
			db.executePrepared();
		} catch (SQLException e) {
			e.printStackTrace();
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
	
	public List<SmsSendBean> oneSendPhone(Map<String, String> map) throws SQLException{
		List<SmsSendBean> list = new ArrayList<SmsSendBean>();
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil db = new PreparedDBUtil();
		sql.append("select u.user_realname ,u.user_mobiletel1 ");
		sql.append(" from  td_sm_user u where 1=1");
		String endUserid=SplitUserid(map.get("user_id"));
		if(null == map.get("dynamicperformer")|| "".equals(map.get("dynamicperformer"))){
			 sql.append(" and u.user_id in ("+endUserid+")");
		}else{
			 sql.append(" and u.user_name in ("+endUserid+")");
		}
		db.preparedSelect(sql.toString());
		db.executePrepared();
		for(int i=0; i<db.size();i++) {
			StringBuffer phoneNum = new StringBuffer();//保存的为当前用户的电话号码
			SmsSendBean smsSendBean = new SmsSendBean();
			if(null != db.getString(i,"user_mobiletel1") && !"".equals(db.getString(i,"user_mobiletel1"))){
				smsSendBean.setReceive(db.getString(i,"user_mobiletel1"));
				if(null == map.get("content") || "".equals(map.get("content"))){
					//得到职务简称 
					String userName =getUserduties(map.get("userName"));
					smsSendBean.setUserName(userName);
				}
				
				
				list.add(smsSendBean);
			}
			
			
				
		}
		return 	list;
	}
	
	public List<NoteDetailBean>  getRecipient(Map<String, String> map) throws SQLException{
		List<NoteDetailBean> list = new ArrayList<NoteDetailBean>();
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil db = new PreparedDBUtil();
		sql.append("select u.user_realname ,u.user_mobiletel1,u.user_id ");
		sql.append(" from  td_sm_user u where 1=1");
		String endUserid=SplitUserid(map.get("user_id"));
		if(null == map.get("dynamicperformer")|| "".equals(map.get("dynamicperformer"))){
			 sql.append(" and u.user_id in ("+endUserid+")");
		}else{
			 sql.append(" and u.user_name in ("+endUserid+")");
		}
		db.preparedSelect(sql.toString());
		db.executePrepared();
		for(int i=0; i<db.size();i++) {
			NoteDetailBean bean = new NoteDetailBean();
			if(null != db.getString(i,"user_mobiletel1") && !"".equals(db.getString(i,"user_mobiletel1"))){
				bean.setPhone_num(db.getString(i,"user_mobiletel1"));
				bean.setUser_name(db.getString(i,"user_realname"));
				bean.setUser_id(db.getString(i,"user_id"));
				list.add(bean);
			}
			
		}
		return list;
	}
	
	/**
	 * 
	 * @param content 短息内容
	 * @param userid  用户id
	 * @return 组装好数据的集合
	 * @throws SQLException
	 * 发送给别人的数据形式为 phone1   
	 */
	
	public List<SmsSendBean> oneSendPersonPhone(Map<String, String> map) throws SQLException{
		List<SmsSendBean> list = new ArrayList<SmsSendBean>();
		StringBuffer sql = new StringBuffer();
		String endUserid=SplitUserid(map.get("user_id"));
		//来源人ID
		String sendUser_id = SplitUserid(map.get("is_source"));
		PreparedDBUtil db = new PreparedDBUtil();
		sql.append("select *");
		sql.append("  from (select distinct (t.person_id),");
		sql.append("                        name,");
		sql.append("                        (select t1.field_value");
		sql.append("                           from ta_oa_personwork_extrainfo t1");
		sql.append("                          where t1.person_id = t.person_id");
		sql.append("                            and t1.field_name = '办公手机'");
		sql.append("                            and rownum = 1) commonlymobile,");
		sql.append("                        t.user_id,");
		sql.append("                        t.eng_name");
		sql.append("          from ta_oa_personwork_personinfo t");
		sql.append("          left join ta_oa_personwork_extrainfo e on t.person_id =");
		sql.append("                                                    e.person_id");
		sql.append("         where t.info_type = 'personal'");
		sql.append("        union");
		sql.append("        select to_char(t3.user_id) as person_id,");
		sql.append("               t3.user_realname as name,");
		sql.append("               t3.user_mobiletel1 as commonlymobile,");
		sql.append("               r.user_id,");
		sql.append("               t3.user_name");
		sql.append("          from td_sm_user t3");
		sql.append("         inner join ta_oa_persondirect_relation r on r.directoryid =");
		sql.append("                                                     t3.user_id) tt");
		sql.append(" where tt.user_id in ("+sendUser_id+")");
		sql.append("  and tt.person_id in("+endUserid+")");
		sql.append(" order by person_id desc");
		sql.append("");
		db.preparedSelect(sql.toString());
		db.executePrepared();
		for(int i=0; i<db.size();i++) {
			SmsSendBean smsSendBean = new SmsSendBean();
			if(null != db.getString(i,"commonlymobile") && !"".equals(db.getString(i,"commonlymobile"))){
				smsSendBean.setReceive(db.getString(i,"commonlymobile"));
				list.add(smsSendBean);
			}
		}
		return 	list;
	}
	/**
	 * 
	 * @param content 短息内容
	 * @param userid  用户id
	 * @return 组装好数据的集合
	 * @throws SQLException
	 * 发送给别人的数据形式为 phone1;phone2   
	 */
	public List<SmsBean> twoSendPhone(Map<String, String> map) throws SQLException{
		List<SmsBean> list = new ArrayList<SmsBean>();
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil db = new PreparedDBUtil();
		sql.append("select u.user_realname ,u.user_mobiletel1,u.user_mobiletel2  ");
		sql.append(" from  td_sm_user u  where ");
		String endUserid=SplitUserid(map.get("user_id"));
		if(null == map.get("dynamicperformer")|| "".equals(map.get("dynamicperformer"))){
			 sql.append(" u.user_id in ("+endUserid+")");
		}else{
			 sql.append(" u.user_name in ("+endUserid+")");
		}
		db.preparedSelect(sql.toString());
		db.executePrepared();
		for(int i=0; i<db.size();i++) {
			StringBuffer phoneNum = new StringBuffer();//保存的为当前用户的电话号码
			SmsBean smsBean = new SmsBean();
			if(!"".equals(db.getString(i,"user_mobiletel1"))) {
				phoneNum.append(db.getString(i,"user_mobiletel1")).append(";");
			}
			if(!"".equals(db.getString(i,"user_mobiletel2"))) {
				phoneNum.append(db.getString(i,"user_mobiletel2")).append(";");
			}
			if(phoneNum.length()>0){
				smsBean.setTel(phoneNum.substring(0,phoneNum.length() - 1));
				list.add(smsBean);
			}
			
			
				
		}
		return 	list;
	}
	/**
	 * 
	 * @param content 短息内容
	 * @param userid  用户id
	 * @return 组装好数据的集合
	 * @throws SQLException
	 * 发送给别人的数据形式为 phone1     phone2   
	 */
	public List<SmsBean> threeSendPhone(Map<String, String> map) throws SQLException{
		List<SmsBean> list = new ArrayList<SmsBean>();
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil db = new PreparedDBUtil();
		sql.append("select u.user_realname ,u.user_mobiletel1,u.user_mobiletel2  ");
		sql.append(" from  td_sm_user u  where ");
		String endUserid=SplitUserid(map.get("user_id"));
		if(null == map.get("dynamicperformer")|| "".equals(map.get("dynamicperformer"))){
			 sql.append(" u.user_id in ("+endUserid+")");
		}else{
			 sql.append(" u.user_name in ("+endUserid+")");
		}
		db.preparedSelect(sql.toString());
		db.executePrepared();
		for(int i=0; i<db.size();i++) {
			StringBuffer phoneNum = new StringBuffer();//保存的为当前用户的电话号码
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
			list.add(smsBean);
		}
		return 	list;
	}
	/**
	 * 
	*<b>Summary: </b>
	* smsSendDao(请用一句话描述这个方法的作用)
	* 短信发送
	* @param smsBean
	* @throws SQLException
	 */
	public void smsSendDao(SmsBean smsBean) throws SQLException{
		PreparedDBUtil  pdb = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		sql.append(" insert into  ");
		sql.append("   T_SendTask ( TaskID,DestNumber,Content )");
		sql.append("   values( SEQ_T_SendTask.nextval,?,? ) ");
			if(!StringUtil.isBlank(smsBean.getRECEIVERMOBILENO())){
				pdb.preparedInsert(sql.toString());
				pdb.setString(1,smsBean.getRECEIVERMOBILENO());
				pdb.setString(2,smsBean.getMSG());
				pdb.executePrepared();
			}
			if(!StringUtil.isBlank(smsBean.getRECEIVERMOBILENOOne())){
				pdb.preparedInsert(sql.toString());
				pdb.setString(1,smsBean.getRECEIVERMOBILENOOne());
				pdb.setString(2,smsBean.getMSG());
				pdb.executePrepared();
			}
	}
	
	
	/**
	*<b>Summary: </b>
	* getUserduties(取得用户的职务简称)
	* @param userIds
	* @return
	* @throws SQLException
	 */
	public String getUserduties(String userIds) throws SQLException{
		//返回字符窜
		String resultStr = "";
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select t.duties, u.user_realname ");
		sql.append("   from ta_oa_userandsn t ");
		sql.append("   left join td_sm_user u on t.userid = u.user_id ");
		sql.append("   where u.user_name in ('"+userIds+"')");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		for (int i = 0; i < pdb.size(); i++) {
			String duties = pdb.getString(i, "duties");
			String user_realname = pdb.getString(i, "user_realname");
			if(!StringUtil.isBlank(duties)){
				resultStr += duties + ",";
			}else {
				resultStr += user_realname + ",";
			}
		}
		
		if(resultStr.length()>0){
			resultStr = resultStr.substring(0, resultStr.length()-1);
		}
		return resultStr;
	}
	 public  String replaceBlank(String str) {  
	     String dest = "";  
	      if (str!=null) {  
	        Pattern p = Pattern.compile("\\s*|\t|\r|\n");  
	        Matcher m = p.matcher(str);  
	        dest = m.replaceAll("");  
	        if(dest.length() > 20){
	        	dest  = dest.substring(0,20);
	        }else{
	        	dest = dest;
	        }
	      }  
	     return dest;  
	} 

}
