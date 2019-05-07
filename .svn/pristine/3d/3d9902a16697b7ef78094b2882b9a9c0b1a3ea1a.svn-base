
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     KbmDocReceiveDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-4-1   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.kbm.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.kbm.dao.KbmDocReceiveDao;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:KbmDocReceiveDaoImpl.java</p>
 *<p>Description:体系文件数据层实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-4-1
 */
public class KbmDocReceiveDaoImpl  extends XtDbBaseDao implements KbmDocReceiveDao {

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 queryKbmDocReceiveList
	  * @param model
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.kbm.dao.KbmDocReceiveDao#queryKbmDocReceiveList(com.chinacreator.xtbg.core.kbm.entity.KbmDocReceiverUserBean, java.lang.String, java.lang.String, long, int) 
	  */
	@Override
	public PagingBean queryKbmDocReceiveList(KbmDocBean model,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			List<String> conditionValues = new ArrayList<String>();
			sql.append("select b.k_doc_id as k_doc_id,");
			sql.append("       b.k_title as k_title,");
			sql.append("       b.k_code as k_code,");
			sql.append("       b.k_type_name as k_type_name,");
			sql.append("       b.k_unit_name as k_unit_name,");
			sql.append("       b.k_attach_id        as k_attach_id,");
			sql.append("       b.k_create_user_name as k_create_user_name,");
			sql.append("       b.k_create_time as k_create_time,");
			sql.append("       b.k_remark as k_remark,");
			sql.append("       a.djsn as djsn,");
			sql.append("       a.extend as file_type,");
			sql.append("       a.filename as filename,");
			sql.append("       b.k_upload_type as k_upload_type");//上传类型
			sql.append("  from oa_kbm_doc b ");
			sql.append("  left join oa_fc_attach a on b.k_attach_id = a.djbh");
			sql.append(" where  b.k_update_time is not null  and (b.k_luojishanchu = '0' or b.k_luojishanchu is null)");
			
			if(!StringUtil.nullOrBlank(model.getK_title())){//标题
				sql.append(" and b.k_title like '%"+model.getK_title()+"%'");
			}
			if(!StringUtil.nullOrBlank(model.getK_type_id())){//分类
				sql.append(" and b.k_type_id = '"+model.getK_type_id()+"'");
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
			//编号
			if(!StringUtil.nullOrBlank(model.getK_code() )){
				sql.append(" and b.k_code =? ");
				conditionValues.add(model.getK_code() );
			}
			//上传人
			if(!StringUtil.nullOrBlank(model.getK_create_user_name())){
				sql.append(" and b.k_create_user_name =? ");
				conditionValues.add(model.getK_create_user_name() );
			}
			//关键文字
			if(!StringUtil.nullOrBlank(model.getK_key() )){
				sql.append(" and b.k_key like '%'||?||'%' ");
				conditionValues.add(model.getK_key());
			}
			sql.append(" order by " + sortName + " " + sortOrder);
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,conditionValues);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}	
	
	/**
	*<b>Summary: </b>
	* queryKbmDocNoReadList(查询体系文件未阅读列表)
	* @param model
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean queryKbmDocNoReadList(KbmDocBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception{
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			List<String> conditionValues = new ArrayList<String>();
			sql.append("select o.k_receiveruser_orgname as k_receiveruser_orgname, ");
			sql.append("       o.k_receiver_username as k_receiver_username, ");
			sql.append("       u.user_mobiletel1 as user_mobiletel1 ");
			sql.append("  from oa_kbm_docreceiveuser o, td_sm_user u");
			sql.append(" where o.k_receiver_userid = u.user_id");
			sql.append("   and (o.k_isview is null or o.k_isview = '0')");
			sql.append(" and o.k_doc_id = ? ");
			conditionValues.add(model.getK_doc_id());
			sql.append(" order by " + sortName + " " + sortOrder);
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,conditionValues);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	/**
	*<b>Summary: </b>
	* queryKbmDocReadList(查询体系文件已阅读列表)
	* @param model
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean queryKbmDocReadList(KbmDocBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception{
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pb = new PagingBean();
			StringBuffer sql = new StringBuffer();
			List<String> conditionValues = new ArrayList<String>();
			sql.append("select o.k_receiveruser_orgname as k_receiveruser_orgname, ");
			sql.append("       o.k_receiver_username as k_receiver_username, ");
			sql.append("       o.k_creator_time as k_creator_time, ");
			sql.append("       u.user_mobiletel1 as user_mobiletel1  ");
			sql.append("  from oa_kbm_docreceiveuser o, td_sm_user u");
			sql.append(" where o.k_receiver_userid = u.user_id");
			sql.append("   and o.k_isview = '1' ");
			sql.append(" and o.k_doc_id = ? ");
			conditionValues.add(model.getK_doc_id());
			sql.append(" order by " + sortName + " " + sortOrder);
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,conditionValues);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	@Override
	public String getTXWJManager() {
		String txwjManager = "";
		try{
			PreparedDBUtil db = new PreparedDBUtil();
			String sql = "select su.user_id from td_sm_userrole su where su.role_id in (select sr.role_id from td_sm_role sr where sr.role_name like '%体系文件管理员%')";
			db.preparedSelect(sql);
			db.executePrepared();
			if(db.size()>0){
				for(int i=0;i<db.size();i++){
					txwjManager +=db.getString(i, "user_id");
				}
			}
		}catch(Exception e){
			 System.out.println(e.toString());
		}
		return txwjManager;
	}

	@Override
	public void deleteNotice(String k_doc_id,Connection conn) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		String sql = "update oa_kbm_doc set k_luojishanchu = '1' where k_doc_id = ?";
		db.preparedDelete(sql);
		db.setString(1, k_doc_id);
		db.executePrepared(conn);
	}
	
}
