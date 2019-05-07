package com.chinacreator.xtbg.core.kbm.service.impl;

import java.sql.Connection;
import java.sql.Timestamp;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.kbm.dao.KbmDocDao;
import com.chinacreator.xtbg.core.kbm.dao.KbmDocFavoritesDao;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocBean;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocFavoritesBean;
import com.chinacreator.xtbg.core.kbm.service.KbmDocFavoritesService;
import com.chinacreator.xtbg.core.kbm.service.KbmDocService;
/**
 * 
 *<p>Title:KbmDocFavoritesServiceImpl.java</p>
 *<p>Description:知识库我的收藏服务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-12
 */
public class KbmDocFavoritesServiceImpl implements KbmDocFavoritesService {

	private static final Log LOG=LogFactory.getLog(KbmDocFavoritesServiceImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteFavorites
	  * @param beanid
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.service.KbmDocFavoritesService#deleteFavorites(java.lang.String)
	 */
	public Boolean deleteFavorites(String beanids) {
		Connection conn=null;
		Boolean flag=false;
		String p_id_list[]=null;
		try {
			conn=DbManager.getInstance().getTransactionConnection();
			KbmDocDao dao = (KbmDocDao)LoadSpringContext.getApplicationContext().getBean("kbmDocDaoImpl");
			if(!StringUtil.isBlank(beanids)){
				p_id_list=beanids.split(",");
				for (int i = 0; i < p_id_list.length; i++) {
					KbmDocFavoritesBean bean=new KbmDocFavoritesBean();
					bean.setK_favorites_id(p_id_list[i]);
					((BaseDao)dao).deleteListById(bean, conn, p_id_list[i]);
				}
			}
			flag = true;
			conn.commit();
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
	  *     复写方法 insertKbmDocFavorites
	  * @param userid
	  * @param username
	  * @param k_doc_ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.service.KbmDocService#insertKbmDocFavorites(java.lang.String, java.lang.String, java.lang.String)
	 */
	public boolean insertKbmDocFavorites(String userid, String username,
			String k_doc_ids) {
		Connection conn = null;
		boolean flag = false;
		String ids[]=k_doc_ids.split(",");
		try {
			conn = DbManager.getInstance().getConnection();
			KbmDocFavoritesDao dao = (KbmDocFavoritesDao)LoadSpringContext.getApplicationContext().getBean("kbmDocFavoritesDaoImpl");
			Timestamp time=StringUtil.convertStringToTimestamp(DateUtil.getCurrentDateTime());
			KbmDocService docservice=new KbmDocServiceImpl();
			for (String id  : ids) {
				KbmDocFavoritesBean bean=new KbmDocFavoritesBean();
				//根据id和userid先删除已存在的收藏
				dao.delFavoritesBan(userid, id, conn);
				//根据id得到文档的信息
				KbmDocBean docbean= docservice.getKbmDocBeanById(id);
				//封装收藏实体bean
				bean.setK_favorites_id(StringUtil.getUUID());
				bean.setK_create_user(userid);
				bean.setK_create_userr_name(username);
				bean.setK_create_time(time);
				bean.setK_doc_id(id);
				bean.setK_title(docbean.getK_title());
				bean.setK_type_id(docbean.getK_type_id());
				bean.setK_type_name(docbean.getK_type_name());
				bean.setK_doc_user(docbean.getK_create_user());
				bean.setK_doc_user_name(docbean.getK_create_user_name());
				
				((BaseDao)dao).insert(bean, conn);
				
			}
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally {
			DbManager.closeConnection(conn);
		}
		return flag;
	}
}
