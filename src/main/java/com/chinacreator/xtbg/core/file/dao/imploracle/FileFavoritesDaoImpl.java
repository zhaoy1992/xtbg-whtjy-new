package com.chinacreator.xtbg.core.file.dao.imploracle;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.file.dao.FileFavoritesDao;
import com.chinacreator.xtbg.core.file.entity.FileFilesQueryBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:FileFavoritesDaoImpl.java</p>
 *<p>Description:收藏文件Dao</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Jul 24, 2013
 */
public class FileFavoritesDaoImpl extends XtDbBaseDao implements FileFavoritesDao {
	
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 queryFileFilesListOther
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileFilesQueryDao#queryFileFilesListOther(com.chinacreator.xtbg.core.file.entity.FileFilesQueryBean, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean queryList(FileFilesQueryBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			// 拼接的值
			List<String> conditionValues = new ArrayList<String>();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT OFD.F_DOC_ID,");
			sql.append("       OFD.F_DOC_NUM,");//件号
			sql.append("       case");
			sql.append("       when  f_attach_id is null then (select count(1) from oa_fc_attach fa where fa.djbh in (select f_attach_id from oa_file_photo_info fpi where fpi.f_file_id = ofd.f_doc_id)) ");
			sql.append("       else (SELECT COUNT(1) FROM OA_FC_ATTACH WHERE DJBH IN (SELECT F_ATTACH_ID FROM OA_FILE_DOC OFD1 WHERE OFD1.F_DOC_ID=OFD.F_DOC_ID)) end ATTACH_NUM, ");//附件数量
			sql.append("       OFD.F_DOC_FONTSIZE,");//编号
			sql.append("       OFD.F_DOC_NAME,");//文件标题
			sql.append("       DECODE(OFD.f_Doc_State,");
			sql.append("       '0','待归档',");
			sql.append("       '1','不需归档',");
			sql.append("       '2','已归档',");
			sql.append("       '8','已移交',");
			sql.append("       '9','已销毁',f_Doc_State) f_Doc_State,");//档案状态
			sql.append("       OFD.F_FILE_NUM,");//库存数量
			sql.append("       OFD.F_DEPT_NAME,");//所属部门
			sql.append("       TO_CHAR(OFD.F_FILE_FORMTIME, 'yyyy-MM-dd') F_CREATOR_TIME_STR,");//文件形成时间
			sql.append("       OFPP.F_FILE_DETAIL QUERY_PAGE,");
			sql.append("      OFFTT.F_FAVORITES_ID F_FAVORITES_ID");
			sql.append("  FROM OA_FILE_DOC OFD");
			sql.append(" RIGHT JOIN OA_FILE_FAVORITES OFFTT");
			sql.append("    ON OFFTT.F_DOC_ID = OFD.F_DOC_ID");
			sql.append("  LEFT JOIN OA_FILE_DOCFILES OFDF");
			sql.append("    ON OFD.f_Doc_Id = OFDF.F_DOC_ID");
			sql.append("  LEFT JOIN OA_FILE_FILES OFFT");
			sql.append("    ON OFDF.F_FILES_ID = OFFT.F_FILES_ID");
			sql.append("  LEFT JOIN OA_FILE_TYPE OFT");
			sql.append("    ON OFD.F_TYPE_ID = OFT.F_TYPE_ID");
			sql.append("  LEFT JOIN OA_FILE_PROGRAM_PAGE OFPP");
			sql.append("    ON OFT.F_PROGRAM_ID = OFPP.F_PROGRAM_ID");
			if(StringUtil.nullOrBlank(bean.getF_org_id())){
				sql.append(" WHERE 1 = 0");
			}else{
				sql.append(" WHERE OFFTT.F_USER_ID = ? AND OFD.F_ORG_ID = ?");
				conditionValues.add(bean.getF_user_id());
				conditionValues.add(bean.getF_org_id());
				//2
				if(!StringUtil.nullOrBlank(bean.getF_type_id())){
					sql.append("   AND OFD.F_TYPE_ID = ?");
					conditionValues.add(bean.getF_type_id());
				}
				//3档案年份
				if (!StringUtil.nullOrBlank(bean.getF_doc_year())) {
					sql.append(" and OFD.f_doc_year like '%'||?||'%'");
					conditionValues.add(bean.getF_doc_year());
				}
				//4所属部门
				if(!StringUtil.nullOrBlank(bean.getF_dept_name() )){
					sql.append(" and OFD.F_dept_name like '%'||?||'%' ");
					conditionValues.add(bean.getF_dept_name());
				}
				//5归档状态
				if(!StringUtil.nullOrBlank(bean.getF_doc_state())){
					sql.append("   AND OFD.f_doc_state = ?");
					conditionValues.add(bean.getF_doc_state());
				}
				//6文档标题
				if(!StringUtil.nullOrBlank(bean.getF_doc_name())){
					sql.append("   AND OFD.f_doc_name LIKE '%'||?||'%' ");
					conditionValues.add(bean.getF_doc_name());
				}
	            //7编号
				if (!StringUtil.nullOrBlank(bean.getF_doc_fontsize())) {
					sql.append("   AND OFD.f_doc_fontsize LIKE '%'||?||'%' ");
					conditionValues.add(bean.getF_doc_fontsize());
				}
				//8案卷号
				if (!StringUtil.nullOrBlank(bean.getF_filesno())) {
					sql.append(" AND OFFT.f_filesno like '%'||?||'%'  ");
					conditionValues.add(bean.getF_filesno());						
				}
				
				if (!StringUtil.nullOrBlank(sortName)
						&& !StringUtil.nullOrBlank(sortOrder)) {
					sql.append(" order by " + sortName + " " + sortOrder);
				}
			}
			// 调父类的方法
			return queryToPagingBean(sql.toString(), offset, maxPagesize, conn,
					conditionValues);
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 getDocIdByUserId
	 * @param userId
	 * @param conn
	 * @param flag
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileFavoritesDao#getDocIdByUserId(java.lang.String, java.sql.Connection, boolean)
	 */
	@Override
	public Set<String> getDocIdByUserId(String userId, Connection conn,
			boolean flag) throws Exception {
		String sql = "SELECT OFFT.F_DOC_ID FROM OA_FILE_FAVORITES OFFT WHERE OFFT.F_USER_ID = ?";
		if(flag){
			sql +=" FOR UPDATE";
		}
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql.toString());
		db.setString(1,userId);
		db.executePrepared(conn);
		Set<String> set = new HashSet<String>();
		for (int i = 0; i < db.size(); i++) {
			set.add(db.getString(i,"F_DOC_ID"));
		}
		return set;
	}
}
