package com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.Logger;
import com.chinacreator.business.common.tools.CacheCommonManage;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DaoUtil;
import com.chinacreator.xtbg.pub.util.DateUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.officeassets.dao.CollarStockDao;
import com.chinacreator.xtbg.yimingju.officeassets.entity.CollarBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
import com.frameworkset.orm.transaction.TransactionManager;
/**
 * <p>
 * Title:CollarStockDaoImpl.java
 * Description:领用信息实例类
 * Company:湖南科创
 * @author QIULIAN
 * @version 1.0 2012-3-6
 */
public class CollarStockDaoImpl implements CollarStockDao {
	private static final Logger LOG = Logger
			.getLogger(CollarStockDaoImpl.class);
	
	/**
	 * 查找办公设备出库领用的设备
	 */
	public PagingBean findTypeList(CollarBean collarBean, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");//421003贸促会
		PagingBean pb = new PagingBean();
		PreparedDBUtil db = new PreparedDBUtil();
		List<CollarBean> list = new ArrayList<CollarBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("  select         							             ");
		sql.append("     y.stock_id as stock_id,      				         ");
		sql.append("     y.eq_name as eq_name,       				         ");
		sql.append("     y.type_id as type_id,		   				         ");
		sql.append("     type.oetype_name as type_name,   				         ");
		sql.append("     y.eq_no as eq_no,          				         ");
		sql.append("     y.eq_model as eq_model,     				         ");
		sql.append("     t.collarreg_id as collarreg_id,    		         ");
		sql.append("     t.collar_username as collar_username,               ");
		sql.append("     t.collar_departname as collar_departname,           ");
		sql.append("     type.oetype_no as oetype_no,            			  ");
		sql.append("     to_char(t.collar_date,'yyyy-mm-dd') as collar_date,  ");
		sql.append("     decode(y.state,'1','在库','2','出库','3','报废') as state, ");
		sql.append("     decode(y.collar_state,'1','归还','2','领用','3','报废') as collar_state, ");
		sql.append("     t.collar_user as  collar_user                        ");
		sql.append("  from ymj_oa_office_equipmentapply t		              ");
		
		if(("421003").equals(userArea)){
			sql.append(" left     join ymj_oa_officeeqstock y on t.stockeq_id = y.stock_id ");
			sql.append(" left    join ymj_oa_office_equipmenttype type on y.type_id = type.oetype_id ");
		}else{
			sql.append("      join ymj_oa_officeeqstock y on t.stockeq_id = y.stock_id ");
			sql.append("      join ymj_oa_office_equipmenttype type on y.type_id = type.oetype_id ");
		}
		sql.append(" where 1=1  ");
		//状态
		if (!StringUtil.nullOrBlank(collarBean.getState())) {
			sql.append(" and state  ='"+collarBean.getState()+"'");
		}
		//领用状态
		if (!StringUtil.nullOrBlank(collarBean.getCollarState())) {
				sql.append(" and collar_state  ='"+collarBean.getCollarState()+"'");
		}
		//领用开始时期
		if (!StringUtil.nullOrBlank(collarBean.getCollar_startTime())) {
			sql.append(" and collar_date >= to_date('").append(collarBean.getCollar_startTime()).append("','yyyy-MM-dd')");
		}
		//领用结束时间
		if (!StringUtil.nullOrBlank(collarBean.getCollar_endTime())) {
			sql.append(" and collar_date <= to_date('").append(collarBean.getCollar_endTime()).append("','yyyy-MM-dd')");
		}
		//领用人
		if (!StringUtil.nullOrBlank(collarBean.getCollar_user())) {
			  sql.append("	and collar_user='"+collarBean.getCollar_user()+"' ");
		}
		//领用人名称
		if (!StringUtil.nullOrBlank(collarBean.getCollar_userName())) {
			  sql.append("	and collar_username like '%"+collarBean.getCollar_userName()+"%' ");
		}
		//领用部门
		if (!StringUtil.nullOrBlank(collarBean.getCollar_departName())) {
			sql.append("	and collar_departname like '%"+collarBean.getCollar_departName()+"%' ");
		}
		//设备名称
		if (!StringUtil.nullOrBlank(collarBean.getEq_name())) {
			sql.append("	and eq_name like '%"+collarBean.getEq_name()+"%' ");
		}
		//设备编号
		if (!StringUtil.nullOrBlank(collarBean.getEq_no())) {
			sql.append("	and eq_no like '%"+collarBean.getEq_no()+"%' ");
		}
		//类别
		if (!StringUtil.nullOrBlank(collarBean.getEq_typeId())) {
			sql.append("	and type_id = '"+collarBean.getEq_typeId()+"' ");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
		try {
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.executePrepared();
			for (int i = 0; i < db.size(); i++) {
				CollarBean ab = new CollarBean();
				ab.setCollar_id(db.getString(i,"collarreg_id"));
				ab.setEq_name(db.getString(i,"eq_name"));
				ab.setEq_type(db.getString(i, "type_name"));
				ab.setEq_no(db.getString(i,"eq_no"));
				ab.setEq_model(db.getString(i,"eq_model"));
				ab.setStock_Id(db.getString(i, "stock_id"));
				ab.setCollar_userName(db.getString(i,"collar_username"));
				ab.setCollar_departName(db.getString(i,"collar_departname"));
				ab.setCollar_date(db.getString(i,"collar_date"));
				ab.setState(db.getString(i,"state"));
				ab.setCollarState(db.getString(i,"collar_state"));
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
	
	public String[] getDepartByUserID(String userId) throws Exception{
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		String[] departs = new String[2];
		sql.append(" select o.org_id as org_id, o.org_name as org_name ");
		sql.append(" from td_sm_orguser u ");
		sql.append(" inner join td_sm_organization o on u.org_id = o.org_id ");
		sql.append(" where u.user_id= "+userId+"") ;
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		for (int i = 0; i < pdb.size(); i++) {
			departs[0] = (String)pdb.getString(i, "org_id");
			departs[1] = (String)pdb.getString(i, "org_name");
		}
		return departs;
	}
	/**
	 * 领用办公室设备信息添加
	 * @param collarBean
	 * @return
	 */
	public void addToBean(List<CollarBean> collarBeans) throws Exception{
		StringBuffer buf = new StringBuffer();
		// 领用信息
		buf.append(" insert into ymj_oa_office_equipmentapply");
		buf.append("(collarreg_id, collar_user, collar_username,collar_depart,collar_departname,collar_date,remark,stockeq_id)");
		buf.append("values(?,?,?,?,?,?,?,?)");
		
		PreparedDBUtil db = new PreparedDBUtil();
		for(int i=0;i<collarBeans.size();i++){
			String purchasId = DaoUtil.findBySequencsName("SEQ_COLLARSTOCK");
			CollarBean collarBean = (CollarBean)collarBeans.get(i);
			db.preparedInsert(buf.toString());
			db.setString(1, purchasId);
			db.setString(2, collarBean.getCollar_user());
			db.setString(3, collarBean.getCollar_userName());
			db.setString(4, collarBean.getCollar_depart());
			db.setString(5, collarBean.getCollar_departName());
			db.setDate(6, DateUtil.parseTimeString(collarBean.getCollar_date()));
			db.setString(7, collarBean.getRemark());
			db.setString(8, collarBean.getStock_Id());
			db.addPreparedBatch();
		}
		db.executePreparedBatch();
	}
	/**
	 * 修改领用办公室库存信息
	 * @param collarBean
	 * @return
	 */
	public void updateStockBean(List<CollarBean> collarBeans) throws Exception{
		TransactionManager tm = new TransactionManager();
		tm.begin();
		StringBuffer buf = new StringBuffer();
		// 领用办公室库存信息
		buf.append(" update ymj_oa_officeeqstock ");
		buf.append(" set state =?, ");
		buf.append("     collar_state =?, ");
		buf.append("     remark =? ");
		buf.append(" where stock_id=? ");
		//库存明细
		StringBuffer buffer  = new StringBuffer();
		buffer.append(" insert into ymj_oa_officestocklist ");
		buffer.append(" (ty_id,collar_name,action_name,action,ty_name,eq_no,eq_name,s_date,id,STOCK_ID)");
		buffer.append(" values (?,?,?,?,?,?,?,?,SEQ_OFFICESTOCK.NEXTVAL,?)");
		try{
			PreparedDBUtil db = new PreparedDBUtil();
			for(int i=0;i<collarBeans.size();i++){
				CollarBean collarBean =(CollarBean)collarBeans.get(i);
				db.preparedInsert(buf.toString());
				db.setString(1, collarBean.getState());
				db.setString(2, collarBean.getCollarState());
				db.setString(3, collarBean.getRemark());
				db.setString(4, collarBean.getStock_Id());
				db.addPreparedBatch();
				
				//库存详细信息
				db.preparedInsert(buffer.toString());
				db.setString(1, collarBean.getEq_typeId());
				db.setString(2, collarBean.getCollar_userName());
				db.setString(3, collarBean.getAction_name());
				db.setString(4, collarBean.getAction());
				db.setString(5, collarBean.getEq_type());
				db.setString(6, collarBean.getEq_no());
				db.setString(7, collarBean.getEq_name());
				db.setDate(8, DateUtil.parseTimeString(collarBean.getCollar_date()));
				db.setString(9, collarBean.getStock_Id());
				db.addPreparedBatch();
			}
			db.executePreparedBatch();
			tm.commit();
		} catch(Exception e){
			tm.rollback();
			throw e;
		}
	}
	/**
	 * 查找领用办公室库存信息
	 * @param collarBean
	 * @return
	 */
	public CollarBean findStockBean(CollarBean collarBean) throws Exception{
		PreparedDBUtil db = new PreparedDBUtil();
		CollarBean ab = new CollarBean();
		StringBuffer sql = new StringBuffer();
		sql.append(" select         							");
		sql.append("     y.stock_id as stock_id,      				");
		sql.append("     y.eq_name as eq_name,       				");
		sql.append("     y.type_id as type_id,		   				");
		sql.append("     y.type_name as type_name,   				");
		sql.append("     y.eq_no as eq_no,          				");
		sql.append("     y.suppliers as suppliers,          	    ");
		sql.append("     y.eq_phone as eq_phone,          	        ");
		sql.append("     to_char(y.stock_data,'yyyy-mm-dd') as stock_data,    ");
		sql.append("     y.eq_model as eq_model,     				");
		sql.append("     y.eq_price as eq_price,     				");
		sql.append("     t.collarreg_id as collarreg_id,    		");
		sql.append("     y.state as state,    						");
		sql.append("     y.remark as remark,    					");
		sql.append("     t.collar_username as collar_username,      ");
		sql.append("     t.collar_departname as collar_departname,  ");
		sql.append("     to_char(t.collar_date,'yyyy-mm-dd') as collar_date  ");
		sql.append(" from ymj_oa_office_equipmentapply t				");
		sql.append(" join ymj_oa_officeeqstock y on t.stockeq_id = y.stock_id ");
		sql.append(" where 1=1 and y.state='"+collarBean.getState()+"' ");
		sql.append(" and stock_id ='"+collarBean.getStock_Id()+"'");
		try {
			db.preparedSelect(sql.toString());
			db.executePrepared();
			
			for (int i = 0; i < db.size(); i++) {
				ab.setCollar_id(db.getString(i,"collarreg_id"));
				ab.setEq_name(db.getString(i,"eq_name"));
				ab.setEq_type(db.getString(i, "type_name"));
				ab.setEq_no(db.getString(i,"eq_no"));
				ab.setSuppliers(db.getString(i,"suppliers"));
				ab.setEq_phone(db.getString(i,"eq_phone"));
				ab.setStock_data(db.getString(i,"stock_data"));
				ab.setEq_model(db.getString(i,"eq_model"));
				ab.setEq_price(db.getString(i,"eq_price"));
				ab.setStock_Id(db.getString(i, "stock_id"));
				ab.setCollar_userName(db.getString(i,"collar_username"));
				ab.setCollar_departName(db.getString(i,"collar_departname"));
				ab.setCollar_date(db.getString(i,"collar_date"));
				ab.setState(db.getString(i,"state"));
				ab.setRemark(db.getString(i,"remark"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.error("执行类型列表查询报错：" + e.getMessage());
		}
		return ab;
	}
	/**
	 * 删除办公设备领用信息
	 * @param collarBean
	 * @throws Exception
	 */
	public void deleteStockApply(List<CollarBean> collarBeans) throws  Exception{
		StringBuffer buf = new StringBuffer();
		// 领用办公室库存信息
		buf.append(" delete from ymj_oa_office_equipmentapply  ");
		buf.append(" where stockeq_id = ? ");
		PreparedDBUtil db = new PreparedDBUtil();
		for(int i=0;i<collarBeans.size();i++){
			CollarBean  collarBean =(CollarBean)collarBeans.get(i);
			db.preparedDelete(buf.toString());
			db.setString(1, collarBean.getStock_Id());
			db.executePrepared();
		}
	}
}
