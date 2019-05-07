package com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.chinacreator.business.common.tools.CacheCommonManage;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DaoUtil;
import com.chinacreator.xtbg.pub.util.DateUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.officeassets.dao.PurchaseApplyDao;
import com.chinacreator.xtbg.yimingju.officeassets.entity.OrderGoods;
import com.chinacreator.xtbg.yimingju.officeassets.entity.PurchaseApplyBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
import com.frameworkset.orm.transaction.TransactionManager;

/**
 * <p>
 * Title:PurchaseApplyDaoImpl.java
 * </p>
 * <p>
 * Description:采购申请信息实例类
 * </p>
 * <p>
 * Company:湖南科创
 * </p>
 * 
 * @author QIULIAN
 * @version 1.0 2012-11-5
 */
public class PurchaseApplyDaoImpl implements PurchaseApplyDao {

	private static final Logger LOG = Logger
			.getLogger(PurchaseApplyDaoImpl.class);

	/**
	 * @Description 查询类型列表
	 * 
	 * @param ScheduleCanViewBean
	 *            //查询参数
	 * @param sortName
	 *            //排序字段
	 * @param sortOrder
	 *            //排序方式
	 * @param offset
	 *            //从第几天开始
	 * @param maxPagesize
	 *            //当前页数
	 * @return List
	 * @exception
	 */

	public PagingBean findTypeList(PurchaseApplyBean typeBean, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil db = new PreparedDBUtil();
		List<PurchaseApplyBean> list = new ArrayList<PurchaseApplyBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select         ");
		sql.append(" apply_id,     ");
		sql.append(" apply_title,  ");
		sql.append(" apply_room,   ");
		sql.append(" to_char(apply_date,'YYYY-MM-DD HH24:MI') as apply_date,   ");
		sql.append(" apply_remarks,");
		sql.append(" decode(state,'1','等待处室审批','2','处室审批通过','3','处室审批未通过','4','办公室审批通过','5','办公室审批未通过','已采购') as state ");
		sql.append(" from ymj_oa_purchaslist where 1=1 ");
		sql.append(" and apply_users = '"+typeBean.getApply_users()+"' ");
		if (!StringUtil.nullOrBlank(typeBean.getState())) {
			if ("1".equals(typeBean.getState())) { // 等待处室审批
				sql.append(" and state ='1' ");
			} else if ("2".equals(typeBean.getState())) {// 处室审批通过
				sql.append(" and state ='2' ");
			} else if ("3".equals(typeBean.getState())) {// 处室审批不通过
				sql.append("  and state ='3' ");
			} else if ("4".equals(typeBean.getState())) {// 办公室审批通过
				sql.append("  and state ='4' ");
			} else if ("5".equals(typeBean.getState())) {// 办公室审批不通过
				sql.append("  and state ='5' ");
			} else { // 已采购
				sql.append("  and state ='6' ");
			}
		}
		if (!StringUtil.nullOrBlank(typeBean.getApply_room())) {
			sql.append(" and apply_room like  '%"+typeBean.getApply_room()+"%'");
		}
		if (!StringUtil.nullOrBlank(typeBean.getApply_startdate())) {
			sql.append(" and apply_date >= to_date('")
					.append(typeBean.getApply_startdate())
					.append("','yyyy-MM-dd')");
		}
		if (!StringUtil.nullOrBlank(typeBean.getApply_enddate())) {
			sql.append(" and apply_date <= to_date('")
					.append(typeBean.getApply_enddate() + "23:59:59")
					.append("','yyyy-MM-dd hh24:mi:ss')");
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
	 * @Description 添加采购申请信息
	 * @param typeBean
	 *            类型Bean
	 * @return boolean
	 * @throws SQLException
	 */
	public void addOe(PurchaseApplyBean oeBean, ArrayList<OrderGoods> orders)
			throws Exception {
		TransactionManager tm = new TransactionManager();
		String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
		tm.begin();
		StringBuffer buf = new StringBuffer();
		try{
			String purchasId = DaoUtil
					.findBySequencsName("SEQ_OFFICESTOCK");
			// 采购申请
			buf.append(" insert into ymj_oa_purchaslist");
			buf.append("(apply_id, apply_title, apply_room,apply_date,apply_remarks,state,apply_users,apply_userroles)");
			buf.append("values(?,?,?,to_date('" + oeBean.getApply_date()
					+ "','yyyy-MM-dd HH24:mi'),?,?,?,?)");
			PreparedDBUtil db = new PreparedDBUtil();
			db.preparedInsert(buf.toString());
			db.setString(1, purchasId);
			db.setString(2, oeBean.getApply_title());
			db.setString(3, oeBean.getApply_room());
			db.setString(4, oeBean.getApply_remarks());
			db.setString(5, oeBean.getState());// 等待处室审批
			db.setString(6, oeBean.getApply_users());
			db.setString(7, oeBean.getApply_UserRoles());
			db.executePrepared();
			// 物品列表
			StringBuffer sb =  new StringBuffer();
			sb.append("insert into ymj_oa_office_goods ");
			if("410003".equals(userArea)) {
				sb.append("(goods_id,apply_id,goods_name,goods_unit,goods_count,goods_price,goods_rcount) ");
				sb.append("values(SEQ_OFFICEEQUIPMENTTYPE.nextval,?,?,?,?,?,?) ");
			}else {
				sb.append("(goods_id,apply_id,goods_name,goods_unit,goods_count,goods_price) ");
				sb.append("values(SEQ_OFFICEEQUIPMENTTYPE.nextval,?,?,?,?,?) ");
			}
			PreparedDBUtil db1 = new PreparedDBUtil();
			for (int i = 0; i < orders.size(); i++) {
				OrderGoods goods = (OrderGoods) orders.get(i);
				db1.preparedInsert(sb.toString());
				db1.setString(1, purchasId);
				db1.setString(2, goods.getGoods_name());
				db1.setString(3, goods.getGoods_unit());
				db1.setString(4, goods.getGoods_count());
				if(StringUtils.isEmpty(goods.getGoods_price())){
					db1.setDouble(5, 0);
				} else {
					db1.setDouble(5, Double.valueOf(goods.getGoods_price()));
				}
				if("410003".equals(userArea)) {
					db1.setString(6, goods.getGoods_rcount());
				}
				db1.addPreparedBatch();
			}
			db1.executePreparedBatch();
			tm.commit();
		}catch(Exception e){
			tm.rollback();
			throw e;
		}
	}

	/**
	 * @Description 修改采购申请信息
	 * @param typeBean
	 *            类型Bean
	 * @return boolean
	 * @throws SQLException
	 */
	public void updateType(PurchaseApplyBean oeBean,
			ArrayList<OrderGoods> orders) throws SQLException,Exception {
		
		TransactionManager tm = new TransactionManager();
		tm.begin();
		StringBuffer buf = new StringBuffer();
		try{
			// 采购
			buf.append(" update ymj_oa_purchaslist  ");
			buf.append(" set apply_title  = ?,      ");
			buf.append("     apply_room   = ?,      ");
			buf.append("     apply_remarks = ?,   	");
			buf.append("     state = ?,   		 	");
			buf.append("     office_opinion = ?,  	");
			buf.append("     office_date = ?,   	");
			buf.append("     room_opinion = ?,    	");
			buf.append("     room_date = ?,   	 	");
			buf.append("     detail_date = ?,   	");
			buf.append("     andit_userid = ?,   	");
			buf.append("     office_andit_userid = ?,  ");
			buf.append("     apply_date= ?  ");
			buf.append("  where apply_id=?   	    ");
			PreparedDBUtil db = new PreparedDBUtil();
			db.preparedUpdate(buf.toString());
			db.setString(1, oeBean.getApply_title());
			db.setString(2, oeBean.getApply_room());
			db.setString(3, oeBean.getApply_remarks());
			db.setString(4, oeBean.getState());
			db.setString(5, oeBean.getOffice_opinion());
			if(oeBean.getOffice_date()==null){
				db.setTimestamp(6, null);
			} else {
				db.setTimestamp(6, DateUtil.parseTimeStringFull(oeBean.getOffice_date()));
			}
			db.setString(7, oeBean.getRoom_opinion());
			if(oeBean.getRoom_date() == null){
				db.setTimestamp(8,null);
			} else {
				db.setTimestamp(8,DateUtil.parseTimeStringFull(oeBean.getRoom_date()));
			}
			if(oeBean.getDetail_date() == null){
				db.setTimestamp(9,null);
			}else {
				db.setTimestamp(9,DateUtil.parseTimeStringFull(oeBean.getDetail_date()));
			}
			db.setString(10,oeBean.getAndit_userId());
			db.setString(11,oeBean.getOffice_andit_userId());
			db.setTimestamp(12,DateUtil.parseTimeStringWithFormatStr(oeBean.getApply_date(),"yyyy-MM-dd HH:mm"));
			db.setString(13, oeBean.getApply_id());
			db.executePrepared();
	
			// 物品信息
			PreparedDBUtil db1 = new PreparedDBUtil();
			StringBuffer buf1 = new StringBuffer();
			buf1.append("insert into ymj_oa_office_goods");
			buf1.append("(goods_id,apply_id,goods_name,goods_unit,goods_count,goods_price)");
			buf1.append("values(SEQ_OFFICEEQUIPMENTTYPE.nextval,?,?,?,?,?)");
			for (int i = 0; i < orders.size(); i++) {
				OrderGoods orderGoods = (OrderGoods) orders.get(i);
				db1.preparedInsert(buf1.toString());
				db1.setString(1, orderGoods.getApply_id());
				db1.setString(2, orderGoods.getGoods_name());
				db1.setString(3, orderGoods.getGoods_unit());
				db1.setString(4, orderGoods.getGoods_count());
				if(StringUtils.isEmpty(orderGoods.getGoods_price())){
					db1.setDouble(5, 0);
				} else {
					db1.setDouble(5, Double.valueOf(orderGoods.getGoods_price()));
				}
				db1.addPreparedBatch();
			}
			db1.executePreparedBatch();
			tm.commit();
		}catch(Exception e){
			tm.rollback();
			throw e;
		}
	}

	/**
	 * @Description 删除采购申请信息
	 * @param userIds
	 * @return boolean
	 * @throws SQLException
	 */
	public boolean delType(String userIds) throws SQLException {
		String sql = "delete from ymj_oa_purchaslist where apply_id in ("
				+ userIds + ")";
		PreparedDBUtil db = new PreparedDBUtil();
		db.executeDelete(sql);
		return true;
	}

	/**
	 * @Description 根据类型ID获得类型信息
	 * @param typeBean
	 *            类型Bean
	 * @return boolean
	 * @throws SQLException
	 */
	public PurchaseApplyBean getTypeBeanById(String id) throws SQLException {
		StringBuffer buf = new StringBuffer();
		buf.append("select");
		buf.append(" apply_id,     ");
		buf.append(" apply_title,  ");
		buf.append(" apply_room,   ");
		buf.append(" to_char(apply_date,'yyyy-mm-dd hh24:mi') as apply_date,   ");
		buf.append(" apply_remarks,");
		buf.append(" state ,");
		buf.append(" room_opinion ,");
		buf.append(" room_date ,");
		buf.append(" office_opinion ,");
		buf.append(" andit_userid ,");
		buf.append(" office_date,   ");
		buf.append(" apply_userroles   ");
		buf.append(" from ymj_oa_purchaslist where apply_id=? ");
		PreparedDBUtil db = new PreparedDBUtil();
		PurchaseApplyBean ab = new PurchaseApplyBean();
		db.preparedSelect(buf.toString());
		db.setString(1, id);
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {
			ab.setApply_id(db.getString(i, "apply_id"));
			ab.setApply_title(db.getString(i, "apply_title"));
			ab.setApply_room(db.getString(i, "apply_room"));
			ab.setApply_date(db.getString(i, "apply_date"));
			ab.setApply_remarks(db.getString(i, "apply_remarks"));
			ab.setState(db.getString(i, "state"));
			ab.setAndit_userId(db.getString(i,"andit_userid"));
			ab.setRoom_opinion(db.getString(i ,"room_opinion"));
			ab.setRoom_date(DateUtil.GetTimeStringFull(db.getTimestamp(i ,"room_date")));
			ab.setOffice_opinion(db.getString(i ,"office_opinion"));
			ab.setOffice_date(DateUtil.GetTimeStringFull(db.getTimestamp(i ,"office_date")));
			ab.setApply_UserRoles(db.getString(i,"apply_userroles"));
		}
		return ab;
	}

	/**
	 * @Description 根据类型ID获得类型信息
	 * @param typeBean
	 *            类型Bean
	 * @return boolean
	 * @throws SQLException
	 */
	public ArrayList<OrderGoods> getGoodsBeanById(String id)
			throws SQLException {
		StringBuffer buf = new StringBuffer();
		buf.append(" select        ");
		buf.append(" goods_id,     ");
		buf.append(" apply_id,     ");
		buf.append(" goods_name,   ");
		buf.append(" goods_unit,   ");
		buf.append(" goods_count,  ");
		buf.append(" goods_price   ");
		buf.append(" from ymj_oa_office_goods where apply_id=? ");
		PreparedDBUtil db = new PreparedDBUtil();
		ArrayList<OrderGoods> ab = new ArrayList<OrderGoods>();
		db.preparedSelect(buf.toString());
		db.setString(1, id);
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {
			OrderGoods goods = new OrderGoods();
			goods.setGoods_id(db.getString(i, "goods_id"));
			goods.setApply_id(db.getString(i, "apply_id"));
			goods.setGoods_name(db.getString(i, "goods_name"));
			goods.setGoods_unit(db.getString(i, "goods_unit"));
			goods.setGoods_count(db.getString(i, "goods_count"));
			goods.setGoods_price(db.getString(i, "goods_price"));
			ab.add(goods);
		}
		return ab;
	}

	/**
	 * @Description 根据物品信息获得类型信息
	 * @param typeBean
	 *            类型Bean
	 * @return boolean
	 * @throws SQLException
	 */
	public OrderGoods getGoodsBeanById(String id, String goodId)
			throws SQLException {
		StringBuffer buf = new StringBuffer();
		buf.append(" select        ");
		buf.append(" goods_id,     ");
		buf.append(" apply_id,     ");
		buf.append(" goods_name,   ");
		buf.append(" goods_unit,   ");
		buf.append(" goods_count,   ");
		buf.append(" goods_price   ");
		buf.append(" from ymj_oa_office_goods where apply_id=? and goods_id=?");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(buf.toString());
		db.setString(1, id);
		db.setString(2, goodId);
		db.executePrepared();
		OrderGoods goods = null;
		for (int i = 0; i < db.size(); i++) {
			goods = new OrderGoods();
			goods.setGoods_id(db.getString(i, "goods_id"));
			goods.setApply_id(db.getString(i, "apply_id"));
			goods.setGoods_name(db.getString(i, "goods_name"));
			goods.setGoods_unit(db.getString(i, "goods_unit"));
			goods.setGoods_count(db.getString(i, "goods_count"));
			goods.setGoods_price(db.getString(i, "goods_price"));
		}
		return goods;
	}

	/**
	 * @Description 删除物品信息获得类型信息
	 * @param typeBean
	 *            类型Bean
	 * @return boolean
	 * @throws SQLException
	 */
	public void deleteGoods(String id) throws SQLException {
		StringBuffer buf = new StringBuffer();
		buf.append(" delete from  ymj_oa_office_goods ");
		buf.append(" where apply_id ='" + id + "' ");
		PreparedDBUtil db = new PreparedDBUtil();
		db.executeDelete(buf.toString());

	}
	
	/**
	  * <b>Summary: </b>
	  *     复写方法 setDetailApproval
	  * @param oeBean
	  * @param orders
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.yimingju.officeassets.dao.PurchaseApplyDao#setDetailApproval(com.chinacreator.xtbg.yimingju.officeassets.entity.PurchaseApplyBean, java.util.ArrayList)
	 */
	public void setDetailApproval(PurchaseApplyBean oeBean,ArrayList<OrderGoods> orders) throws SQLException,Exception{
		StringBuffer buf = new StringBuffer();
		TransactionManager tm = new TransactionManager();
		try{
			tm.begin();
			// 采购完成
			buf.append(" update ymj_oa_purchaslist ");
			buf.append(" set state=?, ");
			buf.append(" detail_date= sysdate ");
			buf.append(" where apply_id=?   ");
			PreparedDBUtil db = new PreparedDBUtil();
			db.preparedUpdate(buf.toString());
			db.setString(1, oeBean.getState());
			db.setString(2, oeBean.getApply_id());
			db.executePrepared();
			
			// 物品信息
			PreparedDBUtil db1 = new PreparedDBUtil();
			//物品列表价格信息修改
			for (int i = 0; i < orders.size(); i++) {
				
				StringBuffer buf1 = new StringBuffer();
				buf1.append("update ymj_oa_office_goods");
				buf1.append(" set goods_price = ? ");
				buf1.append("where goods_id = ? and apply_id =? ");
				db1.preparedUpdate(buf1.toString());
				OrderGoods orderGoods = (OrderGoods) orders.get(i);
				db1.setDouble(1, Double.valueOf(orderGoods.getGoods_price()));
				db1.setString(2, orderGoods.getGoods_id());
				db1.setString(3, orderGoods.getApply_id());
				
				db1.addPreparedBatch();
			}
			db1.executePreparedBatch();
			tm.commit();
		}  catch(Exception e1){
			tm.rollback();
			throw e1;
		}
	}

}
