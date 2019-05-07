package com.chinacreator.xtbg.core.agency.dao.imploracle;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.agency.dao.AgencyDao;
import com.chinacreator.xtbg.core.agency.entity.AgencyBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;
public class AgencyDaoImploracle implements AgencyDao {

	private static final Logger LOG = Logger.getLogger(AgencyDaoImploracle.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findAgencyAll
	  * @param agencyBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return 
	  * @see com.chinacreator.xtbg.core.agency.dao.imploracle.AgencyDao#findAgencyAll(com.chinacreator.xtbg.core.agency.entity.AgencyBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findAgencyAll(AgencyBean agencyBean, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<AgencyBean> list = new ArrayList<AgencyBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select work_id,work_type,work_name,");
		sql.append("to_char(start_time,'yyyy-mm-dd') start_time , to_char(end_time,'yyyy-mm-dd')end_time, ");
		sql.append("agency_username,agency_id,entrust_name,entrust_id ");
		sql.append(" from OA_FLOW_AGENCY v where 1=1 ");
		if("find".equals(agencyBean.getFlow_id())){
			sql.append("  and  v.AGENCY_NAME = '"+agencyBean.getUsername()+"'");
		}else{
			sql.append("  and  v.entrust_id = '"+agencyBean.getUsername()+"'");
		}
		//sql.append(" from oa_flow_agency v ");
		if(!StringUtil.nullOrBlank(agencyBean.getWork_name())){
			sql.append(" and v.work_name like '%").append(agencyBean.getWork_name()).append("%'");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
		try {
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.executePrepared();
			for(int i = 0;i < db.size();i++){
				AgencyBean ayBean = new AgencyBean();
				ayBean.setWork_id(db.getString(i,"work_id"));
				ayBean.setWork_type(db.getString(i,"work_type"));
				ayBean.setWork_name(db.getString(i,"work_name"));
				ayBean.setStart_time(db.getString(i,"start_time"));
				ayBean.setEnd_time(db.getString(i,"end_time"));
				ayBean.setAgency_username(db.getString(i,"agency_username"));
				//ayBean.setAgency_id(db.getString(i,"agency_id"));
				ayBean.setEntrust_name(db.getString(i,"entrust_name"));
				ayBean.setEntrust_id(db.getString(i,"entrust_id"));
				
				list.add(ayBean);
			}
		} catch (Exception e) {
			LOG.error("执行代理列表查询失败："+e.getMessage());
		}
		pb.setList(list);
		pb.setRecords((long)db.getTotalSize());
		return pb;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 delAgencyById
	  * @param id
	  * @return 
	  * @see com.chinacreator.xtbg.core.agency.dao.AgencyDao#delAgencyById(java.lang.String)
	 */
	public String delAgencyById(String id)  {
		StringBuffer sb = new StringBuffer();
		String[] ids = id.split(",");
		for(int i =0;i<ids.length;i++){
			sb.append("'").append(ids[i]).append("'").append(",");
		}
		String str =sb.subSequence(0, sb.length()-1).toString();
		String flag = "flag";
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil pdb = new PreparedDBUtil();
		sql.append(" delete OA_FLOW_AGENCY ");
		sql.append(" where work_id in ("+str+")");
		try {
			pdb.preparedUpdate(sql.toString());
			pdb.executePrepared();
		} catch (Exception e) {
			flag ="flag3";
			e.printStackTrace();
		}
		return flag;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 setAgencyByName
	  * @param agencyBean
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.agency.dao.AgencyDao#setAgencyByName(com.chinacreator.xtbg.core.agency.entity.AgencyBean)
	 */
	public String setAgencyByName(AgencyBean agencyBean) throws Exception{
		String flag = "flag";
		boolean flag1 = false;
		//查询在当前时间段是否可以设置代理
		flag1  = findAgencyByName( agencyBean);
		String busitypecode = findBusiTypeCode(agencyBean.getWork_name());
		if(!flag1){
			flag = "flag1";
			return flag ;
		}
		//查询当前用书是否为代理人
		int number1 =findAgencyByAgencyName(agencyBean);
		if(number1>0){
			flag = "flag2";
			return flag;
		}
		//查询将要设置为代理人的用户在当前时间段是否还是委托人
		flag = findAgencyIsEntrust(agencyBean);
		if(!"".equals(flag) &&  null != flag){
			return flag;
		}else{
			flag = "flag";
		}
		String work_id="";
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil pdb = new PreparedDBUtil();
		sql.append(" insert  into  OA_FLOW_AGENCY (work_id, work_type,work_name,start_time ,end_time,");
		sql.append("agency_name,agency_id,entrust_name,entrust_id,agency_username,flow_id)");
		sql.append("values(");
		sql.append("?,?,?,to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),?,?,?,?,?,?)");
		try {
			work_id =StringUtil.getUUID();
			pdb.preparedInsert(sql.toString());
			pdb.setString(1, work_id);
			pdb.setString(2, busitypecode);
			pdb.setString(3, agencyBean.getWork_name());
			pdb.setString(4, agencyBean.getStart_time());
			pdb.setString(5, agencyBean.getEnd_time());
			pdb.setString(6, agencyBean.getAgency_username());
			pdb.setString(7, agencyBean.getAgency_id());
			pdb.setString(8, agencyBean.getEntrust_name());
			pdb.setString(9, agencyBean.getEntrust_id());
			pdb.setString(10, agencyBean.getAgency_name());
			pdb.setString(11, agencyBean.getFlow_id());
			
			pdb.executePrepared();
		} catch (Exception e) {
			flag = "flag3";
			e.printStackTrace();
		} 
		return flag;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findAgencyBeanById
	  * @param id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.agency.dao.AgencyDao#findAgencyBeanById(java.lang.String)
	 */
	public AgencyBean findAgencyBeanById(String id) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" select work_type,work_name,to_char(start_time,'yyyy-mm-dd') start_time, ");
		sql.append(" to_char(end_time,'yyyy-mm-dd')end_time,agency_username,agency_id , ");
		sql.append(" entrust_name,entrust_id from OA_FLOW_AGENCY ");
		sql.append(" where work_id =?");
		PreparedDBUtil db = new PreparedDBUtil();
		AgencyBean agencyBean = new AgencyBean();
		db.preparedSelect(sql.toString()); 
		db.setString(1, id);
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {  
			agencyBean.setWork_type(db.getString(i,"work_type"));
			agencyBean.setWork_name(db.getString(i,"work_name"));
			agencyBean.setStart_time(db.getString(i,"start_time"));
			agencyBean.setEnd_time(db.getString(i,"end_time"));
			agencyBean.setAgency_name(db.getString(i,"agency_username"));
			agencyBean.setAgency_id(db.getString(i,"agency_id"));
			agencyBean.setEntrust_name(db.getString(i,"entrust_name"));
			agencyBean.setEntrust_id(db.getString(i,"entrust_id"));
		}
		return agencyBean;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateAgencyBeanById
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.core.agency.dao.AgencyDao#updateAgencyBeanById(com.chinacreator.xtbg.core.agency.entity.AgencyBean)
	 */
	public String updateAgencyBeanById(AgencyBean bean) throws Exception  {
		String flag = "flag";
		/*boolean flag1 = false;
		//查询在当前时间段是否可以设置代理
		flag1  = findAgencyByName( bean);
		String busitypecode = findBusiTypeCode(bean.getWork_name());
		if(!flag1){
			flag = "flag1";
			return flag ;
		}
		//查询当前用书是否为代理人
		int number1 =findAgencyByAgencyName(bean);
		if(number1>0){
			flag = "flag2";
			return flag;
		}
		//查询将要设置为代理人的用户在当前时间段是否还是委托人
		flag = findAgencyIsEntrust(bean);
		if(!"".equals(flag) &&  null != flag){
			return flag;
		}else{
			flag = "flag";
		}*/
		String busitypecode = findBusiTypeCode(bean.getWork_name());
		StringBuffer sql = new StringBuffer();
		sql.append("update OA_FLOW_AGENCY set work_type=?, work_name=?,start_time=to_date(?,'yyyy-mm-dd') , ");
		sql.append("end_time=to_date(?,'yyyy-mm-dd'),agency_name=?,agency_id=?,agency_username=?");
		sql.append("where work_id =?");
	
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			pdb.preparedInsert(sql.toString());
			int i = 1;
			 pdb.setString(i++, busitypecode);
			 pdb.setString(i++, bean.getWork_name());
			 pdb.setString(i++, bean.getStart_time());
			 pdb.setString(i++, bean.getEnd_time());
			 pdb.setString(i++, bean.getAgency_username());
			 pdb.setString(i++, bean.getAgency_id());
			 pdb.setString(i++, bean.getAgency_name());
			 pdb.setString(i++, bean.getWork_id());
			
			 pdb.executePrepared();
		} catch (Exception e) {
			flag="flag3";
			e.printStackTrace();
		}
		 
		return flag;
	}
	/**
	 * 查看当前设置的人是否已经设置了代理,如果是某种类型已经设置了代理则不能再设置
	 * 
	 * @param entrust_name
	 * @return
	 */
	public boolean findAgencyByName(AgencyBean bean)throws Exception{
		boolean  flag = true;
		StringBuffer sql = new StringBuffer();
		sql.append("select  a.start_time,a.end_time  from OA_FLOW_AGENCY a ");
		sql.append("where a.entrust_name =? and a.work_name =? ");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString()); 
		db.setString(1, bean.getEntrust_name());
		db.setString(2, bean.getWork_name());
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {  
			 if(((DateUtil.compareDate2(bean.getStart_time(),db.getString(i,"start_time"))||DateUtil.compareDate(bean.getStart_time(),db.getString(i,"end_time"))) && 
				(DateUtil.compareDate2(bean.getEnd_time(),db.getString(i,"start_time"))||DateUtil.compareDate(bean.getEnd_time(),db.getString(i,"end_time"))) 
				&&(DateUtil.compareDate2(bean.getEnd_time(),db.getString(i,"start_time")) || DateUtil.compareDate(bean.getEnd_time(),db.getString(i,"end_time")))
				)){
				 	flag = true;
			 }else{
				 flag = false;
			 }
		}
		return flag;
	}
	/**
	 * 查询自己是否已经为代理人
	 * @param bean
	 * @return
	 * @throws SQLException
	 */
	public int findAgencyByAgencyName(AgencyBean bean) throws Exception{
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil db = new PreparedDBUtil();
		sql.append("　select count(*) id　");
		sql.append("  from OA_FLOW_AGENCY af　");
		sql.append(" where af.work_name = ?　");
		sql.append("   and  ?　");
		sql.append(" in ");
		sql.append("       (select c　");
		sql.append("          from (with test as (select to_char(wm_concat(a.agency_name)) c　");
		sql.append("                               from OA_FLOW_AGENCY a　");
		sql.append("                              where a.work_name = ?)　");
		sql.append("                select substr(t.ca,　");
		sql.append("                              instr(t.ca, ',', 1, c.lv) + 1,　");
		sql.append("                              instr(t.ca, ',', 1, c.lv + 1) -　");
		sql.append("                              (instr(t.ca, ',', 1, c.lv) + 1)) AS c　");
		sql.append("                 from (select ',' || c || ',' AS ca,　");
		sql.append("                              length(c || ',') -　");
		sql.append("                              nvl(length(REPLACE(c, ',')), 0) AS cnt　");
		sql.append("                         FROM test) t,　");
		sql.append("                      (select LEVEL lv from dual CONNECT BY LEVEL <= 100) c　");
		sql.append("                where c.lv <= t.cnt)　");
		sql.append("      )　");
		db.preparedSelect(sql.toString()); 
		db.setString(1, bean.getWork_name());
		db.setString(2, bean.getEntrust_id());
		db.setString(3, bean.getWork_name());
		db.executePrepared();
		int number  = db.getInt(0,"id");
		return number;
	}
	/**
	 * 查询将要设置为代理的人是否已经是委托人
	 * @param bean
	 * @return
	 * @throws SQLException
	 */
	private String findAgencyIsEntrust(AgencyBean bean) throws Exception{
		//代理人
		String agencyName = bean.getAgency_username();
		String[] agencyNameArray = null;
		agencyNameArray = agencyName.split(",");
		StringBuffer userName = new StringBuffer();
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil db = new PreparedDBUtil();
		sql.append("select  a.start_time,a.end_time ,a.entrust_name,a.entrust_id from oa_flow_agency a ");
		sql.append("where  a.work_name =? ");
		db.preparedSelect(sql.toString()); 
		//db.setString(1, bean.getEntrust_name());
		db.setString(1, bean.getWork_name());
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) { 
			String entrust_id = db.getString(i,"entrust_id");
			String entrust_name = db.getString(i,"entrust_name");
			for(int j = 0; j < agencyNameArray.length ; j++ ){
				if(entrust_id.equals(agencyNameArray[j])){
					if(((DateUtil.compareDate2(bean.getStart_time(),db.getString(i,"start_time"))||DateUtil.compareDate(bean.getStart_time(),db.getString(i,"end_time"))) && 
						(DateUtil.compareDate2(bean.getEnd_time(),db.getString(i,"start_time"))||DateUtil.compareDate(bean.getEnd_time(),db.getString(i,"end_time"))) 
						&&(DateUtil.compareDate2(bean.getEnd_time(),db.getString(i,"start_time")) || DateUtil.compareDate(bean.getEnd_time(),db.getString(i,"end_time"))))){
							
						}
						else{
								userName.append(entrust_name).append(",");
							}
						}
				}	
			
		}
		if("".equals(userName.toString()) || null == userName.toString()){
			return userName.toString();
		}else{
			return userName.toString().substring(0,userName.toString().length()-1);
		}
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findAgencyBeanList
	  * @param agencyBean
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.agency.dao.AgencyDao#findAgencyBeanList(com.chinacreator.xtbg.core.agency.entity.AgencyBean)
	 */
	@Override
	public List<AgencyBean> findAgencyBeanList(AgencyBean queryAgencyBean)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		List<AgencyBean> agencyBeanList = new ArrayList<AgencyBean>();
		sql.append(" select work_type,work_name,to_char(start_time,'yyyy-mm-dd') start_time, ");
		sql.append(" to_char(end_time,'yyyy-mm-dd')end_time,agency_username,agency_id , ");
		sql.append(" entrust_name,entrust_id from OA_FLOW_AGENCY ");
		sql.append(" where instr(agency_name,?)>0 and sysdate between start_time and end_time");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString()); 
		if(queryAgencyBean!=null){
			db.setString(1, queryAgencyBean.getAgency_id());
		}
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {  
			AgencyBean agencyBean = new AgencyBean();
			agencyBean.setWork_type(db.getString(i,"work_type"));
			agencyBean.setWork_name(db.getString(i,"work_name"));
			agencyBean.setStart_time(db.getString(i,"start_time"));
			agencyBean.setEnd_time(db.getString(i,"end_time"));
			agencyBean.setAgency_name(db.getString(i,"agency_username"));
			agencyBean.setAgency_id(db.getString(i,"agency_id"));
			agencyBean.setEntrust_name(db.getString(i,"entrust_name"));
			agencyBean.setEntrust_id(db.getString(i,"entrust_id"));
			agencyBeanList.add(agencyBean);
		}
		return agencyBeanList;
	}

	private String findBusiTypeCode(String busiTypeName){
		String str = "";
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil db = new PreparedDBUtil();
		sql.append(" select s.busitype_type_code busitype    from oa_flow_busitype_type s where s.busitype_type_name ")
		.append(" ='") 
		.append(busiTypeName)
		.append("' ");
		try {
			db.preparedSelect(sql.toString());
			db.executePrepared();
			str = db.getString(0, "busitype");
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		
		return str.trim();
	}

}
