package com.chinacreator.xtbg.core.sysparam.util;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.sysparam.dao.SysParamDao;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:SysParamUitl.java</p>
 *<p>Description:系统参数工具类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-8-8
 */
public class SysParamUitl extends XtDbBaseDao {

	private static final Log LOG = LogFactory.getLog(SysParamUitl.class);
	
	
	
	/**
	*<b>Summary: </b>
	* getSysParamByTableName(根据类型得到参数list)
	* @param code
	* @return 
	*/
	public List<Map<String, String>> getSysParamByTableName(String code,String type){
		List<Map<String, String>> list= new ArrayList<Map<String,String>>();
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			String sql = "select * from oa_sys_param p left join oa_dict_data d on p.dictdata_id=d.dictdata_id where dictdata_value=? and p_type=? ";
			list=queryToListMap(sql, conn, code,type);
		} catch (Exception e) {
			LOG.error("获得参数失败" + e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return list;
	}
	
	
	/**
	 * 
	*<b>Summary: </b>
	* getSysParamValue(获得系统参数值)
	* @param p_code
	* @return
	 */
	public static String getSysParamValue(String p_code) {
		Connection conn = null;
		String p_content = "";
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			conn = DbManager.getInstance().getConnection();
			String sql = "select p.p_content from oa_sys_param p where p.p_code=?";
			pdb.preparedSelect(sql);
			pdb.setString(1, p_code);
			pdb.executePrepared(conn);
			if(pdb.size() > 0) {
				p_content = pdb.getString(0, "p_content");
			}
		} catch (SQLException e) {
			LOG.error("获得参数失败" + e.getMessage(), e);
		}finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return p_content;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* getSystemValue(根据编号查询系统参数下相应参数类型的所有参数)
	* @return
	 */
	public List<Map<String, String>> getSystemValue(String code){
		List<Map<String, String>> list= new ArrayList<Map<String,String>>();
		
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			String sql = "select * from oa_sys_param p left join oa_dict_data d on p.dictdata_id=d.dictdata_id where dictdata_value=? ";
			
			list=queryToListMap(sql, conn, code);
			
		} catch (Exception e) {
			LOG.error("获得参数失败" + e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		
		return list;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* getSystemValue(判断全局参数的消息类型有那些)
	* @return
	 */
	public Map<String, String> getCheckedSystemMsg(){
		Map<String, String> map1=new HashMap<String, String>();
		
		List<Map<String,String>> list=getSystemValue(SysParamConstant.SYSTEM_CODE);
		String is_pub_sms="";
		String is_pub_mail="";
		String is_pub_rtx="";
		String is_pub_msg="";
		if(list.size()>0){
			for (Map<String, String> map : list) {
				if(map.get("p_code").equals(SysParamConstant.IS_PUB_MAIL)){
					is_pub_mail=map.get("p_content");
				}
				if(map.get("p_code").equals(SysParamConstant.IS_PUB_MSG)){
					is_pub_msg=map.get("p_content");
				}
				if(map.get("p_code").equals(SysParamConstant.IS_PUB_RTX)){
					is_pub_rtx=map.get("p_content");
				}
				if(map.get("p_code").equals(SysParamConstant.IS_PUB_SMS)){
					is_pub_sms=map.get("p_content");
				}
			}
		}
		map1.put(SysParamConstant.IS_PUB_MAIL, is_pub_mail);
		map1.put(SysParamConstant.IS_PUB_MSG, is_pub_msg);
		map1.put(SysParamConstant.IS_PUB_RTX, is_pub_rtx);
		map1.put(SysParamConstant.IS_PUB_SMS, is_pub_sms);
		
		
		return map1;
	}
	
	
	/**
	*<b>Summary: </b>
	* getSysParamValueDetail(获得系统从表参数值)
	* @param p_code
	* @return 
	*/
	public static List<Map<String, String>> getSysParamValueDetail(String p_code) {
		Connection conn = null;
		SysParamDao dao = null;
		List<Map<String, String>> listmap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			listmap = new ArrayList<Map<String, String>>();
			dao = (SysParamDao)LoadSpringContext.getApplicationContext().getBean("sysParamDaoImpl");
			listmap = dao.getSysParamvalueByPcode(p_code);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return listmap;
	}
	
	
	/**
	*<b>Summary: </b>
	* getSysParamValueIsVALID(得到设置有效的知识库提示短信模板，有1条以上有效的取最新的)
	* @param p_type
	* @return 
	*/
	public static String getSysParamValueIsVALID(String p_type) {
		Connection conn = null;
		String p_code = "";
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			conn = DbManager.getInstance().getConnection();
			String sql = "select dd.* from (select p.p_code from oa_sys_param p where p_valid='1' and  p.p_type=? order by p.p_creator_time desc) dd where rownum=1 ";
			pdb.preparedSelect(sql);
			pdb.setString(1, p_type);
			pdb.executePrepared(conn);
			if(pdb.size() > 0) {
				p_code = pdb.getString(0, "p_code");
			}
		} catch (SQLException e) {
			LOG.error("获得参数失败" + e.getMessage(), e);
		}finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return p_code;
	}
}
