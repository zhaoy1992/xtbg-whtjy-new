package com.chinacreator.xtbg.core.wordnumdef.service.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.wordnumdef.dao.WordNumDefDao;
import com.chinacreator.xtbg.core.wordnumdef.entity.WordNumberDefBean;
import com.chinacreator.xtbg.core.wordnumdef.service.WordNumDefService;

public class WordNumDefServiceImpl implements WordNumDefService {

	private static final Log LOG=LogFactory.getLog(WordNumDefServiceImpl.class);
	/**
	 * 
	  * <b>Summary:删除文号 </b>
	  *     复写方法 deleteWordNum
	  * @param id
	  * @return 
	  * @see com.chinacreator.xtbg.core.wordnumdef.service.WordNumDefService#deleteWordNum(java.lang.String)
	 */
	public Boolean deleteWordNum(WordNumberDefBean bean) {
		Connection conn=null;
		Boolean flag=false;
		try {
			conn=DbManager.getInstance().getTransactionConnection();
			WordNumDefDao dao=(WordNumDefDao)LoadSpringContext.getApplicationContext().getBean("wordNumDefDaoImpl");
			flag=dao.deleteWordNum(bean.getNumber_type(), bean.getNumber_year(), conn);
			
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
	  * <b>Summary: 添加文号</b>
	  *     复写方法 addWordNum
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.core.wordnumdef.service.WordNumDefService#addWordNum(com.chinacreator.xtbg.core.wordnumdef.entity.WordNumberDefBean)
	 */
	public boolean addorupdateWordNum(WordNumberDefBean bean,String oldtype,String oldyear) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			WordNumDefDao dao=(WordNumDefDao)LoadSpringContext.getApplicationContext().getBean("wordNumDefDaoImpl");
			if(bean.getNumber_year().equals(oldyear)){//年份相等就是修改
				//先删除再添加
				dao.deleteWordNum(oldtype,oldyear, conn);
				
				((BaseDao)dao).insert(bean, conn);
			}else{//添加
				//先删除再添加
				dao.deleteWordNum(bean.getNumber_type(),bean.getNumber_year(), conn);
				
				((BaseDao)dao).insert(bean, conn);
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
	  * <b>Summary:根据id得到文号信息 </b>
	  *     复写方法 getWordNumBean
	  * @param type year
	  * @return 
	  * @see com.chinacreator.xtbg.core.wordnumdef.service.WordNumDefService#getWordNumBean(java.lang.String)
	 */
	public Map<String, String> getWordNumBean(String type ,String year) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			WordNumDefDao dao=(WordNumDefDao)LoadSpringContext.getApplicationContext().getBean("wordNumDefDaoImpl");
			viewMap = dao.getWordNumBean(type,year, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
			
		}
		return viewMap;
	}

}
