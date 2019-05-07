package com.chinacreator.xtbg.core.file.service.impl;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.file.dao.FileDestroyDao;
import com.chinacreator.xtbg.core.file.entity.FileDestroyBean;
import com.chinacreator.xtbg.core.file.entity.FileDestroyDetalBean;
import com.chinacreator.xtbg.core.file.entity.FileDocBean;
import com.chinacreator.xtbg.core.file.service.FileDestroyService;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:FileDestroyServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛
 *@version 1.0
 *2013-8-22
 */
public class FileDestroyServiceImpl implements FileDestroyService{
	private static final Log LOG = LogFactory.getLog(FileDestroyServiceImpl.class);
	@Override
	public boolean addfiledestroydetal(FileDestroyDetalBean bean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileDestroyDao dao = (FileDestroyDao)LoadSpringContext.getApplicationContext().getBean("fileDestroyDaoImpl");
			bean.setF_destroy_time(new Timestamp(new Date().getTime()));
			bean.setF_destroy_state("1"); //1 为已销毁 0是正常
			((BaseDao)dao).insert(bean, conn);
			conn.commit();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	@Override
	public boolean updatedestroydetal(String id) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			String sql="update OA_FILE_DESTROY_DETAIL set f_destroy_state = '0' where f_doc_id ="+id;
			String docsql = "update oa_file_doc set f_destroy_state ='0',f_doc_state='"+FileDocBean.STATE_YGD+"',f_doc_state_name='"+FileDocBean.STATE_YGD_NM+"' where f_doc_id ="+id;
			PreparedDBUtil pdb = new PreparedDBUtil();
			pdb.preparedUpdate(sql.toString());
			pdb.executePrepared(conn);
			pdb.preparedUpdate(docsql.toString());
			pdb.executePrepared(conn);
			conn.commit();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	@Override
	public List<Map<String, String>> getFiledestoryDetail(String id) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			FileDestroyDao dao = (FileDestroyDao)LoadSpringContext.getApplicationContext().getBean("fileDestroyDaoImpl");
			return dao.getFiledestoryDetail(id, conn);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return null;
	}
	@Override
	public boolean delfiledestroy(String[] ids) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileDestroyDao dao = (FileDestroyDao)LoadSpringContext.getApplicationContext().getBean("fileDestroyDaoImpl");
			for(String id : ids){
				((BaseDao)dao).deleteListById(new FileDestroyBean(), conn, id);
			}
			conn.commit();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	/**
	 * 
	 */
	@Override
	public boolean stopFileDestroy(String ids) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileDestroyDao dao = (FileDestroyDao)LoadSpringContext.getApplicationContext().getBean("fileDestroyDaoImpl");
			dao.stopFileDestroy(ids, conn);
			conn.commit();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	
}
