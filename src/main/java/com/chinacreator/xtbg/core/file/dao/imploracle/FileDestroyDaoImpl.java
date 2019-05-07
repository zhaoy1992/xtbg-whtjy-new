package com.chinacreator.xtbg.core.file.dao.imploracle;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.file.dao.FileDestroyDao;
import com.chinacreator.xtbg.core.file.entity.FileDestroyBean;
import com.chinacreator.xtbg.core.file.entity.FileDestroyDetalBean;
import com.chinacreator.xtbg.core.file.entity.FileDocBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:FileDestroyDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛
 *@version 1.0
 *2013-8-22
 */
public class FileDestroyDaoImpl extends XtDbBaseDao implements FileDestroyDao,FlowBusiDataSaveDao{

	private static final Log LOG = LogFactory.getLog(FileDestroyDaoImpl.class);
	@Override
	public PagingBean queryFileDocList(FileDestroyBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			// 拼接的值
			List<String> conditionValues = new ArrayList<String>();
			StringBuffer sql = new StringBuffer();
			if(bean.getJsp_type().equals("spz")){ //审批中 
				sql.append("select  c.f_destroy_id,b.status_name as ,a.ins_id,a.busi_id,to_char(c.f_apply_time,'yyyy-mm-dd') as f_apply_time " +
						" ,c.f_destroy_reason,c.f_check_username,c.f_destroy_title,a.busitype_code "+
						" from  oa_file_destroy c"+
						" left join OA_FLOW_INSTANCE a"+
						"  on a.busi_id=c.f_destroy_id"+
						"  left join oa_flow_status b"+
						"  on a.status_code = b.status_code"+
				"  where a.status_code=01 and a.busitype_code='uuid-337' ");
			}else{
				sql.append("select  c.f_destroy_id,b.status_name as ,a.ins_id,to_char(c.f_apply_time,'yyyy-mm-dd') as f_apply_time ,c.f_destroy_reason,c.f_check_username,c.f_destroy_title "+
						" from  oa_file_destroy c"+
						" left join OA_FLOW_INSTANCE a"+
						"  on a.busi_id=c.f_destroy_id"+
						"  left join oa_flow_status b"+
						"  on a.status_code = b.status_code"+
				"  where a.status_code=02 and a.busitype_code='uuid-337' ");
			}
			if (!StringUtil.nullOrBlank(bean.getF_destroy_title())) {
				sql.append("   and c.f_destroy_title LIKE '%'||?||'%' ");
				conditionValues.add(bean.getF_destroy_title());
			}
			if (!StringUtil.nullOrBlank(bean.getStatedate())) {
				sql.append("   and c.f_apply_time >= to_date(?,'yyyy-MM-dd')");
				conditionValues.add(bean.getStatedate());
			}
			if (!StringUtil.nullOrBlank(bean.getEnddate())) {
				sql.append("   and c.f_apply_time <= to_date(?,'yyyy-MM-dd')");
				conditionValues.add(bean.getEnddate());
			}
			if (!StringUtil.nullOrBlank(sortName)
					&& !StringUtil.nullOrBlank(sortOrder)) {
				sql.append(" order by " + sortName + " " + sortOrder);
			}
			// 调父类的方法
			return queryToPagingBean(sql.toString(), offset, maxPagesize, conn,conditionValues);
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	@Override
	public boolean saveBusiInfo(HttpServletRequest request, Connection conn)
			throws Exception {
		boolean flag = false;
		
		String action_defid = request.getParameter("action_defid");
		if(!StringUtil.nullOrBlank(action_defid)){
			try {
				conn = DbManager.getInstance().getTransactionConnection();
				String f_doc_id[] = request.getParameterValues("f_doc_id");
				String f_detail_id[] = request.getParameterValues("f_detail_id");
				String f_user_id = request.getParameter("f_user_id");
				String f_user_name = request.getParameter("f_user_name");
				String f_destroy_time = request.getParameter("f_destroy_time");
				String f_destroy_id = request.getParameter("busi_id");
				String f_isagree_destroy[] = request.getParameterValues("f_isagree_destroy"); //是否同意销毁
				FileDestroyDao dao = (FileDestroyDao)LoadSpringContext.getApplicationContext().getBean("fileDestroyDaoImpl");			
				if(action_defid.equals("danganxiaohui_wp1_act1")){
					StringBuffer f_detail_ids = new StringBuffer();
					if(f_detail_id!=null&&f_doc_id!=null&&f_detail_id.length==f_doc_id.length){
						for(int j=0;j<f_detail_id.length;j++){
							String id = f_detail_id[j];
							if(id.length()==0){//insert
								FileDestroyDetalBean bean = new FileDestroyDetalBean();
								bean.setF_detail_id(StringUtil.getUUID());
								f_detail_ids.append(","+bean.getF_detail_id());
								bean.setF_doc_id(f_doc_id[j]);
								bean.setF_user_id(f_user_id);
								bean.setF_user_name(f_user_name);
								bean.setF_isagree_destroy(f_isagree_destroy[j]);
								bean.setF_destroy_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(f_destroy_time), "yyyy-MM-dd HH24:mi:ss"));
								bean.setF_destroy_state("2"); //处理中的文件数据 销毁状态为  2   
								bean.setF_destroy_id(f_destroy_id);
								((BaseDao)dao).insert(bean, conn);
								
								String sql = "update OA_FILE_DOC set f_destroy_state ='2' where f_doc_id='"+f_doc_id[j]+"'"; //销魂中的数据  但是流程未完成  完成后状态改为1
								PreparedDBUtil pdb = new PreparedDBUtil();
								pdb.preparedUpdate(sql.toString());
								pdb.executePrepared(conn);
							}else{
								f_detail_ids.append(","+id);
							}
						}
					}
					if(f_detail_ids.length()>0){
						String sql = "update OA_FILE_DOC set f_destroy_state ='0' where f_doc_id in (select f_doc_id from oa_file_destroy_detail where f_destroy_id = '"+f_destroy_id+"' and f_detail_id not in (select * from table(split('"+f_detail_ids.substring(1)+"'))))";
						PreparedDBUtil pdb = new PreparedDBUtil();
						pdb.preparedUpdate(sql.toString());
						pdb.executePrepared(conn);
						sql = "delete oa_file_destroy_detail where f_destroy_id = '"+f_destroy_id+"' and f_detail_id not in (select * from table(split('"+f_detail_ids.substring(1)+"')))";
						pdb.preparedDelete(sql.toString());
						pdb.executePrepared(conn);
					}else{
						String sql = "update OA_FILE_DOC set f_destroy_state ='0' where f_doc_id in (select f_doc_id from oa_file_destroy_detail where f_destroy_id = '"+f_destroy_id+"')";
						PreparedDBUtil pdb = new PreparedDBUtil();
						pdb.preparedUpdate(sql.toString());
						pdb.executePrepared(conn);
						sql = "delete oa_file_destroy_detail where f_destroy_id = '"+f_destroy_id+"'";
						pdb.preparedDelete(sql.toString());
						pdb.executePrepared(conn);
					}
				}else if(action_defid.equals("danganxiaohui_wp1_act2") || action_defid.equals("danganxiaohui_wp1_act3")) // 领导审核环节 和会前环节 保存销毁意见
				{
					if(f_doc_id!=null){
						for(int i=0;i<f_doc_id.length;i++){
							FileDestroyDetalBean bean = new FileDestroyDetalBean();
							bean.setF_detail_id(f_detail_id[i]);
							bean.setF_isagree_destroy(f_isagree_destroy[i]);
							((BaseDao)dao).update(bean, conn);
						}
					}
				}else if(action_defid.equals("danganxiaohui_wp1_act4")) //办结环节  更新销毁状态
				{
					if(f_doc_id!=null){
						String sql =""; 
						for(int i=0;i<f_doc_id.length;i++){
							FileDestroyDetalBean bean = new FileDestroyDetalBean();
							bean.setF_detail_id(f_detail_id[i]);
							bean.setF_doc_id(f_doc_id[i]);
							bean.setF_user_id(f_user_id);
							bean.setF_user_name(f_user_name);
							if(f_isagree_destroy[i].equals("1")){ //同意销毁的文件
								bean.setF_destroy_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(f_destroy_time), "yyyy-MM-dd HH24:mi:ss"));
								bean.setF_destroy_state("1");  //已销毁
								sql =  "update OA_FILE_DOC set f_destroy_state ='1',f_doc_state='"+FileDocBean.STATE_YXH+"',f_doc_state_name='已销毁' where f_doc_id='"+f_doc_id[i]+"'";
							}else{ //不同意销毁
								bean.setF_destroy_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(""), "yyyy-MM-dd HH24:mi:ss"));
								bean.setF_destroy_state("2");  //流程中
								sql =  "update OA_FILE_DOC set f_destroy_state ='0' where f_doc_id='"+f_doc_id[i]+"'";
							}
							((BaseDao)dao).update(bean, conn);
							PreparedDBUtil pdb = new PreparedDBUtil();
							pdb.preparedUpdate(sql.toString());
							pdb.executePrepared(conn);
						}
					}
				}
				flag = true;
			} catch (Exception e) {
				LOG.error(e.getMessage(), e);
			} finally{

				DbManager.closeConnection(conn);
			}
		}
		return flag;
	}

	@Override
	public PagingBean queryFileInventoryList(FileDestroyDetalBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			// 拼接的值
			List<String> conditionValues = new ArrayList<String>();
			StringBuffer sql = new StringBuffer();
			sql.append("select a.f_detail_id,");
			sql.append("       a.f_doc_id,");
			sql.append("       b.f_file_no,");
			sql.append("       b.f_doc_num,");
			sql.append("       b.f_doc_name,");
			sql.append("       c.f_check_username,");
			sql.append("       to_char(a.f_destroy_time, 'yyyy-MM-dd') as f_destroy_time,");
			sql.append("       a.f_destroy_id,");
			sql.append("       ofi.ins_id");
			sql.append("  from oa_file_destroy_detail a");
			sql.append("  left join oa_file_doc b");
			sql.append("    on a.f_doc_id = b.f_doc_id");
			sql.append("  left join oa_file_destroy c");
			sql.append("    on c.f_destroy_id = a.f_destroy_id");
			sql.append("  inner join oa_flow_instance ofi");
			sql.append("    on c.f_destroy_id = ofi.busi_id");
			sql.append(" where 1 = 1");
			sql.append("   and a.f_destroy_state = '1'");
			if (!StringUtil.nullOrBlank(bean.getTitle())) {
				sql.append("   and b.f_doc_name LIKE '%'||?||'%' ");
				conditionValues.add(bean.getTitle());
			}
			if (!StringUtil.nullOrBlank(bean.getStateime())) {
				sql.append("   and a.f_destroy_time >= to_date(?,'yyyy-MM-dd')");
				conditionValues.add(bean.getStateime());
			}
			if (!StringUtil.nullOrBlank(bean.getEndtime())) {
				sql.append("   and a.f_destroy_time <= to_date(?,'yyyy-MM-dd')");
				conditionValues.add(bean.getEndtime());
			}
			if (!StringUtil.nullOrBlank(sortName) && !StringUtil.nullOrBlank(sortOrder)) {
				sql.append(" order by " + sortName + " " + sortOrder);
			}
			// 调父类的方法
			return queryToPagingBean(sql.toString(), offset, maxPagesize, conn,conditionValues);
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	@Override
	public List<Map<String, String>> getFiledestoryDetail(String id,Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select a.f_detail_id, "+
				   "    c.f_doc_year,"+
				   "    a.f_doc_id,"+
				   "    a.f_isagree_destroy,"+
				   "    c.f_file_no,"+
				   "    c.f_doc_name,"+
				   "    to_char(c.f_file_time,'yyyy-MM-dd') f_file_time,"+
				   //"    trunc( sysdate - c.f_file_formtime)  as f_doc_deadlines,"+
				   "    case when sysdate-f_file_formtime>365 then round((sysdate-f_file_formtime)/365)||'年' when sysdate-f_file_formtime>30 then round((sysdate-f_file_formtime)/30)||'个月' else round(sysdate-f_file_formtime)||'天' end  as f_doc_deadlines,"+
				   "    c.f_doc_content f_type_remark,c.f_doc_deadline_name f_doc_deadline"+
				   " from oa_file_destroy_detail a"+
				   " left join oa_file_destroy b"+
				   "  on a.f_destroy_id = b.f_destroy_id"+
				   " left join oa_file_doc c"+
				   " on a.f_doc_id = c.f_doc_id"+
				   " where a.f_destroy_id = '"+id+"'");
		return queryToListMap(sql.toString(), conn);
	}
	/**
	 * 
	*<b>Summary: </b>
	* getcontbyid(根据ID查询销毁详细是否存在)
	* @param id
	* @return
	 * @throws SQLException 
	 * @throws NumberFormatException 
	 */
	public int getcontbyid(String id,Connection conn) throws Exception{
		String sql ="select count(*) as count from oa_file_destroy_detail t where t.f_detail_id ="+id;
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared(conn);
		return Integer.parseInt(pdb.getString(0, "count"));
	}
	/**
	 * 
	 */
	@Override
	public boolean stopFileDestroy(String ids,Connection conn) throws Exception {
		
		PreparedDBUtil pdb = new PreparedDBUtil();
		
		StringBuffer sql = new StringBuffer();
		sql.append("update oa_file_doc");
		sql.append("   set f_destroy_state = '0'");
		sql.append(" where f_doc_id in");
		sql.append("       (select f_doc_id from oa_file_destroy where f_destroy_id in ("+ids+"))");
		pdb.preparedUpdate(sql.toString());
		pdb.executePrepared(conn);
		
		
		sql = new StringBuffer();
		sql.append("delete");
		sql.append("  from oa_flow_inswfaction");
		sql.append(" where ins_id in");
		sql.append("       (select ins_id");
		sql.append("          from oa_flow_instance ofi");
		sql.append("         where ofi.busi_id in (");
		sql.append("                               select f_destroy_id");
		sql.append("                                 from oa_file_destroy");
		sql.append("                                where f_destroy_id in");
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
		sql.append("                               select f_destroy_id");
		sql.append("                                 from oa_file_destroy");
		sql.append("                                where f_destroy_id in");
		sql.append("       ("+ids+")))");
		pdb.preparedUpdate(sql.toString());
		pdb.executePrepared(conn);
		sql = new StringBuffer();
		sql.append("delete");
		sql.append("  from oa_flow_instance ofi");
		sql.append(" where ofi.busi_id in (");
		sql.append("                       select f_destroy_id");
		sql.append("                         from oa_file_destroy");
		sql.append("                        where f_destroy_id in");
		sql.append("       ("+ids+"))");
		pdb.preparedUpdate(sql.toString());
		pdb.executePrepared(conn);
		
		sql = new StringBuffer();
		sql.append("delete  oa_file_destroy");
		sql.append(" where f_destroy_id in");
		sql.append("       ("+ids+")");
		pdb.preparedUpdate(sql.toString());
		pdb.executePrepared(conn);

		sql = new StringBuffer();
		sql.append("delete");
		sql.append("  from oa_file_destroy_detail");
		sql.append(" where f_destroy_id in");
		sql.append("       ("+ids+")");
		pdb.preparedUpdate(sql.toString());
		pdb.executePrepared(conn);
		return true;
	}
}
