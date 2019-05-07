package com.chinacreator.xtbg.core.file.dao.imploracle;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.file.dao.FilePurviewDao;
import com.chinacreator.xtbg.core.file.entity.FilePurviewBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:FilePurviewDaoImpl.java</p>
 *<p>Description:档案分类密级数据访问实现类[ORACLE]</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Jul 18, 2013
 */
public class FilePurviewDaoImpl extends XtDbBaseDao implements FilePurviewDao {
	/**
	 * 
	 *<b>Summary: </b>
	 * getFileTypeList(查询档案分类)
	 * @param parmjson
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	@Override
	public PagingBean getFilePurviewList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		try {
			if (!StringUtil.isBlank(parmjson)) {
				FilePurviewBean bean = (FilePurviewBean) JSONObject.parseObject(parmjson,FilePurviewBean.class);
				List<String> argList = new ArrayList<String>();
				StringBuffer sql = new StringBuffer();
				String canDo = FilePurviewBean.CAN_DO;
				sql.append("SELECT OFP.F_PURVIEW_ID,");
				sql.append("       OFP.F_SECRECY_ID,");
				sql.append("       OFP.F_SECRECY_NAME,");
				sql.append("       CASE");
				sql.append("         WHEN OFP.F_READ_ALL_USER = '"+canDo+"' THEN");
				sql.append("          '所有人'");
				sql.append("         WHEN OFP.F_READ_DEPT_USER = '"+canDo+"' AND");
				sql.append("              OFP.F_READ_USER_GROUPNAME IS NOT NULL THEN");
				sql.append("          '本部门和用户组[' || OFP.F_READ_USER_GROUPNAME || ']'");
				sql.append("         WHEN OFP.F_READ_USER_GROUPNAME IS NOT NULL THEN");
				sql.append("          '用户组[' || OFP.F_READ_USER_GROUPNAME || ']'");
				sql.append("         WHEN OFP.F_READ_DEPT_USER = '"+canDo+"' THEN");
				sql.append("          '本部门'");
				sql.append("         ELSE '[未配置角色]'");
				sql.append("       END READ_ROLE,");
				sql.append("       CASE");
				sql.append("         WHEN OFP.F_DOWNLOAD_ALL_USER = '"+canDo+"' THEN");
				sql.append("          '所有人'");
				sql.append("         WHEN OFP.F_DOWNLOAD_DEPT_USER = '"+canDo+"' AND");
				sql.append("              OFP.F_DOWNLOAD_USER_GROUPNAME IS NOT NULL THEN");
				sql.append("          '本部门和用户组[' || OFP.F_DOWNLOAD_USER_GROUPNAME || ']'");
				sql.append("         WHEN OFP.F_DOWNLOAD_USER_GROUPNAME IS NOT NULL THEN");
				sql.append("          '用户组[' || OFP.F_DOWNLOAD_USER_GROUPNAME || ']'");
				sql.append("         WHEN OFP.F_DOWNLOAD_DEPT_USER = '"+canDo+"' THEN");
				sql.append("          '本部门'");
				sql.append("         ELSE '[未配置角色]'");
				sql.append("       END DOWNLOAD_ROLE,");
				sql.append("       (SELECT ODD.DICTDATA_ORDER");
				sql.append("          FROM OA_DICT_DATA ODD");
				sql.append("         WHERE ODD.DICT_ID = '"+FilePurviewBean.DICT_ID+"'");
				sql.append("           AND ODD.DICTDATA_ID = OFP.F_SECRECY_ID) ORDER_NUM");
				sql.append("  FROM OA_FILE_PURVIEW OFP");
				sql.append(" WHERE OFP.F_TYPE_ID = ?");
				sql.append(" ORDER BY ORDER_NUM");
				argList.add(bean.getF_type_id());
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
	 *<b>Summary: </b>
	 * deleteFilePurviewBeansById(通过beanId删除以beanId节点为根节点的树结构数据上的所有FilePurviewBean[包含beanId])
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception
	 */
	@Override
	public boolean deleteFilePurviewBeansById(Connection conn, String beanId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("DELETE FROM OA_FILE_PURVIEW");
		sql.append(" WHERE F_PURVIEW_ID = ?");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * getFilePurviewBeanById(通过beanId获得Map形式的行数据集合)
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception
	 */
	@Override
	public Map<String, String> getFilePurviewBeanById(Connection conn,
			String beanId) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM OA_FILE_PURVIEW OFP");
		sql.append(" WHERE OFP.F_PURVIEW_ID = ?");
		return queryToSingleMap(conn, sql.toString(), beanId);
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * getMaxFilePurviewNum(获得密级种类数量)
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	@Override
	public int getMaxFilePurviewNum(Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT COUNT(1) COUNTT");
		sql.append("  FROM OA_DICT_DATA ODD");
		sql.append(" WHERE ODD.DICT_ID = '"+FilePurviewBean.DICT_ID+"'");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared(conn);
		return Integer.parseInt(pdb.getString(0, "COUNTT"));
	}
	
}
