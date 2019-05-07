package com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle;

import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.Logger;

import com.chinacreator.business.common.tools.CacheCommonManage;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DaoUtil;
import com.chinacreator.xtbg.pub.util.DateUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.officeassets.dao.CollarConEqStockDao;
import com.chinacreator.xtbg.yimingju.officeassets.entity.CollarConEqBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * <p>
 * Title:CollarConEqStockDaoImpl.java
 * Description:领用易耗品信息实例类
 * Company:湖南科创
 * @author QIULIAN
 * @version 1.0 2012-3-6
 */
public class CollarConEqStockDaoImpl implements CollarConEqStockDao{
	private static final Logger LOG = Logger
			.getLogger(CollarConEqStockDaoImpl.class);
	
	/**
	 * @Description 根据条件查询领用信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findTypeList(CollarConEqBean collarConEqBean, String sortName, String sortOrder, long offset, int maxPagesize){
		PagingBean pb = new PagingBean();
		String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");//421003贸促会
		PreparedDBUtil db = new PreparedDBUtil();
		List<CollarConEqBean> list = new ArrayList<CollarConEqBean>();
		StringBuffer sql = new StringBuffer();
		sql.append(" select         							");
		sql.append(" c.stock_id as stock_id,      				");
		sql.append(" c.con_name as con_name,       				");
		sql.append(" c.type_id as type_id,		   				");
		//改c.type_name为type.ocname_name    tl   2013-4-28
		sql.append(" type.ocname_name as type_name,	   				");
		sql.append(" c.con_rule as con_rule,     				");
		sql.append(" t.collar_username as collar_username,      ");
		sql.append(" t.collar_departname as collar_departname,	");
		sql.append(" t.sum_count as sum_count,           		");
		sql.append(" type.ocname_no as ocname_no,           		");
		sql.append(" to_char(t.collar_date,'yyyy-mm-dd') as collar_date     ");
		sql.append(" from ymj_oa_office_equipmentapply t				");
		if(("421003").equals(userArea)){
			sql.append(" inner join ymj_oa_officeconstock c on t.stocksum_id = c.stock_id ");
			sql.append(" left join ymj_oa_office_consumablename type on type.ocname_id = c.type_id ");
		}else{
			sql.append(" join ymj_oa_officeconstock c on t.stocksum_id = c.stock_id ");
			sql.append(" join ymj_oa_office_consumablename type on type.ocname_id = c.type_id ");
		}
		sql.append(" where 1=1 ");
		//领用开始时期
		if (!StringUtil.nullOrBlank(collarConEqBean.getCollarCon_startTime())) {
			sql.append(" and collar_date >= to_date('").append(collarConEqBean.getCollarCon_startTime()).append("','yyyy-MM-dd')");
		}
		//领用结束时间
		if (!StringUtil.nullOrBlank(collarConEqBean.getCollarCon_endTime())) {
			sql.append(" and collar_date <= to_date('").append(collarConEqBean.getCollarCon_endTime()).append("','yyyy-MM-dd')");
		}
		//领用部门
		if (!StringUtil.nullOrBlank(collarConEqBean.getCollarCon_departName())) {
			sql.append("  and collar_departname like '%"+collarConEqBean.getCollarCon_departName()+"%' ");
		}
		//品名
		if (!StringUtil.nullOrBlank(collarConEqBean.getConEq_name())) {
			sql.append("  and con_name like '%"+collarConEqBean.getConEq_name()+"%' ");
		}
		//类别
		if (!StringUtil.nullOrBlank(collarConEqBean.getConEq_type())) {
			sql.append("  and type_name = '"+collarConEqBean.getConEq_type()+"' ");
		}
		//领用人
		if (!StringUtil.nullOrBlank(collarConEqBean.getCollarCon_userName())) {
			sql.append("  and collar_username like '%"+collarConEqBean.getCollarCon_userName()+"%' ");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
		try {
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.executePrepared();
			for (int i = 0; i < db.size(); i++) {
				CollarConEqBean ab = new CollarConEqBean();
				ab.setStock_Id(db.getString(i,"stock_id"));
				ab.setConEq_name(db.getString(i,"con_name"));
				ab.setConEq_type(db.getString(i, "type_name"));
				ab.setConEq_ruls(db.getString(i,"con_rule"));
				ab.setCollarCon_userName(db.getString(i,"collar_username"));
				ab.setCollarCon_departName(db.getString(i, "collar_departname"));
				ab.setCollar_count(db.getString(i,"sum_count"));
				ab.setCollarCon_date(db.getString(i,"collar_date"));
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
	 * 领用易耗品设备信息添加
	 * @param collarConEqBean
	 * @return
	 */
	public void addToBean(List<CollarConEqBean> collarConEqBeans) throws Exception{
		
		PreparedDBUtil db = new PreparedDBUtil();
		for(int i=0;i<collarConEqBeans.size();i++){
			String purchasId = DaoUtil.findBySequencsName("SEQ_COLLARSTOCK");
			CollarConEqBean collarConEqBean =(CollarConEqBean)	collarConEqBeans.get(i);
			//查找是否存在易耗品信息
			CollarConEqBean collarConEqBean2=findConEqBean(collarConEqBean);
			if(collarConEqBean2 ==null){
				StringBuffer buf = new StringBuffer();
				// 领用信息
				buf.append(" insert into ymj_oa_office_equipmentapply");
				buf.append("(collarreg_id, collar_user, collar_username,collar_depart,collar_departname,collar_date,remark,stocksum_id,sum_count)");
				buf.append("values(?,?,?,?,?,to_date('" + collarConEqBean.getCollarCon_date()
						+ "','yyyy-MM-dd HH24:mi'),?,?,?)");
				db.preparedInsert(buf.toString());
				db.setString(1, purchasId);
				db.setString(2, collarConEqBean.getCollarCon_user());
				db.setString(3, collarConEqBean.getCollarCon_userName());
				db.setString(4, collarConEqBean.getCollarCon_depart());
				db.setString(5, collarConEqBean.getCollarCon_departName());
				db.setString(6, collarConEqBean.getRemark());
				db.setString(7, collarConEqBean.getStock_Id());
				db.setInt(8, Integer.parseInt(collarConEqBean.getCollar_count()));
				db.executePrepared();
			} else{
					StringBuffer buf = new StringBuffer();
				    // 领用信息
					java.sql.Date stcoDate= Date.valueOf(collarConEqBean.getCollarCon_date());
					buf.append(" update ymj_oa_office_equipmentapply");
					buf.append(" set sum_count =sum_count + ?,      ");
					buf.append("     collar_date =?,       			");
					buf.append("     remark =?                     ");
					buf.append("     where stocksum_id=?   			");
					buf.append("           and collar_user=?   			");
					db.preparedUpdate(buf.toString());
					db.setString(1, collarConEqBean.getCollar_count());
					db.setDate(2, stcoDate);
					db.setString(3, collarConEqBean.getRemark());
					db.setString(4, collarConEqBean.getStock_Id());
					db.setString(5, collarConEqBean.getCollarCon_user());
					db.executePrepared();
			}
		}
	}
	/**
	 * 修改易耗品库存信息
	 * @param collarBean
	 * @return
	 */
	public void updateConEqStockBean(List<CollarConEqBean> collarConEqBeans) throws Exception{
		StringBuffer buf = new StringBuffer();
		String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");//421003贸促会
		// 领用办公室库存信息
		buf.append(" update ymj_oa_officeconstock ");
		buf.append(" set count =? ");
		buf.append(" where stock_id=? ");
		//易耗品库存详细信息
		StringBuffer buffer  = new StringBuffer();
		buffer.append(" insert into ymj_oa_constocklist ");
		buffer.append(" (collar_name,leave_count,out_count,into_count,type_name,type_id,eq_name,s_date,id,stock_id)");
		buffer.append(" values (?,?,?,?,?,?,?,?,SEQ_OFFICESTOCK.NEXTVAL,?)");
		PreparedDBUtil db = new PreparedDBUtil();
		for(int i=0;i<collarConEqBeans.size();i++){
			CollarConEqBean collarConEqBean = (CollarConEqBean)collarConEqBeans.get(i);
			db.preparedInsert(buf.toString());
			//贸促会这里控制 可以为空
			if(("421003").equals(userArea)){
				if(!("").equals(collarConEqBean.getConStock_count())&&!("").equals(collarConEqBean.getCollar_count())){
					db.setInt(1, Integer.parseInt(collarConEqBean.getConStock_count())-Integer.parseInt(collarConEqBean.getCollar_count()));
				}else{
					db.setString(1,"0");
				}
			}else{
				db.setInt(1, Integer.parseInt(collarConEqBean.getConStock_count())-Integer.parseInt(collarConEqBean.getCollar_count()));
			}
			db.setString(2, collarConEqBean.getStock_Id());
			db.executePrepared();
			//库存详细信息
			db.preparedInsert(buffer.toString());
			db.setString(1, collarConEqBean.getAction_name());
		if(("421003").equals(userArea)){
			db.setString(2, collarConEqBean.getLeave_count());
			db.setString(3, collarConEqBean.getOut_count());
			db.setString(4, collarConEqBean.getInto_count());
		}else{
			db.setInt(2, Integer.valueOf(collarConEqBean.getLeave_count()));
			db.setInt(3, Integer.valueOf(collarConEqBean.getOut_count()));
			db.setInt(4, Integer.valueOf(collarConEqBean.getInto_count()));
		}
			db.setString(5, collarConEqBean.getConEq_type());
			db.setString(6, collarConEqBean.getType_id());
			db.setString(7, collarConEqBean.getConEq_name());
			db.setDate(8, DateUtil.parseTimeString(collarConEqBean.getCollarCon_date()));
			db.setString(9, collarConEqBean.getStock_Id());
			db.executePrepared();
		}
	}
	
	/**
	 * 查询易耗品信息里领用
	 * @param collarConEqBean
	 * @return 
	 */
	public CollarConEqBean findConEqBean(CollarConEqBean collarConEqBean) throws Exception{
		StringBuffer buf = new StringBuffer();
		
		// 查询易耗品信息里领用
		buf.append(" select t.stocksum_id, 					    ");
		buf.append("        t.sum_count    					    ");
		buf.append("       from ymj_oa_office_equipmentapply t  ");
		buf.append("     where    t.stocksum_id=?      			");
		buf.append("          and t.collar_user=?  				");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(buf.toString());
		db.setString(1, collarConEqBean.getStock_Id());
		db.setString(2, collarConEqBean.getCollarCon_user());
		db.executePrepared();
		CollarConEqBean collarConEqBean2 = null;
		for (int i = 0; i < db.size(); i++) {
			collarConEqBean2=new CollarConEqBean();
			collarConEqBean2.setStock_Id(db.getString(i,"stock_id"));
			collarConEqBean2.setCollar_count(db.getString(i,"sum_count"));
		}
		return collarConEqBean2;
	}
	
}
