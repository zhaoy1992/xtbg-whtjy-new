package com.chinacreator.xtbg.core.archive.service;

import com.chinacreator.xtbg.core.archive.entity.BudgetAttachBean;
import com.chinacreator.xtbg.core.common.util.ResultCode;
import com.chinacreator.xtbg.core.common.util.ResultMap;

/**
 * 
 *<p>Title:BudgetAttachService.java</p>
 *<p>Description:指标文拆分-附件表服务层接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Nov 12, 2013
 */
public interface BudgetAttachService {
	/**
	 * 
	*<b>Summary: 保存方法，先根据拆分主表id与文件显示名查询是否有数据，决定是更新还是插入操作</b>
	* save()
	* @return
	 */
	public ResultMap<ResultCode, BudgetAttachBean> save(String id,String file_name,String shown_name,String file_path,String file_size);
}
