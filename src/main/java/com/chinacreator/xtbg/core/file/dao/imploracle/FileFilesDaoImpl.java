package com.chinacreator.xtbg.core.file.dao.imploracle;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.sysmgrcore.manager.db.OrgCacheManager;
import com.chinacreator.xtbg.core.common.commonlist.PageInfoBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.file.dao.FileFilesDao;
import com.chinacreator.xtbg.core.file.dao.FileFirstPageDao;
import com.chinacreator.xtbg.core.file.entity.FileDocBean;
import com.chinacreator.xtbg.core.file.entity.FileFilesBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:FileFilesDaoImpl.java</p>
 *<p>Description:档案管理数据库操作接口实现类</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-7-15
 */
public class FileFilesDaoImpl extends XtDbBaseDao implements FileFilesDao,FileFirstPageDao{

	/**
	  * 
	  * <b>Summary: </b>
	  *     复写方法 findFilesPageBean
	  * @param bean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.file.dao.FileFilesDao#findFilesPageBean(com.chinacreator.xtbg.core.file.entity.FileFilesBean, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean findFilesPageBean(FileFilesBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
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
			sql.append("       a.f_file_username,");			
			sql.append("       a.f_listno,");		//目录号
			sql.append("       a.f_doc_deadline_name,");		//保管期限id
			sql.append("       a.f_entity_type_name,");		//实物类型name
			sql.append("       a.f_entity_type,");		//实物类型
			sql.append("       a.f_files_state_name,");		//案卷状态名
			sql.append("       to_char(a.f_start_time,'yyyy-mm-dd') as f_start_time,");		//起始日期（档案的最早形成日期）
			sql.append("       to_char(a.f_end_time,'yyyy-mm-dd') as f_end_time,");		//终止日期（档案的最后修改日期）
			sql.append("       a.f_doc_blid,");		//责任者id
			sql.append("       a.f_type_id,");		//所属分类id			
			sql.append("       to_char(a.f_file_time,'yyyy-mm-dd') as f_file_time");
			sql.append("  from oa_file_files a where a.f_files_id is not null ");
			
			//所属部门id
			if(!StringUtil.nullOrBlank(bean.getF_dept_name() )){
				sql.append(" and a.F_dept_name like '%'||?||'%' ");
				conditionValues.add(bean.getF_dept_name());
			}
			//所属单位
			if(!StringUtil.nullOrBlank(bean.getF_org_id())){
				sql.append(" and a.F_org_id = ? ");
				conditionValues.add(bean.getF_org_id());
			}			
			//所属分类分类id
			if(!StringUtil.nullOrBlank(bean.getF_type_id())){
				sql.append(" and a.F_type_id in  ");
				sql.append(" ( select f_type_id");
				sql.append("  from oa_file_type");
				sql.append(" start with f_type_id = ?");
				sql.append(" connect by prior f_type_id = f_parent_type_id )");
				conditionValues.add(bean.getF_type_id());
			}
            //保管期限
			if (!StringUtil.nullOrBlank(bean.getF_doc_deadline_name())) {
				sql.append(" and  instr(','||?||',',','||a.f_doc_deadline_name||',')>0 ");
				conditionValues.add(bean.getF_doc_deadline_name());
			}
			//档案年份
			if (!StringUtil.nullOrBlank(bean.getF_doc_year())) {
				sql.append(" and a.f_doc_year like '%'||?||'%'  ");
				conditionValues.add(bean.getF_doc_year());
			}
			//档案名称
			if (!StringUtil.nullOrBlank(bean.getF_files_title())) {
				sql.append(" and a.f_files_title like '%'||?||'%'  ");
				conditionValues.add(bean.getF_files_title());
			}
			//案卷号
			if (!StringUtil.nullOrBlank(bean.getF_filesno())) {
				sql.append(" and a.f_filesno like '%'||?||'%'  ");
				conditionValues.add(bean.getF_filesno());						
			}
			//密级
			if (!StringUtil.nullOrBlank(bean.getF_secrecy_name())) {
				sql.append(" and instr(','||?||',',','||a.f_secrecy_name||',')>0 ");
				conditionValues.add(bean.getF_secrecy_name());						
			}
			
			if (!StringUtil.nullOrBlank(sortName)
					&& !StringUtil.nullOrBlank(sortOrder)) {
				sql.append(" order by " + sortName + " " + sortOrder);
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
		*<b>Summary: 根据字典类型编号查询对应的记录</b>
		* queryDictByCode()
		* @param code  编号
		* @return   List<Map<String,String>>形式的字典数据
		* @throws Exception
		 */
	public List<Map<String, String>> queryDictByCode(String code)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();

			StringBuffer sql = new StringBuffer();
			sql.append("select dictdata_id,");
			sql.append("       dict_id,");
			sql.append("       dictdata_parent_id,");
			sql.append("       dictdata_name,");
			sql.append("       dictdata_value,");
			sql.append("       dictdata_remark,");
			sql.append("       dictdata_is_valid,");
			sql.append("       dictdata_order");
			sql.append("  from oa_dict_data a");
			sql.append(" where exists (select DICT_ID");
			sql.append("          from oa_dict_type b");
			sql.append("         where a.dict_id = b.dict_id");
			sql.append("           and b.dict_code = ?");
			sql.append("           and b.dict_is_valid = '1')");
			sql.append("   and a.dictdata_is_valid = '1'");
			sql.append(" order by dictdata_order");
			return queryToListMap(sql.toString(), conn, code);
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	/**
	 * 
	*<b>Summary: 根据单位id查询全宗号列表</b>
	* queryListFondsno()
	* @param orgId
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryListFondsno(String orgId)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			List<String> condition = new ArrayList<String>();
			sql.append(" select f_fonds_id,");
			sql.append("        f_fondsno_name,");
			sql.append("        f_fondsno,");
			sql.append("        f_fonds_remark,");
			sql.append("        f_fonds_order,");
			sql.append("        f_org_id,");
			sql.append("        f_org_name,");
			sql.append("        f_dept_id,");
			sql.append("        f_dept_name");
			sql.append("   from oa_file_fondsno where f_fonds_id is not null ");
			if (!StringUtil.nullOrBlank(orgId)) {
				sql.append(" and f_org_id = ?");
				condition.add(orgId);
			}
			sql.append(" order by f_fonds_order asc ");
			return queryToListMap(sql.toString(), conn, condition);
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findDocPageBeanForFiles
	  * @param map
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.file.dao.FileFilesDao#findDocPageBeanForFiles(java.util.Map)
	 */
	public PagingBean findDocPageBeanForFiles(Map<String,String> map) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			
			// 拼接的值
			List<String> conditionValues = new ArrayList<String>();
			StringBuffer sql = new StringBuffer();
			sql.append("select d.f_doc_name,");
			sql.append("         d.f_doc_fontsize,d.f_doc_id,");
			sql.append("         d.f_type_id,");
			sql.append("         d.f_type_name,");
			sql.append("         d.f_doc_keywords,");
			sql.append("         d.f_doc_year,");
			sql.append("         d.f_secrecy_id,");
			sql.append("         d.f_secrecy_name,");
			sql.append("         decode(substr(d.f_secrecy_name,0,1),'普','',substr(d.f_secrecy_name,0,1)) as f_secrecy_name4export,");
			sql.append("         d.f_org_id,");
			sql.append("         d.f_org_name,");
			sql.append("         d.f_dept_id,");
			sql.append("         d.f_dept_name,");
			sql.append("         d.f_doc_checkuser,");
			sql.append("         d.f_doc_blname,");
			sql.append("        to_char(d.f_file_formtime,'yyyy-mm-dd') as f_file_formtime,");
			sql.append("        to_char(d.f_file_formtime,'yyyymmdd') as f_file_formtime4export,");
			sql.append("         d.f_file_quantity,");
			sql.append("         d.f_type_remark,");
			sql.append("         d.f_user_id,");
			sql.append("         d.f_user_name,");
			sql.append("         d.f_creator_time,");
			sql.append("         d.f_doc_content,");
			sql.append("         d.f_attach_id,");
			sql.append("         d.f_doc_state,");
			sql.append("         d.f_doc_state_name,");
			sql.append("         d.f_file_no,");
			sql.append("         d.f_typeno,");
			sql.append("         d.f_doc_num,");
			sql.append("         d.f_info_num,");
			sql.append("         d.f_doc_media,");
			sql.append("         d.f_doc_media_name,");
			sql.append("         d.f_entity_type,");
			sql.append("         d.f_entity_type_name,");
			sql.append("         d.f_burn_user_id,");
			sql.append("         d.f_burn_user_name,");
			sql.append("         d.f_file_num,");
			sql.append("         d.f_doc_deadline,");
			sql.append("         d.f_file_userid,");
			sql.append("         d.f_file_username,");
			sql.append("         d.f_file_time,");
			sql.append("         d.f_info_type,");
			sql.append("         d.f_info_type_name,");
			sql.append("         d.f_file_num_unit,");
			sql.append("         d.f_file_num_unit_name,");
			sql.append("         d.f_doc_deadline_name,");
			sql.append("  f.f_docfiles_id, f.f_files_id,");
			sql.append("  e.f_pan_id,");
			sql.append("              e.f_specification,");
			sql.append("              e.f_shooting_user,");
			sql.append("              e.f_add,");
			sql.append("              e.f_person,");
			sql.append("              e.f_background,");
			sql.append("    nvl((select count(1) from oa_file_photo_info ofpi where ofpi.F_FILE_ID = d.f_doc_id),0) photo_num");
			sql.append("    from oa_file_doc d");
			sql.append("   inner join oa_file_docfiles f ");
			sql.append("      on d.f_doc_id = f.f_doc_id ");
			sql.append("    left join oa_file_pan_ext e ");
			sql.append("      on d.f_doc_id = e.f_doc_id ");
			sql.append("   where d.f_doc_id is not null ");
			if(!StringUtil.nullOrBlank(map.get("filesId"))){
				sql.append("   and f.f_files_id = ?");
				conditionValues.add(map.get("filesId"));
			}
			if (!StringUtil.nullOrBlank(map.get("sortName"))
					&& !StringUtil.nullOrBlank(map.get("sortOrder"))) {
				sql.append(" order by " + map.get("sortName") + " " + map.get("sortOrder"));
			}
			
			// 调父类的方法
			return queryToPagingBean(sql.toString(), Long.valueOf(map.get("offset")),Integer.valueOf(map.get("maxPagesize")), conn,
					conditionValues);
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	/**
	 * 
	*<b>Summary: 入卷时进行查询</b>
	* findDocPageBean4AddToFile()
	* @param bean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findDocPageBean4AddToFile(FileDocBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();			
			// 拼接的值
			List<String> conditionValues = new ArrayList<String>();
			StringBuffer sql = new StringBuffer();
			sql.append(" select d.f_doc_id,");
			sql.append("        d.f_doc_name,");
			sql.append("        d.f_doc_fontsize,");
			sql.append("        d.f_type_id,");
			sql.append("        d.f_type_name,");
			sql.append("        d.f_doc_keywords,");
			sql.append("        d.f_doc_year,");
			sql.append("        d.f_secrecy_id,");
			sql.append("        d.f_secrecy_name,");
			sql.append("        d.f_org_id,");
			sql.append("        d.f_org_name,");
			sql.append("        d.f_dept_id,");
			sql.append("        d.f_dept_name,");
			sql.append("        d.f_doc_checkuser,");
			sql.append("        d.f_doc_blname,");
			sql.append("        to_char(d.f_file_formtime,'yyyy-mm-dd') as f_file_formtime,");
			sql.append("        d.f_file_quantity,");
			sql.append("        d.f_type_remark,");
			sql.append("        d.f_user_id,");
			sql.append("        d.f_user_name,");
			sql.append("        d.f_creator_time,");
			sql.append("        d.f_doc_content,");
			sql.append("        d.f_attach_id,");
			sql.append("        d.f_doc_state,");
			sql.append("        d.f_doc_state_name,");
			sql.append("        d.f_file_no,");
			sql.append("        d.f_typeno,");
			sql.append("        d.f_doc_num,");
			sql.append("        d.f_info_num,");
			sql.append("        d.f_doc_media,");
			sql.append("        d.f_doc_media_name,");
			sql.append("        d.f_entity_type,");
			sql.append("        d.f_entity_type_name,");
			sql.append("        d.f_burn_user_id,");
			sql.append("        d.f_burn_user_name,");
			sql.append("        d.f_file_num,");
			sql.append("        d.f_doc_deadline,");
			sql.append("        d.f_file_userid,");
			sql.append("        d.f_file_username,");
			sql.append("        d.f_file_time,");
			sql.append("        d.f_info_type,");
			sql.append("        d.f_info_type_name,");
			sql.append("        d.f_file_num_unit,");
			sql.append("        d.f_file_num_unit_name,");
			sql.append("        d.f_doc_deadline_name,");
			sql.append("  e.f_pan_id,");
			sql.append("              e.f_specification,");
			sql.append("              e.f_shooting_user,");
			sql.append("              e.f_add,");
			sql.append("              e.f_person,");
			sql.append("              e.f_background");
			sql.append("   from oa_file_doc d left join oa_file_pan_ext e");
			sql.append("     on e.f_doc_id = d.f_doc_id ");
			sql.append(" where d.f_doc_state = '0'  and  (d.f_flow_state='3' or d.f_flow_state is null)");			
			if(!StringUtil.nullOrBlank(bean.getF_type_id())){
				sql.append("   and d.f_type_id = ? ");
				conditionValues.add(bean.getF_type_id());
			}
			if(!StringUtil.nullOrBlank(bean.getF_doc_year())){
				sql.append("   and d.F_DOC_YEAR = ? ");
				conditionValues.add(bean.getF_doc_year());
			}
			if(!StringUtil.nullOrBlank(bean.getF_doc_deadline())){
				sql.append("   and d.F_DOC_DEADLINE = ? ");
				conditionValues.add(bean.getF_doc_deadline());
			}
			if(!StringUtil.nullOrBlank(bean.getF_doc_name())){
				sql.append("   and d.f_doc_name like '%'||?||'%' ");
				conditionValues.add(bean.getF_doc_name());
			}
			if(!StringUtil.nullOrBlank(bean.getF_dept_name())){
				sql.append(" and d.f_dept_name like '%'||?||'%'");
				conditionValues.add(bean.getF_dept_name());
			}
			if(!StringUtil.nullOrBlank(bean.getF_org_id())){//所属单位
				sql.append("   and d.F_org_id = ? ");
				conditionValues.add(bean.getF_org_id());
			}			
			if (!StringUtil.nullOrBlank(sortName) && !StringUtil.nullOrBlank(sortOrder)) {
				sql.append(" order by " + sortName + " " +sortOrder);
			}			
			// 调父类的方法
			return queryToPagingBean(sql.toString(), offset,maxPagesize, conn,
					conditionValues);
		} finally {
			DbManager.closeConnection(conn);
		}
	}

    /**
     * 
      * <b>Summary: </b>
      *     复写方法 updateListFiles
      * @param map
      * @param conn
      * @throws Exception 
      * @see com.chinacreator.xtbg.core.file.dao.FileFilesDao#updateListFiles(java.util.Map, java.sql.Connection)
     */
	public void updateListFiles(Map<String,Object> map,Connection conn) throws Exception{
		
		StringBuffer sql = new StringBuffer();
		List<String> condition = new ArrayList<String>();
		//要更新的bean
		FileFilesBean bean = (FileFilesBean)map.get("bean");
		sql.append("update oa_file_files set ");
		//档案存放位置
		if(null != bean.getF_storage_fullname()){
			sql.append(" f_storage_fullname = ? ,");
			condition.add(bean.getF_storage_fullname());
		}
		if(null != bean.getF_doc_deadline()){
			sql.append(" f_doc_deadline = ? ,");
			condition.add(bean.getF_doc_deadline());
		}
		if(null != bean.getF_doc_deadline_name()){
			sql.append(" f_doc_deadline_name = ? ,");
			condition.add(bean.getF_doc_deadline_name());
		}
		if(null != bean.getF_type_name()){
			sql.append(" f_type_name = ? ,");
			condition.add(bean.getF_type_name());
		}
		if(null != bean.getF_type_id()){
			sql.append(" f_type_id = ? ,");
			condition.add(bean.getF_type_id());
		}
		if(null != bean.getF_typeno()){
			sql.append(" f_typeno = ? ,");
			condition.add(bean.getF_typeno());
		}
		if(null != bean.getF_fondsno()){
			sql.append(" f_fondsno = ? ,");
			condition.add(bean.getF_fondsno());
		}
		if(null != bean.getF_secrecy_id()){
			sql.append(" f_secrecy_id = ? ,");
			condition.add(bean.getF_secrecy_id());
		}
		if(null != bean.getF_secrecy_name()){
			sql.append(" f_secrecy_name = ? ,");
			condition.add(bean.getF_secrecy_name());
		}
		if(null != bean.getF_doc_blname()){
			sql.append(" f_doc_blname = ? ,");
			condition.add(bean.getF_doc_blname());
		}
		if(null != bean.getF_doc_blid()){
			sql.append(" f_doc_blid = ? ,");
			condition.add(bean.getF_doc_blid());
		}

		if(null != bean.getF_dept_id()){
			sql.append(" f_dept_id = ? ,");
			condition.add(bean.getF_dept_id());
		}
		if(null != bean.getF_dept_name()){
			sql.append(" F_dept_name = ? ,");
			condition.add(bean.getF_dept_name());
		}
		if(null != bean.getF_file_time()){
			if(StringUtil.nullOrBlank(bean.getF_file_time())){
				sql.append(" f_file_time = null, ");
			}else{
				sql.append(" f_file_time = to_date(?,'yyyy-mm-dd') ,");
				condition.add(bean.getF_file_time().toString());
			}
		}
		
		//存在要被修改的项，则截掉字符串
		sql.deleteCharAt(sql.length()-1);
		sql.append(" where f_files_id  is not null ");
		
		//查询条件
		FileFilesBean searchBean = (FileFilesBean)map.get("search");
		String ids = StringUtil.deNull(map.get("ids"));
		if(!StringUtil.nullOrBlank(ids)){
			sql.append( " and instr (','||?||',',','||f_files_id||',') >0 ");
			
			condition.add(ids.replaceAll("'", ""));
		}else if(null != searchBean){
			//所属单位
			if(!StringUtil.nullOrBlank(searchBean.getF_org_id())){
				sql.append(" and F_org_id =? ");
				condition.add(searchBean.getF_org_id());
			}	
			//所属分类分类id
			if(!StringUtil.nullOrBlank(searchBean.getF_type_id())){
				sql.append(" and f_type_id in  ");
				sql.append(" ( select f_type_id");
				sql.append("  from oa_file_type");
				sql.append(" start with f_type_id = ?");
				sql.append(" connect by prior f_type_id = f_parent_type_id )");
                condition.add(searchBean.getF_type_id());
                
			}
            //保管期限
			if (!StringUtil.nullOrBlank(searchBean.getF_doc_deadline())) {
				sql.append(" and  instr(','||?||',',','||f_doc_deadline||',')>0 ");
				condition.add(searchBean.getF_doc_deadline());
			}
			//档案年份
			if (!StringUtil.nullOrBlank(searchBean.getF_doc_year())) {
				sql.append(" and f_doc_year like '%'||?||'%'  ");
				condition.add(searchBean.getF_doc_year());
			}
			//档案名称
			if (!StringUtil.nullOrBlank(searchBean.getF_files_title())) {
				sql.append(" and f_files_title like '%'||?||'%'  ");
				condition.add(searchBean.getF_files_title());
			}
			//案卷号
			if (!StringUtil.nullOrBlank(searchBean.getF_filesno())) {
				sql.append(" and f_filesno like '%'||?||'%'  ");
				condition.add(searchBean.getF_filesno());						
			}
			//密级
			if (!StringUtil.nullOrBlank(searchBean.getF_secrecy_name())) {
				sql.append(" and instr(','||?||',',','||f_secrecy_name||',')>0 ");
				condition.add(searchBean.getF_secrecy_name());						
			}
			
			//所属部门
			if (!StringUtil.nullOrBlank(searchBean.getF_dept_name())) {
				sql.append(" and F_dept_name like '%'||?||'%' ");
				condition.add(searchBean.getF_dept_name());
			}
			
			
			if(!StringUtil.nullOrBlank(searchBean.getF_files_state())){
				sql.append(" and F_files_state=? ");
				condition.add(searchBean.getF_files_state());
			}

			//档号
			if(!StringUtil.nullOrBlank(searchBean.getF_files_no())){
				sql.append(" and F_files_no like '%'||?||'%'");
				condition.add(searchBean.getF_files_no());
			} 
		    
			//归档日期开始时间
			if (!StringUtil.nullOrBlank(searchBean.getF_start_time())) {
				sql.append(" and F_file_time >= to_date(?,'yyyy-mm-dd')  ")
						.append(" and F_file_time is not null ");
				condition.add(StringUtil.deNull(searchBean.getF_start_time()));
			}
			//归档日期结束时间
			if (!StringUtil.nullOrBlank(searchBean.getF_end_time())) {
				sql.append(" and F_file_time <= to_date(?,'yyyy-mm-dd') ")
						.append(" and F_file_time is not null ");
				condition.add(StringUtil.deNull(searchBean.getF_end_time()));
			}
			//案卷题名
			if(!StringUtil.nullOrBlank(searchBean.getF_files_title())){
				sql.append(" and f_files_title like '%'||?||'%'");
				condition.add(searchBean.getF_files_title());
			} 
						
			//目录号
			if(!StringUtil.nullOrBlank(searchBean.getF_listno())){
				sql.append(" and f_listno = ?");
				condition.add(searchBean.getF_listno());
			}
			//卷内件数
			if(!StringUtil.nullOrBlank(searchBean.getF_files_num())){
				sql.append(" and f_files_num = ? ");
				condition.add(searchBean.getF_files_num());
			}
		}
		
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		//预编译赋值
		for(int i=0;i<condition.size();i++){
			pdb.setString(i+1, condition.get(i));
		} 
		pdb.executePrepared(conn);
	}
	

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateListDoc
	  * @param map
	  * @param conn
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.file.dao.FileFilesDao#updateListDoc(java.util.Map, java.sql.Connection)
	 */
	public void updateListDoc(Map<String, Object> map, Connection conn)
			throws Exception {

		StringBuffer sql = new StringBuffer();
		List<String> condition = new ArrayList<String>();
		// 要更新的bean
		FileDocBean bean = (FileDocBean) map.get("bean");
		sql.append("update oa_file_doc set ");
		// 审核人
		if (null != bean.getF_doc_checkuser()) {
			sql.append(" f_doc_checkuser = ? ,");
			condition.add(bean.getF_doc_checkuser());
		}
		// 保管期限
		if (null != bean.getF_doc_deadline()) {
			sql.append(" f_doc_deadline = ? ,");
			condition.add(bean.getF_doc_deadline());
		}
		if(null != bean.getF_doc_deadline_name()){
			sql.append(" f_doc_deadline_name = ?,");
			condition.add(bean.getF_doc_deadline_name());
		}
		// 介质类型
		if (null != bean.getF_doc_media()) {
			sql.append(" f_doc_media = ? ,");
			condition.add(bean.getF_doc_media());
		}
		if (null != bean.getF_doc_media_name()) {
			sql.append(" f_doc_media_name = ? ,");
			condition.add(bean.getF_doc_media_name());
		}
		// 责任者
		if (null != bean.getF_doc_blname()) {
			sql.append(" f_doc_blname = ? ,");
			condition.add(bean.getF_doc_blname());
		}
		//密级
		if(null!=bean.getF_secrecy_id()){
			sql.append(" F_secrecy_id = ? ,");
			condition.add(bean.getF_secrecy_id());
		}
		if(null!=bean.getF_secrecy_name()){
			sql.append(" F_secrecy_name = ? ,");
			condition.add(bean.getF_secrecy_name());
		}
		if(null != bean.getF_dept_id()){
			sql.append(" f_dept_id = ? ,");
			condition.add(bean.getF_dept_id());
		}
		if(null != bean.getF_dept_name()){
			sql.append(" F_dept_name = ? ,");
			condition.add(bean.getF_dept_name());
		}
		// 存在要被修改的项，则截掉字符串
		sql.deleteCharAt(sql.length() - 1);
		sql.append(" where f_doc_id  is not null ");

		// 查询条件
		String ids = StringUtil.deNull(map.get("ids"));// 文件id集合
		if (!StringUtil.nullOrBlank(ids)) {
			sql.append(" and instr (','||?||',',','||f_doc_id||',') >0 ");

			condition.add(ids.replaceAll("'", ""));
		} else {
			String fileId = StringUtil.deNull(map.get("fileId"));// 档案id
			// 档案id
			if (!StringUtil.nullOrBlank(fileId)) {
				sql.append(" and f_doc_id in ");
				sql.append("       (select f_doc_id from oa_file_docfiles ");
				sql.append(" where f_files_id = ? ) ");
				condition.add(fileId);
			}
			// 机构id 

		}

		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		// 预编译赋值
		for (int i = 0; i < condition.size(); i++) {
			pdb.setString(i + 1, condition.get(i));
		}
		pdb.executePrepared(conn);
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryProgramByTypeId
	  * @param typeId
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.file.dao.FileFilesDao#queryProgramByTypeId(java.lang.String, java.sql.Connection)
	 */
	public Map<String, String> queryProgramByTypeId(String typeId,
			Connection conn) throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select b.f_program_id,");
		sql.append("       b.f_program_page,");
		sql.append("       b.f_file_list,");
		sql.append("       b.f_file_detail,");
		sql.append("       b.f_files_list,");
		sql.append("       b.f_files_detail,");
		sql.append("       b.f_order,");
		sql.append("       b.f_remark");
		sql.append("  from oa_file_program_page b");
		sql.append(" where exists");
		sql.append(" (select f_program_id");
		sql.append("          from oa_file_type t");
		sql .append("  where b.f_program_id=t.f_program_id and t.f_type_id = ?)");
		viewMap = queryToSingleMap(conn, sql.toString(), StringUtil
				.deNull(typeId));

		return viewMap;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findFilesPageBean4acc
	  * @param bean
	  * @param page
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.file.dao.FileFilesDao#findFilesPageBean4acc(com.chinacreator.xtbg.core.file.entity.FileFilesBean, com.chinacreator.xtbg.core.common.commonlist.PageInfoBean)
	 */
	public PagingBean findFilesPageBean4acc(FileFilesBean bean,
			PageInfoBean page) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();

			// 拼接的值
			List<String> conditionValues = new ArrayList<String>();
			StringBuffer sql = new StringBuffer();
			sql.append("select a.f_order,a.f_files_id,");
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
					.append("       to_char(a.f_file_time, 'yyyy-mm-dd') as f_file_time,");
			sql
					.append("       '共' || c.f_file_monthbooktotal || '册 第' || c.f_file_monthbookindex || '册' as f_file_monthbookindex,");
			sql
					.append("       '自第' || c.f_file_startno || '号至' || c.f_file_endno || '号' as f_file_startno,");
			sql
					.append("       a.f_doc_year||'年'||c.f_file_month||'月'  as f_file_month");
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
			sql.append("  left join oa_file_files_acc c");
			sql.append("    on a.f_files_id = c.f_files_id");
			sql.append(" where a.f_files_id is not null");
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
			if(!StringUtil.nullOrBlank(bean.getUserRole())){
				if("dept".equals(bean.getUserRole())){
					sql.append(" and (a.f_flow_state = '1' or a.f_flow_state = '0') ");
				}else if("org".equals(bean.getUserRole())){
					sql.append(" and (a.f_flow_state is null or a.f_flow_state='3') ");
				}
			}
			if (!StringUtil.nullOrBlank(page.getSortName())
					&& !StringUtil.nullOrBlank(page.getSortOrder())) {
				sql.append(" order by " + page.getSortName() + " "
						+ page.getSortOrder());
			}
			
			// 调父类的方法
			return queryToPagingBean(sql.toString(), page.getOffset(), page
					.getRows(), conn, conditionValues);
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	*<b>Summary: 根据配置的备考表模板查询键值对信息</b>
	* queryDictDataByTemp()
	* @param temp      
	* @param dictTypeId
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String,String>> queryDictDataByTemp(String temp,String dictTypeId,Connection conn) throws Exception {
		
			StringBuffer sql = new StringBuffer();
			sql.append("select dictdata_name,dictdata_value, dictdata_remark ");
			sql.append("  from oa_dict_data");
			sql.append(" where '" + temp
					+ "' like '%【' || dictdata_name || '】%'");
			// 字典类型为“备考表模板参数”的id
			sql.append("   and dict_id = ?");
			return super.queryToListMap(sql.toString(), conn,dictTypeId);
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryTables
	  * @param id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.file.dao.FileFilesDao#queryTables(java.lang.String, java.sql.Connection)
	 */
	public List<Map<String,String>> queryTables(String id,Connection conn) throws Exception{
		// 拼接的值
		List<String> conditionValues = new ArrayList<String>();
		StringBuffer sql = new StringBuffer();
		sql.append(" select table_code");
		sql.append("   from oa_md_table");
		sql.append("  where table_id = ?");
		sql.append(" union all");
		sql.append(" select table_code");
		sql.append("   from oa_md_table");
		sql.append("  where parent_table_id = ?");
		
		//添加预编译的值
		conditionValues.add(id);
		conditionValues.add(id);
		return super.queryToListMap(sql.toString(), conn,conditionValues);
		
	}
	
	/**
	 * 
	*<b>Summary: 根据档案表或者档案扩展表的表名以及档案id查询数据</b>
	* queryByTableName()
	* @param table   表名
	* @param filesId 档案id 
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> queryByTableName(String table, String filesId,Connection conn) throws Exception {
		if (StringUtil.nullOrBlank(table) || StringUtil.nullOrBlank(filesId)) {
			return new HashMap<String, String>();
		}
		StringBuffer sql = new StringBuffer();
		sql.append(" select *");
		sql.append("   from " + table);
		sql.append("  where f_files_id = ?");
		return super.queryToSingleMap(conn, sql.toString(), filesId);
	}
	
	/**
	 * 
	*<b>Summary:根据档案的档号生成文件档号，文件档号为档案档号+“_件号” </b>
	* createDocFileno()
	* @param fileno
	 * @throws Exception 
	 */
	public void updateDocFileno(String filesId, String fileno, Connection conn)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("UPDATE OA_FILE_DOC");
		sql.append("   SET F_FILE_NO = ? || '_' || F_DOC_NUM");
		sql.append(" WHERE F_DOC_ID IN");
		sql.append("       (SELECT B.F_DOC_ID");
		sql.append("          FROM OA_FILE_DOCFILES B");
		sql.append("         WHERE B.F_FILES_ID = ?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, fileno);
		pdb.setString(2, filesId);
		pdb.executePrepared(conn);
	}

	/**
	 * 
	*<b>Summary:更新照片的档号 (照片的档号等于要入档的档案档号+组号+照片号)</b>
	* updateDocFileno4pic()
	* @param filesId  档案id
	* @param fileno   档号
	* @param conn     数据库连接对象
	* @throws Exception
	 */
	public void updateDocFileno4pic(String filesId, String fileno,
			Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("update OA_FILE_PHOTO_INFO a");
		sql.append("   set f_dang_no = (?|| '_' ||");
		sql.append("(select max(c.F_DOC_NUM)");
		sql.append("                      from oa_file_doc c");
		sql.append("                     where a.f_file_id = c.f_doc_id)||'_'|| a.f_no)");
		sql.append(" where exists (select b.f_doc_id");
		sql.append("          from oa_file_docfiles b");
		sql.append("         where a.f_file_id = b.f_doc_id");
		sql.append("         and b.f_files_id=?");
		sql.append("           )");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, fileno);
		pdb.setString(2, filesId);
		pdb.executePrepared(conn);
	}
	/**
	 * 
	*<b>Summary:根据档案id查询该档案类的照片详情，用于 导出</b>
	* queryDocTip()
	* @param filesId
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String,String>> queryDocDesc4Export(String filesId,
			Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select d.f_title as f_title,");
		sql.append(" c.f_doc_num || '-' || d.f_no as f_no,");
		// 已归档，则参见号为 案卷号+件号
		sql.append(" d.f_cj_no,");
		sql.append(" to_char(c.f_file_formtime, 'yyyy-mm-dd')");
		sql.append(" as f_file_formtime,");

		sql.append("        to_char(c.f_file_formtime,'yyyymmdd') as f_file_formtime4export,");
		sql.append(" f_shooting_user,");
		sql.append(" c.f_doc_content || ' ' || d.f_explain ");
		sql.append("|| '(' || e.f_add||')' as f_doc_content_pic, ");
        sql.append(" d.f_title,");
        sql.append("         decode(substr(c.f_secrecy_name,0,1),'普','',substr(c.f_secrecy_name,0,1)) as f_secrecy_name4export,");
		
        sql.append(" d.f_explain,");
        sql.append(" (select max(f.djsn||'.jpg') from oa_fc_attach f where trim(f.djbh) = trim(d.f_attach_id)) as fileurl ");
        sql.append("  from oa_file_files      a,");
		sql.append("       oa_file_docfiles   b,");
		sql.append("       oa_file_photo_info d,");
		sql.append("       oa_file_doc        c");
		sql.append("  left join oa_file_pan_ext e");
		sql.append("    on c.f_doc_id = e.f_doc_id");
		sql.append(" where a.f_files_id = b.f_files_id");
		sql.append("   and b.f_doc_id = c.f_doc_id");
		sql.append("   and c.f_doc_id = d.f_file_id");
		sql.append("   and a.f_files_id = ? ");
		sql.append(" order by c.f_doc_num asc, d.f_no asc ");
		return super.queryToListMap(sql.toString(), conn, filesId);
	}
	
	/**
	 * 
	*<b>Summary:根据档案id查询该档案内的光盘详情，用于 导出</b>
	* queryDocTip()
	* @param filesId
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String,String>> queryDocDesc4ExportDisk(String filesId,
			Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select a.f_fondsno,");
		sql.append("       a.f_listno,");
		sql.append("       a.f_typeno,");
		sql.append("       a.f_filesno,");
		sql.append("       c.f_doc_num,");
		sql.append("       c.f_doc_name,");
		sql.append("       c.f_burn_user_id,");
		sql.append("         decode(substr(c.f_secrecy_name,0,1),'普','',substr(c.f_secrecy_name,0,1)) as f_secrecy_name4export,");
		
		sql.append("       f_shooting_user,");
		sql.append("        to_char(c.f_file_formtime,'yyyymmdd') as f_file_formtime4export,");
		sql.append("       to_char(c.f_file_formtime, 'yyyy-mm-dd') as f_file_formtime");
		sql.append("  from oa_file_files a, oa_file_docfiles b, oa_file_doc c");
		sql.append("  left join oa_file_pan_ext e");
		sql.append("    on c.f_doc_id = e.f_doc_id");
		sql.append(" where a.f_files_id = b.f_files_id");
		sql.append("   and b.f_doc_id = c.f_doc_id");
		sql.append("   and a.f_files_id = ? ");
		sql.append(" order by c.f_doc_num asc");
		return super.queryToListMap(sql.toString(), conn, filesId);
	}

	/**
	 * 
	*<b>Summary:更新文件状态为未归档 </b>
	* updateDocStateByFileIds()
	* @param ids
	* @param userId
	* @param conn
	 * @throws SQLException 
	 */
	public void updateDocStateByFileIds(String ids,Connection conn) throws SQLException {
			
		StringBuffer sql = new StringBuffer();
		sql.append("update oa_file_doc a");
		sql.append("   set a.f_doc_state = '0', a.f_doc_state_name = '待归档'");
		sql.append(" where exists (select f_doc_id");
		sql.append("          from oa_file_docfiles b");
		sql.append("         where a.f_doc_id = b.f_doc_id");
		sql.append("           and instr(',' ||?|| ',',");
		sql.append("                     ',' || b.f_files_id || ',') > 0");		
		
		sql.append(")");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, ids);
		pdb.executePrepared(conn);
	}
	
	/**
	 * 
	*<b>Summary: 删除备考表信息</b>
	* deleteFileNote()
	* @param ids 档案id列表
	* @param userId 用户id
	* @param conn
	* @throws SQLException
	 */
	public void deleteFileNote(String ids, Connection conn)
			throws SQLException {
		StringBuffer sql = new StringBuffer();
		sql.append("        delete from oa_file_note a");
		sql.append(" where exists (select f_files_id");
		sql.append("          from oa_file_files b");
		sql.append("         where a.f_files_id = b.f_files_id");
		sql
				.append(" and instr(',' || ? || ',', ',' || b.f_files_id || ',') > 0");
		
		sql.append(")");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedDelete(sql.toString());
		pdb.setString(1, ids);		
		pdb.executePrepared(conn);
	}
	
	/**
	 * 
	 *<b>Summary: 删除档案和文件对应关系表数据</b> deleteListDocFiles()
	 * 
	 * @param ids
	 * @param userId
	 * @param isManager
	 * @param conn
	 * @throws SQLException
	 */
	public void deleteListDocFiles(String ids, Connection conn) throws SQLException {
		StringBuffer sql = new StringBuffer();
		sql.append("delete from oa_file_docfiles a");
		sql.append(" where exists (select f_files_id");
		sql.append("          from oa_file_files b");
		sql.append("         where b.f_files_id = a.f_files_id");
		sql
				.append("           and instr(',' || ? || ',', ',' || b.f_files_id || ',') > 0");
		
		sql.append(")");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedDelete(sql.toString());
		pdb.setString(1, ids);		
		pdb.executePrepared(conn);
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 isFileTypeAdmin
	  * @param userId
	  * @param typeId
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.file.dao.FileFilesDao#isFileTypeAdmin(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 isFileTypeAdmin
	  * @param userId
	  * @param typeId
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.file.dao.FileFilesDao#isFileTypeAdmin(java.lang.String, java.lang.String, java.sql.Connection) 
	  */
	public boolean isFileTypeAdmin(String userId, String typeId, Connection conn)
			throws SQLException {
		StringBuffer sql = new StringBuffer();  
		sql.append("select decode(sum(sun),null,0,0,0,1,0,1)  ");
		sql.append("  from (select count(1) sun");
		sql.append("          from oa_file_type f");
		sql.append("         start with f.f_type_id =  ?");
		sql.append("        ");
		sql.append("        connect by prior f.f_parent_type_id = f.f_type_id");
		sql.append("               and instr(',' || f.f_type_admin || ',', ',' || ? || ',') > 0");
		sql.append("        union all ");
		sql.append("        select count(1) sun");
		sql.append("          from oa_file_type f");
		sql.append("         start with f.f_type_id = ?");
		sql.append("                and instr(',' || f.f_type_admin || ',', ',' || ? || ',') > 0");
		sql.append("        connect by prior f.f_parent_type_id = f.f_type_id");
		sql.append("               and instr(',' || f.f_type_admin || ',', ',' || ? || ',') > 0");
		sql.append("        ");
		sql.append("        ) b");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, typeId);
		pdb.setString(2, userId);
		pdb.setString(3, typeId);
		pdb.setString(4, userId);
		pdb.setString(5, userId);
		pdb.executePrepared(conn);
		if (pdb.size() > 0) {
			int i = pdb.getInt(0, 0);
			if (i > 0) {
				return true;
			}
		}
		return false;
	}
	
	/**
	 * 
	*<b>Summary: 批量修改案卷状态</b>
	* updateListFileState()
	* @param state
	* @param fileIds
	 * @throws SQLException 
	 */
	public void updateListFileState(String state,String stateName,String fileIds,Connection conn) throws SQLException{
		if (StringUtil.nullOrBlank(state) || StringUtil.nullOrBlank(stateName)
				|| StringUtil.nullOrBlank(fileIds)) {
			return;
		}
		StringBuffer sql = new StringBuffer();
		sql.append(" update oa_file_files");
		sql.append(" set f_files_state = ? , ");
		sql.append(" f_files_state_name = ?  ");
		sql.append(" where  instr(',' || ? || ',', ',' ||f_files_id || ',') > 0");
		
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, state);		
		pdb.setString(2, stateName);	
		pdb.setString(3, fileIds);	
		pdb.executePrepared(conn);
	}
	/**
	 * 
	*<b>Summary:复制会计档案 </b>
	* copyFileAcc()
	 * @throws SQLException 
	 */
	public void copyFileAcc(String oldFileId,String newFileId,Connection conn) throws SQLException{
		
		StringBuffer sql = new StringBuffer();		 
		sql.append("insert into oa_file_files_acc");
		sql.append("  (f_acc_id,");
		sql.append("   f_file_month,");
		sql.append("   f_file_monthbooktotal,");
		sql.append("   f_file_monthbookindex,");
		sql.append("   f_file_startno,");
		sql.append("   f_file_endno,");
		sql.append("   f_attach_id,");
		sql.append("   f_files_id)");
		sql.append("  select sys_guid(),");
		sql.append("         f_file_month,");
		sql.append("         f_file_monthbooktotal,");
		sql.append("         f_file_monthbookindex,");
		sql.append("         f_file_startno,");
		sql.append("         f_file_endno,");
		sql.append("         '',");
		sql.append("         ?");
		sql.append("    from oa_file_files_acc b");
		sql.append("   where b.f_files_id = ? "); 
		
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedInsert(sql.toString());
		pdb.setString(1, newFileId);		
		pdb.setString(2, oldFileId);	
		pdb.executePrepared(conn);
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryListFile4update
	  * @param map
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.file.dao.FileFilesDao#queryListFile4update(java.util.Map, java.sql.Connection)
	 */
	public List<Map<String, String>> queryListFile4update(
			Map<String, Object> map, Connection conn) throws Exception {
		// 查询条件
		FileFilesBean searchBean = (FileFilesBean) map.get("search");
		String ids = StringUtil.deNull(map.get("ids"));

		StringBuffer sql = new StringBuffer();
		List<String> condition = new ArrayList<String>();
		sql.append("select f_files_id,f_type_id from  oa_file_files ");
		sql.append(" where f_files_id is not null ");
		if (!StringUtil.nullOrBlank(ids)) {
			sql.append(" and instr (','||?||',',','||f_files_id||',') >0 ");
			condition.add(ids.replaceAll("'", ""));
		} else if (null != searchBean) {
			//所属单位
			if(!StringUtil.nullOrBlank(searchBean.getF_org_id())){
				sql.append(" and F_org_id =? ");
				condition.add(searchBean.getF_org_id());
			}	
			//所属分类分类id
			if(!StringUtil.nullOrBlank(searchBean.getF_type_id())){
				sql.append(" and f_type_id in  ");
				sql.append(" ( select f_type_id");
				sql.append("  from oa_file_type");
				sql.append(" start with f_type_id = ?");
				sql.append(" connect by prior f_type_id = f_parent_type_id )");
                condition.add(searchBean.getF_type_id());
                
			}
            //保管期限
			if (!StringUtil.nullOrBlank(searchBean.getF_doc_deadline_name())) {
				sql.append(" and  instr(','||?||',',','||F_doc_deadline_name||',')>0 ");
				condition.add(searchBean.getF_doc_deadline_name());
			}
			//档案年份
			if (!StringUtil.nullOrBlank(searchBean.getF_doc_year())) {
				sql.append(" and f_doc_year like '%'||?||'%'  ");
				condition.add(searchBean.getF_doc_year());
			}
			//档案名称
			if (!StringUtil.nullOrBlank(searchBean.getF_files_title())) {
				sql.append(" and f_files_title like '%'||?||'%'  ");
				condition.add(searchBean.getF_files_title());
			}
			//案卷号
			if (!StringUtil.nullOrBlank(searchBean.getF_filesno())) {
				sql.append(" and f_filesno like '%'||?||'%'  ");
				condition.add(searchBean.getF_filesno());						
			}
			//密级
			if (!StringUtil.nullOrBlank(searchBean.getF_secrecy_name())) {
				sql.append(" and instr(','||?||',',','||f_secrecy_name||',')>0 ");
				condition.add(searchBean.getF_secrecy_name());						
			}
			
			//所属部门
			if (!StringUtil.nullOrBlank(searchBean.getF_dept_name())) {
				sql.append(" and F_dept_name like '%'||?||'%' ");
				condition.add(searchBean.getF_dept_name());
			}
			
			
			if(!StringUtil.nullOrBlank(searchBean.getF_files_state())){
				sql.append(" and F_files_state=? ");
				condition.add(searchBean.getF_files_state());
			}

			//档号
			if(!StringUtil.nullOrBlank(searchBean.getF_files_no())){
				sql.append(" and F_files_no like '%'||?||'%'");
				condition.add(searchBean.getF_files_no());
			} 
		    
			//归档日期开始时间
			if (!StringUtil.nullOrBlank(searchBean.getF_start_time())) {
				sql.append(" and F_file_time >= to_date(?,'yyyy-mm-dd')  ")
						.append(" and F_file_time is not null ");
				condition.add(StringUtil.deNull(searchBean.getF_start_time()));
			}
			//归档日期结束时间
			if (!StringUtil.nullOrBlank(searchBean.getF_end_time())) {
				sql.append(" and F_file_time <= to_date(?,'yyyy-mm-dd') ")
						.append(" and F_file_time is not null ");
				condition.add(StringUtil.deNull(searchBean.getF_end_time()));
			}
			//案卷题名
			if(!StringUtil.nullOrBlank(searchBean.getF_files_title())){
				sql.append(" and f_files_title like '%'||?||'%'");
				condition.add(searchBean.getF_files_title());
			} 
						
			//目录号
			if(!StringUtil.nullOrBlank(searchBean.getF_listno())){
				sql.append(" and f_listno = ?");
				condition.add(searchBean.getF_listno());
			}
			//卷内件数
			if(!StringUtil.nullOrBlank(searchBean.getF_files_num())){
				sql.append(" and f_files_num = ? ");
				condition.add(searchBean.getF_files_num());
			}
		}
		return super.queryToListMap(sql.toString(), conn, condition);
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryUserData
	  * @param sql
	  * @param params
	  * @param dbColumns
	  * @param maxRownum
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.file.dao.FileFirstPageDao#queryUserData(java.lang.String, java.util.List, java.util.List, int, java.sql.Connection)
	 */
	@Override
	public List<Map<String, String>> queryUserData(String sql,
			List<String> params, List<String> dbColumns,int maxRownum, Connection conn)
			throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql,0,maxRownum);
		int i = 1;
		for(String param : params){//设置查询参数
			pdb.setString(i, param);
			i++;
		}
		pdb.executePrepared(conn);
		List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		if(pdb.size() > 0){
			for(int j = 0 ; j < pdb.size() ; j++){//遍历查询出的每行数据
				Map<String, String> map = new HashMap<String, String>();
				for(String column : dbColumns){//遍历每行中的字段
					map.put(column, pdb.getString(j, column));
				}
				list.add(map);
			}
		}
		return list;
	}
	/**
	 * 
	*<b>Summary:获得当前类型最大的案卷号，并自增1 </b>
	* @param typeId 档案类型id
	* @param orgId  单位id
	* @param conn   数据库连接对象
	* @return
	* @throws Exception
	 */
	public Map<String, String> queryMaxFileNo(String typeId,String orgId, Connection conn)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select max(to_number(a.F_FILESNO)) + 1 as f_filesno");
		sql.append("  from oa_file_files a");
		sql.append(" where a.f_type_id = ?");
		sql.append(" and a.f_org_id=?");
		return queryToSingleMap(conn, sql.toString(), typeId,orgId);
	}
	
	/**
	 * 
	*<b>Summary:查询卷内未见的最大件号+1 </b>
	* queryMaxDocNo()
	* @param fileId 档案编号
	* @return
	 * @throws Exception 
	 */
	public Map<String,String> queryMaxDocNo(String fileId,Connection conn) throws Exception{
		StringBuffer sql = new StringBuffer();
		sql.append("select max(to_number(a.f_doc_num)) + 1 as f_doc_num");
		sql.append("  from oa_file_doc a");
		sql.append(" where exists (select 1");
		sql.append("          from oa_file_docfiles b");
		sql.append("         where a.f_doc_id = b.f_doc_id");
		sql.append("           and b.f_files_id = ?)");
		return queryToSingleMap(conn, sql.toString(), fileId);
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 updateFilesListOrder
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileFilesDao#updateFilesListOrder(com.chinacreator.xtbg.core.file.entity.FileFilesBean, java.sql.Connection)
	 */
	@Override
	public boolean updateFilesListOrder(FileFilesBean bean, Connection conn)
			throws Exception {
		String ids = bean.getF_files_id();
		if(!StringUtil.isBlank(ids)) {
			String[] idsArray = ids.split(",");
			PreparedDBUtil db = new PreparedDBUtil();
			String sql = "update oa_file_files set f_order = ? where f_files_id = ?";
			for(int i=0; i<idsArray.length ;i++){
				db.preparedUpdate(sql);
				db.setInt(1, i);
				db.setString(2, idsArray[i]);
				db.addPreparedBatch();
			}
			db.executePreparedBatch(conn);
		}
		return true;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 updateFileListInFilesOrder
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileFilesDao#updateFileListInFilesOrder(com.chinacreator.xtbg.core.file.entity.FileFilesBean, java.sql.Connection)
	 */
	@Override
	public boolean updateFileListInFilesOrder(FileFilesBean bean,
			Connection conn) throws Exception {
		String ids = bean.getF_files_id();
		if(!StringUtil.isBlank(ids)) {
			String[] idsArray = ids.split(",");
			PreparedDBUtil db = new PreparedDBUtil();
			String sql = "update oa_file_doc set f_doc_num = ? where F_DOC_ID = ?";
			for(int i=0; i<idsArray.length ;i++){
				db.preparedUpdate(sql);
				db.setInt(1, i+1);
				db.setString(2, idsArray[i]);
				db.addPreparedBatch();
			}
			db.executePreparedBatch(conn);
		}
		return true;
	}
}
