package com.chinacreator.xtbg.core.kbm.service.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;
import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.note.entity.NoteBufferBean;
import com.chinacreator.xtbg.core.common.note.entity.NoteDetailBean;
import com.chinacreator.xtbg.core.common.note.services.NoteService;
import com.chinacreator.xtbg.core.common.note.services.impl.NoteServiceImpl;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.RequestBeanUtils;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.dataresources.util.DataResourcesUtil;
import com.chinacreator.xtbg.core.kbm.service.KbmDocService;
import com.chinacreator.xtbg.core.kbm.dao.*;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocBean;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocFavoritesBean;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocOperateLogBean;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocReceiverUserBean;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocSuggestBean;
import com.chinacreator.xtbg.core.kbm.util.KbmConstants;
import com.chinacreator.xtbg.core.purviewmanager.service.UserManagerServiceIfc;
import com.chinacreator.xtbg.core.purviewmanager.service.impl.UserManagerServiceImpl;
import com.chinacreator.xtbg.core.sysparam.util.SysParamUitl;
import com.chinacreator.xtbg.core.upload.util.UploadConstants;
import com.chinacreator.xtbg.pub.iweboffice.dao.impl.ManageIWebOfficeDataInFileUploadKBM;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:KbmDocServiceImpl.java</p>
 *<p>Description:知识库文档管理服务接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-8-7
 */
public class KbmDocServiceImpl implements KbmDocService {
	private static final Logger LOG = Logger.getLogger(KbmDocServiceImpl.class);
	KbmDocDao dao = (KbmDocDao)LoadSpringContext.getApplicationContext().getBean("kbmDocDaoImpl");
	NoteService noteService = new NoteServiceImpl();
	UserManagerServiceIfc userManagerServiceIfc = new UserManagerServiceImpl();
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 checkKbmDocBean 审核文档
	  * @param kbmDocBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.service.KbmDocService#checkKbmDocBean(com.chinacreator.xtbg.core.kbm.entity.KbmDocBean) 
	  */
	public boolean checkKbmDocBean(KbmDocBean kbmDocBean) {
		Connection conn = null;
		boolean flag = false;
		try {
			if(kbmDocBean != null) {
				conn = DbManager.getInstance().getConnection();
				KbmDocBean model = new KbmDocBean();
				KbmDocReceiverUserBean kbmdocreceiveruserbean = new KbmDocReceiverUserBean();
				model = this.getKbmDocBeanById(kbmDocBean.getK_doc_id());
				//model.setK_check_time(StringUtil.convertStringToTimestamp(DateUtil.getCurrentDate(), "yyyy-mm-dd"));
				model.setK_check_time(StringUtil.convertStringToTimestamp(kbmDocBean.getK_check_time(), "yyyy-mm-dd"));
				model.setK_create_time(StringUtil.convertStringToTimestamp(kbmDocBean.getK_create_time(), "yyyy-mm-dd"));
				model.setK_first_time(StringUtil.convertStringToTimestamp(kbmDocBean.getK_first_time(), "yyyy-mm-dd"));
				model.setK_update_time(StringUtil.convertStringToTimestamp(kbmDocBean.getK_update_time(), "yyyy-mm-dd"));
				
				model.setK_check_user(kbmDocBean.getK_check_user());
				model.setK_check_user_name(kbmDocBean.getK_check_user_name());
				model.setK_check_info(kbmDocBean.getK_check_info());
				model.setK_flag(kbmDocBean.getK_flag());
				model.setK_flag_name(kbmDocBean.getK_flag_name());
				//特检院OA 追加 批准人 批准意见字段 和【发布】环节的执行人可修改【所属分类】、【编号】字段   2014-03-27 start
				model.setK_approval_time(StringUtil.convertStringToTimestamp(kbmDocBean.getK_approval_time(), "yyyy-mm-dd"));//批准时间
				model.setK_approval_user(kbmDocBean.getK_approval_user());//批准人
				model.setK_approval_user_name(kbmDocBean.getK_approval_user_name());//批准人name
				model.setK_approval_info(kbmDocBean.getK_approval_info()); //批准意见
				model.setK_type_name(kbmDocBean.getK_type_name()); //所属分类名称
				model.setK_type_id(kbmDocBean.getK_type_id()); //所属分类ID
				model.setK_code(kbmDocBean.getK_code()); //编号
				//特检院OA 追加 批准人 批准意见 字段 和【发布】环节的执行人可修改【所属分类】、【编号】字段  2014-03-27 end
				//审核后清空修改备注
				model.setK_remark("");
				
				//特检院OA 追加适用部门ID 适用部门名称 start
				model.setK_receive_deptid(kbmDocBean.getK_receive_deptid());//适用部门ID
				model.setK_receive_deptname(kbmDocBean.getK_receive_deptname());//适用部门名称
				String k_receive_deptid = kbmDocBean.getK_receive_deptid();
				String [] k_receiver_orgidArray = null;
				String [] AllOrgReceiverusersArray = null;
				String unit_receiver_userids = "";
				String all_org_receiverusers = "";
				
				kbmdocreceiveruserbean.setDeleteKey("k_doc_id");
			  ((BaseDao)dao).deleteListById(kbmdocreceiveruserbean, conn, model.getK_doc_id());//删除适用部门接收人
				//所有单位接收人拼接在一起
				if(!StringUtil.isBlank(k_receive_deptid)&&(KbmConstants.FLAG_PUBLISH_PASS).equals(kbmDocBean.getK_flag())) {
					k_receiver_orgidArray = k_receive_deptid.split(",");
					for(int i = 0; i < k_receiver_orgidArray.length; i++) {
						
						// 获得单位接收人
						unit_receiver_userids = DataResourcesUtil.getDataResourcesRecipient(k_receiver_orgidArray[i], "kbmdocreceiverson");
						if(!StringUtil.isBlank(unit_receiver_userids)) {
							all_org_receiverusers += "," + unit_receiver_userids;
						}
					}
				}
				if(!StringUtil.isBlank(all_org_receiverusers)) {
					AllOrgReceiverusersArray = all_org_receiverusers.split(",");
				}
				if(AllOrgReceiverusersArray!=null){
					
					for (int j = 0; j < AllOrgReceiverusersArray.length; j++) {
						kbmdocreceiveruserbean = new KbmDocReceiverUserBean();
						kbmdocreceiveruserbean.setK_receiverid(StringUtil.getUUID());
						kbmdocreceiveruserbean.setK_doc_id(kbmDocBean.getK_doc_id());
						kbmdocreceiveruserbean.setK_receiver_userid(AllOrgReceiverusersArray[j]);
						UserCacheBean userCacheBean = UserCache.getUserCacheBean(AllOrgReceiverusersArray[j]);
						if(userCacheBean==null){
							continue;
						}
						kbmdocreceiveruserbean.setK_receiver_username(userCacheBean.getUser_realname());
						kbmdocreceiveruserbean.setK_receiveruser_orgid(userCacheBean.getOrg_id());
						kbmdocreceiveruserbean.setK_receiveruser_orgname(userCacheBean.getOrg_name());
						((BaseDao)dao).insert(kbmdocreceiveruserbean, conn);//保存用户接收人信息
					}
				}
				//特检院OA 追加适用部门ID 适用部门名称 end 
				
				((BaseDao)dao).update(model, conn);//更新保存
				
				//发短信-----------------------------------------------------begin
				if(kbmDocBean.getM_msg_contents()!=null && kbmDocBean.getM_msg_type()!=null && !StringUtil.nullOrBlank(kbmDocBean.getM_msg_contents()) && !StringUtil.nullOrBlank(kbmDocBean.getM_msg_type())){
					NoteBufferBean noteBufferBean = new NoteBufferBean();
					NoteDetailBean noteDetailBean = null;
					List<NoteDetailBean> detailList = new ArrayList<NoteDetailBean>();; 
					
					noteBufferBean.setContent(kbmDocBean.getM_msg_contents());
					noteBufferBean.setUser_id(kbmDocBean.getK_check_user());
					noteBufferBean.setUser_name(kbmDocBean.getK_check_user_name());
					String buffer_id = StringUtil.getUUID();
					noteBufferBean.setBuffer_id(buffer_id);
					
					//给上传人发短信-----------------
					Map<String, String> userMap = new HashMap<String, String>();
					userMap = userManagerServiceIfc.getUserBean(kbmDocBean.getK_create_user());
					if(!StringUtil.nullOrBlank(userMap.get("user_mobiletel1"))){
						noteDetailBean = new NoteDetailBean();
						noteDetailBean.setRecv_id(StringUtil.getUUID());
						noteDetailBean.setBuffer_id(buffer_id);
						noteDetailBean.setUser_id(kbmDocBean.getK_create_user());
						noteDetailBean.setUser_name(kbmDocBean.getK_create_user_name());
						noteDetailBean.setPhone_num(StringUtil.deNull(userMap.get("user_mobiletel1")));
						detailList.add(noteDetailBean);
					}
					if(noteBufferBean!=null && detailList!=null && detailList.size()>0){
						flag = noteService.doNoteSend(noteBufferBean, detailList, conn);
					}
				}else{
					flag=true;
				}
				if("1".equals(kbmDocBean.getK_flag())){
					// 给定阅文章关键字类似的的发短信
					NoteBufferBean noteBufferBean1 = new NoteBufferBean();
					NoteDetailBean noteDetailBean1 = null;
					List<NoteDetailBean> detailList1 = new ArrayList<NoteDetailBean>();; 
					
					//得到短信内容
					String checkpass = SysParamUitl.getSysParamValueIsVALID(KbmConstants.KBM_NOTE_CHECKRSS);
					String m_msg_contents="";
					KbmDocBean bean = new KbmDocBean();
					bean = this.getKbmDocBeanById(kbmDocBean.getK_doc_id());
					Map<String, String> kbmDocMap = RequestBeanUtils.transBean2Map(bean);
		        	if(!StringUtil.nullOrBlank(checkpass)){
		        		m_msg_contents = SysParamUitl.getSysParamValue(checkpass);
		            	List<Map<String, String>> listmap = SysParamUitl.getSysParamValueDetail(checkpass);
		            	if(!StringUtil.nullOrBlank(m_msg_contents) && listmap!=null && listmap.size()>0){
		            		for (Map<String, String> map : listmap){
		            			//System.out.println("map.get(\"p_value_name\")=="+map.get("p_value_name")+",map.get(\"p_value_code\")==="+map.get("p_value_code")+",kbmDocMap.get(map.get(\"p_value_code\"))=="+kbmDocMap.get(map.get("p_value_code")));
		            			if(kbmDocMap!=null && kbmDocMap.size()>0 && !StringUtil.nullOrBlank(kbmDocMap.get(map.get("p_value_code")))){
		            				m_msg_contents = m_msg_contents.replaceAll("【"+map.get("p_value_name")+"】",kbmDocMap.get(map.get("p_value_code")));
		            			}
		            		}
		            	}	
		        	}
					if(!StringUtil.isBlank(m_msg_contents)){
						noteBufferBean1.setContent(m_msg_contents);
						noteBufferBean1.setUser_id(kbmDocBean.getK_check_user());
						noteBufferBean1.setUser_name(kbmDocBean.getK_check_user_name());
						String buffer_id1 = StringUtil.getUUID();
						noteBufferBean1.setBuffer_id(buffer_id1);
						
						List<Map<String, String>> kbmDocRssMap = new ArrayList<Map<String, String>>();
						kbmDocRssMap = dao.getKbmDocRssByKey(kbmDocBean.getK_key(),kbmDocBean.getK_type_id());
						for (Map<String, String> map : kbmDocRssMap){
							Map<String, String> userMap = new HashMap<String, String>();
							userMap = userManagerServiceIfc.getUserBean(map.get("k_rss_user"));
							if (userMap!=null && !StringUtil.nullOrBlank(userMap.get("user_mobiletel1"))){
								noteDetailBean1 = new NoteDetailBean();
								noteDetailBean1.setRecv_id(StringUtil.getUUID());
								noteDetailBean1.setBuffer_id(buffer_id1);
								noteDetailBean1.setUser_id(map.get("k_rss_user"));
								noteDetailBean1.setUser_name(map.get("k_rss_user_name"));
								noteDetailBean1.setPhone_num(StringUtil.deNull(userMap.get("user_mobiletel1")));
								detailList1.add(noteDetailBean1);
							}
						}
						if(noteBufferBean1!=null && detailList1!=null && detailList1.size()>0){
							flag = noteService.doNoteSend(noteBufferBean1, detailList1, conn);
						}
					}
				}
				//发短信-----------------------------------------------------end
				
			}
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn); 
			LOG.error(e.getMessage(), e);
		} finally {
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 updateKbmDocBean 更新文件管理实体bean 暂存、送审
	  * @param kbmDocBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.service.KbmDocService#updateKbmDocBean(com.chinacreator.xtbg.core.kbm.entity.KbmDocBean) 
	  */
	public boolean updateKbmDocBean(KbmDocBean kbmDocBean) {
		Connection conn = null;
		boolean flag = false;
		try {
			if(kbmDocBean != null) {
				conn = DbManager.getInstance().getConnection();
				String k_doc_id = kbmDocBean.getK_doc_id();
				kbmDocBean.setK_first_time(StringUtil.convertStringToTimestamp(kbmDocBean.getK_first_time(), "yyyy-mm-dd"));
				if(StringUtil.isBlank(k_doc_id)) {
					k_doc_id=StringUtil.getUUID();
					kbmDocBean.setK_doc_id(k_doc_id);
					kbmDocBean.setK_dcount("0");
					kbmDocBean.setK_create_time(StringUtil.convertStringToTimestamp(DateUtil.getCurrentDateTime(), "yyyy-MM-dd HH24:mi:ss"));
					kbmDocBean.setK_check_time(null);
					((BaseDao)dao).insert(kbmDocBean, conn);//新增保存
					//insertreceiveuser(kbmDocBean);
				}else{
					kbmDocBean.setK_update_time(StringUtil.convertStringToTimestamp(DateUtil.getCurrentDate(), "yyyy-mm-dd"));
					kbmDocBean.setK_check_time(null);
					//显示更新通知
					kbmDocBean.setK_luojishanchu("0");
					((BaseDao)dao).update(kbmDocBean, conn);//更新保存
				}
				//如果是送审操作，发一短信给审核人。短信内容由系统参数配置中得到，p_code=pengding
				if (kbmDocBean.getK_flag().equalsIgnoreCase(KbmConstants.FLAG_PENDING)){
					//需求待定
				}
				flag=true;
			}
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally {
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	public void insertreceiveuser(KbmDocBean kbmDocBean){
		KbmDocReceiverUserBean kbmdocreceiveruserbean = new KbmDocReceiverUserBean();
		KbmDocBean model = new KbmDocBean();
		model = this.getKbmDocBeanById(kbmDocBean.getK_doc_id());
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			//特检院OA 追加适用部门ID 适用部门名称 start
			model.setK_receive_deptid(kbmDocBean.getK_receive_deptid());//适用部门ID
			model.setK_receive_deptname(kbmDocBean.getK_receive_deptname());//适用部门名称
			String k_receive_deptid = kbmDocBean.getK_receive_deptid();
			String [] k_receiver_orgidArray = null;
			String [] AllOrgReceiverusersArray = null;
			String unit_receiver_userids = "";
			String all_org_receiverusers = "";
			
			kbmdocreceiveruserbean.setDeleteKey("k_doc_id");
		  ((BaseDao)dao).deleteListById(kbmdocreceiveruserbean, conn, model.getK_doc_id());//删除适用部门接收人
			//所有单位接收人拼接在一起
			if(!StringUtil.isBlank(k_receive_deptid)&&(KbmConstants.FLAG_PUBLISH_PASS).equals(kbmDocBean.getK_flag())) {
				k_receiver_orgidArray = k_receive_deptid.split(",");
				for(int i = 0; i < k_receiver_orgidArray.length; i++) {
					
					// 获得单位接收人
					unit_receiver_userids = DataResourcesUtil.getDataResourcesRecipient(k_receiver_orgidArray[i], "kbmdocreceiverson");
					if(!StringUtil.isBlank(unit_receiver_userids)) {
						all_org_receiverusers += "," + unit_receiver_userids;
					}
				}
			}
			if(!StringUtil.isBlank(all_org_receiverusers)) {
				AllOrgReceiverusersArray = all_org_receiverusers.split(",");
			}
			if(AllOrgReceiverusersArray!=null){
				
				for (int j = 0; j < AllOrgReceiverusersArray.length; j++) {
					kbmdocreceiveruserbean = new KbmDocReceiverUserBean();
					kbmdocreceiveruserbean.setK_receiverid(StringUtil.getUUID());
					kbmdocreceiveruserbean.setK_doc_id(kbmDocBean.getK_doc_id());
					kbmdocreceiveruserbean.setK_receiver_userid(AllOrgReceiverusersArray[j]);
					UserCacheBean userCacheBean = UserCache.getUserCacheBean(AllOrgReceiverusersArray[j]);
					if(userCacheBean==null){
						continue;
					}
					kbmdocreceiveruserbean.setK_receiver_username(userCacheBean.getUser_realname());
					kbmdocreceiveruserbean.setK_receiveruser_orgid(userCacheBean.getOrg_id());
					kbmdocreceiveruserbean.setK_receiveruser_orgname(userCacheBean.getOrg_name());
					((BaseDao)dao).insert(kbmdocreceiveruserbean, conn);//保存用户接收人信息
				}
			}
			//特检院OA 追加适用部门ID 适用部门名称 end 
			//((BaseDao)dao).update(model, conn);//更新保存
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getKbmDocBeanById 按主键id值得到实体bean对象
	  * @param k_doc_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.service.KbmDocService#getKbmDocBeanById(java.lang.String) 
	  */
	public KbmDocBean getKbmDocBeanById(String k_doc_id) {
		Connection conn = null;		
		KbmDocBean kbmDocBean = new KbmDocBean();
		try {
			conn = DbManager.getInstance().getConnection();	
			kbmDocBean.setK_doc_id(k_doc_id);
			return (KbmDocBean)((BaseDao)dao).queryToBean(kbmDocBean,conn);			
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		}finally{
			DbManager.closeConnection(conn);
		}
		return kbmDocBean;
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteKbmDocBeanByIds 按ids批量删除
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.service.KbmDocService#deleteKbmDocBeanByIds(java.lang.String) 
	  */
	public boolean deleteKbmDocBeanByIds(String ids,KbmDocBean Bean) {
		Connection conn = null;
		boolean flag = false;
		KbmDocBean bean = new KbmDocBean();
		KbmDocSuggestBean suggestBean=new KbmDocSuggestBean();
		KbmDocOperateLogBean logbean=new KbmDocOperateLogBean();
		
		try {
			conn = DbManager.getInstance().getConnection();
			
			
			if(!StringUtil.isBlank(ids)){//bean里面有数据则是审核里面的删除发送短信
				String checkpass = SysParamUitl.getSysParamValueIsVALID(KbmConstants.KBM_NOTE_DELETEDOC);
				String docids[]=ids.split(",");
				KbmDocBean kbmDocBean=new KbmDocBean();
				for (String id : docids) {
					kbmDocBean.setK_doc_id(id);
					kbmDocBean=(KbmDocBean)((BaseDao)dao).queryToBean(kbmDocBean,conn);
					Map<String, String> kbmDocMap = RequestBeanUtils.transBean2Map(kbmDocBean);
		        	if(!StringUtil.nullOrBlank(checkpass)){
		        		String m_msg_contents = SysParamUitl.getSysParamValue(checkpass);
		            	List<Map<String, String>> listmap = SysParamUitl.getSysParamValueDetail(checkpass);
		            	if(!StringUtil.nullOrBlank(m_msg_contents) && listmap!=null && listmap.size()>0){
		            		for (Map<String, String> map : listmap){
		            			//System.out.println("map.get(\"p_value_name\")=="+map.get("p_value_name")+",map.get(\"p_value_code\")==="+map.get("p_value_code")+",kbmDocMap.get(map.get(\"p_value_code\"))=="+kbmDocMap.get(map.get("p_value_code")));
		            			if(kbmDocMap!=null && kbmDocMap.size()>0 && !StringUtil.nullOrBlank(kbmDocMap.get(map.get("p_value_code")))){
		            				m_msg_contents = m_msg_contents.replaceAll(map.get("p_value_name"),kbmDocMap.get(map.get("p_value_code")));
		            				kbmDocBean.setM_msg_contents(m_msg_contents);
		            			}
		            		}
		            	}	
		            	//发短信-----------------------------------------------------begin
		            	NoteBufferBean noteBufferBean = new NoteBufferBean();
		            	NoteDetailBean noteDetailBean = null;
		            	List<NoteDetailBean> detailList = new ArrayList<NoteDetailBean>();; 
		            	
		            	noteBufferBean.setContent(kbmDocBean.getM_msg_contents());
		            	noteBufferBean.setUser_id(kbmDocBean.getK_check_user());
		            	noteBufferBean.setUser_name(kbmDocBean.getK_check_user_name());
		            	String buffer_id = StringUtil.getUUID();
		            	noteBufferBean.setBuffer_id(buffer_id);
		            	
		            	//给上传人发短信-----------------
		            	Map<String, String> userMap = new HashMap<String, String>();
		            	userMap = userManagerServiceIfc.getUserBean(kbmDocBean.getK_create_user());
		            	if(!StringUtil.nullOrBlank(userMap.get("user_mobiletel1"))){
		            		noteDetailBean = new NoteDetailBean();
		            		noteDetailBean.setRecv_id(StringUtil.getUUID());
		            		noteDetailBean.setBuffer_id(buffer_id);
		            		noteDetailBean.setUser_id(kbmDocBean.getK_create_user());
		            		noteDetailBean.setUser_name(kbmDocBean.getK_create_user_name());
		            		noteDetailBean.setPhone_num(StringUtil.deNull(userMap.get("user_mobiletel1")));
		            		detailList.add(noteDetailBean);
		            	}
		            	if(noteBufferBean!=null && detailList!=null && detailList.size()>0){
		            		flag = noteService.doNoteSend(noteBufferBean, detailList, conn);
		            	}
		            	//发短信-----------------------------------------------------end
		        	}
				}
			}
			bean.setDeleteKey("k_doc_id");
			((BaseDao)dao).deleteListById(bean, conn, ids);
			
			//删除相应的推荐信息add by jie.xiao 8-27
			suggestBean.setDeleteKey("k_doc_id");
			((BaseDao)dao).deleteListById(suggestBean, conn, ids);
			//删除相应的文档用户操作记录信息 add by jie.xiao 8-29
			logbean.setDeleteKey("k_doc_id");
			((BaseDao)dao).deleteListById(logbean, conn, ids);
			
			//删除相应的收藏信息add by jie.xiao 9-27
			KbmDocFavoritesBean favoritesbean=new KbmDocFavoritesBean();
			favoritesbean.setDeleteKey("k_doc_id");
			((BaseDao)dao).deleteListById(favoritesbean, conn, ids);
			
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally {
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 updatekdcount 更新文档下载数
	  * @param k_doc_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.service.KbmDocService#updatekdcount(java.lang.String) 
	  */
	public boolean updatekdcount(String k_doc_id){
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getConnection();
			flag = dao.updatekdcount(k_doc_id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally {
			DbManager.closeConnection(conn);
		}
		return flag;
	}


	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 isWordAndOnlyOne  是否只有一个附件并且该附件为word格式 是则返回文档ID 不是则返回“no”    add by  jia.tong  2013-11-12
	  * @param k_doc_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.kbm.service.KbmDocService#isWordAndOnlyOne(java.lang.String)
	 */
	public String isWordAndOnlyOne(String k_doc_id) {
		Connection conn = null;
		List<Map<String, String>> fileInfos = new ArrayList<Map<String,String>>();
		int num = 0;  //总文件数
		int wordNum = 0; //word文件数目
		String fileId = "no"; // 文档的ID值
		try {
			conn = DbManager.getInstance().getConnection();
			fileInfos = dao.getAcceptInfo(k_doc_id);
			for (int i = 0; i < fileInfos.size(); i++) {
				Map<String, String> acceptMap = fileInfos.get(i);
				if("doc".equals(acceptMap.get("file_extra")) || "docx".equals(acceptMap.get("file_extra"))){
					fileId = acceptMap.get("file_id");
					wordNum++;
				}
				num++;
			}
			if((num==1)&&(wordNum==1)){
				return fileId;
			}else{
				fileId = "no";
			}
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally {
			DbManager.closeConnection(conn);
		}
		return fileId;
	}
	public Map<String,String> getFileDetail(String file_id){
		Map<String,String> map = new HashMap<String,String>();
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql1 = new StringBuffer();
		sql1.append("select file_id,file_name,file_extra,file_size,attach_id,yearfolder,monthfolder from OA_FILEUPLOAD_KBM o where o.file_id = ?");
		try {
			pdb.preparedSelect(sql1.toString());
			pdb.setString(1, file_id);
			pdb.executePrepared();
			if(pdb.size() > 0){
				map.put("file_extra", pdb.getString(0,"file_extra"));
				map.put("attach_id", pdb.getString(0,"attach_id"));
				map.put("yearfolder", pdb.getString(0,"yearfolder"));
				map.put("monthfolder", pdb.getString(0,"monthfolder"));
			}
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		return map;
	}


	@Override
	public boolean deleteUpdate(String ids) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getConnection();
			flag = dao.deleteUpdate(ids, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally {
			DbManager.closeConnection(conn);
		}
		return flag;
	}
}
