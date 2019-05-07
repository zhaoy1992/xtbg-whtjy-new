package com.chinacreator.xtbg.core.file.dao;

import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.core.file.entity.FileReadRecodeInfoBean;
import java.sql.Connection;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * 档案查看记录dao
 *<p>Title:FileReadRecodeInfoDao.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Oct 22, 2013
 */
public interface FileReadRecodeInfoDao {
	/**
	 * 通过信息检查是否存在,如果存在返回bean,如果不存在返回null
	 *<b>Summary: </b>
	 * getRecodeByBeanMess(请用一句话描述这个方法的作用)
	 * @param bean
	 * @return
	 * @throws Exception
	 */
	public FileReadRecodeInfoBean  getRecodeByBeanMess(Connection conn,FileReadRecodeInfoBean bean) throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * checkAttachNumOfFileDoc(检查附件数量)
	 * @param f_doc_id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public int checkAttachNumOfFileDoc(String f_doc_id,Connection conn) throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * getOldRecode(获得当天老数据)
	 * @param request
	 * @param ac
	 * @param con
	 * @return
	 * @throws Exception
	 */
	public Map<String,String> getOldRecode(HttpServletRequest request,AccessControl ac,
			Connection con) throws Exception;
}
