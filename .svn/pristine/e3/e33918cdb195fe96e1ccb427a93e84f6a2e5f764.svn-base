package com.chinacreator.xtbg.core.common.iweboffice.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.iweboffice.bean.RuleItemBean;
import com.chinacreator.xtbg.core.common.iweboffice.bean.SelectBean;
import com.chinacreator.xtbg.core.common.iweboffice.bean.ThWordTemplateBean;
import com.chinacreator.xtbg.core.common.iweboffice.bean.WordRuleItemBean;
import com.chinacreator.xtbg.core.common.iweboffice.bean.WordTemplateBean;
import com.chinacreator.xtbg.core.common.iweboffice.bean.WordTemplateResultBean;
import com.chinacreator.xtbg.core.common.iweboffice.bean.WordVarBean;
import com.chinacreator.xtbg.core.common.iweboffice.dao.WordTemplateDao;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.enterprisedt.util.debug.Logger;
import com.frameworkset.common.poolman.CallableDBUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:WordTemplateDaoImpl.java</p>
 *<p>Description:模块管理dao实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-7-29
 */

public class WordTemplateDaoImpl  extends XtDbBaseDao implements WordTemplateDao {
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
		sql.append("   wt.template_name,");
		sql.append("   wt.template_remark,");
		sql.append("   wt.is_common,");
		sql.append("   wt.template_sn ,");
		sql.append("   wt.singn_config,table_code ");
		sql.append("from oa_word_template wt ");
		sql.append("where wt.template_id = ?");
		pd.preparedSelect(sql.toString());
		pd.setString(1, template_id);
		pd.executePrepared();
		if(pd.size() > 0){
			wordTemplateBean.setTemplate_id(pd.getString(0, "template_id"));
			wordTemplateBean.setTemplate_name(pd.getString(0, "template_name"));
			wordTemplateBean.setTemplate_remark(pd.getString(0, "template_remark"));
			wordTemplateBean.setIs_common(pd.getString(0, "is_common"));
			wordTemplateBean.setSingn_config(pd.getString(0, "singn_config"));
			wordTemplateBean.setTemplate_sn(pd.getString(0, "template_sn"));
			wordTemplateBean.setTable_code(pd.getString(0, "table_code"));
		}
		return wordTemplateBean;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getThWordTemplateInfoByMbId
	  * @param template_id_th
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.iweboffice.dao.WordTemplateDao#getThWordTemplateInfoByMbId(java.lang.String)
	 */
	public ThWordTemplateBean getThWordTemplateInfoByMbId(String template_id_th)
			throws Exception {

		ThWordTemplateBean bean = new ThWordTemplateBean();
		StringBuffer sql = new StringBuffer();

		PreparedDBUtil pd = new PreparedDBUtil();
		sql.append("select wt.template_id_th,");
		sql.append("   wt.template_name_th,");
		sql.append("   wt.template_remark_th,");
		sql.append("   wt.is_common_th,");
		sql.append("   wt.org_id,");
		sql.append("   wt.org_name,");
		sql.append("   wt.template_sn_th, ");
		//============增加流程业务类型
		sql.append("   wt.busitype_code ");
		sql.append("from oa_word_template_th wt ");
		sql.append("where wt.template_id_th = ?");
		pd.preparedSelect(sql.toString());
		pd.setString(1, template_id_th);
		pd.executePrepared();
		if (pd.size() > 0) {
			bean.setTemplate_id_th(pd.getString(0, "template_id_th"));
			bean.setTemplate_name_th(pd.getString(0, "template_name_th"));
			bean.setTemplate_remark_th(pd.getString(0,
					"template_remark_th"));
			bean.setIs_common_th(pd.getString(0, "is_common_th"));
			bean.setOrg_id(pd.getString(0, "org_id"));
			bean.setOrg_name(pd.getString(0, "org_name"));
			bean.setTemplate_sn_th(pd.getString(0, "template_sn_th"));
			bean.setBusitype_code(pd.getString(0,"busitype_code"));//流程业务类型
		}
		return bean;
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
			template_id = StringUtil.getUUID();
			sql.append("insert into oa_word_template");
			sql.append("  (template_id,");
			sql.append("   template_name,");
			sql.append("   template_creatortime,");
			sql.append("   template_userid,");
			sql.append("   template_username,");
			sql.append("   org_id,");
			sql.append("   org_name,");
			sql.append("   template_remark,");
			sql.append("   is_common,");
			sql.append("   lastmodifytime,");
			sql.append("   singn_config,");
			sql.append("   template_sn,table_code) ");
			sql.append("values");
			sql.append("  (?, ?, sysdate, ?, ?, ?, ?, ?, ?, sysdate,?, ?,?)");
			pd.preparedInsert(sql.toString());
			pd.setString(1, template_id);
			pd.setString(2, wordTemplateBean.getTemplate_name());
			pd.setString(3, wordTemplateBean.getTemplate_userid());
			pd.setString(4, wordTemplateBean.getTemplate_username());
			pd.setString(5, wordTemplateBean.getOrg_id());
			pd.setString(6, wordTemplateBean.getOrg_name());
			pd.setString(7, wordTemplateBean.getTemplate_remark());
			pd.setString(8, wordTemplateBean.getIs_common());
			pd.setString(9, wordTemplateBean.getSingn_config());
			pd.setString(10, wordTemplateBean.getTemplate_sn());
			pd.setString(11, wordTemplateBean.getTable_code());
		} else {
			sql.append("update oa_word_template");
			sql.append("   set template_name        = ?,");
			sql.append("       template_remark      = ?,");
			sql.append("       is_common            = ?,");
			sql.append("       lastmodifytime       = sysdate, ");
			sql.append("       template_sn   = ?,  singn_config = ?,table_code=?");
			sql.append("where template_id = ?");
			pd.preparedUpdate(sql.toString());
			pd.setString(1, wordTemplateBean.getTemplate_name());
			pd.setString(2, wordTemplateBean.getTemplate_remark());
			pd.setString(3, wordTemplateBean.getIs_common());
			pd.setString(4, wordTemplateBean.getTemplate_sn());
			pd.setString(5, wordTemplateBean.getSingn_config());
			pd.setString(6, wordTemplateBean.getTable_code());
			pd.setString(7, wordTemplateBean.getTemplate_id());
			
		}
		
		pd.executePrepared();
		
		return template_id;
	}
	
	public String saveThWordtemplate(ThWordTemplateBean thWordTemplateBean)
			throws Exception {

		PreparedDBUtil pd = new PreparedDBUtil();
		String template_id_th = thWordTemplateBean.getTemplate_id_th();
		StringBuffer sql = new StringBuffer();
		if (StringUtil.isBlank(template_id_th)) {
			template_id_th = StringUtil.getUUID();
			sql.append("insert into oa_word_template_th");
			sql.append("  (template_id_th,");
			sql.append("   template_name_th,");
			sql.append("   template_creatortime_th,");
			sql.append("   template_userid_th,");
			sql.append("   template_username_th,");
			sql.append("   org_id,");
			sql.append("   org_name,");
			sql.append("   template_remark_th,");
			sql.append("   is_common_th,");
			sql.append("   lastmodifytime_th,");
			sql.append("   remark,");
			sql.append("   busitype_code,");
			sql.append("   template_sn_th) ");
			sql.append("values");
			sql.append("  (?, ?, sysdate, ?, ?, ?, ?, ?, ?, sysdate,?,?, ?)");
			pd.preparedInsert(sql.toString());
			pd.setString(1, template_id_th);
			pd.setString(2, thWordTemplateBean.getTemplate_name_th());
			pd.setString(3, thWordTemplateBean.getTemplate_userid_th());
			pd.setString(4, thWordTemplateBean.getTemplate_username_th());
			pd.setString(5, thWordTemplateBean.getOrg_id());
			pd.setString(6, thWordTemplateBean.getOrg_name());
			pd.setString(7, thWordTemplateBean.getTemplate_remark_th());
			pd.setString(8, thWordTemplateBean.getIs_common_th());
			pd.setString(9, thWordTemplateBean.getRemark());
			pd.setString(10, thWordTemplateBean.getBusitype_code());
			pd.setString(11, thWordTemplateBean.getTemplate_sn_th());
		} else {
			sql.append("update oa_word_template_th");
			sql.append("   set template_name_th        = ?,");
			sql.append("       template_remark_th      = ?,");
			sql.append("       is_common_th            = ?,");
			sql.append("       org_id            = ?,");
			sql.append("       org_name           = ?,");
			sql.append("       lastmodifytime_th       = sysdate, ");
			sql.append("       template_sn_th   = ?,");
			sql.append("       busitype_code   = ? ");
			sql.append("where template_id_th = ?");
			pd.preparedUpdate(sql.toString());
			pd.setString(1, thWordTemplateBean.getTemplate_name_th());
			pd.setString(2, thWordTemplateBean.getTemplate_remark_th());
			pd.setString(3, thWordTemplateBean.getIs_common_th());
			pd.setString(4, thWordTemplateBean.getOrg_id());
			pd.setString(5, thWordTemplateBean.getOrg_name());
			pd.setString(6, thWordTemplateBean.getTemplate_sn_th());
			pd.setString(7, thWordTemplateBean.getBusitype_code());
			pd.setString(8, thWordTemplateBean.getTemplate_id_th());

		}

		pd.executePrepared();

		return template_id_th;
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
			var_id = StringUtil.getUUID();
			sql.append("insert into oa_word_var ");
			sql.append("  (var_id, template_id_th, var_name, var_value, var_defaultvalue, var_desc) ");
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
			sql.append("update oa_word_var ");
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
		sql.append("from oa_word_var wv ");
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
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getRuleItemInfoList
	  * @param RuleItemBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.iweboffice.dao.WordTemplateDao#getRuleItemInfoList(com.chinacreator.xtbg.core.common.iweboffice.bean.RuleItemBean, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean getRuleItemInfoList(RuleItemBean RuleItemBean,
			String sortName, String sortOrder,long offset, int maxPagesize)
			throws Exception {
		PagingBean pagingBean = new PagingBean();
		PreparedDBUtil pd = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		List<RuleItemBean> RuleItemBeanList = new ArrayList<RuleItemBean>();
		RuleItemBean rulItemBean = null;
		sql.append("select textinput_id as ruleitem_id,");
		sql.append("       template_id,");
		sql.append("       textinput_name as ruleitem_name,");
		sql.append("       t.table_id,");
		sql.append("       t.column_id,");
		sql.append("       c.column_name,");
		sql.append("       decode(textinput_value_type,'1','变量','2','正文','3','附件','4','文号','5','标题','6','意见',7,'附件列表',8,'主键','9','信息公开') as ruleitem_value_typename,");
		sql.append("       textinput_value as ruleitem_value,");
		sql.append("       table_cell as table_cell");
		sql.append("  from oa_word_textinput t left join oa_md_table mt on t.table_id=mt.table_code");
		sql.append("  left join oa_md_columns c on mt.table_id=c.table_id and t.column_id=c.column_code");
		sql.append(" where template_id = ?");
		sql.append(" order by to_number(substr(table_cell,0,INSTR (table_cell,',',1,1)-1)) nulls first ,");
		sql.append("  to_number(substr(table_cell,INSTR (table_cell,',',1,1)+1,INSTR (table_cell,',',1,2)-INSTR (table_cell,',',1,1)-1)),");
		sql.append("  to_number(substr(table_cell,INSTR (table_cell,',',1,2)+1,length(table_cell)-INSTR (table_cell,',',1,2))) nulls first, ");
		sql.append("  ruleitem_value_typename desc");
		//sql.append(" order by table_cell");
		pd.preparedSelect(sql.toString(), offset, maxPagesize);
		pd.setString(1, StringUtil.deNull(RuleItemBean.getTemplate_id()));
		pd.executePrepared();
		
		for (int i = 0; i < pd.size(); i++) {
			rulItemBean = new RuleItemBean();
			rulItemBean.setRuleitem_id(pd.getString(i, "ruleitem_id"));
			rulItemBean.setTemplate_id(pd.getString(i, "template_id"));
			rulItemBean.setRuleitem_name(pd.getString(i, "ruleitem_name"));
			rulItemBean.setRuleitem_value_typename(pd.getString(i, "ruleitem_value_typename"));
			rulItemBean.setRuleitem_value_type(pd.getString(i, "ruleitem_value_type"));
			rulItemBean.setRuleitem_value(pd.getString(i, "ruleitem_value"));
			rulItemBean.setTable_id(pd.getString(i, "table_id"));
			rulItemBean.setColumn_id(pd.getString(i, "column_id"));
			rulItemBean.setColumn_name(pd.getString(i, "column_name"));
			rulItemBean.setTable_cell(pd.getString(i, "table_cell"));
			RuleItemBeanList.add(rulItemBean);
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
		sql.append("   template_name, ");
		sql.append("   template_creatortime, ");
		sql.append("   template_userid, ");
		sql.append("   template_username, ");
		sql.append("   org_id, ");
		sql.append("   org_name, ");
		sql.append("   template_remark, ");
		sql.append("   is_common, ");
		sql.append("   lastmodifytime, ");
		sql.append("   template_sn,table_code ");
		sql.append(" from oa_word_template t ");
		if(!StringUtil.nullOrBlank(wordTemplateBean.getTemplate_name())){
			sql.append(" where t.template_name like ?");
		}
		sql.append("  order by t.template_sn,t.template_creatortime,t.template_name ");
		
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
			wordTemplateResultBean.setTable_code(pd.getString(i, "table_code"));
			
			WordTemplateBeanList.add(wordTemplateResultBean);
		}
		pagingBean.setList(WordTemplateBeanList);
		pagingBean.setRecords((long)pd.getTotalSize());
		return pagingBean;
	}
	
	public PagingBean getThWordTemplateInfoList(
			ThWordTemplateBean ThWordTemplateBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		PagingBean pagingBean = new PagingBean();
		PreparedDBUtil pd = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		List<WordTemplateResultBean> WordTemplateBeanList = new ArrayList<WordTemplateResultBean>();
		
		sql.append("select template_id_th, ");
		sql.append("   template_name_th, ");
		sql.append("   template_creatortime_th, ");
		sql.append("   template_userid_th, ");
		sql.append("   template_username_th, ");
		sql.append("   org_id, ");
		sql.append("   org_name, ");
		sql.append("   template_remark_th, ");
		sql.append("   is_common_th, ");
		sql.append("   lastmodifytime_th, ");
		sql.append("   type.busitype_name, ");
		sql.append("   template_sn_th ");
		sql.append(" from oa_word_template_th t  ");
		sql.append("   left join oa_flow_busitype type on t.busitype_code =type.busitype_code ");
		sql.append("   where 1=1  ");
		if(!StringUtil.nullOrBlank(ThWordTemplateBean.getRemark())){
			sql.append(" and IS_COMMON_TH='"+ThWordTemplateBean.getRemark()+"'");
		}
		if(!StringUtil.nullOrBlank(ThWordTemplateBean.getOrg_id())){
			sql.append(" and org_id in("+StringUtil.splitString(ThWordTemplateBean.getOrg_id(),",","'")+")");
		}
		if(!StringUtil.nullOrBlank(ThWordTemplateBean.getTemplate_name_th())){
			sql.append(" and t.template_name_th like ?");
		}
		//流程业务类型
		if(!StringUtil.nullOrBlank(ThWordTemplateBean.getBusitype_code())){
			sql.append(" and (t.busitype_code ='"+ThWordTemplateBean.getBusitype_code()+"' or t.busitype_code is null )");
		}
		if(StringUtil.isBlank(sortName)){
			sql.append("  order by t.template_sn_th,t.template_id_th ");
		}else{
			sql.append("  order by t."+sortName+"  "+sortOrder);
		}

		pd.preparedSelect(sql.toString(), offset, maxPagesize);
		int j = 1;
		if(!StringUtil.nullOrBlank(ThWordTemplateBean.getTemplate_name_th())){
			pd.setString(j++, "%"+ThWordTemplateBean.getTemplate_name_th()+"%");
		}
		
		pd.executePrepared();
		
		for(int i = 0; i < pd.size(); i++) {
			WordTemplateResultBean wordTemplateResultBean = new WordTemplateResultBean();
			wordTemplateResultBean.setMb_id(pd.getString(i, "template_id_th"));
			wordTemplateResultBean.setMb_mc(pd.getString(i, "template_name_th"));
			wordTemplateResultBean.setMb_cjz(pd.getString(i, "template_username_th"));
			wordTemplateResultBean.setMb_cjsj(DateUtil.GetTimeStringFull(pd.getTimestamp(i, "template_creatortime_th")));
			wordTemplateResultBean.setMb_remark(pd.getString(i, "template_remark_th"));
			wordTemplateResultBean.setTemplate_sn(pd.getString(i, "template_sn_th"));
			wordTemplateResultBean.setBusitype_name(pd.getString(i, "busitype_name"));
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
		sql.append("           from oa_word_textinput a ");
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
		String sql = " delete oa_word_var where var_id in ("+ids+")";
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
		
		
		if(StringUtil.isBlank(kjId)) {
			sql.append("insert into oa_word_textinput ");
			sql.append("  (textinput_id, ");
			sql.append("   template_id, ");
			sql.append("   textinput_name, ");
			sql.append("   textinput_value_type, ");
			sql.append("   textinput_value, ");
			sql.append("   textinput_help, ");
			sql.append("   textinput_flag, ");
			sql.append("   textinput_remark, ");
			sql.append("   table_id, ");
			sql.append("   column_id, ");
			sql.append("   table_cell,DATA_COME_FROM_TABLE_ID,DATA_COME_FROM_COLUMN_ID) ");
			sql.append("values ");
			sql.append("  (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ");
			
			kjId = StringUtil.getUUID();
			pd.preparedInsert(sql.toString());
			pd.setString(1, kjId);
			pd.setString(2, ruleItemBean.getTemplate_id());
			pd.setString(3, ruleItemBean.getRuleitem_name());
			pd.setString(4, ruleItemBean.getRuleitem_value_type());
			pd.setString(5, ruleItemBean.getRuleitem_value());
			pd.setString(6, ruleItemBean.getRuleitem_help());
			pd.setString(7, "1");
			pd.setString(8, ruleItemBean.getRuleitem_remark());
			pd.setString(9, ruleItemBean.getTable_id());
			pd.setString(10, ruleItemBean.getColumn_id());
			pd.setString(11, ruleItemBean.getTable_cell());
			pd.setString(12, ruleItemBean.getData_come_from_table_id());
			pd.setString(13, ruleItemBean.getData_come_from_column_id());
			pd.executePrepared();
		} else {
			sql.append("update oa_word_textinput set ");
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
			if(!StringUtil.nullOrBlank(ruleItemBean.getTable_cell())){
				sql.append("       table_cell     = ?,");
			}
			if(!StringUtil.nullOrBlank(ruleItemBean.getTable_id())){
				sql.append("       table_id     = ?,");
			}
			if(!StringUtil.nullOrBlank(ruleItemBean.getColumn_id())){
				sql.append("       column_id     = ?,");
			}
			if(!StringUtil.nullOrBlank(ruleItemBean.getData_come_from_table_id())){
				sql.append("       DATA_COME_FROM_TABLE_ID     = ?,");
			}
			if(!StringUtil.nullOrBlank(ruleItemBean.getData_come_from_column_id())){
				sql.append("       DATA_COME_FROM_COLUMN_ID     = ?,");
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
			if(!StringUtil.nullOrBlank(ruleItemBean.getTable_cell())){
				pd.setString(i++, ruleItemBean.getTable_cell());
			}
			if(!StringUtil.nullOrBlank(ruleItemBean.getTable_id())){
				pd.setString(i++, ruleItemBean.getTable_id());
			}
			if(!StringUtil.nullOrBlank(ruleItemBean.getColumn_id())){
				pd.setString(i++, ruleItemBean.getColumn_id());
			}
			if(!StringUtil.nullOrBlank(ruleItemBean.getData_come_from_table_id())){
				pd.setString(i++, ruleItemBean.getData_come_from_table_id());
			}
			if(!StringUtil.nullOrBlank(ruleItemBean.getData_come_from_column_id())){
				pd.setString(i++, ruleItemBean.getData_come_from_column_id());
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
		
		sql.append("delete oa_word_textinput where textinput_id = ?");
		pdb.preparedDelete(sql.toString());
		pdb.setString(1, ids);
		pdb.executePrepared();
		
	}
	
	/**
	 * 删除模版信息
	 * @param ids
	 * @throws Exception
	 */
	@Override
	public boolean deleteWordTemplate(String ids, Connection conn) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		
		sql.append("delete oa_word_template where template_id in (").append(ids).append(")");
		pdb.preparedDelete(sql.toString());
		pdb.executePrepared(conn);
		return true;
	}
	/**
	 * 删除套红模版信息
	 * @param ids
	 * @throws Exception
	 */
	@Override
	public boolean deleteThWordTemplate(String ids, Connection conn) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		
		sql.append("delete oa_word_template_th where template_id_th in (").append(ids).append(")");
		pdb.preparedDelete(sql.toString());
		pdb.executePrepared(conn);
		return true;
	}
	
	/**
	 *根据模板ID 删除模版信息
	 * @param ids
	 * @throws Exception
	 */
	@Override
	public boolean deleteWordParamByTemplate(String ids, Connection conn) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		
		sql.append("delete oa_word_textinput where template_id in (").append(ids).append(")");
		pdb.preparedDelete(sql.toString());
		pdb.executePrepared(conn);
		return true;
	}

	/**
	 * @Description:变量下拉列表
	 * @param mbId
	 * @return
	 * @throws Exception
	 */
	public List<SelectBean> getVariableSelect(String mbId) throws Exception {
		String sql = "select var_id,var_name,var_value,var_defaultvalue,var_desc,template_id from oa_word_var t where template_id = ? order by var_id desc";
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
 			LOG.error(e.getMessage(), e);
 			throw new Exception(e);
 		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getRuleItemDefaultValue
	  * @param ruleItemid
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.iweboffice.dao.WordTemplateDao#getRuleItemDefaultValue(java.lang.String)
	 */
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
		sql.append(" from oa_word_var t where var_id = ?");

		
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, ruleItemid);
		pdb.executePrepared();
		if(pdb.size() > 0){
			textinput_value = pdb.getString(0, "var_defaultvalue");
		}
		return textinput_value;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getRuleItemBean
	  * @param ruleitem_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.iweboffice.dao.WordTemplateDao#getRuleItemBean(java.lang.String)
	 */
	@Override
	public Map<String, String> getRuleItemBean(String ruleitem_id)
			throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select textinput_id,");
		sql.append("       template_id,");
		sql.append("       textinput_name,");
		sql.append("       table_id,");
		sql.append("       column_id,");
		sql.append("       textinput_value_type,");
		sql.append("       textinput_value,");
		sql.append("       textinput_help,");
		sql.append("       textinput_flag,");
		sql.append("       textinput_remark,");
		sql.append("       table_cell,data_come_from_table_id,data_come_from_column_id");
		sql.append("  from oa_word_textinput");
		sql.append(" where textinput_id = ?");
		viewMap = queryToSingleMap(sql.toString(), ruleitem_id);
		return viewMap;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getRuleItemBeanList
	  * @param template_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.iweboffice.dao.WordTemplateDao#getRuleItemBeanList(java.lang.String)
	 */
	@Override
	public List<WordRuleItemBean> getRuleItemBeanList(String template_id)
			throws Exception {
		PreparedDBUtil pd = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		List<WordRuleItemBean> ruleItemBeanList = new ArrayList<WordRuleItemBean>();
		WordRuleItemBean wordRuleItemBean = null;
		sql.append("select textinput_id,template_id,textinput_name,table_id,column_id,textinput_value_type,textinput_value,textinput_help,textinput_flag,textinput_remark,table_cell");
		sql.append(",DATA_COME_FROM_TABLE_ID,DATA_COME_FROM_COLUMN_ID  from oa_word_textinput");
		sql.append("  where template_id = ?");
		pd.preparedSelect(sql.toString());
		pd.setString(1, StringUtil.deNull(template_id));
		pd.executePrepared();
		
		for (int i = 0; i < pd.size(); i++) {
			wordRuleItemBean = new WordRuleItemBean();
			wordRuleItemBean.setTextinput_id(pd.getString(i,"textinput_id"));
			wordRuleItemBean.setTemplate_id(pd.getString(i,"template_id"));
			wordRuleItemBean.setTextinput_name(pd.getString(i,"textinput_name"));
			wordRuleItemBean.setTable_id(pd.getString(i,"table_id"));
			wordRuleItemBean.setColumn_id(pd.getString(i,"column_id"));
			wordRuleItemBean.setTextinput_value_type(pd.getString(i,"textinput_value_type"));
			wordRuleItemBean.setTextinput_value(pd.getString(i,"textinput_value"));
			wordRuleItemBean.setTextinput_help(pd.getString(i,"textinput_help"));
			wordRuleItemBean.setTextinput_flag(pd.getString(i,"textinput_flag"));
			wordRuleItemBean.setTextinput_remark(pd.getString(i,"textinput_remark"));
			wordRuleItemBean.setTable_cell(pd.getString(i,"table_cell"));
			ruleItemBeanList.add(wordRuleItemBean);
		}
		return ruleItemBeanList;
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
	public String copyWordTemplate(Map<Integer,String> procMap, Connection conn) throws Exception{
		CallableDBUtil cdb = new CallableDBUtil();
		cdb.prepareCallable("{call p_oa_word_template_copy(?,?,?,?,?,?)}");
		for (Integer key : procMap.keySet()) {
			cdb.setString(key, procMap.get(key));
		}
		cdb.registerOutParameter(6, java.sql.Types.VARCHAR);
		cdb.executeCallable(conn);
		String id = cdb.getString(6);
		return id;
	}
	/**
	 * 为复制 word中输入文本数据表(横向复制模板) 查询的list
	 * <b>Summary: </b>
	 *     复写方法 getWordTemplateInfoForCopyList
	 * @param wordTemplateBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.common.iweboffice.dao.WordTemplateDao#getWordTemplateInfoForCopyList(com.chinacreator.xtbg.core.common.iweboffice.bean.WordTemplateBean, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean getWordTemplateInfoForCopyList(
			WordTemplateBean wordTemplateBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		PagingBean pagingBean = new PagingBean();
		PreparedDBUtil pd = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		List<WordTemplateResultBean> WordTemplateBeanList = new ArrayList<WordTemplateResultBean>();
		
		sql.append("select template_id, ");
		sql.append("   template_name, ");
		sql.append("   template_creatortime, ");
		sql.append("   template_userid, ");
		sql.append("   template_username, ");
		sql.append("   org_id, ");
		sql.append("   org_name, ");
		sql.append("   template_remark, ");
		sql.append("   is_common, ");
		sql.append("   lastmodifytime, ");
		sql.append("   template_sn,table_code ");
		sql.append(" from oa_word_template t where 1=1 ");
		if(!StringUtil.nullOrBlank(wordTemplateBean.getTemplate_name())){
			sql.append(" and t.template_name like ?");
		}
		if(!StringUtil.nullOrBlank(wordTemplateBean.getTemplate_id())){
			sql.append(" and t.template_id <> ?");
		}
		sql.append("  order by t.template_sn ");

		pd.preparedSelect(sql.toString(), offset, maxPagesize);
		int j = 1;
		if(!StringUtil.nullOrBlank(wordTemplateBean.getTemplate_name())){
			pd.setString(j++, "%"+wordTemplateBean.getTemplate_name()+"%");
		}
		if(!StringUtil.nullOrBlank(wordTemplateBean.getTemplate_id())){
			pd.setString(j++, "%"+wordTemplateBean.getTemplate_id()+"%");
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
			wordTemplateResultBean.setTable_code(pd.getString(i, "table_code"));
			
			WordTemplateBeanList.add(wordTemplateResultBean);
		}
		pagingBean.setList(WordTemplateBeanList);
		pagingBean.setRecords((long)pd.getTotalSize());
		return pagingBean;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 copyWordTextinput
	 * @param procMap
	 * @param conn
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.common.iweboffice.dao.WordTemplateDao#copyWordTextinput(java.util.Map, java.sql.Connection)
	 */
	@Override
	public String copyWordTextinput(Map<Integer, String> procMap,
			Connection conn) throws Exception {
		CallableDBUtil cdb = new CallableDBUtil();
		cdb.prepareCallable("{call p_oa_word_textinput_copy(?,?,?)}");
		for (Integer key : procMap.keySet()) {
			cdb.setString(key, procMap.get(key));
		}
		cdb.registerOutParameter(3, java.sql.Types.VARCHAR);
		cdb.executeCallable(conn);
		String id = cdb.getString(3);
		return id;
	}
	
}
