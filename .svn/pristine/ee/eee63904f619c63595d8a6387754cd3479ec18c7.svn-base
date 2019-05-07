package com.chinacreator.xtbg.core.kbm.service.impl;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.kbm.dao.KbmDocSuggestDao;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocBean;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocSuggestBean;
import com.chinacreator.xtbg.core.kbm.service.KbmDocService;
import com.chinacreator.xtbg.core.kbm.service.KbmDocSuggestService;
/**
 * 
 *<p>Title:KbmDocSuggestServiceImpl.java</p>
 *<p>Description:知识库推荐文档服务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-16
 */
public class KbmDocSuggestServiceImpl implements KbmDocSuggestService {

	private static final Log LOG=LogFactory.getLog(KbmDocSuggestServiceImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 insertKbmDocSuggest 添加推荐
	  * @param userids
	  * @param username
	  * @param k_doc_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.service.KbmDocSuggestService#insertKbmDocSuggest(java.lang.String, java.lang.String, java.lang.String)
	 */
	public boolean insertKbmDocSuggest(String userids, String k_doc_id,String usercacheid) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getConnection();
			KbmDocSuggestDao dao = (KbmDocSuggestDao)LoadSpringContext.getApplicationContext().getBean("kbmDocSuggestDaoImpl");
			Timestamp time=StringUtil.convertStringToTimestamp(DateUtil.getCurrentDateTime());
			KbmDocService docservice=new KbmDocServiceImpl();
			KbmDocSuggestBean bean=new KbmDocSuggestBean();
			//根据k_doc_id得到文档的信息
			KbmDocBean docbean= docservice.getKbmDocBeanById(k_doc_id);
			//根据usercacheid得到当前用户信息
			UserCacheBean usercachebean=UserCache.getUserCacheBean(usercacheid);
			//设置封装实体bean的不变动值
			bean.setK_is_read("0");
			bean.setK_create_user(usercachebean.getUser_id());
			bean.setK_create_user_name(usercachebean.getUser_realname());
			bean.setK_create_time(time);
			bean.setK_type(docbean.getK_type_id());
			bean.setK_type_name(docbean.getK_type_name());
			bean.setK_doc_id(docbean.getK_doc_id());
			bean.setK_title(docbean.getK_title());
			bean.setK_unit(docbean.getK_unit());
			bean.setK_unit_name(docbean.getK_unit_name());
			//根据k_doc_id和userids先删除已存在推荐文档
			dao.delSuggestBean(userids.replaceAll(",", "','"), k_doc_id, conn);
			//根据userids得到推荐用户的信息
			List<Map<String, String>> list= dao.getUserBeanbyuserids(userids, conn);
			for (Map<String, String> userbean  : list) {
				//设置封装实体bean的变动值
				bean.setK_id(StringUtil.getUUID());
				bean.setK_user(userbean.get("user_id"));
				bean.setK_user_name(userbean.get("user_realname"));
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
