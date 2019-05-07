package com.chinacreator.xtbg.pub.wordtemplate.service;

import java.util.List;

import com.chinacreator.xtbg.pub.wordtemplate.entity.RuleItemBean;
import com.chinacreator.xtbg.pub.wordtemplate.entity.SelectBean;
import com.chinacreator.xtbg.pub.wordtemplate.entity.WordTemplateBean;
import com.chinacreator.xtbg.pub.wordtemplate.entity.WordVarBean;

/**
 *<p>Title:</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2011</p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-5-25
 */

public interface WordTemplateServiceIfc {

	/**
	 * @Description:查询模板信息
	 * @param template_id 模板ID
	 * @return
	 * @throws Exception
	 */
	public WordTemplateBean getWordTemplateInfoByMbId(String template_id)throws Exception;
	
	
	/**
	 * @Description:保存/修改模板信息
	 * @param wordTemplateBean 模板基本信息Bean
	 * @throws Exception
	 */
	public String saveWordtemplate(WordTemplateBean wordTemplateBean) throws Exception;
	
	/**
	 * @Description:删除模板信息
	 * @param ids
	 * @return true or false
	 * @throws Exception
	 */
	public boolean deleteWordTemplate(String ids) throws Exception;
	
	/**
	 * @Description:保存/修改变量
	 * @param map
	 * @throws Exception
	 */
	public void saveVariable(WordVarBean wordVarBean)throws Exception;
	
	/**
	 * @Description:是否存在被引用记录
	 * @param ids
	 * @return
	 */
	public boolean isUsedVariable(String ids,String template_id) throws Exception;
	
	/**
	 * @Description:删除变量
	 * @param ids
	 */
	public void deleteVariable(String ids) throws Exception;
	
	/**
	 * @Description:保存规则项
	 * @param map
	 * @throws Exception
	 */
	public String saveWordParam(RuleItemBean ruleItemBean)throws Exception;
	
	/**
	 * @Description:删除规则项
	 * @param map
	 * @throws Exception
	 */
	public void deleteWordParam(String ids)throws Exception;
	
	/**
	 * @Description:变量下拉列表
	 * @param mbId
	 * @return
	 * @throws Exception
	 */
	public List<SelectBean> getVariableSelect(String mbId)throws Exception;
	

	
}

