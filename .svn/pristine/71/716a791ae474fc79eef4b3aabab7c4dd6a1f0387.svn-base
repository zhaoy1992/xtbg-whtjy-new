package com.chinacreator.xtbg.pub.wordtemplate.service.impl;

import java.util.List;

import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.wordtemplate.dao.WordTemplateDao;
import com.chinacreator.xtbg.pub.wordtemplate.dao.imploracle.WordTemplateDaoImpl;
import com.chinacreator.xtbg.pub.wordtemplate.entity.RuleItemBean;
import com.chinacreator.xtbg.pub.wordtemplate.entity.SelectBean;
import com.chinacreator.xtbg.pub.wordtemplate.entity.WordTemplateBean;
import com.chinacreator.xtbg.pub.wordtemplate.entity.WordVarBean;
import com.chinacreator.xtbg.pub.wordtemplate.service.WordTemplateServiceIfc;
import com.enterprisedt.util.debug.Logger;

/**
 *<p>Title:</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2011</p>
 *<p>Company:湖南科创</p>
 *@author yi.yang
 *@version 1.0
 *@date 2011-9-16
 */

public class WordTemplateServiceImpl implements WordTemplateServiceIfc {
	private static final Logger LOG = Logger.getLogger(WordTemplateServiceImpl.class);
	/**
	 * @Description:查询模板信息
	 * @param template_id 模板ID
	 * @return
	 * @throws Exception
	 */
	public WordTemplateBean getWordTemplateInfoByMbId(String template_id)throws Exception {
		
		WordTemplateDao wordTemplateDao = (WordTemplateDao)DaoImplClassUtil.getDaoImplClass("wordTemplateDaoImpl");
		WordTemplateBean wordTemplateBean = wordTemplateDao.getWordTemplateInfoByMbId(template_id);
		return wordTemplateBean;
	}
	
	/**
	 * @Description:保存/修改模板信息
	 * @param wordTemplateBean 模板基本信息Bean
	 * @throws Exception
	 */
	public String saveWordtemplate(WordTemplateBean wordTemplateBean)
			throws Exception {
		
		WordTemplateDao wordTemplateDao = (WordTemplateDao)DaoImplClassUtil.getDaoImplClass("wordTemplateDaoImpl");
		String template_id = wordTemplateDao.saveWordtemplate(wordTemplateBean);
		return template_id;
		
	}
	

	/**
	 * @Description:保存/修改变量
	 * @param map
	 * @throws Exception
	 */
	public void saveVariable(WordVarBean wordVarBean)throws Exception {
		WordTemplateDao wordTemplateDao = (WordTemplateDao)DaoImplClassUtil.getDaoImplClass("wordTemplateDaoImpl");
		wordTemplateDao.saveVariable(wordVarBean);
		
	}
	
	/**
	 * @Description:是否存在被引用记录
	 * @param ids
	 * @return
	 */
	public boolean isUsedVariable(String ids,String template_id) throws Exception {
		WordTemplateDao wordTemplateDao = (WordTemplateDao)DaoImplClassUtil.getDaoImplClass("wordTemplateDaoImpl");
		return wordTemplateDao.isUsedVariable(ids, template_id);
		
	}

	/**
	 * @Description:删除变量
	 * @param ids
	 */
	public void deleteVariable(String ids) throws Exception {
		WordTemplateDao wordTemplateDao = (WordTemplateDao)DaoImplClassUtil.getDaoImplClass("wordTemplateDaoImpl");
		wordTemplateDao.deleteVariable(ids);
	}
	
	/**
	 * @Description:保存规则项
	 * @param map
	 * @throws Exception
	 */
	public String saveWordParam(RuleItemBean ruleItemBean) throws Exception {
		String kjId = "";
		String defaultvalue = "";
		String kjType = ruleItemBean.getControl_type();
		
		WordTemplateDao wordTemplateDao = (WordTemplateDao)DaoImplClassUtil.getDaoImplClass("wordTemplateDaoImpl");
		if ("textInput".equals(kjType)){
			kjId = wordTemplateDao.saveWordParamTextInput(ruleItemBean);
			defaultvalue = wordTemplateDao.getRuleItemDefaultValue(ruleItemBean.getRuleitem_value());
		}
		return kjId+"#"+defaultvalue;
	}


	/**
	 * @Description:变量下拉列表
	 * @param mbId
	 * @return
	 * @throws Exception
	 */
	public List<SelectBean> getVariableSelect(String mbId) throws Exception {
		try{
			WordTemplateDao wordTemplateDao = new WordTemplateDaoImpl();
			return wordTemplateDao.getVariableSelect(mbId);
		}catch(Exception e){
			LOG.error(e.toString());
			throw new Exception(e.toString());
		}
	}

	@Override
	public void deleteWordParam(String ids) throws Exception {
		WordTemplateDao wordTemplateDao = (WordTemplateDao)DaoImplClassUtil.getDaoImplClass("wordTemplateDaoImpl");
		wordTemplateDao.deleteWordParam(ids);
	}
	
	/**
	 * 删除模版信息
	 * @param ids
	 * @throws Exception
	 */
	@Override
	public boolean deleteWordTemplate(String ids) throws Exception {
		try {
			WordTemplateDao wordTemplateDao = (WordTemplateDao)DaoImplClassUtil.getDaoImplClass("wordTemplateDaoImpl");
			wordTemplateDao.deleteWordTemplate(ids);
		} catch (Exception e) {
			LOG.error(e.toString());
			return false;
		}
		return true;
	}

	
}
