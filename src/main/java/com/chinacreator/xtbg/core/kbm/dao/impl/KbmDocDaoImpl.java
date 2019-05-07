package com.chinacreator.xtbg.core.kbm.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringSplitUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.kbm.dao.KbmDocDao;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocBean;
import com.chinacreator.xtbg.core.kbm.util.KbmConstants;
import com.chinacreator.xtbg.core.kbm.util.KbmUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:KbmDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-8-6
 */
public class KbmDocDaoImpl extends XtDbBaseDao implements KbmDocDao {

	 /** 
	  * <b>Summary: </b>
	  *     复写方法 queryKbmDocList
	  * @param model
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.file.dao.KbmDocDao#queryKbmDocList(com.chinacreator.xtbg.core.file.entity.KbmDocBean, java.lang.String, java.lang.String, long, int) 
	  */
	public PagingBean queryKbmDocList(KbmDocBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		try {
			//特检院OA  添加角色查看 2014-03-28 start
			AccessControl accesscontroler = AccessControl.getAccessControl();
			String userId = accesscontroler.getUserID();//当前发送人 登录名
			//副总工程师
			boolean isEngineer = KbmUtil.isRolesUser(userId, KbmConstants.ENGINEER_ROLE_NAME);
			//总工/院长
			boolean isDean = KbmUtil.isRolesUser(userId, KbmConstants.DEAN_ROLE_NAME);
			//质保工程师
			boolean isWarrantor = KbmUtil.isRolesUser(userId, KbmConstants.WARRANTOR_ROLE_NAME);
			//特检院OA  添加角色查看 2014-03-28 end
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			String opentype = model.getOpentype();
			//sql.append(" select * from OA_KBM_DOC where 1=1 ");
			sql.append("select k_doc_id,");
			sql.append("       k_title,");
			sql.append("       k_code,");
			sql.append("       k_type_id,");
			sql.append("       k_type_name,");
			sql.append("       k_key,");
			sql.append("       k_secrecy_id,");
			sql.append("       k_secrecy_name,");
			sql.append("       k_unit,");
			sql.append("       k_unit_name,");
			sql.append("       k_dept,");
			sql.append("       k_dept_name,");
			sql.append("       k_first_time,");
			sql.append("       k_create_time,");
			sql.append("       k_create_user,");
			sql.append("       k_create_user_name,");
			sql.append("       k_contents,");
			sql.append("       k_attach_id,");
			sql.append("       k_flag,");
			sql.append("       k_flag_name,");
			sql.append("       k_remark,");
			sql.append("       k_check_time,");
			sql.append("       k_check_user,");
			sql.append("       k_check_user_name,");
			sql.append("       k_check_info,");
			sql.append("       k_dcount,");
			sql.append("       k_update_time,");
			sql.append("       k_approval_time,");
			sql.append("       k_approval_user,");
			sql.append("       k_approval_user_name,");
			sql.append("       k_approval_info,");
			sql.append("       k_receive_deptid,");
			sql.append("       k_receive_deptname,");
			sql.append("       k_upload_type,");
			sql.append("       a.djsn as djsn,");
			sql.append("       a.extend as file_type,");
			sql.append("       a.filename as filename,");
			sql.append("       (select count(*) from oa_kbm_docreceiveuser o where o.k_doc_id = t.k_doc_id and o.k_isview = '1')||'/'|| ");
			sql.append("       (select count(*) from oa_kbm_docreceiveuser o where o.k_doc_id = t.k_doc_id )  as v_number ");
			sql.append("  from OA_KBM_DOC t ");
			sql.append("  left join oa_fc_attach a on t.k_attach_id = a.djbh");
			sql.append("   where 1=1 ");
			if("unpublish".equalsIgnoreCase(opentype)){
				
				//特检院OA 【未发布】列表   【待审核】、【待批准】、【不通过】、【待发布】  2014-03-28 start
				//sql.append(" and (k_flag='"+KbmConstants.FLAG_DRAFT+"' or k_flag='"+KbmConstants.FLAG_PENDING+"' or k_flag='"+KbmConstants.FLAG_UNPASS+"') ");
				sql.append(" and (k_flag='"+KbmConstants.FLAG_DRAFT+"' or k_flag='"+KbmConstants.FLAG_PENDING +"' or k_flag='"+KbmConstants.FLAG_PASS+"' or k_flag='"+"' or k_flag='"+KbmConstants.FLAG_APPROVAL_PASS+"' or k_flag='"+KbmConstants.FLAG_UNPASS+"') ");
				//特检院OA  【未发布】列表   【待审核】、【待批准】、【不通过】、【待发布】  2014-03-28 end
				sql.append(" and k_create_user = '"+model.getK_create_user()+"' ");
			}else if ("published".equalsIgnoreCase(opentype)){//已发布即已审核通过
				
				//特检院OA 【已发布】列表   【已发布】  2014-03-28 start
				//sql.append(" and k_flag='"+KbmConstants.FLAG_PASS+"'");
				sql.append(" and k_flag='"+KbmConstants.FLAG_PUBLISH_PASS+"'");
				//特检院OA 【已发布】列表   【已发布】  2014-03-28 end
				if(!StringUtil.nullOrBlank(model.getK_create_user())){
					sql.append(" and k_create_user = '"+model.getK_create_user()+"' ");	
				}
				
			}else if ("uncheck".equalsIgnoreCase(opentype)){//待处理  
				//特检院OA 【待处理】列表     2014-03-28 start
				//sql.append(" and k_flag='"+KbmConstants.FLAG_PENDING+"'");
				sql.append(" and ( 1!=1  ");
				if(isEngineer == true){
					sql.append(" or  k_flag='"+KbmConstants.FLAG_PENDING+"'");// 待审核
				}
				if(isDean == true ){
					sql.append(" or  k_flag='"+KbmConstants.FLAG_PASS+"'");// 待批准
				}
				if(isWarrantor == true){
					sql.append(" or  k_flag='"+KbmConstants.FLAG_APPROVAL_PASS+"'");//待发布
				}
				sql.append(")");
				//特检院OA 【待处理】列表     2014-03-28 end
			}else if ("checked".equalsIgnoreCase(opentype)){//已处理
				//特检院OA 【已处理】列表     2014-03-28 start
				//sql.append(" and (k_flag='"+KbmConstants.FLAG_UNPASS+"' or k_flag='"+KbmConstants.FLAG_PASS+"')");
				sql.append(" and ( 1!=1  ");
				if(isEngineer == true){
					sql.append(" or k_flag='"+KbmConstants.FLAG_UNPASS+"' or k_flag='"+KbmConstants.FLAG_PASS+"' or k_flag='"+KbmConstants.FLAG_APPROVAL_PASS+"' or k_flag='"+KbmConstants.FLAG_PUBLISH_PASS+"' ");
				}
				if(isDean == true ){
					sql.append(" or k_flag='"+KbmConstants.FLAG_UNPASS+"' or k_flag='"+KbmConstants.FLAG_APPROVAL_PASS+"' or k_flag='"+KbmConstants.FLAG_PUBLISH_PASS+"'");
				}
				if(isWarrantor == true){
					sql.append(" or k_flag='"+KbmConstants.FLAG_UNPASS+"' or k_flag='"+KbmConstants.FLAG_PUBLISH_PASS+"'");
				}
				sql.append(")");
				//特检院OA 【已处理】列表     2014-03-28 end
			}
			if(!StringUtil.nullOrBlank(model.getK_title())){//标题
				sql.append(" and k_title like '%"+model.getK_title()+"%'");
			}
			if(!StringUtil.nullOrBlank(model.getK_type_id())){//分类
				sql.append(" and k_type_id = '"+model.getK_type_id()+"'");
			}
			if(!StringUtil.nullOrBlank(model.getK_create_time())){//上传时间
				String str = model.getK_create_time().toString();
				String bt=str.substring(0, str.indexOf(","));
				String et=str.substring(str.indexOf(",")+1);
				
				if(!StringUtil.nullOrBlank(bt)&&!StringUtil.nullOrBlank(et)){
					sql.append(" and to_char(k_create_time, 'yyyy-mm-dd') BETWEEN '"+bt+"' AND '"+et+"' ");
				}else if(!StringUtil.nullOrBlank(bt)){
					sql.append(" and to_char(k_create_time, 'yyyy-mm-dd')>= '"+bt+"' ");
				}else if(!StringUtil.nullOrBlank(et)){
					sql.append(" and to_char(k_create_time, 'yyyy-mm-dd')<= '"+et+"'");
				}
			}
			if(!StringUtil.nullOrBlank(model.getK_create_user_name())){//上传人
				sql.append(" and k_create_user_name like '%"+model.getK_create_user_name()+"%'");
			}
			if(!StringUtil.nullOrBlank(model.getK_flag())){//审核状态
				sql.append(" and k_flag = '"+model.getK_flag()+"'");
			}
			//条件过滤
			
			sql.append(" order by " + sortName + " " + sortOrder);
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 queryKbmDocList4Where 知识库查询
	  * @param model
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocDao#queryKbmDocList4Where(com.chinacreator.xtbg.core.kbm.entity.KbmDocBean, java.lang.String, java.lang.String, long, int) 
	  */
	public PagingBean queryKbmDocList4Where(KbmDocBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			String opentype = model.getOpentype();
			String userid="";
			if(!StringUtil.nullOrBlank(model.getK_create_user())){
				userid=model.getK_create_user();
			}
			sql.append("select d.*,a.djsn,a.filename,a.extend as file_type from OA_KBM_DOC d");
			sql.append("  left join oa_fc_attach a  on d.k_attach_id = a.djbh");
			sql.append("  left join ");
			sql.append(" (select * from OA_KBM_DOC_OPERATE_LOG okdol where okdol.k_create_user='"+userid+"') ");
			sql.append(" l on d.k_doc_id=l.k_doc_id  where 1=1 ");
			//特检院OA 列表查询已发布数据     2014-03-28 start
			//sql.append(" and d.k_flag='"+KbmConstants.FLAG_PASS+"'");
			sql.append(" and d.k_flag='"+KbmConstants.FLAG_PUBLISH_PASS+"'");
			//特检院OA 列表查询已发布数据     2014-03-28 end
			if(!StringUtil.nullOrBlank(model.getK_type_id())&& !"0".equals(model.getK_type_id())){//分类
				sql.append(" and d.k_type_id in (select k_type_id from oa_kbm_doc_type start with k_type_id= '"+model.getK_type_id()+"' connect by prior k_type_id=k_parent_type_id ) ");
			}
			if(!StringUtil.nullOrBlank(model.getK_title())){//标题
				sql.append(" and d.k_title like '%"+model.getK_title()+"%'");
			}
			if(!StringUtil.nullOrBlank(model.getK_code())){//编号
				sql.append(" and d.k_code like '%"+model.getK_code()+"%'");
			}
			if(!StringUtil.nullOrBlank(model.getK_dept())){//部门
				sql.append(" and d.k_dept = '"+model.getK_dept()+"'");
			}
			if(!StringUtil.nullOrBlank(model.getK_create_time())){//上传时间
				String str = model.getK_create_time().toString();
				String bt=str.substring(0, str.indexOf(","));
				String et=str.substring(str.indexOf(",")+1);
				
				if(!StringUtil.nullOrBlank(bt)&&!StringUtil.nullOrBlank(et)){
					sql.append(" and to_char(d.k_create_time, 'yyyy-mm-dd') BETWEEN '"+bt+"' AND '"+et+"' ");
				}else if(!StringUtil.nullOrBlank(bt)){
					sql.append(" and to_char(d.k_create_time, 'yyyy-mm-dd')>= '"+bt+"' ");
				}else if(!StringUtil.nullOrBlank(et)){
					sql.append(" and to_char(d.k_create_time, 'yyyy-mm-dd')<= '"+et+"'");
				}
			}
			if(!StringUtil.nullOrBlank(model.getK_create_user_name())){//上传人
				sql.append(" and d.k_create_user_name like '%"+model.getK_create_user_name()+"%'");
			}
			
			if ("query".equalsIgnoreCase(opentype) && !StringUtil.nullOrBlank(model.getK_doc_id())) {
				if (!StringUtil.nullOrBlank(model.getK_key())) {// 相关文档关键字
					if (model.getK_key().indexOf(",") > -1) {
						String arr[] = model.getK_key().split(",");
						String whereSql = " 1=2 ";
						for (int i = 0; i < arr.length; i++) {
							whereSql += " or (d.k_key like '%" + arr[i] + "%') ";
						}
						sql.append(" and (" + whereSql + ")");
					} else {
						sql.append(" and (d.k_key like '%" + model.getK_key()+ "%') ");
					}
				}else{
					sql.append(" and 1=2 ");
				}
			} else {
				if (!StringUtil.nullOrBlank(model.getK_key())) {// 关键字和内容
					sql.append(" and (d.k_key like '%"+model.getK_key()+"%' or d.k_contents like '%"+model.getK_key()+ "%' ) ");
				}
			}
			if("query".equalsIgnoreCase(opentype) && !StringUtil.nullOrBlank(model.getK_doc_id())){//注意这里显示相关文档时要过滤掉本身
				sql.append(" and d.k_doc_id <> '"+model.getK_doc_id()+"' ");
			}
			sql.append(" order by d." + sortName + " " + sortOrder);
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}


	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryAllKbmDocList
	  * @param model
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocDao#queryAllKbmDocList(com.chinacreator.xtbg.core.kbm.entity.KbmDocBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean queryAllKbmDocList(KbmDocBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			List<String> conditionValues = new ArrayList<String>();
			//特检院OA 列表查询已发布数据     2014-03-28 start
			//sql.append(" select * from OA_KBM_DOC t where 1=1  and t.k_flag='1' ");
			sql.append(" select * from OA_KBM_DOC t where 1=1  and t.k_flag='"+KbmConstants.FLAG_PUBLISH_PASS+"' ");
			//特检院OA 列表查询已发布数据     2014-03-28 end
			if(!StringUtil.nullOrBlank(model.getK_title() )){
				sql.append(" and t.k_title like '%'||?||'%' ");
				conditionValues.add(model.getK_title());
			}
			if(!StringUtil.nullOrBlank(model.getK_code() )){
				sql.append(" and t.k_code like '%'||?||'%' ");
				conditionValues.add(model.getK_code());
			}
			if(!StringUtil.nullOrBlank(model.getK_dept_name() )){
				sql.append(" and t.k_dept_name =? ");
				conditionValues.add(model.getK_dept_name() );
			}
			if(!StringUtil.nullOrBlank(model.getK_check_user_name() )){
				sql.append(" and t.k_create_user_name=? ");
				conditionValues.add(model.getK_check_user_name());
			}else{
				if(!StringUtil.nullOrBlank(model.getK_create_user_name() )){
					sql.append(" and t.k_create_user_name like '%'||?||'%' ");
					conditionValues.add(model.getK_create_user_name());
				}
			}
			if(!StringUtil.nullOrBlank(model.getK_key() )){
				sql.append(" and (t.k_key like '%'||?||'%' or t.k_contents like '%'||?||'%' ) ");
				conditionValues.add(model.getK_key());
				conditionValues.add(model.getK_key());
			}
			if(!StringUtil.nullOrBlank(model.getK_type_name() )){
				sql.append(" and t.k_type_name =? ");
				conditionValues.add(model.getK_type_name());
			}
			
			sql.append(" order by " + sortName + " " + sortOrder);
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,conditionValues);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}


	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryKbmUploadTopList
	  * @param model
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocDao#queryKbmUploadTopList(com.chinacreator.xtbg.core.kbm.entity.KbmDocBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean queryKbmUploadTopList(KbmDocBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			List<String> conditionValues = new ArrayList<String>();
			sql.append(" select tr.*, rownum ");
			sql.append(" from (select t.k_create_user_name, ");
			sql.append(" t.k_dept_name, ");
			sql.append(" count(t.k_create_user_name) k_count ");
			//特检院OA 列表查询已发布数据     2014-03-28 start
			//sql.append(" from oa_kbm_doc t where t.k_flag='1' ");
			sql.append(" from oa_kbm_doc t where t.k_flag='"+KbmConstants.FLAG_PUBLISH_PASS+"' ");
			//特检院OA 列表查询已发布数据     2014-03-28 end
			sql.append(" group by t.k_create_user_name, t.k_dept_name order by k_count desc) tr ");
			sql.append(" where 1=1 ");
			
			if(!StringUtil.nullOrBlank(model.getK_dept_name() )){
				sql.append(" and tr.k_dept_name =? ");
				conditionValues.add(model.getK_dept_name() );
			}
			if(!StringUtil.nullOrBlank(model.getK_create_user_name() )){
				sql.append(" and tr.k_create_user_name like '%'||?||'%' ");
				conditionValues.add(model.getK_create_user_name());
			}
			sql.append(" order by " + sortName + " " + sortOrder);
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,conditionValues);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}


	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryKbmDocSuggestList
	  * @param model
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocDao#queryKbmDocSuggestList(com.chinacreator.xtbg.core.kbm.entity.KbmDocBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean queryKbmDocSuggestList(KbmDocBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			List<String> conditionValues = new ArrayList<String>();
			sql.append(" select kbs.k_id, ");
			sql.append(" kbs.k_user, ");
			sql.append(" kbs.k_user_name, ");
			sql.append(" kbs.k_is_read, ");
			sql.append(" kbs.k_read_time, ");
			sql.append(" kb.* ");
			sql.append(" from oa_kbm_doc_suggest kbs ");
			sql.append(" inner join oa_kbm_doc kb ");
			sql.append(" on kbs.k_doc_id = kb.k_doc_id ");
			sql.append(" where 1=1 ");
			
			if(!StringUtil.nullOrBlank(model.getK_user() )){
				sql.append(" and kbs.k_user =? ");
				conditionValues.add(model.getK_user() );
			}
			if(!StringUtil.nullOrBlank(model.getK_title() )){
				sql.append(" and kb.k_title like '%'||?||'%' ");
				conditionValues.add(model.getK_title());
			}
			if(!StringUtil.nullOrBlank(model.getK_code() )){
				sql.append(" and kb.k_code like '%'||?||'%' ");
				conditionValues.add(model.getK_code());
			}
			if(!StringUtil.nullOrBlank(model.getK_dept_name() )){
				sql.append(" and kb.k_dept_name =? ");
				conditionValues.add(model.getK_dept_name() );
			}
			if(!StringUtil.nullOrBlank(model.getK_create_user_name() )){
				sql.append(" and kb.k_create_user_name like '%'||?||'%' ");
				conditionValues.add(model.getK_create_user_name());
			}
			if(!StringUtil.nullOrBlank(model.getK_key() )){
				sql.append(" and (kb.k_key like '%'||?||'%' or kb.k_contents like '%'||?||'%' ) ");
				conditionValues.add(model.getK_key());
				conditionValues.add(model.getK_key());
			}
			if(!StringUtil.nullOrBlank(model.getK_type_name() )){
				sql.append(" and kb.k_type_name =? ");
				conditionValues.add(model.getK_type_name());
			}
			
			sql.append(" order by kb." + sortName + " " + sortOrder);
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,conditionValues);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}


	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryKbmDocFavoritesList
	  * @param model
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocDao#queryKbmDocFavoritesList(com.chinacreator.xtbg.core.kbm.entity.KbmDocBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean queryKbmDocFavoritesList(KbmDocBean model,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			List<String> conditionValues = new ArrayList<String>();
			sql.append(" select f.*,kb.k_create_time as create_time,kb.k_attach_id,a.extend as file_type,a.filename,a.djsn from oa_kbm_doc_favorites f ");
			sql.append(" left join oa_kbm_doc kb on f.k_doc_id = kb.k_doc_id ");
			sql.append(" left join oa_fc_attach a on kb.k_attach_id = a.djbh");
			sql.append(" where 1=1 ");
			
			if(!StringUtil.nullOrBlank(model.getK_title() )){
				sql.append(" and kb.k_title like '%'||?||'%' ");
				conditionValues.add(model.getK_title());
			}
			if(!StringUtil.nullOrBlank(model.getK_code() )){
				sql.append(" and kb.k_code like '%'||?||'%' ");
				conditionValues.add(model.getK_code());
			}
			if(!StringUtil.nullOrBlank(model.getK_dept_name() )){
				sql.append(" and kb.k_dept_name =? ");
				conditionValues.add(model.getK_dept_name() );
			}
			if(!StringUtil.nullOrBlank(model.getK_create_user_name() )){
				sql.append(" and kb.k_create_user_name like '%'||?||'%' ");
				conditionValues.add(model.getK_create_user_name());
			}
			if(!StringUtil.nullOrBlank(model.getK_key() )){
				sql.append(" and (kb.k_key like '%'||?||'%' or kb.k_contents like '%'||?||'%' ) ");
				conditionValues.add(model.getK_key());
				conditionValues.add(model.getK_key());
			}
			if(!StringUtil.nullOrBlank(model.getK_type_name() )){
				sql.append(" and kb.k_type_name =? ");
				conditionValues.add(model.getK_type_name());
			}
			if(!StringUtil.nullOrBlank(model.getK_create_user() )){
				sql.append(" and f.k_create_user =? ");
				conditionValues.add(model.getK_create_user());
			}
			if(!StringUtil.nullOrBlank(model.getK_create_time())){//上传时间
				String str = model.getK_create_time().toString();
				String bt=str.substring(0, str.indexOf(","));
				String et=str.substring(str.indexOf(",")+1);
				
				if(!StringUtil.nullOrBlank(bt)&&!StringUtil.nullOrBlank(et)){
					sql.append(" and to_char(kb.k_create_time, 'yyyy-mm-dd') BETWEEN '"+bt+"' AND '"+et+"' ");
				}else if(!StringUtil.nullOrBlank(bt)){
					sql.append(" and to_char(kb.k_create_time, 'yyyy-mm-dd')>= '"+bt+"' ");
				}else if(!StringUtil.nullOrBlank(et)){
					sql.append(" and to_char(kb.k_create_time, 'yyyy-mm-dd')<= '"+et+"'");
				}
			}
			
			sql.append(" order by f." + sortName + " " + sortOrder);
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,conditionValues);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getKbmDocListByIds 由主键得列表list，暂供打印时用
	  * @param ids
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocDao#getKbmDocListByIds(java.lang.String) 
	  */
	public List<Map<String,String>> getKbmDocListByIds(String ids) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select * from OA_KBM_DOC d where d.K_DOC_ID IN ('"+ids.replaceAll(",", "','")+"')");
		return queryToListMap(sql.toString());
	}
	
	
	
	/**
	*<b>Summary: </b>
	* getKbmDocRssByKey(得到关键字文档的订阅者)
	* @param keys
	* @return
	* @throws Exception 
	*/
	public List<Map<String, String>> getKbmDocRssByKey(String keys,String k_type_id)
			throws Exception {
		List<Map<String, String>> viewMap = new ArrayList<Map<String, String>>();
		String arr[] = keys.split(",");
		String whereSql = "";
		for (int i = 0; i < arr.length; i++) {
			whereSql += " or ','||b.k_key||',' like '%," + arr[i] + ",%' ";
		}
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from oa_kbm_doc_rss b");
		sql.append(" where 1=2 or b.k_type_id='"+k_type_id+"' ");
		sql.append(whereSql);
		viewMap = queryToListMap(sql.toString());
		return viewMap;
	}
	
	
	/**
	*<b>Summary: </b>
	* updatekdcount(更新文档下载数)
	* @param k_doc_id
	* @param conn
	* @return
	* @throws Exception 
	*/
	public boolean updatekdcount(String k_doc_id,Connection conn) throws Exception {
		boolean flag = false;
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("update oa_kbm_doc d set d.k_dcount=d.k_dcount+1 where d.k_doc_id='"+k_doc_id+"'");
		pdb.executeSql(sql.toString(), conn);
		flag=false;
		return flag;
	}
	
	
	/**
	*<b>Summary: </b>
	* selKbmDocByCode(查询编码是否已存在数据)
	* @param k_code
	* @return
	* @throws Exception 
	*/
	public boolean selKbmDocByCode(String k_code) throws Exception{
		boolean flag = false;
		StringBuffer sql = new StringBuffer();
		sql.append("select * from OA_KBM_DOC d where  1=1 ");
		String k_codeTemp = "";
		//查询第二个【-】前面的
		int twoindex = StringSplitUtil.findNumber(k_code,"-",2);
		if(twoindex==0){
			k_codeTemp = k_code;
			sql.append(" and k_code ='"+k_codeTemp+"' ");
		} else {
			k_codeTemp = k_code.substring(0,twoindex);
			sql.append(" and k_code like '"+k_codeTemp+"%' ");
		}
		List<Map<String,String>> list = queryToListMap(sql.toString());
		if(list.size()==0){
			flag = false; 
		} else{
			flag = true; 
		}
		return flag;
	}
	

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getAcceptInfo   根据文档ID获取其对应附件的信息
	  * @param k_doc_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocDao#getAcceptInfo(java.lang.String, java.sql.Connection)
	 */
	public List<Map<String, String>> getAcceptInfo(String k_doc_id) throws Exception {
		List<Map<String, String>> viewMap = new ArrayList<Map<String, String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("select b.file_id,b.file_name,b.file_extra");
		sql.append("  from OA_FILEUPLOAD_KBM b ");
		sql.append("   left join OA_KBM_DOC o  on b.ATTACH_ID = o.K_ATTACH_ID ");
		sql.append("   where o.K_DOC_ID = '"+k_doc_id+"'");
		
		viewMap = queryToListMap(sql.toString());
		return viewMap;
	}


	@Override
	public boolean deleteUpdate(String ids,Connection conn) throws Exception {
		boolean flag = false;
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("update oa_kbm_doc d set d.k_luojishanchu = '1' where d.k_doc_id in ("+ids+")");
		pdb.executeSql(sql.toString(), conn);
		flag=true;
		return flag;
	}
}
