package com.chinacreator.xtbg.core.archive.service;

import java.util.List;

import com.chinacreator.xtbg.core.archive.entity.GWCSUnitBean;
import com.chinacreator.xtbg.core.common.util.ResultCode;
import com.chinacreator.xtbg.core.common.util.ResultMap;


/**
 * 
 *<p>Title:SplitLogService.java</p>
 *<p>Description:公文传输的地址簿服务层接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Sep 16, 2013
 */
public interface GWCSUnitService {
	/**
	 * 
	*<b>Summary: 公文传输的地址簿列表</b>
	* splitFile()
	* @param filename
	* @return
	 */
	public ResultMap<ResultCode, List<GWCSUnitBean>> list(String parent_id);
	/**
	 * 
	*<b>Summary:根据机构名称串查询，读取配置文件 </b>
	* listByNames()
	* @param names
	* @return
	 */
	public ResultMap<ResultCode, List<GWCSUnitBean>> listByConfig(String type,String send_org_config);
}
