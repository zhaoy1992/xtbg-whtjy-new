package com.chinacreator.xtbg.core.archive.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.core.process.flowprocessing.util.Constant;
import com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao;
import com.chinacreator.xtbg.core.archive.service.ArchiveExtService;
import com.chinacreator.xtbg.core.archive.service.ArchiveService;
import com.chinacreator.xtbg.core.common.cache.OASystemCache;
import com.chinacreator.xtbg.core.common.fancyuoload.service.impl.FiletransferServiceImpl;
import com.chinacreator.xtbg.core.common.note.entity.NoteBufferBean;
import com.chinacreator.xtbg.core.common.note.entity.NoteDetailBean;
import com.chinacreator.xtbg.core.common.note.services.NoteService;
import com.chinacreator.xtbg.core.common.note.services.impl.NoteServiceImpl;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.MessageUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.dssave.entity.ViewListBean;
import com.chinacreator.xtbg.core.dssave.service.DsCRUDService;
import com.chinacreator.xtbg.core.dssave.service.impl.DsCRUDServiceImpl;
import com.chinacreator.xtbg.core.process.flowprocessing.dao.impl.FlowInstanceDataSaveDaoImpl;
import com.chinacreator.xtbg.core.process.flowprocessing.dao.impl.FlowViewDaoImpl;
import com.chinacreator.xtbg.core.process.flowprocessing.servlet.FlowServlet;
import com.chinacreator.xtbg.core.process.flowprocessing.util.FlowStaticTHreadData;
import com.chinacreator.xtbg.core.purviewmanager.service.UserManagerServiceIfc;
import com.chinacreator.xtbg.core.purviewmanager.service.impl.UserManagerServiceImpl;
import com.chinacreator.xtbg.core.sysparam.util.SysParamUitl;
import com.chinacreator.xtbg.core.wordnumdef.dao.WordNumDefDao;
import com.chinacreator.xtbg.core.wordnumdef.dao.impl.WordNumDefDaoImpl;
import com.chinacreator.xtbg.core.wordnumdef.entity.SerialNumberBean;
import com.chinacreator.xtbg.core.common.note.support.NoteConstants;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 *<p>Title:ArchiveServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-4-20
 */
public class OvercommonServiceImpl implements ArchiveService {
	
	private static final Log LOG = LogFactory.getLog(OvercommonServiceImpl.class);

	/**
	  * <b>Summary: </b>
	  *     复写方法 handler
	  * @param request
	  * @param response
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.service.ArchiveService#handler(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	public 	Map<String,Object> handler(HttpServletRequest request,
			HttpServletResponse response) {
		Map<String,Object> returnMap = new 	HashMap<String,Object>();
		boolean sucess = true;
		Connection conn = null;
		try{
			// 保存 业务bean
			DsCRUDService  dsCRUDService = new DsCRUDServiceImpl();
			// 保存意见信息  此处存在问题，如果出于心发起的流程中流程实例未保存，那么无法将意见信息插入到意见表中，如果将流程实例先保存那么无法控制事务。
			List<ViewListBean> viewListBeanList = dsCRUDService.getViewListInfo(request,conn);
			FlowInstanceDataSaveDaoImpl flowInstanceDataSaveDaoImpl = new FlowInstanceDataSaveDaoImpl();
			if(viewListBeanList.size()>0){
				//进行request 的封装
				FlowViewDaoImpl viewDao = new FlowViewDaoImpl();
				sucess = sucess && saveActionView(request, response, viewListBeanList, conn);
			}
			/*if(sucess){
				conn.commit();
			}else{
				conn.rollback();
			}*/
		}catch (Exception e) {
			//删除流程静态参数
			DbManager.rollBackNoThrow(conn);
			if(e.getStackTrace().length>=1){
				StackTraceElement ste = e.getStackTrace()[0];
				if("com.chinacreator.workflow.shark.WorkitemAction".equals(ste.getClassName())
					&&"getAssignment".equals(ste.getMethodName())
					&&435==ste.getLineNumber()){
					LOG.error("问题定位(通过经验定位,不能100%确定):该流程->流程配置->当前活动环节-->环节用户信息 没有配置当前用户");
				}
			}
			LOG.error("公文业务数据处理失败"+e.getMessage(), e);
			
			sucess = false;
			returnMap.put("flag", sucess);
			returnMap.put("erroMsg", e.getMessage());
			return returnMap;
		}finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		returnMap.put("flag", sucess);
		return returnMap;
	}

	
	public boolean saveActionView(HttpServletRequest request, HttpServletResponse response, List<ViewListBean> viewListBeanList, Connection con) throws Exception{
		if(viewListBeanList!=null){
			ViewListBean sameMessBean = new ViewListBean();
			//pc 手机端区别
			String mobile = StringUtil.deNull(request.getParameter("mobile"));
			if((!StringUtil.nullOrBlank(mobile)) || mobile.equals("mobile")){
				sameMessBean.setUser_id(request.getParameter("user_id"));
				sameMessBean.setUser_name(request.getParameter("user_name"));
				sameMessBean.setOrg_id(request.getParameter("org_id"));
				sameMessBean.setOrg_name(request.getParameter("org_name"));
			}else{
				//1.1取参数:从AccessControl取
				AccessControl control = AccessControl.getInstance();
				control.checkAccess(request, response);
				
				sameMessBean.setUser_id(control.getUserID());
				sameMessBean.setUser_name(control.getUserName());
				sameMessBean.setOrg_id(control.getChargeOrgId());
				sameMessBean.setOrg_name(control.getChargeOrgName());
			}
			
			
			//1.2取参数:从request取
			/*String flowDataJson = request.getParameter("flowData");//流程信息
			flowDataJson = DataControlUtil.replaceStr(flowDataJson);
			Map<String, String> flowData = (Map)JSONObject.parseObject(flowDataJson);// 根据字符串转换对象
*/			String action_ins_id = "37802_34101_hbjyswgzlc_hbjyswgzlc_wp1_hbjyswgzlc_wp1_act6";//flowData.get("actInsId");
			String ins_id = request.getParameter("ins_id");
			if(StringUtil.nullOrBlank(action_ins_id)){
				action_ins_id = ViewListBean.FIRST_ACTION_INS_ID;
				con=null;
			}
			sameMessBean.setIns_id(ins_id);
			sameMessBean.setAction_id("a5cf5e43-3144-4482-863c-fd5c8b0f8f8f");//flowData.get("action_id")
			sameMessBean.setAction_name("传阅/部门人员办理");//flowData.get("action_name")
			sameMessBean.setAction_ins_id(action_ins_id);
			
			
			PreparedDBUtil pdb = new PreparedDBUtil();
			
			
			//3
			StringBuffer sql = new StringBuffer();
			sql.append("insert into oa_flow_insviewlist ");
			sql.append("  (viewlist_id, ");
			sql.append("   ins_id, ");
			sql.append("   action_id, ");
			sql.append("   action_name, ");
			sql.append("   action_handeridea, ");
			sql.append("   hander_time, ");
			sql.append("   is_valid, ");
			sql.append("   org_id, ");
			sql.append("   org_name, ");
			sql.append("   user_id, ");
			sql.append("   user_name,");
			sql.append("   table_name,");
			sql.append("   column_name, ");
			sql.append("   ACTION_INS_ID) ");
			sql.append("values ");
			sql.append("  (?, ?, ?, ?, ?, sysdate, 'Y', ?, ?, ?, ?, ?, ?, ?) ");
			for (ViewListBean tmp : viewListBeanList) {
				//2如果不是第一个环节,考虑删除重复意见
				if(!action_ins_id.equals(ViewListBean.FIRST_ACTION_INS_ID)){
					sameMessBean.setTable_name(tmp.getTable_name());
					sameMessBean.setColumn_name(tmp.getColumn_name());
					delOldView(sameMessBean,pdb);
				}
				
				String viewlist_id = StringUtil.getUUID();
				
				pdb.preparedInsert(sql.toString());
				pdb.setString(1, viewlist_id);
				pdb.setString(2, sameMessBean.getIns_id());
				pdb.setString(3, sameMessBean.getAction_id());
				pdb.setString(4, sameMessBean.getAction_name());
				pdb.setString(5, tmp.getAction_handeridea());
				pdb.setString(6, sameMessBean.getOrg_id());
				pdb.setString(7, sameMessBean.getOrg_name());
				pdb.setString(8, sameMessBean.getUser_id());
				pdb.setString(9, sameMessBean.getUser_name());
				pdb.setString(10, tmp.getTable_name());
				pdb.setString(11, tmp.getColumn_name());
				pdb.setString(12, sameMessBean.getAction_ins_id());
				pdb.executePrepared();
			}
			
			
		}
		
		return true;
	}
	private void delOldView(ViewListBean sameMessBean,
			PreparedDBUtil pdb) {
		StringBuffer sql = new StringBuffer();
		sql.append("delete from oa_flow_insviewlist");
		sql.append(" where ins_id = '"+sameMessBean.getIns_id()+"'");
		sql.append("   and action_id = '"+sameMessBean.getAction_id()+"'");
		sql.append("   and action_ins_id = '"+sameMessBean.getAction_ins_id()+"'");
		sql.append("   and table_name = '"+sameMessBean.getTable_name()+"'");
		sql.append("   and column_name = '"+sameMessBean.getColumn_name()+"'");
		sql.append("   and user_id = '"+sameMessBean.getUser_id()+"'");
		
		try {
			pdb.executeDelete(sql.toString());
		} catch (Exception e) {
			e.printStackTrace();
			LOG.debug(e.getClass().getName()+";insId:"+sameMessBean.getIns_id());
		}
	}
	/**
	 * 
	*<b>Summary: </b>
	* getInsName(根据表达式获取流程实例名称)
	* @param request
	* @param ruleString
	* @return
	*/
  private String getInsName(HttpServletRequest request,String ruleString) throws Exception{
      String title =  "";	
	  String regEx= "\\{(.*?)\\}"; 
	  Pattern p=Pattern.compile(regEx); 
	  Matcher m=p.matcher(ruleString); 
	  while(true){
		  if(m.find()){
			  title  =  request.getParameter(m.group(1));
			  if(title !=null){
				  ruleString = m.replaceFirst(title);
			  }else{
				  throw new Exception("根据表达式获取流程实例名称时出错！");
			  }
			  m=p.matcher(ruleString); 
		  }else{
			  break;
		  }
	  }
	  return ruleString.toString();
    }
  
  	/**
  	 * 
  	*<b>Summary: </b>
  	* getMsgTxt(获取系统参数配置的短信内容)
  	* @param msgtxt
  	* @param insMap
  	* @return
  	 */
  	public String getMsgTxt(String msgtxt,Map<String,String> insMap){
  		List<Map<String, String>> listmap = SysParamUitl.getSysParamValueDetail(Constant.ARCHIVE_MSG_SEND);
		if(!StringUtil.nullOrBlank(msgtxt) && listmap!=null && listmap.size()>0){
			for (Map<String, String> map1 : listmap){
				//System.out.println("map.get(\"p_value_name\")=="+map.get("p_value_name")+",map.get(\"p_value_code\")==="+map.get("p_value_code")+",kbmDocMap.get(map.get(\"p_value_code\"))=="+kbmDocMap.get(map.get("p_value_code")));
				if(insMap!=null && insMap.size()>0 && !StringUtil.nullOrBlank(insMap.get(map1.get("p_value_code")))){
					msgtxt = msgtxt.replaceAll("【"+map1.get("p_value_name")+"】","【"+insMap.get(map1.get("p_value_code"))+"】");
				}
			}
		}
		return msgtxt;
  	}
  	/**
	 * 
	*<b>Summary: </b>
	* sendMessage(发送短信)
	* @param request
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean sendNote(HttpServletRequest request,Map<String,String> insMap, Connection conn) throws Exception{
		boolean sucess = true;
		//String user_id = insMap.get("send_user_id");	//活动执行人
		String user_id = request.getParameter("DYNAMICPERFORMER_ID");	
		if(!StringUtil.isBlank(user_id)){
			NoteService noteService = new NoteServiceImpl();
			UserManagerServiceIfc userManagerServiceIfc = new UserManagerServiceImpl();
			String[] user_ids = null;
			if(!StringUtil.isBlank(user_id)){
				user_ids = user_id.split(",");
			}
			String msgtxt = request.getParameter("msg_txt");
			msgtxt = getInsName(request, msgtxt);//获取短信内容
			//获取替换参数配置内容
			msgtxt = getMsgTxt(msgtxt,insMap);
			
			NoteBufferBean noteBufferBean = new NoteBufferBean();
			NoteDetailBean noteDetailBean = null;
			List<NoteDetailBean> detailList = new ArrayList<NoteDetailBean>();; 
			Map<String, String> viewMap = null;
			noteBufferBean.setContent(msgtxt);
			noteBufferBean.setUser_id(insMap.get("send_user_id"));
			noteBufferBean.setUser_name(insMap.get("send_user_name"));
			String buffer_id = StringUtil.getUUID();
			noteBufferBean.setBuffer_id(buffer_id);
			noteBufferBean.setBusiness_type(insMap.get("business_type"));
			
			for (int j = 0; j < user_ids.length; j++) {
				viewMap = new HashMap<String, String>();
				viewMap = userManagerServiceIfc.getUserBean(user_ids[j]);
				if(!StringUtil.nullOrBlank(viewMap.get("user_mobiletel1"))){
					noteDetailBean = new NoteDetailBean();
					noteDetailBean.setRecv_id(StringUtil.getUUID());
					noteDetailBean.setBuffer_id(buffer_id);
					noteDetailBean.setUser_id(user_ids[j]);
					noteDetailBean.setUser_name(StringUtil.deNull(viewMap.get("user_name")));
					noteDetailBean.setPhone_num(StringUtil.deNull(viewMap.get("user_mobiletel1")));
					detailList.add(noteDetailBean);
				}
			}
			if(noteBufferBean!=null && detailList.size()>0){
				sucess = sucess && noteService.doNoteSend(noteBufferBean, detailList, conn);//  短信发送
			}
			
		}
		return true;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* sendZnxx(发送站内消息)
	* @param request
	* @param conn
	* @param flowData
	* @return
	* @throws Exception
	 */
	public boolean sendZnxx(HttpServletRequest request, Map<String,String> insMap,Connection conn) throws Exception{
		MessageUtil util=new MessageUtil();
		String send_userid= insMap.get("send_user_id");
		String user_id = request.getParameter("DYNAMICPERFORMER_ID");
		String msgtxt = request.getParameter("msg_txt");
		msgtxt = getInsName(request, msgtxt);//获取短信内容
		//获取替换参数配置内容
		msgtxt = getMsgTxt(msgtxt,insMap);
	
		String user_ids[]=null;
		List<String> user_list=new ArrayList<String>();
		if(!StringUtil.isBlank(user_id)){
			user_ids=user_id.split(",");
			for (String id : user_ids) {
				user_list.add(id);
			}
		}
		util.sendMsg(msgtxt, send_userid, user_list, conn);
		return true;
	}
	/**
	 * 
	*<b>Summary: </b>
	* sendMessage(发送即时信息)
	* @param request
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean sendMessage(HttpServletRequest request, Connection conn) throws Exception{
		return true;
	}
}
