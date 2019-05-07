package com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.python.modules.newmodule;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.officeassets.dao.PurchaseApprovalRoolDao;
import com.chinacreator.xtbg.yimingju.officeassets.entity.PurchaseApplyBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * <p>
 * Title:PurchaseApprovalRoolDaoImpl.java
 * Description:采购申请处室审批实例类
 * Company:湖南科创
 * @author QIULIAN
 * @version 1.0 2012-11-5
 */
public class PurchaseApprovalRoolDaoImpl extends XtDbBaseDao implements PurchaseApprovalRoolDao{

	private static final Logger LOG = Logger.getLogger(PurchaseApprovalRoolDaoImpl.class);
	/**
	 * @Description 根据条件查询采购申请处室审批信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findWaitList(PurchaseApplyBean typeBeanJson, String sortName, String sortOrder, long offset, int maxPagesize){
		PagingBean pb = new PagingBean();
		PreparedDBUtil db = new PreparedDBUtil();
		List<PurchaseApplyBean> list = new ArrayList<PurchaseApplyBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select         ");
		sql.append(" p.apply_id as apply_id,     ");
		sql.append(" p.apply_title as apply_title,  ");
		sql.append(" t.user_realname as apply_userName,  ");
		sql.append(" p.apply_room as apply_room,   ");
		sql.append(" to_char(p.apply_date,'YYYY-MM-DD HH24:MI') as apply_date,   ");
		sql.append(" p.apply_remarks as apply_remarks");
		sql.append(" from ymj_oa_purchaslist p ,td_sm_user t where state in ("+typeBeanJson.getState()+") and t.user_id=p.apply_users  and  1=1 ");
		//有处室审批角色的人只能看到本处室的审批信息
		if("1".equals(typeBeanJson.getState())){
			sql.append("	and apply_room ='"+typeBeanJson.getApply_room()+"' ");
		} else {
			if (!StringUtil.nullOrBlank(typeBeanJson.getApply_room())) {
				sql.append("	and apply_room like '%"+typeBeanJson.getApply_room()+"%' ");
			}
		}
		if (!StringUtil.nullOrBlank(typeBeanJson.getApply_startdate())) {
			sql.append(" and apply_date >= to_date('").append(typeBeanJson.getApply_startdate())	.append("','yyyy-MM-dd')");
		}
		if (!StringUtil.nullOrBlank(typeBeanJson.getApply_enddate())) {
			sql.append(" and apply_date <= to_date('").append(typeBeanJson.getApply_enddate() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
		try {
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.executePrepared();
			for (int i = 0; i < db.size(); i++) {
				PurchaseApplyBean ab = new PurchaseApplyBean();
				ab.setApply_id(db.getString(i, "apply_id"));
				ab.setApply_title(db.getString(i, "apply_title"));
				ab.setApply_userName(db.getString(i,"apply_userName"));
				ab.setApply_room(db.getString(i, "apply_room"));
				ab.setApply_date(db.getString(i, "apply_date"));
				ab.setApply_remarks(db.getString(i, "apply_remarks"));
				ab.setState(db.getString(i, "state"));
				list.add(ab);
			}
		} catch (SQLException e) {
			LOG.error("执行类型列表查询报错：" + e.getMessage());
		}
		pb.setList(list);
		pb.setRecords((long) db.getTotalSize());
		return pb;
	}	
	
	
	/**
	 * @Description 根据条件查询已审批信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findAlreadyList(PurchaseApplyBean typeBeanJson, String sortName, String sortOrder, long offset, int maxPagesize){
		PagingBean pb = new PagingBean();
		PreparedDBUtil db = new PreparedDBUtil();
		List<PurchaseApplyBean> list = new ArrayList<PurchaseApplyBean>();
		StringBuffer sql = new StringBuffer();
		sql.append(" select         									 ");
		sql.append(" y.apply_id as apply_id,     						 ");
		sql.append(" y.apply_title as apply_title,  					 ");
		sql.append(" t.user_realname as apply_users, 					 ");
		sql.append(" y.apply_room as apply_room,   						 ");
		sql.append(" to_char(y.apply_date,'YYYY-MM-DD HH24:MI') as apply_date,   ");
		sql.append(" y.apply_remarks as apply_remarks,					 ");
		sql.append(" decode(y.state,'1','等待处室审批','2','处室审批通过','3','处室审批未通过','4','办公室审批通过','5','办公室审批未通过','已采购') as state ");
		sql.append(" from ymj_oa_purchaslist y,td_sm_user t where t.user_id=y.apply_users and state in ("+typeBeanJson.getState()+") and 1=1 ");
		
		//处室或者办公室
		if(!StringUtil.nullOrBlank(typeBeanJson.getDiff_type())){
			//处室审批人
			if("room".equals(typeBeanJson.getDiff_type())){
				//审批人可以看到自己审批的
				if(!StringUtil.nullOrBlank(typeBeanJson.getAndit_userId())){
					sql.append("    and andit_userid = '").append(typeBeanJson.getAndit_userId()).append("'");
				}
				//有处室审批角色的人只能看到本处室的审批信息
				if(!StringUtil.nullOrBlank(typeBeanJson.getApply_room())){
					sql.append("    and apply_room = '").append(typeBeanJson.getApply_room()).append("'");
				}
			}
			//办公室审批人
			if("office".equals(typeBeanJson.getDiff_type())){
				if(!StringUtil.nullOrBlank(typeBeanJson.getAndit_userId())){
					sql.append("    and office_andit_userid = '").append(typeBeanJson.getAndit_userId()).append("'");
				}
				if (!StringUtil.nullOrBlank(typeBeanJson.getApply_room())) {
					sql.append("	and apply_room like '%"+typeBeanJson.getApply_room()+"%' ");
				}
			}
			//办公室审批人和处室审批
			if("combine".equals(typeBeanJson.getDiff_type())){
				if(!StringUtil.nullOrBlank(typeBeanJson.getAndit_userId())){
					sql.append("    and (andit_userid = '").append(typeBeanJson.getAndit_userId()).append("' ");
					sql.append("    or office_andit_userid = '").append(typeBeanJson.getAndit_userId()).append("' )");
				}
				if (!StringUtil.nullOrBlank(typeBeanJson.getApply_room())) {
					sql.append("	and apply_room like '%"+typeBeanJson.getApply_room()+"%' ");
				}
			}
			
		} else {
			if (!StringUtil.nullOrBlank(typeBeanJson.getApply_room())) {
				sql.append("	and apply_room like '%"+typeBeanJson.getApply_room()+"%' ");
			}
		}
		
		if (!StringUtil.nullOrBlank(typeBeanJson.getApply_startdate())) {
			sql.append(" and apply_date >= to_date('").append(typeBeanJson.getApply_startdate())	.append("','yyyy-MM-dd')");
		}
		if (!StringUtil.nullOrBlank(typeBeanJson.getApply_enddate())) {
			sql.append(" and apply_date <= to_date('").append(typeBeanJson.getApply_enddate() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
		try {
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.executePrepared();
			for (int i = 0; i < db.size(); i++) {
				PurchaseApplyBean ab = new PurchaseApplyBean();
				ab.setApply_id(db.getString(i, "apply_id"));
				ab.setApply_title(db.getString(i, "apply_title"));
				ab.setApply_room(db.getString(i, "apply_room"));
				ab.setApply_userName(db.getString(i,"apply_users"));
				ab.setApply_date(db.getString(i, "apply_date"));
				ab.setApply_remarks(db.getString(i, "apply_remarks"));
				ab.setState(db.getString(i, "state"));
				list.add(ab);
			}
		} catch (SQLException e) {
			LOG.error("执行类型列表查询报错：" + e.getMessage());
		}
		pb.setList(list);
		pb.setRecords((long) db.getTotalSize());
		return pb;
	}
	
	/**
	 * @Description 根据条件查询已采购的清单
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findDetailAlreadList(PurchaseApplyBean typeBeanJson, String sortName, String sortOrder, long offset, int maxPagesize){
		PagingBean pb = new PagingBean();
		PreparedDBUtil db = new PreparedDBUtil();
		List<PurchaseApplyBean> list = new ArrayList<PurchaseApplyBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select         ");
		sql.append(" p.apply_id as apply_id,                             ");
		sql.append(" p.apply_title as apply_title,                       ");
		sql.append(" t.user_realname as apply_userName,                  ");
		sql.append(" p.apply_room as apply_room,                         ");
		sql.append(" to_char(p.apply_date,'YYYY-MM-DD HH24:MI') as apply_date,   ");
		sql.append(" p.apply_remarks as apply_remarks,					 ");
		sql.append(" to_char(p.detail_date,'YYYY-MM-DD HH24:MI') as detail_date	  ");
		sql.append(" from ymj_oa_purchaslist p ,td_sm_user t where state='"+typeBeanJson.getState()+"' and t.user_id=p.apply_users  and  1=1 ");
		if (!StringUtil.nullOrBlank(typeBeanJson.getApply_room())) {
			sql.append("	and apply_room like '%"+typeBeanJson.getApply_room()+"%' ");
		}
		if (!StringUtil.nullOrBlank(typeBeanJson.getApply_startdate())) {
			sql.append(" and apply_date >= to_date('").append(typeBeanJson.getApply_startdate())	.append("','yyyy-MM-dd')");
		}
		if (!StringUtil.nullOrBlank(typeBeanJson.getApply_enddate())) {
			sql.append(" and apply_date <= to_date('").append(typeBeanJson.getApply_enddate() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
		try {
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.executePrepared();
			for (int i = 0; i < db.size(); i++) {
				PurchaseApplyBean ab = new PurchaseApplyBean();
				ab.setApply_id(db.getString(i, "apply_id"));
				ab.setApply_title(db.getString(i, "apply_title"));
				ab.setApply_userName(db.getString(i,"apply_userName"));
				ab.setApply_room(db.getString(i, "apply_room"));
				ab.setApply_date(db.getString(i, "apply_date"));
				ab.setApply_remarks(db.getString(i, "apply_remarks"));
				ab.setState(db.getString(i, "state"));
				ab.setDetail_date(db.getString(i, "detail_date"));
				list.add(ab);
			}
		} catch (SQLException e) {
			LOG.error("执行类型列表查询报错：" + e.getMessage());
		}
		pb.setList(list);
		pb.setRecords((long) db.getTotalSize());
		return pb;
	}


	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryGoods
	  * @return 
	  * @see com.chinacreator.xtbg.yimingju.officeassets.dao.PurchaseApprovalRoolDao#queryGoods()
	 */
	public List<Map<String, String>> queryGoods() throws Exception{
		PreparedDBUtil pdb = new PreparedDBUtil();
		List<String> values= new ArrayList<String>();
		StringBuffer sql = new StringBuffer();
		sql.append(" select g.* from ymj_oa_office_goods g,ymj_oa_purchaslist p ");
		sql.append(" where g.apply_id= p.apply_id and p.state='6'");
		return queryToListMap(sql.toString(), values);
	}


	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 querykc
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.yimingju.officeassets.dao.PurchaseApprovalRoolDao#querykc()
	 */
	public String querykc(String id,String num) throws Exception {
		List<String> values= new ArrayList<String>();
		StringBuffer sql = new StringBuffer();
		sql.append(" select * from ymj_oa_office_goods t");
		sql.append(" where t.goods_id= "+id);
		List<Map<String, String>> listmap=queryToListMap(sql.toString(), values);
		String str="";
		if(Integer.parseInt(num) >Integer.parseInt(listmap.get(0).get("goods_rcount"))){
			 str=listmap.get(0).get("goods_name")+":库存不足";
		}
		return str;
	}

}
