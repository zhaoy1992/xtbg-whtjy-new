package com.chinacreator.xtbg.core.wordnumdef.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.core.archive.entity.OaWordNumberBean;
import com.chinacreator.xtbg.core.wordnumdef.entity.SerialNumberBean;

/**
 * 
 *<p>Title:WordNumDefDao.java</p>
 *<p>Description:文号维护接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-10-17
 */
public interface WordNumDefDao {

	/**
	 * 
	*<b>Summary: </b>
	* getWordNumBean(根据id得到文号信息)
	* @param id
	* @param conn
	* @return
	 */
	public Map<String, String> getWordNumBean(String type,String year,Connection conn) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* deleteWordNum(删除文号信息)
	* @param type
	* @param year
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean deleteWordNum(String type,String year,Connection conn)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* insertSerialNumber(添加流水号)
	* @param bean
	* @throws Exception
	 */
	public void insertSerialNumber(SerialNumberBean bean,Connection conn)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* updateSerialNumber(修改流水号)
	* @param bean
	* @throws Exception
	 */
	public void updateSerialNumber(SerialNumberBean bean,Connection conn)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* findSerialcode(查询出相应的流水号)
	* @param scode
	* @return
	* @throws Exception
	 */
	public SerialNumberBean findSerialcode(String scode,Connection conn)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* isExistNum(流水号是否存在)
	* @param serialNumberBean
	* @return
	* @throws Exception
	 */
	public boolean isExistNum(SerialNumberBean serialNumberBean,Connection conn)throws Exception;
	
	/**
	*<b>Summary: </b>
	* deleteWordInfoByIds(删除文号)
	* @param bus_id
	* @param number_code
	* @param bean
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean deleteWordInfoByIds(String bus_id,String number_code,OaWordNumberBean bean,Connection conn)throws Exception;
}
