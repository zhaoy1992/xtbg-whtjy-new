package com.chinacreator.xtbg.zhangjiajie.inforeported.dao.imploracle;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.dao.ReleaseunitDao;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.ReleaseunitBean;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:ReleaseunitDaoImpl.java</p>
 *<p>Description:发布栏目Dao接口实现类</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-2-20
 */
public class ReleaseunitDaoImpl implements ReleaseunitDao {

	private static final Logger LOG = Logger.getLogger(ReleaseunitDaoImpl.class);
	/**
	 * @Description 根据条件查询发布栏目
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findReleaseunitList(ReleaseunitBean releaseunitBean,
			String sortName, String sortOrder, long offset, int maxPagesize) {
			PagingBean pb = new PagingBean();
			PreparedDBUtil  db = new PreparedDBUtil ();
			List<ReleaseunitBean> list = new ArrayList<ReleaseunitBean>();
			StringBuffer sql = new StringBuffer();
			sql.append("select");
			sql.append(" 		a.releaseunit_id,");
			sql.append(" 		a.infotype_id,");
			sql.append(" 		b.infotype_name,");
			sql.append(" 		a.rec_personid,");
			sql.append(" 		a.rec_person_name,");
			sql.append(" 		a.user_id,");
			sql.append(" 		a.create_time,");
			sql.append(" 		a.releaseunit_name");
			sql.append(" from ta_oa_infre_releaseunit a ");
			sql.append(" left join ta_oa_infre_info_type b on a.infotype_id = b.infotype_id where 1=1 ");

			if (!StringUtil.isBlank(releaseunitBean.getReleaseunit_name())) {
				sql.append(" and a.releaseunit_name like '%"+releaseunitBean.getReleaseunit_name()+"%'");
			}
			
			if (!StringUtil.isBlank(releaseunitBean.getInfotype_id())) {
				sql.append(" and a.infotype_id = '"+releaseunitBean.getInfotype_id()+"'");
			}
			
			sql.append(" order by " + sortName + " " + sortOrder);
			
			try {
		    	db.preparedSelect(sql.toString(), offset, maxPagesize);
		    	db.executePrepared();
			    for(int i = 0;i < db.size();i++){
			    	ReleaseunitBean rb = new ReleaseunitBean();
			    	rb.setReleaseunit_id(db.getString(i, "releaseunit_id"));
			    	rb.setInfotype_id(db.getString(i, "infotype_id"));
			    	rb.setInfotype_name(db.getString(i, "infotype_name"));
			    	rb.setRec_personid(db.getString(i, "rec_personid"));
			    	rb.setRec_person_name(db.getString(i, "rec_person_name"));
			    	rb.setUser_id(db.getString(i, "user_id"));
			    	rb.setCreate_time(db.getString(i, "create_time"));
			    	rb.setReleaseunit_name(db.getString(i, "releaseunit_name"));
			    	list.add(rb);
			    }
		    } catch (SQLException e) {
				LOG.error("执行发布栏目列表查询报错："+e.getMessage());
			}
		    pb.setList(list);
		    pb.setRecords((long)db.getTotalSize());
			return pb;

	}

	/**
	 * @Description 添加发布栏目
	 * @param ReleaseunitBean 发布栏目Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void addReleaseunit(ReleaseunitBean releaseunitBean) throws SQLException {
		StringBuffer buf = new StringBuffer();
		buf.append(" insert into ta_oa_infre_releaseunit");
		buf.append("                (releaseunit_id, infotype_id, rec_personid, rec_person_name, user_id, create_time, releaseunit_name)");
		buf.append(" values(seq_infre_releaseunit.nextval, ");
		buf.append("	    ?, ?, ?, ?, sysdate, ?)");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedInsert(buf.toString());
		db.setString(1, releaseunitBean.getInfotype_id());
		db.setString(2, releaseunitBean.getRec_personid());
		db.setString(3, releaseunitBean.getRec_person_name());
		db.setString(4, releaseunitBean.getUser_id());
		db.setString(5, releaseunitBean.getReleaseunit_name());
		db.executePrepared();
	}

	/**
	 * @Description  删除发布栏目
	 * @param releaseunit_id
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean delReleaseunit(String releaseunit_id) throws SQLException {
		String sql = "delete from ta_oa_infre_releaseunit where releaseunit_id in ("+ releaseunit_id + ")";
		PreparedDBUtil db = new PreparedDBUtil();
		db.executeDelete(sql);
		return true;


	}

	/**
	 * @Description 修改发布栏目
	 * @param ReleaseunitBean  发布栏目Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void updateReleaseunit(ReleaseunitBean releaseunitBean) throws SQLException {
		StringBuffer buf = new StringBuffer();
		
		buf.append(" update ta_oa_infre_releaseunit ");
		buf.append("        set infotype_id = ?, rec_personid = ?, rec_person_name = ?, releaseunit_name = ?");
        buf.append("  where releaseunit_id = ? ");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedUpdate(buf.toString());
		db.setString(1, releaseunitBean.getInfotype_id());
		db.setString(2, releaseunitBean.getRec_personid());
		db.setString(3, releaseunitBean.getRec_person_name());
		db.setString(4, releaseunitBean.getReleaseunit_name());
		db.setString(5, releaseunitBean.getReleaseunit_id());
		db.executePrepared();

	}

	/**
	 * @Description 根据用户ID获得发布栏目信息
	 * @return boolean
	 * @throws SQLException 
	 */
	public ReleaseunitBean getReleaseunitBeanById(String id) throws SQLException {
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		releaseunit_id,");
		sql.append(" 		infotype_id,");
		sql.append(" 		rec_personid,");
		sql.append(" 		rec_person_name,");
		sql.append(" 		user_id,");
		sql.append(" 		create_time,");
		sql.append(" 		releaseunit_name");
		sql.append(" from ta_oa_infre_releaseunit");
		sql.append("      where releaseunit_id= ?");
		PreparedDBUtil db = new PreparedDBUtil();
		ReleaseunitBean releaseunitBean = new ReleaseunitBean();
		db.preparedSelect(sql.toString()); 
		db.setString(1, id);
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {  
			releaseunitBean.setReleaseunit_id(db.getString(i, "releaseunit_id"));
			releaseunitBean.setInfotype_id(db.getString(i, "infotype_id"));
			releaseunitBean.setRec_personid(db.getString(i, "rec_personid"));
			releaseunitBean.setRec_person_name(db.getString(i, "rec_person_name"));
			releaseunitBean.setUser_id(db.getString(i, "user_id"));
			releaseunitBean.setCreate_time(db.getString(i, "create_time"));
			releaseunitBean.setReleaseunit_name(db.getString(i, "releaseunit_name"));
		}
		return releaseunitBean;

	}

}
