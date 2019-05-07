package com.chinacreator.xtbg.core.data.service.impl;

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
import com.chinacreator.xtbg.core.data.dao.DataTypeDao;
import com.chinacreator.xtbg.core.data.entity.DataDataBean;
import com.chinacreator.xtbg.core.data.entity.DataTypeBean;
import com.chinacreator.xtbg.core.data.service.DataTypeService;
/**
 * 
 *<p>Title:DataTypeServiceImpl.java</p>
 *<p>Description:资料分类服务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-20
 */
public class DataTypeServiceImpl implements DataTypeService {

	private static final Log LOG=LogFactory.getLog(DataTypeServiceImpl.class);
	/**
	 * 
	  * <b>Summary:根据id得到资料分类信息 </b>
	  *     复写方法 getDataTypeBean
	  * @param id
	  * @return 
	  * @see com.chinacreator.xtbg.core.data.service.DataTypeService#getDataTypeBean(java.lang.String)
	 */
	public Map<String, String> getDataTypeBean(String id) {
		Connection conn=null;
		Map<String, String> map=new HashMap<String, String>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DataTypeDao dao=(DataTypeDao)LoadSpringContext.getApplicationContext().getBean("dataTypeDaoImpl");
			map = dao.getDataTypeBean(id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return map;
	}
	/**
	 * 
	  * <b>Summary:增加和修改资料分类信息 </b>
	  *     复写方法 insertOrUpdateDataTypeBean
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.core.data.service.DataTypeService#insertOrUpdateDataTypeBean(com.chinacreator.xtbg.core.data.entity.DataTypeBean)
	 */
	public String insertOrUpdateDataTypeBean(DataTypeBean bean) {
		Connection conn = null;
		String beanId = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DataTypeDao dao=(DataTypeDao)LoadSpringContext.getApplicationContext().getBean("dataTypeDaoImpl");
			//1:设置时间F_creator_time
			bean.setD_type_create_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getD_type_create_time()), "yyyy-MM-dd HH24:mi:ss"));
			if(StringUtil.nullOrBlank(bean.getD_type_id())){//insert
				bean.setD_type_id(StringUtil.getUUID());
				bean.setD_type_parent_id(StringUtil.deNull(bean.getD_type_parent_id()));
				beanId = bean.getD_type_id();
				
				((BaseDao)dao).insert(bean, conn);
			}else{//update
				beanId = bean.getD_type_id();
				//如果修改分类名称则修改该分类下的所有资料的分类名称
				DataDataServiceImpl service=new DataDataServiceImpl();
				List<Map<String, String>> list=new ArrayList<Map<String,String>>();
				list=service.getDataBaseBeanList(bean.getD_type_id());
				String oldtypename=bean.getD_type_name();
				if(list.size()>0){
					for (Map<String, String> map : list) {
						DataDataBean databean=new DataDataBean();
						databean.setD_data_id(map.get("d_data_id"));
						databean.setD_type_name(oldtypename);
						((BaseDao)dao).update(databean, conn);
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
	  * <b>Summary: 根据ids删除资料分类信息</b>
	  *     复写方法 deleteDataTypeInfoByIds
	  * @param beanIdArr
	  * @return 
	  * @see com.chinacreator.xtbg.core.data.service.DataTypeService#deleteDataTypeInfoByIds(java.lang.String[])
	 */
	public String deleteDataTypeInfoByIds(String[] beanIdArr) {
		Connection conn = null;
		String flag = "false";
		//int count=0;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DataTypeDao dao=(DataTypeDao)LoadSpringContext.getApplicationContext().getBean("dataTypeDaoImpl");
			for (String beanId : beanIdArr) {
				//判断该分类是否有子分类
				boolean isson=dao.isSonDataType(conn, beanId);
				if(isson){
					return "parent";
				}
				//判断该分类是否被引用
				DataDataServiceImpl service=new DataDataServiceImpl();
				List<Map<String, String>> list=new ArrayList<Map<String,String>>();
				list=service.getDataBaseBeanList(beanId);
				if(list.size()>0){
					return "number";
				}
				//删除该节点以及子节点
				dao.deleteDataTypeBeansById(conn, beanId);
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

}
