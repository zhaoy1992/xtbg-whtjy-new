package com.chinacreator.xtbg.pub.personwork.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.personwork.dao.PriManageDao;
import com.chinacreator.xtbg.pub.personwork.entity.PGroupBean;
import com.chinacreator.xtbg.pub.personwork.entity.PriManageBean;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class PriManageDaoImpl implements PriManageDao {

	private static final Logger LOG = Logger.getLogger(PriManageDaoImpl.class);
	private String MGRNAME_SPLIT_TOKEN = "#";
	/**
	 * 查询登录用户权限下的所有公共通讯录条目
	 * return pb 分页实体 PagingBean
	 * 
	 */
	public PagingBean findPriManageBeanList(PriManageBean prBean,
			String sortName, String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<PriManageBean> list = new ArrayList<PriManageBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		u.user_realname,");
		sql.append("        r.leaders, ");
		sql.append("        r.user_id");
		sql.append(" from td_sm_user u,ta_oa_personwork_role r ");
		sql.append(" where u.user_id=r.user_id ");
		try {
	    	db.preparedSelect(sql.toString(), offset, maxPagesize);
	    	db.executePrepared();
		    for(int i = 0;i < db.size();i++){
		    	PriManageBean pib = new PriManageBean();
		    	pib.setLoginUserName(db.getString(i, "user_realname"));
		    	pib.setLeaders(db.getString(i, "leaders"));
		    	pib.setLeadID(db.getString(i, "user_id"));
		    	list.add(pib);
		    }
	    } catch (SQLException e) {
			LOG.error("执行流程列表查询报错："+e.getMessage());
		}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}
	/**
	 * 增加条目
	 */
	public boolean insertPrivilege(PriManageBean prBean){
		boolean flag=true;
		PreparedDBUtil db=new PreparedDBUtil();
		StringBuffer sql=new StringBuffer();
		sql.append("insert into ta_oa_personwork_role (role_id,user_id,leaders,leaders_userid) ");
		sql.append("values(seq_personwork_role.nextval,?,?,?)");
		try {
			db.preparedInsert(sql.toString());
			db.setString(1, StringUtil.deNull(prBean.getLeadID()));
			db.setString(2, StringUtil.deNull(prBean.getPersons()));
			db.setString(3, StringUtil.deNull(prBean.getPersonsID()));
			db.executePrepared();
		} catch (SQLException e) {
			flag=false;
		}
		return flag;
	}
	
	/**
	 * 查询用户id是否已经存在
	 */
	public List queryUserID(PriManageBean pBean){
		PreparedDBUtil db=new PreparedDBUtil();
		List list=new ArrayList();
		StringBuffer sql=new StringBuffer();
		sql.append("select user_id,leaders,leaders_userid  from ta_oa_personwork_role where user_id=? ");
		try {
			db.preparedSelect(sql.toString());
			db.setString(1, pBean.getLeadID());
			db.executePrepared();
			if(db.size()!=0){
				for(int i=0;i<db.size();i++){
					pBean.setReLeaders(db.getString(i, "leaders"));
					pBean.setRepersonsID(db.getString(i, "leaders_userid"));
					list.add(pBean);
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	/**
	 * 更新数据
	 */
	public boolean updatePriInfo(PriManageBean pBean){
		PreparedDBUtil db=new PreparedDBUtil();
		StringBuffer sql=new StringBuffer();
		boolean flag=true;
		sql.append("update");
		sql.append(" ta_oa_personwork_role set leaders = ? , leaders_userid =?  ");
		sql.append(" where user_id= ? ");
		try {
			db.preparedUpdate(sql.toString());
			db.setString(1, pBean.getPersons());
			db.setString(2, pBean.getPersonsID());
			db.setString(3, pBean.getLeadID());
			db.executePrepared();
		} catch (SQLException e) {
			flag=false;
		}
		return flag;
	}
	
	/**
	 * 删除记录
	 */
	public boolean deletePriInfo(PriManageBean pBean){
		PreparedDBUtil db=new PreparedDBUtil();
		StringBuffer sql=new StringBuffer();
		boolean flag=true;
		sql.append("delete");
		sql.append(" from ta_oa_personwork_role ");
		sql.append(" where user_id = ? ");
		try {
			db.preparedDelete(sql.toString());
			db.setString(1, pBean.getLeadID());
			db.executePrepared();
		} catch (SQLException e) {
			flag=false;
		}
		
		return flag;
	}
	/**
	 * 查询单条记录
	 */
	public PriManageBean querySingle(PriManageBean pBean){
		PreparedDBUtil db=new PreparedDBUtil();
		StringBuffer sql=new StringBuffer();
		sql.append("select");
		sql.append(" r.leaders, u.user_realname from ta_oa_personwork_role r,td_sm_user u  ");
		sql.append(" where u.user_id=? and r.user_id=? ");
		try {
			db.preparedSelect(sql.toString());
			db.setString(1, pBean.getLeadID());
			db.setString(2, pBean.getLeadID());
			db.executePrepared();
			for (int i = 0; i < db.size(); i++) {
				pBean.setLeadName(db.getString(i, "user_realname"));
				pBean.setPersons(db.getString(i, "leaders"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return pBean;
	}
	
	/**
	 * 查询分组表 
	 */
	public PagingBean queryGroup(PGroupBean pbGroupBean,
			String sortName, String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<PGroupBean> list = new ArrayList<PGroupBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		rownum , ");
		sql.append("        group_name, ");
		sql.append("        group_id ");
		sql.append(" from ta_oa_personwork_group ");
		sql.append(" where user_id = ? ");
		try {
	    	db.preparedSelect(sql.toString(), offset, maxPagesize);
	    	db.setString(1, pbGroupBean.getLoginUserID());
	    	db.executePrepared();
		    for(int i = 0;i < db.size();i++){
		    	PGroupBean pgb=new PGroupBean();
		    	pgb.setRownum(db.getString(i, "rownum"));
		    	pgb.setGroupName(db.getString(i, "group_name"));
		    	pgb.setGroupID(db.getString(i, "group_id"));
		    	list.add(pgb);
		    }
	    } catch (SQLException e) {
			LOG.error("执行流程列表查询报错："+e.getMessage());
		}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}
	
	@Override
	public List<PGroupBean> queryGroup4List(PGroupBean pbGroupBean) {
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<PGroupBean> list = new ArrayList<PGroupBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		rownum , ");
		sql.append("        group_name, ");
		sql.append("        group_id ");
		sql.append(" from ta_oa_personwork_group ");
		sql.append(" where user_id = ? ");
		try {
			db.preparedSelect(sql.toString());
	    	db.setString(1, pbGroupBean.getLoginUserID());
	    	db.executePrepared();
		    for(int i = 0;i < db.size();i++){
		    	PGroupBean pgb=new PGroupBean();
		    	pgb.setRownum(db.getString(i, "rownum"));
		    	pgb.setGroupName(db.getString(i, "group_name"));
		    	pgb.setGroupID(db.getString(i, "group_id"));
		    	list.add(pgb);
		    }
		} catch (SQLException e) {
			LOG.error("执行通讯录分组列表查询报错："+e.getMessage());
		}
		return list;
	}
	
	public PGroupBean queryGroup(String groupId){
		PGroupBean pgb=new PGroupBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append("        group_name");

		sql.append(" from ta_oa_personwork_group ");
		sql.append(" where group_id = ? ");
		
		try {
			db.preparedSelect(sql.toString());
	    	db.setString(1, groupId);
	    	db.executePrepared();
		    if(db.size() > 0){
		    	pgb.setGroupName(db.getString(0, "group_name"));
		    }
		} catch (SQLException e) {
			LOG.error("执行分组查询报错："+e.getMessage());
		}
		return pgb;
	}
	/**
	 * 增加分组
	 */
	public boolean insertGroup(PGroupBean pGroupBean){
		boolean flag=true;
		PreparedDBUtil db=new PreparedDBUtil();
		StringBuffer sql=new StringBuffer();
		sql.append(" insert into ta_oa_personwork_group (group_id,user_id,group_name) ");
		sql.append(" values (seq_personwork_group.nextval, ? , ? ) ");
		try {
			db.preparedInsert(sql.toString());
			db.setString(1, StringUtil.deNull(pGroupBean.getLoginUserID()));
			db.setString(2, StringUtil.deNull(pGroupBean.getGroupName()));
			db.executePrepared();
		} catch (SQLException e) {
			flag=false;
		}
		return flag;
	}
	
	/**
	 * 更新分组
	 */
	public boolean updateGroup(PGroupBean pGroupBean){
		boolean flag=true;
		PreparedDBUtil db=new PreparedDBUtil();
		StringBuffer sql=new StringBuffer();
		sql.append(" update ta_oa_personwork_group set group_name=?  ");
		sql.append(" where group_id =  ?  ");
		try {
			db.preparedInsert(sql.toString());
			db.setString(1, StringUtil.deNull(pGroupBean.getGroupName()));
			db.setString(2, StringUtil.deNull(pGroupBean.getGroupID()));
			db.executePrepared();
		} catch (SQLException e) {
			flag=false;
		}
		return flag;
	}
	/**
	 * 查询分组是否已存在
	 */
	public boolean queryExist(PGroupBean pGroupBean){
		boolean flag=true;
		PreparedDBUtil db=new PreparedDBUtil();
		StringBuffer sql=new StringBuffer();
		sql.append(" select * from ta_oa_personwork_group ");
		sql.append(" where group_name= ? and user_id= ? ");
		try {
			db.preparedSelect(sql.toString());
			db.setString(1, StringUtil.deNull(pGroupBean.getGroupName()));
			db.setString(2, StringUtil.deNull(pGroupBean.getLoginUserID()));
			db.executePrepared();
			if(db.size()!=0){
				flag=false;
			}
		} catch (SQLException e) {
			e.getMessage();
		}
		return flag;
	}
	
	/**
	 * 删除分组
	 */
	public boolean deleteGroup(PGroupBean pGroupBean){
		boolean flag=true;
		PreparedDBUtil db=new PreparedDBUtil();
		PreparedDBUtil dbd=new PreparedDBUtil();
		StringBuffer sql=new StringBuffer();
		StringBuffer sqld=new StringBuffer();
		if(!StringUtil.nullOrBlank(pGroupBean.getGroupID())){
			sql.append(" delete from ta_oa_personwork_persongroup ");
			if(pGroupBean.getGroupID().indexOf(",") != -1){
				sql.append(" where group_id in (").append(StringUtil.deNull(pGroupBean.getGroupID())).append(")");
			}else{
				sql.append(" where group_id = '").append(StringUtil.deNull(pGroupBean.getGroupID())).append("'");
			}
			
			sqld.append(" delete from ta_oa_personwork_group ");
			if(pGroupBean.getGroupID().indexOf(",") != -1){
				sqld.append(" where group_id in (").append(StringUtil.deNull(pGroupBean.getGroupID())).append(")");
			}else{
				sqld.append(" where group_id = '").append(StringUtil.deNull(pGroupBean.getGroupID())).append("'");
			}
			
			try {
				db.preparedDelete(sql.toString());
				dbd.preparedDelete(sqld.toString());
				db.executePrepared();
				dbd.executePrepared();
			} catch (SQLException e) {
				flag=false;
			}
		}
		
		return flag;
	}
	
	
}
