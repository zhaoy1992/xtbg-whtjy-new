package com.chinacreator.xtbg.core.kbm.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.kbm.dao.KbmDocTypeDao;
import com.chinacreator.xtbg.core.kbm.dao.KbmDocTypeconfigDao;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocBean;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocTypeBean;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocTypeRightConfig;
import com.chinacreator.xtbg.core.kbm.service.KbmDocTypeServiceIfc;
/**
 * 
 *<p>Title:KbmDocTypeServiceImpl.java</p>
 *<p>Description:知识库文档分类服务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-6
 */
public class KbmDocTypeServiceImpl implements KbmDocTypeServiceIfc {

	private static final Log LOG=LogFactory.getLog(KbmDocTypeServiceImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getKbmDocTypeBean
	  * @param k_type_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.service.KbmDocTypeServiceIfc#getKbmDocTypeBean(java.lang.String)
	 */
	public Map<String, String> getKbmDocTypeBean(String k_type_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			KbmDocTypeDao kbmDocTypeDao=(KbmDocTypeDao)LoadSpringContext.getApplicationContext().getBean("kbmDocTypeDaoImpl");
			viewMap = kbmDocTypeDao.getKbmDocType(k_type_id, conn);
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
	  *     复写方法 getIsrecursionDataForInsert
	  * @param parentId
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.service.KbmDocTypeServiceIfc#getIsrecursionDataForInsert(java.lang.String)
	 */
	public KbmDocTypeBean getIsrecursionDataForInsert(String parentId) {
		KbmDocTypeBean bean = new KbmDocTypeBean();
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			KbmDocTypeDao dao=(KbmDocTypeDao)LoadSpringContext.getApplicationContext().getBean("kbmDocTypeDaoImpl");
			Map<String,String> map = dao.getIsrecursionDataById(conn, parentId);
			bean.setK_type_id(map.get("k_type_id"));
			bean.setK_content_template(map.get("k_content_template"));
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return bean;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 insertOrUpdateKbmDocTypeBean
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.service.KbmDocTypeServiceIfc#insertOrUpdateKbmDocTypeBean(com.chinacreator.xtbg.core.kbm.entity.KbmDocTypeBean)
	 */
	public String insertOrUpdateKbmDocTypeBean(KbmDocTypeBean bean) {
		Connection conn = null;
		String beanId = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			KbmDocTypeDao dao=(KbmDocTypeDao)LoadSpringContext.getApplicationContext().getBean("kbmDocTypeDaoImpl");
			//1:设置时间F_creator_time
			bean.setK_create_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getK_create_time()), "yyyy-MM-dd HH24:mi:ss"));
			if(StringUtil.nullOrBlank(bean.getK_type_id())){//insert
				bean.setK_type_id(StringUtil.getUUID());
				bean.setK_parent_type_id(StringUtil.deNull(bean.getK_parent_type_id()));
				beanId = bean.getK_type_id();
				
				((BaseDao)dao).insert(bean, conn);
			}else{//update
				beanId = bean.getK_type_id();
				if(KbmDocTypeBean.IS_RECURSION_YES.equals(bean.getK_isrecursion_content())){
					dao.updateChildrenDocTypeByBean(bean,conn);
				}
				//如果分类名称修改  更新相应文档的分类名称
				List<Map<String, String>> list=new ArrayList<Map<String,String>>();
				list=dao.getKbmDocById(bean.getK_type_id());
				if(list.size()>0){
					String oldtypename=bean.getK_type_name();
					KbmDocBean docbean=new KbmDocBean();
					docbean.setK_type_name(oldtypename);
					for (Map<String, String> map : list) {
						docbean.setK_doc_id(map.get("k_doc_id"));
						((BaseDao)dao).update(docbean, conn);
					}
				}
				
				((BaseDao)dao).update(bean, conn);
			}
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return beanId;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteDocTypeInfoByIds
	  * @param beanIdArr
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.service.KbmDocTypeServiceIfc#deleteDocTypeInfoByIds(java.lang.String[])
	 */
	public String deleteDocTypeInfoByIds(String[] beanIdArr) {
		Connection conn = null;
		String flag = "false";
		int count=0;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			KbmDocTypeDao dao=(KbmDocTypeDao)LoadSpringContext.getApplicationContext().getBean("kbmDocTypeDaoImpl");
			for (String beanId : beanIdArr) {
				//判断该分类是否被引用
				count=dao.isKbmDocBean(conn, beanId);
				if(count>0){
					return "number";
				}
				//判断该分类子类是否被引用
				List<Map<String, String>> list=dao.getSonDocTypeBeansById(beanId);
				for (Map<String, String> map : list) {
					count=dao.isKbmDocBean(conn, map.get("k_type_id"));
					if(count>0){
						return "number";
					}
				}
				//先删该节点以及子节点的权限内容
				dao.deleteChildrenDocTypeConfigByBean(beanId, conn);
				//删除该节点以及子节点
				dao.deleteDocTypeBeansById(conn, beanId);
			}
			conn.commit();
			flag = "true";
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
	  * <b>Summary: </b>
	  *     复写方法 getMaxDocTypeConfigNum
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.service.KbmDocTypeServiceIfc#getMaxDocTypeConfigNum()
	 */
	public int getMaxDocTypeConfigNum() {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			KbmDocTypeconfigDao dao=(KbmDocTypeconfigDao)LoadSpringContext.getApplicationContext().getBean("kbmDocTypeConfigDaoImpl");
			return dao.getMaxDocTypeConfigNum(conn);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return 0;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getDocTypeConfigBeanById
	  * @param beanId
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.service.KbmDocTypeServiceIfc#getDocTypeConfigBeanById(java.lang.String)
	 */
	public Map<String, String> getDocTypeConfigBeanById(String beanId) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			KbmDocTypeconfigDao dao=(KbmDocTypeconfigDao)LoadSpringContext.getApplicationContext().getBean("kbmDocTypeConfigDaoImpl");
			return dao.getDocTypeConfigBeanById(conn, beanId);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return null;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 insertOrUpdateDocConfigBean
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.service.KbmDocTypeServiceIfc#insertOrUpdateDocConfigBean(com.chinacreator.xtbg.core.kbm.entity.KbmDocTypeRightConfig)
	 */
	public boolean insertOrUpdateDocConfigBean(KbmDocTypeRightConfig bean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			KbmDocTypeconfigDao dao=(KbmDocTypeconfigDao)LoadSpringContext.getApplicationContext().getBean("kbmDocTypeConfigDaoImpl");
			KbmDocTypeDao typedao=(KbmDocTypeDao)LoadSpringContext.getApplicationContext().getBean("kbmDocTypeDaoImpl");
			if(KbmDocTypeRightConfig.CAN_DO.equals(bean.getK_role_range())){
				bean.setK_role_range_name("所有人");
			}
			if(KbmDocTypeRightConfig.CAN_NOT_DO.equals(bean.getK_role_range())){
				bean.setK_role_range_name("本部门");
			}
			if(StringUtil.nullOrBlank(bean.getK_id())){
				bean.setK_id(StringUtil.getUUID());
				((BaseDao)dao).insert(bean, conn);
			}else{
				((BaseDao)dao).update(bean, conn);
			}
			//1.如果不是最底层  修改改分类下所有权限
			//1.1得到该分类下的所有子类
			List<Map<String, String>> list=typedao.getSonDocTypeBeansById(bean.getK_type_id());
			if(list.size()>0){//如果大于零则修改list里分类的权限
				//1.2得到该分类的所有权限
				List<KbmDocTypeRightConfig> configbeans=dao.queryListKbmDocTypeConfig(bean.getK_type_id(), conn);
				//1.3删除该分类下的所有子分类的权限
				typedao.deletesonDocTypeConfigByBean(bean.getK_type_id(), conn);
				for (Map<String, String> typebean : list) {
					//1.4添加该子分类的权限
					for (KbmDocTypeRightConfig configbean : configbeans) {
						configbean.setK_id(StringUtil.getUUID());
						configbean.setK_type_id(typebean.get("k_type_id"));
						((BaseDao)dao).insert(configbean, conn);
					}
				}
				
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
	  * <b>Summary: </b>
	  *     复写方法 deleteDocTypeConfigInfoByIds
	  * @param beanIdArr
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.service.KbmDocTypeServiceIfc#deleteDocTypeConfigInfoByIds(java.lang.String[])
	 */
	public boolean deleteDocTypeConfigInfoByIds(String[] beanIdArr) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			KbmDocTypeconfigDao dao=(KbmDocTypeconfigDao)LoadSpringContext.getApplicationContext().getBean("kbmDocTypeConfigDaoImpl");
			KbmDocTypeDao typedao=(KbmDocTypeDao)LoadSpringContext.getApplicationContext().getBean("kbmDocTypeDaoImpl");

			//得到权限所属分类ID
			String k_type_id=(dao.getDocTypeConfigBeanById(conn, beanIdArr[0])).get("k_type_id");
			
			for (String beanId : beanIdArr) {
				KbmDocTypeRightConfig bean=new KbmDocTypeRightConfig();
				bean.setK_id(beanId);
				((BaseDao)dao).deleteListById(bean, conn, beanId);
			}
			
			//1.如果不是最底层  修改改分类下所有权限
			//1.1得到该分类下的所有子类
			List<Map<String, String>> list=typedao.getSonDocTypeBeansById(k_type_id);
			if(list.size()>0){//如果大于零则修改list里分类的权限
				//1.2得到该分类的所有权限
				List<KbmDocTypeRightConfig> configbeans=dao.queryListKbmDocTypeConfig(k_type_id, conn);
				//1.3删除该分类下的所有子分类的权限
				typedao.deletesonDocTypeConfigByBean(k_type_id, conn);
				for (Map<String, String> typebean : list) {
					//1.4添加该子分类的权限
					for (KbmDocTypeRightConfig configbean : configbeans) {
						configbean.setK_id(StringUtil.getUUID());
						configbean.setK_type_id(typebean.get("k_type_id"));
						((BaseDao)dao).insert(configbean, conn);
					}
				}
				
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

}
