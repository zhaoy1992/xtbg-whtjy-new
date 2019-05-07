package com.chinacreator.xtbg.core.kbm.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.kbm.dao.KbmDocBbsDao;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocBbsBean;
import com.chinacreator.xtbg.core.kbm.service.KbmDocBbsService;
/**
 * 
 *<p>Title:KbmDocBssServiceImpl.java</p>
 *<p>Description:知识库文档评阅服务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-15
 */
public class KbmDocBbsServiceImpl implements KbmDocBbsService {

	private static final Log LOG=LogFactory.getLog(KbmDocBbsServiceImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 addKbmDocBbs
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.service.KbmDocBbsService#addKbmDocBbs(com.chinacreator.xtbg.core.kbm.entity.KbmDocBbsBean)
	 */
	public boolean addKbmDocBbs(KbmDocBbsBean bean) {
		Boolean flag=false;
		Connection conn=null;
		try {
			conn=DbManager.getInstance().getConnection();
			KbmDocBbsDao dao=(KbmDocBbsDao)LoadSpringContext.getApplicationContext().getBean("kbmDocBbsDaoImpl");
			bean.setK_create_time(StringUtil.convertStringToTimestamp(bean.getK_create_time()));
			bean.setK_id(StringUtil.getUUID());
			
			((BaseDao)dao).insert(bean, conn);
			flag=true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		}finally{
			if(conn!=null){
				DbManager.closeConnection(conn);
			}
		}
		return flag;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 selectKbmDocBbs
	  * @param k_doc_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.service.KbmDocBbsService#selectKbmDocBbs(java.lang.String)
	 */
	public List<Map<String, String>> selectKbmDocBbs(String k_doc_id) {
		Connection conn = null;
		List<Map<String, String>> list =new ArrayList<Map<String,String>>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			KbmDocBbsDao dao=(KbmDocBbsDao)LoadSpringContext.getApplicationContext().getBean("kbmDocBbsDaoImpl");
			list = dao.getKbmDocBbsBeans(k_doc_id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
			
		}
		return list;
	}

}
