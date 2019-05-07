package com.chinacreator.xtbg.core.file.dao.imploracle;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.fancyuoload.service.FiletransferService;
import com.chinacreator.xtbg.core.common.fancyuoload.service.impl.FiletransferServiceImpl;
import com.chinacreator.xtbg.core.common.fancyuoload.util.FileUtils;
import com.chinacreator.xtbg.core.common.note.entity.NoteBufferBean;
import com.chinacreator.xtbg.core.common.note.entity.NoteDetailBean;
import com.chinacreator.xtbg.core.common.note.services.impl.NoteServiceImpl;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.MessageUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.file.dao.FileDocDao;
import com.chinacreator.xtbg.core.file.dao.FileTypeDao;
import com.chinacreator.xtbg.core.file.entity.FileDocBean;
import com.chinacreator.xtbg.core.file.entity.FileDocBeforeArchiveBean;
import com.chinacreator.xtbg.core.file.entity.FileDocPhotoBean;
import com.chinacreator.xtbg.core.file.entity.FileDocPhotoInfoBean;
import com.frameworkset.common.poolman.DBUtil;
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
public class FileDocDaoImpl extends XtDbBaseDao implements FileDocDao {

	 /** 
	  * <b>Summary: </b>
	  *     复写方法 queryFileDocList
	  * @param model
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.file.dao.FileDocDao#queryFileDocList(com.chinacreator.xtbg.core.file.entity.FileDocBean, java.lang.String, java.lang.String, long, int) 
	  */
	public PagingBean queryFileDocList(FileDocBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			sql.append("select ofd.f_doc_id,");
			sql.append("       ofd.f_doc_name,");
			sql.append("       ofd.f_doc_fontsize,");
			sql.append("       ofd.f_type_id,");
			sql.append("       ofd.f_type_name,");
			sql.append("       ofd.f_doc_keywords,");
			sql.append("       ofd.f_doc_year,");
			sql.append("       ofd.f_secrecy_id,");
			sql.append("       ofd.f_secrecy_name,");
			sql.append("       ofd.f_org_id,");
			sql.append("       ofd.f_org_name,");
			sql.append("       ofd.f_dept_id,");
			sql.append("       ofd.f_dept_name,");
			sql.append("       ofd.f_doc_checkuser,");
			sql.append("       ofd.f_doc_blname,");
			sql.append("       TO_CHAR(f_file_formtime, 'yyyy-mm-dd') f_file_formtime,");
			sql.append("       ofd.f_file_quantity,");
			sql.append("       ofd.f_doc_content f_type_remark,");//目前备注列无用
			sql.append("       ofd.f_user_id,");
			sql.append("       ofd.f_user_name,");
			sql.append("       ofd.f_creator_time,");
			sql.append("       ofd.f_doc_content,");
			sql.append("       countttt.countt f_attach_id,");
			sql.append("       ofd.f_doc_state,");
			sql.append("       ofd.f_doc_state_name,");
			sql.append("       ofd.f_file_no,");
			sql.append("       ofd.f_typeno,");
			sql.append("       ofd.f_doc_num,");
			sql.append("       ofd.f_info_num,");
			sql.append("       ofd.f_doc_media,");
			sql.append("       ofd.f_doc_media_name,");
			sql.append("       ofd.f_entity_type,");
			sql.append("       ofd.f_entity_type_name,");
			sql.append("       ofd.f_burn_user_id,");
			sql.append("       ofd.f_burn_user_name,");
			sql.append("       ofd.f_file_num,");
			sql.append("       ofd.f_doc_deadline,");
			sql.append("       ofd.f_file_userid,");
			sql.append("       ofd.f_file_username,");
			sql.append("       ofd.f_file_time,");
			sql.append("       TO_CHAR(ofd.f_file_time, 'yyyy-mm-dd') f_file_time_str,");
			sql.append("       ofd.f_info_type,");
			sql.append("       ofd.f_info_type_name,");
			sql.append("       ofd.f_file_num_unit,");
			sql.append("       ofd.f_file_num_unit_name,");
			sql.append("       ofd.f_doc_deadline_name,");
			sql.append("       case when sysdate-f_file_formtime>365 then round((sysdate-f_file_formtime)/365)||'年' when sysdate-f_file_formtime>30 then round((sysdate-f_file_formtime)/30)||'个月' else round(sysdate-f_file_formtime)||'天' end f_doc_yi_deadline");
			sql.append("  from oa_file_doc ofd ");
			sql.append("  left join (select fpi.f_doc_id, count(1) countt");
			sql.append("               from oa_file_doc fpi");
			sql.append("               inner join oa_fc_attach fa");
			sql.append("                  on fpi.f_attach_id = fa.djbh");
			sql.append("             group by fpi.f_doc_id) countttt");
			sql.append("    on   ofd.f_doc_id = countttt.f_doc_id");
			sql.append("    where 1=1 ");
			sql.append("   and ofd.f_doc_state<>'"+FileDocBean.F_DOC_STATE_DESTROY+"'");
			sql.append("   and (ofd.f_flow_state ='3' or ofd.f_flow_state is null)");
			if(!StringUtil.nullOrBlank(model.getF_type())){ //选择待销毁文件列表 
				sql.append(" and f_destroy_state ='0' and ofd.f_doc_state='2'");
				
				if(!StringUtil.nullOrBlank(model.getNotInId())){ //选择待销毁文件列表 
					sql.append(" and ofd.f_doc_id not in (select * from table(split('"+model.getNotInId().substring(0,model.getNotInId().length()-1)+"')))");
				}
			}
			if (!StringUtil.nullOrBlank(model.getF_doc_name())){
				sql.append(" and f_doc_name like '%"+model.getF_doc_name()+"%'");
			}
			if (!StringUtil.nullOrBlank(model.getF_type_id())){
				//sql.append(" and f_type_id = '"+model.getF_type_id()+"'");
				sql.append(" and ofd.f_type_id in (select f_type_id from oa_file_type start with f_type_id = '"+model.getF_type_id()+"' connect by prior f_type_id = f_parent_type_id)");
			}
			
			if (!StringUtil.nullOrBlank(model.getF_dept_name())){
				sql.append(" and f_dept_name like '%"+model.getF_dept_name()+"%'");
			}
			if (!StringUtil.nullOrBlank(model.getF_doc_state())){
				sql.append(" and f_doc_state = '"+model.getF_doc_state()+"'");
			}
			if (!StringUtil.nullOrBlank(model.getF_doc_fontsize())){
				sql.append(" and f_doc_fontsize like '%"+model.getF_doc_fontsize()+"%'");
			}
			if (!StringUtil.nullOrBlank(model.getF_doc_year())){
				sql.append(" and f_doc_year = '"+model.getF_doc_year()+"'");
			}
			if (!StringUtil.nullOrBlank(model.getF_dept_id())){
				sql.append(" and ofd.f_dept_id = '"+model.getF_dept_id()+"'");
				
			}
			if (!StringUtil.nullOrBlank(model.getF_org_id())){
				sql.append(" and ofd.f_org_id = '"+model.getF_org_id()+"'");
			}
			
			//+件号
			if (!StringUtil.nullOrBlank(model.getF_doc_num())){
				sql.append(" and F_doc_num like '%"+model.getF_doc_num()+"%'");
			}
			//+附件数量下限
			if (!StringUtil.nullOrBlank(model.getF_attach_id_min())){
				sql.append(" and (select count(1) from oa_fc_attach fa where fa.djbh=ofd.f_attach_id)>= "+model.getF_attach_id_min()+"");
			}
			//+附件数量上限
			if (!StringUtil.nullOrBlank(model.getF_attach_id_max())){
				sql.append(" and (select count(1) from oa_fc_attach fa where fa.djbh=ofd.f_attach_id)<= "+model.getF_attach_id_max()+"");
			}
			
			//+备注栏(密级)  f_secrecy_name
			if (!StringUtil.nullOrBlank(model.getF_secrecy_name())) {
				sql.append(" and instr(','||'"+model.getF_secrecy_name()+"'||',',','||ofd.f_secrecy_name||',')>0 ");				
			}
			//+文件生成时间
			if(!StringUtil.nullOrBlank(StringUtil.deNull(model.getStart_time()))){
				sql.append(" and ofd.f_creator_time >= to_date('"+model.getStart_time()+"','yyyy-MM-dd') ");
			}
			if(!StringUtil.nullOrBlank(StringUtil.deNull(model.getEnd_time()))){
				sql.append(" and ofd.f_creator_time <= to_date('"+model.getEnd_time()+"','yyyy-MM-dd') ");
			}
			if("f_doc_num".equals(sortName)){
				sql.append(" order by ofd.f_doc_year desc," + sortName + " " + sortOrder+",ofd.f_creator_time desc");
			}else{
				sql.append(" order by " + sortName + " " + sortOrder+",ofd.f_creator_time desc");
			}
			
			// 调父类的方法
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 queryFileDocPhotoList
	 * @param model
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileDocDao#queryFileDocPhotoList(com.chinacreator.xtbg.core.file.entity.FileDocPhotoBean, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean queryFileDocPhotoList(FileDocPhotoBean model,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			sql.append("select ofd.f_doc_id,");
			sql.append("       ofd.f_doc_name,");
			sql.append("       ofd.f_doc_fontsize,");
			sql.append("       ofd.f_type_id,");
			sql.append("       ofd.f_type_name,");
			sql.append("       ofd.f_doc_keywords,");
			sql.append("       ofd.f_doc_year,");
			sql.append("       ofd.f_secrecy_id,");
			sql.append("       ofd.f_secrecy_name,");
			sql.append("       ofd.f_org_id,");
			sql.append("       ofd.f_org_name,");
			sql.append("       ofd.f_dept_id,");
			sql.append("       ofd.f_dept_name,");
			sql.append("       ofd.f_doc_checkuser,");
			sql.append("       ofd.f_doc_blname,");
			sql.append("       TO_CHAR(f_file_formtime, 'yyyy-mm-dd') f_file_formtime,");
			sql.append("       ofd.f_file_quantity,");
			sql.append("       ofd.f_doc_content f_type_remark,");//目前备注列无用
			//sql.append("       ofd.f_type_remark,");
			sql.append("       ofd.f_user_id,");
			sql.append("       ofd.f_user_name,");
			sql.append("       ofd.f_creator_time,");
			sql.append("       ofd.f_doc_content,");
			sql.append("       counttt.countt f_attach_id, ");//附件数量
			sql.append("       ofd.f_doc_state,");
			sql.append("       ofd.f_doc_state_name,");
			sql.append("       ofd.f_file_no,");
			sql.append("       ofd.f_typeno,");
			sql.append("       ofd.f_doc_num,");
			sql.append("       ofd.f_info_num,");
			sql.append("       ofd.f_doc_media,");
			sql.append("       ofd.f_doc_media_name,");
			sql.append("       ofd.f_entity_type,");
			sql.append("       ofd.f_entity_type_name,");
			sql.append("       ofd.f_burn_user_id,");
			sql.append("       ofd.f_burn_user_name,");
			sql.append("       ofd.f_file_num,");
			sql.append("       ofd.f_doc_deadline,");
			sql.append("       ofd.f_file_userid,");
			sql.append("       ofd.f_file_username,");
			sql.append("       ofd.f_file_time,");
			sql.append("       ofd.f_info_type,");
			sql.append("       ofd.f_info_type_name,");
			sql.append("       ofd.f_file_num_unit,");
			sql.append("       ofd.f_file_num_unit_name,");
			sql.append("       ofd.f_doc_deadline_name,");
			sql.append("       ofpe.f_pan_id,");
			sql.append("       ofpe.f_specification,");
			sql.append("       ofpe.f_shooting_user,");
			sql.append("       ofpe.f_add,");
			sql.append("       ofpe.f_person,");
			sql.append("       ofpe.f_background");
			sql.append("  from oa_file_doc ofd LEFT JOIN oa_file_pan_ext ofpe ON OFD.f_doc_id = ofpe.f_doc_id ");
			
			sql.append("  left join (select fpi.f_file_id, count(1) countt");
			sql.append("               from oa_file_photo_info fpi");
			sql.append("               inner join oa_fc_attach fa");
			sql.append("                  on fpi.f_attach_id = fa.djbh");
			sql.append("             group by fpi.f_file_id) counttt");
			sql.append("    on   ofd.f_doc_id = counttt.f_file_id");
			
			sql.append("    where 1=1 ");
			sql.append("   and ofd.f_doc_state<>'"+FileDocBean.F_DOC_STATE_DESTROY+"'");
			if (!StringUtil.nullOrBlank(model.getF_doc_name())){
				sql.append(" and ofd.f_doc_name like '%"+model.getF_doc_name()+"%'");
			}
			if (!StringUtil.nullOrBlank(model.getF_type_id())){
				//sql.append(" and ofd.f_type_id = '"+model.getF_type_id()+"'");
				sql.append(" and ofd.f_type_id in (select f_type_id from oa_file_type start with f_type_id = '"+model.getF_type_id()+"' connect by prior f_type_id = f_parent_type_id)");
			}
			
			if (!StringUtil.nullOrBlank(model.getF_dept_name())){
				sql.append(" and ofd.f_dept_name like '%"+model.getF_dept_name()+"%'");
			}
			if (!StringUtil.nullOrBlank(model.getF_doc_state())){
				sql.append(" and ofd.f_doc_state = '"+model.getF_doc_state()+"'");
			}
			if (!StringUtil.nullOrBlank(model.getF_shooting_user())){
				sql.append(" and ofpe.f_shooting_user like '%"+model.getF_shooting_user()+"%'");
			}
			if (!StringUtil.nullOrBlank(model.getF_add())){
				sql.append(" and ofpe.f_ADD like '%"+model.getF_add()+"%'");
			}
			if (!StringUtil.nullOrBlank(model.getF_doc_year())){
				sql.append(" and ofd.f_doc_year = '"+model.getF_doc_year()+"'");
			}
			if (!StringUtil.nullOrBlank(model.getF_dept_id())){
				sql.append(" and ofd.f_dept_id = '"+model.getF_dept_id()+"'");
			}
			if (!StringUtil.nullOrBlank(model.getF_org_id())){
				sql.append(" and ofd.f_org_id = '"+model.getF_org_id()+"'");
			}
			
			//+件号
			if (!StringUtil.nullOrBlank(model.getF_doc_num())){
				sql.append(" and F_doc_num like '%"+model.getF_doc_num()+"%'");
			}
			//+附件数量下限
			if (!StringUtil.nullOrBlank(model.getF_attach_id_min())){
				sql.append(" and (select count(1) from oa_fc_attach fa where fa.djbh in (select f_attach_id from oa_file_photo_info fpi where fpi.f_file_id = ofd.f_doc_id))>= "+model.getF_attach_id_min()+"");
			}
			//+附件数量上限
			if (!StringUtil.nullOrBlank(model.getF_attach_id_max())){
				sql.append(" and (select count(1) from oa_fc_attach fa where fa.djbh in (select f_attach_id from oa_file_photo_info fpi where fpi.f_file_id = ofd.f_doc_id))<= "+model.getF_attach_id_max()+"");
			}
			//+照片数量下限
			if (!StringUtil.nullOrBlank(model.getF_file_quantity_min())){
				sql.append(" and nvl(REGEXP_SUBSTR(ofd.f_file_quantity,'^\\d*'),0) >= "+model.getF_file_quantity_min()+" ");
			}
			//+照片数量上限
			if (!StringUtil.nullOrBlank(model.getF_file_quantity_max())){
				sql.append(" and nvl(REGEXP_SUBSTR(ofd.f_file_quantity,'^\\d*'),0) <= "+model.getF_file_quantity_max()+"");
			}
			//+备注栏(密级)  f_secrecy_name
			if (!StringUtil.nullOrBlank(model.getF_secrecy_name())) {
				sql.append(" and instr(','||'"+model.getF_secrecy_name()+"'||',',','||ofd.f_secrecy_name||',')>0 ");				
			}
			//+文件生成时间
			if(!StringUtil.nullOrBlank(StringUtil.deNull(model.getStart_time()))){
				sql.append(" and ofd.f_creator_time >= to_date('"+model.getStart_time()+"','yyyy-MM-dd') ");
			}
			if(!StringUtil.nullOrBlank(StringUtil.deNull(model.getEnd_time()))){
				sql.append(" and ofd.f_creator_time <= to_date('"+model.getEnd_time()+"','yyyy-MM-dd') ");
			}
			
			if("f_doc_num".equals(sortName)){
				sql.append(" order by ofd.f_doc_year desc," + sortName + " " + sortOrder+",ofd.f_creator_time desc");
			}else{
				sql.append(" order by " + sortName + " " + sortOrder+",ofd.f_creator_time desc");
			}
			// 调父类的方法
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 queryFileDocVideoList
	 * @param model
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileDocDao#queryFileDocVideoList(com.chinacreator.xtbg.core.file.entity.FileDocPhotoBean, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean queryFileDocVideoList(FileDocPhotoBean model,
			String sortName, String sortOrder, long offset, int maxPagesize)
	throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			sql.append("select ofd.f_doc_id,");
			sql.append("       ofd.f_doc_name,");
			sql.append("       ofd.f_doc_fontsize,");
			sql.append("       ofd.f_type_id,");
			sql.append("       ofd.f_type_name,");
			sql.append("       ofd.f_doc_keywords,");
			sql.append("       ofd.f_doc_year,");
			sql.append("       ofd.f_secrecy_id,");
			sql.append("       ofd.f_secrecy_name,");
			sql.append("       ofd.f_org_id,");
			sql.append("       ofd.f_org_name,");
			sql.append("       ofd.f_dept_id,");
			sql.append("       ofd.f_dept_name,");
			sql.append("       ofd.f_doc_checkuser,");
			sql.append("       ofd.f_doc_blname,");
			sql.append("       TO_CHAR(f_file_formtime, 'yyyy-mm-dd') f_file_formtime,");
			sql.append("       ofd.f_file_quantity,");
			sql.append("       ofd.f_doc_content f_type_remark,");//目前备注列无用
			//sql.append("       ofd.f_type_remark,");
			sql.append("       ofd.f_user_id,");
			sql.append("       ofd.f_user_name,");
			sql.append("       ofd.f_creator_time,");
			sql.append("       ofd.f_doc_content,");
			sql.append("       (select count(1) from oa_fc_attach fa where fa.djbh=ofd.f_attach_id) f_attach_id,");
			sql.append("       ofd.f_doc_state,");
			sql.append("       ofd.f_doc_state_name,");
			sql.append("       ofd.f_file_no,");
			sql.append("       ofd.f_typeno,");
			sql.append("       ofd.f_doc_num,");
			sql.append("       ofd.f_info_num,");
			sql.append("       ofd.f_doc_media,");
			sql.append("       ofd.f_doc_media_name,");
			sql.append("       ofd.f_entity_type,");
			sql.append("       ofd.f_entity_type_name,");
			sql.append("       ofd.f_burn_user_id,");
			sql.append("       ofd.f_burn_user_name,");
			sql.append("       ofd.f_file_num,");
			sql.append("       ofd.f_doc_deadline,");
			sql.append("       ofd.f_file_userid,");
			sql.append("       ofd.f_file_username,");
			sql.append("       ofd.f_file_time,");
			sql.append("       ofd.f_info_type,");
			sql.append("       ofd.f_info_type_name,");
			sql.append("       ofd.f_file_num_unit,");
			sql.append("       ofd.f_file_num_unit_name,");
			sql.append("       ofd.f_doc_deadline_name,");
			sql.append("       ofpe.f_pan_id,");
			sql.append("       ofpe.f_specification,");
			sql.append("       ofpe.f_shooting_user,");
			sql.append("       ofpe.f_add,");
			sql.append("       ofpe.f_person,");
			sql.append("       ofpe.f_background");
			sql.append("  from oa_file_doc ofd LEFT JOIN oa_file_pan_ext ofpe ON OFD.f_doc_id = ofpe.f_doc_id where 1=1 ");
			sql.append("   and ofd.f_doc_state<>'"+FileDocBean.F_DOC_STATE_DESTROY+"'");
			if (!StringUtil.nullOrBlank(model.getF_doc_name())){
				sql.append(" and ofd.f_doc_name like '%"+model.getF_doc_name()+"%'");
			}
			if (!StringUtil.nullOrBlank(model.getF_type_id())){
				//sql.append(" and ofd.f_type_id = '"+model.getF_type_id()+"'");
				sql.append(" and ofd.f_type_id in (select f_type_id from oa_file_type start with f_type_id = '"+model.getF_type_id()+"' connect by prior f_type_id = f_parent_type_id)");
			}
			
			if (!StringUtil.nullOrBlank(model.getF_dept_name())){
				sql.append(" and ofd.f_dept_name like '%"+model.getF_dept_name()+"%'");
			}
			if (!StringUtil.nullOrBlank(model.getF_doc_state())){
				sql.append(" and ofd.f_doc_state = '"+model.getF_doc_state()+"'");
			}
			if (!StringUtil.nullOrBlank(model.getF_shooting_user())){
				sql.append(" and ofpe.f_shooting_user like '%"+model.getF_shooting_user()+"%'");
			}
			if (!StringUtil.nullOrBlank(model.getF_add())){
				sql.append(" and ofpe.f_ADD like '%"+model.getF_add()+"%'");
			}
			if (!StringUtil.nullOrBlank(model.getF_doc_year())){
				sql.append(" and ofd.f_doc_year = '"+model.getF_doc_year()+"'");
			}
			if (!StringUtil.nullOrBlank(model.getF_dept_id())){
				sql.append(" and ofd.f_dept_id = '"+model.getF_dept_id()+"'");
			}
			if (!StringUtil.nullOrBlank(model.getF_org_id())){
				sql.append(" and ofd.f_org_id = '"+model.getF_org_id()+"'");
			}
			
			//+件号
			if (!StringUtil.nullOrBlank(model.getF_doc_num())){
				sql.append(" and F_doc_num like '%"+model.getF_doc_num()+"%'");
			}
			//+附件数量下限
			if (!StringUtil.nullOrBlank(model.getF_attach_id_min())){
				sql.append(" and (select count(1) from oa_fc_attach fa where fa.djbh=ofd.f_attach_id)>= "+model.getF_attach_id_min()+"");
			}
			//+附件数量上限
			if (!StringUtil.nullOrBlank(model.getF_attach_id_max())){
				sql.append(" and (select count(1) from oa_fc_attach fa where fa.djbh=ofd.f_attach_id)<= "+model.getF_attach_id_max()+"");
			}
			//+照片数量下限
			if (!StringUtil.nullOrBlank(model.getF_file_quantity_min())){
				sql.append(" and ofd.f_file_quantity>= "+model.getF_file_quantity_min()+"");
			}
			//+照片数量上限
			if (!StringUtil.nullOrBlank(model.getF_file_quantity_max())){
				sql.append(" and ofd.f_file_quantity<= "+model.getF_file_quantity_max()+"");
			}
			//+备注栏(密级)  f_secrecy_name
			if (!StringUtil.nullOrBlank(model.getF_secrecy_name())) {
				sql.append(" and instr(','||'"+model.getF_secrecy_name()+"'||',',','||ofd.f_secrecy_name||',')>0 ");				
			}
			//+文件生成时间
			if(!StringUtil.nullOrBlank(StringUtil.deNull(model.getStart_time()))){
				sql.append(" and ofd.f_creator_time >= to_date('"+model.getStart_time()+"','yyyy-MM-dd') ");
			}
			if(!StringUtil.nullOrBlank(StringUtil.deNull(model.getEnd_time()))){
				sql.append(" and ofd.f_creator_time <= to_date('"+model.getEnd_time()+"','yyyy-MM-dd') ");
			}
			
			if("f_doc_num".equals(sortName)){
				sql.append(" order by ofd.f_doc_year desc," + sortName + " " + sortOrder+",ofd.f_creator_time desc");
			}else{
				sql.append(" order by " + sortName + " " + sortOrder+",ofd.f_creator_time desc");
			}
			// 调父类的方法
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 queryFileDocPhotoBeanList
	 * @param model
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileDocDao#queryFileDocPhotoBeanList(com.chinacreator.xtbg.core.file.entity.FileDocPhotoInfoBean, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean queryFileDocPhotoBeanList(FileDocPhotoInfoBean model,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			sql.append("select f_id,");
			sql.append("       f_file_id,");
			sql.append("       case when regexp_like(f_no,'^\\d+(\\.{0,1}\\d+){0,1}$') then to_number(f_no) else 0 end f_no,");
			sql.append("       f_cj_no,");
			sql.append("       f_title,");
			sql.append("       f_photo_media,");
			sql.append("       f_explain,");
			sql.append("       f_attach_id,");
			sql.append("       f_dang_no,");
			sql.append("       f_location");
			sql.append("  from OA_FILE_PHOTO_INFO where 1=1 ");
			if (!StringUtil.nullOrBlank(model.getF_file_id())){
				sql.append(" and f_file_id = '"+model.getF_file_id()+"'");
			}else{
				sql.append(" and 1=0");
			}
			
			sql.append(" order by " + sortName + " " + sortOrder);
			// 调父类的方法
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 queryFileDocDiskList
	 * @param model
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileDocDao#queryFileDocDiskList(com.chinacreator.xtbg.core.file.entity.FileDocPhotoBean, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean queryFileDocDiskList(FileDocPhotoBean model,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			sql.append("select ofd.f_doc_id,");
			sql.append("       ofd.f_doc_name,");
			sql.append("       ofd.f_doc_fontsize,");
			sql.append("       ofd.f_type_id,");
			sql.append("       ofd.f_type_name,");
			sql.append("       ofd.f_doc_keywords,");
			sql.append("       ofd.f_doc_year,");
			sql.append("       ofd.f_secrecy_id,");
			sql.append("       ofd.f_secrecy_name,");
			sql.append("       ofd.f_org_id,");
			sql.append("       ofd.f_org_name,");
			sql.append("       ofd.f_dept_id,");
			sql.append("       ofd.f_dept_name,");
			sql.append("       ofd.f_doc_checkuser,");
			sql.append("       ofd.f_doc_blname,");
			sql.append("       TO_CHAR(f_file_formtime, 'yyyy-mm-dd') f_file_formtime,");
			sql.append("       ofd.f_file_quantity,");
			sql.append("       ofd.f_doc_content f_type_remark,");//目前备注列无用
			//sql.append("       ofd.f_type_remark,");
			sql.append("       ofd.f_user_id,");
			sql.append("       ofd.f_user_name,");
			sql.append("       ofd.f_creator_time,");
			sql.append("       ofd.f_doc_content,");
			sql.append("       (select count(1) from oa_fc_attach fa where fa.djbh=ofd.f_attach_id) f_attach_id,");
			sql.append("       ofd.f_doc_state,");
			sql.append("       ofd.f_doc_state_name,");
			sql.append("       ofd.f_file_no,");
			sql.append("       ofd.f_typeno,");
			sql.append("       ofd.f_doc_num,");
			sql.append("       ofd.f_info_num,");
			sql.append("       ofd.f_doc_media,");
			sql.append("       ofd.f_doc_media_name,");
			sql.append("       ofd.f_entity_type,");
			sql.append("       ofd.f_entity_type_name,");
			sql.append("       ofd.f_burn_user_id,");
			sql.append("       ofd.f_burn_user_name,");
			sql.append("       ofd.f_file_num,");
			sql.append("       ofd.f_doc_deadline,");
			sql.append("       ofd.f_file_userid,");
			sql.append("       ofd.f_file_username,");
			sql.append("       ofd.f_file_time,");
			sql.append("       ofd.f_info_type,");
			sql.append("       ofd.f_info_type_name,");
			sql.append("       ofd.f_file_num_unit,");
			sql.append("       ofd.f_file_num_unit_name,");
			sql.append("       ofd.f_doc_deadline_name,");
			sql.append("       ofpe.f_pan_id,");
			sql.append("       ofpe.f_specification,");
			sql.append("       ofpe.f_shooting_user,");
			sql.append("       ofpe.f_add,");
			sql.append("       ofpe.f_person,");
			sql.append("       ofpe.f_background");
			sql.append("  from oa_file_doc ofd  LEFT JOIN oa_file_pan_ext ofpe ON OFD.f_doc_id = ofpe.f_doc_id where 1=1 ");
			sql.append("   and ofd.f_doc_state<>'"+FileDocBean.F_DOC_STATE_DESTROY+"'");
			if (!StringUtil.nullOrBlank(model.getF_doc_name())){
				sql.append(" and ofd.f_doc_name like '%"+model.getF_doc_name()+"%'");
			}
			if (!StringUtil.nullOrBlank(model.getF_type_id())){
				//sql.append(" and ofd.f_type_id = '"+model.getF_type_id()+"'");
				sql.append(" and ofd.f_type_id in (select f_type_id from oa_file_type start with f_type_id = '"+model.getF_type_id()+"' connect by prior f_type_id = f_parent_type_id)");
			}
			
			if (!StringUtil.nullOrBlank(model.getF_dept_name())){
				sql.append(" and ofd.f_dept_name like '%"+model.getF_dept_name()+"%'");
			}
			if (!StringUtil.nullOrBlank(model.getF_doc_state())){
				sql.append(" and ofd.f_doc_state = '"+model.getF_doc_state()+"'");
			}
			if (!StringUtil.nullOrBlank(model.getF_burn_user_id())){
				sql.append(" and ofd.f_burn_user_id like '%"+model.getF_burn_user_id()+"%'");
			}
			if (!StringUtil.nullOrBlank(model.getF_add())){
				sql.append(" and ofpe.f_add like '%"+model.getF_add()+"%'");
			}
			if (!StringUtil.nullOrBlank(model.getF_doc_year())){
				sql.append(" and ofd.f_doc_year = '"+model.getF_doc_year()+"'");
			}
			if (!StringUtil.nullOrBlank(model.getF_dept_id())){
				sql.append(" and ofd.f_dept_id = '"+model.getF_dept_id()+"'");
			}
			if (!StringUtil.nullOrBlank(model.getF_org_id())){
				sql.append(" and ofd.f_org_id = '"+model.getF_org_id()+"'");
			}
			
			//+件号
			if (!StringUtil.nullOrBlank(model.getF_doc_num())){
				sql.append(" and F_doc_num like '%"+model.getF_doc_num()+"%'");
			}
			//+附件数量下限
			if (!StringUtil.nullOrBlank(model.getF_attach_id_min())){
				sql.append(" and (select count(1) from oa_fc_attach fa where fa.djbh=ofd.f_attach_id)>= "+model.getF_attach_id_min()+"");
			}
			//+附件数量上限
			if (!StringUtil.nullOrBlank(model.getF_attach_id_max())){
				sql.append(" and (select count(1) from oa_fc_attach fa where fa.djbh=ofd.f_attach_id)<= "+model.getF_attach_id_max()+"");
			}
			
			//+备注栏(密级)  f_secrecy_name
			if (!StringUtil.nullOrBlank(model.getF_secrecy_name())) {
				sql.append(" and instr(','||'"+model.getF_secrecy_name()+"'||',',','||ofd.f_secrecy_name||',')>0 ");				
			}
			//+文件生成时间
			if(!StringUtil.nullOrBlank(StringUtil.deNull(model.getStart_time()))){
				sql.append(" and ofd.f_creator_time >= to_date('"+model.getStart_time()+"','yyyy-MM-dd') ");
			}
			if(!StringUtil.nullOrBlank(StringUtil.deNull(model.getEnd_time()))){
				sql.append(" and ofd.f_creator_time <= to_date('"+model.getEnd_time()+"','yyyy-MM-dd') ");
			}
			if("f_doc_num".equals(sortName)){
				sql.append(" order by ofd.f_doc_year desc," + sortName + " " + sortOrder+",ofd.f_creator_time desc");
			}else{
				sql.append(" order by " + sortName + " " + sortOrder+",ofd.f_creator_time desc");
			}
			// 调父类的方法
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	@Override
	public PagingBean queryFileDocListbyid(String id, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			sql.append("select ofd.f_doc_id,");
			sql.append("       ofd.f_doc_name,");
			sql.append("       ofd.f_doc_fontsize,");
			sql.append("       ofd.f_type_id,");
			sql.append("       ofd.f_type_name,");
			sql.append("       ofd.f_doc_keywords,");
			sql.append("       ofd.f_doc_year,");
			sql.append("       ofd.f_secrecy_id,");
			sql.append("       ofd.f_secrecy_name,");
			sql.append("       ofd.f_org_id,");
			sql.append("       ofd.f_org_name,");
			sql.append("       ofd.f_dept_id,");
			sql.append("       ofd.f_dept_name,");
			sql.append("       ofd.f_doc_checkuser,");
			sql.append("       ofd.f_doc_blname,");
			sql.append("       TO_CHAR(f_file_formtime, 'yyyy-mm-dd') f_file_formtime,");
			sql.append("       ofd.f_file_quantity,");
			sql.append("       ofd.f_doc_content f_type_remark,");//目前备注列无用
			//sql.append("       ofd.f_type_remark,");
			sql.append("       ofd.f_user_id,");
			sql.append("       ofd.f_user_name,");
			sql.append("       ofd.f_creator_time,");
			sql.append("       ofd.f_doc_content,");
			sql.append("       (select count(1) from oa_fc_attach fa where fa.djbh=ofd.f_attach_id) f_attach_id,");
			sql.append("       ofd.f_doc_state,");
			sql.append("       ofd.f_doc_state_name,");
			sql.append("       ofd.f_file_no,");
			sql.append("       ofd.f_typeno,");
			sql.append("       ofd.f_doc_num,");
			sql.append("       ofd.f_info_num,");
			sql.append("       ofd.f_doc_media,");
			sql.append("       ofd.f_doc_media_name,");
			sql.append("       ofd.f_entity_type,");
			sql.append("       ofd.f_entity_type_name,");
			sql.append("       ofd.f_burn_user_id,");
			sql.append("       ofd.f_burn_user_name,");
			sql.append("       ofd.f_file_num,");
			sql.append("       ofd.f_doc_deadline,");
			sql.append("       ofd.f_file_userid,");
			sql.append("       ofd.f_file_username,");
			sql.append("       ofd.f_file_time,");
			sql.append("       ofd.f_info_type,");
			sql.append("       ofd.f_info_type_name,");
			sql.append("       ofd.f_file_num_unit,");
			sql.append("       ofd.f_file_num_unit_name,");
			sql.append("       ofd.f_doc_deadline_name");
			sql.append("  from oa_file_doc ofd where 1=1 and ofd.f_doc_id in("+id+")");
			// 调父类的方法
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * getPhotoMessById(通过ID获取照片说明)
	 * @param id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> getPhotoMessById(String id,Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select d.f_title as f_title,");
		sql.append(" c.f_doc_num || '-' || d.f_no as f_no,");
		// 已归档，则参见号为 案卷号+件号
		//sql.append(" a.f_filesno ||'-'||c.f_doc_num as f_cj_no,");
		sql.append("  d.f_cj_no as f_cj_no,");
		sql.append(" to_char(c.f_file_formtime, 'yyyyMMdd')");
		sql.append(" as f_file_formtime,");
		sql.append(" f_shooting_user,");
		sql.append(" d.f_explain as f_doc_content_pic, ");
        sql.append(" d.f_title,");
        sql.append(" d.f_explain,");
        sql.append(" (select max(f.djsn||f.extend) from oa_fc_attach f where trim(f.djbh) = trim(d.f_attach_id)) as fileurl ");
        sql.append("  from oa_file_doc c");
        sql.append("  left join oa_file_docfiles b");
		sql.append("       on b.f_doc_id = c.f_doc_id");
		sql.append("  left join oa_file_files      a ");
		sql.append("       on a.f_files_id = b.f_files_id");
		sql.append("  left join oa_file_photo_info d");
		sql.append("       on c.f_doc_id = d.f_file_id");
		sql.append("  left join oa_file_pan_ext e");
		sql.append("    on c.f_doc_id = e.f_doc_id");
		sql.append("   where d.f_id = ?");
		sql.append(" order by c.f_doc_num asc, d.f_no asc ");
		return super.queryToListMap(sql.toString(), conn, id);
	}
	
	/**
	 * 
	 *<b>Summary: </b>
	 * getPhotoMessById(通过ID获取照片说明)
	 * @param id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> getPhotoFileById(String id,Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select d.f_title as f_title,");
		sql.append(" c.f_doc_num || '-' || d.f_no as f_no,");
		// 已归档，则参见号为 案卷号+件号
		//sql.append(" a.f_filesno ||'-'||c.f_doc_num as f_cj_no,");
		sql.append("  d.f_cj_no as f_cj_no,");
		sql.append(" to_char(c.f_file_formtime, 'yyyyMMdd')");
		sql.append(" as f_file_formtime,");
		sql.append(" f_shooting_user,");
		sql.append(" d.f_explain as f_doc_content_pic, ");
        sql.append(" d.f_title,");
        sql.append(" d.f_explain,");
        sql.append(" (select max(f.djsn||f.extend) from oa_fc_attach f where trim(f.djbh) = trim(d.f_attach_id)) as fileurl ");
 
		sql.append("  from  oa_file_doc c");
		sql.append("  left join oa_file_docfiles b");
		sql.append("       on b.f_doc_id = c.f_doc_id");
		sql.append("  left join oa_file_files      a ");
		sql.append("       on a.f_files_id = b.f_files_id");
		sql.append("  left join oa_file_photo_info d");
		sql.append("       on c.f_doc_id = d.f_file_id");
		sql.append("  left join oa_file_pan_ext e");
		sql.append("    on c.f_doc_id = e.f_doc_id");
		sql.append("   where c.f_doc_id = ?");
		sql.append(" order by c.f_doc_num asc, d.f_no asc");
		return super.queryToListMap(sql.toString(), conn, id);
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * getPhotoBaseFileById(照片组说明 打印内容)
	 * @param id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> getPhotoBaseFileById(String id,Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select ofd.f_type_name,");
		sql.append("       offf.F_FILESNO,");
		sql.append("       ofd.F_INFO_NUM,");
		sql.append("       ofd.f_file_num,");
		sql.append("       ofd.f_file_quantity,");
		sql.append("       ofpe.F_SPECIFICATION,");
		sql.append("       to_char(ofd.F_FILE_FORMTIME, 'yyyyMMdd') F_FILE_FORMTIME,");
		sql.append("       ofpe.F_SHOOTING_USER,");
		sql.append("       ofpe.f_add,");
		sql.append("       ofd.F_DOC_CONTENT");
		sql.append("  from oa_file_doc ofd");
		sql.append("  left join oa_file_docfiles ofdf");
		sql.append("    on ofd.f_doc_id = ofdf.f_doc_id");
		sql.append("  left join oa_file_files offf");
		sql.append("    on ofdf.f_files_id = offf.f_files_id");
		sql.append("  left join oa_file_pan_ext ofpe");
		sql.append("    on ofd.f_doc_id = ofpe.f_doc_id");
		sql.append(" where ofd.f_doc_id = ?");
		return super.queryToListMap(sql.toString(), conn, id);
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * getPhoto(打印组内照片)
	 * @param id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> getPhoto(String id,Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select d.f_title as f_title,");
		sql.append(" c.f_doc_num || '-' || d.f_no as f_no,");
		// 已归档，则参见号为 案卷号+件号
		//sql.append(" a.f_filesno ||'-'||c.f_doc_num as f_cj_no,");
		sql.append("  d.f_cj_no as f_cj_no,");
		sql.append(" to_char(c.f_file_formtime, 'yyyyMMdd')");
		sql.append(" as f_file_formtime,");
		sql.append(" f_shooting_user,");
		sql.append(" d.f_explain as f_doc_content_pic, ");
        sql.append(" d.f_title,");
        sql.append(" d.f_explain,");
        sql.append(" (select max(f.djsn||f.extend) from oa_fc_attach f where trim(f.djbh) = trim(d.f_attach_id)) as fileurl ");
        sql.append("  from  oa_file_doc c");
		sql.append("  left join oa_file_docfiles b");
		sql.append("       on b.f_doc_id = c.f_doc_id");
		sql.append("  left join oa_file_files      a ");
		sql.append("       on a.f_files_id = b.f_files_id");
		sql.append("  left join oa_file_photo_info d");
		sql.append("       on c.f_doc_id = d.f_file_id");
		sql.append("  left join oa_file_pan_ext e");
		sql.append("    on c.f_doc_id = e.f_doc_id");
		sql.append("   where c.f_doc_id = ?");
		sql.append(" order by c.f_doc_num asc, d.f_no asc");
		return super.queryToListMap(sql.toString(), conn, id);
		
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 queryFileDocBeforeArchiveList
	 * @param model
	 * @param sortName-
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileDocDao#queryFileDocBeforeArchiveList(com.chinacreator.xtbg.core.file.entity.FileDocBeforeArchiveBean, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean queryFileDocBeforeArchiveList(
			FileDocBeforeArchiveBean model, String sortName, String sortOrder,
			long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			sql.append("select * from (");
			sql.append("select ofb.f_id,");
			sql.append("       ofb.f_title,");
			sql.append("       ofb.f_file_no,");
			sql.append("       ofb.f_archive_type,");
			sql.append("       ofb.f_org_id,");
			sql.append("       ofb.f_org_name,");
			sql.append("       ofb.f_dept_id,");
			sql.append("       ofb.f_dept_name,");
			sql.append("       ofb.f_attach_id,");
			sql.append("       ofb.f_create_user_id,");
			sql.append("       (select user_realname");
			sql.append("          from td_sm_user");
			sql.append("         where user_id = ofb.f_create_user_id) f_create_user_name,");
			sql.append("       to_char(ofb.f_create_date, 'yyyy-MM-dd') f_create_date,");
			sql.append("       (select user_realname");
			sql.append("          from td_sm_user");
			sql.append("         where user_id = ofb.f_archive_user_id) f_archive_user_name,");
			sql.append("       to_char(ofb.f_archive_date, 'yyyy-MM-dd') f_archive_date,");
			sql.append("       ofb.f_is_archived,");
			sql.append("       '0' datahome,");
			sql.append("       '' fj,");
			sql.append("       '' gongwen_id,");
			sql.append("       '0' f_flow_state");
			sql.append("  from oa_file_before_archive_info ofb");
			sql.append(" where ofb.f_is_archived = '0' and 1=0");
			sql.append("   and not exists");
			sql.append(" (select 1 from oa_file_doc ofd where ofd.f_gongwen_id = ofb.f_id)");
			sql.append(" union ");
			sql.append("select ofd.f_doc_id,");
			sql.append("       ofd.f_doc_name,");
			sql.append("       ofd.f_doc_fontsize,");
			sql.append("       '1',");
			sql.append("       ofd.f_org_id,");
			sql.append("       ofd.f_org_name,");
			sql.append("       ofd.f_dept_id,");
			sql.append("       ofd.f_dept_name,");
			sql.append("       ofd.f_attach_id,");
			sql.append("       ofd.f_submit_user_id,");
			sql.append("       ofd.f_submit_user_name,");
			sql.append("       to_char(ofd.f_creator_time, 'yyyy-MM-dd') f_creator_time,");
			sql.append("       ofd.f_user_id,");
			sql.append("       to_char(ofd.f_submit_time, 'yyyy-MM-dd') f_submit_time,");
			sql.append("       '1',");
			sql.append("       '1' datahome,");
			sql.append("       ofd.f_attach_id fj,");
			sql.append("       ofd.f_gongwen_id gongwen_id,");
			sql.append("       ofd.f_flow_state");
			sql.append("  from oa_file_doc ofd");
			if(!"2".equals(model.getPageType())){
				sql.append(" where ofd.f_flow_state = '1' or ofd.f_flow_state = '0'");
				if (!StringUtil.nullOrBlank(model.getF_create_user_id())){
					sql.append("   and ofd.f_submit_user_id = '"+model.getF_create_user_id()+"'");
				}
			}else{
				sql.append(" where (ofd.f_flow_state <> '1' and ofd.f_flow_state <> '0')");
				if (!StringUtil.nullOrBlank(model.getF_create_user_id())){
					sql.append("   and ofd.f_submit_user_id = '"+model.getF_create_user_id()+"'");
				}
			}
			sql.append(") ofb where 1=1"); 
			if (!StringUtil.nullOrBlank(model.getF_org_id())){
				sql.append("   and ofb.f_org_id = '"+model.getF_org_id()+"'");
			}
			if (!StringUtil.nullOrBlank(model.getF_dept_id())){
				sql.append("   and ofb.f_dept_id = '"+model.getF_dept_id()+"'");
			}
			if (!StringUtil.nullOrBlank(model.getF_title())){
				sql.append("   and ofb.f_title like '%"+model.getF_title()+"%'");
			}
			if (!StringUtil.nullOrBlank(model.getF_file_no())){
				sql.append("   and ofb.f_file_no like '%"+model.getF_file_no()+"%'");
			}
			sql.append(" order by " + sortName + " " + sortOrder);
			// 调父类的方法
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			List<Map<String, String>> list = (List<Map<String, String>>)pb.getList();
			for(Map<String, String> map : list){
				Object f_archive_type = map.get("f_archive_type");
				map.put("f_archive_type_name", FileDocBeforeArchiveBean.getArchivePageName(StringUtil.deNull(f_archive_type)));
			}
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 getfileDocBeforeArchiveBeanById
	 * @param id
	 * @param conn
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileDocDao#getfileDocBeforeArchiveBeanById(java.lang.String, java.sql.Connection)
	 */
	@Override
	public Map<String, String> getfileDocBeforeArchiveBeanById(String id,
			Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select ofb.f_id,");
		sql.append("   ofb.f_title,");
		sql.append("   ofb.f_file_no,");
		sql.append("   ofb.f_archive_type,");
		sql.append("   ofb.f_org_id,");
		sql.append("   ofb.f_org_name,");
		sql.append("   ofb.f_dept_id,");
		sql.append("   ofb.f_dept_name,");
		//sql.append("   ofb.f_oldfile_content,");
		sql.append("   ofb.f_oldfile_type,");
		//sql.append("   ofb.f_mainfile_content,");
		sql.append("   ofb.f_mainfile_type,");
		sql.append("   ofb.f_attach_id,");
		sql.append("   ofb.f_create_user_id,");
		sql.append("   (select user_realname from td_sm_user where user_id = ofb.f_create_user_id) f_create_user_name,");
		sql.append("   to_char(ofb.f_create_date,'yyyy-MM-dd') f_create_date,");
		sql.append("   (select user_realname from td_sm_user where user_id = ofb.f_archive_user_id) f_archive_user_name,");
		sql.append("   to_char(ofb.f_archive_date,'yyyy-MM-dd') f_archive_date,");
		sql.append("   ofb.f_is_archived");
		sql.append("  from oa_file_before_archive_info ofb");
		sql.append(" where ofb.f_id = ?");
		return super.queryToSingleMap(conn, sql.toString(), id);
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 insertAttachForFileDoc
	 * @param id
	 * @param conn
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileDocDao#insertAttachForFileDoc(java.lang.String, java.sql.Connection)
	 */
	@Override
	public void insertAttachForFileDoc(String userId,String mFilePath,Map<String, String> bean,String fjId,Connection conn)
		throws Exception{
		//参考  FileUploadServlet
		FiletransferService ft = new FiletransferServiceImpl();
		StringBuffer sql = new StringBuffer();
		//1:原文添加
		String oldFileType = bean.get("f_oldfile_type");
		String oldFileName = "原文"+oldFileType;
		String djsn = StringUtil.getUUID();
		String djsnURL = djsn+"_" + FileUtils.getSysTime();
		sql.append("insert into oa_fc_attach");
		sql.append("  (extend,");
		sql.append("   djbh,");
		sql.append("   dj_sn,");
		sql.append("   filename,");
		sql.append("   attachid,");
		sql.append("   bz,");
		sql.append("   djsn,");
		sql.append("   attachcontent,");
		sql.append("   filepos,");
		sql.append("   upload_mode,");
		sql.append("   cc_form_instanceid,");
		sql.append("   creator)");
		sql.append("values");
		sql.append("  ('"+oldFileType+"',");
		sql.append("   '"+fjId+"',");
		sql.append("   null,");
		sql.append("   '"+oldFileName+"',");
		sql.append("   '"+ft.getAttachId()+"',");
		sql.append("   null,");
		sql.append("   '"+djsn+"',");
		sql.append("   (select f_oldfile_content from oa_file_before_archive_info where f_id = '"+bean.get("f_id")+"'),");
		sql.append("   '"+mFilePath+djsnURL+oldFileType+"',");
		sql.append("   '1',");//文件存取模式：1-数据库、2-本地磁盘、3-FTP远程服务器
		sql.append("   null,");
		sql.append("   '"+userId+"')");
		DBUtil pdb = new DBUtil();
		pdb.executeInsert(sql.toString(), conn);
		//1:正文添加
		oldFileType = bean.get("f_mainfile_type");
		oldFileName = "正文"+oldFileType;
		djsn = StringUtil.getUUID();
		djsnURL = djsn+"_" + FileUtils.getSysTime();
		sql = new StringBuffer();
		sql.append("insert into oa_fc_attach");
		sql.append("  (extend,");
		sql.append("   djbh,");
		sql.append("   dj_sn,");
		sql.append("   filename,");
		sql.append("   attachid,");
		sql.append("   bz,");
		sql.append("   djsn,");
		sql.append("   attachcontent,");
		sql.append("   filepos,");
		sql.append("   upload_mode,");
		sql.append("   cc_form_instanceid,");
		sql.append("   creator)");
		sql.append("values");
		sql.append("  ('"+oldFileType+"',");
		sql.append("   '"+fjId+"',");
		sql.append("   null,");
		sql.append("   '"+oldFileName+"',");
		sql.append("   '"+ft.getAttachId()+"',");
		sql.append("   null,");
		sql.append("   '"+djsn+"',");
		sql.append("   (select f_mainfile_content from oa_file_before_archive_info where f_id = '"+bean.get("f_id")+"'),");
		sql.append("   '"+mFilePath+djsnURL+oldFileType+"',");
		sql.append("   '1',");//文件存取模式：1-数据库、2-本地磁盘、3-FTP远程服务器
		sql.append("   null,");
		sql.append("   '"+userId+"')");
		pdb.executeInsert(sql.toString(), conn);
		//3迁移其他附件
		if(!StringUtil.nullOrBlank(bean.get("f_attach_id"))){
			sql = new StringBuffer();
			sql.append("select djsn from oa_fc_attach where djbh = '"+bean.get("f_attach_id")+"'");
			pdb.executeSelect(sql.toString(), conn);
			for (int i = 0; i < pdb.size(); i++) {
				//附件 逐个 复制
				String tmpDJSN = pdb.getString(i, "djsn");
				if(tmpDJSN!=null){
					sql = new StringBuffer();
					djsn = StringUtil.getUUID();
					djsnURL = djsn+"_" + FileUtils.getSysTime();
					sql.append("insert into oa_fc_attach");
					sql.append("  (extend,");
					sql.append("   djbh,");
					sql.append("   dj_sn,");
					sql.append("   filename,");
					sql.append("   attachid,");
					sql.append("   bz,");
					sql.append("   djsn,");
					sql.append("   attachcontent,");
					sql.append("   filepos,");
					sql.append("   upload_mode,");
					sql.append("   cc_form_instanceid,");
					sql.append("   creator)");
					sql.append("  select extend,");
					sql.append("         '"+fjId+"',");//关联业务数据的code
					sql.append("         dj_sn,");
					sql.append("         filename,");
					sql.append("         '"+ft.getAttachId()+"',");//递增的column
					sql.append("         bz,");
					sql.append("         '"+djsn+"',");//附件ID
					sql.append("         attachcontent,");
					sql.append("         '"+mFilePath+djsnURL+"'||extend,");//url
					sql.append("         upload_mode,");
					sql.append("         cc_form_instanceid,");
					sql.append("         '"+userId+"'");
					sql.append("    from oa_fc_attach");
					sql.append("   where djsn = '"+tmpDJSN+"'");
					pdb.executeInsert(sql.toString(), conn);
				}
			}
		}
		
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 updateFileDocBeforeArchiveBeanByBean
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileDocDao#updateFileDocBeforeArchiveBeanByBean(com.chinacreator.xtbg.core.file.entity.FileDocBeforeArchiveBean, java.sql.Connection)
	 */
	@Override
	public String updateFileDocBeforeArchiveBeanByBean(
			FileDocBeforeArchiveBean bean, Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("update oa_file_before_archive_info");
		sql.append("   set F_IS_ARCHIVED     = '"+bean.getF_is_archived()+"',");
		sql.append("       F_ARCHIVE_USER_ID = '"+bean.getF_archive_user_id()+"',");
		sql.append("       F_ARCHIVE_DATE    = to_date('"+bean.getF_archive_date()+"', 'yyyy-MM-dd hh24:mi:ss')");
		sql.append(" where F_ID = '"+bean.getF_id()+"'");
		DBUtil pdb = new DBUtil();
		pdb.executeInsert(sql.toString(), conn);
		return null;
	}
	
	public Map<String,String> getNewMessForInsert(String userId,String fileType,String deptId,String f_files_id,Connection conn) throws Exception {
		/*StringBuffer sql = new StringBuffer();
		if(f_files_id.length()==0){
			sql.append("select *");
			sql.append("  from oa_file_doc ofd");
			sql.append("  left join oa_file_pan_ext ofpe");
			sql.append("    on ofd.f_doc_id = ofpe.f_doc_id");
			sql.append(" where ofd.f_dept_id = ?");
			sql.append("   and ofd.f_type_id = ?");
			sql.append(" order by ofd.f_creator_time desc");
		}else{
			sql.append("select *");
			sql.append("  from oa_file_doc ofd");
			sql.append("  left join oa_file_pan_ext ofpe");
			sql.append("    on ofd.f_doc_id = ofpe.f_doc_id");
			sql.append(" where ofd.f_dept_id = ?");
			sql.append("   and ofd.f_type_id = ?");
			sql.append("   and ofd.f_doc_id in (select f_doc_id from oa_file_docfiles where f_files_id = '"+f_files_id+"')");
			sql.append(" order by ofd.f_creator_time desc");
		}
		
		Map<String,String> map = super.queryToSingleMap(conn, sql.toString(),deptId,fileType);*/
		
		
		FileDocBean bean = new FileDocBean();
		bean.setF_dept_id(deptId);
		bean.setF_type_id(fileType);
		Map<String,String> map = new HashMap<String,String>();
		map.put("f_doc_num", ""+this.getMaxFDocNumByBean(bean, conn, f_files_id));
		return map;
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * getMaxFDocNumByBean(获得最大的件号)
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public int getMaxFDocNumByBean(FileDocBean bean,Connection conn,String f_files_id) throws Exception{
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT NVL(MAX(OFD.F_DOC_NUM),0) F_DOC_NUM");
		sql.append("  FROM OA_FILE_DOC OFD             ");
		sql.append(" WHERE  f_doc_year = to_char(SYSDATE,'yyyy') and OFD.F_DEPT_ID = '"+bean.getF_dept_id()+"' and OFD.F_TYPE_ID = '"+bean.getF_type_id()+"'");
		
		DBUtil pdb = new DBUtil();
		pdb.executeSelect(sql.toString(), conn);
		int count = 0;
		if(pdb.size()==1){
			count = pdb.getInt(0, "f_doc_num");
		}
		return count;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 queryFileDocToDeptList
	 * @param model
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileDocDao#queryFileDocToDeptList(com.chinacreator.xtbg.core.file.entity.FileDocBean, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean queryFileDocToDeptList(FileDocBean model,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			sql.append("select ofd.f_doc_id,");
			sql.append("       ofd.f_doc_name,");
			sql.append("       ofd.f_doc_fontsize,");
			sql.append("       ofd.f_type_id,");
			sql.append("       ofd.f_type_name,");
			sql.append("       ofd.f_doc_keywords,");
			sql.append("       ofd.f_doc_year,");
			sql.append("       ofd.f_secrecy_id,");
			sql.append("       ofd.f_secrecy_name,");
			sql.append("       ofd.f_org_id,");
			sql.append("       ofd.f_org_name,");
			sql.append("       ofd.f_dept_id,");
			sql.append("       ofd.f_dept_name,");
			sql.append("       ofd.f_doc_checkuser,");
			sql.append("       ofd.f_doc_blname,");
			sql.append("       TO_CHAR(f_file_formtime, 'yyyy-mm-dd') f_file_formtime,");
			sql.append("       ofd.f_file_quantity,");
			sql.append("       ofd.f_doc_content f_type_remark,");//目前备注列无用
			sql.append("       ofd.f_user_id,");
			sql.append("       ofd.f_user_name,");
			sql.append("       ofd.f_creator_time,");
			sql.append("       ofd.f_doc_content,");
			sql.append("       countttt.countt f_attach_id,");
			sql.append("       ofd.f_doc_state,");
			sql.append("       ofd.f_doc_state_name,");
			sql.append("       ofd.f_file_no,");
			sql.append("       ofd.f_typeno,");
			sql.append("       ofd.f_doc_num,");
			sql.append("       ofd.f_info_num,");
			sql.append("       ofd.f_doc_media,");
			sql.append("       ofd.f_doc_media_name,");
			sql.append("       ofd.f_entity_type,");
			sql.append("       ofd.f_entity_type_name,");
			sql.append("       ofd.f_burn_user_id,");
			sql.append("       ofd.f_burn_user_name,");
			sql.append("       ofd.f_file_num,");
			sql.append("       ofd.f_doc_deadline,");
			sql.append("       ofd.f_file_userid,");
			sql.append("       ofd.f_file_username,");
			sql.append("       ofd.f_file_time,");
			sql.append("       TO_CHAR(ofd.f_file_time, 'yyyy-mm-dd') f_file_time_str,");
			sql.append("       ofd.f_info_type,");
			sql.append("       ofd.f_info_type_name,");
			sql.append("       ofd.f_file_num_unit,");
			sql.append("       ofd.f_file_num_unit_name,");
			sql.append("       ofd.f_doc_deadline_name,");
			sql.append("       case when sysdate-f_file_formtime>365 then round((sysdate-f_file_formtime)/365)||'年' when sysdate-f_file_formtime>30 then round((sysdate-f_file_formtime)/30)||'个月' else round(sysdate-f_file_formtime)||'天' end f_doc_yi_deadline");
			sql.append("  from oa_file_doc ofd ");
			sql.append("  left join (select fpi.f_doc_id, count(1) countt");
			sql.append("               from oa_file_doc fpi");
			sql.append("               inner join oa_fc_attach fa");
			sql.append("                  on fpi.f_attach_id = fa.djbh");
			sql.append("             group by fpi.f_doc_id) countttt");
			sql.append("    on   ofd.f_doc_id = countttt.f_doc_id");
			sql.append("    where 1=1 ");
			sql.append("   and ofd.f_flow_state='2'");
			sql.append("   and ofd.f_doc_state<>'"+FileDocBean.F_DOC_STATE_DESTROY+"'");
			if(!StringUtil.nullOrBlank(model.getF_type())){ //选择待销毁文件列表 
				sql.append(" and f_destroy_state ='0' and ofd.f_doc_state='2'");
				
				if(!StringUtil.nullOrBlank(model.getNotInId())){ //选择待销毁文件列表 
					sql.append(" and ofd.f_doc_id not in (select * from table(split('"+model.getNotInId().substring(0,model.getNotInId().length()-1)+"')))");
				}
			}
			if (!StringUtil.nullOrBlank(model.getF_doc_name())){
				sql.append(" and f_doc_name like '%"+model.getF_doc_name()+"%'");
			}
			if (!StringUtil.nullOrBlank(model.getF_type_id())){
				//sql.append(" and f_type_id = '"+model.getF_type_id()+"'");
				sql.append(" and ofd.f_type_id in (select f_type_id from oa_file_type start with f_type_id = '"+model.getF_type_id()+"' connect by prior f_type_id = f_parent_type_id)");
			}
			
			if (!StringUtil.nullOrBlank(model.getF_dept_name())){
				sql.append(" and f_dept_name like '%"+model.getF_dept_name()+"%'");
			}
			if (!StringUtil.nullOrBlank(model.getF_doc_state())){
				sql.append(" and f_doc_state = '"+model.getF_doc_state()+"'");
			}
			if (!StringUtil.nullOrBlank(model.getF_doc_fontsize())){
				sql.append(" and f_doc_fontsize like '%"+model.getF_doc_fontsize()+"%'");
			}
			if (!StringUtil.nullOrBlank(model.getF_doc_year())){
				sql.append(" and f_doc_year = '"+model.getF_doc_year()+"'");
			}
			if (!StringUtil.nullOrBlank(model.getF_dept_id())){
				sql.append(" and ofd.f_dept_id = '"+model.getF_dept_id()+"'");
				
			}
			if (!StringUtil.nullOrBlank(model.getF_org_id())){
				sql.append(" and ofd.f_org_id = '"+model.getF_org_id()+"'");
			}
			
			//+件号
			if (!StringUtil.nullOrBlank(model.getF_doc_num())){
				sql.append(" and F_doc_num like '%"+model.getF_doc_num()+"%'");
			}
			//+附件数量下限
			if (!StringUtil.nullOrBlank(model.getF_attach_id_min())){
				sql.append(" and (select count(1) from oa_fc_attach fa where fa.djbh=ofd.f_attach_id)>= "+model.getF_attach_id_min()+"");
			}
			//+附件数量上限
			if (!StringUtil.nullOrBlank(model.getF_attach_id_max())){
				sql.append(" and (select count(1) from oa_fc_attach fa where fa.djbh=ofd.f_attach_id)<= "+model.getF_attach_id_max()+"");
			}
			
			//+备注栏(密级)  f_secrecy_name
			if (!StringUtil.nullOrBlank(model.getF_secrecy_name())) {
				sql.append(" and instr(','||'"+model.getF_secrecy_name()+"'||',',','||ofd.f_secrecy_name||',')>0 ");				
			}
			//+文件生成时间
			if(!StringUtil.nullOrBlank(StringUtil.deNull(model.getStart_time()))){
				sql.append(" and ofd.f_creator_time >= to_date('"+model.getStart_time()+"','yyyy-MM-dd') ");
			}
			if(!StringUtil.nullOrBlank(StringUtil.deNull(model.getEnd_time()))){
				sql.append(" and ofd.f_creator_time <= to_date('"+model.getEnd_time()+"','yyyy-MM-dd') ");
			}
			if("f_doc_num".equals(sortName)){
				sql.append(" order by ofd.f_doc_year desc," + sortName + " " + sortOrder+",ofd.f_creator_time desc");
			}else{
				sql.append(" order by " + sortName + " " + sortOrder+",ofd.f_creator_time desc");
			}
			
			// 调父类的方法
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	
	public boolean tuihui(String ids,String contentStr,String sendUserId,String sendUserName,boolean isDX,boolean isXX,String message_content){

		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			//1
			String[] arr = ids.split(",");
			FileTypeDao daoType = new FileTypeDaoImpl();
			flag=daoType.tuihui(arr,conn,message_content);
			
			//2提取用户
			NoteServiceImpl nsi=new NoteServiceImpl();
			MessageUtil util=new MessageUtil();
			List<NoteDetailBean> listT = new ArrayList<NoteDetailBean>();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select tsu.user_id,");
			sql.append("       tsu.user_realname,");
			sql.append("       nvl(tsu.user_mobiletel1, tsu.USER_MOBILETEL2) user_mobiletel1");
			sql.append("  from td_sm_user tsu");
			sql.append(" where user_id in (");
			sql.append(" select distinct f_submit_user_id from oa_file_doc where instr('"+ids+"',f_doc_id)>0)");
			DBUtil pdb = new DBUtil();
			pdb.executeSelect(sql.toString(), conn);
			for (int i = 0; i < pdb.size(); i++) {
				String userId = pdb.getString(i, "user_id");
				String user_realname = pdb.getString(i, "user_realname");
				String user_mobiletel1 = pdb.getString(i, "user_mobiletel1");
				if(user_mobiletel1==null||user_mobiletel1.length()==0){
					continue;
				}
				if(isDX){
					
					NoteDetailBean smsSendBean = new NoteDetailBean();
					smsSendBean.setPhone_num(user_mobiletel1);
					smsSendBean.setUser_name(user_realname);
					smsSendBean.setUser_id(userId);
					listT.add(smsSendBean);
					
					NoteBufferBean nBean = new NoteBufferBean();
					StringBuffer content = new StringBuffer(contentStr+"("+sendUserName+"发送)");
					nBean.setContent(content.toString());
					nBean.setUser_name(sendUserName);
					nsi.doNoteSend(nBean,listT,conn);
				}
				if(isXX){
					List<String> user_list=new ArrayList<String>();
					user_list.add(userId);
					util.sendMsg(contentStr, sendUserId, user_list, conn);
				}
			}
			conn.commit();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	
	}
	public boolean tuihuifiles(String ids,String contentStr,String sendUserId,String sendUserName,boolean isDX,boolean isXX,String message_content){
		
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			//1
			String[] arr = ids.split(",");
			String sql1 = "update OA_FILE_files  set F_FLOW_STATE = '1',F_ROLLBACK_IDEA=? where f_files_id= ?";
			PreparedDBUtil db = null;
			db = new PreparedDBUtil();
			for(int i=0; i< arr.length ;i++){ //子节点成1开始遍历
				db.preparedUpdate(sql1.toString());
				db.setString(1, message_content);
				db.setString(2,arr[i]);
				db.addPreparedBatch();
			}
			db.executePreparedBatch(conn);
			
			//2提取用户
			NoteServiceImpl nsi=new NoteServiceImpl();
			MessageUtil util=new MessageUtil();
			List<NoteDetailBean> listT = new ArrayList<NoteDetailBean>();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select tsu.user_id,");
			sql.append("       tsu.user_realname,");
			sql.append("       nvl(tsu.user_mobiletel1, tsu.USER_MOBILETEL2) user_mobiletel1");
			sql.append("  from td_sm_user tsu");
			sql.append(" where user_id in (");
			sql.append(" select distinct f_submit_user_id from oa_file_doc where instr('"+ids+"',f_doc_id)>0)");
			DBUtil pdb = new DBUtil();
			pdb.executeSelect(sql.toString(), conn);
			for (int i = 0; i < pdb.size(); i++) {
				String userId = pdb.getString(i, "user_id");
				String user_realname = pdb.getString(i, "user_realname");
				String user_mobiletel1 = pdb.getString(i, "user_mobiletel1");
				if(user_mobiletel1==null||user_mobiletel1.length()==0){
					continue;
				}
				if(isDX){
					
					NoteDetailBean smsSendBean = new NoteDetailBean();
					smsSendBean.setPhone_num(user_mobiletel1);
					smsSendBean.setUser_name(user_realname);
					smsSendBean.setUser_id(userId);
					listT.add(smsSendBean);
					
					NoteBufferBean nBean = new NoteBufferBean();
					StringBuffer content = new StringBuffer(contentStr+"("+sendUserName+"发送)");
					nBean.setContent(content.toString());
					nBean.setUser_name(sendUserName);
					nsi.doNoteSend(nBean,listT,conn);
				}
				if(isXX){
					List<String> user_list=new ArrayList<String>();
					user_list.add(userId);
					util.sendMsg(contentStr, sendUserId, user_list, conn);
				}
			}
			conn.commit();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
		
	}
}
