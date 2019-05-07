package com.chinacreator.xtbg.core.kbm.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.kbm.dao.KbmDocTypeconfigDao;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocTypeRightConfig;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:KbmDocTypeConfigDaoImpl.java</p>
 *<p>Description:知识库分类权限设置接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-8
 */
public class KbmDocTypeConfigDaoImpl extends XtDbBaseDao implements
		KbmDocTypeconfigDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getMaxDocTypeConfigNum
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocTypeconfigDao#getMaxDocTypeConfigNum(java.sql.Connection)
	 */
	public int getMaxDocTypeConfigNum(Connection conn)throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT COUNT(1) COUNTT");
		sql.append("  FROM OA_DICT_DATA ODD");
		sql.append(" WHERE ODD.DICT_ID = '"+KbmDocTypeRightConfig.DICT_ID+"'");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared(conn);
		return Integer.parseInt(pdb.getString(0, "COUNTT"));
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getDocTypeConfigBeanById
	  * @param conn
	  * @param beanId
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocTypeconfigDao#getDocTypeConfigBeanById(java.sql.Connection, java.lang.String)
	 */
	public Map<String, String> getDocTypeConfigBeanById(Connection conn,
			String beanId) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM OA_KBM_DOC_TYPE_RIGHT_CONFIG OFP");
		sql.append(" WHERE OFP.K_ID = ?");
		return queryToSingleMap(conn, sql.toString(), beanId);
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getKbmDocTypeConfigList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocTypeconfigDao#getKbmDocTypeConfigList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean getKbmDocTypeConfigList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		try {
			if (!StringUtil.isBlank(parmjson)) {
				KbmDocTypeRightConfig bean = (KbmDocTypeRightConfig) JSONObject.parseObject(parmjson,KbmDocTypeRightConfig.class);
				List<String> argList = new ArrayList<String>();
				StringBuffer sql = new StringBuffer();
				sql.append("SELECT OFP.k_ID,");
				sql.append("       OFP.k_SECRECY_ID,");
				sql.append("       OFP.k_SECRECY_NAME,");
				sql.append("       CASE");
				sql.append("          WHEN OFP.k_role_range = '1' THEN");
				sql.append("          '所有人'");
				sql.append("          WHEN OFP.k_role_range = '0' AND ");
				sql.append("               OFP.k_role_names IS NOT NULL THEN");
				sql.append("          '本部门和用户组[' || to_char(OFP.k_role_names) || ']'");
				sql.append("         WHEN OFP.k_role_names IS NOT NULL THEN");
				sql.append("          '用户组[' || to_char(OFP.k_role_names) || ']'");
				sql.append("         WHEN OFP.k_role_range = '0' THEN");
				sql.append("          '本部门'");
				sql.append("         ELSE '[未配置角色]'");
				sql.append("        END DOWNLOAD_ROLE,");
				sql.append("       (SELECT ODD.DICTDATA_ORDER");
				sql.append("          FROM OA_DICT_DATA ODD");
				sql.append("         WHERE ODD.DICT_ID = '"+KbmDocTypeRightConfig.DICT_ID+"'");
				sql.append("           AND ODD.DICTDATA_ID = OFP.K_SECRECY_ID) ORDER_NUM");
				sql.append("  FROM OA_KBM_DOC_TYPE_RIGHT_CONFIG OFP");
				sql.append(" WHERE OFP.K_TYPE_ID = ?");
				sql.append(" ORDER BY ORDER_NUM");
				argList.add(bean.getK_type_id());
				PagingBean pb = new PagingBean();
				conn = DbManager.getInstance().getConnection();
				pb = queryToPagingBean(sql.toString(),offset,maxPagesize, conn,argList);
				return pb;
			}
			return null;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryListKbmDocTypeConfig
	  * @param beanid
	  * @param con
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocTypeconfigDao#queryListKbmDocTypeConfig(java.lang.String, java.sql.Connection)
	 */
	@SuppressWarnings("unchecked")
	public List<KbmDocTypeRightConfig> queryListKbmDocTypeConfig(String beanid,
			Connection con) throws Exception {
		String sql="select * from OA_KBM_DOC_TYPE_RIGHT_CONFIG where k_type_id=? ";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, beanid);
		
		return pdb.executePreparedForList(con, KbmDocTypeRightConfig.class);
	}
	

}
