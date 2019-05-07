package com.chinacreator.xtbg.core.dict.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 * 
 *<p>Title:DictDao.java</p>
 *<p>Description:数据字典接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-23
 */
public interface DictDao {

	/**
	 * 
	*<b>Summary: </b>
	* selDictDataList(查询字典数据列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selDictDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getDictDataBean(根据Id查询字典数据的信息)
	* @param dictdata_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getDictDataBean(String dictdata_id, Connection conn) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getDictTypeBean(根据id查询字典类型的信息)
	* @param dict_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getDictTypeBean(String dict_id, Connection conn) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getDictDataBydvalue(根据字典数据编号和dict_id查询字典数据信息)
	* @param dictdata_value
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getDictDataBydvalue(String dictdata_value, Connection conn,String dict_id) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getDictTypeBydcode(根据字典编号查询字典类型信息)
	* @param dict_code
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getDictTypeBydcode(String dict_code, Connection conn) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* isSonDictType(判断是否有子类字典类型)
	* @param dict_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Boolean isSonDictType(String dict_id, Connection conn) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* isDictData(判断该字典类型下是否有字典数据)
	* @param dict_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Boolean isDictData(String dict_id, Connection conn) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* isSonData(判断是否有子类字典数据)
	* @param dictdata_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Boolean isSonData(String dictdata_id, Connection conn) throws Exception;
}
