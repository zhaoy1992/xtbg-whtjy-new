package com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.officeassets.dao.OfficeConsumeTypeDao;
import com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeConsumeTypeBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * <p>
 * Title:OfficeEquipmentTypeTypeDaoImpl.java
 * </p>
 * <p>
 * Description:类型信息实例类
 * </p>
 * <p>
 * Company:湖南科创
 * </p>
 * 
 * @author 刘春元
 * @version 1.0 2012-3-6
 */
public class OfficeConsumeTypeDaoImpl implements OfficeConsumeTypeDao {

	private static final Logger LOG = Logger
			.getLogger(OfficeConsumeTypeDaoImpl.class);

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

	public PagingBean findTypeList(OfficeConsumeTypeBean typeBean,
			String sortName, String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil db = new PreparedDBUtil();
		List<OfficeConsumeTypeBean> list = new ArrayList<OfficeConsumeTypeBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" ocname_id, ocname_name,ocname_no, ocname_remark ");
		sql.append(" from ymj_oa_office_consumablename where 1=1 ");
		if (!StringUtil.nullOrBlank(typeBean.getOcname_name())) {
			sql = sql.append(" and ocname_name like '%"
					+ typeBean.getOcname_name() + "%'");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
		try {
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.executePrepared();
			for (int i = 0; i < db.size(); i++) {
				OfficeConsumeTypeBean ab = new OfficeConsumeTypeBean();
				ab.setOcname_id(db.getString(i, "ocname_id"));
				ab.setOcname_name(db.getString(i, "ocname_name"));
				ab.setOcname_remark(db.getString(i, "ocname_remark"));
				ab.setOcname_no(db.getInt(i, "ocname_no"));
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
	 * @Description 添加类型信息
	 * @param typeBean
	 *            类型Bean
	 * @return boolean
	 * @throws SQLException
	 */
	public void addOe(OfficeConsumeTypeBean oeBean) throws SQLException {
		StringBuffer buf = new StringBuffer();
		buf.append(" insert into ymj_oa_office_consumablename");
		buf.append(" (ocname_id, ocname_name, ocname_remark,ocname_no)");
		buf.append(" values(SEQ_OFFICEEQUIPMENTTYPE.nextval,  ?, ?, ?)");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedInsert(buf.toString());
		db.setString(1, oeBean.getOcname_name());
		db.setString(2, oeBean.getOcname_remark());
		db.setInt(3, oeBean.getOcname_no());
		db.executePrepared();
	}

	/**
	 * @Description 修改类型信息
	 * @param typeBean
	 *            类型Bean
	 * @return boolean
	 * @throws SQLException
	 */
	public void updateType(OfficeConsumeTypeBean oeBean) throws SQLException {
		StringBuffer buf = new StringBuffer();
		buf.append(" update ymj_oa_office_consumablename ");
		buf.append(" set ocname_name=?, ocname_remark=?,ocname_no=? where ocname_id = ?");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedUpdate(buf.toString());
		db.setString(1, oeBean.getOcname_name());
		db.setString(2, oeBean.getOcname_remark());
		db.setInt(3, oeBean.getOcname_no());
		db.setString(4, oeBean.getOcname_id());
		db.executePrepared();
	}

	/**
	 * @Description 删除类型信息
	 * @param userIds
	 * @return boolean
	 * @throws SQLException
	 */
	public boolean delType(String userIds) throws SQLException {
		String sql = "delete from ymj_oa_office_consumablename where ocname_id in ("
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
	public OfficeConsumeTypeBean getTypeBeanById(String id) throws SQLException {
		StringBuffer buf = new StringBuffer();
		buf.append("select");
		buf.append(" ocname_id, ocname_name, ocname_remark, ocname_no ");
		buf.append(" from ymj_oa_office_consumablename where ocname_id=? ");
		PreparedDBUtil db = new PreparedDBUtil();
		OfficeConsumeTypeBean ab = new OfficeConsumeTypeBean();
		db.preparedSelect(buf.toString());
		db.setString(1, id);
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {
			ab.setOcname_id(db.getString(i, "ocname_id"));
			ab.setOcname_name(db.getString(i, "ocname_name"));
			ab.setOcname_remark(db.getString(i, "ocname_remark"));
			ab.setOcname_no(db.getInt(i, "ocname_no"));
		}
		return ab;
	}
	
	/**
	 * @Description 根据名称获得易耗品类型
	 * @param typeBean 易耗品类型Bean
	 * @return OfficeConsumeTypeBean
	 * @throws SQLException 
	 */
	public boolean findTypeBeanByName(OfficeConsumeTypeBean typeBean) throws SQLException{
		StringBuffer buf = new StringBuffer();
		buf.append("select");
		buf.append(" ocname_id, ocname_name, ocname_remark, ocname_no ");
		buf.append(" from ymj_oa_office_consumablename where ocname_name=? ");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(buf.toString());
		db.setString(1, typeBean.getOcname_name());
		db.executePrepared();
		if(db.size() > 0){
			return true;
		} else{
			return false;
		}
	}
	
	/**
	 * @Description 查找所有数据
	 * @return List
	 * @throws SQLException
	 */
	public List<OfficeConsumeTypeBean> findAll() throws SQLException {
		List<OfficeConsumeTypeBean> list = new ArrayList<OfficeConsumeTypeBean>();
		StringBuffer buf = new StringBuffer();
		buf.append("select");
		buf.append(" ocname_id, ocname_name, ocname_remark,ocname_no");
		buf.append(" from ymj_oa_office_consumablename  ");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(buf.toString());
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {
			OfficeConsumeTypeBean ab = new OfficeConsumeTypeBean();
			ab.setOcname_id(db.getString(i, "ocname_id"));
			ab.setOcname_name(db.getString(i, "ocname_name"));
			ab.setOcname_remark(db.getString(i, "ocname_remark"));
			ab.setOcname_no(db.getInt(i, "ocname_no"));
			list.add(ab);
		}
		return list;
	}
	/**
	 * @Description 根据类型ID查询易耗品库信息
	 * @param id  类型ID
	 * @return boolean
	 * @throws Exception 
	 */
	public boolean findConByTypeId(String id) throws Exception{
		StringBuffer buf = new StringBuffer();
		buf.append("select");
		buf.append(" *     ");
		buf.append(" from ymj_oa_officeconstock  where type_id in ("+ id +")");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(buf.toString());
		db.executePrepared();
		if(db.size()>0){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * @Description 根据排序号 判断是否存在类型排序号
	 * @param id  排序号
	 * @return boolean
	 * @throws Exception 
	 */
	public boolean findConByTypeNo(String id) throws Exception{
		StringBuffer buf = new StringBuffer();
		buf.append("select");
		buf.append(" *     ");
		buf.append(" from ymj_oa_office_consumablename  where oetype_no in ("+ id +")");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(buf.toString());
		db.executePrepared();
		if(db.size()>0){
			return true;
		}else{
			return false;
		}
	}
}
