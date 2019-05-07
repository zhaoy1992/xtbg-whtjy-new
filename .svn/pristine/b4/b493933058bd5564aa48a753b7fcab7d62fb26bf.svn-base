package com.chinacreator.xtbg.core.archive.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.archive.dao.CircularizeDao;
import com.chinacreator.xtbg.core.archive.entity.CircularizeBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:CircularizeDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 李星
 *@version 1.0
 *2013-4-19
 */
public class CircularizeDaoImpl implements CircularizeDao{
	private static final Logger LOG = Logger.getLogger(CircularizeDaoImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findTypeList
	 * @param ScheduleCanViewBean  //查询参数
	 * @param sortName  //排序字段
	 * @param sortOrder  //排序方式
	 * @param offset  //从第几天开始
	 * @param maxPagesize	//当前页数
	 * @return  List
	 * @throws SQLException 
	 * @throws SQLException 
	  * @see com.chinacreator.xtbg.huaihua.workflow.circularize.dao.CircularizeDao#findTypeList(com.chinacreator.xtbg.yimingju.sendno.entity.SendTypeBean, java.lang.String, java.lang.String, long, int)
	 */

	@Override
	public PagingBean findCirularizeList(CircularizeBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<CircularizeBean> list = new ArrayList<CircularizeBean>();
		StringBuffer sql = new StringBuffer();
		sql.append(" select f.circularize_title , ");
		sql.append(" to_char(f.entering_date,'yyyy-mm-dd hh24:mi') entering_date, ");
		sql.append(" f.receive_userid, ");
		sql.append(" f.is_circularize, ");
		sql.append(" f.circularize_id ,");
		sql.append(" f.action_form, ");
		sql.append(" f.ins_id, ");
		sql.append(" f.busi_id, ");
		sql.append(" f.send_userid ,");
		sql.append(" decode(f.is_view,'1','已查看','未查看') as is_view, ");//查看状态
		sql.append(" (select count(*) from oa_circularize_flow t,td_sm_user users where t.ins_id = f.ins_id and t.receive_userid=users.user_id and t.is_view is null) as  notreadNum,");//未阅读人数
		sql.append(" (select count(*) from oa_circularize_flow t,td_sm_user users where t.ins_id = f.ins_id and t.receive_userid=users.user_id and t.is_view =1 ) as  readNum,");//未阅读人数
		sql.append(" u.user_realname,f.busitype_code,f.template_id ");
		sql.append(" from oa_circularize_flow f ,td_sm_user u ");
		sql.append(" where  f.receive_userid = ?  and u.user_id = f.send_userid ");
		
		if(!StringUtil.nullOrBlank(bean.getCircularize_title())){
			sql.append(" and f.circularize_title like '%"+bean.getCircularize_title()+"%'");	
		}
		sql.append(" order by " + sortName + " " + sortOrder);
		try {
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.setString(1, bean.getReceive_userid());
			db.executePrepared();
			for(int i = 0 ; i < db.size() ; i++){
				CircularizeBean cBean = new CircularizeBean();
				cBean.setBusi_id(db.getString(i,"busi_id"));
				cBean.setCircularize_id(db.getString(i,"circularize_id"));
				cBean.setCircularize_title(db.getString(i,"circularize_title"));
				cBean.setEntering_date(db.getString(i,"entering_date"));
				cBean.setIs_circularize(db.getString(i,"is_circularize"));
				cBean.setSend_userid(db.getString(i,"send_userid"));
				cBean.setReceive_userid(db.getString(i,"receive_userid"));
				cBean.setAction_form(db.getString(i,"action_form"));
				cBean.setIns_id(db.getString(i,"ins_id"));
				cBean.setUser_realname(db.getString(i,"user_realname"));
				cBean.setBusitype_code(db.getString(i,"busitype_code"));
				cBean.setTemplate_id(db.getString(i,"template_id"));
				cBean.setIs_view(db.getString(i,"is_view"));//查看状态
				cBean.setNotreadNum(db.getString(i,"notreadNum"));//未阅读人数
				cBean.setReadNum(db.getString(i,"readNum"));
				list.add(cBean);
			}
		} catch (SQLException e) {
			LOG.error("执行传阅列表查询报错："+e.getMessage());
		}
		 pb.setList(list);
		 pb.setRecords((long)db.getTotalSize());
		return pb;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 savaCircularize
	  * @param bean
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.huaihua.workflow.circularize.dao.CircularizeDao#savaCircularize(com.chinacreator.xtbg.huaihua.workflow.circularize.enetity.CircularizeBean)
	 */
	@Override
	public boolean savaCircularize(List<CircularizeBean> circularizeBeanList, Connection conn) throws SQLException {
		StringBuffer sql = new StringBuffer();
		sql.append(" insert into oa_circularize_flow(circularize_id ,busi_id,send_userid,")
		.append(" receive_userid,circularize_title,action_form,ins_id,entering_date,busitype_code,template_id)");
		sql.append(" values(?,?,?,?,?,?,?,sysdate,?,?)");
		PreparedDBUtil db = new PreparedDBUtil();
		int i = 0;
		for(CircularizeBean bean:circularizeBeanList){
			String circularize_id  =  UUID.randomUUID().toString();
			db.preparedInsert(sql.toString());
			db.setString(1, circularize_id);
			db.setString(2, bean.getBusi_id());
			db.setString(3, bean.getSend_userid());
			db.setString(4, bean.getReceive_userid());
			db.setString(5, bean.getCircularize_title());
			db.setString(6, bean.getAction_form());
			db.setString(7, bean.getIns_id());
			db.setString(8, bean.getBusitype_code());
			db.setString(9, bean.getTemplate_id());
			db.addPreparedBatch();
			i++;
		}
		if(i > 0){
			db.executePreparedBatch(conn);
		}
		return true;
	}

	/**
	*<b>Summary: </b>
	* findCirularizeUserReadList( 根据参数查询,查看阅读人员信息) 
	* @param bean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return 
	 */
	public PagingBean findCirularizeUserReadList(CircularizeBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize){
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<CircularizeBean> list = new ArrayList<CircularizeBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select org.org_name, u.user_realname, u.user_mobiletel1");
		sql.append("  from oa_circularize_flow f,");
		sql.append("       td_sm_user          u,");
		sql.append("       td_sm_organization  org,");
		sql.append("       td_sm_orguser       orguser ");
		sql.append(" where  u.user_id = f.receive_userid ");
		sql.append("   and org.org_id = orguser.org_id ");
		sql.append("   and u.user_id = orguser.user_id ");
		if(!StringUtil.nullOrBlank(bean.getIns_id())){
			sql.append(" and f.ins_id='"+bean.getIns_id()+"' ");	
		}
		//查看状态
		if(!StringUtil.nullOrBlank(bean.getIs_view())){
			sql.append(" and f.is_view='"+bean.getIs_view()+"' ");	
		} else {
			sql.append(" and f.is_view is null  ");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
		try {
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.executePrepared();
			for(int i = 0 ; i < db.size() ; i++){
				CircularizeBean cBean = new CircularizeBean();
				cBean.setOrg_name(db.getString(i,"org_name"));
				cBean.setUser_realname(db.getString(i,"user_realname"));
				cBean.setPhone(db.getString(i,"user_mobiletel1"));//手机号码
				cBean.setIs_view(db.getString(i,"is_view"));//查看状态
				list.add(cBean);
			}
		} catch (SQLException e) {
			LOG.error("执行传阅列表查询报错："+e.getMessage());
		}
		 pb.setList(list);
		 pb.setRecords((long)db.getTotalSize());
		return pb;
	}
	@Override
	public boolean updateDone(String circularizeId) throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("update oa_circularize_flow t");
		sql.append("  set  t.is_done = '1' ");
		sql.append("  where t.circularize_id = ? ");
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, circularizeId);
		pdb.executePrepared();
		
		return true;
	}


}
