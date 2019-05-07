package com.chinacreator.xtbg.core.common.iweboffice.service.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.iweboffice.bean.RuleItemBean;
import com.chinacreator.xtbg.core.common.iweboffice.bean.SelectBean;
import com.chinacreator.xtbg.core.common.iweboffice.bean.ThWordTemplateBean;
import com.chinacreator.xtbg.core.common.iweboffice.bean.WordRuleItemBean;
import com.chinacreator.xtbg.core.common.iweboffice.bean.WordTemplateBean;
import com.chinacreator.xtbg.core.common.iweboffice.bean.WordVarBean;
import com.chinacreator.xtbg.core.common.iweboffice.dao.WordTemplateDao;
import com.chinacreator.xtbg.core.common.iweboffice.service.WordTemplateServiceIfc;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.form.entity.OaMdColumnsBean;
import com.chinacreator.xtbg.core.form.service.Formservice;
import com.chinacreator.xtbg.core.form.service.impl.FormserviceImpl;
import com.enterprisedt.util.debug.Logger;

/**
 * 
 *<p>Title:WordTemplateServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-7-29
 */
public class WordTemplateServiceImpl implements WordTemplateServiceIfc {
	private static final Logger LOG = Logger.getLogger(WordTemplateServiceImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getWordTemplateInfoByMbId
	  * @param template_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.iweboffice.service.WordTemplateServiceIfc#getWordTemplateInfoByMbId(java.lang.String)
	 */
	public WordTemplateBean getWordTemplateInfoByMbId(String template_id)throws Exception {
		
		WordTemplateDao wordTemplateDao = (WordTemplateDao)LoadSpringContext.getApplicationContext().getBean("wordTemplateDaoImpl");
		WordTemplateBean wordTemplateBean = wordTemplateDao.getWordTemplateInfoByMbId(template_id);
		return wordTemplateBean;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getThWordTemplateInfoByMbId
	  * @param template_id_th
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.iweboffice.service.WordTemplateServiceIfc#getThWordTemplateInfoByMbId(java.lang.String)
	 */
	public ThWordTemplateBean getThWordTemplateInfoByMbId(String template_id_th)
			throws Exception {

		WordTemplateDao wordTemplateDao = (WordTemplateDao) LoadSpringContext
				.getApplicationContext().getBean("wordTemplateDaoImpl");
		ThWordTemplateBean wordTemplateBean = wordTemplateDao.getThWordTemplateInfoByMbId(template_id_th);
		return wordTemplateBean;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveWordtemplate
	  * @param wordTemplateBean
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.iweboffice.service.WordTemplateServiceIfc#saveWordtemplate(com.chinacreator.xtbg.core.common.iweboffice.bean.WordTemplateBean)
	 */
	public String saveWordtemplate(WordTemplateBean wordTemplateBean)
			throws Exception {
		Connection conn =null;
		String templateid="";
		WordTemplateDao wordTemplateDao = (WordTemplateDao)LoadSpringContext.getApplicationContext().getBean("wordTemplateDaoImpl");
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			//如果新增和更新了表名的就自动设置相应配置
			boolean flag=false;
			String template_id=StringUtil.deNull(wordTemplateBean.getTemplate_id());
			if(StringUtil.isBlank(template_id)){//为空 新增
				flag=true;
			}else{
				String old_table_code=wordTemplateDao.getWordTemplateInfoByMbId(template_id).getTable_code();
				if(!old_table_code.equals(wordTemplateBean.getTable_code())){//原来的与现在的不想等则跟新了表名
					flag=true;
				}
			}
			
			templateid= wordTemplateDao.saveWordtemplate(wordTemplateBean);
			Formservice formservice = new FormserviceImpl();
			
			if(flag){//为true则自动设置相应配置
				//先删除原有配置
				String templateids="'"+template_id+"'";
				templateids=templateids.replace(",", "','");
				wordTemplateDao.deleteWordParamByTemplate(templateids, conn);
				List<OaMdColumnsBean> list= formservice.getCloumn(wordTemplateBean.getTable_id(), "");
				for (OaMdColumnsBean oaMdColumnsBean : list) {
					RuleItemBean ruleItemBean=new RuleItemBean();
					if(StringUtil.isBlank(template_id)){
						template_id=templateid;
					}
					ruleItemBean.setTemplate_id(template_id);
					ruleItemBean.setRuleitem_name(wordTemplateBean.getTable_code()+"__"+oaMdColumnsBean.getColumn_code());
					ruleItemBean.setTable_id(wordTemplateBean.getTable_code());
					ruleItemBean.setColumn_id(oaMdColumnsBean.getColumn_code());
					String type="";
					if("T_ID".equalsIgnoreCase(oaMdColumnsBean.getColumn_code())){
						type="8";
					}else if("T_FJ_ID".equalsIgnoreCase(oaMdColumnsBean.getColumn_code())){
						type="3";
					}else if("T_ZW_ID".equalsIgnoreCase(oaMdColumnsBean.getColumn_code())){
						type="2";
					}else{
						type="1";
					}
					ruleItemBean.setRuleitem_value_type(type);
					
					saveWordParam(ruleItemBean);
				}
				
			}
			
			
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		
		return templateid;
		
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveThWordtemplate
	  * @param thWordTemplateBean
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.iweboffice.service.WordTemplateServiceIfc#saveThWordtemplate(com.chinacreator.xtbg.core.common.iweboffice.bean.ThWordTemplateBean)
	 */
	public String saveThWordtemplate(ThWordTemplateBean thWordTemplateBean)
			throws Exception {

		WordTemplateDao wordTemplateDao = (WordTemplateDao) LoadSpringContext
				.getApplicationContext().getBean("wordTemplateDaoImpl");
		String template_id = wordTemplateDao.saveThWordtemplate(thWordTemplateBean);
		return template_id;

	}
	

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveVariable
	  * @param wordVarBean
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.iweboffice.service.WordTemplateServiceIfc#saveVariable(com.chinacreator.xtbg.core.common.iweboffice.bean.WordVarBean)
	 */
	public void saveVariable(WordVarBean wordVarBean)throws Exception {
		WordTemplateDao wordTemplateDao = (WordTemplateDao)LoadSpringContext.getApplicationContext().getBean("wordTemplateDaoImpl");
		wordTemplateDao.saveVariable(wordVarBean);
		
	}
	
	/**
	 * @Description:是否存在被引用记录
	 * @param ids
	 * @return
	 */
	public boolean isUsedVariable(String ids,String template_id) throws Exception {
		WordTemplateDao wordTemplateDao = (WordTemplateDao)LoadSpringContext.getApplicationContext().getBean("wordTemplateDaoImpl");
		return wordTemplateDao.isUsedVariable(ids, template_id);
		
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteVariable
	  * @param ids
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.iweboffice.service.WordTemplateServiceIfc#deleteVariable(java.lang.String)
	 */
	public void deleteVariable(String ids) throws Exception {
		WordTemplateDao wordTemplateDao = (WordTemplateDao)LoadSpringContext.getApplicationContext().getBean("wordTemplateDaoImpl");
		wordTemplateDao.deleteVariable(ids);
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveWordParam
	  * @param ruleItemBean
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.iweboffice.service.WordTemplateServiceIfc#saveWordParam(com.chinacreator.xtbg.core.common.iweboffice.bean.RuleItemBean)
	 */
	public String saveWordParam(RuleItemBean ruleItemBean) throws Exception {
		String kjId = "";
		WordTemplateDao wordTemplateDao = (WordTemplateDao)LoadSpringContext.getApplicationContext().getBean("wordTemplateDaoImpl");
		kjId = wordTemplateDao.saveWordParamTextInput(ruleItemBean);
		return kjId;
	}


	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getVariableSelect
	  * @param mbId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.iweboffice.service.WordTemplateServiceIfc#getVariableSelect(java.lang.String)
	 */
	public List<SelectBean> getVariableSelect(String mbId) throws Exception {
		try{
			WordTemplateDao wordTemplateDao = (WordTemplateDao)LoadSpringContext.getApplicationContext().getBean("wordTemplateDaoImpl");
			return wordTemplateDao.getVariableSelect(mbId);
		}catch(Exception e){
			LOG.error(e.getMessage(), e);
		}
		return null;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteWordParam
	  * @param ids
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.iweboffice.service.WordTemplateServiceIfc#deleteWordParam(java.lang.String)
	 */
	@Override
	public boolean deleteWordParam(String ids) {
		boolean flag = false;
		try{
			WordTemplateDao wordTemplateDao = (WordTemplateDao)LoadSpringContext.getApplicationContext().getBean("wordTemplateDaoImpl");
			wordTemplateDao.deleteWordParam(ids);
			flag = true;
		}catch(Exception e){
			LOG.error(e.getMessage(), e);
		}
		return flag;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteWordTemplate
	  * @param ids
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.iweboffice.service.WordTemplateServiceIfc#deleteWordTemplate(java.lang.String)
	 */
	@Override
	public boolean deleteWordTemplate(String ids) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			WordTemplateDao wordTemplateDao = (WordTemplateDao)LoadSpringContext.getApplicationContext().getBean("wordTemplateDaoImpl");
			wordTemplateDao.deleteWordParamByTemplate(ids, conn);//删除子表
			wordTemplateDao.deleteWordTemplate(ids,conn);//删除主表
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			return false;
		}finally{
			DbManager.closeConnection(conn);
		}
		return true;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteThWordTemplate
	  * @param ids
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.iweboffice.service.WordTemplateServiceIfc#deleteThWordTemplate(java.lang.String)
	 */
	public boolean deleteThWordTemplate(String ids) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			WordTemplateDao wordTemplateDao = (WordTemplateDao)LoadSpringContext.getApplicationContext().getBean("wordTemplateDaoImpl");
			wordTemplateDao.deleteThWordTemplate(ids,conn);//删除主表
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			return false;
		}finally{
			DbManager.closeConnection(conn);
		}
		return true;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getRuleItemBean
	  * @param ruleitem_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.iweboffice.service.WordTemplateServiceIfc#getRuleItemBean(java.lang.String)
	 */
	@Override
	public Map<String, String> getRuleItemBean(String ruleitem_id) {
		Map<String, String> ruleItemBeanMap = new HashMap<String, String>();
		try {
			WordTemplateDao wordTemplateDao = (WordTemplateDao)LoadSpringContext.getApplicationContext().getBean("wordTemplateDaoImpl");
			ruleItemBeanMap = wordTemplateDao.getRuleItemBean(ruleitem_id);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return ruleItemBeanMap;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getRuleItemBeanList
	  * @param template_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.common.iweboffice.service.WordTemplateServiceIfc#getRuleItemBeanList(java.lang.String)
	 */
	@Override
	public List<WordRuleItemBean> getRuleItemBeanList(String template_id) {
		List<WordRuleItemBean> WordRuleItemBeanList  =  null;
		try{
			WordTemplateDao wordTemplateDao = (WordTemplateDao)LoadSpringContext.getApplicationContext().getBean("wordTemplateDaoImpl");
			WordRuleItemBeanList =  wordTemplateDao.getRuleItemBeanList(template_id);
		}catch(Exception e){
			LOG.error(e.getMessage(), e);
		}
		return WordRuleItemBeanList;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *    复制模板信息
	 * @param ids
	 * @return
	 * @throws Exception 
	 * @see 
	 */
	@Override
	public String copyWordTemplate(Map<Integer,String> procMap) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			WordTemplateDao wordTemplateDao = (WordTemplateDao)LoadSpringContext.getApplicationContext().getBean("wordTemplateDaoImpl");
			String id = wordTemplateDao.copyWordTemplate(procMap, conn);
			conn.commit();
			return id;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			return "";
		}finally{
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 copyWordTextinput
	 * @param procMap
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.common.iweboffice.service.WordTemplateServiceIfc#copyWordTextinput(java.util.Map)
	 */
	@Override
	public String copyWordTextinput(Map<Integer, String> procMap)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			WordTemplateDao wordTemplateDao = (WordTemplateDao)LoadSpringContext.getApplicationContext().getBean("wordTemplateDaoImpl");
			String id = wordTemplateDao.copyWordTextinput(procMap, conn);
			conn.commit();
			return id;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			return "";
		}finally{
			DbManager.closeConnection(conn);
		}
	}
	
}
