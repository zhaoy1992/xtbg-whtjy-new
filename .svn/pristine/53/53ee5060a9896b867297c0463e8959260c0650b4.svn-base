package com.chinacreator.xtbg.core.inspect.service.impl;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.PageInfoBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.msgcenter.services.MessageCenterService;
import com.chinacreator.xtbg.core.common.msgcenter.services.impl.MessageCenterServiceImpl;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.inspect.dao.InspectManageDao;
import com.chinacreator.xtbg.core.inspect.entity.InspectBaseInfoBean;
import com.chinacreator.xtbg.core.inspect.entity.InspectReceptBean;
import com.chinacreator.xtbg.core.inspect.entity.InspectReceptuserBean;
import com.chinacreator.xtbg.core.inspect.entity.InspectResponseBean;
import com.chinacreator.xtbg.core.inspect.service.InspectManageService;
import com.chinacreator.xtbg.core.inspect.util.InspectConstant;
/**
 * 
 *<p>Title:InspectManageServiceImpl.java</p>
 *<p>Description:督察督办管理sercice接口实现类</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-10-29
 */
public class InspectManageServiceImpl implements InspectManageService {

	private static final Logger LOG = Logger
			.getLogger(InspectManageServiceImpl.class);
	private InspectManageDao dao = null;

	/**
	 * 
	 * <b>Summary: </b> 构造一个 FileFilesServiceImpl <b>Remarks: </b> 构造类
	 * FileFilesServiceImpl 的构造函数 FileFilesServiceImpl
	 */
	public InspectManageServiceImpl() {
		this.dao = (InspectManageDao) LoadSpringContext.getApplicationContext()
				.getBean("InspectManageDaoImpl");
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 findBaseInfoPageBean
	 * 
	 * @param bean
	 * @param page
	 * @return
	 * @see com.chinacreator.xtbg.core.inspect.service.InspectManageService#findBaseInfoPageBean(com.chinacreator.xtbg.core.inspect.entity.InspectBaseInfoBean,
	 *      com.chinacreator.xtbg.core.common.commonlist.PageInfoBean)
	 */
	@Override
	public PagingBean findBaseInfoPageBean(Map<String,String> bean,
			PageInfoBean page) {
		Connection conn = null;
        try{
        	conn = DbManager.getInstance().getConnection();
        	return dao.findBaseInfoPageBean(bean, page, conn);     	
        }catch(Exception e){
        	LOG.error("督察督办查询管理列表数据出现异常:"+e.getMessage(),e);
        	return null;
        }finally{
        	DbManager.closeConnection(conn);
        }
	}
	
	
	/**
	 * 
	*<b>Summary: “任务通知查看”查询任务数据。根据任务接收人来查看数据</b>
	* findBaseInfoPageBean4recept()
	* @param bean
	* @param page
	* @param conn
	* @return
	* @throws Exception
	 */
	public PagingBean findBaseInfoPageBean4recept(Map<String,String> bean,
			PageInfoBean page){
		Connection conn = null;
        try{
        	conn = DbManager.getInstance().getConnection();
        	return dao.findBaseInfoPageBean4recept(bean, page, conn);     	
        }catch(Exception e){
        	LOG.error(e.getMessage(),e);
        	return null;
        }finally{
        	DbManager.closeConnection(conn);
        }
	}
    /**
     * 
    *<b>Summary:根据id查询督察督办基本信息 </b>
    * queryToInspectBaseInfoBean()
    * @param id 基本信息id
    * @return 基本信息实例
     */
	public InspectBaseInfoBean queryToInspectBaseInfoBean(String id) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			InspectBaseInfoBean bean = new InspectBaseInfoBean();
			bean.setInfo_id(id);
			bean = (InspectBaseInfoBean) ((BaseDao) dao)
					.queryToBean(bean, conn);
			if(null == bean){
				bean = new InspectBaseInfoBean();
			}
			return bean;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return new InspectBaseInfoBean();
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	
	/**
	 * 
	*<b>Summary:查询所有分类信息 </b>
	* queryAllType()
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryAllType(){
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();			
			return dao.queryAllType(conn);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return null;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	*<b>Summary:保存督察督办数据 </b>
	* saveBaseInfo()
	* @param bean
	* @return
	 */
	public Boolean saveBaseInfo(InspectBaseInfoBean bean) {
		if (null == bean) {
			return false;
		}
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			// 将字符串转换为Timestamp对象
			bean.convertToTimestamp();
			// 插入基本信息
			((BaseDao) dao).insert(bean, conn);

			// 如果插入，且不是存为草稿，才插入办理单位
			if(!InspectConstant.STATE_CG.equals(bean.getInspect_state())){
				saveListRecept(bean.getInfo_id(), bean.getRecept_orgids(), bean
						.getRecept_orgnames(), conn);
			}						
			conn.commit();
			return true;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);			
			DbManager.rollBackNoThrow(conn);
			return false;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	*<b>Summary:更新操作 </b>
	* updateBaseInfo()
	* @param bean
	* @return
	 */
	public Boolean updateBaseInfo(InspectBaseInfoBean bean) {
		if (null == bean) {
			return false;
		}
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			// 将字符串转换为Timestamp对象
			bean.convertToTimestamp();
			//更新基本信息
			((BaseDao) dao).update(bean, conn);

			// 如果插入，且不是存为草稿，才插入办理单位
			if (!InspectConstant.STATE_CG.equals(bean.getInspect_state())) {
				saveListRecept(bean.getInfo_id(), bean.getRecept_orgids(),
						bean.getRecept_orgnames(), 
						conn);
			}
			conn.commit();
			return true;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			DbManager.rollBackNoThrow(conn);
			return false;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	*<b>Summary:删除基本信息 </b>
	* deleteBaseInfo()
	* @param ids
	* @return
	 */
    public Boolean deleteBaseInfo(String ids){
    	if (StringUtil.nullOrBlank(ids)) {
			return false;
		}
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			 
			//删除督察督办单位负责人信息
			InspectReceptuserBean userBean = new InspectReceptuserBean("info_id");
            ((BaseDao)dao).deleteListById(userBean, conn, ids);
            //删除反馈信息
            InspectResponseBean responseBean = new InspectResponseBean("info_id");
            ((BaseDao)dao).deleteListById(responseBean, conn, ids);
            //删除接收单位
            InspectReceptBean receptBean = new InspectReceptBean("info_id");
            ((BaseDao)dao).deleteListById(receptBean, conn, ids);
                        
            //删除任务信息
			((BaseDao) dao).deleteListById(new InspectBaseInfoBean(),conn,ids);
 
			conn.commit();
			return true;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			DbManager.rollBackNoThrow(conn);
			return false;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	
	
	/**
	 * 
	*<b>Summary: 插入任务接收单位信息</b>
	* saveListRecept()
	* @param orgIds
	* @param orgNames
	 * @throws Exception 
	 */
	private void saveListRecept(String infoId, String orgIds, String orgNames,
			Connection conn) throws Exception {
		
		if (StringUtil.nullOrBlank(orgIds) || StringUtil.nullOrBlank(orgNames)) {
			return;
		}
		String[] orgIdsArray = orgIds.split("\\,");
		String[] orgNamesArray = orgNames.split("\\,");
		InspectReceptBean receptBean = null;
		String receptId = "";
		List<Map<String, String>> resourcesMap = dao.queryResourceConfig(
				InspectConstant.RESOURCE_ID, conn);
		if (null != orgIdsArray && orgIdsArray.length > 0
				&& null != orgNamesArray && orgNamesArray.length > 0) {
			for (int i = 0; i < orgIdsArray.length; i++) {
				receptId = StringUtil.getUUID();
				receptBean = new InspectReceptBean();
				receptBean.setRecept_id(receptId);
				receptBean.setInfo_id(infoId);
				receptBean.setRecept_time(new Timestamp(System
						.currentTimeMillis()));
				receptBean.setOrg_id(orgIdsArray[i]);
				receptBean.setOrg_name(orgNamesArray[i]);
				receptBean.setRecept_state("0");// 设置状态为0，表示待反馈
				// 插入任务接收单位
				((BaseDao) dao).insert(receptBean, conn);

				// 插入对应的单位负责人到接收人表
				saveReceptUser(resourcesMap, orgIdsArray[i], receptId,infoId, conn);
			}
		}
	}
	
	
	/**
	 * 
	*<b>Summary:插入任务接收人信息 </b>
	* saveReceptUser()
	* @param resourcesMap
	* @param orgId
	* @param receptId
	* @param conn
	* @throws Exception
	 */
	private void saveReceptUser(List<Map<String, String>> resourcesMap,
			String orgId, String receptId,String infoId, Connection conn) throws Exception {
		if (null != resourcesMap && !resourcesMap.isEmpty()) {
			for (Map<String, String> map : resourcesMap) {
				if (orgId.equals(map.get("config_typeid"))) {
					dao.insertReceptUser(infoId,receptId, map.get("config_ids"), conn);
					return;
				}
			}
		}
	}
	/**
	 * 
	*<b>Summary:根据任务id，查询各个单位的反馈状况 </b>
	* queryRecept()
	* @param map  查询条件
	* @param conn 数据库连接
	* @return
	* @throws Exception
	*/
	public List<Map<String, String>> queryRecept(String infoId) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			return dao.queryRecept(infoId, conn);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return null;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	*<b>Summary: 任务办结</b>
	* overInspect()
	* @param bean
	* @return
	 */
	public boolean overInspect(InspectBaseInfoBean bean){
		Connection conn = null;
		try {			
			if(null == bean){
				return false;
			}
			conn = DbManager.getInstance().getTransactionConnection();
            //更新任务状态信息
			((BaseDao)dao).update(bean, conn);
			conn.commit();
			return true;            
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			return false;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	*<b>Summary:任务催办 </b>
	* hurryInspect()
	* @param bean
	* @param ids
	* @return
	 */
	public boolean hurryInspect(InspectBaseInfoBean bean,String ids){
		Connection conn = null;
		try {			
			if(null == bean){
				return false;
			}
			conn = DbManager.getInstance().getTransactionConnection();
			//根据接收id列表查询责任人信息
		    List<Map<String,String>> receptUserList = dao.queryReceptUser(ids, conn);
			
			if(InspectConstant.TRUE.equals(bean.getIs_msg())){//站内消息
				sendMsg(bean,receptUserList,conn);
			}else if(InspectConstant.TRUE.equals(bean.getIs_sms())){//短信(预留)
				
			}else if(InspectConstant.TRUE.equals(bean.getIs_rtx())){//即时通讯工具预留
				
			}else if(InspectConstant.TRUE.equals(bean.getIs_mail())){//右键预留
				
			}
            //更新任务状态信息
			((BaseDao)dao).update(bean, conn);
            
			//发牌等操作（预留）
			
			conn.commit();
			return true;            
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			return false;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 发送站内消息
	*<b>Summary: </b>
	* sendMsg()
	 * @throws Exception 
	 */
	private void sendMsg(InspectBaseInfoBean bean,
			List<Map<String, String>> receptUserList,Connection conn) throws Exception {
		if (null != bean && null != receptUserList && !receptUserList.isEmpty()) {
			List<String> userIds = new ArrayList<String>();
			for (int i = 0; i < receptUserList.size(); i++) {
				userIds.add(receptUserList.get(i).get("recept_userid"));
			}
			// 发送消息
			MessageCenterService mservice = new MessageCenterServiceImpl();

			mservice.sendMessage(bean.getSend_user_id(), userIds, bean
					.getRemind_content(), conn);
		}
	}
	
	/**
	 * 
	*<b>Summary: 查询回复信息</b>
	* queryListResponse()
	* @param receptId 接收id
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryListResponse(String receptId) {
		Connection conn = null;
		try {			
			if(StringUtil.nullOrBlank(receptId)){
				return null;
			}
			conn = DbManager.getInstance().getConnection();
			return dao.queryListResponse(receptId, conn);            
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return null;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	*<b>Summary:反馈 </b>
	* responseInspect()
	* @param bean
	* @return
	 */
	public boolean responseInspect(InspectResponseBean bean){
		Connection conn = null;
		try {			
			if(null == bean){
				return false;
			}
			conn = DbManager.getInstance().getTransactionConnection();
			//添加反馈时间等信息
			bean.setResponse_time(new Timestamp(System.currentTimeMillis()));
			bean.setResponse_state("0");//默认为未读
			bean.setResponse_id(StringUtil.getUUID());//主键
			//插入反馈信息
			((BaseDao)dao).insert(bean, conn);
			
			//将任务接收状态
            String receptState = InspectConstant.RECEPT_RESPONSE;//默认为已反馈
            if(InspectConstant.RESPONSE_TYPE_THCB.equals(bean.getType())){
            	receptState = InspectConstant.RECEPT_RERESPONSE;//设置为退回重办
            }
            
            //更改任务接收表的任务反馈状态
            InspectReceptBean recept = new InspectReceptBean();
            recept.setRecept_id(bean.getRecept_id());
            recept.setRecept_state(receptState);
            if(InspectConstant.RESPONSE_TYPE_FK.equals(bean.getType())){//反馈，则添加反馈时间
            	recept.setResponse_time(bean.getResponse_time());
            }else{
            	recept.setResponse_time(null);//退回重办，反馈时间设置为空
            }
            
            //更新任务状态信息
			((BaseDao)dao).update(recept, conn);
            
			conn.commit();
			return true;            
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			return false;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	/**
	 * 
	*<b>Summary:查询发牌的数据列表 </b>
	* @return 发牌数据列表
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	public PagingBean queryCardList(Map<String,String> condition,PageInfoBean page) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			PagingBean pageList = dao.queryCardList(condition,page, conn);
			if(null!=pageList){
				List<Map<String,String>> list = (List<Map<String,String>>)pageList.getList();
				if (null != list && !list.isEmpty()) {
					for (Map<String, String> map : list) {
						//获得当前时间
						String time = StringUtil.convertTimeToString(new Timestamp(
								System.currentTimeMillis()), "yyyyMMddHHmm");
						Long timeCount = Long.parseLong(time);
						//获得指定期限
						String planEndTime = map.get("plan_endtime4card");
						Long planEndTimeCount = Long.parseLong(planEndTime);					
						//预警时间
						String remindTime = map.get("remind_time4card");
						
						String responseTime = map.get("response_time");
						Long responseTimeCount = 1000000000000L;
						//反馈时间不为空，且状态为已反馈，则认为是反馈了的
						if (!StringUtil.nullOrBlank(responseTime)
								&& InspectConstant.RECEPT_RESPONSE.equals(map
										.get("recept_state"))) {
							responseTimeCount = Long.parseLong(responseTime);
						}
						
						//没有添加预警时间
						if(StringUtil.nullOrBlank(remindTime)){
						   if(responseTimeCount<planEndTimeCount){
							   map.put("card","0");//反馈时间在指定期限之前，绿灯
						   }else{
							   //如果当前时间小于指定期限
							   if(timeCount<planEndTimeCount){
								   map.put("card", "");//不发牌
							   }else{//当前时间晚于指定期限（超过期限未完成）
								   map.put("card", "2");//发红牌
							   }
						   }						
						}else{
						   //添加了预警时间
						   Long remindTimeCount = Long.parseLong(remindTime);
						   if(responseTimeCount<planEndTimeCount){
							   map.put("card","0");//反馈时间在指定期限之前，绿灯
						   }else{
							   //当前日期小于预警时间，则不发牌
							   if(timeCount<=remindTimeCount){
								   map.put("card", "");//不发牌
							   }
							   
							   if(timeCount>remindTimeCount&&timeCount<=planEndTimeCount){
								   //当前日期在预警时间之后，但是没有超过预警时间，发红牌
								   map.put("card", InspectConstant.CARD_YELLOW);
							   }
							   //当前时间超过了指定期限，红灯
							   if(timeCount>planEndTimeCount){
								   map.put("card", InspectConstant.CARD_RED);
							   }
						   }
							
						}
					}
				}
			}
			
			return pageList;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return null;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
}
