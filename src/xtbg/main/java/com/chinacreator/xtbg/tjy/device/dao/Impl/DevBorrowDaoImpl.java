
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevborrowDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-6   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.dao.Impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.device.dao.DevBorrowDao;
import com.chinacreator.xtbg.tjy.device.entity.DevBorrowBean;
import com.chinacreator.xtbg.tjy.device.entity.DevChuzuBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:DevBorrowDaoImpl.java</p>
 *<p>Description:设备借用、归还数据库dao接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-6
 */
public class DevBorrowDaoImpl extends XtDbBaseDao implements  DevBorrowDao{

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDevBorrowInfo
	  * @param t_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevBorrowDao#getDevBorrowInfo(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public Map<String, String> getDevBorrowInfo(String t_id, Connection conn)
			throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select t_id,");
		sql.append("       t_fj_id,");
		sql.append("       t_zw_id,");
		sql.append("       t_sb_id,");
		sql.append("       t_jbr_id,");
		sql.append("       t_jre_mc,");
		sql.append("       t_lyorg_id,");
		sql.append("       t_lyorg_mc,");
		sql.append("       t_lydate,");
		sql.append("       t_ghdate,");
		sql.append("       t_sbgly_id,");
		sql.append("       t_sbgly_mc,");
		sql.append("       t_shyj,");
		sql.append("       t_shy_id,");
		sql.append("       t_shy_mc,");
		sql.append("       t_title");
		sql.append("  from ta_oa_devborrow ");
		sql.append(" where t_id = ? ");
		viewMap = queryToSingleMap(conn, sql.toString(), t_id);
		return viewMap;
	}
	
	/**
	*<b>Summary: </b>
	* selDevBorrowInfoList(查询设备借用、归还列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selDevBorrowInfoList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception{
		Connection conn = null;
		DevBorrowBean devborrowbean= new DevBorrowBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				devborrowbean = (DevBorrowBean) JSONObject.parseObject(parmjson, DevBorrowBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select t_id,");
			sql.append("       t_fj_id,");
			sql.append("       t_zw_id,");
			sql.append("       t_sb_id,");
			sql.append("       t_jbr_id,");
			sql.append("       t_jre_mc,");
			sql.append("       t_lyorg_id,");
			sql.append("       t_lyorg_mc,");
			sql.append("       to_char(t_lydate,'yyyy-mm-dd') as t_lydate,");
			sql.append("       to_char(t_ghdate,'yyyy-mm-dd') as t_ghdate,");
			sql.append("       t_sbgly_id,");
			sql.append("       t_sbgly_mc,");
			sql.append("       t_shyj,");
			sql.append("       t_shy_id,");
			sql.append("       t_shy_mc,");
			sql.append("       t_title");
			sql.append("  from ta_oa_devborrow ");
			sql.append("  where 1=1" );
			if(devborrowbean!=null){
				if(!StringUtil.nullOrBlank(devborrowbean.getT_sb_id())){
					//设备ID
					sql.append(" and t_sb_id =? ");
					condition.add(devborrowbean.getT_sb_id());
				}
				//标题
				if (!StringUtil.nullOrBlank(devborrowbean.getT_title())) {
					sql.append(" and t_title like '%'||?||'%'");
					condition.add(devborrowbean.getT_title());
				}
				//标题
				if (!StringUtil.nullOrBlank(devborrowbean.getJieyong_or_chuzu())) {
					if("1".equals(devborrowbean.getJieyong_or_chuzu())){
						sql.append(" and t_money is null ");
					}else{
						sql.append(" and t_money is not null ");
					}
				}
			}
			//排序
			sql.append(" order by " + sortName + " " + sortOrder);
			
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	@Override
	public void saveDevBorrowInfo(DevBorrowBean bean) throws Exception {
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil pb = new PreparedDBUtil();
		sql.append("insert into TA_OA_DEVBORROW ");
		sql.append("(t_id,t_sb_id,t_jbr_id,t_jre_mc,t_lyorg_id,t_lyorg_mc,t_lydate,t_ghdate,t_sbgly_id,t_sbgly_mc,t_title,t_money) ");
		sql.append("  values(?,?,?,?,?,?,sysdate,to_date(?,'YYYY-MM-DD HH24:MI:SS'),?,?,?,?)");
		pb.preparedInsert(sql.toString());
		pb.setString(1, bean.getT_id());
		pb.setString(2, bean.getT_sb_id());
		pb.setString(3, bean.getT_jbr_id());
		pb.setString(4, bean.getT_jre_mc());
		pb.setString(5, bean.getT_lyorg_id());
		pb.setString(6, bean.getT_lyorg_mc());
		//pb.setString(7, bean.getT_lydate().toString());
		pb.setString(7, bean.getT_ghdate().toString());
		pb.setString(8, bean.getT_sbgly_id());
		pb.setString(9, bean.getT_sbgly_mc());
		pb.setString(10, bean.getT_title());
		pb.setString(11, bean.getT_money());
		pb.executePrepared();
	}
	@Override
	public void updateDevBorrowInfo(DevBorrowBean bean) throws Exception {
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil pb = new PreparedDBUtil();
		sql.append(" update TA_OA_DEVRENTOU set t_ghdate = sysdate where t_id = '"+bean.getT_id()+"' ");
		pb.preparedUpdate(sql.toString());
		pb.executePrepared();
	}
	@Override
	public void updateDevDiaobo(String user_orgid, String user_orgname,
			String custos_userid, String custos_username,String id) throws Exception {
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil pb = new PreparedDBUtil();
		if(!StringUtil.isBlank(user_orgid)&&!StringUtil.isBlank(user_orgname)&&!StringUtil.isBlank(custos_userid)&&!StringUtil.isBlank(custos_username)){
			sql.append(" update ta_oa_devaccount set user_orgid = '"+user_orgid+"' ");
			sql.append(" ,user_orgname='"+user_orgname+"' ");
		
			sql.append(" ,custos_userid='"+custos_userid+"' ");
			sql.append(" ,custos_username='"+custos_username+"' ");
			sql.append("where id='"+id+"' ");
			
		}
		
		pb.preparedUpdate(sql.toString());
		pb.executePrepared();
	}
	public boolean updatedev_stockflag(String id,String type) throws Exception {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			StringBuffer sql = new StringBuffer();
			PreparedDBUtil pb = new PreparedDBUtil();
			sql.append("update ta_oa_devaccount set dev_stockflag ='"+type+"' where id='"+id+"' ");
			pb.preparedUpdate(sql.toString());
			pb.executePrepared();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	public boolean updatedev_state(String id,String type) throws Exception {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			StringBuffer sql = new StringBuffer();
			PreparedDBUtil pb = new PreparedDBUtil();
			sql.append("update ta_oa_devaccount set dev_state ='"+type+"' where id='"+id+"' ");
			pb.preparedUpdate(sql.toString());
			pb.executePrepared();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}

	@Override
	public Map<String, String> getDevTransferInfo(String t_id, Connection conn)
			throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select t_id,");
		sql.append("       t_sb_id,");
		sql.append("       t_jbr_id,");
		sql.append("       t_jre_mc,");
		sql.append("       t_lyorg_id,");
		sql.append("       t_lyorg_mc,");
		sql.append("       t_czdate,");
		sql.append("       t_ghdate,");
		sql.append("       t_sbgly_id,");
		sql.append("       t_sbgly_mc,");
		sql.append("       t_title");
		sql.append("  from TA_OA_DEVTRANSFER ");
		sql.append(" where t_id = ? ");
		viewMap = queryToSingleMap(conn, sql.toString(), t_id);
		return viewMap;
	}
}
