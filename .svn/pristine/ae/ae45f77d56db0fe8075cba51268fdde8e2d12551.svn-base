package com.chinacreator.xtbg.pub.wordtemplate.dao.imploracle;

import java.util.ArrayList;
import java.util.List;

import com.chinacreator.business.common.tools.CacheCommonManageProxy;
import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DaoUtil;
import com.chinacreator.xtbg.pub.util.DateUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.pub.wordtemplate.dao.WordTemplateDao;
import com.chinacreator.xtbg.pub.wordtemplate.entity.RuleItemBean;
import com.chinacreator.xtbg.pub.wordtemplate.entity.SelectBean;
import com.chinacreator.xtbg.pub.wordtemplate.entity.WordTemplateBean;
import com.chinacreator.xtbg.pub.wordtemplate.entity.WordTemplateResultBean;
import com.chinacreator.xtbg.pub.wordtemplate.entity.WordVarBean;
import com.enterprisedt.util.debug.Logger;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2011</p>
 *<p>Company:湖南科创</p>
 *@author yi.yang
 *@version 1.0
 *@date 2011-9-15
 */

public class WordTemplateDaoImpl implements WordTemplateDao {
	private static final Logger LOG = Logger.getLogger(WordTemplateDaoImpl.class);
	/**
	 * @Description:查询模板信息
	 * @param template_id 模板ID
	 * @return
	 * @throws Exception
	 */
	public WordTemplateBean getWordTemplateInfoByMbId(String template_id)
			throws Exception {
		
		WordTemplateBean wordTemplateBean = new WordTemplateBean();
		StringBuffer sql = new StringBuffer();
		
		PreparedDBUtil pd = new PreparedDBUtil();
		sql.append("select wt.template_id,");
		sql.append("   wt.moduletype_logo,");
		sql.append("   wt.template_name,");
		sql.append("   wt.template_remark,");
		sql.append("   wt.is_common,");
		sql.append("   wt.template_sn ");
		sql.append("from ta_oa_word_template wt ");
		sql.append("where wt.template_id = ?");
		pd.preparedSelect(sql.toString());
		pd.setString(1, template_id);
		pd.executePrepared();
		if(pd.size() > 0){
			wordTemplateBean.setTemplate_id(pd.getString(0, "template_id"));
			wordTemplateBean.setModuletype_logo(pd.getString(0, "moduletype_logo"));
			wordTemplateBean.setTemplate_name(pd.getString(0, "template_name"));
			wordTemplateBean.setTemplate_remark(pd.getString(0, "template_remark"));
			wordTemplateBean.setIs_common(pd.getString(0, "is_common"));
			wordTemplateBean.setTemplate_sn(pd.getString(0, "template_sn"));
		}
		return wordTemplateBean;
	}
	
	/**
	 * @Description:保存/修改模板信息
	 * @param wordTemplateBean 模板基本信息Bean
	 * @throws Exception
	 */
	public String saveWordtemplate(WordTemplateBean wordTemplateBean)
			throws Exception {
		
		PreparedDBUtil pd = new PreparedDBUtil();
		String template_id = wordTemplateBean.getTemplate_id();
		StringBuffer sql = new StringBuffer();
		if(StringUtil.isBlank(template_id)) {
			template_id = DaoUtil.findBySequencsName("seq_ta_oa_word_template");
			sql.append("insert into ta_oa_word_template");
			sql.append("  (template_id,");
			sql.append("   moduletype_logo,");
			sql.append("   template_name,");
			sql.append("   template_creatortime,");
			sql.append("   template_userid,");
			sql.append("   template_username,");
			sql.append("   org_id,");
			sql.append("   org_name,");
			sql.append("   template_remark,");
			sql.append("   is_common,");
			sql.append("   lastmodifytime,");
			sql.append("   template_sn) ");
			sql.append("values");
			sql.append("  (?, ?, ?, sysdate, ?, ?, ?, ?, ?, ?, sysdate, ?)");
			pd.preparedInsert(sql.toString());
			pd.setString(1, template_id);
			pd.setString(2, wordTemplateBean.getModuletype_logo());
			pd.setString(3, wordTemplateBean.getTemplate_name());
			pd.setString(4, wordTemplateBean.getTemplate_userid());
			pd.setString(5, wordTemplateBean.getTemplate_username());
			pd.setString(6, wordTemplateBean.getOrg_id());
			pd.setString(7, wordTemplateBean.getOrg_name());
			pd.setString(8, wordTemplateBean.getTemplate_remark());
			pd.setString(9, wordTemplateBean.getIs_common());
			pd.setString(10, wordTemplateBean.getTemplate_sn());
		} else {
			sql.append("update ta_oa_word_template");
			sql.append("   set moduletype_logo      = ?,");
			sql.append("       template_name        = ?,");
			sql.append("       template_remark      = ?,");
			sql.append("       is_common            = ?,");
			sql.append("       lastmodifytime       = sysdate, ");
			sql.append("       template_sn       = ? ");
			sql.append("where template_id = ?");
			pd.preparedUpdate(sql.toString());
			pd.setString(1, wordTemplateBean.getModuletype_logo());
			pd.setString(2, wordTemplateBean.getTemplate_name());
			pd.setString(3, wordTemplateBean.getTemplate_remark());
			pd.setString(4, wordTemplateBean.getIs_common());
			pd.setString(5, wordTemplateBean.getTemplate_sn());
			pd.setString(6, wordTemplateBean.getTemplate_id());
			
		}
		
		pd.executePrepared();
		
		return template_id;

	}

	
	/**
	 * @Description:保存/修改变量
	 * @param map
	 * @throws Exception
	 */
	public void saveVariable(WordVarBean wordVarBean)throws Exception {
		PreparedDBUtil pd = new PreparedDBUtil();
		String var_id = wordVarBean.getVar_id();
		StringBuffer sql = new StringBuffer();
		if(StringUtil.isBlank(var_id)) {
			var_id = DaoUtil.findBySequencsName("seq_ta_oa_word_var");
			sql.append("insert into ta_oa_word_var ");
			sql.append("  (var_id, template_id, var_name, var_value, var_defaultvalue, var_desc) ");
			sql.append("values ");
			sql.append("  (?, ?, ?, ?, ?, ?) ");
			pd.preparedInsert(sql.toString());
			pd.setString(1, var_id);
			pd.setString(2, wordVarBean.getTemplate_id());
			pd.setString(3, wordVarBean.getVar_name());
			pd.setString(4, wordVarBean.getVar_value());
			pd.setString(5, wordVarBean.getVar_defaultvalue());
			pd.setString(6, wordVarBean.getVar_desc());
		} else {
			sql.append("update ta_oa_word_var ");
			sql.append("   set var_name         = ?, ");
			sql.append("       var_value        = ?, ");
			sql.append("       var_defaultvalue = ?, ");
			sql.append("       var_desc         = ? ");
			sql.append("  where var_id = ? ");
			pd.preparedUpdate(sql.toString());
			pd.setString(1, wordVarBean.getVar_name());
			pd.setString(2, wordVarBean.getVar_value());
			pd.setString(3, wordVarBean.getVar_defaultvalue());
			pd.setString(4, wordVarBean.getVar_desc());
			pd.setString(5, var_id);
		}
		pd.executePrepared();
		
	}
	
	/**
	 * @Description:查询变量
	 * @param sortKey
	 * @return
	 * @throws Exception
	 */
	public PagingBean getVariableInfoList(WordVarBean wordVarSearchBean, String sortName, String sortOrder, long offset, int maxPagesize) throws Exception {
		PagingBean pagingBean = new PagingBean();
		PreparedDBUtil pd = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		List<WordVarBean> wordVarBeanList = new ArrayList<WordVarBean>();
		
		sql.append("select wv.var_id, ");
		sql.append("   wv.template_id, ");
		sql.append("   wv.var_name, ");
		sql.append("   wv.var_value, ");
		sql.append("   wv.var_defaultvalue, ");
		sql.append("   wv.var_desc ");
		sql.append("from ta_oa_word_var wv ");
		sql.append("where wv.template_id = ? ");
		pd.preparedSelect(sql.toString());
		pd.setString(1, wordVarSearchBean.getTemplate_id());
		pd.executePrepared();
		
		for (int i = 0; i < pd.size(); i++) {
			WordVarBean wordVarBean = new WordVarBean();
			wordVarBean.setVar_id(pd.getString(i, "var_id"));
			wordVarBean.setTemplate_id(pd.getString(i, "template_id"));
			wordVarBean.setVar_name(pd.getString(i, "var_name"));
			wordVarBean.setVar_value(pd.getString(i, "var_value"));
			wordVarBean.setVar_defaultvalue(pd.getString(i, "var_defaultvalue"));
			wordVarBean.setVar_desc(pd.getString(i, "var_desc"));
			wordVarBeanList.add(wordVarBean);
			
		}
		pagingBean.setList(wordVarBeanList);
		pagingBean.setRecords((long)pd.getTotalSize());
		return pagingBean;
		
	}
	
	
	@Override
	public PagingBean getRuleItemInfoList(RuleItemBean RuleItemBean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		PagingBean pagingBean = new PagingBean();
		PreparedDBUtil pd = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		List<RuleItemBean> RuleItemBeanList = new ArrayList<RuleItemBean>();
		
		
		sql.append("select textinput_id ruleitem_id, ");
		sql.append("   template_id, ");
		sql.append("   textinput_name ruleitem_name,");
		sql.append("   decode(textinput_value_type,'1','变量','2','数据集') ruleitem_value_typename, ");
		sql.append("   textinput_value_type ruleitem_value_type, ");
		sql.append("   textinput_value ruleitem_value, ");
		sql.append("   (select v.var_name from ta_oa_word_var v where v.var_id = t.textinput_value) ruleitem_var_name, ");
		sql.append("   textinput_help ruleitem_help, ");
		sql.append("   textinput_flag ruleitem_flag, ");
		sql.append("   textinput_remark ruleitem_remark");
		sql.append(" from ta_oa_word_textinput t where template_id=? ");
		pd.preparedSelect(sql.toString());
		pd.setString(1, StringUtil.deNull(RuleItemBean.getTemplate_id()));
		pd.executePrepared();
		
		for (int i = 0; i < pd.size(); i++) {
			RuleItemBean rulItemBean2 = new RuleItemBean();
			rulItemBean2.setRuleitem_id(pd.getString(i, "ruleitem_id"));
			rulItemBean2.setTemplate_id(pd.getString(i, "template_id"));
			rulItemBean2.setRuleitem_name(pd.getString(i, "ruleitem_name"));
			rulItemBean2.setRuleitem_value_typename(pd.getString(i, "ruleitem_value_typename"));
			rulItemBean2.setRuleitem_value_type(pd.getString(i, "ruleitem_value_type"));
			rulItemBean2.setRuleitem_value(pd.getString(i, "ruleitem_value"));
			rulItemBean2.setRuleitem_var_name(pd.getString(i, "ruleitem_var_name"));
			rulItemBean2.setRuleitem_help(pd.getString(i, "ruleitem_help"));
			rulItemBean2.setRuleitem_flag(pd.getString(i, "ruleitem_flag"));
			rulItemBean2.setRuleitem_remark(pd.getString(i, "ruleitem_remark"));
			rulItemBean2.setControl_type("输入框");
			rulItemBean2.setControl_type_value("textInput");
			RuleItemBeanList.add(rulItemBean2);
		}
		pagingBean.setList(RuleItemBeanList);
		pagingBean.setRecords((long)pd.getTotalSize());
		return pagingBean;
	}

	
	
	@Override
	public PagingBean getWordTemplateInfoList(
			WordTemplateBean wordTemplateBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		PagingBean pagingBean = new PagingBean();
		PreparedDBUtil pd = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		List<WordTemplateResultBean> WordTemplateBeanList = new ArrayList<WordTemplateResultBean>();
		sql.append("select template_id, ");
		sql.append("   moduletype_logo, ");
		sql.append("   template_name, ");
		sql.append("   template_creatortime, ");
		sql.append("   template_userid, ");
		sql.append("   template_username, ");
		sql.append("   org_id, ");
		sql.append("   org_name, ");
		sql.append("   template_remark, ");
		sql.append("   is_common, ");
		sql.append("   lastmodifytime, ");
		sql.append("   template_sn ");
		sql.append(" from ta_oa_word_template t where 1=1  ");
		if(!StringUtil.nullOrBlank(wordTemplateBean.getTemplate_name())){
			sql.append(" and t.template_name like ?");
		}
		if(CacheCommonManageProxy.getBooleanSystemParam("WordTemp")){
			sql.append(" and t.org_id = '"+wordTemplateBean.getOrg_id()+"'");
		}
		sql.append("  order by t.template_sn ");

		pd.preparedSelect(sql.toString(), offset, maxPagesize);
		int j = 1;
		if(!StringUtil.nullOrBlank(wordTemplateBean.getTemplate_name())){
			pd.setString(j++, "%"+wordTemplateBean.getTemplate_name()+"%");
		}
		
		pd.executePrepared();
		
		for(int i = 0; i < pd.size(); i++) {
			WordTemplateResultBean wordTemplateResultBean = new WordTemplateResultBean();
			wordTemplateResultBean.setMb_id(pd.getString(i, "template_id"));
			wordTemplateResultBean.setMb_mc(pd.getString(i, "template_name"));
			wordTemplateResultBean.setMb_cjz(pd.getString(i, "template_username"));
			wordTemplateResultBean.setMb_cjsj(DateUtil.GetTimeStringFull(pd.getTimestamp(i, "template_creatortime")));
			wordTemplateResultBean.setMb_remark(pd.getString(i, "template_remark"));
			wordTemplateResultBean.setTemplate_sn(pd.getString(i, "template_sn"));
			
			WordTemplateBeanList.add(wordTemplateResultBean);
		}
		pagingBean.setList(WordTemplateBeanList);
		pagingBean.setRecords((long)pd.getTotalSize());
		return pagingBean;
	}


	/**
	 * @Description:是否存在被引用记录
	 * @param ids
	 * @return
	 */
	public boolean isUsedVariable(String ids,String template_id) throws Exception {
		boolean flag = false;
		PreparedDBUtil pd = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		sql.append("select count(value) ");
		sql.append("   from (select textinput_value as value, template_id ");
		sql.append("           from ta_oa_word_textinput a ");
		sql.append("          where textinput_value_type = '1') ");
		sql.append("  where value in (?) ");
		sql.append("    and template_id = ? ");
		pd.preparedSelect(sql.toString());
		pd.setString(1, ids);
		pd.setString(2, template_id);
		pd.executePrepared();
		if(pd.size() > 0 && Integer.parseInt(pd.getString(0, 0))>0 ){
			flag = true;
		}
		return flag;
		
	}
	
	/**
	 * @Description:删除变量
	 * @param ids
	 */
	public void deleteVariable(String ids) throws Exception {
		PreparedDBUtil pd = new PreparedDBUtil ();
		String sql = " delete ta_oa_word_var where var_id in ("+ids+")";
		pd.preparedDelete(sql);
		pd.executePrepared();
	}
	
	/**
	 * @Description:保存输入框
	 * @param map
	 */
	public String saveWordParamTextInput(RuleItemBean ruleItemBean)
			throws Exception {
		PreparedDBUtil pd = new PreparedDBUtil();
		String kjId = ruleItemBean.getRuleitem_id();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		
		
		if(StringUtil.isBlank(kjId)) {
			sql1.append("select seq_ta_oa_word_textinput.nextval nextid from dual");
			sql.append("insert into ta_oa_word_textinput ");
			sql.append("  (textinput_id, ");
			sql.append("   template_id, ");
			sql.append("   textinput_name, ");
			sql.append("   textinput_value_type, ");
			sql.append("   textinput_value, ");
			sql.append("   textinput_help, ");
			sql.append("   textinput_flag, ");
			sql.append("   textinput_remark) ");
			sql.append("values ");
			sql.append("  (?, ?, ?, ?, ?, ?, ?, ?) ");
			
			pd.preparedSelect(sql1.toString());
			pd.executePrepared();
			if(pd.size() > 0){
				kjId = pd.getString(0, "nextid");
			}
			
			pd.preparedInsert(sql.toString());
			pd.setString(1, kjId);
			pd.setString(2, ruleItemBean.getTemplate_id());
			pd.setString(3, ruleItemBean.getRuleitem_name());
			pd.setString(4, ruleItemBean.getRuleitem_value_type());
			pd.setString(5, ruleItemBean.getRuleitem_value());
			pd.setString(6, ruleItemBean.getRuleitem_help());
			pd.setString(7, "1");
			pd.setString(8, ruleItemBean.getRuleitem_remark());
			pd.executePrepared();
		} else {
			sql.append("update ta_oa_word_textinput set ");
			if(!StringUtil.nullOrBlank(ruleItemBean.getRuleitem_name())){
				sql.append("    textinput_name       = ?,");
			}
			if(!StringUtil.nullOrBlank(ruleItemBean.getRuleitem_value_type())){
				sql.append("       textinput_value_type = ?,");
			}
			if(!StringUtil.nullOrBlank(ruleItemBean.getRuleitem_value())){
				sql.append("       textinput_value      = ?,");			
			}
			if(!StringUtil.nullOrBlank(ruleItemBean.getRuleitem_help())){
				sql.append("       textinput_help       = ?,");
			}
			if(!StringUtil.nullOrBlank(ruleItemBean.getRuleitem_remark())){
				sql.append("       textinput_remark     = ?,");
			}
			pd.preparedUpdate(sql.substring(0, sql.length()-1) + " where textinput_id = ? ");
			int i = 1;
			if(!StringUtil.nullOrBlank(ruleItemBean.getRuleitem_name())){
				pd.setString(i++, ruleItemBean.getRuleitem_name());
			}
			if(!StringUtil.nullOrBlank(ruleItemBean.getRuleitem_value_type())){
				pd.setString(i++, ruleItemBean.getRuleitem_value_type());
			}
			if(!StringUtil.nullOrBlank(ruleItemBean.getRuleitem_value())){
				pd.setString(i++, ruleItemBean.getRuleitem_value());	
			}
			if(!StringUtil.nullOrBlank(ruleItemBean.getRuleitem_help())){
				pd.setString(i++, ruleItemBean.getRuleitem_help());
			}
			if(!StringUtil.nullOrBlank(ruleItemBean.getRuleitem_remark())){
				pd.setString(i++, ruleItemBean.getRuleitem_remark());
			}
			pd.setString(i++, kjId);
			pd.executePrepared();
			
		}
		return kjId;
	}
	
	
	
	@Override
	public void deleteWordParam(String ids) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		
		StringBuffer sql = new StringBuffer();
		
		sql.append("delete ta_oa_word_textinput where textinput_id in (").append(ids).append(")");
		pdb.preparedDelete(sql.toString());
		pdb.executePrepared();
		
	}
	
	/**
	 * 删除模版信息
	 * @param ids
	 * @throws Exception
	 */
	@Override
	public boolean deleteWordTemplate(String ids) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		
		sql.append("delete ta_oa_word_template where template_id in (").append(ids).append(")");
		pdb.preparedDelete(sql.toString());
		pdb.executePrepared();
		return true;
	}

	/**
	 * @Description:变量下拉列表
	 * @param mbId
	 * @return
	 * @throws Exception
	 */
	public List<SelectBean> getVariableSelect(String mbId) throws Exception {
		String sql = "select var_id,var_name,var_value,var_defaultvalue,var_desc,template_id from ta_oa_word_var t where template_id = ? order by var_id desc";
		PreparedDBUtil pdb = new PreparedDBUtil();
 		List<SelectBean> list = new ArrayList<SelectBean>();
		try{
 			pdb.preparedSelect(sql);
 			pdb.setString(1, mbId);
 			
 			pdb.executePrepared();
 			for(int i = 0 ; i < pdb.size() ; i++){
 				SelectBean selectBean = new SelectBean();
 				selectBean.setName(pdb.getString(i, "var_name"));
 				selectBean.setValue(pdb.getString(i, "var_id"));
 				list.add(selectBean);
 			}
 			return list;
 		}catch(Exception e){
 			LOG.error(e.toString());
 			throw new Exception(e);
 		}
	}

	@Override
	public String getRuleItemDefaultValue(String ruleItemid) throws Exception {
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil pdb = new PreparedDBUtil();
		String textinput_value = "";
		
		sql.append(" select  ");
		sql.append("   template_id, ");
		sql.append("   var_name, ");
		sql.append("   var_value, ");
		sql.append("   var_defaultvalue, ");
		sql.append("   var_desc ");
		sql.append(" from ta_oa_word_var t where var_id = ?");

		
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, ruleItemid);
		pdb.executePrepared();
		if(pdb.size() > 0){
			textinput_value = pdb.getString(0, "var_defaultvalue");
		}
		return textinput_value;
	}
	
	
	
}
