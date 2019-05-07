package com.chinacreator.xtbg.core.archive.service;

import java.util.List;

import com.chinacreator.xtbg.core.archive.entity.SplitUnitBean;
import com.chinacreator.xtbg.core.common.util.ResultCode;
import com.chinacreator.xtbg.core.common.util.ResultMap;

/**
 * 
 *<p>Title:SplitUnitService.java</p>
 *<p>Description:拆分单位服务层实现</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Sep 16, 2013
 */
public interface SplitUnitService {
	/**
	 * 
	*<b>Summary:保存 </b>
	* insert()
	* @param bean
	* @return
	 */
	public ResultMap<ResultCode, SplitUnitBean> insert(SplitUnitBean bean );
	
	/**
	 * 
	*<b>Summary: 根据Id得到数据</b>
	* getById()
	* @param id
	* @return
	 */
	public ResultMap<ResultCode, SplitUnitBean> getById(String id);
	
	/**
	 * 
	*<b>Summary: 更新</b>
	* update()
	* @param bean
	* @return
	 */
	public ResultMap<ResultCode, SplitUnitBean> update(SplitUnitBean bean);
	
	/**
	 * 
	*<b>Summary: 无分页列表</b>
	* list()
	* @param bean
	* @return
	 */
	public ResultMap<ResultCode, List<SplitUnitBean>> list(SplitUnitBean bean);
	
	/**
	 * 
	*<b>Summary: 根据ID删除数据</b>
	* deleteById()
	* @param unit_ids
	* @return
	 */
	public ResultMap<ResultCode, SplitUnitBean> deleteById(String unit_ids);
	
	/**
	 * 
	*<b>Summary: 根据单位名称得到数据</b>
	* getByUnitName()
	* @param unit_ids
	* @return
	 */
	public ResultMap<ResultCode, SplitUnitBean> getByUnitName(String unit_name);
	/**
	 * 
	 *<b>Summary: 根据公文传输机构id得到数据</b>
	 * getByUnitName()
	 * @param unit_ids
	 * @return
	 */
	public ResultMap<ResultCode, SplitUnitBean> getUnitByGwcsOrgId(SplitUnitBean bean);
}
