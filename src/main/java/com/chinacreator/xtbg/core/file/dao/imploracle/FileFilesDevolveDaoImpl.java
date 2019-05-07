package com.chinacreator.xtbg.core.file.dao.imploracle;

import java.io.File;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.file.dao.FileFilesDevolveDao;
import com.chinacreator.xtbg.core.file.entity.FileDocBean;
import com.chinacreator.xtbg.core.file.entity.FileFilesDevolveBean;
import com.chinacreator.xtbg.core.file.entity.FileFilesDevolveDetailBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:FileTypeDaoImpl.java</p>
 *<p>Description:档案分类数据访问实现类[ORACLE]</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Jul 16, 2013
 */
public class FileFilesDevolveDaoImpl extends XtDbBaseDao implements FileFilesDevolveDao {
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 queryFileFilesDevolveDetailList
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileFilesDevolveDao#queryFileFilesDevolveDetailList(com.chinacreator.xtbg.core.file.entity.FileFilesDevolveDetailBean, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean queryFileFilesDevolveDetailList(
			FileFilesDevolveDetailBean bean, String sortName, String sortOrder,
			long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT OFDD.F_DEVOLVE_DETAIL_ID,");
			sql.append("       OFDD.F_DEVOLVE_ID,");
			sql.append("       OFDD.F_FILES_ID,");
			//sql.append("       OFDD.F_START_TIME,");
			//sql.append("       OFDD.F_END_TIME,");
			//sql.append("       OFDD.F_PAGE_NUM,");
			sql.append("       OFDD.F_STATE,");
			sql.append("       OFFF.F_FONDSNO,");
			sql.append("       OFFF.F_LISTNO,");
			sql.append("       OFFF.F_FILESNO,");
			sql.append("       OFFF.F_TYPE_NAME,");
			sql.append("       OFFF.F_FILES_TITLE,");
			sql.append("       OFFF.F_FILES_NO,");
			sql.append("       TO_CHAR((select min(offf1.F_START_TIME) from OA_FILE_FILES offf1 where offf1.f_files_id in (select F_FILES_ID from OA_FILES_DEVOLVE_DETAIL OFDD1 where OFDD1.F_DEVOLVE_ID = OFDD.F_DEVOLVE_ID)),'yyyy-MM-dd') min_time,");
			sql.append("       TO_CHAR((select max(offf1.F_end_TIME) from OA_FILE_FILES offf1 where offf1.f_files_id in (select F_FILES_ID from OA_FILES_DEVOLVE_DETAIL OFDD1 where OFDD1.F_DEVOLVE_ID = OFDD.F_DEVOLVE_ID)),'yyyy-MM-dd') max_time,");
			sql.append("       (CASE WHEN OFFF.F_START_TIME IS NOT NULL AND OFFF.F_END_TIME IS NOT NULL ");
			sql.append("             THEN TO_CHAR(OFFF.F_START_TIME,'yyyy-MM-dd')||' 至 '||TO_CHAR(OFFF.F_END_TIME,'yyyy-MM-dd')");
			sql.append("             WHEN OFFF.F_START_TIME IS NOT NULL AND OFFF.F_END_TIME IS NULL");
			sql.append("             THEN TO_CHAR(OFFF.F_START_TIME,'yyyy-MM-dd')||' 至 ~'");
			sql.append("             WHEN OFFF.F_END_TIME IS NOT NULL AND OFFF.F_START_TIME IS NULL");
			sql.append("             THEN '~ 至  '||TO_CHAR(OFFF.F_END_TIME,'YYYY-MM-DD')");
			sql.append("             ELSE '无' END");
			sql.append("       ) F_START_END_TIME,");
			sql.append("       OFFF.F_START_TIME,");
			sql.append("       OFFF.F_END_TIME,");
			sql.append("       OFFF.F_DOC_DEADLINE_NAME,");
			sql.append("       (SELECT NVL(SUM(CASE WHEN OFD1.F_ENTITY_TYPE = 1 THEN NVL(TO_NUMBER(OFD1.F_FILE_QUANTITY), 0)");
			sql.append("                     ELSE 0 END),0)");
			sql.append("          FROM OA_FILE_DOC OFD1, OA_FILE_DOCFILES OFD2");
			sql.append("         WHERE OFD1.F_DOC_ID = OFD2.F_DOC_ID");
			sql.append("           AND OFD2.F_FILES_ID = OFFF.F_FILES_ID) F_PAGE_NUM");
			sql.append("  FROM OA_FILES_DEVOLVE_DETAIL OFDD");
			sql.append("  INNER JOIN OA_FILE_FILES OFFF");
			sql.append("    ON OFDD.F_FILES_ID = OFFF.F_FILES_ID");
			sql.append(" WHERE 1 = 1");
			if(!StringUtil.nullOrBlank(bean.getF_devolve_id())){
				sql.append(" AND OFDD.F_DEVOLVE_ID = '"+bean.getF_devolve_id()+"'");
			}
			if(!StringUtil.nullOrBlank(sortName)
					&&!StringUtil.nullOrBlank(sortOrder)){
				sql.append(" ORDER BY " + sortName + " " + sortOrder+",F_FILES_ID ");
			}else{
				sql.append("  ORDER BY F_FILES_ID ");
			}
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 queryFileFilesDevolveList
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileFilesDevolveDao#queryFileFilesDevolveList(com.chinacreator.xtbg.core.file.entity.FileFilesDevolveBean, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean queryFileFilesDevolveList(FileFilesDevolveBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT F_DEVOLVE_ID,");
			sql.append("       F_TITLE,");
			sql.append("       F_STATE,");
			sql.append("       F_DEADLINE,");
			sql.append("       F_TYPE,");
			sql.append("       F_RECEIVE_ORG_ID,");
			sql.append("       F_RECEIVE_ORG_NAME,");
			sql.append("       TO_CHAR(F_BEGIN_TIME,'yyyy-MM-dd') F_BEGIN_TIME,");
			sql.append("       TO_CHAR(F_DEN_TIME,'yyyy-MM-dd') F_DEN_TIME,");
			sql.append("       F_NUM,");
			sql.append("       F_LOG_USER_ID,");
			sql.append("       F_LOG_USER_NAME,");
			sql.append("       TO_CHAR(F_LOG_TIME,'yyyy-MM-dd') F_LOG_TIME,");
			sql.append("       F_ORG_ID,");
			sql.append("       F_ORG_NAME,");
			sql.append("       F_DEPT_ID,");
			sql.append("       F_DEPT_NAME,");
			sql.append("       F_REMARKS,");
			sql.append("       F_ATTACH_ID,");
			sql.append("       F_YEAR,");
			sql.append("       F_FONDS_NO,");
			sql.append("       F_CATALOG_NO,");
			sql.append("       F_FILES_NO,");
			
			sql.append("       (CASE WHEN OFFF.F_BEGIN_TIME IS NOT NULL AND OFFF.F_DEN_TIME IS NOT NULL ");
			sql.append("             THEN TO_CHAR(OFFF.F_BEGIN_TIME,'yyyy-MM-dd')||' 至 '||TO_CHAR(OFFF.F_DEN_TIME,'yyyy-MM-dd')");
			sql.append("             WHEN OFFF.F_BEGIN_TIME IS NOT NULL AND OFFF.F_DEN_TIME IS NULL");
			sql.append("             THEN TO_CHAR(OFFF.F_BEGIN_TIME,'yyyy-MM-dd')||' 至 ~'");
			sql.append("             WHEN OFFF.F_DEN_TIME IS NOT NULL AND OFFF.F_BEGIN_TIME IS NULL");
			sql.append("             THEN '~ 至  '||TO_CHAR(OFFF.F_DEN_TIME,'YYYY-MM-DD')");
			sql.append("             ELSE '' END");
			sql.append("       ) f_begin_end_time");
			
			sql.append("  FROM OA_FILES_DEVOLVE OFFF");
			sql.append("  WHERE 1=1");
			if(!StringUtil.nullOrBlank(bean.getF_year())){
				sql.append(" AND F_YEAR = '"+bean.getF_year()+"'");
			}
			if(!StringUtil.nullOrBlank(bean.getF_org_id())){
				sql.append(" AND F_ORG_ID = '"+bean.getF_org_id()+"'");
			}
			if(!StringUtil.nullOrBlank(sortName)
					&&!StringUtil.nullOrBlank(sortOrder)){
				if("f_state_show".equals(sortName)){
					sortName = "f_state";
				}
				sql.append(" ORDER BY " + sortName + " " + sortOrder+"");
			}else{
				sql.append("  ORDER BY F_LOG_TIME DESC");
			}
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 getBeanById
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileFilesDevolveDao#getBeanById(java.sql.Connection, java.lang.String)
	 */
	@Override
	public Map<String, String> getBeanById(Connection conn, String beanId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT F_DEVOLVE_ID,");
		sql.append("       F_TITLE,");
		sql.append("       F_STATE,");
		sql.append("       F_DEADLINE,");
		sql.append("       F_TYPE,");
		sql.append("       F_RECEIVE_ORG_ID,");
		sql.append("       F_RECEIVE_ORG_NAME,");
		sql.append("       TO_CHAR(F_BEGIN_TIME,'yyyy-MM-dd') F_BEGIN_TIME,");
		sql.append("       TO_CHAR(F_DEN_TIME,'yyyy-MM-dd') F_DEN_TIME,");
		sql.append("       F_NUM,");
		sql.append("       F_LOG_USER_ID,");
		sql.append("       F_LOG_USER_NAME,");
		sql.append("       TO_CHAR(F_LOG_TIME,'yyyy-MM-dd') F_LOG_TIME,");
		sql.append("       F_ORG_ID,");
		sql.append("       F_ORG_NAME,");
		sql.append("       F_DEPT_ID,");
		sql.append("       F_DEPT_NAME,");
		sql.append("       F_REMARKS,");
		sql.append("       F_ATTACH_ID,");
		sql.append("       F_YEAR,");
		sql.append("       F_FONDS_NO,");
		sql.append("       F_CATALOG_NO,");
		sql.append("       F_FILES_NO");
		sql.append("  FROM OA_FILES_DEVOLVE OFD");
		sql.append(" WHERE OFD.F_DEVOLVE_ID = ?");
		return queryToSingleMap(conn, sql.toString(), beanId);
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 getQZH
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileFilesDevolveDao#getQZH(java.sql.Connection, java.lang.String)
	 */
	@Override
	public String getQZH(Connection conn, String beanId) throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from oa_file_fondsno b");
		sql.append(" where b.f_org_id = ? ");
		viewMap = queryToSingleMap(conn, sql.toString(), beanId);
		if(viewMap!=null&&viewMap.get("f_fondsno")!=null){
			return viewMap.get("f_fondsno");
		}else{
			return "";
		}
		
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 updateDetailBeanStateByBeanId
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileFilesDevolveDao#updateDetailBeanStateByBeanId(java.sql.Connection, java.lang.String)
	 */
	@Override
	public String updateDetailBeanStateByBeanId(Connection conn, String beanId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("UPDATE OA_FILES_DEVOLVE_DETAIL SET F_STATE = '"+
				FileFilesDevolveBean.STATE_TWO+
				"' WHERE F_DEVOLVE_ID = '"+beanId+"'");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.executePrepared(conn);
		sql = new StringBuffer();
		sql.append("update oa_file_files                   ");
		sql.append("   set f_files_state = '"+FileDocBean.STATE_YYJ+"' ");
		sql.append("     , f_files_state_name = '"+FileDocBean.STATE_YYJ_NM+"'    ");
		sql.append(" where f_files_id in                   ");
		sql.append("       (select f_files_id              ");
		sql.append("          from OA_FILES_DEVOLVE_DETAIL ");
		sql.append("         where F_DEVOLVE_ID ='"+beanId+"')");
		pdb.preparedUpdate(sql.toString());
		pdb.executePrepared(conn);
		
		
		sql = new StringBuffer();
		sql.append("update oa_file_doc");
		sql.append("   set f_doc_state = '"+FileDocBean.STATE_YYJ+"'");
		sql.append("     , f_doc_state_name = '"+FileDocBean.STATE_YYJ_NM+"'");
		sql.append(" where f_doc_id in");
		sql.append("       (select f_doc_id");
		sql.append("          from oa_file_docfiles");
		sql.append("         where f_files_id in");
		sql.append("               (select f_files_id");
		sql.append("                  from OA_FILES_DEVOLVE_DETAIL");
		sql.append("                 where F_DEVOLVE_ID = '"+beanId+"'))");
		pdb.preparedUpdate(sql.toString());
		pdb.executePrepared(conn);
		return "";
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 deleteDetailByBeanId
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileFilesDevolveDao#deleteDetailByBeanId(java.sql.Connection, java.lang.String)
	 */
	@Override
	public String deleteDetailByBeanId(Connection conn, String beanId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("DELETE OA_FILES_DEVOLVE_DETAIL WHERE F_DEVOLVE_ID = '"+beanId+"'");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.executePrepared(conn);
		return "";
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 getDetailBeanListForExport
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileFilesDevolveDao#getDetailBeanListForExport(java.sql.Connection, java.lang.String)
	 */
	@Override
	public List<Map<String, String>> getDetailBeanListForExport(
			Connection conn, String beanId) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT OFDD.F_DEVOLVE_DETAIL_ID,");
		sql.append("       OFDD.F_DEVOLVE_ID,");
		sql.append("       OFDD.F_FILES_ID,");
		sql.append("       OFFF.F_FILES_NO,");
		//sql.append("       OFDD.F_START_TIME,");
		//sql.append("       OFDD.F_END_TIME,");
		//sql.append("       OFDD.F_PAGE_NUM,");
		sql.append("       OFDD.F_STATE,");
		sql.append("       OFFF.F_FONDSNO,");
		sql.append("       OFFF.F_LISTNO,");
		sql.append("       OFFF.F_FILESNO,");
		sql.append("       OFFF.F_TYPE_NAME,");
		sql.append("       OFFF.F_FILES_TITLE,");
		sql.append("       (CASE WHEN OFFF.F_START_TIME IS NOT NULL AND OFFF.F_END_TIME IS NOT NULL ");
		sql.append("             THEN TO_CHAR(OFFF.F_START_TIME,'yyyy-MM-dd')||' 至 '||TO_CHAR(OFFF.F_END_TIME,'yyyy-MM-dd')");
		sql.append("             WHEN OFFF.F_START_TIME IS NOT NULL AND OFFF.F_END_TIME IS NULL");
		sql.append("             THEN TO_CHAR(OFFF.F_START_TIME,'yyyy-MM-dd')||' 至 ~'");
		sql.append("             WHEN OFFF.F_END_TIME IS NOT NULL AND OFFF.F_START_TIME IS NULL");
		sql.append("             THEN '~ 至  '||TO_CHAR(OFFF.F_END_TIME,'YYYY-MM-DD')");
		sql.append("             ELSE '无' END");
		sql.append("       ) F_START_END_TIME,");
		sql.append("       OFFF.F_START_TIME,");
		sql.append("       OFFF.F_END_TIME,");
		sql.append("       OFFF.F_DOC_DEADLINE_NAME,");
		sql.append("       OFFF.F_FILES_CONTENT,");
		sql.append("       (SELECT SUM(CASE WHEN OFD1.F_ENTITY_TYPE = 1 THEN NVL(TO_NUMBER(OFD1.F_FILE_QUANTITY), 0)");
		sql.append("                     ELSE 0 END)");
		sql.append("          FROM OA_FILE_DOC OFD1, OA_FILE_DOCFILES OFD2");
		sql.append("         WHERE OFD1.F_DOC_ID = OFD2.F_DOC_ID");
		sql.append("           AND OFD2.F_FILES_ID = OFFF.F_FILES_ID) F_PAGE_NUM");
		sql.append("  FROM OA_FILES_DEVOLVE_DETAIL OFDD");
		sql.append("  INNER JOIN OA_FILE_FILES OFFF");
		sql.append("    ON OFDD.F_FILES_ID = OFFF.F_FILES_ID");
		sql.append(" WHERE OFDD.F_DEVOLVE_ID = ?");
		sql.append("  ORDER BY F_FILES_ID ");
		return queryToListMap(sql.toString(), conn,beanId);
	}
	/**
	 * 文书类
	 * <b>Summary: </b>
	 *     复写方法 getWenShuList
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileFilesDevolveDao#getWenShuList(java.sql.Connection, java.lang.String)
	 */
	@Override
	public List<Map<String,String>> getWenShuList(Connection conn, String beanId) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT OFF.F_FONDSNO QZH");
		sql.append("     , OFF.F_FILESNO HH");
		sql.append("     , OFDC.F_DOC_NUM JH");//OFF.F_FILES_NO JH
		sql.append("     , OFF.F_DOC_YEAR ND");
		sql.append("     , OFF.F_DOC_BLNAME  ZRZ");
		sql.append("     , OFF.F_DOC_DEADLINE_NAME BGQX");
		sql.append("     , OFDC.F_DOC_FONTSIZE WH");
		sql.append("     , OFF.F_DEPT_NAME WT");
		sql.append("     , OFDC.F_DOC_NAME TM");
		sql.append("     , TO_CHAR(OFDC.F_FILE_FORMTIME,'yyyyMMdd') CWSJ");
		sql.append("     , OFDC.F_FILE_QUANTITY YS");
		sql.append("     , '文本' XXLX");
		sql.append("     , NVL(OFDC.F_DOC_CONTENT,'无') BZ");//mdb不能为空
		sql.append("     , OFDC.F_FILE_NO");
		sql.append("     , OFA.DJBH");
		sql.append("     , OFA.DJSN");
		sql.append("     , OFA.FILENAME");
		//sql.append("     , OFA.ATTACHCONTENT");
		sql.append("     , OFA.EXTEND");
		sql.append("       ,CASE");
		sql.append("         WHEN OFA.FILENAME IS NOT NULL AND OFDC.F_FILE_NO IS NOT NULL THEN");
		sql.append("           TRIM(OFDC.F_FILE_NO || OFA.EXTEND)");
		sql.append("         WHEN OFA.FILENAME IS NOT NULL AND OFDC.F_FILE_NO IS NULL THEN");
		sql.append("          TRIM('[无档号]' || OFA.FILENAME)");
		sql.append("         ELSE");
		sql.append("          ''");
		sql.append("       END DZWJM_NAME");
		sql.append("     , '"+File.separator+"'||NVL(TO_CHAR(OFDC.F_FILE_FORMTIME,'yyyy'),NVL(OFF.F_DOC_YEAR,'2013'))||'"+File.separator+"'||");
		sql.append("       CASE TO_CHAR(OFDC.F_FILE_FORMTIME,'MM')");
		sql.append("         WHEN '01' THEN '一月'");
		sql.append("         WHEN '02' THEN '二月'");
		sql.append("         WHEN '03' THEN '三月'");
		sql.append("         WHEN '04' THEN '四月'");
		sql.append("         WHEN '05' THEN '五月'");
		sql.append("         WHEN '06' THEN '六月'");
		sql.append("         WHEN '07' THEN '七月'");
		sql.append("         WHEN '08' THEN '八月'");
		sql.append("         WHEN '09' THEN '九月'");
		sql.append("         WHEN '10' THEN '十月'");
		sql.append("         WHEN '11' THEN '十一月'");
		sql.append("         WHEN '12' THEN '十二月'");
		sql.append("         ELSE '一月'");
		sql.append("       END||'"+File.separator+"' DZWJM_PATH");
		sql.append("  FROM OA_FILE_FILES OFF");
		sql.append(" INNER JOIN OA_FILE_DOCFILES OFDF");
		sql.append("    ON OFF.F_FILES_ID = OFDF.F_FILES_ID");
		sql.append(" INNER JOIN OA_FILE_DOC OFDC");
		sql.append("    ON OFDF.F_DOC_ID = OFDC.F_DOC_ID");
		sql.append("  LEFT JOIN OA_FC_ATTACH OFA");
		sql.append("    ON OFDC.F_ATTACH_ID = OFA.DJBH");
		sql.append(" WHERE OFF.F_TYPE_ID IN (");
		sql.append("SELECT OFT.F_TYPE_ID FROM OA_FILE_TYPE OFT WHERE OFT.F_PROGRAM_ID = '"+FileDocBean.F_PROGRAM_ID_WEN_SHU+"'");
		sql.append(" ) AND OFF.F_FILES_ID IN (");
		sql.append("SELECT F_FILES_ID FROM OA_FILES_DEVOLVE_DETAIL OFDD WHERE OFDD.F_DEVOLVE_ID = ?");
		sql.append(" ) AND OFDC.F_TYPE_ID IN (");
		sql.append("SELECT OFT.F_TYPE_ID FROM OA_FILE_TYPE OFT WHERE OFT.F_PROGRAM_ID = '"+FileDocBean.F_PROGRAM_ID_WEN_SHU+"'");
		sql.append(" ) ");
		return queryToListMap(sql.toString(), conn,beanId);
	}
	/**
	 * 光盘类
	 * <b>Summary: </b>
	 *     复写方法 getGuangPanList
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileFilesDevolveDao#getGuangPanList(java.sql.Connection, java.lang.String)
	 */
	@Override
	public List<Map<String, String>> getGuangPanList(Connection conn,
			String beanId) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT OFF.F_FONDSNO QZH");
		sql.append("     , OFF.F_FILESNO HH");
		sql.append("     , OFDC.F_DOC_NUM JH");//OFF.F_FILES_NO JH
		sql.append("     , OFF.F_DOC_YEAR ND");
		sql.append("     , OFF.F_DOC_BLNAME  ZRZ");
		sql.append("     , OFF.F_DOC_DEADLINE_NAME BGQX");
		sql.append("     , NVL(OFDC.F_DOC_FONTSIZE,'无') WH");//mdb不能为空
		sql.append("     , OFF.F_DEPT_NAME WT");
		sql.append("     , OFDC.F_DOC_NAME TM");
		sql.append("     , TO_CHAR(OFDC.F_FILE_FORMTIME,'yyyyMMdd') CWSJ");
		sql.append("     , OFDC.F_FILE_QUANTITY YS");
		sql.append("     , '光盘' XXLX");
		sql.append("     , NVL(OFDC.F_DOC_CONTENT,'无') BZ");//mdb不能为空
		sql.append("     , OFDC.F_FILE_NO");
		sql.append("     , OFA.DJBH");
		sql.append("     , OFA.DJSN");
		sql.append("     , OFA.FILENAME");
		//sql.append("     , OFA.ATTACHCONTENT");
		sql.append("     , OFA.EXTEND");
		sql.append("       ,CASE");
		sql.append("         WHEN OFA.FILENAME IS NOT NULL AND OFDC.F_FILE_NO IS NOT NULL THEN");
		sql.append("           TRIM(OFDC.F_FILE_NO || OFA.EXTEND)");
		sql.append("         WHEN OFA.FILENAME IS NOT NULL AND OFDC.F_FILE_NO IS NULL THEN");
		sql.append("          TRIM('[无档号]' || OFA.FILENAME)");
		sql.append("         ELSE");
		sql.append("          ''");
		sql.append("       END DZWJM_NAME");
		sql.append("     , '"+File.separator+"'||NVL(TO_CHAR(OFDC.F_FILE_FORMTIME,'yyyy'),NVL(OFF.F_DOC_YEAR,'2013'))||'"+File.separator+"'||");
		sql.append("       CASE TO_CHAR(OFDC.F_FILE_FORMTIME,'MM')");
		sql.append("         WHEN '01' THEN '一月'");
		sql.append("         WHEN '02' THEN '二月'");
		sql.append("         WHEN '03' THEN '三月'");
		sql.append("         WHEN '04' THEN '四月'");
		sql.append("         WHEN '05' THEN '五月'");
		sql.append("         WHEN '06' THEN '六月'");
		sql.append("         WHEN '07' THEN '七月'");
		sql.append("         WHEN '08' THEN '八月'");
		sql.append("         WHEN '09' THEN '九月'");
		sql.append("         WHEN '10' THEN '十月'");
		sql.append("         WHEN '11' THEN '十一月'");
		sql.append("         WHEN '12' THEN '十二月'");
		sql.append("         ELSE '一月'");
		sql.append("       END||'"+File.separator+"' DZWJM_PATH");
		sql.append("  FROM OA_FILE_FILES OFF");
		sql.append(" INNER JOIN OA_FILE_DOCFILES OFDF");
		sql.append("    ON OFF.F_FILES_ID = OFDF.F_FILES_ID");
		sql.append(" INNER JOIN OA_FILE_DOC OFDC");
		sql.append("    ON OFDF.F_DOC_ID = OFDC.F_DOC_ID");
		sql.append("  LEFT JOIN OA_FC_ATTACH OFA");
		sql.append("    ON OFDC.F_ATTACH_ID = OFA.DJBH");
		sql.append(" WHERE OFF.F_TYPE_ID IN (");
		sql.append("SELECT OFT.F_TYPE_ID FROM OA_FILE_TYPE OFT WHERE OFT.F_PROGRAM_ID = '"+FileDocBean.F_PROGRAM_ID_GUANG_PAN+"'");
		sql.append(" ) AND OFF.F_FILES_ID IN (");
		sql.append("SELECT F_FILES_ID FROM OA_FILES_DEVOLVE_DETAIL OFDD WHERE OFDD.F_DEVOLVE_ID = ?");
		sql.append(" ) AND OFDC.F_TYPE_ID IN (");
		sql.append("SELECT OFT.F_TYPE_ID FROM OA_FILE_TYPE OFT WHERE OFT.F_PROGRAM_ID = '"+FileDocBean.F_PROGRAM_ID_GUANG_PAN+"'");
		sql.append(" )");
		return queryToListMap(sql.toString(), conn,beanId);
	}
	/**
	 * 视频类
	 * <b>Summary: </b>
	 *     复写方法 getShiPinList
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileFilesDevolveDao#getShiPinList(java.sql.Connection, java.lang.String)
	 */
	@Override
	public List<Map<String, String>> getShiPinList(Connection conn,
			String beanId) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT OFF.F_FONDSNO QZH");
		sql.append("     , OFF.F_FILESNO HH");
		sql.append("     , OFDC.F_DOC_NUM JH");//OFF.F_FILES_NO JH
		sql.append("     , OFF.F_DOC_YEAR ND");
		sql.append("     , OFF.F_DOC_BLNAME  ZRZ");
		sql.append("     , OFF.F_DOC_DEADLINE_NAME BGQX");
		sql.append("     , NVL(OFDC.F_DOC_FONTSIZE,'无') WH");//mdb不能为空
		sql.append("     , OFF.F_DEPT_NAME WT");
		sql.append("     , OFDC.F_DOC_NAME TM");
		sql.append("     , TO_CHAR(OFDC.F_FILE_FORMTIME,'yyyyMMdd') CWSJ");
		sql.append("     , OFDC.F_FILE_QUANTITY YS");
		sql.append("     , '视频' XXLX");
		sql.append("     , NVL(OFDC.F_DOC_CONTENT,'无') BZ");//mdb不能为空
		sql.append("     , OFDC.F_FILE_NO");
		sql.append("     , OFA.DJBH");
		sql.append("     , OFA.DJSN");
		sql.append("     , OFA.FILENAME");
		//sql.append("     , OFA.ATTACHCONTENT");
		sql.append("     , OFA.EXTEND");
		sql.append("       ,CASE");
		sql.append("         WHEN OFA.FILENAME IS NOT NULL AND OFDC.F_FILE_NO IS NOT NULL THEN");
		sql.append("           TRIM(OFDC.F_FILE_NO || OFA.EXTEND)");
		sql.append("         WHEN OFA.FILENAME IS NOT NULL AND OFDC.F_FILE_NO IS NULL THEN");
		sql.append("          TRIM('[无档号]' || OFA.FILENAME)");
		sql.append("         ELSE");
		sql.append("          ''");
		sql.append("       END DZWJM_NAME");
		sql.append("     , '"+File.separator+"'||NVL(TO_CHAR(OFDC.F_FILE_FORMTIME,'yyyy'),NVL(OFF.F_DOC_YEAR,'2013'))||'"+File.separator+"'||");
		sql.append("       CASE TO_CHAR(OFDC.F_FILE_FORMTIME,'MM')");
		sql.append("         WHEN '01' THEN '一月'");
		sql.append("         WHEN '02' THEN '二月'");
		sql.append("         WHEN '03' THEN '三月'");
		sql.append("         WHEN '04' THEN '四月'");
		sql.append("         WHEN '05' THEN '五月'");
		sql.append("         WHEN '06' THEN '六月'");
		sql.append("         WHEN '07' THEN '七月'");
		sql.append("         WHEN '08' THEN '八月'");
		sql.append("         WHEN '09' THEN '九月'");
		sql.append("         WHEN '10' THEN '十月'");
		sql.append("         WHEN '11' THEN '十一月'");
		sql.append("         WHEN '12' THEN '十二月'");
		sql.append("         ELSE '一月'");
		sql.append("       END||'"+File.separator+"' DZWJM_PATH");
		sql.append("  FROM OA_FILE_FILES OFF");
		sql.append(" INNER JOIN OA_FILE_DOCFILES OFDF");
		sql.append("    ON OFF.F_FILES_ID = OFDF.F_FILES_ID");
		sql.append(" INNER JOIN OA_FILE_DOC OFDC");
		sql.append("    ON OFDF.F_DOC_ID = OFDC.F_DOC_ID");
		sql.append("  LEFT JOIN OA_FC_ATTACH OFA");
		sql.append("    ON OFDC.F_ATTACH_ID = OFA.DJBH");
		sql.append(" WHERE OFF.F_TYPE_ID IN (");
		sql.append("SELECT OFT.F_TYPE_ID FROM OA_FILE_TYPE OFT WHERE OFT.F_PROGRAM_ID = '"+FileDocBean.F_PROGRAM_ID_SHI_PIN+"'");
		sql.append(" ) AND OFF.F_FILES_ID IN (");
		sql.append("SELECT F_FILES_ID FROM OA_FILES_DEVOLVE_DETAIL OFDD WHERE OFDD.F_DEVOLVE_ID = ?");
		sql.append(" ) AND OFDC.F_TYPE_ID IN (");
		sql.append("SELECT OFT.F_TYPE_ID FROM OA_FILE_TYPE OFT WHERE OFT.F_PROGRAM_ID = '"+FileDocBean.F_PROGRAM_ID_SHI_PIN+"'");
		sql.append(" )");
		return queryToListMap(sql.toString(), conn,beanId);
	}
	/**
	 * 照片类
	 * <b>Summary: </b>
	 *     复写方法 getZhaoPianList
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileFilesDevolveDao#getZhaoPianList(java.sql.Connection, java.lang.String)
	 */
	@Override
	public List<Map<String, String>> getZhaoPianList(Connection conn,
			String beanId) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT OFF.F_FONDSNO QZH");
		sql.append("     , OFF.F_FILESNO HH");
		sql.append("     , OFDC.F_DOC_NUM JH");//OFF.F_FILES_NO JH
		sql.append("     , OFF.F_DOC_YEAR ND");
		sql.append("     , OFF.F_DOC_BLNAME  ZRZ");
		sql.append("     , OFF.F_DOC_DEADLINE_NAME BGQX");
		sql.append("     , NVL(OFDC.F_DOC_FONTSIZE,'无') WH");//mdb不能为空
		sql.append("     , OFF.F_DEPT_NAME WT");
		sql.append("     , OFDC.F_DOC_NAME TM");
		sql.append("     , TO_CHAR(OFDC.F_FILE_FORMTIME,'yyyyMMdd') CWSJ");
		sql.append("     , OFDC.F_FILE_QUANTITY YS");
		sql.append("     , '照片' XXLX");
		sql.append("     , NVL(OFDC.F_DOC_CONTENT,'无') BZ");//mdb不能为空
		sql.append("     , OFDC.F_FILE_NO");
		sql.append("     , OFA.DJBH");
		sql.append("     , OFA.DJSN");
		sql.append("     , OFA.FILENAME");
		//sql.append("     , OFA.ATTACHCONTENT");
		sql.append("     , OFA.EXTEND");
		sql.append("       ,CASE");
		sql.append("         WHEN OFA.FILENAME IS NOT NULL AND OFDC.F_FILE_NO IS NOT NULL THEN");
		sql.append("           TRIM(OFDC.F_FILE_NO || OFA.EXTEND)");
		sql.append("         WHEN OFA.FILENAME IS NOT NULL AND OFDC.F_FILE_NO IS NULL THEN");
		sql.append("          TRIM('[无档号]' || OFA.FILENAME)");
		sql.append("         ELSE");
		sql.append("          ''");
		sql.append("       END DZWJM_NAME");
		sql.append("     , '"+File.separator+"'||NVL(TO_CHAR(OFDC.F_FILE_FORMTIME,'yyyy'),NVL(OFF.F_DOC_YEAR,'2013'))||'"+File.separator+"'||");
		sql.append("       CASE TO_CHAR(OFDC.F_FILE_FORMTIME,'MM')");
		sql.append("         WHEN '01' THEN '一月'");
		sql.append("         WHEN '02' THEN '二月'");
		sql.append("         WHEN '03' THEN '三月'");
		sql.append("         WHEN '04' THEN '四月'");
		sql.append("         WHEN '05' THEN '五月'");
		sql.append("         WHEN '06' THEN '六月'");
		sql.append("         WHEN '07' THEN '七月'");
		sql.append("         WHEN '08' THEN '八月'");
		sql.append("         WHEN '09' THEN '九月'");
		sql.append("         WHEN '10' THEN '十月'");
		sql.append("         WHEN '11' THEN '十一月'");
		sql.append("         WHEN '12' THEN '十二月'");
		sql.append("         ELSE '一月'");
		sql.append("       END||'"+File.separator+"' DZWJM_PATH");
		sql.append("  FROM OA_FILE_FILES OFF");
		sql.append(" INNER JOIN OA_FILE_DOCFILES OFDF");
		sql.append("    ON OFF.F_FILES_ID = OFDF.F_FILES_ID");
		sql.append(" INNER JOIN OA_FILE_DOC OFDC");
		sql.append("    ON OFDF.F_DOC_ID = OFDC.F_DOC_ID");
		sql.append(" INNER JOIN OA_FILE_PHOTO_INFO OFPI");
		sql.append("    ON OFPI.F_FILE_ID = OFDC.F_DOC_ID");
		sql.append("  LEFT JOIN OA_FC_ATTACH OFA");
		sql.append("    ON OFPI.F_ATTACH_ID = OFA.DJBH");
		sql.append(" WHERE OFF.F_TYPE_ID IN (");
		sql.append("SELECT OFT.F_TYPE_ID FROM OA_FILE_TYPE OFT WHERE OFT.F_PROGRAM_ID = '"+FileDocBean.F_PROGRAM_ID_ZAHO_PIAN+"'");
		sql.append(" ) AND OFF.F_FILES_ID IN (");
		sql.append("SELECT F_FILES_ID FROM OA_FILES_DEVOLVE_DETAIL OFDD WHERE OFDD.F_DEVOLVE_ID = ?");
		sql.append(" ) AND OFDC.F_TYPE_ID IN (");
		sql.append("SELECT OFT.F_TYPE_ID FROM OA_FILE_TYPE OFT WHERE OFT.F_PROGRAM_ID = '"+FileDocBean.F_PROGRAM_ID_ZAHO_PIAN+"'");
		sql.append(" )");
		return queryToListMap(sql.toString(), conn,beanId);
	}
	/**
	QZH       全宗号
	HH        盒号
	JH        档案室编件号
	ND	      归档年度
	ZRZ       责任者
	BGQX      保管期限
	WH        文号
	WT        组织机构或问题
	TM        题名
	CWSJ      文件形成时间   yyyyMMdd
	YS        页数
	XXLX      信息类型（文本、图像、影像、声音）
	BZ        备注
	DZWJM     电子文件名称
			 */
}
