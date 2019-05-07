package com.chinacreator.xtbg.core.file.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspWriter;

import com.chinacreator.xtbg.core.file.entity.FileFilesDevolveBean;
import com.chinacreator.xtbg.core.file.entity.FileFilesDevolveDetailBean;

/**
 * 档案移交
 *<p>Title:FileFilesDevolveService.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Sep 16, 2013
 */
public interface FileFilesDevolveService {
	/**
	 * 添加 or 修改(档案移交 暂存 or 移交)
	 *<b>Summary: </b>
	 * add(请用一句话描述这个方法的作用)
	 * @param bean
	 * @param list
	 * @return
	 */
	public String addOrUpdate(FileFilesDevolveBean bean);
	
	/**
	 * 添加明细
	 *<b>Summary: </b>
	 * addDetailBean(添加明细)
	 * @param bean
	 * @return
	 */
	public boolean addDetailBean(FileFilesDevolveDetailBean bean);
	
	/**
	 * 删除明细
	 *<b>Summary: </b>
	 * delDetailBeanByIds(删除明细)
	 * @param bean
	 * @return
	 */
	public boolean delDetailBeanByIds(String ids);
	/**
	 * 删除 Bean
	 *<b>Summary: </b>
	 * delBeanByIds(删除 Bean)
	 * @param id
	 * @return
	 */
	public boolean delBeanByIds(String id);
	/**
	 * 
	 *<b>Summary: </b>
	 * addDetailBeanByIds(请用一句话描述这个方法的作用)
	 * @param ids
	 * @param beanId
	 * @return
	 */
	public boolean addDetailBeanByIds(String ids,String beanId);
	/**
	 * 为导出查询明细
	 *<b>Summary: </b>
	 * getDetailBeanListForExport(请用一句话描述这个方法的作用)
	 * @param id
	 * @return
	 */
	public List<Map<String,String>> getDetailBeanListForExport(String id);
	/**
	 * 
	 *<b>Summary: </b>
	 * getBeanById(获得bean)
	 * @param id
	 * @return
	 */
	public Map<String,String> getBeanById(String id);
	/**
	 * 
	 *<b>Summary: </b>
	 * getQZH(获得机构全宗号)
	 * @param orgId
	 * @return
	 */
	public String getQZH(String orgId);
	/**
	 * 为移交生成附件压缩包
	 *<b>Summary: </b>
	 * createZIPForDevolve(为移交生成附件压缩包)
	 * @param out
	 * @param busi_id
	 */
	public Map<String,String> createZIPForDevolve(JspWriter out,HttpServletRequest request,String busi_id,String f_type);
}
