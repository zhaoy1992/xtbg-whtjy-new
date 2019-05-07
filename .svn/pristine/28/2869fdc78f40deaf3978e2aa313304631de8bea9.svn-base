package com.chinacreator.xtbg.core.archive.service;

import java.util.List;

import com.chinacreator.xtbg.core.archive.entity.BudgetDetailBean;
import com.chinacreator.xtbg.core.archive.entity.BudgetFileBean;
import com.chinacreator.xtbg.core.common.util.ResultCode;
import com.chinacreator.xtbg.core.common.util.ResultMap;

/**
 * 
 * <p>
 * Title:SplitLogService.java
 * </p>
 * <p>
 * Description:指标文拆分服务层接口
 * </p>
 * <p>
 * Copyright:Copyright (c) 2013
 * </p>
 * <p>
 * Company:湖南科创
 * </p>
 * 
 * @author 陈建华
 * @version 1.0 Sep 16, 2013
 */
public interface BudgetFileService {
	/**
	 * 
	 * <b>Summary: 保存</b> insert()
	 * 
	 * @param bean
	 * @param con
	 * @throws Exception
	 */
	public ResultMap<ResultCode, BudgetFileBean> save(BudgetFileBean bean);

	/**
	 * 
	 * <b>Summary: 保存</b> save()
	 * 
	 * @param bean
	 * @return
	 */
	public ResultMap<ResultCode, BudgetFileBean> save(String id,String file_code,
			String bus_id, String file_name, String amount, String branch_id,
			String user_id, String op_date, String status,String annual);

	/**
	 * <b>Summary: 文件拆分</b> splitFile()
	 * @param filename
	 * @return
	 */
	public String splitFile(String relative_path, String fileName,String file_code,
			int header_row, String user_id, String dept_id, String bus_id,String annual,String template_type);

	/**
	 * 
	*<b>Summary:查询所拆分的文件中与公文传输关联的机构 </b>
	* getGwcsOrg()
	* @param buss_id
	* @return
	 */
	public ResultMap<ResultCode, List<BudgetDetailBean>> getGwcsOrg(String bus_id);
}
