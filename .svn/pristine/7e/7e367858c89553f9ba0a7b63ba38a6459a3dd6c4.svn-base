package com.chinacreator.xtbg.core.common.iweboffice.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.iweboffice.bean.RuleItemBean;
import com.chinacreator.xtbg.core.common.iweboffice.bean.SelectBean;
import com.chinacreator.xtbg.core.common.iweboffice.bean.ThWordTemplateBean;
import com.chinacreator.xtbg.core.common.iweboffice.bean.WordRuleItemBean;
import com.chinacreator.xtbg.core.common.iweboffice.bean.WordTemplateBean;
import com.chinacreator.xtbg.core.common.iweboffice.bean.WordVarBean;

/**
 *<p>Title:</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2011</p>
 *<p>Company:湖南科创</p>
 *@author yi.yang
 *@version 1.0
 *@date 2011-9-15
 */

public interface WordTemplateDao {
	

	/**
	 * @Description:查询模板信息
	 * @param template_id 模板ID
	 * @return
	 * @throws Exception
	 */
	public WordTemplateBean getWordTemplateInfoByMbId(String template_id)
			throws Exception;
	/**
	 * @Description:查询套红模板信息
	 * @param template_id_th 模板ID
	 * @return
	 * @throws Exception
	 */
	public ThWordTemplateBean getThWordTemplateInfoByMbId(String template_id_th)
	throws Exception;
			
	/**
	 * @Description:保存/修改模板信息
	 * @param wordTemplateBean 模板基本信息Bean
	 * @throws Exception
	 */
	public String saveWordtemplate(WordTemplateBean wordTemplateBean)
			throws Exception;
	/**
	 * @Description:保存/修改套红模板信息
	 * @param wordTemplateBean 模板基本信息Bean
	 * @throws Exception
	 */
	public String saveThWordtemplate(ThWordTemplateBean thWordTemplateBean)
			throws Exception;
	
	
	/**
	 * @Description:保存/修改变量
	 * @param map
	 * @throws Exception
	 */
	public void saveVariable(WordVarBean wordVarBean)throws Exception;
	
	/**
	 * @Description:查询变量
	 * @param sortKey
	 * @return
	 * @throws Exception
	 */
	public PagingBean getVariableInfoList(WordVarBean wordVarBean, String sortName, String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * @Description:查询规则项
	 * @param sortKey
	 * @return
	 * @throws Exception
	 */
	public PagingBean getRuleItemInfoList(RuleItemBean RuleItemBean, String sortName, String sortOrder, long offset, int maxPagesize) throws Exception;
	
	
	/**
	 * @Description:查询变量
	 * @param sortKey
	 * @return
	 * @throws Exception
	 */
	public PagingBean getWordTemplateInfoList(WordTemplateBean wordTemplateBean, String sortName, String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * @Description:查询套红列表
	 * @param sortKey
	 * @return
	 * @throws Exception
	 */
	public PagingBean getThWordTemplateInfoList(ThWordTemplateBean thWordTemplateBean, String sortName, String sortOrder, long offset, int maxPagesize) throws Exception;

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
	 * @Description:保存输入框规则项
	 * @param map
	 */
	public String saveWordParamTextInput(RuleItemBean ruleItemBean)
			throws Exception;
	/**
	 * @Description:删除模板信息
	 * @param ids
	 * @return true or false
	 * @throws Exception
	 */
	public boolean deleteWordTemplate(String ids, Connection conn) throws Exception;
	/**
	 * @Description:删除套红模板信息
	 * @param ids
	 * @return true or false
	 * @throws Exception
	 */
	public boolean deleteThWordTemplate(String ids, Connection conn) throws Exception;
	
	/**
	 * @Description:根据模板ID删除模板信息
	 * @param ids
	 * @return true or false
	 * @throws Exception
	 */
	public boolean deleteWordParamByTemplate(String ids, Connection conn) throws Exception;
	
	/**
	 * @Description:删除规则项
	 * @param wordTemplateBean 模板基本信息Bean
	 * @throws Exception
	 */
	public void deleteWordParam(String ids)
			throws Exception;
	/**
	 * @Description:变量下拉列表
	 * @param mbId
	 * @return
	 * @throws Exception
	 */
	public List<SelectBean> getVariableSelect(String mbId)throws Exception;
	
	/**
	 * 获得规则项默认值
	 * @param ruleItemid
	 * @return
	 * @throws Exception
	 */
	public String getRuleItemDefaultValue(String ruleItemid) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getRuleItemBean(获得textinput的参数值)
	* @param ruleitem_id
	* @return
	* @throws Exception
	 */
	public Map<String, String> getRuleItemBean(String ruleitem_id) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getRuleItemBeanList(根据模板ID查询标签列表)
	* @param template_id
	* @return
	* @throws Exception
	 */
	public List<WordRuleItemBean> getRuleItemBeanList(String template_id)throws Exception;
	

	/**
	 * @Description:复制模板信息
	 * @param ids
	 * @return true or false
	 * @throws Exception
	 */
	public String copyWordTemplate(Map<Integer,String> procMap, Connection conn) throws Exception;
	/**
	 * 复制模板中Textinput信息
	 *<b>Summary: </b>
	 * copyWordTextinput
	 * @param procMap
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public String copyWordTextinput(Map<Integer,String> procMap, Connection conn) throws Exception;
	/**
	 * 为 复制 word中输入文本数据表 而查询
	 *<b>Summary: </b>
	 * getWordTemplateInfoForCopyList(为 复制 word中输入文本数据表 而查询)
	 * @param wordTemplateBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean getWordTemplateInfoForCopyList(WordTemplateBean wordTemplateBean, String sortName, String sortOrder, long offset, int maxPagesize) throws Exception;
}
