package com.chinacreator.xtbg.zhangjiajie.inforeported.dao.imploracle;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.dao.InfoTypeDao;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoTypeBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:InfoTypeDaoImpl.java</p>
 *<p>Description:信息类型Dao接口实现类</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-2-20
 */
public class InfoTypeDaoImpl implements InfoTypeDao {

	private static final Logger LOG = Logger.getLogger(InfoTypeDaoImpl.class);
	/**
	 * @Description 根据条件查询信息类型
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findInfoTypeList(InfoTypeBean infoTypeBean,
			String sortName, String sortOrder, long offset, int maxPagesize) {
			PagingBean pb = new PagingBean();
			PreparedDBUtil  db = new PreparedDBUtil ();
			List<InfoTypeBean> list = new ArrayList<InfoTypeBean>();
			StringBuffer sql = new StringBuffer();
			sql.append("select");
			sql.append(" 		infotype_id,");
			sql.append(" 		infotype_name,");
			sql.append(" 		case when infotype_source='01' then '信息采编' else '每日舆情' end infotype_source,");
			sql.append(" 		infotype_desc");
			sql.append(" from ta_oa_infre_info_type where 1=1 ");

			if (!StringUtils.isEmpty(infoTypeBean.getInfotype_name())) {
				sql.append(" and infotype_name like '%"+infoTypeBean.getInfotype_name()+"%'");
			}
			
			//if (!StringUtils.isEmpty(infoTypeBean.getInfotype_source())) {
			//	sql.append(" and infotype_source = '"+infoTypeBean.getInfotype_source()+"'");
			//}
			
			sql.append(" order by " + sortName + " " + sortOrder);
			
			try {
		    	db.preparedSelect(sql.toString(), offset, maxPagesize);
		    	db.executePrepared();
			    for(int i = 0;i < db.size();i++){
			    	InfoTypeBean it = new InfoTypeBean();
			    	it.setInfotype_id(db.getString(i, "infotype_id"));
			    	it.setInfotype_name(db.getString(i, "infotype_name"));
			    	it.setInfotype_source(db.getString(i, "infotype_source"));
			    	it.setInfotype_desc(db.getString(i, "infotype_desc"));
			    	list.add(it);
			    }
		    } catch (SQLException e) {
				LOG.error("执行信息类型列表查询报错："+e.getMessage());
			}
		    pb.setList(list);
		    pb.setRecords((long)db.getTotalSize());
			return pb;

	}

	/**
	 * @Description 添加信息类型
	 * @param InfoTypeBean 信息类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void addInfoType(InfoTypeBean infoTypeBean) throws SQLException {
		StringBuffer buf = new StringBuffer();
		buf.append(" insert into ta_oa_infre_info_type");
		buf.append("                (infotype_id, infotype_name, infotype_source, infotype_desc)");
		buf.append(" values(seq_infre_info_type.nextval, ");
		buf.append("	    ?, ?, ?)");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedInsert(buf.toString());
		db.setString(1, infoTypeBean.getInfotype_name());
		db.setString(2, "01");
		db.setString(3, infoTypeBean.getInfotype_desc());
		db.executePrepared();
	}

	/**
	 * @Description  删除信息类型
	 * @param userIds
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean delInfoType(String infotype_id) throws SQLException {
		PreparedDBUtil db = new PreparedDBUtil();
		String sql1 = "select count(infotype_id) as infotype_Id from ta_oa_infre_submitted_info s where s.infotype_id in("+ infotype_id + ")";
		db.preparedSelect(sql1.toString());
		db.executePrepared();
		 int count = Integer.parseInt(db.getString(0,"infotype_Id").toString());
		 if(count >0 )
		 {
			 return false;
		 }
		String sql = "delete from ta_oa_infre_info_type where infotype_id in ("+ infotype_id + ")";
		
		db.executeDelete(sql);
		return true;


	}

	/**
	 * @Description 修改信息类型
	 * @param InfoTypeBean  信息类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void updateInfoType(InfoTypeBean infoTypeBean) throws SQLException {
		StringBuffer buf = new StringBuffer();
		
		buf.append(" update ta_oa_infre_info_type ");
		buf.append("        set infotype_name = ?, infotype_desc = ?");
        buf.append("  where infotype_id = ? ");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedUpdate(buf.toString());
		db.setString(1, infoTypeBean.getInfotype_name());
		db.setString(2, infoTypeBean.getInfotype_desc());
		db.setString(3, infoTypeBean.getInfotype_id());
		db.executePrepared();

	}

	/**
	 * @Description 根据用户ID获得信息类型
	 * @param userBean 用户Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public InfoTypeBean getInfoTypeBeanById(String id) throws SQLException {
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		infotype_id,");
		sql.append(" 		infotype_name,");
		sql.append(" 		infotype_source,");
		sql.append(" 		infotype_desc");
		sql.append(" from ta_oa_infre_info_type ");
		sql.append("      where infotype_id= ?");
		PreparedDBUtil db = new PreparedDBUtil();
		InfoTypeBean infoTypeBean = new InfoTypeBean();
		db.preparedSelect(sql.toString()); 
		db.setString(1, id);
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {  
			infoTypeBean.setInfotype_id(db.getString(i, "infotype_id"));
			infoTypeBean.setInfotype_name(db.getString(i, "infotype_name"));
			infoTypeBean.setInfotype_source(db.getString(i, "infotype_source"));
			infoTypeBean.setInfotype_desc(db.getString(i, "infotype_desc"));
		}
		return infoTypeBean;

	}

}
