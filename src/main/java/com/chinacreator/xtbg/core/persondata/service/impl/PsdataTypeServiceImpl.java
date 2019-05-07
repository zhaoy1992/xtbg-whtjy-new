package com.chinacreator.xtbg.core.persondata.service.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.persondata.dao.PsdataTypeDao;
import com.chinacreator.xtbg.core.persondata.entity.PsdataTypeBean;
import com.chinacreator.xtbg.core.persondata.service.PsdataTypeService;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:PsdataTypeServiceImpl.java</p>
 *<p>Description:个人文件柜分类服务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2013-8-9
 */
public class PsdataTypeServiceImpl implements PsdataTypeService {

	private static final Log LOG=LogFactory.getLog(PsdataTypeServiceImpl.class);

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getPsdataTypeBean
	  * @param p_type_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.persondata.service.PsdataTypeService#getPsdataTypeBean(java.lang.String) 
	  */
	@Override
	public Map<String, String> getPsdataTypeBean(String p_type_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			PsdataTypeDao psdataTypeDao=(PsdataTypeDao)LoadSpringContext.getApplicationContext().getBean("psdataTypeDaoImp");
			viewMap = psdataTypeDao.getPsdataType(p_type_id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return viewMap;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 insertOrUpdatePsdataTypeBean
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.core.persondata.service.PsdataTypeService#insertOrUpdatePsdataTypeBean(com.chinacreator.xtbg.core.persondata.entity.PsdataTypeBean) 
	  */
	@Override
	public String insertOrUpdatePsdataTypeBean(PsdataTypeBean bean) {
		Connection conn = null;
		String beanId = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			PsdataTypeDao dao=(PsdataTypeDao)LoadSpringContext.getApplicationContext().getBean("psdataTypeDaoImp");
			//1:设置时间F_creator_time
			bean.setP_creater_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getP_creater_time()), "yyyy-MM-dd HH24:mi:ss"));
			if(StringUtil.nullOrBlank(bean.getP_type_id())){//insert
				bean.setP_type_id(StringUtil.getUUID());
				bean.setP_type_parentid(StringUtil.deNull(bean.getP_type_parentid()));
				beanId = bean.getP_type_id();
				
				((BaseDao)dao).insert(bean, conn);
			}else{//update
				beanId = bean.getP_type_id();
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
	*<b>Summary: </b>
	* deletePsdataTypeInfoByIds(根据IDs 删除资料分类信息)
	* @param ids
	* @return
	 */
	public String  deletePsdataTypeInfoByIds(String[] ids){
		Connection conn = null;
		String flag = "false";
		int count=0;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			PsdataTypeDao dao=(PsdataTypeDao)LoadSpringContext.getApplicationContext().getBean("psdataTypeDaoImp");
			for (String beanId : ids) {
				//判断该分类是否被引用
				count=dao.isPsdataBaseBean(conn, beanId);
				if(count>0){
					return "number";
				}
				//删除该节点以及子节点
				dao.deletePsdataTypeBeansById(conn, beanId);
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
	*<b>Summary: </b>
	* findTypeTopInfo(查询资料分类默认信息分类)
	* @param user_id
	* @return
	 */
	public Map<String, String> findTypeTopInfo(String user_id){
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			PsdataTypeDao psdataTypeDao=(PsdataTypeDao)LoadSpringContext.getApplicationContext().getBean("psdataTypeDaoImp");
			viewMap = psdataTypeDao.findTopType( user_id , conn);
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
	*<b>Summary: </b>
	* getOrder(得到传入相应表的排序号最大的下一个)
	* @param order
	* @param tablename
	* @param wheresql
	* @return
	 */
	public static int getOrder(String order,String tablename,String wheresql) {
		Connection conn = null;
		int count=1;
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql=new StringBuffer();
		try {
			conn = DbManager.getInstance().getConnection();
			sql.append(" select "+order+" table_order from "+tablename+" where " + wheresql +" order by "+order+" desc ");
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared(conn);
			if(pdb.size() > 0) {
				count=pdb.getInt(0, "table_order")+1;
			}
		} catch (SQLException e) {
			LOG.error("获得默认排序号失败" + e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return count;
	}
	
}
