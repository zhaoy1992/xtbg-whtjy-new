package com.chinacreator.xtbg.core.file.dao.imploracle;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.file.dao.FileLendingDetailDao;
import com.chinacreator.xtbg.core.file.entity.FileFilesQueryBean;
import com.chinacreator.xtbg.core.file.entity.FileLendingDetailBean;
import com.chinacreator.xtbg.core.file.entity.FilelendingBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:FileLendingDetailDaoImpl.java</p>
 *<p>Description:借阅明细Dao</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Jul 24, 2013
 */
public class FileLendingDetailDaoImpl extends XtDbBaseDao implements FileLendingDetailDao,FlowBusiDataSaveDao {

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
		String sql = "SELECT OFLD.F_DOC_ID FROM OA_FILE_LENDING_DETAIL OFLD WHERE OFLD.F_LENDING_USERID = ? AND OFLD.f_lending_id IS NULL";
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
	
	
	/**
	 * 
	 *<b>Summary: </b>
	 * queryList(请用一句话描述这个方法的作用)
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	@Override
	public PagingBean queryList(FileFilesQueryBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
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
			sql.append("       OFD.f_file_no,");//文件标题
			sql.append("       DECODE(OFD.f_Doc_State,");
			sql.append("       '0','待归档',");
			sql.append("       '1','不需归档',");
			sql.append("       '2','已归档',");
			sql.append("       '8','已移交',");
			sql.append("       '9','已销毁',f_Doc_State) f_Doc_State,");//档案状态
			sql.append("       OFD.F_FILE_num,");//库存数量
			sql.append("       OFD.F_DEPT_NAME,");//所属部门
			sql.append("       TO_CHAR(OFD.F_CREATOR_TIME, 'yyyy-MM-dd') F_CREATOR_TIME_STR,");//文件形成时间
			sql.append("       OFPP.F_FILE_DETAIL QUERY_PAGE,");
			sql.append("      OFFTT.F_DETAIL_ID,");
			sql.append("      OFD.f_doc_media,");
			sql.append("      OFT.f_type_admin");
			sql.append("  FROM OA_FILE_DOC OFD");
			sql.append(" RIGHT JOIN OA_FILE_LENDING_DETAIL OFFTT");//主表
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
				sql.append(" WHERE OFFTT.F_USER_ID IS NULL AND OFFTT.F_LENDING_USERID = ? AND OFD.F_ORG_ID = ? and  OFFTT.F_LENDING_ID is null");
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
				//9合同管理员
				if (!StringUtil.nullOrBlank(bean.getDagly_id())) {
					sql.append(" AND ','||oft.f_type_admin||',' like '%,'||?||',%'  ");
					conditionValues.add(bean.getDagly_id());
				}
				//10 出一些文档之外
				if (!StringUtil.nullOrBlank(bean.getOut_side_detail_ids())) {
					sql.append(" AND OFFTT.F_DETAIL_ID not in (select * from table(split(?)))  ");
					conditionValues.add(bean.getOut_side_detail_ids());
				}
				if (!StringUtil.nullOrBlank(sortName)
						&& !StringUtil.nullOrBlank(sortOrder)) {
					sql.append(" order by " + sortName + " " + sortOrder+",F_DOC_ID");
				}else{
					sql.append(" order by F_DOC_ID");
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
	 * 查询某借阅人的借阅篮的所有档案文件关联的所有的档案管理员
	 * 初始化页面，和页面异步刷新同时需要
	 */
	public static final String getDAGLYWithJYL_sql ="SELECT USER_ID, USER_REALNAME"+
									"  FROM TD_SM_USER"+
									" WHERE USER_ID IN"+
									"       (SELECT DISTINCT COLUMN_VALUE"+
									"          FROM TABLE (SELECT SPLIT((SELECT WM_CONCAT(DISTINCT F_TYPE_ADMIN)"+
									"                                     FROM OA_FILE_LENDING_DETAIL OFLD"+
									"                                    INNER JOIN OA_FILE_DOC OFD"+
									"                                       ON OFLD.F_DOC_ID = OFD.F_DOC_ID"+
									"                                     LEFT JOIN OA_FILE_TYPE OFT"+
									"                                       ON OFD.F_TYPE_ID = OFT.F_TYPE_ID"+
									"                                    WHERE OFLD.f_lending_id IS NULL AND OFLD.f_lending_userid='{f_lending_userid}')) A"+
									"                        FROM DUAL))"+
									" ORDER BY USER_ID";
	/**
	 * 
	 * 
	 * <b>Summary: </b>
	 *     复写方法 getDAGLYWithJYL
	 * @param userId
	 * @param conn
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileLendingDetailDao#getDAGLYWithJYL(java.lang.String, java.sql.Connection)
	 */
	@Override
	public List<String[]> getDAGLYWithJYL(String userId, Connection conn)
			throws Exception {
		String sql = FileLendingDetailDaoImpl.getDAGLYWithJYL_sql;
		sql = sql.replaceAll("{f_lending_userid}", userId);
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared(conn);
		List<String[]> list = new ArrayList<String[]>();
		for (int j = 0; j < pdb.size(); j++) {
			list.add(new String[]{pdb.getString(j, "USER_ID"),pdb.getString(j, "USER_REALNAME")});
		}
		return list;
	}
	@Override
	public List<Map<String, String>> getFileLendingDetailForJYSQ(
			String[] beanIds, Connection conn) throws Exception {
		if(beanIds!=null&&beanIds.length>0){
			StringBuffer beanIdStr = new StringBuffer();
			for(String id : beanIds){
				if(id.length()>0){
					beanIdStr.append(",'"+id+"'");
				}
			}
			if(beanIdStr.length()>0){
				StringBuffer sql = new StringBuffer();
				sql.append("select ofld.f_detail_id,");
				sql.append("       ofld.f_doc_id,");
				sql.append("       ofd.F_DOC_NUM,"); //--件号
				sql.append("       ofd.F_FILE_NO,"); //--档号
				sql.append("       ofd.f_doc_name,"); //--文件标题
				sql.append("       to_char(ofd.F_FILE_FORMTIME,'yyyy-MM-dd') F_FILE_FORMTIME,"); //--文件形成时间
				sql.append("       ofld.F_LENDING_DAY,"); //--借阅天数
				sql.append("       ofld.F_LENDING_TYPE,"); //--借阅类型
				sql.append("       ofd.f_doc_media,"); //--介质类型
				sql.append("       ofld.F_READ_PURVIEW,"); //--阅读权限
				sql.append("       ofld.F_ISAGREE"); //--是否借阅
				sql.append("  from oa_file_lending_detail ofld, oa_file_doc ofd");
				sql.append(" where ofld.f_doc_id = ofd.f_doc_id");
				sql.append("   and ofld.f_detail_id in ("+beanIdStr.substring(1)+")");
				
				return queryToListMap(sql.toString(), conn);
			}
		}
		return null;
	}
	@Override
	public Map<String, String> getFileLendingDetailBean(String beanId,
			Connection conn) throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select f_lending_id,");
		sql.append("       f_lending_reason,");
		sql.append("       f_lending_userid,");
		sql.append("       f_lending_username,");
		sql.append("       f_org_id,");
		sql.append("       f_org_name,");
		sql.append("       f_dept_id,");
		sql.append("       f_dept_name,");
		sql.append("       f_tel,");
		sql.append("       to_char(f_creator_time,'yyyy-MM-dd') f_creator_time,");
		sql.append("       f_checkmsg");
		sql.append("  from oa_file_lending f");
		sql.append(" where f.f_lending_id = ? ");
		viewMap = queryToSingleMap(conn, sql.toString(), beanId);
		return viewMap;
	}

	@Override
	public PagingBean getFilelendingBeanList(FileLendingDetailBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			// 拼接的值
			List<String> conditionValues = new ArrayList<String>();
			StringBuffer sql = new StringBuffer();
			sql.append("select t.f_detail_id,"+
					"  t.f_lending_id,"+
					"  d.f_file_no,"+
					"  d.f_doc_num,"+
					"  d.F_DOC_ID,"+
					"  l.f_dept_name,"+
			        "  DECODE(t.f_read_approve,"+
			        "        '1',"+
			        "        '只阅读',"+
			        "         '2',"+
			        "        '可下载',"+
			        "        f_read_approve) f_read_approve,"+
					" DECODE(t.f_lending_type,"+
					"        '0',"+
					"        '电子和实物',"+
					"        '1',"+
					"        '电子',"+
					"        '2',"+
					"        '实物',"+
					"        f_lending_type) f_lending_type_name,"+
					"  t.f_lending_type,"+
					"  d.F_DOC_NAME f_docname,"+
					"  l.f_lending_username as f_lending_userid,"+
					"  to_char(t.f_lending_time,'yyyy-MM-dd') as f_lending_time,"+
					"  to_char((t.f_lending_time+t.f_lending_day),'yyyy-MM-dd') as f_reback_time,"+
					"  t.f_user_name,"+
					"  to_char(t.f_back_time,'yyyy-MM-dd') as f_back_time," +
					"  t.f_back_username,"+
					"  t.f_isback"+
					" from oa_file_lending_detail t"+
					" left join OA_FILE_DOC d"+
					" ON t.F_DOC_ID = d.F_DOC_ID " +
					" left join td_sm_user u"+
					" on t.f_lending_userid = u.user_id " +
					" left join oa_file_lending l"+
					" on l.f_lending_id = t.f_lending_id"+
			" where t.f_lending_id is not null  ");
			if(bean.getJsp_type().equals("boroowing")){ //借阅中
				sql.append(" and t.f_isback ='0' and t.f_islending='1'");
			}else if(bean.getJsp_type().equals("borrowback")){ //已归还
				sql.append(" and t.f_isback ='1' and t.f_islending='1'");
			}
			if (!StringUtil.nullOrBlank(bean.getF_docname())) {
				sql.append("   and d.F_DOC_NAME LIKE '%'||?||'%' ");
				conditionValues.add(bean.getF_docname());
			}
			if (!StringUtil.nullOrBlank(bean.getF_lending_type())) {
				sql.append("   and t.f_lending_type = ?");
				conditionValues.add(bean.getF_lending_type());
			}
			if (!StringUtil.nullOrBlank(bean.getF_creator_state_time())) {
				sql.append("   and t.f_lending_time >= to_date(?,'yyyy-MM-dd')");
				conditionValues.add(bean.getF_creator_state_time());
			}
			if (!StringUtil.nullOrBlank(bean.getF_creator_end_time())) {
				sql.append("   and t.f_lending_time <= to_date(?,'yyyy-MM-dd')");
				conditionValues.add(bean.getF_creator_end_time());
			}
			if (!StringUtil.nullOrBlank(bean.getF_lending_userid())) {
				sql.append("   and l.f_lending_username LIKE '%'||?||'%' ");
				conditionValues.add(bean.getF_lending_userid());
			}
			if (!StringUtil.nullOrBlank(bean.getF_dep_name())) {
				sql.append("   and l.f_dept_name LIKE '%'||?||'%' ");
				conditionValues.add(bean.getF_dep_name());
			}
			if (!StringUtil.nullOrBlank(bean.getF_file_no())) {
				sql.append("   and d.f_file_no LIKE '%'||?||'%' ");
				conditionValues.add(bean.getF_file_no());
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
	 * <b>Summary: </b>
	 *     复写方法 saveBusiInfo
	 * @param request
	 * @param conn
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao#saveBusiInfo(javax.servlet.http.HttpServletRequest, java.sql.Connection)
	 */
	@Override
	public boolean saveBusiInfo(HttpServletRequest request, Connection conn)
			throws Exception {
		String actId = request.getParameter(ACTION_DEFID);
		AccessControl ar = AccessControl.getInstance();
		ar.checkAccess(request.getSession());
		String userId = ar.getUserID();
		String userName = ar.getUserName();
		if(actId!=null){
			//提交申请,修改申请详情信息
			if(actId.equals(FilelendingBean.ACT_JY_SQ)){
				String f_lending_id = request.getParameter("busi_id");//外键
				String[] datarownum = request.getParameterValues("datarownum");
				String[] ids = request.getParameterValues("detailId");
				String[] lendingDays = request.getParameterValues("f_lending_day");
				String[] lendingType = request.getParameterValues("f_lending_type");
				String[] readPurview = request.getParameterValues("f_read_purview");
				if(datarownum!=null){
					int i = 0;
					ArrayList<FileLendingDetailBean> beans = new ArrayList<FileLendingDetailBean>();
					for(String rowNum : datarownum){
						if(rowNum.length()>0){
							FileLendingDetailBean bean = new FileLendingDetailBean();
							bean.setF_lending_id(f_lending_id);
							bean.setF_detail_id(ids[i]);//借阅详情Id
							bean.setF_lending_day(lendingDays[i]);//借阅天数
							bean.setF_lending_type(lendingType[i]); //介质类型
							bean.setF_read_purview(readPurview[i]); //阅读权限1:只阅读2可下载
							bean.setF_lending_time(new Timestamp(new Date().getTime()));
							beans.add(bean);
						}
						i++;
						if(i>=ids.length||i>=lendingDays.length||i>=lendingType.length||i>=readPurview.length){
							break;
						}
					}
					//修改(增加关联)借阅申请关联的明细数据
					StringBuffer detailIds = new StringBuffer();
					PreparedDBUtil pdb = new PreparedDBUtil();
					for(FileLendingDetailBean bean : beans){
						StringBuffer sql = new StringBuffer();
						sql.append("update oa_file_lending_detail");
						sql.append("   set f_lending_type = '"+bean.getF_lending_type()+"',");
						sql.append("       f_lending_day = '"+bean.getF_lending_day()+"',");
						sql.append("       f_read_purview = '"+bean.getF_read_purview()+"',");
						sql.append("       f_lending_id = '"+bean.getF_lending_id()+"',");
						sql.append("       f_lending_time = sysdate");
						sql.append(" where f_detail_id = '"+bean.getF_detail_id()+"'");
						detailIds.append(",'"+bean.getF_detail_id()+"'");
						pdb.preparedUpdate(sql.toString());
						pdb.executePrepared(conn);
					}
					//修改(删除关联)
					if(detailIds.length()>0){
						StringBuffer sql = new StringBuffer();
						sql.append("update oa_file_lending_detail");
						sql.append("   set f_lending_type = null,");
						sql.append("       f_lending_day = null,");
						sql.append("       f_read_purview = null,");
						sql.append("       f_read_approve = null,");
						sql.append("       f_isagree = null,");
						sql.append("       f_lending_id = null");
						sql.append(" where f_lending_id = '"+f_lending_id+"' and f_detail_id not in ("+detailIds.substring(1)+")");
						pdb.preparedUpdate(sql.toString());
						pdb.executePrepared(conn);
					}else{
						StringBuffer sql = new StringBuffer();
						sql.append("update oa_file_lending_detail");
						sql.append("   set f_lending_type = null,");
						sql.append("       f_lending_day = null,");
						sql.append("       f_read_purview = null,");
						sql.append("       f_lending_id = null");
						sql.append(" where f_lending_id = '"+f_lending_id+"'");
						pdb.preparedUpdate(sql.toString());
						pdb.executePrepared(conn);
					}
				}
				
			}else if(actId.equals(FilelendingBean.ACT_BM_SH)
					||actId.equals(FilelendingBean.ACT_DAGLY_SH)){
				String[] datarownum = request.getParameterValues("datarownum");
				if(datarownum!=null){
					String[] ids = request.getParameterValues("detailId");
					String[] sfkjy = request.getParameterValues("sfkjy");
					int i = 0;
					ArrayList<FileLendingDetailBean> beans = new ArrayList<FileLendingDetailBean>();
					for(String rowNum : datarownum){
						if(rowNum.length()>0){
							FileLendingDetailBean bean = new FileLendingDetailBean();
							bean.setF_detail_id(ids[i]);//借阅详情Id
							bean.setF_isagree(sfkjy[i]);//是否同意
							beans.add(bean);
						}
						i++;
						if(i>=ids.length||i>=sfkjy.length){
							break;
						}
					}
					
					//修改(增加关联)借阅申请关联的明细数据
					PreparedDBUtil pdb = new PreparedDBUtil();
					for(FileLendingDetailBean bean : beans){
						StringBuffer sql = new StringBuffer();
						if("1".equals(bean.getF_isagree())){
							sql.append("update oa_file_lending_detail");
							sql.append("   set f_isagree = '"+bean.getF_isagree()+"',");
							sql.append("       f_read_approve = f_read_purview");
							sql.append(" where f_detail_id = '"+bean.getF_detail_id()+"'");
						}else{
							sql.append("update oa_file_lending_detail");
							sql.append("   set f_isagree = '"+bean.getF_isagree()+"',");
							sql.append("       f_read_approve = ''");
							sql.append(" where f_detail_id = '"+bean.getF_detail_id()+"'");
						}
						pdb.preparedUpdate(sql.toString());
						pdb.executePrepared(conn);
					}
				}
			}else if(actId.equals(FilelendingBean.ACT_JY_TZ)){
				String[] ids = request.getParameterValues("detailId");
				if(ids!=null){
					StringBuffer detailIds = new StringBuffer();
					for(String id : ids){
						detailIds.append(",'"+id+"'");
					}
					PreparedDBUtil pdb = new PreparedDBUtil();
					if(detailIds.length()>0){
						//同意 and 电子 介质
						StringBuffer sql = new StringBuffer();
						sql.append("update oa_file_lending_detail");
						sql.append("   set F_ISAGREE = '1',");
						sql.append("       F_ISLENDING = '1',");
						sql.append("       F_ISBACK = '0',");
						sql.append("       F_USER_ID = '"+userId+"',");
						sql.append("       F_USER_NAME = '"+userName+"',");
						sql.append("       F_REBACK_TIME = SYSDATE + NVL(F_LENDING_DAY,0),");
						sql.append("       f_read_approve = f_read_purview");
						sql.append(" where f_detail_id  in ("+detailIds.substring(1)+") and F_ISAGREE='1'");
						sql.append("   and f_doc_id in (select f_doc_id from oa_file_doc where f_doc_media = '1')");
						pdb.preparedUpdate(sql.toString());
						pdb.executePrepared(conn);
						//同意 and 非"只电子" 介质
						sql = new StringBuffer();
						sql.append("update oa_file_lending_detail");
						sql.append("   set F_ISAGREE = '1',");
						sql.append("       F_ISLENDING = '0',");
						sql.append("       F_ISBACK = '0',");
						
						sql.append("       f_read_approve = f_read_purview");
						sql.append(" where f_detail_id  in ("+detailIds.substring(1)+") and F_ISAGREE='1'");
						sql.append("   and f_doc_id in (select f_doc_id from oa_file_doc where f_doc_media <> '1')");
						pdb.preparedUpdate(sql.toString());
						pdb.executePrepared(conn);
						
						sql = new StringBuffer();
						sql.append("update oa_file_lending_detail");
						sql.append("   set F_ISAGREE = '0',");
						sql.append("       F_ISLENDING = '0',");
						sql.append("       f_read_approve = f_read_purview");
						sql.append(" where f_detail_id  in ("+detailIds.substring(1)+") and F_ISAGREE='0'");
						pdb.preparedUpdate(sql.toString());
						pdb.executePrepared(conn);
					}
				}
			}
		}
		return true;
	}
	/**
	 * request中保存流程环节节点的属性名
	 */
	public static final String ACTION_DEFID = "action_defid";
	@Override
	public List<Map<String, String>> getFileLendingDetailById(String beanId,
			Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select ofld.f_detail_id,");
		sql.append("       ofld.f_doc_id,");
		sql.append("       ofd.F_DOC_NUM,"); //--件号
		sql.append("       ofd.F_FILE_NO,"); //--档号
		sql.append("       ofd.f_doc_name,"); //--文件标题
		sql.append("       to_char(ofd.F_FILE_FORMTIME,'yyyy-MM-dd') F_FILE_FORMTIME,"); //--文件形成时间
		sql.append("       ofld.F_LENDING_DAY,"); //--借阅天数
		sql.append("       ofld.F_LENDING_TYPE,"); //--借阅类型
		sql.append("       ofd.f_doc_media,"); //--介质类型
		sql.append("       ofld.F_READ_PURVIEW,"); //--阅读权限
		sql.append("       ofld.F_ISAGREE"); //--是否借阅
		sql.append("  from oa_file_lending_detail ofld, oa_file_doc ofd");
		sql.append(" where ofld.f_doc_id = ofd.f_doc_id");
		sql.append("   and ofld.f_lending_id = '"+beanId+"'");
		return queryToListMap(sql.toString(), conn);
	
	}


	@Override
	public PagingBean queryListByAdmin(FileFilesQueryBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			// 拼接的值
			List<String> conditionValues = new ArrayList<String>();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT OFD.F_DOC_ID,");
			sql.append("       OFD.F_DOC_NUM,");
//			sql.append("       case");
//			sql.append("         when f_attach_id is null then");
//			sql.append("          (select count(1)");
//			sql.append("             from oa_fc_attach fa");
//			sql.append("            where fa.djbh in (select f_attach_id");
//			sql.append("                                from oa_file_photo_info fpi");
//			sql.append("                               where fpi.f_file_id = ofd.f_doc_id))");
//			sql.append("         else");
//			sql.append("          (SELECT COUNT(1)");
//			sql.append("             FROM OA_FC_ATTACH");
//			sql.append("            WHERE DJBH IN (SELECT F_ATTACH_ID");
//			sql.append("                             FROM OA_FILE_DOC OFD1");
//			sql.append("                            WHERE OFD1.F_DOC_ID = OFD.F_DOC_ID))");
//			sql.append("       end ATTACH_NUM,");
			sql.append("       0 ATTACH_NUM,");
			sql.append("       OFD.F_DOC_FONTSIZE,");
			sql.append("       OFD.F_DOC_NAME,");
			sql.append("       OFD.f_file_no,");
			sql.append("       DECODE(OFD.f_Doc_State,");
			sql.append("              '0',");
			sql.append("              '待归档',");
			sql.append("              '1',");
			sql.append("              '不需归档',");
			sql.append("              '2',");
			sql.append("              '已归档',");
			sql.append("              '8',");
			sql.append("              '已移交',");
			sql.append("              '9',");
			sql.append("              '已销毁',");
			sql.append("              f_Doc_State) f_Doc_State,");
			sql.append("       OFD.F_FILE_num,");
			sql.append("       OFD.F_DEPT_NAME,");
			sql.append("       TO_CHAR(OFD.F_CREATOR_TIME, 'yyyy-MM-dd') F_CREATOR_TIME_STR,");
			sql.append("       OFPP.F_FILE_DETAIL QUERY_PAGE,");
			sql.append("       OFD.f_doc_media");
			sql.append("  FROM OA_FILE_DOC OFD");
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
				sql.append(" WHERE OFPP.F_PROGRAM_ID in ('ed635d24-fced-4353-81f9-86b18e378ef6','fff6a4a1-5943-46dd-bc6c-07591e5c6ebd','fc74cac7-8256-4d0f-902d-0316e7fb2b7e','f0fe0a05-e472-45da-a5e9-94dbbffe6e6c') and OFD.F_ORG_ID = ? ");
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
				//10 出一些文档之外
				if (!StringUtil.nullOrBlank(bean.getOut_side_detail_ids())) {
					sql.append(" AND OFD.F_DOC_ID not in (select * from table(split(?)))  ");
					conditionValues.add(bean.getOut_side_detail_ids());
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
	 *     复写方法 checkKC
	 * @param list
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileLendingDetailDao#checkKC(java.util.List)
	 */
	@Override
	public Map<String, String> checkKC(List<FileLendingDetailBean> list,Connection conn)
			throws Exception {
		StringBuffer ids = new StringBuffer();
		for (FileLendingDetailBean bean : list) {
			//0,2包括实物
			if(bean.getF_doc_id()!=null&&("0".equals(bean.getF_lending_type())||"2".equals(bean.getF_lending_type()))){
				ids.append(",'"+bean.getF_doc_id()+"'");
			}
		}
		if(ids.length()>0){
			StringBuffer sql = new StringBuffer();
			sql.append("select count(1) countt,wm_concat(ofd.f_doc_name) names");
			sql.append("  from oa_file_doc ofd");
			sql.append(" where ofd.f_doc_id in");
			sql.append("       ("+ids.substring(1)+")");
			sql.append("   and (ofd.f_file_num is null");
			sql.append("    or ofd.f_file_num < 1)"); 
			List<Map<String, String>> list1 = queryToListMap(sql.toString(), conn);
			if(list1.size()==1){
				return list1.get(0);
			}
		}
		return null;
	}

	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 updateKC
	 * @param list
	 * @param conn
	 * @param type
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileLendingDetailDao#updateKC(java.util.List, java.sql.Connection, java.lang.String)
	 */
	@Override
	public boolean updateKC(List<FileLendingDetailBean> list, Connection conn,
			String type) throws Exception {
		StringBuffer ids = new StringBuffer();
		for (FileLendingDetailBean bean : list) {
			//0,2包括实物
			if(bean.getF_doc_id()!=null&&("0".equals(bean.getF_lending_type())||"2".equals(bean.getF_lending_type()))){
				ids.append(",'"+bean.getF_doc_id()+"'");
			}
		}
		
		if("-1".equals(type)){
			if(ids.length()>0){
				StringBuffer sql = new StringBuffer();
				sql.append("update oa_file_doc");
				sql.append("   set f_file_num = f_file_num - 1");
				sql.append(" where f_doc_id in ("+ids.substring(1)+")");
				PreparedDBUtil pdb = new PreparedDBUtil();
				pdb.preparedUpdate(sql.toString());
				pdb.executePrepared(conn);
			}
		}else if("+1".equals(type)){
			if(ids.length()>0){
				StringBuffer sql = new StringBuffer();
				sql.append("update oa_file_doc");
				sql.append("   set f_file_num = f_file_num + 1");
				sql.append(" where f_doc_id in ("+ids.substring(1)+")");
				PreparedDBUtil pdb = new PreparedDBUtil();
				pdb.preparedUpdate(sql.toString());
				pdb.executePrepared(conn);
			}
		}
		return false;
	}

	/**
	 * 档案借阅管理--待借阅
	 * <b>Summary: </b>
	 *     复写方法 queryMyFileLendingBeforeList
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileLendingDetailDao#queryMyFileLendingBeforeList(com.chinacreator.xtbg.core.file.entity.FileLendingDetailBean, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean queryMyFileLendingBeforeList(FileLendingDetailBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT OFD.F_DOC_NUM,");
			sql.append("       OFFF.F_FILES_NO,");
			sql.append("       OFD.F_DOC_NAME,");
			sql.append("       OFD.F_FILE_NUM,");
			sql.append("       TO_CHAR(OFLD.F_LENDING_TIME,'yyyy-MM-dd') F_LENDING_TIME,");
			sql.append("       OFL.F_LENDING_USERNAME,");
			sql.append("       OFL.F_DEPT_NAME,");
			sql.append("       OFLD.F_DETAIL_ID,");
			sql.append("       OFD.F_DOC_ID,");
			sql.append("       OFLD.F_LENDING_DAY,");
			sql.append("       OFD.F_TYPE_NAME");
			sql.append("  FROM OA_FILE_LENDING_DETAIL OFLD");
			sql.append(" INNER JOIN OA_FILE_DOC OFD");
			sql.append("    ON OFLD.F_DOC_ID = OFD.F_DOC_ID");
			sql.append("  LEFT JOIN OA_FILE_DOCFILES OFDF");
			sql.append("    ON OFD.F_DOC_ID = OFDF.F_DOC_ID");
			sql.append("  LEFT JOIN OA_FILE_FILES OFFF ");
			sql.append("    ON OFDF.F_FILES_ID = OFFF.F_FILES_ID");
			sql.append("  LEFT JOIN OA_FILE_LENDING OFL");
			sql.append("    ON OFLD.F_LENDING_ID = OFL.F_LENDING_ID");
			sql.append(" WHERE ofld.f_isagree = '1' and ofld.f_islending = '0' and ofld.f_isback='0'");
			
			List<String> conditionValues = new ArrayList<String>();
			//1：档号
			if(!StringUtil.nullOrBlank(bean.getF_file_no())){
				sql.append(" AND OFFF.F_FILES_NO  like '%'||?||'%'");
				conditionValues.add(bean.getF_file_no());
			}
			//2：文件标题
			if (!StringUtil.nullOrBlank(bean.getF_doc_name())) {
				sql.append(" AND OFD.F_DOC_NAME like '%'||?||'%'");
				conditionValues.add(bean.getF_doc_name());
			}
			//3:文件分类
			if(!StringUtil.nullOrBlank(bean.getF_type_name())){
				sql.append(" AND OFD.F_TYPE_NAME like '%'||?||'%' ");
				conditionValues.add(bean.getF_type_name());
			}
			//4:f_creator_state_time  f_creator_end_time
			if (!StringUtil.nullOrBlank(bean.getF_creator_state_time())) {
				sql.append("   and OFLD.f_lending_time >= to_date(?,'yyyy-MM-dd')");
				conditionValues.add(bean.getF_creator_state_time());
			}
			if (!StringUtil.nullOrBlank(bean.getF_creator_end_time())) {
				sql.append("   and OFLD.f_lending_time <= to_date(?,'yyyy-MM-dd')");
				conditionValues.add(bean.getF_creator_end_time());
			}
			//5:借阅人
			if(!StringUtil.nullOrBlank(bean.getF_lending_userid())){
				sql.append("   AND OFL.F_LENDING_USERNAME like '%'||?||'%' ");
				conditionValues.add(bean.getF_lending_userid());
			}
			//6:所属部门
			if(!StringUtil.nullOrBlank(bean.getF_dept_name())){
				sql.append("   AND OFL.F_DEPT_NAME LIKE '%'||?||'%' ");
				conditionValues.add(bean.getF_dept_name());
			}
			if (!StringUtil.nullOrBlank(sortName)
					&& !StringUtil.nullOrBlank(sortOrder)) {
				sql.append(" ORDER BY " + sortName + " " + sortOrder);
			}
			return queryToPagingBean(sql.toString(), offset, maxPagesize, conn,
					conditionValues);
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 getFileLendingFlowDoList
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileLendingDetailDao#getFileLendingFlowDoList(com.chinacreator.xtbg.core.file.entity.FileLendingDetailBean, java.lang.String, java.lang.String, long, int)
	 */
	private final String STATUS_CODE_TWO = "02";//办结
	@Override
	public PagingBean getFileLendingFlowDoList(FileLendingDetailBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT OFL.F_LENDING_REASON,");
			sql.append("       OFLD.F_LENDING_DAY,");
			sql.append("       TO_CHAR(OFL.F_CREATOR_TIME,'yyyy-MM-dd') F_CREATOR_TIME,");
			sql.append("       OFI.STATUS_CODE,");
			sql.append("       OFIN.ACTION_NAME,");
			sql.append("       OFI.INS_ID,");
			sql.append("       OFL.F_LENDING_ID");
			sql.append("  FROM OA_FILE_LENDING OFL");
			sql.append(" INNER JOIN OA_FLOW_INSTANCE OFI");
			sql.append("    ON OFL.F_LENDING_ID = OFI.BUSI_ID");
			sql.append("  LEFT JOIN (SELECT F_LENDING_ID, MAX(F_LENDING_DAY) F_LENDING_DAY");
			sql.append("               FROM OA_FILE_LENDING_DETAIL");
			sql.append("              GROUP BY F_LENDING_ID) OFLD");
			sql.append("    ON OFL.F_LENDING_ID = OFLD.F_LENDING_ID");
			sql.append("  LEFT JOIN (SELECT OFIN.INS_ID,");
			sql.append("                    TO_CHAR(WM_CONCAT(DISTINCT OFIN.ACTION_NAME)) ACTION_NAME");
			sql.append("               FROM OA_FLOW_INSWFACTION OFIN");
			sql.append("              WHERE OFIN.ACTION_HANDERNAME IS NULL");
			sql.append("                AND OFIN.TACHE_END_TIME IS NULL");
			sql.append("              GROUP BY OFIN.INS_ID) OFIN");
			sql.append("    on OFI.INS_ID = OFIN.INS_ID");
			sql.append(" WHERE OFI.BUSITYPE_CODE = 'uuid-336'");
			sql.append("   AND OFI.ACCEPTER_ID = '"+bean.getAccepter_id()+"'");
			sql.append("   AND 1=1");
			
			if(STATUS_CODE_TWO.equals(bean.getStatus_code())){
				sql.append(" AND OFI.STATUS_CODE = '"+STATUS_CODE_TWO+"'");
			}else{
				sql.append(" AND OFI.STATUS_CODE IN ('01','06')");//01在办06回退 DATA IN OA_FLOW_STATUS
			}
			
			List<String> conditionValues = new ArrayList<String>();
			//1：借阅理由
			if (!StringUtil.nullOrBlank(bean.getF_lending_reason())) {
				sql.append(" AND OFL.F_lending_reason like '%'||?||'%'");
				conditionValues.add(bean.getF_lending_reason());
			}
			
			//2:申请时间f_creator_state_time  f_creator_end_time
			if (!StringUtil.nullOrBlank(bean.getF_creator_state_time())) {
				sql.append("   and OFL.F_CREATOR_TIME >= to_date(?,'yyyy-MM-dd')");
				conditionValues.add(bean.getF_creator_state_time());
			}
			if (!StringUtil.nullOrBlank(bean.getF_creator_end_time())) {
				sql.append("   and OFL.F_CREATOR_TIME <= to_date(?,'yyyy-MM-dd')");
				conditionValues.add(bean.getF_creator_end_time());
			}
			if (!StringUtil.nullOrBlank(sortName)
					&& !StringUtil.nullOrBlank(sortOrder)) {
				sql.append(" ORDER BY " + sortName + " " + sortOrder+",OFI.LASTMODIFEDTIME DESC");
			}else{
				sql.append(" ORDER BY OFI.LASTMODIFEDTIME DESC");
			}
			return queryToPagingBean(sql.toString(), offset, maxPagesize, conn,
					conditionValues);
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 MyFileLendingForMeBeforeList
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileLendingDetailDao#MyFileLendingForMeBeforeList(com.chinacreator.xtbg.core.file.entity.FileLendingDetailBean, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean MyFileLendingForMeBeforeList(FileLendingDetailBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT OFD.F_DOC_NUM,");
			sql.append("       OFFF.F_FILES_NO,");
			sql.append("       OFD.F_DOC_NAME,");
			sql.append("       OFD.F_FILE_NUM,");
			sql.append("       TO_CHAR(OFL.F_CREATOR_TIME,'yyyy-MM-dd') F_LENDING_TIME,");
			sql.append("       OFL.F_LENDING_USERNAME,");
			sql.append("       OFL.F_DEPT_NAME,");
			sql.append("       OFLD.F_DETAIL_ID,");
			sql.append("       OFD.F_DOC_ID,");
			sql.append("       OFLD.F_LENDING_DAY,");
			sql.append("       OFD.F_TYPE_NAME");
			sql.append("  FROM OA_FILE_LENDING_DETAIL OFLD");
			sql.append(" INNER JOIN OA_FILE_DOC OFD");
			sql.append("    ON OFLD.F_DOC_ID = OFD.F_DOC_ID");
			sql.append("  LEFT JOIN OA_FILE_DOCFILES OFDF");
			sql.append("    ON OFD.F_DOC_ID = OFDF.F_DOC_ID");
			sql.append("  LEFT JOIN OA_FILE_FILES OFFF ");
			sql.append("    ON OFDF.F_FILES_ID = OFFF.F_FILES_ID");
			sql.append("  LEFT JOIN OA_FILE_LENDING OFL");
			sql.append("    ON OFLD.F_LENDING_ID = OFL.F_LENDING_ID");
			sql.append(" WHERE ofld.f_isagree = '1' and ofld.f_islending = '0' and ofld.f_isback='0'");
			sql.append(" AND OFL.F_LENDING_USERID = '"+bean.getF_lending_userid()+"'");
			List<String> conditionValues = new ArrayList<String>();
			//2：文件标题
			if (!StringUtil.nullOrBlank(bean.getF_doc_name())) {
				sql.append(" AND OFD.F_DOC_NAME like '%'||?||'%'");
				conditionValues.add(bean.getF_doc_name());
			}
			//3:文件分类
			if(!StringUtil.nullOrBlank(bean.getF_type_name())){
				sql.append(" AND OFD.F_TYPE_NAME like '%'||?||'%' ");
				conditionValues.add(bean.getF_type_name());
			}
			//4:f_creator_state_time  f_creator_end_time
			if (!StringUtil.nullOrBlank(bean.getF_creator_state_time())) {
				sql.append("   and OFL.F_CREATOR_TIME >= to_date(?,'yyyy-MM-dd')");
				conditionValues.add(bean.getF_creator_state_time());
			}
			if (!StringUtil.nullOrBlank(bean.getF_creator_end_time())) {
				sql.append("   and OFL.F_CREATOR_TIME <= to_date(?,'yyyy-MM-dd')");
				conditionValues.add(bean.getF_creator_end_time());
			}
			if (!StringUtil.nullOrBlank(sortName)
					&& !StringUtil.nullOrBlank(sortOrder)) {
				sql.append(" ORDER BY " + sortName + " " + sortOrder);
			}
			return queryToPagingBean(sql.toString(), offset, maxPagesize, conn,
					conditionValues);
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 MyFileLendingForMeBackList
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileLendingDetailDao#MyFileLendingForMeBackList(com.chinacreator.xtbg.core.file.entity.FileLendingDetailBean, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean MyFileLendingForMeBackList(FileLendingDetailBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT OFD.F_DOC_NUM,");
			sql.append("       OFFF.F_FILES_NO,");
			sql.append("       OFD.F_DOC_NAME,");
			sql.append("       OFD.F_FILE_NUM,");
			sql.append("       TO_CHAR(OFLD.F_LENDING_TIME,'yyyy-MM-dd') F_LENDING_TIME,");
			sql.append("       TO_CHAR(OFLD.F_REBACK_TIME,'yyyy-MM-dd') F_REBACK_TIME,");
			sql.append("       TO_CHAR(OFLD.F_BACK_TIME,'yyyy-MM-dd') F_BACK_TIME,");
			sql.append("       OFL.F_LENDING_USERNAME,");
			sql.append("       OFL.F_DEPT_NAME,");
			sql.append("       OFLD.F_DETAIL_ID,");
			sql.append("       OFD.F_DOC_ID,");
			sql.append("       OFLD.F_LENDING_DAY,");
			sql.append("       OFD.F_TYPE_NAME,");
			sql.append("       DECODE(OFLD.f_lending_type,'0','电子和实物','1','电子','2','实物',f_lending_type) f_lending_type_name,");
			sql.append("       OA_FILE_GET_DETAIL_PAGE(OFD.f_Type_Id,1) page_name");
			sql.append("  FROM OA_FILE_LENDING_DETAIL OFLD");
			sql.append(" INNER JOIN OA_FILE_DOC OFD");
			sql.append("    ON OFLD.F_DOC_ID = OFD.F_DOC_ID");
			sql.append("  LEFT JOIN OA_FILE_DOCFILES OFDF");
			sql.append("    ON OFD.F_DOC_ID = OFDF.F_DOC_ID");
			sql.append("  LEFT JOIN OA_FILE_FILES OFFF ");
			sql.append("    ON OFDF.F_FILES_ID = OFFF.F_FILES_ID");
			sql.append("  LEFT JOIN OA_FILE_LENDING OFL");
			sql.append("    ON OFLD.F_LENDING_ID = OFL.F_LENDING_ID");
			sql.append(" WHERE ofld.f_isagree = '1' and ofld.f_islending = '1' and ofld.f_isback='1'");
			sql.append(" AND OFL.F_LENDING_USERID = '"+bean.getF_lending_userid()+"'");
			List<String> conditionValues = new ArrayList<String>();
			//2：文件标题
			if (!StringUtil.nullOrBlank(bean.getF_doc_name())) {
				sql.append(" AND OFD.F_DOC_NAME like '%'||?||'%'");
				conditionValues.add(bean.getF_doc_name());
			}
			//3:文件分类
			if(!StringUtil.nullOrBlank(bean.getF_type_name())){
				sql.append(" AND OFD.F_TYPE_NAME like '%'||?||'%' ");
				conditionValues.add(bean.getF_type_name());
			}
			//4:f_creator_state_time  f_creator_end_time
			if (!StringUtil.nullOrBlank(bean.getF_creator_state_time())) {
				sql.append("   and OFLD.F_LENDING_TIME >= to_date(?,'yyyy-MM-dd')");
				conditionValues.add(bean.getF_creator_state_time());
			}
			if (!StringUtil.nullOrBlank(bean.getF_creator_end_time())) {
				sql.append("   and OFLD.F_LENDING_TIME <= to_date(?,'yyyy-MM-dd')");
				conditionValues.add(bean.getF_creator_end_time());
			}
			if (!StringUtil.nullOrBlank(sortName)
					&& !StringUtil.nullOrBlank(sortOrder)) {
				sql.append(" ORDER BY " + sortName + " " + sortOrder);
			}
			return queryToPagingBean(sql.toString(), offset, maxPagesize, conn,
					conditionValues);
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 MyFileLendingForMeNowList
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileLendingDetailDao#MyFileLendingForMeNowList(com.chinacreator.xtbg.core.file.entity.FileLendingDetailBean, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean MyFileLendingForMeNowList(FileLendingDetailBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT OFD.F_DOC_NUM,");
			sql.append("       OFFF.F_FILES_NO,");
			sql.append("       OFD.F_DOC_NAME,");
			sql.append("       OFD.F_FILE_NUM,");
			sql.append("       TO_CHAR(OFLD.F_LENDING_TIME,'yyyy-MM-dd') F_LENDING_TIME,");
			sql.append("       TO_CHAR(OFLD.F_REBACK_TIME,'yyyy-MM-dd') F_REBACK_TIME,");
			sql.append("       TO_CHAR(OFLD.F_BACK_TIME,'yyyy-MM-dd') F_BACK_TIME,");
			sql.append("       OFL.F_LENDING_USERNAME,");
			sql.append("       OFL.F_DEPT_NAME,");
			sql.append("       OFLD.F_DETAIL_ID,");
			sql.append("       OFD.F_DOC_ID,");
			sql.append("       OFLD.F_LENDING_DAY,");
			sql.append("       OFD.F_TYPE_NAME,");
			sql.append("       DECODE(OFLD.f_lending_type,'0','电子和实物','1','电子','2','实物',f_lending_type) f_lending_type_name");
			sql.append("  FROM OA_FILE_LENDING_DETAIL OFLD");
			sql.append(" INNER JOIN OA_FILE_DOC OFD");
			sql.append("    ON OFLD.F_DOC_ID = OFD.F_DOC_ID");
			sql.append("  LEFT JOIN OA_FILE_DOCFILES OFDF");
			sql.append("    ON OFD.F_DOC_ID = OFDF.F_DOC_ID");
			sql.append("  LEFT JOIN OA_FILE_FILES OFFF ");
			sql.append("    ON OFDF.F_FILES_ID = OFFF.F_FILES_ID");
			sql.append("  LEFT JOIN OA_FILE_LENDING OFL");
			sql.append("    ON OFLD.F_LENDING_ID = OFL.F_LENDING_ID");
			sql.append(" WHERE ofld.f_isagree = '1' and ofld.f_islending = '1' and ofld.f_isback='0'");
			sql.append(" AND OFL.F_LENDING_USERID = '"+bean.getF_lending_userid()+"'");
			List<String> conditionValues = new ArrayList<String>();
			//2：文件标题
			if (!StringUtil.nullOrBlank(bean.getF_doc_name())) {
				sql.append(" AND OFD.F_DOC_NAME like '%'||?||'%'");
				conditionValues.add(bean.getF_doc_name());
			}
			//3:文件分类
			if(!StringUtil.nullOrBlank(bean.getF_type_name())){
				sql.append(" AND OFD.F_TYPE_NAME like '%'||?||'%' ");
				conditionValues.add(bean.getF_type_name());
			}
			//4:f_creator_state_time  f_creator_end_time
			if (!StringUtil.nullOrBlank(bean.getF_creator_state_time())) {
				sql.append("   and OFLD.F_LENDING_TIME >= to_date(?,'yyyy-MM-dd')");
				conditionValues.add(bean.getF_creator_state_time());
			}
			if (!StringUtil.nullOrBlank(bean.getF_creator_end_time())) {
				sql.append("   and OFLD.F_LENDING_TIME <= to_date(?,'yyyy-MM-dd')");
				conditionValues.add(bean.getF_creator_end_time());
			}
			if (!StringUtil.nullOrBlank(sortName)
					&& !StringUtil.nullOrBlank(sortOrder)) {
				sql.append(" ORDER BY " + sortName + " " + sortOrder);
			}
			return queryToPagingBean(sql.toString(), offset, maxPagesize, conn,
					conditionValues);
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 getFileLendingDetailListByIds
	 * @param ids
	 * @param conn
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileLendingDetailDao#getFileLendingDetailListByIds(java.lang.String, java.sql.Connection)
	 */
	@Override
	public List<Map<String, String>> getFileLendingDetailListByIds(String ids,
			Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT OFLD.*,OFL.F_TEL,OFL.F_LENDING_USERNAME");
		sql.append("  FROM OA_FILE_LENDING_DETAIL OFLD,");
		sql.append("       OA_FILE_LENDING OFL");
		sql.append(" WHERE OFLD.F_LENDING_ID = OFL.F_LENDING_ID ");
		sql.append("   AND F_DETAIL_ID IN");
		sql.append("       (SELECT *");
		sql.append("          FROM TABLE(SPLIT('"+ids+"')))");
		return queryToListMap(sql.toString(), conn);
	}


	@Override
	public boolean deleteFlow(String ids, Connection conn) throws Exception {
		
		PreparedDBUtil pdb = new PreparedDBUtil();
		
		
		StringBuffer sql = new StringBuffer();
		sql.append("delete");
		sql.append("  from oa_flow_inswfaction");
		sql.append(" where ins_id in");
		sql.append("       (select ins_id");
		sql.append("          from oa_flow_instance ofi");
		sql.append("         where ofi.busi_id in (");
		sql.append("                               select f_lending_id");
		sql.append("                                 from oa_file_lending");
		sql.append("                                where f_lending_id in");
		sql.append("       ("+ids+")))");
		pdb.preparedUpdate(sql.toString());
		pdb.executePrepared(conn);
	

		sql = new StringBuffer();
		sql.append("delete");
		sql.append("  from oa_flow_insviewlist");
		sql.append(" where ins_id in");
		sql.append("       (select ins_id");
		sql.append("          from oa_flow_instance ofi");
		sql.append("         where ofi.busi_id in (");
		sql.append("                               select f_lending_id");
		sql.append("                                 from oa_file_lending");
		sql.append("                                where f_lending_id in");
		sql.append("       ("+ids+")))");
		pdb.preparedUpdate(sql.toString());
		pdb.executePrepared(conn);
		sql = new StringBuffer();
		sql.append("delete");
		sql.append("  from oa_flow_instance ofi");
		sql.append(" where ofi.busi_id in (");
		sql.append("                       select f_lending_id");
		sql.append("                         from oa_file_lending");
		sql.append("                        where f_lending_id in");
		sql.append("       ("+ids+"))");
		pdb.preparedUpdate(sql.toString());
		pdb.executePrepared(conn);
		
		sql = new StringBuffer();
		sql.append("delete  oa_file_lending");
		sql.append(" where f_lending_id in");
		sql.append("       ("+ids+")");
		pdb.preparedUpdate(sql.toString());
		pdb.executePrepared(conn);

		sql = new StringBuffer();
		sql.append("delete");
		sql.append("  from oa_file_lending_detail");
		sql.append(" where f_lending_id in");
		sql.append("       ("+ids+")");
		pdb.preparedUpdate(sql.toString());
		pdb.executePrepared(conn);
		return true;
	}
}
