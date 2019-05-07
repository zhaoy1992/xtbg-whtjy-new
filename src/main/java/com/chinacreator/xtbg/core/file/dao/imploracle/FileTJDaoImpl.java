package com.chinacreator.xtbg.core.file.dao.imploracle;

import java.sql.Connection;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.file.dao.FileTJDao;
import com.chinacreator.xtbg.core.file.entity.FileDocBean;

/**
 * 统计
 *<p>Title:FileTJDao.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Oct 23, 2013
 */
public class FileTJDaoImpl extends XtDbBaseDao implements FileTJDao{
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 queryList1
	 * @param model
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileTJDao#queryList1(com.chinacreator.xtbg.core.file.entity.FileFJBeanVO, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean queryList1(FileDocBean model, String sortName,
			String sortOrder, long offset, int maxPagesize,String type) throws Exception {
		Connection conn = null;
		String aa = "&nbsp;";// space in page
		if(type.equals("excel")){//space in excel
			aa =" ";
		}
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			sql.append("select oft.f_type_id,");
			sql.append("       oft.f_type_name,");
			sql.append("       oft.rm,");
			sql.append("       nvl(sum(oft.aa), 0)aa,");
			sql.append("       nvl(sum(oft.a), 0) a,");
			sql.append("       nvl(sum(oft.b), 0) b,");
			sql.append("       nvl(sum(oft.c), 0) c");
			sql.append("  from (select oft.f_type_id,");
			sql.append("               oft.f_type_name,");
			sql.append("               oft.rm,");
			sql.append("               mess.aa,");
			sql.append("               mess.a,");
			sql.append("               mess.b,");
			sql.append("               mess.c");
			sql.append("          from (select oft.f_type_id,");
			//1级无空格,2级4个空格,n级2^n个空格
			sql.append("                       REPLACE(REPLACE(''||power(10,decode(level,1,0,power(2,level))),'0','"+aa+"'),'1','')||");
			sql.append("                       oft.f_type_name f_type_name,");
			sql.append("                       rownum rm,");
			sql.append("                       (select wm_concat(oftt.f_type_id)");
			sql.append("                          from oa_file_type oftt");
			sql.append("                        connect by prior oftt.f_type_id = oftt.f_parent_type_id");
			sql.append("                         start with oftt.f_type_id = oft.f_type_id) f_type_ids");
			sql.append("                  from oa_file_type oft");
			sql.append("                connect by prior oft.f_type_id = oft.f_parent_type_id");
			if (!StringUtil.nullOrBlank(model.getF_type_id())){
				sql.append("                 start with oft.f_type_id = '"+model.getF_type_id()+"'");
			}else{
				sql.append("                 start with oft.f_parent_type_id is null");
			}
			sql.append("                        and oft.f_org_id =");
			sql.append("                            '"+model.getF_org_id()+"'");
			sql.append("                 ORDER SIBLINGS BY oft.f_type_order) oft");
			sql.append("          left join (SELECT OFD.F_TYPE_ID,");
			sql.append("                           count(distinct OFD.F_DOC_ID) aa,");
			sql.append("                           SUM(阅读次数) a,");
			sql.append("                           SUM(借阅次数) b,");
			sql.append("                           SUM(部门外借阅次数) c");
			sql.append("                      FROM (");
			
			sql.append("     SELECT OFD.F_DOC_ID,");
			sql.append("            OFD.F_DOC_NAME,");
			sql.append("            OFD.F_TYPE_ID,");
			sql.append("            OFR.F_USER_ID,");
			sql.append("            NULL F_LENDING_USERNAME,");
			sql.append("            NULL F_LENDING_USERID,");
			sql.append("            DECODE(OFR.F_USER_ID, NULL, 0, 1) 阅读次数,");
			sql.append("            0 借阅次数,");
			sql.append("            0 部门外借阅次数");
			sql.append("       FROM OA_FILE_DOC OFD");
			sql.append("       LEFT JOIN OA_FILE_READ_RECODE_INFO OFR");
			sql.append("         ON OFD.F_DOC_ID = OFR.F_DOC_ID");
			sql.append("      WHERE 1 = 1");
			if (!StringUtil.nullOrBlank(model.getF_doc_year())){
				sql.append(" and OFD.f_doc_year = '"+model.getF_doc_year()+"'");
			}
			if (!StringUtil.nullOrBlank(model.getF_dept_name())){
				sql.append(" and OFD.f_dept_name = '"+model.getF_dept_name()+"'");
			}
			
			sql.append("      UNION ALL");
			sql.append("     SELECT OFD.F_DOC_ID,");
			sql.append("            OFD.F_DOC_NAME,");
			sql.append("            OFD.F_TYPE_ID,");
			sql.append("            NULL F_USER_ID,");
			sql.append("            OFL.F_LENDING_USERNAME,");
			sql.append("            OFL.F_LENDING_USERID,");
			sql.append("            0 阅读次数,");
			sql.append("            DECODE(OFL.F_LENDING_USERNAME, NULL, 0, 1) 借阅次数,");
			sql.append("            DECODE(OFL.F_LENDING_USERNAME, NULL, 0, 1) *");
			sql.append("            DECODE(OFL.F_LENDING_USERID, NULL, 1, 0) 部门外借阅次数");
			sql.append("       FROM OA_FILE_DOC OFD");
			sql.append("       LEFT JOIN OA_FILE_LENDING_DETAIL OFLD");
			sql.append("         ON OFD.F_DOC_ID = OFLD.F_DOC_ID");
			sql.append("       LEFT JOIN OA_FILE_LENDING OFL");
			sql.append("         ON OFLD.F_LENDING_ID = OFL.F_LENDING_ID");
			sql.append("      WHERE 1 = 1");
			
			if (!StringUtil.nullOrBlank(model.getF_doc_year())){
				sql.append(" and OFD.f_doc_year = '"+model.getF_doc_year()+"'");
			}
			if (!StringUtil.nullOrBlank(model.getF_dept_name())){
				sql.append(" and OFD.f_dept_name = '"+model.getF_dept_name()+"'");
			}
			sql.append("                            ) OFD");
			sql.append("                     GROUP BY OFD.F_TYPE_ID) mess");
			sql.append("            on oft.f_type_ids like '%' || mess.f_type_id || '%') oft");
			sql.append(" group by oft.f_type_id, oft.f_type_name, oft.rm");
			sql.append(" order by " + sortName + " " + sortOrder+",oft.rm");
			// 调父类的方法
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	@Override
	public PagingBean queryList2(FileDocBean model, String sortName,
			String sortOrder, long offset, int maxPagesize, String type)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			sql.append("select OFD.F_DOC_ID,");
			sql.append("       OFD.F_DOC_NAME,");
			sql.append("       OFD.F_TYPE_ID,");
			sql.append("       ofd.a,");
			sql.append("       ofd.b,");
			sql.append("       ofd.c,");
			sql.append("       oft.f_type_parentname");
			sql.append("  from (SELECT OFD.F_DOC_ID,");
			sql.append("               OFD.F_DOC_NAME,");
			sql.append("               OFD.F_TYPE_ID,");
			sql.append("               SUM(阅读次数) a,");
			sql.append("               SUM(借阅次数) b,");
			sql.append("               SUM(部门外借阅次数) c");
			sql.append("          FROM (");
			
			sql.append("     SELECT OFD.F_DOC_ID,");
			sql.append("            OFD.F_DOC_NAME,");
			sql.append("            OFD.F_TYPE_ID,");
			sql.append("            OFR.F_USER_ID,");
			sql.append("            NULL F_LENDING_USERNAME,");
			sql.append("            NULL F_LENDING_USERID,");
			sql.append("            DECODE(OFR.F_USER_ID, NULL, 0, 1) 阅读次数,");
			sql.append("            0 借阅次数,");
			sql.append("            0 部门外借阅次数");
			sql.append("       FROM OA_FILE_DOC OFD");
			sql.append("       LEFT JOIN OA_FILE_READ_RECODE_INFO OFR");
			sql.append("         ON OFD.F_DOC_ID = OFR.F_DOC_ID");
			sql.append("      WHERE OFD.F_ORG_ID = '"+model.getF_org_id()+"' ");
			if (!StringUtil.nullOrBlank(model.getF_doc_year())){
				sql.append(" and OFD.f_doc_year = '"+model.getF_doc_year()+"'");
			}
			if (!StringUtil.nullOrBlank(model.getF_dept_name())){
				sql.append(" and OFD.f_dept_name = '"+model.getF_dept_name()+"'");
			}
			if (!StringUtil.nullOrBlank(model.getF_type_id())){
				sql.append(" and ofd.f_type_id in (  select f_type_id from oa_file_type connect by prior f_type_id = f_parent_type_id start with f_type_id = '"+model.getF_type_id()+"')");
			}
			
			sql.append("      UNION ALL");
			sql.append("     SELECT OFD.F_DOC_ID,");
			sql.append("            OFD.F_DOC_NAME,");
			sql.append("            OFD.F_TYPE_ID,");
			sql.append("            NULL F_USER_ID,");
			sql.append("            OFL.F_LENDING_USERNAME,");
			sql.append("            OFL.F_LENDING_USERID,");
			sql.append("            0 阅读次数,");
			sql.append("            DECODE(OFL.F_LENDING_USERNAME, NULL, 0, 1) 借阅次数,");
			sql.append("            DECODE(OFL.F_LENDING_USERNAME, NULL, 0, 1) *");
			sql.append("            DECODE(OFL.F_LENDING_USERID, NULL, 1, 0) 部门外借阅次数");
			sql.append("       FROM OA_FILE_DOC OFD");
			sql.append("       LEFT JOIN OA_FILE_LENDING_DETAIL OFLD");
			sql.append("         ON OFD.F_DOC_ID = OFLD.F_DOC_ID");
			sql.append("       LEFT JOIN OA_FILE_LENDING OFL");
			sql.append("         ON OFLD.F_LENDING_ID = OFL.F_LENDING_ID");
			sql.append("      WHERE OFD.F_ORG_ID = '"+model.getF_org_id()+"' ");
			if (!StringUtil.nullOrBlank(model.getF_doc_year())){
				sql.append(" and OFD.f_doc_year = '"+model.getF_doc_year()+"'");
			}
			if (!StringUtil.nullOrBlank(model.getF_dept_name())){
				sql.append(" and OFD.f_dept_name = '"+model.getF_dept_name()+"'");
			}
			if (!StringUtil.nullOrBlank(model.getF_type_id())){
				sql.append(" and ofd.f_type_id in (  select f_type_id from oa_file_type connect by prior f_type_id = f_parent_type_id start with f_type_id = '"+model.getF_type_id()+"')");
			}
			sql.append("                            ) OFD");
			sql.append("         GROUP BY OFD.F_DOC_ID, OFD.F_DOC_NAME, OFD.F_TYPE_ID) ofd,");
			sql.append("       oa_file_type oft");
			sql.append(" where ofd.F_TYPE_ID = oft.F_TYPE_ID");
			sql.append(" order by " + sortName + " " + sortOrder+",OFD.F_DOC_NAME");
			// 调父类的方法
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}}
