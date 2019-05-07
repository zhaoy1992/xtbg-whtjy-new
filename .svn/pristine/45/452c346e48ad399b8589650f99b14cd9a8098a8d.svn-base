package com.chinacreator.xtbg.core.file.service;

import java.util.Map;

import com.chinacreator.xtbg.core.file.entity.FileFondsnoBean;

/**
 * 
 *<p>Title:FileFondsnoServiceIfc.java</p>
 *<p>Description:档案全宗号服务接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-12
 */
public interface FileFondsnoServiceIfc {
	/**
	 * 
	*<b>Summary: </b>
	* getFileFondsnoBean(查询全宗号信息)
	* @param f_fonds_id
	* @return
	 */
	public Map<String, String> getFileFondsnoBean(String f_fonds_id);
	/**
	 * 
	*<b>Summary: </b>
	* getFileFondsnoBean(根据orgid查询全宗号信息)
	* @param f_fonds_orgid
	* @return
	 */
	public Map<String, String> getFileFondsnoBeanByOrgid(String f_fonds_orgid);
	/**
	 * 
	*<b>Summary: </b>
	* addFileFondsno(添加全宗号信息)
	* @param fileFondsnoBean
	* @return
	 */
	public boolean addFileFondsno(FileFondsnoBean fileFondsnoBean);
	/**
	 * 
	*<b>Summary: </b>
	* deleteFileFondsno(删除全宗号信息)
	* @param f_fonds_id
	* @return
	 */
	public boolean deleteFileFondsno(String f_fonds_id);
	/**
	 * s
	*<b>Summary: </b>
	* updateFileFondsno(修改全宗号信息)
	* @param fileFondsnoBean
	* @return
	 */
	public boolean updateFileFondsno(FileFondsnoBean fileFondsnoBean);
	/**
	 * 
	*<b>Summary: </b>
	* isNameorCode(判断全宗号和名称是否被引用排除该id下)
	* @param name
	* @param code
	* @return
	 */
	public String isNameorCode(String name, String code,String id);
}
