package com.chinacreator.xtbg.core.subsystemmanage.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.subsystemmanage.dao.SubSystemOrgConfigDao;
import com.chinacreator.xtbg.core.subsystemmanage.entity.OaGwcsConfigBean;

public class GwcsOrgConfigDaoImpl extends XtDbBaseDao implements SubSystemOrgConfigDao {
	private static final Logger log = Logger
	.getLogger(GwcsOrgConfigDaoImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findSubSystemOrgConfigList
	  * @param SearchConditionMap
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return 
	  * @see com.chinacreator.xtbg.core.subsystemmanage.dao.SubSystemOrgConfigDao#findSubSystemOrgConfigList(java.util.Map, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findSubSystemOrgConfigList(
			Map<String, String> SearchConditionMap, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		StringBuffer sql = new StringBuffer();
		Connection conn = null;
		List<String> values = new ArrayList<String>();
		
		sql.append("select o.org_id    gwcs_org_id,");
		sql.append("       o.org_name  gwcs_orgname,");
		sql.append("       o1.org_name oa_orgname,");
		sql.append("       o1.org_id   oa_org_id");
		sql.append("  from OA_GWCS_ORG_MAPPING m");
		sql.append(" right join OA_GWCS_ORG o");
		sql.append("    on o.org_id = m.gwcs_org_id");
		sql.append(" left join td_sm_organization o1");
		sql.append("    on o1.org_id = m.oa_org_id where 1=1 ");
		if(!StringUtil.nullOrBlank(SearchConditionMap.get("gwcs_orgname"))){
			sql.append("and o.org_name like ?");
			values.add("%"+SearchConditionMap.get("gwcs_orgname")+"%");
		}
		
		PagingBean pagingBean = new PagingBean();
		try{
			conn = DbManager.getInstance().getConnection();
			pagingBean = queryToPagingBean(sql.toString(), offset, maxPagesize,conn,values);
		}catch(Exception e){
			log.error(e.getMessage(), e);
		} finally {
			DbManager.closeConnection(conn);
		}
		
		return pagingBean;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findSubSystemOrgMappingInfo
	  * @param subsysorgid
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.subsystemmanage.dao.SubSystemOrgConfigDao#findSubSystemOrgMappingInfo(java.lang.String)
	 */
	public Map<String, String> findSubSystemOrgMappingInfo(String subsysorgid)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select o.org_id    gwcs_org_id,");
		sql.append("       o.org_name  gwcs_orgname,");
		sql.append("       o.org_addr  gwcs_orgaddr,");
		sql.append("       o1.org_name oa_orgname,");
		sql.append("       o1.org_id   oa_org_id");
		sql.append("  from OA_GWCS_ORG_MAPPING m");
		sql.append(" right join OA_GWCS_ORG o");
		sql.append("    on o.org_id = m.gwcs_org_id");
		sql.append(" left join td_sm_organization o1");
		sql.append("    on o1.org_id = m.oa_org_id where o.org_id = ? ");
		return queryToSingleMap(sql.toString(), subsysorgid);
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 findSubSystemOrgMappingInfoByOAid
	  * @param orgid
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.subsystemmanage.dao.SubSystemOrgConfigDao#findSubSystemOrgMappingInfoByOAid(java.lang.String) 
	  */
	@Override
	public Map<String, String> findSubSystemOrgMappingInfoByOAid(String orgid)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select o.org_id    gwcs_org_id,");
		sql.append("       o.org_name  gwcs_orgname,");
		sql.append("       o.org_addr  gwcs_orgaddr,");
		sql.append("       o1.org_name oa_orgname,");
		sql.append("       o1.org_id   oa_org_id");
		sql.append("  from OA_GWCS_ORG_MAPPING m");
		sql.append(" right join OA_GWCS_ORG o");
		sql.append("    on o.org_id = m.gwcs_org_id");
		sql.append(" left join td_sm_organization o1");
		sql.append("    on o1.org_id = m.oa_org_id where o1.org_id = ? ");
		return queryToSingleMap(sql.toString(), orgid);
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getGwcsConfigByID
	  * @param id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.subsystemmanage.dao.SubSystemOrgConfigDao#getGwcsConfigByID(java.lang.String)
	 */
	@Override
	public OaGwcsConfigBean getGwcsConfigByID(String id) throws Exception {
		
		OaGwcsConfigBean oaGwcsConfigBean = new OaGwcsConfigBean();
		oaGwcsConfigBean.setId(id);
		return (OaGwcsConfigBean)queryToBean(oaGwcsConfigBean);		
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findOaGwcsOrgConfigList
	  * @param SearchConditionMap
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return 
	  * @see com.chinacreator.xtbg.core.subsystemmanage.dao.SubSystemOrgConfigDao#findOaGwcsOrgConfigList(java.util.Map, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean findOaGwcsOrgConfigList(Map<String, String> SearchConditionMap, String sortName, String sortOrder, long offset, int maxPagesize) {
				StringBuffer sql = new StringBuffer();
				Connection conn = null;
				List<String> values = new ArrayList<String>();
				
				sql.append("select id,config_name,org_id,org_name,gwcs_org_id,gwcs_org_name,wordtogwcswsdl,archivesendwsdl,archiveserversendwsdl,unionarchivesendwsdl,gwcsjspaddress,gwcs_org_addr,gwcs_address_path");
				sql.append(" from oa_gwcs_org_config where 1=1 ");

				if(!StringUtil.nullOrBlank(SearchConditionMap.get("config_name"))){
					sql.append("and config_name like ?");
					values.add("%"+SearchConditionMap.get("config_name")+"%");
				}
				
				PagingBean pagingBean = new PagingBean();
				try{
					conn = DbManager.getInstance().getConnection();
					pagingBean = queryToPagingBean(sql.toString(), offset, maxPagesize,conn,values);
				}catch(Exception e){
					log.error(e.getMessage(), e);
				} finally {
					DbManager.closeConnection(conn);
				}
				
				return pagingBean;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findOaGwcsOrgMappingInfo
	  * @param config_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.subsystemmanage.dao.SubSystemOrgConfigDao#findOaGwcsOrgMappingInfo(java.lang.String)
	 */
	@Override
	public Map<String, String> findOaGwcsOrgMappingInfo(String config_id)throws Exception {
			StringBuffer sql = new StringBuffer();
			sql.append("select id,config_name,org_id,org_name,gwcs_org_id,gwcs_org_name,wordtogwcswsdl,archivesendwsdl,archiveserversendwsdl,unionarchivesendwsdl,gwcsjspaddress,gwcs_org_addr,gwcs_address_path");
			sql.append(" from oa_gwcs_org_config where id = ?");
			return queryToSingleMap(sql.toString(), config_id);
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findGwcsOrgList
	  * @param map
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return 
	  * @see com.chinacreator.xtbg.core.subsystemmanage.dao.SubSystemOrgConfigDao#findGwcsOrgList(java.util.Map, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean findGwcsOrgList(Map<String, String> map, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		StringBuffer sql = new StringBuffer();
		Connection conn = null;
		List<String> values = new ArrayList<String>();
		
		sql.append("select org_id ,org_name, org_addr, parent_id, isouter");
		sql.append("  from oa_gwcs_org where 1=1");
		if(!StringUtil.nullOrBlank(map.get("org_name"))){
			sql.append("and org_name like ?");
			values.add("%"+map.get("org_name")+"%");
		}
		PagingBean pagingBean = new PagingBean();
		try{
			conn = DbManager.getInstance().getConnection();
			pagingBean = queryToPagingBean(sql.toString(), offset, maxPagesize,conn,values);
		}catch(Exception e){
			log.error(e.getMessage(), e);
		} finally {
			DbManager.closeConnection(conn);
		}
		
		return pagingBean;
	}

}
