package com.chinacreator.xtbg.zhangjiajie.inforeported.dao.imploracle;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.dao.UnitsetupDao;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.UnitsetupBean;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:UnitsetupDaoImpl.java</p>
 *<p>Description:上报单位Dao接口实现类</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-2-20
 */
public class UnitsetupDaoImpl implements UnitsetupDao {

	private static final Logger LOG = Logger.getLogger(UnitsetupDaoImpl.class);
	/**
	 * @Description 根据条件查询上报单位
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findUnitsetupList(UnitsetupBean unitsetupBean,
			String sortName, String sortOrder, long offset, int maxPagesize) {
			PagingBean pb = new PagingBean();
			PreparedDBUtil  db = new PreparedDBUtil ();
			List<UnitsetupBean> list = new ArrayList<UnitsetupBean>();
			StringBuffer sql = new StringBuffer();
			sql.append("select");
			sql.append(" 		a.unitsetup_id,");
			sql.append(" 		a.infotype_id,");
			sql.append(" 		b.infotype_name,");
			sql.append(" 		a.org_id,");
			sql.append(" 		a.infotype_desc,");
			sql.append(" 		a.user_id,");
			sql.append(" 		a.create_time,");
			sql.append(" 		a.unitsetup_name");
			sql.append(" from ta_oa_infre_unitsetup a ");
			sql.append(" left join ta_oa_infre_info_type b on a.infotype_id = b.infotype_id where 1=1 ");

			if (!StringUtil.isBlank(unitsetupBean.getOrg_id())) {
				
				sql.append(" and a.org_id in ("+StringUtil.getSingleQm(unitsetupBean.getOrg_id())+")");
			}
			
			if (!StringUtil.isBlank(unitsetupBean.getInfotype_id())) {
				sql.append(" and a.infotype_id = '"+unitsetupBean.getInfotype_id()+"'");
			}
			
			sql.append(" order by " + sortName + " " + sortOrder);
			
			try {
		    	db.preparedSelect(sql.toString(), offset, maxPagesize);
		    	db.executePrepared();
			    for(int i = 0;i < db.size();i++){
			    	UnitsetupBean ub = new UnitsetupBean();
			    	ub.setUnitsetup_id(db.getString(i, "unitsetup_id"));
			    	ub.setInfotype_id(db.getString(i, "infotype_id"));
			    	ub.setInfotype_name(db.getString(i, "infotype_name"));
			    	ub.setOrg_id(db.getString(i, "org_id"));
			    	ub.setInfotype_desc(db.getString(i, "infotype_desc"));
			    	ub.setUser_id(db.getString(i, "user_id"));
			    	ub.setCreate_time(db.getString(i, "create_time"));
			    	ub.setUnitsetup_name(db.getString(i, "unitsetup_name"));
			    	list.add(ub);
			    }
		    } catch (SQLException e) {
				LOG.error("执行上报单位列表查询报错："+e.getMessage());
			}
		    pb.setList(list);
		    pb.setRecords((long)db.getTotalSize());
			return pb;

	}

	/**
	 * @Description 添加上报单位
	 * @param UnitsetupBean 上报单位Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void addUnitsetup(UnitsetupBean unitsetupBean) throws SQLException {
		StringBuffer buf = new StringBuffer();
		buf.append(" insert into ta_oa_infre_unitsetup");
		buf.append("                (unitsetup_id, infotype_id, org_id, infotype_desc,user_id,create_time,unitsetup_name)");
		buf.append(" values(seq_infre_unitsetup.nextval, ");
		buf.append("	    ?, ?, ?, ?, sysdate, ?)");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedInsert(buf.toString());
		db.setString(1, unitsetupBean.getInfotype_id());
		db.setString(2, unitsetupBean.getOrg_id());
		db.setString(3, unitsetupBean.getInfotype_desc());
		db.setString(4, unitsetupBean.getUser_id());
		db.setString(5, unitsetupBean.getUnitsetup_name());
		db.executePrepared();
	}

	/**
	 * @Description  删除上报单位
	 * @param unitsetup_id
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean delUnitsetup(String unitsetup_id) throws SQLException {
		String sql = "delete from ta_oa_infre_unitsetup where unitsetup_id in ("+ unitsetup_id + ")";
		PreparedDBUtil db = new PreparedDBUtil();
		db.executeDelete(sql);
		return true;


	}

	/**
	 * @Description 修改上报单位
	 * @param UnitsetupBean  上报单位Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void updateIUnitsetup(UnitsetupBean unitsetupBean) throws SQLException {
		StringBuffer buf = new StringBuffer();
		
		buf.append(" update ta_oa_infre_unitsetup ");
		buf.append("        set infotype_id = ?, infotype_desc = ?");
        buf.append("  where unitsetup_id = ? ");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedUpdate(buf.toString());
		db.setString(1, unitsetupBean.getInfotype_id());
		db.setString(2, unitsetupBean.getInfotype_desc());
		db.setString(3, unitsetupBean.getUnitsetup_id());
		db.executePrepared();

	}

	/**
	 * @Description 根据用户ID获得上报单位信息
	 * @throws SQLException 
	 */
	public UnitsetupBean getUnitsetupBeanById(String id) throws SQLException {
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		unitsetup_id,");
		sql.append(" 		infotype_id,");
		sql.append(" 		org_id,");
		sql.append(" 		infotype_desc,");
		sql.append(" 		user_id,");
		sql.append(" 		create_time,");
		sql.append(" 		unitsetup_name");
		sql.append(" from ta_oa_infre_unitsetup ");
		sql.append("      where unitsetup_id= ?");
		PreparedDBUtil db = new PreparedDBUtil();
		UnitsetupBean unitsetupBean = new UnitsetupBean();
		db.preparedSelect(sql.toString()); 
		db.setString(1, id);
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {  
			unitsetupBean.setUnitsetup_id(db.getString(i, "unitsetup_id"));
			unitsetupBean.setInfotype_id(db.getString(i, "infotype_id"));
			unitsetupBean.setOrg_id(db.getString(i, "org_id"));
			unitsetupBean.setInfotype_desc(db.getString(i, "infotype_desc"));
			unitsetupBean.setUser_id(db.getString(i, "user_id"));
			unitsetupBean.setCreate_time(db.getString(i, "create_time"));
			unitsetupBean.setUnitsetup_name(db.getString(i, "unitsetup_name"));
		}
		return unitsetupBean;

	}

	@Override
	public boolean isExsitUnitsetupInfo4Org(String orgid) throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("select unitsetup_id from ta_oa_infre_unitsetup where org_id = ?");
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, orgid);
		pdb.executePrepared();
		
		boolean isExsit = false;
		if(pdb.size() > 0)
			isExsit = true;
		
		return isExsit;
	}

}
