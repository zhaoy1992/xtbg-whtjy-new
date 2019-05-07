package com.chinacreator.xtbg.core.archive.service;

import com.chinacreator.xtbg.core.archive.entity.BudgetDetailBean;
import com.chinacreator.xtbg.core.common.util.ResultCode;
import com.chinacreator.xtbg.core.common.util.ResultMap;

/**
 * 
 * <p>
 * Title:BudgetAttachService.java
 * </p>
 * <p>
 * Description:指标文拆分-拆分详细信息服务层接口
 * </p>
 * <p>
 * Copyright:Copyright (c) 2013
 * </p>
 * <p>
 * Company:湖南科创
 * </p>
 * 
 * @author 陈建华
 * @version 1.0 Nov 12, 2013
 */
public interface BudgetDetailService {
	/**
	 * 
	 * <b>Summary: 保存方法，先根据拆分主表id与拆分单位id查询是否有数据，决定是更新还是插入操作</b> save()
	 * 
	 * @return
	 */
	public ResultMap<ResultCode, BudgetDetailBean> save(BudgetDetailBean bean);
	/**
	 * 
	 * <b>Summary: 保存方法，先根据拆分主表id与拆分单位id查询是否有数据，决定是更新还是插入操作</b> save()
	 * 
	 * @return
	 */
	public ResultMap<ResultCode, BudgetDetailBean> save(String detail_id,
			String budget_file_id, String unit_id, String shown_name,
			String file_path, String file_size, String remark);
	
	/**
	 * 
	*<b>Summary:批量删除指标文记录 </b>
	* deleteById()
	* @param ids
	* @return
	 */
	public ResultMap<ResultCode, BudgetDetailBean> deleteByIds(String ids);
	
	/**
	 * 
	*<b>Summary:删除指标文记录 </b>
	* deleteById()
	* @param ids
	* @return
	 */
	public ResultMap<ResultCode, BudgetDetailBean> deleteById(String id);
}
