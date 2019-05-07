package com.chinacreator.xtbg.core.archive.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.archive.dao.ComideaDao;
import com.chinacreator.xtbg.core.archive.entity.DocumentComideaBean;
import com.chinacreator.xtbg.core.archive.service.ComideaService;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
/**
 * 
 *<p>Title:ComideaServiceImpl.java</p>
 *<p>Description:常用意见服务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-11-20
 */
public class ComideaServiceImpl implements ComideaService {

	private static final Log LOG=LogFactory.getLog(ComideaServiceImpl.class);
	/**
	 * 
	  * <b>Summary:保存常用意见 </b>
	  *     复写方法 saveComidea
	  * @param paramJson
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.service.ComideaService#saveNumber(java.lang.String)
	 */
	public boolean saveComidea(DocumentComideaBean bean) {
		ComideaDao dao = (ComideaDao)LoadSpringContext.getApplicationContext().getBean("comideaDaoImpl");
		boolean flag = false;
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			bean.setIdea_id(StringUtil.getUUID());
			((BaseDao)dao).insert(bean, conn);
			flag=true;
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(),e);
		}finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return flag;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 delComidea
	  * @param content
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.service.ComideaService#delComidea(java.lang.String)
	 */
	public boolean delComidea(String content,String user_id) {
		ComideaDao dao = (ComideaDao)LoadSpringContext.getApplicationContext().getBean("comideaDaoImpl");
		boolean flag = false;
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			flag=dao.delComidea(content,user_id, conn);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(),e);
		}finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return flag;
	}
	@Override
	public List<DocumentComideaBean> getList(String userId) {
		List<DocumentComideaBean> list = new ArrayList<DocumentComideaBean>();
		ComideaDao dao = (ComideaDao)LoadSpringContext.getApplicationContext().getBean("comideaDaoImpl");
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			list = dao.getList(userId, conn);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(),e);
		}finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return list;
	}

	
}
