package com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.Logger;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.officeassets.dao.OfficeEquipmentTypeDao;
import com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeEquipmentTypeBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:OfficeEquipmentTypeTypeDaoImpl.java</p>
 *<p>Description:类型信息实例类</p> 
 *<p>Company:湖南科创</p>
 *@author 刘春元
 *@version 1.0
 *2012-3-6
 */
public class OfficeEquipmentTypeDaoImpl implements OfficeEquipmentTypeDao {

	private static final Logger LOG = Logger.getLogger(OfficeEquipmentTypeDaoImpl.class);
	
	/**
	 * @Description  查询类型列表
	 * 
	 * @param ScheduleCanViewBean  //查询参数
	 * @param sortName  //排序字段
	 * @param sortOrder  //排序方式
	 * @param offset  //从第几天开始
	 * @param maxPagesize	//当前页数
	 * @return  List
	 * @exception 
	 */
	
	public PagingBean findTypeList(OfficeEquipmentTypeBean typeBean, String sortName, String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<OfficeEquipmentTypeBean> list = new ArrayList<OfficeEquipmentTypeBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" oetype_id, oetype_name, oetype_remark,oetype_no ");
		sql.append(" from ymj_oa_office_equipmenttype where 1=1 ");
		if (!StringUtil.nullOrBlank(typeBean.getOetype_name())) {
			sql = sql.append(" and oetype_name like '%" + typeBean.getOetype_name() + "%'");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
		try {
	    	db.preparedSelect(sql.toString(), offset, maxPagesize);
	    	db.executePrepared();
		    for(int i = 0;i < db.size();i++){
		    	OfficeEquipmentTypeBean ab = new OfficeEquipmentTypeBean();
		    	ab.setOetype_id(db.getString(i, "oetype_id"));
		    	ab.setOetype_name(db.getString(i, "oetype_name"));
		    	ab.setOetype_remark(db.getString(i, "oetype_remark"));
		    	ab.setOetype_no(db.getInt(i, "oetype_no"));
		    	list.add(ab);
		    }
	    } catch (SQLException e) {
			LOG.error("执行类型列表查询报错："+e.getMessage());
		}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	/**
	 * @Description 添加类型信息
	 * @param typeBean 类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void addOe(OfficeEquipmentTypeBean oeBean) throws SQLException {
		StringBuffer buf = new StringBuffer();
		buf.append(" insert into ymj_oa_office_equipmenttype");
		buf.append(" (oetype_id, oetype_name, oetype_remark,oetype_no)");
		buf.append(" values(SEQ_OFFICEEQUIPMENTTYPE.nextval,  ?, ?, ?)");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedInsert(buf.toString());
		db.setString(1, oeBean.getOetype_name());
		db.setString(2, oeBean.getOetype_remark());
		db.setInt(3, oeBean.getOetype_no());
		db.executePrepared();
	}

	/**
	 * @Description 修改类型信息
	 * @param typeBean 类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void updateType(OfficeEquipmentTypeBean oeBean) throws SQLException {
		StringBuffer buf = new StringBuffer();
		buf.append(" update ymj_oa_office_equipmenttype ");
		buf.append(" set oetype_name=?, oetype_remark=?, oetype_no = ? where oetype_id = ?");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedUpdate(buf.toString());
		db.setString(1, oeBean.getOetype_name());
		db.setString(2, oeBean.getOetype_remark());
		db.setInt(3, oeBean.getOetype_no());
		db.setString(4, oeBean.getOetype_id());
		db.executePrepared();
	}
	
	/**
	 * @Description  删除类型信息
	 * @param userIds
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean delType(String userIds) throws SQLException {
		String sql = "delete from ymj_oa_office_equipmenttype where oetype_id in ("+ userIds + ")";
		PreparedDBUtil db = new PreparedDBUtil();
		db.executeDelete(sql);
		return true;
	}
	
	/**
	 * 查询办公室设备库存  根据类型ID
	 * @param typeId
	 * @return
	 */
	public boolean findEqStockByTypeId(String typeId) throws Exception{
		StringBuffer buf = new StringBuffer();
		buf.append("select");
		buf.append(" * ");
		buf.append(" from ymj_oa_officeeqstock  ");
		buf.append(" where type_id in (" + typeId + ")");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(buf.toString()); 
		db.executePrepared();
		if(db.size()>0){
			return true;
		} else{
			return false;
		}
	}
	
	/**
	 * @Description 根据类型ID获得类型信息
	 * @param typeBean 类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public OfficeEquipmentTypeBean getTypeBeanById(String id) throws SQLException {
		StringBuffer buf = new StringBuffer();
		buf.append("select");
		buf.append(" oetype_id, oetype_name, oetype_remark, oetype_no ");
		buf.append(" from ymj_oa_office_equipmenttype where oetype_id=? ");
		PreparedDBUtil db = new PreparedDBUtil();
		OfficeEquipmentTypeBean ab = new OfficeEquipmentTypeBean();
		db.preparedSelect(buf.toString()); 
		db.setString(1, id);
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {  
			ab.setOetype_id(db.getString(i, "oetype_id"));
			ab.setOetype_name(db.getString(i, "oetype_name"));
			ab.setOetype_remark(db.getString(i, "oetype_remark"));
			ab.setOetype_no(db.getInt(i, "oetype_no"));
		}
		return ab;
	}
	
	/**
	 * @Description 根据名称获得办公室设备类型
	 * @param typeBean 办公室设备Bean
	 * @return OfficeEquipmentTypeBean
	 * @throws SQLException 
	 */
	public boolean findEquipmentTypeByName(OfficeEquipmentTypeBean typeBean) throws SQLException{
		StringBuffer buf = new StringBuffer();
		buf.append("select");
		buf.append(" oetype_id, oetype_name, oetype_remark, oetype_no ");
		buf.append(" from ymj_oa_office_equipmenttype where oetype_name=? ");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(buf.toString()); 
		db.setString(1, typeBean.getOetype_name());
		db.executePrepared();
		if(db.size() > 0 ){
			return true;
		} else {
			return false;
		}
	}
	
	/**
	 * @Description 查找所有设备信息
	 * @param typeBean 类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public List<OfficeEquipmentTypeBean> findAll() throws SQLException {
		List<OfficeEquipmentTypeBean> list = new ArrayList<OfficeEquipmentTypeBean>();
		StringBuffer buf = new StringBuffer();
		buf.append("select");
		buf.append(" oetype_id, oetype_name, oetype_remark , oetype_no ");
		buf.append(" from ymj_oa_office_equipmenttype  ");
		PreparedDBUtil db = new PreparedDBUtil();
		
		db.preparedSelect(buf.toString()); 
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {  
			OfficeEquipmentTypeBean ab = new OfficeEquipmentTypeBean();
			ab.setOetype_id(db.getString(i, "oetype_id"));
			ab.setOetype_name(db.getString(i, "oetype_name"));
			ab.setOetype_remark(db.getString(i, "oetype_remark"));
			ab.setOetype_no(db.getInt(i, "oetype_no"));
			list.add(ab);
		}
		return list;
	}

}
