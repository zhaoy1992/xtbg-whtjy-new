package com.chinacreator.xtbg.core.file.dao;



import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.file.entity.FileFilesDevolveBean;
import com.chinacreator.xtbg.core.file.entity.FileFilesDevolveDetailBean;

/**
 * 档案移交
 *<p>Title:FileFilesDevolveDao.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Sep 16, 2013
 */
public interface FileFilesDevolveDao {
	/**
	 * 
	 *<b>Summary: </b>
	 * queryFileFilesDevolveList(档案移交记录查询)
	 * @param model
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean queryFileFilesDevolveList(FileFilesDevolveBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	 *<b>Summary: </b>
	 * queryFileFilesDevolveDetailList(档案移交明细记录查询)
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean queryFileFilesDevolveDetailList(FileFilesDevolveDetailBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	 *<b>Summary: </b>
	 * getBeanById(get bean)
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> getBeanById(Connection conn,
			String beanId) throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * getDetailBeanListForExport(为导出查询)
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception
	 */
	public List<Map<String,String>> getDetailBeanListForExport(Connection conn,
			String beanId) throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * getQZH(获得全宗号)
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception
	 */
	public String getQZH(Connection conn,
			String beanId) throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * updateDetailBeanStateByBeanId(通过bean id 修改 明细state)
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception
	 */
	public String updateDetailBeanStateByBeanId(Connection conn,
			String beanId) throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * deleteDetailByBeanId(请用一句话描述这个方法的作用)
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception
	 */
	public String deleteDetailByBeanId(Connection conn,
			String beanId) throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * getWenShuList(提取某一移交信息中所有文书类档案)
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception
	 */
	public List<Map<String,String>> getWenShuList(Connection conn,String beanId) throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * getShiPinList(请用一句话描述这个方法的作用)
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception
	 */
	public List<Map<String,String>> getShiPinList(Connection conn,String beanId) throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * getGuangPanList(请用一句话描述这个方法的作用)
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception
	 */
	public List<Map<String,String>> getGuangPanList(Connection conn,String beanId) throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * getZhaoPianList(请用一句话描述这个方法的作用)
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception
	 */
	public List<Map<String,String>> getZhaoPianList(Connection conn,String beanId) throws Exception;
}
