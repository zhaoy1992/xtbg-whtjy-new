package com.chinacreator.xtbg.core.wordnumdef.dao.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import com.chinacreator.xtbg.core.archive.entity.OaWordNumberBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.wordnumdef.dao.WordNumDefDao;
import com.chinacreator.xtbg.core.wordnumdef.entity.SerialNumberBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:WordNumDefDaoImpl.java</p>
 *<p>Description:文号维护接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-10-17
 */
public class WordNumDefDaoImpl extends XtDbBaseDao implements WordNumDefDao {

	/**
	 * 
	  * <b>Summary: 根据id得到文号信息</b>
	  *     复写方法 getWordNumBean
	  * @param id
	  * @param conn
	  * @return 
	  * @see com.chinacreator.xtbg.core.wordnumdef.dao.WordNumDefDao#getWordNumBean(java.lang.String, java.sql.Connection)
	 */
	public Map<String, String> getWordNumBean(String type,String year, Connection conn) throws Exception {
		Map<String, String> map=new HashMap<String, String>();
		String sql="select * from oa_word_number_def where number_type=? and number_year=?  ";
		map=queryToSingleMap(conn, sql, type,year);
		
		return map;
	}

	/**
	 * 
	  * <b>Summary: 删除文号信息</b>
	  *     复写方法 deleteWordNum
	  * @param type
	  * @param year
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.wordnumdef.dao.WordNumDefDao#deleteWordNum(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	public boolean deleteWordNum(String type, String year, Connection conn)
			throws Exception {
		PreparedDBUtil pdb=new PreparedDBUtil();
		String sql="delete oa_word_number_def where number_year='"+year+"' and number_type='"+type+"'";
		
		pdb.preparedDelete(sql);
		pdb.executePrepared(conn);
		
		return true;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 insertSerialNumber
	  * @param bean
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.wordnumdef.dao.WordNumDefDao#insertSerialNumber(com.chinacreator.xtbg.core.wordnumdef.entity.SerialNumberBean)
	 */
	public void insertSerialNumber(SerialNumberBean bean,Connection conn) throws Exception {
		String sql="insert into oa_serial_number(s_id,ins_id,s_code,s_time,s_lsh,s_orgid,s_orgname,s_createtime,s_allcode)"
			+" values (?,?,?,?,?,?,?,to_date(?,'YYYY-MM-DD'),?)";
		PreparedDBUtil pdb=new PreparedDBUtil();
		pdb.preparedInsert(sql);
		int i=1;
		pdb.setString(i++, bean.getS_id());
		pdb.setString(i++, bean.getIns_id());
		pdb.setString(i++, bean.getS_code());
		pdb.setString(i++, bean.getS_time());
		pdb.setString(i++, bean.getS_lsh());
		pdb.setString(i++, bean.getS_orgid());
		pdb.setString(i++, bean.getS_orgname());
		pdb.setString(i++, bean.getS_createtime());
		pdb.setString(i++, bean.getS_allcode());
		pdb.executePrepared(conn);
		
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateSerialNumber
	  * @param bean
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.wordnumdef.dao.WordNumDefDao#updateSerialNumber(com.chinacreator.xtbg.core.wordnumdef.entity.SerialNumberBean)
	 */
	public void updateSerialNumber(SerialNumberBean bean,Connection conn) throws Exception {
		
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findSerialcode
	  * @param scode
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.wordnumdef.dao.WordNumDefDao#findSerialcode(java.lang.String)
	 */
	public SerialNumberBean findSerialcode(String scode,Connection conn) throws Exception {
		SerialNumberBean serialNumberBean = new SerialNumberBean();
		String code="";
		String time=DateUtil.getCurrentYear()+DateUtil.getCurrentMonth()+DateUtil.getCurrentDay();
		String sql="select s_lsh from oa_serial_number where s_code=? and s_time=? order by s_lsh desc";
		PreparedDBUtil pdb=new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, scode);
		pdb.setString(2, time);
		pdb.executePrepared(conn);
		if(pdb.size()>0){
			code=(pdb.getInt(0, "s_lsh")+1)+"";
			code=buwei(code);
		}
		if(StringUtil.isBlank(code)){
			code="001";
		}
		String s_allcode = scode+time+code;
		
		//serialNumberBean.setIns_id(ins_id);
		serialNumberBean.setS_id(StringUtil.getUUID());
		serialNumberBean.setS_code(scode);
		serialNumberBean.setS_time(time);
		serialNumberBean.setS_lsh(code);
		serialNumberBean.setS_createtime(DateUtil.getCurrentDate());
		serialNumberBean.setS_allcode(s_allcode);
		return serialNumberBean;
	}
	/**
	 * 
	*<b>Summary: </b>
	* buwei(补位)
	* @param str
	* @return
	* @throws Exception
	 */
	public String buwei(String str)throws Exception{
		if(str.length()==1){
			str="00"+str;
		}else if(str.length()==2){
			str="0"+str;
		}
		return str;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 isExistNum
	  * @param serialNumberBean
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.wordnumdef.dao.WordNumDefDao#isExistNum(com.chinacreator.xtbg.core.wordnumdef.entity.SerialNumberBean)
	 */
	@Override
	public boolean isExistNum(SerialNumberBean serialNumberBean,Connection conn)
			throws Exception {
		//TODO 此处如何判断。各参数
		boolean flag =true;
		String sql="select count(1) countnum from oa_serial_number where s_allcode=? ";
		PreparedDBUtil pdb=new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, serialNumberBean.getS_allcode());
		pdb.executePrepared(conn);
		if(pdb.size()>0){
			int countnum = pdb.getInt(0, "countnum");
			if(countnum <= 0){
				flag = false;
			}
		}
		return flag;
	}
	
	/**
	*<b>Summary: </b>
	* deleteWordInfoByIds(删除文号)
	* @param bus_ids
	* @param number_codes
	* @param bean
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean deleteWordInfoByIds(String bus_id,String number_code,OaWordNumberBean bean,Connection conn)throws Exception{
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql= new StringBuffer("delete oa_word_number where 1=1");
		if(!StringUtil.isBlank(bus_id)){
			sql.append(" and busi_id = '"+bus_id+"' ");
		} else {
			if(!StringUtil.isBlank(number_code)){
				sql.append(" and number_code = '"+number_code+"' ");
			}
			if(!StringUtil.isBlank(bean.getNumber_type())){
				sql.append(" and number_type = '"+bean.getNumber_type()+"' ");
			}
			if(!StringUtil.isBlank(bean.getNumber_year())){
				sql.append(" and number_year = '"+bean.getNumber_year()+"' ");
			}
		}
		//System.out.println("sql====="+sql.toString());
		pdb.preparedDelete(sql.toString());
		pdb.executePrepared(conn);
		
		return true;
	}

}
