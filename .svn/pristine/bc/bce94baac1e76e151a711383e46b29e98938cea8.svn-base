package com.chinacreator.xtbg.core.archive.service;

import java.util.List;

import com.chinacreator.xtbg.core.archive.entity.SplitLogBean;
import com.chinacreator.xtbg.core.common.util.ResultCode;
import com.chinacreator.xtbg.core.common.util.ResultMap;

/**
 * 
 *<p>Title:SplitLogService.java</p>
 *<p>Description:指标文拆分服务层接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Sep 16, 2013
 */
public interface SplitLogService {
	/**
	 * 
	*<b>Summary: 保存</b>
	* insert()
	* @param bean
	* @param con
	* @throws Exception
	 */
	public ResultMap<ResultCode, SplitLogBean> insert(SplitLogBean bean);
	
	/**
	 * 
	*<b>Summary: 文件拆分</b>
	* splitFile()
	* @param filename
	* @return
	 */
	public String splitFile(String relative_path,String fileName,int header_row,String user_id,String buss_id);
	
	/**
	 * 
	*<b>Summary:查询所拆分的文件中与公文传输关联的机构</b>
	* getGwcsUnit()
	* @param buss_id
	* @return
	 */
	public ResultMap<ResultCode, List<SplitLogBean>> getGwcsOrg (String buss_id);
}
