package com.chinacreator.xtbg.core.kbm.service.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.kbm.dao.KbmDocOperateLogDao;
import com.chinacreator.xtbg.core.kbm.dao.KbmDocRssDao;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocOperateLogBean;
import com.chinacreator.xtbg.core.kbm.service.KbmDocOperateLogService;
/**
 * 
 *<p>Title:KbmDocOperateLogServiceImpl.java</p>
 *<p>Description:文档用户操作情况记录服务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-28
 */
public class KbmDocOperateLogServiceImpl extends XtDbBaseDao implements KbmDocOperateLogService {

	private static final Log LOG=LogFactory.getLog(KbmDocOperateLogServiceImpl.class);
	/**
	 * 
	  * <b>Summary: 根据文档id和用户查询操作记录</b>
	  *     复写方法 selectKbmDocBbs
	  * @param id
	  * @param userid
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.service.KbmDocOperateLogService#selectKbmDocBbs(java.lang.String, java.lang.String)
	 */
	public Map<String, String> getKbmDocOperateLog(String id, String userid) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			KbmDocOperateLogDao dao=(KbmDocOperateLogDao)LoadSpringContext.getApplicationContext().getBean("kbmDocOperateLogDaoImpl");
			viewMap = dao.getKbmDocOperateLog(id, userid, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
			
		}
		return viewMap;
	}
	/**
	 * 
	  * <b>Summary:根据文档ids删除相应的文档用户表信息 </b>
	  *     复写方法 deleteKbmDocOperateLog
	  * @param k_doc_ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.service.KbmDocOperateLogService#deleteKbmDocOperateLog(java.lang.String)
	 */
	public Boolean deleteKbmDocOperateLog(String k_doc_ids) {
		Connection conn=null;
		Boolean flag=false;
		String p_id_list[]=null;
		try {
			conn=DbManager.getInstance().getTransactionConnection();
			KbmDocOperateLogDao dao=(KbmDocOperateLogDao)LoadSpringContext.getApplicationContext().getBean("kbmDocOperateLogDaoImpl");
			if(!StringUtil.isBlank(k_doc_ids)){
				p_id_list=k_doc_ids.split(",");
				KbmDocOperateLogBean bean=new KbmDocOperateLogBean();
				bean.setDeleteKey("k_doc_id");
				for (int i = 0; i < p_id_list.length; i++) {
					((BaseDao)dao).deleteListById(bean, conn, p_id_list[i]);
				}
			}
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return flag;
	}
	/**
	 * 
	  * <b>Summary: 添加或修改文档信息表</b>
	  *     复写方法 addorupdataKbmDocOperateLog
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.service.KbmDocOperateLogService#addorupdataKbmDocOperateLog(com.chinacreator.xtbg.core.kbm.entity.KbmDocOperateLogBean)
	 */
	public Boolean addorupdataKbmDocOperateLog(KbmDocOperateLogBean bean) {
		Connection conn=null;
		Boolean flag=false;
		try {
			conn=DbManager.getInstance().getTransactionConnection();
			KbmDocRssDao dao = (KbmDocRssDao)LoadSpringContext.getApplicationContext().getBean("kbmDocRssDaoImpl");
			//设置时间
			bean.setK_create_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getK_create_time()), "yyyy-MM-dd HH24:mi:ss"));
			//根据文档id和操作人id来判断文档用户操作记录表是否存在
			Map<String, String> mapbean=getKbmDocOperateLog(bean.getK_doc_id(), bean.getK_create_user());
			String k_id=mapbean.get("k_id");
			if(StringUtil.isBlank(k_id)){//为空添加，反之修改
				bean.setK_id(StringUtil.getUUID());
				((BaseDao)dao).insert(bean, conn);
			}else{//是否下载现在还需求还没有 所以只有是否阅读  所有目前只有添加
				
			}
			
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return flag;
	}

}
