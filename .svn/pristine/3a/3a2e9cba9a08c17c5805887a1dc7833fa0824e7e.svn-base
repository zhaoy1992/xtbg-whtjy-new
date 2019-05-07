package com.chinacreator.xtbg.core.kbm.service;

import java.util.Map;

import com.chinacreator.xtbg.core.kbm.entity.KbmDocOperateLogBean;

/**
 * 
 *<p>Title:KbmDocOperateLogService.java</p>
 *<p>Description:文档用户操作情况记录服务接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-28
 */
public interface KbmDocOperateLogService {

	/**
	 * 
	*<b>Summary: </b>
	* selectKbmDocBbs(根据文档id和用户查询操作记录)
	* @param id
	* @param userid
	* @return
	 */
	public Map<String, String> getKbmDocOperateLog(String id,String userid);
	/**
	 * 
	*<b>Summary: </b>
	* deleteKbmDocOperateLog(根据文档ids删除相应的文档用户表信息)
	* @param k_doc_ids
	* @return
	 */
	public Boolean deleteKbmDocOperateLog(String k_doc_ids);
	/**
	 * 
	*<b>Summary: </b>
	* addorupdataKbmDocOperateLog(添加或修改文档信息表)
	* @param bean
	* @return
	 */
	public Boolean addorupdataKbmDocOperateLog(KbmDocOperateLogBean bean);
}
