package com.chinacreator.xtbg.pub.core.dao.imploracle;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.core.dao.OrgTypeDao;
import com.chinacreator.xtbg.pub.core.entity.OrgTypeBean;
import com.frameworkset.common.poolman.DBUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * <p>
 * Title:OrgTypeImpl.java
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright:Copyright (c) 2011
 * </p>
 * <p>
 * Company:湖南科创
 * </p>
 * 
 * @author 刘健
 * @version 1.0 2011-4-16
 */
public class OrgTypeDaoImpl implements OrgTypeDao {
	
	private static final Logger LOG = Logger.getLogger(OrgTypeDaoImpl.class);
	/**
	 * 获得机构类型
	 */
	public List<OrgTypeBean> getOrgType() throws SQLException {
		List<OrgTypeBean> list = new ArrayList<OrgTypeBean>();
		String sql = "select  o.name,o.typeVal from ta_dic_orgtype o where o.state=1";
		DBUtil db = new DBUtil();
		db.executeSelect(sql);
		for (int i = 0; i < db.size(); i++) {
			OrgTypeBean orgType = new OrgTypeBean();
			orgType.setName(db.getString(i, "name"));
			orgType.setTypeVal(db.getString(i, "typeVal"));
			list.add(orgType);
		}
		return list;
	}

	@Override
	public PagingBean findOrgTypeList(OrgTypeBean beanJson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<OrgTypeBean> list = new ArrayList<OrgTypeBean>();
		String sql = "select id,name,typeval,createat,state,decode(state,2,'无效',1,'有效') as status from ta_dic_orgtype where state<>0";
		if(beanJson != null) {
			if (!StringUtils.isEmpty(beanJson.getName())) {
				sql += " and instr(name,'"+beanJson.getName()+"')>0";
			}
			
			if (!StringUtils.isEmpty(beanJson.getTypeVal())) {
				sql += " and typeval = '" + beanJson.getTypeVal()+"'";
			}
		}
		sql += " order by " + sortName + " " + sortOrder;
		try {
	    	db.preparedSelect(sql.toString(), offset, maxPagesize);
	    	db.executePrepared();
		    for(int i = 0;i < db.size();i++){
		    	OrgTypeBean entity = new OrgTypeBean();
		    	entity.setId(db.getString(i, "id"));
		    	entity.setName(db.getString(i, "name"));
		    	entity.setTypeVal(db.getString(i, "typeVal"));
		    	entity.setCreateAt(db.getString(i, "createAt"));
		    	entity.setState(db.getInt(i,"state"));
		    	entity.setStatus(db.getString(i, "status"));
		    	list.add(entity);
		    }
	    } catch (SQLException e) {
			LOG.error("执行机构类型列表查询报错："+e.getMessage());
		}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	@Override
	public void addOrgType(OrgTypeBean entity) throws SQLException {
		String sql = "insert into ta_dic_orgtype(id,name,typeval,createat,state) values (SEQ_DIC_ORGTYPE.NEXTVAL,?,?,sysdate,?)";
		 
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedInsert(sql);
		db.setString(1, entity.getName());
		db.setString(2, entity.getTypeVal());
		db.setInt(3, entity.getState());
		db.executePrepared();
	}

	@Override
	public boolean delOrgType(String delIds) throws SQLException {
		//String sql = "update ta_dic_orgtype set state=0 where id in ("+ delIds + ")";
		String sql = "delete from ta_dic_orgtype where id in ("+ delIds + ")";
		PreparedDBUtil db = new PreparedDBUtil();
		db.executeDelete(sql);
		return true;
	}

	@Override
	public void updateOrgType(OrgTypeBean entity) throws SQLException {
		String sql = "update ta_dic_orgtype set name=?,typeval=?,state=? where id=?";
		
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedUpdate(sql);
		db.setString(1, entity.getName());
		db.setString(2, entity.getTypeVal());
		db.setInt(3, entity.getState());
		db.setString(4, entity.getId());
		db.executePrepared();
	}

	@Override
	public OrgTypeBean getOrgTypeBeanById(String id) throws SQLException {
		String sql = "select name,typeval,createat,state,decode(state,0,'无效','有效') as status from ta_dic_orgtype where id=?";
		PreparedDBUtil db = new PreparedDBUtil();
		OrgTypeBean entity = new OrgTypeBean();
		db.preparedSelect(sql); 
		db.setString(1, id);
		db.executePrepared();
		if(db.size()>0) {  
			entity.setId(id);
	    	entity.setName(db.getString(0, "name"));
	    	entity.setTypeVal(db.getString(0, "typeVal"));
	    	entity.setCreateAt(db.getString(0, "createAt"));
	    	entity.setState(db.getInt(0,"state"));
	    	entity.setStatus(db.getString(0, "status"));
		}
		return entity;
	}

	@Override
	public void changeOrgTypeState(String ids, String state) throws SQLException {
		String sql = "update ta_dic_orgtype set state="+state+" where id in ("+ ids + ")";
		PreparedDBUtil db = new PreparedDBUtil();
		db.executeDelete(sql);
	}
}
