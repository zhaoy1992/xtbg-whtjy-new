package com.chinacreator.xtbg.core.inspect.service.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.inspect.dao.InspectTypeDao;
import com.chinacreator.xtbg.core.inspect.entity.InspectTypeBean;
import com.chinacreator.xtbg.core.inspect.service.InspectTypeService;
/**
 * 
 *<p>Title:InspectTypeServiceImpl.java</p>
 *<p>Description:督查督办的任务类别服务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-11-4
 */
public class InspectTypeServiceImpl implements InspectTypeService {

	private static final Log LOG=LogFactory.getLog(InspectTypeServiceImpl.class);
	InspectTypeDao dao=(InspectTypeDao)LoadSpringContext.getApplicationContext().getBean("inspectTypeDaoImpl");
	/**
	 * 
	  * <b>Summary: 根据id查询类别信息</b>
	  *     复写方法 getInspectTypeByid
	  * @param type_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.inspect.service.InspectTypeService#getInspectTypeByid(java.lang.String)
	 */
	public Map<String, String> getInspectTypeByid(String type_id) {
		Connection conn = null;
		Map<String, String> map=new HashMap<String, String>();
		try {
			conn = DbManager.getInstance().getConnection();
			InspectTypeBean bean = new InspectTypeBean();
			bean.setType_id(type_id);
			map = ((BaseDao) dao).queryToSingleMap(bean, conn);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} finally {
			DbManager.closeConnection(conn);
		}
		return map;
	}
	/**
	 * 
	  * <b>Summary: 新增类别</b>
	  *     复写方法 addInspectType
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.core.inspect.service.InspectTypeService#addInspectType(com.chinacreator.xtbg.core.inspect.entity.InspectTypeBean)
	 */
	public boolean addInspectType(InspectTypeBean bean) {
		Connection conn = null;
		boolean flag=false;
		try {
			conn = DbManager.getInstance().getConnection();
			bean.setType_id(StringUtil.getUUID());
			((BaseDao) dao).insert(bean, conn);
			flag=true;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} finally {
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	/**
	 * 
	  * <b>Summary:修改类别 </b>
	  *     复写方法 updateInspectType
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.core.inspect.service.InspectTypeService#updateInspectType(com.chinacreator.xtbg.core.inspect.entity.InspectTypeBean)
	 */
	public boolean updateInspectType(InspectTypeBean bean) {
		Connection conn = null;
		boolean flag=false;
		try {
			conn = DbManager.getInstance().getConnection();
			((BaseDao) dao).update(bean, conn);
			flag=true;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} finally {
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	/**
	 * 
	  * <b>Summary: 删除类别</b>
	  *     复写方法 delInspectType
	  * @param type_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.inspect.service.InspectTypeService#delInspectType(java.lang.String)
	 */
	public boolean delInspectType(String type_id) {
		Connection conn = null;
		boolean flag=false;
		try {
			conn = DbManager.getInstance().getConnection();
			InspectTypeBean bean=new InspectTypeBean();
			bean.setDeleteKey("type_id");
			((BaseDao) dao).deleteListById(bean, conn, type_id);
			flag=true;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} finally {
			DbManager.closeConnection(conn);
		}
		return flag;
	}

}
