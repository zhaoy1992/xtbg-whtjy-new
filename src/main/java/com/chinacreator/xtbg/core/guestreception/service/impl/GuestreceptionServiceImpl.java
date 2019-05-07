package com.chinacreator.xtbg.core.guestreception.service.impl;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.guestreception.dao.GuestreceptionDao;
import com.chinacreator.xtbg.core.guestreception.entity.GuestBeanNew;
import com.chinacreator.xtbg.core.guestreception.entity.GuestInfoReceiveListBean;
import com.chinacreator.xtbg.core.guestreception.entity.GuestReceiveBean;
import com.chinacreator.xtbg.core.guestreception.entity.GuestTravelBean;
import com.chinacreator.xtbg.core.guestreception.entity.GuestreceptionBean;
import com.chinacreator.xtbg.core.guestreception.entity.QueryBean;
import com.chinacreator.xtbg.core.guestreception.service.GuestreceptionServiceIfc;
/**
 * 
 *<p>Title:GuestreceptionServiceImpl.java</p>
 *<p>Description:接待管理服务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-9-5
 */
public class GuestreceptionServiceImpl implements GuestreceptionServiceIfc {

	public static final Logger logger = Logger.getLogger(GuestreceptionServiceImpl.class.getName());
	String flag="false";
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveGuestInfo
	  * @param guestreceptionBean
	  * @param travelList
	  * @param guestList
	  * @param guestReceiveList 
	  * @see com.chinacreator.xtbg.core.guestreception.service.GuestreceptionServiceIfc#saveGuestInfo(com.chinacreator.xtbg.core.guestreception.entity.GuestreceptionBean, java.util.List, java.util.List, java.util.List)
	 */
	public String saveGuestInfo(GuestreceptionBean guestreceptionBean,List<GuestTravelBean> travelList, List<GuestBeanNew> guestList,List<GuestReceiveBean> guestReceiveList) {
		GuestreceptionDao guestreceptionDao = (GuestreceptionDao)LoadSpringContext.getApplicationContext().getBean("guestreceptionDaoImpl");
		Connection conn = null;
		try {
			conn=DbManager.getInstance().getTransactionConnection();
			//GuestreceptionBean的id为空   保存 否 更新
			//设置时间
			Timestamp time=StringUtil.convertStringToTimestamp(DateUtil.getCurrentDateTime(), "yyyy-MM-dd HH:mm:ss");
			guestreceptionBean.setGrinfo_startime(StringUtil.convertStringToTimestamp(guestreceptionBean.getGrinfo_startime(), "yyyy-MM-dd HH:mm:ss"));
			guestreceptionBean.setGrinfo_endtime(StringUtil.convertStringToTimestamp(guestreceptionBean.getGrinfo_endtime(), "yyyy-MM-dd HH:mm:ss"));
			guestreceptionBean.setGrinfo_createtime(time);
			String grinfo_id="";
			if(StringUtil.isBlank(guestreceptionBean.getGrinfo_id())){
				//保存接待基本信息
				grinfo_id=StringUtil.getUUID();
				guestreceptionBean.setGrinfo_id(grinfo_id);
				((BaseDao)guestreceptionDao).insert(guestreceptionBean, conn);
			}else{//更新
				grinfo_id=guestreceptionBean.getGrinfo_id();
				((BaseDao)guestreceptionDao).update(guestreceptionBean, conn);
				
				//删除相关表数据
				//1.删除行程表
				GuestTravelBean guestTravelBean=new GuestTravelBean();
				guestTravelBean.setDeleteKey("grinfo_id");
				((BaseDao)guestreceptionDao).deleteListById(guestTravelBean, conn,grinfo_id);
				//2.删除来宾信息
				GuestBeanNew guestBeanNew =new GuestBeanNew();
				guestBeanNew.setDeleteKey("grinfo_id");
				((BaseDao)guestreceptionDao).deleteListById(guestBeanNew, conn,grinfo_id);
				//3.删除接待人员信息
				GuestReceiveBean guestReceiveBean=new GuestReceiveBean();
				guestReceiveBean.setDeleteKey("grinfo_id");
				((BaseDao)guestreceptionDao).deleteListById(guestReceiveBean, conn,grinfo_id);
				//4.删除接收人列表信息
				GuestInfoReceiveListBean listbean=new GuestInfoReceiveListBean();
				listbean.setDeleteKey("grinfo_id");
				((BaseDao)guestreceptionDao).deleteListById(listbean, conn,grinfo_id);
			}
			////公共插入部分
			//1.添加行程
			int i=1;
			if(travelList.size()>0){
				for (GuestTravelBean guestTravelBean : travelList) {
					//设置时间
					guestTravelBean.setCreatetime(time);
					guestTravelBean.setPid(StringUtil.getUUID());
					guestTravelBean.setGrinfo_id(grinfo_id);
					guestTravelBean.setRemark1(String.valueOf(i));
					i++;
					((BaseDao)guestreceptionDao).insert(guestTravelBean, conn);
				}
			}
			//2.来宾信息
			i=1;
			if(guestList.size()>0){
				for (GuestBeanNew guestBeanNew : guestList) {
					guestBeanNew.setCreatetime(time);
					guestBeanNew.setPid(StringUtil.getUUID());
					guestBeanNew.setGrinfo_id(grinfo_id);
					guestBeanNew.setRemark1(String.valueOf(i));
					i++;
					((BaseDao)guestreceptionDao).insert(guestBeanNew, conn);
				}
			}
			//3.接待人员信息
			i=1;
			if(guestReceiveList.size()>0){
				for (GuestReceiveBean guestReceiveBean : guestReceiveList) {
					guestReceiveBean.setCreattime(time);
					guestReceiveBean.setPid(StringUtil.getUUID());
					guestReceiveBean.setGrinfo_id(grinfo_id);
					guestReceiveBean.setRemark1(String.valueOf(i));
					i++;
					((BaseDao)guestreceptionDao).insert(guestReceiveBean, conn);
				}
			}
			//4.如果是发布将接收人信息插入oa_guestinforeceivelist表
			if ("2".equals(guestreceptionBean.getGrstatus_id())){
				//加入负责人
				GuestInfoReceiveListBean listbean=new GuestInfoReceiveListBean();
				listbean.setPid(StringUtil.getUUID());
				listbean.setGrinfo_id(grinfo_id);
				listbean.setUserid(guestreceptionBean.getGrinfo_dutyofficerid());
				listbean.setStaticid("3");
				listbean.setCreatetime(time);
				((BaseDao)guestreceptionDao).insert(listbean, conn);
				//加入接待人
				for (GuestReceiveBean guestReceiveBean : guestReceiveList) {
					if(!guestreceptionBean.getGrinfo_dutyofficerid().equals(guestReceiveBean.getPtuserid())){//如果接待人中有相同的负责人则去掉一个加一个就行
						listbean.setPid(StringUtil.getUUID());
						listbean.setUserid(guestReceiveBean.getPtuserid());
						((BaseDao)guestreceptionDao).insert(listbean, conn);
					}
				}
			}
			flag="ture";
			return flag;
		}  catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			logger.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	//删除信息
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteGuestInfo
	  * @param grinfoId 
	  * @see com.chinacreator.xtbg.core.guestreception.service.GuestreceptionServiceIfc#deleteGuestInfo(java.lang.String)
	 */
	public String deleteGuestInfo(String grinfoId) {
		GuestreceptionDao guestreceptionDao = (GuestreceptionDao)LoadSpringContext.getApplicationContext().getBean("guestreceptionDaoImpl");
		Connection conn = null;
		grinfoId="'"+grinfoId.replace(",", "','")+"'";
		try {
			conn=DbManager.getInstance().getTransactionConnection();
			//1.删除行程表
			GuestTravelBean guestTravelBean=new GuestTravelBean();
			guestTravelBean.setDeleteKey("grinfo_id");
			((BaseDao)guestreceptionDao).deleteListById(guestTravelBean, conn,grinfoId);
			//2.删除来宾信息
			GuestBeanNew guestBeanNew =new GuestBeanNew();
			guestBeanNew.setDeleteKey("grinfo_id");
			((BaseDao)guestreceptionDao).deleteListById(guestBeanNew, conn,grinfoId);
			//3.删除接待人员信息
			GuestReceiveBean guestReceiveBean=new GuestReceiveBean();
			guestReceiveBean.setDeleteKey("grinfo_id");
			((BaseDao)guestreceptionDao).deleteListById(guestReceiveBean, conn,grinfoId);
			//4.删除接收人列表信息
			GuestInfoReceiveListBean listbean=new GuestInfoReceiveListBean();
			listbean.setDeleteKey("grinfo_id");
			((BaseDao)guestreceptionDao).deleteListById(listbean, conn,grinfoId);
			//5删除接待信息
			GuestreceptionBean receptionbean=new GuestreceptionBean();
			((BaseDao)guestreceptionDao).deleteListById(receptionbean, conn,grinfoId);
			
			flag="true";
			return flag;
		}  catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			logger.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	//变更信息状态
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updatestatus
	  * @param grinfoId
	  * @param stateValue 
	  * @see com.chinacreator.xtbg.core.guestreception.service.GuestreceptionServiceIfc#updatestatus(java.lang.String, java.lang.String)
	 */
	public String updatestatus(String grinfoId, String stateValue) {
		GuestreceptionDao guestreceptionDao = (GuestreceptionDao)LoadSpringContext.getApplicationContext().getBean("guestreceptionDaoImpl");
		Connection conn = null;
		String ids[]=grinfoId.split(",");
		try {
			conn=DbManager.getInstance().getTransactionConnection();
			Timestamp time=StringUtil.convertStringToTimestamp(DateUtil.getCurrentDateTime(), "yyyy-MM-dd HH:mm:ss");
			//添加所有接收人列表信息
			for (String grinfo_id : ids) {
				QueryBean  bean= guestreceptionDao.queryGuestInfoAll("'"+grinfo_id+"'");
				//加入负责人
				String grinfo_dutyofficerid=bean.getGuestreceptionBean().getGrinfo_dutyofficerid();
				GuestInfoReceiveListBean listbean=new GuestInfoReceiveListBean();
				listbean.setGrinfo_id(grinfo_id);
				listbean.setStaticid("3");
				listbean.setCreatetime(time);
				if(!StringUtil.isBlank(grinfo_dutyofficerid)){
					listbean.setPid(StringUtil.getUUID());
					listbean.setUserid(grinfo_dutyofficerid);
					((BaseDao)guestreceptionDao).insert(listbean, conn);
				}
				//加入接待人
				List<GuestReceiveBean> guestReceiveList=bean.getGuestReceiveList();
				for (GuestReceiveBean guestReceiveBean : guestReceiveList) {
					listbean.setPid(StringUtil.getUUID());
					listbean.setUserid(guestReceiveBean.getPtuserid());
					((BaseDao)guestreceptionDao).insert(listbean, conn);
				}
				//更新接待基本信息
				GuestreceptionBean receptionbean=new GuestreceptionBean();
				receptionbean.setGrinfo_id(grinfo_id);
				receptionbean.setGrstatus_id(stateValue);
				((BaseDao)guestreceptionDao).update(receptionbean, conn);
			}
			
			flag="true";
			return flag;
		}  catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			logger.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
}
