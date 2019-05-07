package com.chinacreator.xtbg.core.inspect.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.inspect.dao.InspectTypeDao;
import com.chinacreator.xtbg.core.inspect.entity.InspectBaseInfoBean;
import com.chinacreator.xtbg.core.inspect.entity.InspectTypeBean;
/**
 * 
 *<p>Title:InspectTypeDaoImpl.java</p>
 *<p>Description:督查督办任务类别接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-11-4
 */
public class InspectTypeDaoImpl extends XtDbBaseDao implements InspectTypeDao {

	/**
	 * 
	  * <b>Summary: 督查督办的类别查询</b>
	  *     复写方法 selInspectTypeList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.inspect.dao.InspectTypeDao#selInspectTypeList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean selInspectTypeList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		InspectTypeBean bean=new InspectTypeBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				bean = (InspectTypeBean) JSONObject.parseObject(parmjson, InspectTypeBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append(" select type_id,type_name,type_remark,type_template,type_order from oa_inspect_type ");
			sql.append("  where 1=1");
			if(bean!=null){
				if(!StringUtil.isBlank(bean.getType_name())){
					sql.append(" and type_name like '%'||?||'%' ");
					condition.add(bean.getType_name());
				}
			}
			
			sql.append(" order by " + sortName + " " + sortOrder);
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	  * <b>Summary:上报查询列表 </b>
	  *     复写方法 selInspectReportList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.inspect.dao.InspectTypeDao#selInspectReportList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean selInspectReportList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		List<String> conditionValues = new ArrayList<String>();
		InspectBaseInfoBean bean=new InspectBaseInfoBean();
		Connection conn = null;
		PagingBean pb = new PagingBean();
		StringBuffer sql = new StringBuffer();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				bean = (InspectBaseInfoBean) JSONObject.parseObject(parmjson, InspectBaseInfoBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			sql.append("select a.info_id,");
			sql.append("       a.inspect_name,");
			sql.append("       a.inspect_type,");
			sql.append("       a.inspect_state,");
			sql.append("       decode(a.inspect_state,'0','草稿','1','办理中','2','已完成','3','未完成') inspect_state_name,");
			sql.append("       a.create_time,");
			sql.append("       to_char(a.send_time, 'yyyy-mm-dd hh24:mi') as send_time,");
			sql.append("       to_char(a.plan_endtime, 'yyyy-mm-dd hh24:mi') as plan_endtime,");
			sql.append("       to_char(a.remind_time, 'yyyy-mm-dd hh24:mi') as remind_time,");
			sql.append("       a.remind_content,");
			sql.append("       a.recept_orgids,");
			sql.append("       a.recept_orgnames,");
			sql.append("       a.send_user_id,");
			sql.append("       a.send_user_name,");
			sql.append("       a.user_orgid,");
			sql.append("       a.user_orgname,");
			sql.append("       a.is_sms,a.is_msg,");
			sql.append("       a.is_rtx,a.is_mail,");
			sql.append("       b.type_name");
			sql.append("  from oa_inspect_baseinfo a ");
			sql.append("  left join oa_inspect_type b  ");
			sql.append("  on a.inspect_type=b.type_id   ");
			sql.append(" where a.info_id is not null and is_report='1' ");
				
			if(!StringUtil.nullOrBlank(bean.getInspect_name())){
				sql.append(" and a.inspect_name like '%'||?||'%'");
				conditionValues.add(bean.getInspect_name());
			}
			if(!StringUtil.nullOrBlank(bean.getInspect_type())){
				sql.append(" and a.inspect_type = ?");
				conditionValues.add(bean.getInspect_type());
			}
			//交办开始时间
			if(!StringUtil.nullOrBlank(bean.getSend_time())){
				sql.append(" and a.send_time >= to_date(?,'yyyy-mm-dd hh24:mi:ss')");
				conditionValues.add(bean.getSend_time()+" 00:00:00");
			}
			//交办截止时间
			if(!StringUtil.nullOrBlank(bean.getPlan_endtime())){
				sql.append(" and a.send_time <= to_date(?,'yyyy-mm-dd hh24:mi:ss')");
				conditionValues.add(bean.getPlan_endtime()+" 23:59:59");
			}
			
			//状态
			if(!StringUtil.nullOrBlank(bean.getInspect_state())){
				sql.append(" and a.inspect_state= ?");
				conditionValues.add(bean.getInspect_state());
			}
			//创建人id
			if(!StringUtil.nullOrBlank(bean.getUser_orgid())){
				sql.append(" and a.user_orgid= ?");
				conditionValues.add(bean.getUser_orgid());
			}
			
			
	        //排序
	        sql.append(" order by "+sortName +" "+sortOrder);
			
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,conditionValues);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
		
	}

}
