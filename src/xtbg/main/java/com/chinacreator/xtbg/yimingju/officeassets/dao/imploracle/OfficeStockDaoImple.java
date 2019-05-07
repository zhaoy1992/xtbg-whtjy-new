package com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle;

import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.transaction.RollbackException;

import org.apache.log4j.Logger;

import com.chinacreator.business.common.tools.CacheCommonManage;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DaoUtil;
import com.chinacreator.xtbg.pub.util.DateUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.officeassets.dao.OfficeStockDao;
import com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeStock;
import com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeStocklistBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
import com.frameworkset.orm.transaction.TransactionManager;

/**
 * <p>
 * Title:OfficeStockDaoImple.java
 * Description:办公室库存实例类
 * Company:湖南科创
 * @author QIULIAN
 * @version 1.0 2012-11-5
 */
public class OfficeStockDaoImple implements OfficeStockDao{
	private static final Logger LOG = Logger
			.getLogger(OfficeStockDaoImple.class);
	/**
	 * @Description 根据条件查询公告信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findTypeList(OfficeStock officeStock, String sortName, String sortOrder, long offset, int maxPagesize){
		String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");//421003贸促会
		PagingBean pb = new PagingBean();
		PreparedDBUtil db = new PreparedDBUtil();
		List<OfficeStock> list = new ArrayList<OfficeStock>();
		StringBuffer sql = new StringBuffer();
		sql.append(" select         ");
		sql.append(" y.stock_id as stock_id,     ");
		sql.append(" users.user_realname as user_realname,  ");
		sql.append(" to_char(y.stock_data,'YYYY-MM-DD') as stock_data,   ");
		sql.append(" y.type_id as type_id,   ");
		sql.append(" type.oetype_name as type_name,   ");
		sql.append(" y.eq_name as eq_name,");
		sql.append(" y.eq_no as eq_no,");
		sql.append(" y.eq_model as eq_model,");
		sql.append(" y.eq_price as eq_price,");
		sql.append(" y.suppliers as suppliers,");
		sql.append(" y.eq_phone as service_phone,");
		sql.append(" y.remark as remark,");
		sql.append(" type.oetype_no as oetype_no ,");
		sql.append(" decode(y.state,'1','在库','2','出库','3','报废') as state ");
		if(("421003").equals(userArea)){
			sql.append(" from ymj_oa_officeeqstock y left join td_sm_user users  on users.user_id= y.stock_applyer left join ymj_oa_office_equipmenttype type on type.oetype_id= y.type_id  ");
			sql.append(" where    1=1 ");
		}else{
			sql.append(" from ymj_oa_officeeqstock y ,td_sm_user users  ,ymj_oa_office_equipmenttype type ");
			sql.append(" where type.oetype_id= y.type_id and users.user_id= y.stock_applyer and 1=1 ");
		}
		//状态
		if (!StringUtil.nullOrBlank(officeStock.getState())) {
			if (" ".equals(officeStock.getState())) { // 全部

			} else if ("1".equals(officeStock.getState())) {// 在库
				sql.append(" and state ='1' ");
			} else if ("2".equals(officeStock.getState())) {// 出库
				sql.append("  and state ='2' ");
			} else if ("3".equals(officeStock.getState())) {// 报废
				sql.append("  and state ='3' ");
			} 
		}
	
		//设备名称
		if (!StringUtil.nullOrBlank(officeStock.getEquipment_name())) {
			sql.append("	and eq_name like '%"+officeStock.getEquipment_name()+"%' ");
		}
		//设备编号
		if (!StringUtil.nullOrBlank(officeStock.getEquipment_no())) {
			sql.append("	and eq_no like '%"+officeStock.getEquipment_no()+"%' ");
		}
		//设备型号
		if (!StringUtil.nullOrBlank(officeStock.getEquipment_model())) {
			sql.append("	and eq_model like '%"+officeStock.getEquipment_model()+"%' ");
		}
		//供货厂商
		if (!StringUtil.nullOrBlank(officeStock.getSuppliers())) {
			sql.append("	and suppliers like '%"+officeStock.getSuppliers()+"%' ");
		}
		//类别
		if (!StringUtil.nullOrBlank(officeStock.getType_id())) {
			sql.append("	and type_id = '"+officeStock.getType_id()+"' ");
		}
		//入库时间
		if (!StringUtil.nullOrBlank(officeStock.getStock_startTime())) {
			sql.append(" and stock_data >= to_date('")
					.append(officeStock.getStock_startTime())
					.append("','yyyy-MM-dd')");
		}
		if (!StringUtil.nullOrBlank(officeStock.getStock_endTime())) {
			sql.append(" and stock_data <= to_date('")
					.append(officeStock.getStock_endTime() + "23:59:59")
					.append("','yyyy-MM-dd hh24:mi:ss')");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
		try {
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.executePrepared();
			for (int i = 0; i < db.size(); i++) {
				OfficeStock ab = new OfficeStock();
				ab.setStock_id(db.getString(i,"stock_id"));
				ab.setStock_applyerName(db.getString(i,"user_realname"));
				ab.setType_id(db.getString(i, "type_id"));
				ab.setStock_data(db.getString(i,"stock_data"));
				ab.setSuppliers(db.getString(i,"suppliers"));
				ab.setType_name(db.getString(i, "type_name"));
				ab.setEquipment_name(db.getString(i,"eq_name"));
				ab.setEquipment_no(db.getString(i,"eq_no"));
				ab.setEquipment_model(db.getString(i,"eq_model"));
				ab.setEquipment_price(db.getString(i,"eq_price"));
				ab.setService_phone(db.getString(i,"service_phone"));
				ab.setRemark(db.getString(i,"remark"));
				ab.setState(db.getString(i, "state"));
				list.add(ab);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.error("执行类型列表查询报错：" + e.getMessage());
		}
		pb.setList(list);
		pb.setRecords((long) db.getTotalSize());
		return pb;
	}
	
	/**
	 * @Description 添加库存信息
	 * @param typeBean 类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void addOe(List<OfficeStock> officeStocks) throws Exception {
		TransactionManager tm = new TransactionManager();
		String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
		Set<String> set=new HashSet<String>();
		tm.begin();
		//库存
		StringBuffer buf = new StringBuffer();
		buf.append(" insert into ymj_oa_officeeqstock");
		buf.append(" (stock_id, stock_applyer, stock_data,remark,state,type_id,type_name,eq_name,eq_no,eq_model,eq_price,suppliers,eq_phone,collar_state)");
		buf.append(" values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		//库存明细
		StringBuffer buffer  = new StringBuffer();
		buffer.append(" insert into ymj_oa_officestocklist ");
		buffer.append(" (ty_id,collar_name,action_name,action,ty_name,eq_no,eq_name,s_date,id,STOCK_ID)");
		buffer.append(" values (?,?,?,?,?,?,?,?,SEQ_OFFICESTOCK.NEXTVAL,?)");
		//修改采购物品实际数量
		StringBuffer goodssql  = new StringBuffer();
		goodssql.append(" update ymj_oa_office_goods g set g.goods_rcount=(g.goods_rcount- ? ) ");
		goodssql.append(" where g.goods_id= ? ");
		for (int i = 0; i < officeStocks.size(); i++) {
			set.add(officeStocks.get(i).getGoodsid());
		}
		String[] goodsid=set.toArray(new String[0]);
		Map<String,String> map=new HashMap<String,String>();
		//入库类型数量map
		if("410003".equals(userArea)) {
			for(int j=0;j<goodsid.length;j++){
				int m=0;
				for(int k=0;k<officeStocks.size();k++){
					if(goodsid[j].equals(officeStocks.get(k).getGoodsid())){
						m++;
					}
				}
				map.put(goodsid[j], String.valueOf(m));
			}
		}
		try{
			PreparedDBUtil db = new PreparedDBUtil();
			for(int i=0;i<officeStocks.size();i++){
				String purchasId = DaoUtil.findBySequencsName("SEQ_OFFICESTOCK");
				db.preparedInsert(buf.toString());
				//库存
				OfficeStock officeStock= (OfficeStock)officeStocks.get(i);
				db.setString(1, purchasId);
				db.setString(2, officeStock.getStock_applyer());
				db.setDate(3, DateUtil.parseTimeStringFull(DateUtil.getCurrentDateTime()));
				db.setString(4, officeStock.getRemark());
				db.setString(5, officeStock.getState());
				db.setString(6, officeStock.getType_id());
				db.setString(7, officeStock.getType_name());
				db.setString(8, officeStock.getEquipment_name());
				db.setString(9, officeStock.getEquipment_no());
				db.setString(10, officeStock.getEquipment_model());
				db.setString(11, officeStock.getEquipment_price());
				db.setString(12, officeStock.getSuppliers());
				db.setString(13, officeStock.getService_phone());
				db.setString(14, officeStock.getState());
				db.addPreparedBatch();
				
				//库存明细
				db.preparedInsert(buffer.toString());
				db.setString(1, officeStock.getType_id());
				db.setString(2, officeStock.getCollar_userName());
				db.setString(3, officeStock.getAction_name());
				db.setString(4, officeStock.getAction());
				db.setString(5, officeStock.getType_name());
				db.setString(6, officeStock.getEquipment_no());
				db.setString(7, officeStock.getEquipment_name());
				db.setDate(8, DateUtil.parseTimeStringFull(DateUtil.getCurrentDateTime()));
				db.setString(9, purchasId);
				db.addPreparedBatch();
				
			}
			//修改采购物品实际数量
			if("410003".equals(userArea)) {
				for (String key : map.keySet()) {
					db.preparedUpdate(goodssql.toString());
					db.setInt(1, Integer.parseInt(map.get(key)));
					db.setString(2, key);
					db.addPreparedBatch();
				}
			}	
			db.executePreparedBatch();
			tm.commit();
		} catch(Exception e){
			tm.rollback();
			throw e;
		}
 	}
	
	/**
	 * @Description 根据用户ID获得设备库存信息
	 * @param typeBean 设备库存信息Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public OfficeStock getTypeBeanById(String id) throws SQLException{
		StringBuffer buf = new StringBuffer();
		buf.append("select");
		buf.append("  t.eq_name as eq_name,          ");
		buf.append("  t.eq_no as eq_no,              ");
		buf.append("  t.type_id as type_id,          ");
		buf.append("  t.type_name as type_name,      ");
		buf.append("  u.user_realname as user_realname");
		buf.append("  from ymj_oa_officeeqstock t, td_sm_user u ");
		buf.append("   where t.stock_applyer = u.user_id ");
		buf.append("         and t.stock_id=?  ");
		PreparedDBUtil db = new PreparedDBUtil();
		OfficeStock ab = new OfficeStock();
		db.preparedSelect(buf.toString()); 
		db.setString(1, id);
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {  
			ab.setEquipment_name(db.getString(i, "eq_name"));
			ab.setEquipment_no(db.getString(i, "eq_no"));
			ab.setType_id(db.getString(i, "type_id"));
			ab.setType_name(db.getString(i, "type_name"));
			ab.setCollar_userName(db.getString(i, "user_realname"));
		}
		return ab;
	}
	
	
	/**
	 * @Description 查找库存明细信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findAllEqList(OfficeStocklistBean officeStocklistBean, String sortName, String sortOrder, long offset, int maxPagesize){
		
		PagingBean pb = new PagingBean();
		PreparedDBUtil db = new PreparedDBUtil();
		List<OfficeStocklistBean> list = new ArrayList<OfficeStocklistBean>();
		StringBuffer sql = new StringBuffer();
		sql.append(" select         						 ");
		sql.append("    t.id as id,    					     ");
		sql.append("    to_char(t.s_date, 'yyyy-mm-dd') as s_date,   ");
		sql.append("    t.eq_name as eq_name,  				 ");
		sql.append("    t.eq_no as eq_no,   				 ");
		sql.append("    t.ty_name as type_name, 			 ");
		sql.append("    t.action as action,					 ");
		sql.append("    t.action_name as action_name,		 ");
		sql.append("    t.collar_name as collar_name,		 ");
		sql.append("    t.ty_id as ty_id,  					 ");
		sql.append("    type.oetype_no as oetype_no  			 ");
		sql.append("  from ymj_oa_officestocklist t,ymj_oa_office_equipmenttype type   ");
		sql.append(" where t.ty_id = type.oetype_id  and 1=1 ");
	
		//设备名称
		if (!StringUtil.nullOrBlank(officeStocklistBean.getEq_name())) {
			sql.append("	and eq_name like '%"+officeStocklistBean.getEq_name()+"%' ");
		}
		//库存ID
		if (!StringUtil.nullOrBlank(officeStocklistBean.getStock_Id())) {
			sql.append("	and stock_id = '"+officeStocklistBean.getStock_Id()+"' ");
		}
		//时间
		if (!StringUtil.nullOrBlank(officeStocklistBean.getStart_time())) {
			sql.append(" and s_date >= to_date('").append(officeStocklistBean.getStart_time()).append("','yyyy-MM-dd')");
		}
		if (!StringUtil.nullOrBlank(officeStocklistBean.getEnd_time())) {
			sql.append(" and s_date <= to_date('").append(officeStocklistBean.getEnd_time() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
		try {
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.executePrepared();
			for (int i = 0; i < db.size(); i++) {
				OfficeStocklistBean ab = new OfficeStocklistBean();
				ab.setId(db.getString(i,"id"));
				ab.setTy_name(db.getString(i,"type_name"));
				ab.setS_date(db.getString(i, "s_date"));
				ab.setEq_name(db.getString(i,"eq_name"));
				ab.setEq_no(db.getString(i,"eq_no"));
				ab.setAction(db.getString(i, "action"));
				ab.setAction_name(db.getString(i,"action_name"));
				ab.setCollar_name(db.getString(i,"collar_name"));
				ab.setTy_id(db.getString(i,"ty_id"));
				list.add(ab);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.error("执行类型列表查询报错：" + e.getMessage());
		}
		pb.setList(list);
		pb.setRecords((long) db.getTotalSize());
		return pb;
	}
	
	/**
	 * @Description 添加库存明细信息
	 * @param typeBean 类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void addOfficeList(OfficeStocklistBean officeStocklistBean) throws SQLException {
		StringBuffer buf = new StringBuffer();
		java.sql.Date stcoDate= Date.valueOf(officeStocklistBean.getS_date());
		buf.append(" insert into ymj_oa_officestocklist ");
		buf.append(" (ty_id,collar_name,action_name,action,ty_name,eq_no,eq_name,s_date,id,STOCK_ID)");
		buf.append(" values (?,?,?,?,?,?,?,?,SEQ_OFFICESTOCK.NEXTVAL,?)");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedInsert(buf.toString());
		db.setString(1, officeStocklistBean.getType_id());
		db.setString(2, officeStocklistBean.getCollar_name());
		db.setString(3, officeStocklistBean.getAction_name());
		db.setString(4, officeStocklistBean.getAction());
		db.setString(5, officeStocklistBean.getTy_name());
		db.setString(6, officeStocklistBean.getEq_no());
		db.setString(7, officeStocklistBean.getEq_name());
		db.setDate(8, stcoDate);
		db.setString(9, officeStocklistBean.getStock_Id());
		db.executePrepared();
	}
	
	/**
	 * @Description  删除办公设备库存信息
	 * @param userIds
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean delEqStock(String userIds) throws SQLException{
		TransactionManager tm = new TransactionManager();
		//删除设备领用信息
		String sqlCollar = "delete from ymj_oa_office_equipmentapply where stockeq_id in ("+ userIds + ")";
		//删除设备库存详细表信息
		String sqlList = "delete from ymj_oa_officestocklist where stock_id in ("+ userIds + ")";
		//删除设备库存信息
		String sqlStock = "delete from ymj_oa_officeeqstock where stock_id in ("+ userIds + ")";
		PreparedDBUtil db = new PreparedDBUtil();
		try{
			tm.begin();
			db.executeDelete(sqlCollar);
			db.executeDelete(sqlList);
			db.executeDelete(sqlStock);
			tm.commit();
		}catch(SQLException e){
			LOG.error("删除报错：" + e.getMessage());
			try {
				tm.rollback();
			} catch (RollbackException e1) {
			}
			throw e;
		}catch(Exception e){
			LOG.error("删除报错：" + e.getMessage());
			try {
				tm.rollback();
			} catch (RollbackException e1) {
			}
			return false;
		}
		return true;
	}
	
}
