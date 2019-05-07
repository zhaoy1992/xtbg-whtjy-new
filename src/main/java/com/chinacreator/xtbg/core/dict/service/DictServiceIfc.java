package com.chinacreator.xtbg.core.dict.service;

import java.util.Map;

import com.chinacreator.xtbg.core.dict.entity.DictDataBean;
import com.chinacreator.xtbg.core.dict.entity.DictTypeBean;

/**
 * 
 *<p>Title:DictServiceIfc.java</p>
 *<p>Description:数据字典服务接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-22
 */
public interface DictServiceIfc {
	/**
	 * 
	*<b>Summary: </b>
	* getDictDataBean(根据Id查询字典数据信息)
	* @param dictdata_id
	* @return
	 */
	public Map<String, String> getDictDataBean(String dictdata_id);
	/**
	 * 
	*<b>Summary: </b>
	* deleteDictData(根据id删除字典数据信息)
	* @param dictdata_id
	* @return
	 */
	public String deleteDictData(String dictdata_id);
	/**
	 * 
	*<b>Summary: </b>
	* addDictData(添加字典数据信息)
	* @param dictDataBean
	* @return
	 */
	public boolean addDictData(DictDataBean dictDataBean);
	/**
	 * 
	*<b>Summary: </b>
	* updateDictData(更新字典数据信息)
	* @param dictDataBean
	* @return
	 */
	public boolean updateDictData(DictDataBean dictDataBean);
	/**
	 * 
	*<b>Summary: </b>
	* getDictTypeBean(根据id查询字典类型信息)
	* @param dict_id
	* @return
	 */
	public Map<String, String> getDictTypeBean(String dict_id);
	/**
	 * 
	*<b>Summary: </b>
	* deleteDictType(根据id删除字典类型)
	* @param dict_id
	* @return
	 */
	public String deleteDictType(String dict_id);
	/**
	 * 
	*<b>Summary: </b>
	* addDictType(添加字典类型)
	* @param dictTypeBean
	* @return
	 */
	public boolean addDictType(DictTypeBean dictTypeBean);
	/**
	 * 
	*<b>Summary: </b>
	* updateDictType(修改字典类型)
	* @param dictTypeBean
	* @return
	 */
	public boolean updateDictType(DictTypeBean dictTypeBean);
	/**
	 * 
	*<b>Summary: </b>
	* getDictDataBydvalue(根据字典数据编号和dict_id查询字典数据信息)
	* @param dictdata_value
	* @return
	 */
	public Map<String, String> getDictDataBydvalue(String dictdata_value,String dict_id);
	/**
	 * 
	*<b>Summary: </b>
	* getDictTypeBydcode(根据字典编号查询字典类型信息)
	* @param dict_code
	* @return
	 */
	public Map<String, String> getDictTypeBydcode(String dict_code);
}
