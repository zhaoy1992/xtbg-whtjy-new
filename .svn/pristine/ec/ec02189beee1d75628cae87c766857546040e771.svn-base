package com.chinacreator.xtbg.core.pubconfig.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.pubconfig.dao.MdColumnsDao;
import com.chinacreator.xtbg.core.pubconfig.dao.MdTableDao;
import com.chinacreator.xtbg.core.pubconfig.dao.impl.MdColumnsDaoImpl;
import com.chinacreator.xtbg.core.pubconfig.dao.impl.MdTableDaoImpl;
import com.chinacreator.xtbg.core.pubconfig.entity.MdColumnsBean;
import com.chinacreator.xtbg.core.pubconfig.entity.MdTableBean;
import com.chinacreator.xtbg.core.pubconfig.service.MdTableAndColumnsService;
/**
 * 
 *<p>Title:MdTableAndColumnsServiceIml.java</p>
 *<p>Description:数据元素表和表元素服务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-11-27
 */
public class MdTableAndColumnsServiceIml implements MdTableAndColumnsService {

	private static final Log LOG=LogFactory.getLog(MdTableAndColumnsServiceIml.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getOneMdTable
	  * @param table_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.pubconfig.service.MdTableAndColumnsService#getOneMdTable(java.lang.String)
	 */
	public Map<String, String> getOneMdTable(String table_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			MdTableDao tabledao=new MdTableDaoImpl();
			viewMap = tabledao.getOneMdTable(table_id, conn);
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
	  *     复写方法 getMdColumns
	  * @param table_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.pubconfig.service.MdTableAndColumnsService#getMdColumns(java.lang.String)
	 */
	public List<Map<String, String>> getMdColumns(String table_id) {
		Connection conn = null;
		List<Map<String, String>> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new ArrayList<Map<String,String>>();
			MdColumnsDao cdao=new MdColumnsDaoImpl();
			viewMap = cdao.getMdColumns(table_id);
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
	  *     复写方法 updateMdColumnsAndTable
	  * @param mdtablejson
	  * @param mdcolumnlistjson
	  * @return 
	  * @see com.chinacreator.xtbg.core.pubconfig.service.MdTableAndColumnsService#updateMdColumnsAndTable(java.lang.String, java.lang.String)
	 */
	public boolean updateMdColumnsAndTable(String mdtablejson,
			String mdcolumnlistjson) {
		Connection conn = null ;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			String json1 = Escape.unescape(DataControlUtil.replaceStr(mdtablejson));
			MdTableBean mdTableBean = (MdTableBean) JSONObject.parseObject(json1, MdTableBean.class);
			String json2 = Escape.unescape(DataControlUtil.replaceStr(mdcolumnlistjson));
			List<MdColumnsBean> list = (List<MdColumnsBean>) JSONObject.parseArray(json2, MdColumnsBean.class);
			
			MdTableDao tdao=new MdTableDaoImpl();
			((BaseDao)tdao).update(mdTableBean, conn);
			
			for(MdColumnsBean mdColumnBean : list){
				((BaseDao)tdao).update(mdColumnBean, conn);
			}
			conn.commit();
		} catch (Exception e) {
			LOG.info("新建数据元字段表或新建业务表时出现异常"+e.getMessage(), e);
			DbManager.rollBackNoThrow(conn);
			return false;
		}finally{
			DbManager.closeConnection(conn);
		}
		return true;
	}

}
