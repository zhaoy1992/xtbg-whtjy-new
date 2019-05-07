package com.chinacreator.xtbg.core.guestreception.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.guestreception.dao.GuestreceptionDao;
import com.chinacreator.xtbg.core.guestreception.entity.GuestBeanNew;
import com.chinacreator.xtbg.core.guestreception.entity.GuestReceiveBean;
import com.chinacreator.xtbg.core.guestreception.entity.GuestTravelBean;
import com.chinacreator.xtbg.core.guestreception.entity.GuestreceptionBean;
import com.chinacreator.xtbg.core.guestreception.entity.QueryBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:GuestreceptionDaoImpl.java</p>
 *<p>Description:接待管理实体接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-9-5
 */
public class GuestreceptionDaoImpl extends XtDbBaseDao implements GuestreceptionDao {

	private static final Logger LOG = Logger.getLogger(GuestreceptionDaoImpl.class);
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryGuestInfo
	  * @param guestreceptionBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param pagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.guestreception.dao.GuestreceptionDao#queryGuestInfo(com.chinacreator.xtbg.core.guestreception.entity.GuestreceptionBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean queryGuestInfo(GuestreceptionBean guestreceptionBean,
			String sortName, String sortOrder, long offset, int pagesize) throws Exception {
		Connection conn = null;
		PagingBean pb = new PagingBean();
		StringBuffer sql = new StringBuffer();
		try {
			conn = DbManager.getInstance().getConnection();
			sql.append(" select i.grinfo_id,");
			sql.append(" i.grinfo_titile, ");
			sql.append(" i.grinfo_receptionorg,");
			sql.append(" i.grinfo_startime,");
			sql.append(" i.grinfo_endtime,");
			sql.append(" wm_concat(gu.accompany) accompany,");
			sql.append(" i.grinfo_org, ");
			sql.append("  t.grstatus_name  ");
			sql.append(" from oa_guestreception_info i left join oa_guestreception_type t ");
			sql.append(" on t.grstatus_id=i.grstatus_id ");
			sql.append("left join oa_guesttravel gu on i.grinfo_id = gu.grinfo_id");
			sql.append(" where i.grinfo_sendpersonid= ? ");
	
			if (!StringUtil.nullOrBlank(guestreceptionBean.getGrinfo_titile())) {
				sql.append(" and i.grinfo_titile like '%" + guestreceptionBean.getGrinfo_titile() + "%' ");
			}
			if (!StringUtil .nullOrBlank(guestreceptionBean.getGrinfo_receptionorg())) {
				sql.append(" and i.grinfo_receptionorg like '%" + guestreceptionBean.getGrinfo_receptionorg() + "%'");
			}
			if (!StringUtil.nullOrBlank(guestreceptionBean.getGrinfo_startime())) {
				sql.append(" and i.grinfo_startime >= to_date('" + guestreceptionBean.getGrinfo_startime()+ " 00:00:00','yyyy-mm-dd hh24:mi:ss')  ");
			}
			if (!StringUtil.nullOrBlank(guestreceptionBean.getGrinfo_endtime())) {
				sql.append(" and  i.grinfo_startime <= to_date( '" + guestreceptionBean.getGrinfo_endtime()+ " 23:59:59' ,'yyyy-mm-dd hh24:mi:ss') ");
			}
			
			sql.append(" group by i.grinfo_id,i.grinfo_titile,i.grinfo_receptionorg,i.grinfo_startime,i.grinfo_endtime,i.grinfo_org,t.grstatus_name");
			sql.append(" order by " + sortName + " " + sortOrder);
			pb=queryToPagingBean(sql.toString(), offset, pagesize, conn, guestreceptionBean.getGrinfo_sendpersonid());

		} catch (Exception e) {
			e.printStackTrace();
			LOG.error(e.getMessage(),e);
		}finally{
			DbManager.closeConnection(conn);
		}
		
		return pb;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryViewGuestInfo
	  * @param guestreceptionBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.guestreception.dao.GuestreceptionDao#queryViewGuestInfo(com.chinacreator.xtbg.core.guestreception.entity.GuestreceptionBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean queryViewGuestInfo(GuestreceptionBean guestreceptionBean,
			String sortName, String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		PagingBean pb = new PagingBean();
		StringBuffer sql = new StringBuffer();
		try {
			conn = DbManager.getInstance().getConnection();
			sql.append("select distinct a.grinfo_id, ");
			sql.append("    u.user_realname, ");
			sql.append("    a.grinfo_titile, ");
			sql.append("    a.grinfo_receptionorg, ");
			sql.append("    a.grinfo_startime, ");
			sql.append("    a.grinfo_endtime, ");
			sql.append("    a.grinfo_org, ");
			sql.append("    b.grstatus_id, ");
			sql.append("    b.grstatus_name, ");
			sql.append("    a.grinfo_createtime, ");
			sql.append("    c.staticid ");
			sql.append(" from oa_guestreception_info      a, ");
			sql.append("    oa_guestreception_type      b, ");
			sql.append("    oa_guestinforeceivelist  c,  ");
			sql.append("    td_sm_user u ");
			sql.append(" where a.grinfo_id = c.grinfo_id ");
			sql.append(" and b.grstatus_id = c.staticid ");
			sql.append(" and a.grinfo_sendpersonid=u.user_id ");
			sql.append(" and trim(c.userid) = ? ");
	
			if(!StringUtil.nullOrBlank(guestreceptionBean.getGrinfo_titile())){
				sql.append(" and a.grinfo_titile like '%").append(guestreceptionBean.getGrinfo_titile()).append("%'");
			}
			if(!StringUtil.nullOrBlank(guestreceptionBean.getGrinfo_receptionorg())){
				sql.append(" and a.grinfo_receptionorg like '%").append(guestreceptionBean.getGrinfo_receptionorg()).append("%'");
			}
			if (!StringUtil.nullOrBlank(guestreceptionBean.getGrinfo_startime())) {
				sql.append(" and a.grinfo_startime >= to_date('"
						+ guestreceptionBean.getGrinfo_startime()
						+ " 00:00:00','yyyy-mm-dd hh24:mi:ss')  ");
			}
			if (!StringUtil.nullOrBlank(guestreceptionBean.getGrinfo_endtime())) {
				sql.append(" and  a.grinfo_startime <= to_date( '"
						+ guestreceptionBean.getGrinfo_endtime()
						+ " 23:59:59' ,'yyyy-mm-dd hh24:mi:ss') ");
			}
			
			sql.append(" order by " + sortName + " " + sortOrder);
			pb=queryToPagingBean(sql.toString(), offset, maxPagesize, conn, guestreceptionBean.getGrinfo_sendpersonid());
		} catch (Exception e) {
			e.printStackTrace();
			LOG.error(e.getMessage(),e);
		}finally{
			DbManager.closeConnection(conn);
		}
		
		return pb;
	}
	@Override
	public String queryUserPhone(String userId) throws Exception {
		PreparedDBUtil pdb=new PreparedDBUtil();
		StringBuffer sql=new StringBuffer();
		String userPhone="";
		sql.append(" select u.user_mobiletel1 from td_sm_user u"); 
		sql.append(" where u.user_id= "+userId+"") ;
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		for (int i = 0; i < pdb.size(); i++) {
			userPhone=pdb.getString(i, "user_mobiletel1");
		}
		return userPhone;
	}
	@Override
	public List<GuestReceiveBean> queryUserBaseInfo(String userid)throws Exception {
		List<GuestReceiveBean> list =new ArrayList<GuestReceiveBean>();
		List<GuestReceiveBean> userList =new ArrayList<GuestReceiveBean>();
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();
		String orgIds="";
		String topId="";
		if(",".equals(String.valueOf(userid.charAt(0)))){
			userid=userid.substring(1);
		}
		sql.append("select ou.org_id,");
		sql.append(" org.org_name,");
		sql.append(" u.user_id,");
		sql.append(" u.user_realname,");
		sql.append(" u.user_sn,");
		sql.append("  decode(u.user_sex, 'M', '男', '女') as sex");
		sql.append(" from td_sm_orguser ou");
		sql.append(" left join td_sm_user u on ou.user_id = u.user_id");
		sql.append(" left join td_sm_organization org on ou.org_id = org.org_id");
		sql.append("  where u.user_id in(" + userid + ")");
		sql.append(" order by u.user_sn");

		try {
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
			for(int i=0;i<pdb.size();i++){
				GuestReceiveBean gBean=new GuestReceiveBean();
				gBean.setPtuserid(pdb.getString(i, "user_id"));
				gBean.setPtusername(pdb.getString(i, "user_realname"));
				gBean.setPtsex(pdb.getString(i, "sex"));
				gBean.setRemark2(pdb.getString(i, "org_id"));
				orgIds+="'"+pdb.getString(i, "org_id")+"',";
				list.add(gBean);
			}
			orgIds=orgIds.substring(0,orgIds.length()-1);
			//sql1
			//sql1.append("");
			sql1.append(" select org.org_id, org.parent_id, org.org_sn, org.org_name");
			sql1.append(" from td_sm_organization org");
			sql1.append(" where org.org_id in ("+orgIds+")");
			sql1.append(" start with org.org_id in (select t.org_id");
			sql1.append("                           from td_sm_organization t");
			sql1.append("               where t.parent_id = '0')");
			sql1.append(" connect by prior org.org_id = org.parent_id");
			sql1.append(" order siblings by org.org_sn");
			pdb.preparedSelect(sql1.toString());
			pdb.executePrepared();
			for(int i=0;i<pdb.size();i++){
				if(!topId.equals(pdb.getString(i, "org_id"))){
					for (int j = 0; j < list.size(); j++) {
						if(pdb.getString(i, "org_id").equals(list.get(j).getRemark2())){
							userList.add(list.get(j));
						}
					}
				}
			}
			for(int i=0;i<pdb.size();i++){
				if(topId.equals(pdb.getString(i, "org_id"))){
					for (int j = 0; j < list.size(); j++) {
						if(pdb.getString(i, "org_id").equals(list.get(j).getRemark2())){
							userList.add(list.get(j));
						}
					}
				}
			}
			sql2.append(" select t.org_id from td_sm_organization t where t.parent_id = '0'");
			pdb.preparedSelect(sql2.toString());
			pdb.executePrepared();
			for (int i = 0; i < pdb.size(); i++) {
				topId=pdb.getString(i, "org_id");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return userList;
	}
	
	
	public QueryBean queryGuestInfoAll(String grinfoId)throws Exception {
		PreparedDBUtil pdb=new PreparedDBUtil();
		QueryBean queryBean=new QueryBean();
		StringBuffer sql=new StringBuffer();
		StringBuffer sql1=new StringBuffer();
		StringBuffer sql2=new StringBuffer();
		StringBuffer sql3=new StringBuffer();
		grinfoId="'"+grinfoId.replace("'", "")+"'";
		try{
			//基本信息
		sql.append("select gi.grinfo_titile,");
		sql.append("  gi.grinfo_receptionorg,");
		sql.append("  gi.grinfo_dutyofficer,");
		sql.append(" gi.grinfo_dutyofficerid,");
		sql.append(" to_char(gi.grinfo_startime,'yyyy-MM-dd HH24:mi:ss') as grinfo_startime,");
		sql.append(" to_char(gi.grinfo_endtime,'yyyy-MM-dd HH24:mi:ss') as grinfo_endtime,");
		sql.append(" gi.grinfo_tel,");
		sql.append("  gi.grinfo_guestcontact,");
		sql.append("  gi.grinfo_content,");
		sql.append(" gi.grinfo_guestphone");
		sql.append(" from oa_guestreception_info gi");
		sql.append(" where gi.grinfo_id = "+grinfoId);
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		for (int i = 0; i < pdb.size(); i++) {
			GuestreceptionBean guestreceptionBean=new GuestreceptionBean();
			guestreceptionBean.setGrinfo_titile(pdb.getString(i, "grinfo_titile"));
			guestreceptionBean.setGrinfo_receptionorg(pdb.getString(i, "grinfo_receptionorg"));
			guestreceptionBean.setGrinfo_dutyofficer(pdb.getString(i, "grinfo_dutyofficer"));
			guestreceptionBean.setGrinfo_dutyofficerid(pdb.getString(i, "grinfo_dutyofficerid"));
			guestreceptionBean.setGrinfo_startime(pdb.getString(i, "grinfo_startime"));
			guestreceptionBean.setGrinfo_endtime(pdb.getString(i, "grinfo_endtime"));
			guestreceptionBean.setGrinfo_tel(pdb.getString(i, "grinfo_tel"));
			guestreceptionBean.setGrinfo_guestcontact(pdb.getString(i, "grinfo_guestcontact"));
			guestreceptionBean.setGrinfo_content(pdb.getString(i, "grinfo_content"));
			guestreceptionBean.setGrinfo_guestphone(pdb.getString(i, "grinfo_guestphone"));
			queryBean.setGuestreceptionBean(guestreceptionBean);
		}
		//行程
		sql1.append("select gt.grinfo_id,");
		sql1.append(" gt.tstarttime,");
		sql1.append("  gt.ttstarttime,");
		sql1.append(" gt.fromcontent,");
		sql1.append("  gt.place,");
		sql1.append(" gt.accompany,");
		sql1.append(" gt.accompanyid,");
		sql1.append(" gt.remark1");
		sql1.append("  from oa_guesttravel gt");
		sql1.append(" where gt.grinfo_id ="+grinfoId);
		sql1.append(" order by gt.tstarttime asc");
		pdb.preparedSelect(sql1.toString());
		pdb.executePrepared();
		List<GuestTravelBean> travelList=new ArrayList<GuestTravelBean>();
		for (int i = 0; i < pdb.size(); i++) {
			GuestTravelBean guestTravelBean=new GuestTravelBean();
			guestTravelBean.setTstarttime(pdb.getString(i, "tstarttime"));
			guestTravelBean.setTtstarttime(pdb.getString(i, "ttstarttime"));
			guestTravelBean.setFromcontent(pdb.getString(i, "fromcontent"));
			guestTravelBean.setPlace(pdb.getString(i, "place"));
			guestTravelBean.setAccompany(pdb.getString(i, "accompany"));
			guestTravelBean.setAccompanyid(pdb.getString(i, "accompanyid"));
			travelList.add(guestTravelBean);
		}
		queryBean.setTravelList(travelList);
		//宾客
		sql2.append(" select g.pid, g.guestname, g.guestsex, g.guestpost, g.remark1");
		sql2.append(" from oa_guestnamelist g");
		sql2.append(" where g.grinfo_id ="+grinfoId);
		sql2.append(" order by g.remark1 asc");
		pdb.preparedSelect(sql2.toString());
		pdb.executePrepared();
		List<GuestBeanNew> guestList =new ArrayList<GuestBeanNew>();
		for (int i = 0; i < pdb.size(); i++) {
			GuestBeanNew guestBeanNew=new GuestBeanNew();
			guestBeanNew.setGuestname(pdb.getString(i, "guestname"));
			guestBeanNew.setGuestsex(pdb.getString(i, "guestsex"));
			guestBeanNew.setGuestpost(pdb.getString(i, "guestpost"));
			guestList.add(guestBeanNew);
		}
		queryBean.setGuestList(guestList);
		//接待
		sql3.append(" select gr.grinfo_id,gr.ptusername,gr.ptuserid,gr.ptsex,gr.ptpost,gr.remark1");
		sql3.append(" from oa_guestreceive gr");
		sql3.append(" where gr.grinfo_id = "+grinfoId);
		sql3.append(" order by gr.remark1 asc");
		pdb.preparedSelect(sql3.toString());
		pdb.executePrepared();
		List<GuestReceiveBean> guestReceiveList =new ArrayList<GuestReceiveBean>();
		for (int i = 0; i < pdb.size(); i++) {
			GuestReceiveBean guestReceiveBean=new GuestReceiveBean();
			guestReceiveBean.setPtusername(pdb.getString(i, "ptusername"));
			guestReceiveBean.setPtuserid(pdb.getString(i, "ptuserid"));
			guestReceiveBean.setPtsex(pdb.getString(i, "ptsex"));
			guestReceiveBean.setPtpost(pdb.getString(i, "ptpost"));
			guestReceiveList.add(guestReceiveBean);
		}
		queryBean.setGuestReceiveList(guestReceiveList);
		}catch(SQLException e){
			e.printStackTrace();
			throw e;
		}
		return queryBean;
	}
	
	public void changeViewState(String grinfoId,String userId,String stateValue) throws Exception {
		PreparedDBUtil pdb=new PreparedDBUtil();
		StringBuffer sql=new StringBuffer();
		grinfoId="'"+grinfoId.replace("'", "")+"'";
		try{
		sql.append(" update oa_guestinforeceivelist gc");
		sql.append(" set gc.staticid = "+stateValue);
		sql.append(" where gc.grinfo_id = "+grinfoId);
		sql.append(" and gc.userid = "+userId);
		pdb.preparedUpdate(sql.toString());
		pdb.executePrepared();
		}catch (SQLException e) {
			e.printStackTrace();
			LOG.error(e.getMessage());
			throw e;
		}
		
	}

}
