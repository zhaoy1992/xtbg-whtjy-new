package com.chinacreator.xtbg.core.file.dao.imploracle;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.file.dao.FileFilesQueryDao;
import com.chinacreator.xtbg.core.file.entity.FileDocBean;
import com.chinacreator.xtbg.core.file.entity.FileFilesBean;
import com.chinacreator.xtbg.core.file.entity.FileFilesQueryBean;

/**
 * 
 *<p>Title:FileDocQueryDaoImpl.java</p>
 *<p>Description:档案查询</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Jul 23, 2013
 */
public class FileFilesQueryDaoImpl extends XtDbBaseDao implements FileFilesQueryDao {
	
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
	public PagingBean queryFileFilesListOther(FileFilesQueryBean bean,
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
			sql.append("       OFD.F_FILE_NO,");//档案号 档号
			sql.append("       nvl(counttt.countt,0)+nvl(countttt.countt,0) f_attach_id, ");//附件数量
			sql.append("       OFD.F_DOC_FONTSIZE,");//编号
			sql.append("       OFD.F_DOC_NAME,");//文件标题
			sql.append("       DECODE(OFD.f_Doc_State,");
			sql.append("       '0','待归档',");
			sql.append("       '1','不需归档',");
			sql.append("       '2','已归档',");
			sql.append("       '8','已移交',");
			sql.append("       '9','已销毁',f_Doc_State) f_Doc_State,");//档案状态
			sql.append("       OFD.F_FILE_QUANTITY,");
			sql.append("       OFD.F_DEPT_NAME,");//所属部门
			sql.append("       TO_CHAR(OFD.F_CREATOR_TIME, 'yyyy-MM-dd') F_CREATOR_TIME_STR,");//文件形成时间
			sql.append("       OFPP.F_FILE_DETAIL QUERY_PAGE,");
			sql.append("       ofd.f_file_num,");//库存
			sql.append("       TO_CHAR(f_file_formtime, 'yyyy-mm-dd') f_file_formtime,");
			sql.append("       ofd.f_burn_user_id,");
			sql.append("       ofpe.f_pan_id,");
			sql.append("       ofpe.f_specification,");
			sql.append("       ofpe.f_shooting_user,");
			sql.append("       ofpe.f_add,");
			sql.append("       ofpe.f_person,");
			sql.append("       ofpe.f_background,");
			sql.append("       OFFT.f_filesno,");
			sql.append("       OFDF.F_FILES_ID,");
			sql.append("       nvl(to_number(REGEXP_REPLACE(OFD.F_FILE_NO,'[^0-9]','')),0)  F_FILE_NO_order_col");
			
			sql.append("  FROM OA_FILE_DOC OFD");
			sql.append("  LEFT JOIN OA_FILE_DOCFILES OFDF");
			sql.append("    ON OFD.f_Doc_Id = OFDF.F_DOC_ID");
			sql.append("  LEFT JOIN OA_FILE_FILES OFFT");
			sql.append("    ON OFDF.F_FILES_ID = OFFT.F_FILES_ID");
			sql.append("  LEFT JOIN OA_FILE_TYPE OFT");
			sql.append("    ON OFD.F_TYPE_ID = OFT.F_TYPE_ID");
			sql.append("  LEFT JOIN OA_FILE_PROGRAM_PAGE OFPP");
			sql.append("    ON OFT.F_PROGRAM_ID = OFPP.F_PROGRAM_ID");
			sql.append("  LEFT JOIN oa_file_pan_ext ofpe ON OFD.f_doc_id = ofpe.f_doc_id");
			sql.append("  left join (select fpi.f_file_id, count(1) countt");
			sql.append("               from oa_file_photo_info fpi");
			sql.append("               inner join oa_fc_attach fa");
			sql.append("                  on fpi.f_attach_id = fa.djbh");
			sql.append("             group by fpi.f_file_id) counttt");
			sql.append("    on   ofd.f_doc_id = counttt.f_file_id");
			sql.append("  left join (select fpi.f_doc_id, count(1) countt");
			sql.append("               from oa_file_doc fpi");
			sql.append("               inner join oa_fc_attach fa");
			sql.append("                  on fpi.f_attach_id = fa.djbh");
			sql.append("             group by fpi.f_doc_id) countttt");
			sql.append("    on   ofd.f_doc_id = countttt.f_doc_id");
			if(StringUtil.nullOrBlank(bean.getF_org_id())){
				sql.append(" WHERE 1 = 0");
			}else{
				sql.append(" WHERE OFD.F_ORG_ID = ?");
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
				//9档号
				if (!StringUtil.nullOrBlank(bean.getF_file_no())) {
					sql.append(" AND OFD.F_file_no like '%'||?||'%'  ");
					conditionValues.add(bean.getF_file_no());						
				}
				if (!StringUtil.nullOrBlank(bean.getF_shooting_user())){
					sql.append(" and ofpe.f_shooting_user like '%"+bean.getF_shooting_user()+"%'");
				}
				if (!StringUtil.nullOrBlank(bean.getF_add())){
					sql.append(" and ofpe.f_ADD like '%"+bean.getF_add()+"%'");
				}
				//刻录人
				if (!StringUtil.nullOrBlank(bean.getF_burn_user_id())){
					sql.append(" and ofd.f_burn_user_id like '%"+bean.getF_burn_user_id()+"%'");
				}
				if (!StringUtil.nullOrBlank(sortName)
						&& !StringUtil.nullOrBlank(sortOrder)) {
					if("f_file_no".equals(sortName)){
						sortName ="F_FILE_NO_order_col";
					}
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

	@Override
	public PagingBean queryFileFilesListByDept(FileFilesBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();

			// 拼接的值
			List<String> conditionValues = new ArrayList<String>();
			StringBuffer sql = new StringBuffer();
			sql.append("select a.f_files_id,");
			sql.append("       a.f_files_title,");
			sql.append("       a.f_type_name,");
			sql.append("       a.f_files_no,");
			sql.append("       a.f_typeno,");
			sql.append("       a.f_fondsno,");
			sql.append("       a.f_filesno,");
			sql.append("       a.f_storage_fullname,");
			sql.append("       a.f_doc_year,");
			sql.append("       a.f_secrecy_id,");
			sql.append("       a.f_secrecy_name,");
			sql.append("       a.f_doc_deadline,");
			sql.append("       a.f_org_id,");
			sql.append("       a.f_org_name,");
			sql.append("       a.f_dept_id,");
			sql.append("       a.f_dept_name,");
			sql.append("       a.f_doc_blname,");
			sql.append("       a.f_files_num,");
			sql.append("       a.f_files_content,");
			sql.append("       a.f_files_state,");
			sql.append("       a.f_file_userid,");
			sql.append("       a.f_file_username,      ");
			sql.append("       a.f_listno, ");
			sql.append("       a.f_doc_deadline_name,");
			sql.append("       a.f_entity_type_name, ");
			sql.append("       a.f_entity_type,");
			sql.append("       a.f_files_state_name, ");
			sql.append("       a.f_doc_blid, ");
			sql.append("       a.f_type_id,   ");
			sql
					.append("       to_char(a.f_file_time, 'yyyy-mm-dd') as f_file_time,");
			sql
					.append("       '共' || c.f_file_monthbooktotal || '册 第' || c.f_file_monthbookindex || '册' as f_file_monthbookindex,");
			sql
					.append("       '自第' || c.f_file_startno || '号至' || c.f_file_endno || '号' as f_file_startno,");
			sql
					.append("       a.f_doc_year||'年'||c.f_file_month||'月' as f_file_month");
			sql.append("  from oa_file_files a");
			sql.append("  left join oa_file_files_acc c");
			sql.append("    on a.f_files_id = c.f_files_id");
			sql.append(" where a.f_files_id is not null");
			
			// 所属单位
			if (!StringUtil.nullOrBlank(bean.getF_org_id())) {
				sql.append(" and a.F_org_id = ? ");
				conditionValues.add(bean.getF_org_id());
			}
			// 所属单位
			if (!StringUtil.nullOrBlank(bean.getF_dept_id())) {
				sql.append(" and a.F_dept_id = ? ");
				conditionValues.add(bean.getF_dept_id());
			}
			if (!StringUtil.nullOrBlank(bean.getF_dept_name())) {
				sql.append(" and a.F_dept_name = ? ");
				conditionValues.add(bean.getF_dept_name());
			}
			// 所属分类分类id
			if (!StringUtil.nullOrBlank(bean.getF_type_id())) {
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
			// 档案年月
			if (!StringUtil.nullOrBlank(bean.getF_doc_year())) {
				sql.append(" and a.f_doc_year = ?  ");
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

			if (!StringUtil.nullOrBlank(sortName)
					&& !StringUtil.nullOrBlank(sortOrder)) {
				if("f_filesno".equals(sortName)){
					sortName = "f_doc_year desc,to_number(f_filesno)";
				}
				
				sql.append(" order by " + sortName + " "
						+ sortOrder);
			}

			// 调父类的方法
			return queryToPagingBean(sql.toString(), offset, maxPagesize, conn, conditionValues);
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 queryFileFilesDevolveInfoAddFilesList
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileFilesQueryDao#queryFileFilesDevolveInfoAddFilesList(com.chinacreator.xtbg.core.file.entity.FileFilesBean, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean queryFileFilesDevolveInfoAddFilesList(FileFilesBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();

			// 拼接的值
			List<String> conditionValues = new ArrayList<String>();
			StringBuffer sql = new StringBuffer();
			sql.append("select a.f_files_id,");
			sql.append("       a.f_files_title,");
			sql.append("       a.f_type_name, ");
			sql.append(" substr(a.f_type_name, ");
			sql.append("   decode(instr(a.f_type_name, '-->', 1, 1), ");
			sql.append("                  0, ");
			sql.append("                  0, ");
			sql.append(" instr(a.f_type_name, '-->', -1, 1) + 3), ");
			//导出专用类型名
			sql.append(" length(a.f_type_name) - instr(a.f_type_name, '-->', -1, 1)) as f_type_name_export,");
            sql.append("       a.f_files_no,");
			sql.append("       a.f_typeno,");
			sql.append("       a.f_fondsno,");
			sql.append("       a.f_filesno,");
			sql.append("       a.f_storage_fullname,");
			sql.append("       a.f_doc_year,");
			sql.append("       a.f_secrecy_id,");
			sql.append("       a.f_secrecy_name,");
			sql.append("       a.f_doc_deadline,");
			sql.append("       a.f_org_id,");
			sql.append("       a.f_org_name,");
			sql.append("       a.f_dept_id,");
			sql.append("       a.f_dept_name,");
			sql.append("       a.f_doc_blname,");
			sql.append("       a.f_files_num,");
			sql.append("       a.f_files_content,");
			sql.append("       a.f_files_state,");
			sql.append("       a.f_file_userid,");
			sql.append("       a.f_file_username, ");
			sql.append("       a.f_listno, ");
			sql.append("       a.f_doc_deadline_name,");
			sql.append("       a.f_entity_type_name, ");
			sql.append("       a.f_entity_type,");
			sql.append("       a.f_files_state_name, ");
			sql.append("       a.f_doc_blid, ");
			sql.append("       a.f_type_id,   ");
			sql
					.append("       to_char(a.f_file_time, 'yyyy-mm-dd') as f_file_time ");
			//增加当前用户是否该类型档案的分类管理员的字段0：不是，1：是	
			if (!StringUtil.nullOrBlank(bean.getF_file_userid())) {
//				sql.append(" ,(select decode(count(1),0,'0','1') from oa_file_type f ");
//				sql.append(" start with f.f_type_id= a.f_type_id ");			
//				sql .append(" connect by prior f.f_parent_type_id=f.f_type_id ");
//				sql.append("  and instr(','||f.f_type_admin||',',','||?||',')>0 ) as istypemanager ");
//				conditionValues.add(bean.getF_file_userid());
				
				sql.append(",(select decode(count(1),'0',0,'1') ");
				sql.append("          from oa_file_type f");
				sql.append("         start with f.f_type_id =  a.f_type_id");
				sql.append("        ");
				sql.append("        connect by prior f.f_parent_type_id = f.f_type_id");
				sql.append("               and instr(',' || f.f_type_admin || ',', ',' || ? || ',') > 0 )");
				
				sql.append("    as istypemanager1");
				sql.append(" ,(       select decode(count(1),'0',0,'1')  ");
				sql.append("          from oa_file_type f");
				sql.append("         start with f.f_type_id = a.f_type_id");
				sql.append("                and instr(',' || f.f_type_admin || ',', ',' || ? || ',') > 0");
				sql.append("        connect by prior f.f_parent_type_id = f.f_type_id");
				sql.append("               and instr(',' || f.f_type_admin || ',', ',' || ? || ',') > 0");
				sql.append("        ) as  istypemanager2 ");
				conditionValues.add(bean.getF_file_userid());
				conditionValues.add(bean.getF_file_userid());
				conditionValues.add(bean.getF_file_userid());
			}else{
				sql.append(" , '0' as istypemanager" );
			}
			
			sql.append("  from oa_file_files a");
			sql.append(" where a.f_files_id not in (select f_files_id from oa_file_files_acc) and  a.f_files_id is not null");
			sql.append("    and a.f_files_state = '1'");
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
			if(!StringUtil.nullOrBlank(bean.getF_type())){
				if("1".equals(bean.getF_type())){
					sql.append(" and a.f_type_id in (select oft.f_type_id from oa_file_type oft where oft.f_program_id = '"+FileDocBean.F_PROGRAM_ID_WEN_SHU+"') ");
				}else if("2".equals(bean.getF_type())){
					sql.append(" and a.f_type_id in (select oft.f_type_id from oa_file_type oft where oft.f_program_id = '"+FileDocBean.F_PROGRAM_ID_ZAHO_PIAN+"') ");
				}else if("3".equals(bean.getF_type())){
					sql.append(" and a.f_type_id in (select oft.f_type_id from oa_file_type oft where oft.f_program_id = '"+FileDocBean.F_PROGRAM_ID_SHI_PIN+"') ");
				}else if("4".equals(bean.getF_type())){
					sql.append(" and a.f_type_id in (select oft.f_type_id from oa_file_type oft where oft.f_program_id = '"+FileDocBean.F_PROGRAM_ID_GUANG_PAN+"') ");
				}
			}
			if(!StringUtil.nullOrBlank(bean.getF_files_id())){
				sql.append(" and a.f_files_id not in ("+bean.getF_files_id()+")");
			}
			sql.append(" and a.f_files_id not in (select f_files_id from oa_files_devolve_detail)");
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
}
