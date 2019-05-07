package com.chinacreator.xtbg.core.kbm.service.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.kbm.dao.KbmDocRssDao;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocRssBean;
import com.chinacreator.xtbg.core.kbm.service.KbmDocRssService;
/**
 * 
 *<p>Title:KbmDocRssServiceImpl.java</p>
 *<p>Description:知识库文档订阅服务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-13
 */
public class KbmDocRssServiceImpl implements KbmDocRssService {

	private static final Log LOG=LogFactory.getLog(KbmDocRssServiceImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteKbmDocRss
	  * @param beanids
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.service.KbmDocRssService#deleteKbmDocRss(java.lang.String)
	 */
	public Boolean deleteKbmDocRss(String beanids) {
		Connection conn=null;
		Boolean flag=false;
		String p_id_list[]=null;
		try {
			conn=DbManager.getInstance().getTransactionConnection();
			KbmDocRssDao dao = (KbmDocRssDao)LoadSpringContext.getApplicationContext().getBean("kbmDocRssDaoImpl");
			if(!StringUtil.isBlank(beanids)){
				p_id_list=beanids.split(",");
				for (int i = 0; i < p_id_list.length; i++) {
					KbmDocRssBean bean=new KbmDocRssBean();
					bean.setK_rss_id(p_id_list[i]);
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
	  * <b>Summary: </b>
	  *     复写方法 getKbmDocRssBean
	  * @param k_rss_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.service.KbmDocRssService#getKbmDocRssBean(java.lang.String)
	 */
	public Map<String, String> getKbmDocRssBean(String k_rss_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			KbmDocRssDao dao = (KbmDocRssDao)LoadSpringContext.getApplicationContext().getBean("kbmDocRssDaoImpl");
			viewMap = dao.getKbmDocRss(k_rss_id, conn);
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
	  * <b>Summary: </b>
	  *     复写方法 addKbmDocRss
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.service.KbmDocRssService#addKbmDocRss(com.chinacreator.xtbg.core.kbm.entity.KbmDocRssBean)
	 */
	public Boolean addKbmDocRss(KbmDocRssBean bean) {
		Connection conn=null;
		Boolean flag=false;
		try {
			conn=DbManager.getInstance().getTransactionConnection();
			KbmDocRssDao dao = (KbmDocRssDao)LoadSpringContext.getApplicationContext().getBean("kbmDocRssDaoImpl");
			//设置时间
			bean.setK_create_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getK_create_time()), "yyyy-MM-dd HH24:mi:ss"));
			//根据分类批量添加
			String type[]=bean.getK_type_id().split(",");
			String name[]=bean.getK_type_name().split(",");
			for (int i = 0; i < type.length; i++){
				bean.setK_rss_id(StringUtil.getUUID());
				bean.setK_type_id(type[i]);
				bean.setK_type_name(name[i]);
				((BaseDao)dao).insert(bean, conn);
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
	  * <b>Summary: </b>
	  *     复写方法 updKbmDocRss
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.service.KbmDocRssService#updKbmDocRss(com.chinacreator.xtbg.core.kbm.entity.KbmDocRssBean)
	 */
	public Boolean updKbmDocRss(KbmDocRssBean bean) {
		Connection conn=null;
		Boolean flag=false;
		try {
			conn=DbManager.getInstance().getTransactionConnection();
			KbmDocRssDao dao = (KbmDocRssDao)LoadSpringContext.getApplicationContext().getBean("kbmDocRssDaoImpl");
			//设置时间
			bean.setK_create_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getK_create_time()), "yyyy-MM-dd HH24:mi:ss"));
			//先删除
			((BaseDao)dao).delete(bean, conn);
			//在添加
			String type[]=bean.getK_type_id().split(",");
			String name[]=bean.getK_type_name().split(",");
			for (int i = 0; i < type.length; i++){
				bean.setK_rss_id(StringUtil.getUUID());
				bean.setK_type_id(type[i]);
				bean.setK_type_name(name[i]);
				((BaseDao)dao).insert(bean, conn);
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
