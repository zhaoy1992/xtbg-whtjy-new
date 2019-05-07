package com.chinacreator.xtbg.core.file.dao.imploracle;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.file.dao.FilesStateManageDao;
import com.chinacreator.xtbg.core.file.entity.FileFilesBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:FileDocDaoImpl.java</p>
 *<p>Description:文件管理Dao接口实现</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-7-16
 */
public class FilesStateManageDaoImpl extends XtDbBaseDao implements FilesStateManageDao{

	@Override
	public PagingBean queryFilesSubmitList(FileFilesBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();

			// 拼接的值
			List<String> conditionValues = new ArrayList<String>();
			StringBuffer sql = new StringBuffer();
			sql.append("select ");
			sql.append(" a.f_files_id,");
			sql.append(" a.f_files_no,");
			sql.append(" a.f_doc_year,");
			sql.append(" a.f_filesno,");
			sql.append(" a.f_listno,");
			sql.append(" a.f_files_num,");
			sql.append(" a.f_files_state,");
			sql.append(" a.f_files_state_name,");
			sql.append(" a.f_doc_deadline_name,");
			sql.append(" a.f_secrecy_name,");
			sql.append(" a.f_secrecy_id,");
			sql.append(" to_char(a.f_file_time,'yyyy-MM-dd') f_file_time,");
			sql.append(" a.f_dept_name,");
			sql.append(" a.f_file_userid,");
			sql.append(" a.f_dept_id,");
			sql.append(" a.f_type_id,");
			sql.append(" a.f_type_name,");
			sql.append(" a.f_order, ");
			sql.append(" a.f_flow_state ");
			sql.append("  from oa_file_files a");
			sql.append("  left join oa_file_files_acc c");
			sql.append("    on a.f_files_id = c.f_files_id");
			sql.append(" where a.f_files_id is not null");
			if("1".equals(bean.getF_type())){
				sql.append(" and (a.f_flow_state ='1' or a.f_flow_state ='0')");
			}else if("2".equals(bean.getF_type())){
				sql.append(" and (a.f_flow_state ='2' or a.f_flow_state ='3')");
			}
			
			// 所属部门
			if (!StringUtil.nullOrBlank(bean.getF_dept_name())) {
				sql.append(" and a.F_dept_name like '%'||?||'%' ");
				conditionValues.add(bean.getF_dept_name());
			}
			// 所属单位
			if (!StringUtil.nullOrBlank(bean.getF_org_id())) {
				sql.append(" and a.F_org_id = ? ");
				conditionValues.add(bean.getF_org_id());
			}
			// 所属分类分类id
			if (!StringUtil.nullOrBlank(bean.getF_type_id())){
				sql.append(" and a.F_type_id in  ");
				sql.append(" ( select f_type_id");
				sql.append("  from oa_file_type");
				sql.append(" start with f_type_id = ?");
				sql.append(" connect by prior f_type_id = f_parent_type_id )");
				conditionValues.add(bean.getF_type_id());
			}
			// 保管期限
			if (!StringUtil.nullOrBlank(bean.getF_doc_deadline_name())) {
				sql
						.append(" and  instr(','||?||',',','||a.f_doc_deadline_name||',')>0 ");
				conditionValues.add(bean.getF_doc_deadline_name());
			}
			// 保管期限
			if (!StringUtil.nullOrBlank(bean.getF_doc_deadline())) {
				sql.append(" and  a.F_doc_deadline =?  ");
				conditionValues.add(bean.getF_doc_deadline());
			}

			// 档案年份
			if (!StringUtil.nullOrBlank(bean.getF_doc_year())) {
				sql.append(" and a.f_doc_year like '%'||?||'%' ");
				conditionValues.add(bean.getF_doc_year());
			}
			// 档案名称
			if (!StringUtil.nullOrBlank(bean.getF_files_title())) {
				sql.append(" and a.f_files_title like '%'||?||'%'  ");
				conditionValues.add(bean.getF_files_title());
			}
			// 案卷号
			if (!StringUtil.nullOrBlank(bean.getF_filesno())) {
				sql.append(" and a.f_filesno like '%'||?||'%'  ");
				conditionValues.add(bean.getF_filesno());
			}
			// 密级
			if (!StringUtil.nullOrBlank(bean.getF_secrecy_name())) {
				sql
						.append(" and instr(','||?||',',','||a.f_secrecy_name||',')>0 ");
				conditionValues.add(bean.getF_secrecy_name());
			}
			if(!StringUtil.nullOrBlank(bean.getF_files_state())){
				sql.append(" and a.F_files_state=? ");
				conditionValues.add(bean.getF_files_state());
			}

			//档号
			if(!StringUtil.nullOrBlank(bean.getF_files_no())){
				sql.append(" and a.F_files_no like '%'||?||'%'");
				conditionValues.add(bean.getF_files_no());
			} 
		    
			//归档日期开始时间
			if (!StringUtil.nullOrBlank(bean.getF_start_time())) {
				sql.append(" and a.F_file_time >= to_date(?,'yyyy-mm-dd')  ")
						.append(" and a.F_file_time is not null ");
				conditionValues.add(StringUtil.deNull(bean.getF_start_time()));
			}
			//归档日期结束时间
			if (!StringUtil.nullOrBlank(bean.getF_end_time())) {
				sql.append(" and a.F_file_time <= to_date(?,'yyyy-mm-dd') ")
						.append(" and a.F_file_time is not null ");
				conditionValues.add(StringUtil.deNull(bean.getF_end_time()));
			}
			
			//目录号
			if(!StringUtil.nullOrBlank(bean.getF_listno())){
				sql.append(" and a.f_listno = ?");
				conditionValues.add(bean.getF_listno());
			}
			//卷内件数
			if(!StringUtil.nullOrBlank(bean.getF_files_num())){
				sql.append(" and a.f_files_num = ? ");
				conditionValues.add(bean.getF_files_num());
			}
			if (!StringUtil.nullOrBlank(sortName)
					&& !StringUtil.nullOrBlank(sortOrder)) { 
				sql.append(" order by " + sortName + " "
						+ sortOrder);
			}

			// 调父类的方法
			return queryToPagingBean(sql.toString(), offset, maxPagesize, conn, conditionValues);
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	@Override
	public boolean tijiaoFiles(String[] ids,String userId,String userName) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			String sql = "update OA_FILE_FILES  set F_FLOW_STATE = '2',F_SUBMIT_USER_ID = ?,F_SUBMIT_USER_NAME = ?,F_SUBMIT_TIME=sysdate where F_FILES_ID= ?";
			PreparedDBUtil db = new PreparedDBUtil();
			for(int i=0; i< ids.length ;i++){ //子节点成1开始遍历
				db.preparedUpdate(sql.toString());
				db.setString(1,userId);
				db.setString(2,userName);
				db.setString(3,ids[i]);
				db.addPreparedBatch();
			}
			db.executePreparedBatch(conn);
		}catch(Exception e){
			DbManager.closeTransactionConnection(conn, false);
		}finally{
			DbManager.closeTransactionConnection(conn, true);
		}
		return true;
	}	
	public boolean jieshouFiles(String[] ids) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			String sql = "update OA_FILE_FILES  set F_FLOW_STATE = '3' where F_FILES_ID= ?";
			PreparedDBUtil db = new PreparedDBUtil();
			for(int i=0; i< ids.length ;i++){ //子节点成1开始遍历
				db.preparedUpdate(sql.toString());
				db.setString(1,ids[i]);
				db.addPreparedBatch();
			}
			db.executePreparedBatch(conn);
		}catch(Exception e){
			DbManager.closeTransactionConnection(conn, false);
		}finally{
			DbManager.closeTransactionConnection(conn, true);
		}
		return true;
	}

	public PagingBean queryFilesJieShouList(FileFilesBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			// 拼接的值
			List<String> conditionValues = new ArrayList<String>();
			StringBuffer sql = new StringBuffer();
			sql.append("select ");
			sql.append(" a.f_files_id,");
			sql.append(" a.f_files_no,");
			sql.append(" a.f_doc_year,");
			sql.append(" a.f_filesno,");
			sql.append(" a.f_listno,");
			sql.append(" a.f_files_num,");
			sql.append(" a.f_files_state,");
			sql.append(" a.f_files_state_name,");
			sql.append(" a.f_doc_deadline_name,");
			sql.append(" a.f_secrecy_name,");
			sql.append(" a.f_secrecy_id,");
			sql.append(" to_char(a.f_file_time,'yyyy-MM-dd') f_file_time,");
			sql.append(" a.f_dept_name,");
			sql.append(" a.f_file_userid,");
			sql.append(" a.f_dept_id,");
			sql.append(" a.f_type_id,");
			sql.append(" a.f_type_name,");
			sql.append(" a.f_order ");
			sql.append("  from oa_file_files a");
			sql.append("  left join oa_file_files_acc c");
			sql.append("    on a.f_files_id = c.f_files_id");
			sql.append(" where a.f_files_id is not null");
			sql.append(" and a.f_flow_state ='2'");
			// 所属部门
			if (!StringUtil.nullOrBlank(bean.getF_dept_name())) {
				sql.append(" and a.F_dept_name like '%'||?||'%' ");
				conditionValues.add(bean.getF_dept_name());
			}
			// 所属单位
			if (!StringUtil.nullOrBlank(bean.getF_org_id())) {
				sql.append(" and a.F_org_id = ? ");
				conditionValues.add(bean.getF_org_id());
			}
			// 所属分类分类id
			if (!StringUtil.nullOrBlank(bean.getF_type_id())){
				sql.append(" and a.F_type_id in  ");
				sql.append(" ( select f_type_id");
				sql.append("  from oa_file_type");
				sql.append(" start with f_type_id = ?");
				sql.append(" connect by prior f_type_id = f_parent_type_id )");
				conditionValues.add(bean.getF_type_id());
			}
			// 保管期限
			if (!StringUtil.nullOrBlank(bean.getF_doc_deadline_name())) {
				sql
						.append(" and  instr(','||?||',',','||a.f_doc_deadline_name||',')>0 ");
				conditionValues.add(bean.getF_doc_deadline_name());
			}
			// 保管期限
			if (!StringUtil.nullOrBlank(bean.getF_doc_deadline())) {
				sql.append(" and  a.F_doc_deadline =?  ");
				conditionValues.add(bean.getF_doc_deadline());
			}

			// 档案年份
			if (!StringUtil.nullOrBlank(bean.getF_doc_year())) {
				sql.append(" and a.f_doc_year like '%'||?||'%' ");
				conditionValues.add(bean.getF_doc_year());
			}
			// 档案名称
			if (!StringUtil.nullOrBlank(bean.getF_files_title())) {
				sql.append(" and a.f_files_title like '%'||?||'%'  ");
				conditionValues.add(bean.getF_files_title());
			}
			// 案卷号
			if (!StringUtil.nullOrBlank(bean.getF_filesno())) {
				sql.append(" and a.f_filesno like '%'||?||'%'  ");
				conditionValues.add(bean.getF_filesno());
			}
			// 密级
			if (!StringUtil.nullOrBlank(bean.getF_secrecy_name())) {
				sql
						.append(" and instr(','||?||',',','||a.f_secrecy_name||',')>0 ");
				conditionValues.add(bean.getF_secrecy_name());
			}
			if(!StringUtil.nullOrBlank(bean.getF_files_state())){
				sql.append(" and a.F_files_state=? ");
				conditionValues.add(bean.getF_files_state());
			}

			//档号
			if(!StringUtil.nullOrBlank(bean.getF_files_no())){
				sql.append(" and a.F_files_no like '%'||?||'%'");
				conditionValues.add(bean.getF_files_no());
			} 
		    
			//归档日期开始时间
			if (!StringUtil.nullOrBlank(bean.getF_start_time())) {
				sql.append(" and a.F_file_time >= to_date(?,'yyyy-mm-dd')  ")
						.append(" and a.F_file_time is not null ");
				conditionValues.add(StringUtil.deNull(bean.getF_start_time()));
			}
			//归档日期结束时间
			if (!StringUtil.nullOrBlank(bean.getF_end_time())) {
				sql.append(" and a.F_file_time <= to_date(?,'yyyy-mm-dd') ")
						.append(" and a.F_file_time is not null ");
				conditionValues.add(StringUtil.deNull(bean.getF_end_time()));
			}
			
			//目录号
			if(!StringUtil.nullOrBlank(bean.getF_listno())){
				sql.append(" and a.f_listno = ?");
				conditionValues.add(bean.getF_listno());
			}
			//卷内件数
			if(!StringUtil.nullOrBlank(bean.getF_files_num())){
				sql.append(" and a.f_files_num = ? ");
				conditionValues.add(bean.getF_files_num());
			}
			if (!StringUtil.nullOrBlank(sortName)
					&& !StringUtil.nullOrBlank(sortOrder)) {
				sql.append(" order by " + sortName + " "
						+ sortOrder);
			}

			// 调父类的方法
			return queryToPagingBean(sql.toString(), offset, maxPagesize, conn, conditionValues);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			DbManager.closeConnection(conn);
		}
	}	
}
