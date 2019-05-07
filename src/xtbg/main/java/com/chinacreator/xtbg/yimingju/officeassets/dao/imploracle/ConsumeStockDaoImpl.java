package com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle;

import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.transaction.RollbackException;

import org.apache.log4j.Logger;

import com.chinacreator.business.common.tools.CacheCommonManage;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DaoUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.officeassets.dao.ConsumeStockDao;
import com.chinacreator.xtbg.yimingju.officeassets.entity.ConSumeStockListBean;
import com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeConsumStock;
import com.frameworkset.common.poolman.PreparedDBUtil;
import com.frameworkset.orm.transaction.TransactionManager;
/**
 * <p>
 * Title:ConsumeStockDaoImpl.java
 * Description:易耗品信息实例类
 * Company:湖南科创
 * @author QIULIAN
 * @version 1.0 2012-3-6
 */
public class ConsumeStockDaoImpl implements ConsumeStockDao{
	private static final Logger LOG = Logger
			.getLogger(ConsumeStockDaoImpl.class);
	/**
	 * @Description 添加易耗品信息
	 * @param typeBean 类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void addConSumOe(List<OfficeConsumStock> officeConsumStocks) throws Exception {
		String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");//421003贸促会
		TransactionManager tm = new TransactionManager();
		tm.begin();
		//库存
		StringBuffer buf = new StringBuffer();
		buf.append(" insert into ymj_oa_officeconstock ");
		buf.append(" (stock_id, stock_users, stock_date,remark,state,type_id,type_name,con_name,con_rule,count,prices,suppliers,service_phone)");
		buf.append(" values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
		//库存明细
		StringBuffer buffer = new StringBuffer();
		buffer.append(" insert into ymj_oa_constocklist ");
		buffer.append(" (collar_name,leave_count,out_count,into_count,type_name,type_id,eq_name,s_date,id,stock_id)");
		buffer.append(" values (?,?,?,?,?,?,?,?,SEQ_OFFICESTOCK.NEXTVAL,?)");
		try{
			PreparedDBUtil db = new PreparedDBUtil();
			for(int i=0;i<officeConsumStocks.size();i++){
				//库存
				OfficeConsumStock officeConsumStock =(OfficeConsumStock)officeConsumStocks.get(i);
				db.preparedInsert(buf.toString());
				String purchasId = DaoUtil.findBySequencsName("SEQ_OFFICESTOCK");
				java.sql.Date stcoDate= Date.valueOf(officeConsumStock.getStock_data());
				db.setString(1, purchasId);
				db.setString(2, officeConsumStock.getStock_applyer());
				db.setDate(3, stcoDate);
				db.setString(4, officeConsumStock.getRemark());
				db.setString(5, officeConsumStock.getState());
				db.setString(6, officeConsumStock.getType_id());
				db.setString(7, officeConsumStock.getType_name());
				db.setString(8, officeConsumStock.getCon_name());
				db.setString(9, officeConsumStock.getCon_rules());
				if(("421003").equals(userArea)){
					db.setString(10, officeConsumStock.getCount());
				}else{
					db.setInt(10, Integer.valueOf(officeConsumStock.getCount()));
				}
				db.setString(11, officeConsumStock.getCon_price());
				db.setString(12, officeConsumStock.getSuppliers());
				db.setString(13, officeConsumStock.getService_phone());
				db.addPreparedBatch();
				//库存明细
				db.preparedInsert(buffer.toString());
				db.setString(1, officeConsumStock.getCollar_userName());
				if(("421003").equals(userArea)){
					db.setString(2, officeConsumStock.getLeave_count());
					db.setString(3, officeConsumStock.getOut_count());
					db.setString(4, officeConsumStock.getInto_count());
				}else{
					db.setInt(2, Integer.valueOf(officeConsumStock.getLeave_count()));
					db.setInt(3, Integer.valueOf(officeConsumStock.getOut_count()));
					db.setInt(4, Integer.valueOf(officeConsumStock.getInto_count()));
				}
				db.setString(5, officeConsumStock.getType_name());
				db.setString(6, officeConsumStock.getType_id());
				db.setString(7, officeConsumStock.getEq_name());
				db.setDate(8, stcoDate);
				db.setString(9, purchasId);
				db.addPreparedBatch();
			}
			db.executePreparedBatch();
			tm.commit();
		}catch(Exception e){
			tm.rollback();
			throw e;
		}
	}
	
	/**
	 * @Description 查找易耗品信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findSnmEqList(OfficeConsumStock officeConsumStock, String sortName, String sortOrder, long offset, int maxPagesize){
		String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");//421003贸促会
		PagingBean pb = new PagingBean();
		PreparedDBUtil db = new PreparedDBUtil();
		List<OfficeConsumStock> list = new ArrayList<OfficeConsumStock>();
		StringBuffer sql = new StringBuffer();
		sql.append(" select       y.stock_id as stock_id,   			  			  ");
		sql.append(" 			  to_char(y.stock_date, 'yyyy-mm-dd') as stock_data,  ");
		sql.append(" 			  y.type_id as type_id,  							  ");
		//改y.type_name为type.ocname_name    tl   2013-4-28
		sql.append(" 			  type.ocname_name as type_name,   						  ");
		sql.append(" 			  y.con_name as con_name,							  ");
		sql.append(" 			  y.con_rule as con_rule,							  ");
		sql.append(" 			  y.count as count,								  	  ");
		sql.append(" 			  y.prices as prices,                                 ");
		sql.append(" 			  y.suppliers as suppliers,							  ");
		sql.append(" 			  y.service_phone as service_phone,					  ");
		sql.append(" 			  y.remark as remark,								  ");
		sql.append(" 			  type.ocname_no as ocname_no,								  ");
		sql.append(" 			  decode(y.state,'1','在库','2','出库','3','报废') as state ");
		if(("421003").equals(userArea)){
			sql.append("           from ymj_oa_officeconstock y left join ymj_oa_office_consumablename type ");
			sql.append(" ON type.ocname_id = y.type_id  where  1=1 ");
		}else{
			sql.append("           from ymj_oa_officeconstock y,ymj_oa_office_consumablename type ");
			sql.append(" where type.ocname_id = y.type_id and  count <> 0 ");
		}
	
		//设备名称
		if (!StringUtil.nullOrBlank(officeConsumStock.getCon_name())) {
			sql.append("	and con_name like '%"+officeConsumStock.getCon_name()+"%' ");
		}
		//供货商
		if (!StringUtil.nullOrBlank(officeConsumStock.getSuppliers())) {
			sql.append("	and suppliers like '%"+officeConsumStock.getSuppliers()+"%' ");
		}
		//类别名称
		if (!StringUtil.nullOrBlank(officeConsumStock.getType_name())) {
			sql.append("	and type_name like '%"+officeConsumStock.getType_name()+"%' ");
		}
		//入库时间
		if (!StringUtil.nullOrBlank(officeConsumStock.getStock_startTime())) {
			sql.append(" and stock_data >= to_date('")
					.append(officeConsumStock.getStock_startTime())
					.append("','yyyy-MM-dd')");
		}
		if (!StringUtil.nullOrBlank(officeConsumStock.getStock_endTime())) {
			sql.append(" and stock_data <= to_date('")
					.append(officeConsumStock.getStock_endTime() + "23:59:59")
					.append("','yyyy-MM-dd hh24:mi:ss')");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
		try {
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.executePrepared();
			for (int i = 0; i < db.size(); i++) {
				OfficeConsumStock ab = new OfficeConsumStock();
				ab.setStock_id(db.getString(i,"stock_id"));
				ab.setType_id(db.getString(i, "type_id"));
				ab.setStock_data(db.getString(i,"stock_data"));
				ab.setSuppliers(db.getString(i,"suppliers"));
				ab.setType_name(db.getString(i, "type_name"));
				ab.setCon_name(db.getString(i,"con_name"));
				ab.setCon_rules(db.getString(i,"con_rule"));
				ab.setCount(db.getString(i,"count"));
				ab.setCon_price(db.getString(i,"prices"));
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
	 * @Description 查找易耗品库存明细信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findAllList(ConSumeStockListBean officeConsumStock, String sortName, String sortOrder, long offset, int maxPagesize){
		
		PagingBean pb = new PagingBean();
		PreparedDBUtil db = new PreparedDBUtil();
		List<ConSumeStockListBean> list = new ArrayList<ConSumeStockListBean>();
		StringBuffer sql = new StringBuffer();
		sql.append(" select       t.id as id,   			  			        ");
		sql.append(" 			  to_char(t.s_date, 'yyyy-mm-dd') as s_date,    ");
		sql.append(" 			  t.eq_name as eq_name,  					    ");
		sql.append(" 			  t.type_id as type_id,   				         ");
		sql.append(" 			  t.type_name as type_name,					     ");
		sql.append(" 			  t.into_count as into_count,					 ");
		sql.append(" 			  t.out_count as out_count,					      ");
		sql.append(" 			  t.leave_count as leave_count,                   ");
		sql.append(" 			  type.ocname_no as ocname_no,                    ");
		sql.append(" 			  t.collar_name as collar_name 				       ");
		sql.append("           from ymj_oa_constocklist t,ymj_oa_office_consumablename type ");
		sql.append(" where  t.type_id = type.ocname_id and 1=1                                                         ");
	
		//设备名称
		if (!StringUtil.nullOrBlank(officeConsumStock.getEq_name())) {
			sql.append("	and eq_name like '%"+officeConsumStock.getEq_name()+"%' ");
		}
		//库存ID
		if (!StringUtil.nullOrBlank(officeConsumStock.getStock_id())) {
			sql.append("	and stock_id = '"+officeConsumStock.getStock_id()+"' ");
		}
		//入库时间
		if (!StringUtil.nullOrBlank(officeConsumStock.getStart_time())) {
			sql.append(" and s_date >= to_date('")
					.append(officeConsumStock.getStart_time())
					.append("','yyyy-MM-dd')");
		}
		if (!StringUtil.nullOrBlank(officeConsumStock.getEnd_time())) {
			sql.append(" and s_date <= to_date('")
					.append(officeConsumStock.getEnd_time() + "23:59:59")
					.append("','yyyy-MM-dd hh24:mi:ss')");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
		try {
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.executePrepared();
			for (int i = 0; i < db.size(); i++) {
				ConSumeStockListBean ab = new ConSumeStockListBean();
				ab.setId(db.getString(i,"id"));
				ab.setType_id(db.getString(i, "type_id"));
				ab.setS_date(db.getString(i,"s_date"));
				ab.setEq_name(db.getString(i,"eq_name"));
				ab.setType_name(db.getString(i, "type_name"));
				ab.setInto_count(db.getString(i,"into_count"));
				ab.setOut_count(db.getString(i,"out_count"));
				ab.setLeave_count(db.getString(i,"leave_count"));
				ab.setCollar_name(db.getString(i,"collar_name"));
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
	 * @Description  删除易耗品库存信息
	 * @param userIds
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean delSumEqStock(String userIds) throws SQLException{
		TransactionManager tm = new TransactionManager();
		//删除易耗品领用信息
		String sqlCollar = "delete from ymj_oa_office_equipmentapply where stocksum_id in ("+ userIds + ")";
		//删除易耗品库存详细表信息
		String sqlList = "delete from ymj_oa_constocklist where stock_id in ("+ userIds + ")";
		//删除易耗品库存信息
		String sqlStock = "delete from ymj_oa_officeconstock where stock_id in ("+ userIds + ")";
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
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryEqueryOfficeconstock
	  * @param bean
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.yimingju.officeassets.dao.ConsumeStockDao#queryEqueryOfficeconstock(com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeConsumStock)
	 */

	public OfficeConsumStock queryEqueryOfficeconstock(OfficeConsumStock bean) throws Exception{
		// TODO Auto-generated method stub
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" select stock_id,");
		sql.append("       stock_users,");
		sql.append("        to_char(t1.stock_date, 'yyyy-mm-dd') as stock_date,");
		sql.append("       type_id,");
		sql.append("       type_name,");
		sql.append("       con_name,");
		sql.append("       con_rule,");
		sql.append("       count,");
		sql.append("       prices,");
		sql.append("       suppliers,");
		sql.append("       service_phone,");
		sql.append("       state,");
		sql.append("       remark");
		sql.append("  from ymj_oa_officeconstock t1");
		sql.append(" where t1.type_id = ? ");
		sql.append("   and t1.con_name = ? ");
		sql.append("    and   type_id  = ? ");
		
		sql.append("    and   type_name = ? ");
		sql.append("    and  con_rule = ? ");
		
		sql.append("    and  prices = ? ");
		sql.append("    and  suppliers = ? ");
		//sql.append("    and  service_phone = ? ");
		
		//sql.append("    and   state = ? ");
		//sql.append("    and   remark  = ?");
		db.preparedSelect(sql.toString());
		int n =1;
		db.setString(n++, StringUtil.deNull(bean.getType_id()));//类型id
		db.setString(n++, StringUtil.deNull(bean.getCon_name()));//品名
		db.setString(n++, StringUtil.deNull(bean.getType_id()));//类型id
		
		db.setString(n++, StringUtil.deNull(bean.getType_name()));//类型名
		db.setString(n++, StringUtil.deNull(bean.getCon_rules()));//规格
		db.setString(n++, StringUtil.deNull(bean.getCon_price()));//单价
		
		db.setString(n++, StringUtil.deNull(bean.getSuppliers()));//供应商
		//db.setString(n++, StringUtil.deNull(bean.getService_phone()));//电话
		
		//db.setString(n++, bean.getState());//品名
		//db.setString(n++, StringUtil.deNull(bean.getRemark()));//说明
		
		db.executePrepared();
		OfficeConsumStock officeConsumStock  = new OfficeConsumStock();
		if(db.size()>=1){
			officeConsumStock.setStock_id(db.getString(0, "stock_id"));
			
			officeConsumStock.setStock_applyerName(db.getString(0, "stock_users"));
			officeConsumStock.setStock_data(db.getString(0, "stock_date"));
			officeConsumStock.setType_id(db.getString(0, "type_id"));
			
			officeConsumStock.setType_name(db.getString(0, "type_name"));
			officeConsumStock.setCon_name(db.getString(0, "con_name"));
			officeConsumStock.setCon_rules(db.getString(0, "con_rule"));
			
			officeConsumStock.setCount(db.getString(0, "count"));
			officeConsumStock.setCon_price(db.getString(0, "prices"));
			officeConsumStock.setSuppliers(db.getString(0, "suppliers"));
			
			officeConsumStock.setService_phone(db.getString(0, "service_phone"));
			officeConsumStock.setState(db.getString(0, "state"));
			//officeConsumStock.setRemark(db.getString(0, "remark"));
			return officeConsumStock;
		}
		
		return null;
	}

	@Override
	public boolean updateOfficeconstocks(
			List<OfficeConsumStock> officeConsumStocks,Connection conn) throws Exception {
		PreparedDBUtil db = new PreparedDBUtil();
		//库存
		StringBuffer sql = new StringBuffer();
		sql.append("update ymj_oa_officeconstock");
		sql.append("   set ");
		sql.append("       stock_users = ?,");
		sql.append("       stock_date = ?,");
		sql.append("       type_id = ?,");
		sql.append("       type_name = ?,");
		sql.append("       con_name = ?,");
		sql.append("       con_rule = ?,");
		sql.append("       count = ?,");
		sql.append("       prices = ?,");
		sql.append("       suppliers = ?,");
		sql.append("       service_phone = ?,");//备注
		sql.append("       state = ?,");
		sql.append("       remark = ? ");//说明
		sql.append(" where stock_id = ? ");
		int n = 1;
		for(int i=0;i<officeConsumStocks.size();i++){
			db.preparedUpdate(sql.toString());
			OfficeConsumStock officeConsumStock =(OfficeConsumStock)officeConsumStocks.get(i);
			
			java.sql.Date stcoDate= Date.valueOf(officeConsumStock.getStock_data());
			db.setString(n++, officeConsumStock.getStock_applyer());
			db.setDate(n++, stcoDate);
			db.setString(n++, officeConsumStock.getType_id());
			
			db.setString(n++, officeConsumStock.getType_name());
			db.setString(n++, officeConsumStock.getCon_name());
			db.setString(n++, officeConsumStock.getCon_rules());
			
			db.setInt(n++, Integer.valueOf(officeConsumStock.getCount()));
			db.setString(n++, officeConsumStock.getCon_price());
			db.setString(n++, officeConsumStock.getSuppliers());
			
			db.setString(n++, officeConsumStock.getService_phone());
			db.setString(n++, officeConsumStock.getState());
			db.setString(n++, officeConsumStock.getRemark());
			
			db.setString(n++, officeConsumStock.getStock_id());
			db.addPreparedBatch();
		}
		db.executePreparedBatch(conn);
		return true;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 insertConstocklist
	  * @param officeConsumStocks
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.yimingju.officeassets.dao.ConsumeStockDao#insertConstocklist(java.util.List, java.sql.Connection)
	 */
	@Override
	public boolean insertConstocklist(List<OfficeConsumStock> officeConsumStocks,Connection conn)
			throws Exception {
		// TODO Auto-generated method stub
		PreparedDBUtil db = new PreparedDBUtil();
		//库存明细
		StringBuffer sql = new StringBuffer();
		sql.append(" insert into ymj_oa_constocklist ");
		sql.append(" (collar_name,leave_count,out_count,into_count,type_name,type_id,eq_name,s_date,id,stock_id)");
		sql.append(" values (?,?,?,?,?,?,?,?,SEQ_OFFICESTOCK.NEXTVAL,?)");
		for(int i=0;i<officeConsumStocks.size();i++){
			OfficeConsumStock officeConsumStock =(OfficeConsumStock)officeConsumStocks.get(i);
			//String purchasId = DaoUtil.findBySequencsName("SEQ_OFFICESTOCK");
			java.sql.Date stcoDate= Date.valueOf(officeConsumStock.getStock_data());
			//库存明细
			db.preparedInsert(sql.toString());
			db.setString(1, officeConsumStock.getCollar_userName());
			db.setInt(2, Integer.valueOf(officeConsumStock.getLeave_count()));
			db.setInt(3, Integer.valueOf(officeConsumStock.getOut_count()));
			db.setInt(4, Integer.valueOf(officeConsumStock.getInto_count()));
			db.setString(5, officeConsumStock.getType_name());
			db.setString(6, officeConsumStock.getType_id());
			db.setString(7, officeConsumStock.getEq_name());
			db.setDate(8, stcoDate);
			db.setString(9, officeConsumStock.getStock_id());//库存id
			db.addPreparedBatch();
		}
		db.executePreparedBatch(conn);
		return true;
		
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 insertOfficeconstocks
	  * @param officeConsumStocks
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.yimingju.officeassets.dao.ConsumeStockDao#insertOfficeconstocks(java.util.List, java.sql.Connection)
	 */
	@Override
	public boolean insertOfficeconstocks(
			List<OfficeConsumStock> officeConsumStocks,Connection conn) throws Exception {
		// TODO Auto-generated method stub
		PreparedDBUtil db = new PreparedDBUtil();
		//库存
		StringBuffer sql = new StringBuffer();
		sql.append(" insert into ymj_oa_officeconstock ");
		sql.append(" (stock_id, stock_users, stock_date,remark,state,type_id,type_name,con_name,con_rule,count,prices,suppliers,service_phone)");
		sql.append(" values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
		for(int i=0;i<officeConsumStocks.size();i++){
			db.preparedInsert(sql.toString());
			OfficeConsumStock officeConsumStock =(OfficeConsumStock)officeConsumStocks.get(i);
			java.sql.Date stcoDate= Date.valueOf(officeConsumStock.getStock_data());
			db.setString(1, officeConsumStock.getStock_id());
			db.setString(2, officeConsumStock.getStock_applyer());
			db.setDate(3, stcoDate);
			db.setString(4, officeConsumStock.getRemark());
			db.setString(5, officeConsumStock.getState());
			db.setString(6, officeConsumStock.getType_id());
			db.setString(7, officeConsumStock.getType_name());
			db.setString(8, officeConsumStock.getCon_name());
			db.setString(9, officeConsumStock.getCon_rules());
			db.setInt(10, Integer.valueOf(officeConsumStock.getCount()));
			db.setString(11, officeConsumStock.getCon_price());
			db.setString(12, officeConsumStock.getSuppliers());
			db.setString(13, officeConsumStock.getService_phone());
			db.addPreparedBatch();
		}
		db.executePreparedBatch(conn);
		return true;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryOfficeConsumStockById
	  * @param stock_id
	  * @return 
	  * @see com.chinacreator.xtbg.yimingju.officeassets.dao.ConsumeStockDao#queryOfficeConsumStockById(java.lang.String)
	 */
	@Override
	public OfficeConsumStock queryOfficeConsumStockById(String stock_id) {
		// TODO Auto-generated method stub
		PreparedDBUtil db = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append(" select stock_id,");
		sql.append("       stock_users,");
		sql.append("        to_char(t1.stock_date, 'yyyy-mm-dd') as stock_date,");
		sql.append("       type_id,");
		sql.append("       type_name,");
		sql.append("       con_name,");
		sql.append("       con_rule,");
		sql.append("       count,");
		sql.append("       prices,");
		sql.append("       suppliers,");
		sql.append("       service_phone,");
		sql.append("       state,");
		sql.append("       remark");
		sql.append("  from ymj_oa_officeconstock t1");
		sql.append(" where t1.stock_id = ? ");
		
		try {
			db.preparedSelect(sql.toString());
			
			int n =1;
			db.setString(n++, StringUtil.deNull(stock_id));
			db.executePrepared();
			OfficeConsumStock officeConsumStock  = new OfficeConsumStock();
			if(db.size()==1){
				officeConsumStock.setStock_id(db.getString(0, "stock_id"));
				officeConsumStock.setStock_applyerName(db.getString(0, "stock_users"));
				officeConsumStock.setStock_data(db.getString(0, "stock_date"));
				officeConsumStock.setType_id(db.getString(0, "type_id"));
				
				officeConsumStock.setType_name(db.getString(0, "type_name"));
				officeConsumStock.setCon_name(db.getString(0, "con_name"));
				officeConsumStock.setCon_rules(db.getString(0, "con_rule"));
				
				officeConsumStock.setCount(db.getString(0, "count"));
				officeConsumStock.setCon_price(db.getString(0, "prices"));
				officeConsumStock.setSuppliers(db.getString(0, "suppliers"));
				
				officeConsumStock.setService_phone(db.getString(0, "service_phone"));
				officeConsumStock.setState(db.getString(0, "state"));
				officeConsumStock.setRemark(db.getString(0, "remark"));
				return officeConsumStock;
			}
		} catch (Exception e) {
			LOG.error("查询易耗品库表报错：" + e.getMessage());
			e.printStackTrace();
		}
		return null;
	}
}
