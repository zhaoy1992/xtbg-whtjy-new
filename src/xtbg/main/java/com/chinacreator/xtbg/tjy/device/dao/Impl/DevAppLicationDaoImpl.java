package com.chinacreator.xtbg.tjy.device.dao.Impl;

import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.tjy.device.dao.DevAppLicationDao;
import com.chinacreator.xtbg.tjy.device.entity.DevAppLicationBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:DevAppLicationDaoImpl.java</p>
 *<p>Description:仪器设备采购业务数据固话层实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-4
 */
public class DevAppLicationDaoImpl implements DevAppLicationDao {

	/**
	 * 
	  * <b>Summary:查询出已办结的仪器设备采购列表 </b>
	  *     复写方法 findDevAppLicationList
	  * @param devAppLicationBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevAppItemDao#findDevAppItemList(com.chinacreator.xtbg.tjy.device.entity.DevAppItem, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findDevAppLicationList(DevAppLicationBean devAppLicationBean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<DevAppLicationBean> list = new ArrayList<DevAppLicationBean>();
		StringBuffer sql = new StringBuffer();
		
		sql.append("select t.t_id,");
		sql.append("       t.t_fj_id,");
		sql.append("       t.t_zw_id,");
		sql.append("       t.t_orgid,");
		sql.append("       t.t_orgname,");
		sql.append("       t.t_creatortime,");
		sql.append("       t.t_title,");
		sql.append("       t.t_jskyj,");
		sql.append("       t.t_zgcsyj,");
		sql.append("       t.t_ycyj");
		sql.append("       from ta_oa_devapplication t, view_oa_instance v");
		sql.append("       where t.t_id = v.BUSI_ID");
		sql.append("       and v.ACT_DEFID = 'sbzfcg_wp1_act5'");
		sql.append(" order by " + sortName + " " + sortOrder);
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
			DevAppLicationBean devAppLicationListBean = new DevAppLicationBean();
			devAppLicationListBean.setT_id(db.getString(i, "t_id"));
			devAppLicationListBean.setT_fj_id(db.getString(i, "t_fj_id"));
			devAppLicationListBean.setT_zw_id(db.getString(i, "t_zw_id"));
			devAppLicationListBean.setT_orgid(db.getString(i, "t_orgid"));
			devAppLicationListBean.setT_orgname(db.getString(i, "t_orgname"));
			devAppLicationListBean.setT_creatortime(db.getString(i, "t_creatortime"));
			devAppLicationListBean.setT_title(db.getString(i, "t_title"));
			devAppLicationListBean.setT_jskyj(db.getString(i, "t_jskyj"));
			devAppLicationListBean.setT_zgcsyj(db.getString(i, "t_zgcsyj"));
			devAppLicationListBean.setT_ycyj(db.getString(i, "t_ycyj"));
			
	    	list.add(devAppLicationListBean);
	    }
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

}
