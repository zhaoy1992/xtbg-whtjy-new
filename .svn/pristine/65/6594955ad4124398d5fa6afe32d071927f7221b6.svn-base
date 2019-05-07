package com.chinacreator.xtbg.core.common.iweboffice.service;

import java.util.List;
import java.util.Map;


import com.chinacreator.xtbg.core.common.iweboffice.bean.RuleItemBean;
import com.chinacreator.xtbg.core.common.iweboffice.bean.SelectBean;
import com.chinacreator.xtbg.core.common.iweboffice.bean.ThWordTemplateBean;
import com.chinacreator.xtbg.core.common.iweboffice.bean.WordRuleItemBean;
import com.chinacreator.xtbg.core.common.iweboffice.bean.WordTemplateBean;
import com.chinacreator.xtbg.core.common.iweboffice.bean.WordVarBean;

/**
 * 
 *<p>Title:WordTemplateServiceIfc.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-7-29
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
	 * @Description:查询套红模板信息
	 * @param template_id_th 模板ID
	 * @return
	 * @throws Exception
	 */
	public ThWordTemplateBean getThWordTemplateInfoByMbId(String template_id_th)throws Exception;
	
	
	/**
	 * @Description:保存/修改模板信息
	 * @param wordTemplateBean 模板基本信息Bean
	 * @throws Exception
	 */
	public String saveWordtemplate(WordTemplateBean wordTemplateBean) throws Exception;
	/**
	 * @Description:保存/修改套红模板信息
	 * @param wordTemplateBean 模板基本信息Bean
	 * @throws Exception
	 */
	public String saveThWordtemplate(ThWordTemplateBean thWordTemplateBean) throws Exception;
	
	/**
	 * @Description:删除模板信息
	 * @param ids
	 * @return true or false
	 * @throws Exception
	 */
	public boolean deleteWordTemplate(String ids) throws Exception;
	/**
	 * @Description:删除套红模板信息
	 * @param ids
	 * @return true or false
	 * @throws Exception
	 */
	public boolean deleteThWordTemplate(String ids) throws Exception;
	
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
	public boolean deleteWordParam(String ids);
	
	/**
	 * @Description:变量下拉列表
	 * @param mbId
	 * @return
	 * @throws Exception
	 */
	public List<SelectBean> getVariableSelect(String mbId)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getRuleItemBean(查询textinput值)
	* @param ruleitem_id
	* @return
	 */
	public Map<String, String> getRuleItemBean(String ruleitem_id) ;
	
	/**
	 * 
	*<b>Summary: </b>
	* getRuleItemBeanList(根据模板ID获取标签列表)
	* @param template_id
	* @return
	 */
	public List<WordRuleItemBean>  getRuleItemBeanList(String template_id);
	
	/**
	 * @Description:复制模板信息
	 * @param ids
	 * @return true or false
	 * @throws Exception
	 */
	public String copyWordTemplate(Map<Integer,String> procMap) throws Exception;
	/**
	 * @Description:复制模板textinput信息
	 * @param ids
	 * @return true or false
	 * @throws Exception
	 */
	public String copyWordTextinput(Map<Integer,String> procMap) throws Exception;

}

