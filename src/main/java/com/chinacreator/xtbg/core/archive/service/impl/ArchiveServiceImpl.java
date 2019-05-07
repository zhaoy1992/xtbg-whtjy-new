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
/**
 *<p>Title:ArchiveServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-4-20
 */
public class ArchiveServiceImpl implements ArchiveService {
	
	private static final Log LOG = LogFactory.getLog(ArchiveServiceImpl.class);

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
			//ready
			String flowDataJson = request.getParameter("flowData");//流程信息
			String busi_id = request.getParameter("busi_id");//业务ID
			String otp_type = request.getParameter("opt_type");//操作类型
			flowDataJson = DataControlUtil.replaceStr(flowDataJson);
			Map<String, String> flowData = (Map)JSONObject.parseObject(flowDataJson);// 根据字符串转换对象
			String insNameRule = StringUtil.deNull(request.getParameter("insname_rule"));
			String mRecordID = StringUtil.deNull(request.getParameter("mRecordID"));
			String operationType = request.getParameter("operationType");	//操作类型
				String extParms = StringUtil.deNull(request.getParameter("extParms"));
			flowData.put("extParms", extParms); //业务参数ID
			String initType = StringUtil.deNull(request.getParameter("initType"));
			flowData.put("initType", initType); //code 类型
			if("".equals(insNameRule)){
				throw new Exception("流程实例名称规则表达式为空");
			}
			String insName = getInsName(request, insNameRule);
			
			String status_code = StringUtil.deNull(flowData.get("status_code"));//
			String ins_id = StringUtil.deNull(flowData.get("ins_id"));
			String action_id = StringUtil.deNull(flowData.get("action_id"));//流程环节ID
			
			if(StringUtil.isBlank(ins_id)){
				ins_id = StringUtil.getUUID();
				flowData.put("ins_id", ins_id);//此处只是将ins_id PUT进MAP ，但是在后面环节通过request.getParameter("flowData");取值的时候会不会有问题。
			}
			request.setAttribute("ins_id", ins_id);
			request.setAttribute("insName", insName);
			request.setAttribute("bussinessID", busi_id);
			request.setAttribute("action_id", action_id);
			
			conn = DbManager.getInstance().getTransactionConnection();
			//插入流水号
			String serialNumberBeanStr = request.getParameter("serialNumberBeanStr");
			String isSerialNumberBeanStr = request.getParameter("isSerialNumberBeanStr");
			//如果保存流水号，不是反复暂存。
			if(!"04".equals(status_code)&&!StringUtil.isBlank(isSerialNumberBeanStr)&& "1".equals(isSerialNumberBeanStr)){
				WordNumDefDao wordNumDefDao = new WordNumDefDaoImpl();
				SerialNumberBean serialNumberBean = (SerialNumberBean) JSONObject.parseObject(serialNumberBeanStr,SerialNumberBean.class);
				if(serialNumberBean==null){
					throw new Exception("转换流水号传输出错！");
				}else{
					//判断流水号是否存在
					boolean isExist = wordNumDefDao.isExistNum(serialNumberBean,conn);
					if(isExist){
						throw new Exception("该流水号已经存在，请重新编号！");
					}
					//如果不存在，插入。
					serialNumberBean.setIns_id(ins_id);
					wordNumDefDao.insertSerialNumber(serialNumberBean,conn);
				}
			}
			WordNumDefDao wordNumDefDao = new WordNumDefDaoImpl();
			// 保存 业务bean
			DsCRUDService  dsCRUDService = new DsCRUDServiceImpl();
			if("save".equals(otp_type)){//新增操作
				sucess = sucess && dsCRUDService.dsSave(request, conn);
			}else if("update".equals(otp_type)){//新增操作
				sucess = sucess && dsCRUDService.dsUpdate(request, conn);
			}else{//修改操作
				throw new Exception("获取操作类型失败！");
			}
			
			// 保存意见信息  此处存在问题，如果出于心发起的流程中流程实例未保存，那么无法将意见信息插入到意见表中，如果将流程实例先保存那么无法控制事务。
			List<ViewListBean> viewListBeanList = dsCRUDService.getViewListInfo(request,conn);
			FlowInstanceDataSaveDaoImpl flowInstanceDataSaveDaoImpl = new FlowInstanceDataSaveDaoImpl();
			if(viewListBeanList.size()>0){
				FlowViewDaoImpl viewDao = new FlowViewDaoImpl();
				sucess = sucess && viewDao.saveActionView(request, response, viewListBeanList, conn);

			}
			
			//是否存档，发送到档案
			String isSaveData = request.getParameter("isSaveData");	
			if(!StringUtil.isBlank(isSaveData) && "true".equals(isSaveData)){
				String saveData = request.getParameter("saveData");
				String saveDataJson = DataControlUtil.replaceStr(saveData);
				Map<String, String> saveDataMap = (Map)JSONObject.parseObject(saveDataJson);// 根据字符串转换对象
				saveDataMap.put("F_TITLE", insName);//标题赋值
				String numberNo = flowInstanceDataSaveDaoImpl.getNumberNo(busi_id,conn); //根据业务ID获取文号
				saveDataMap.put("F_FILE_NO", numberNo);//赋值文号
				saveDataMap.put("mFilePath", request.getSession().getServletContext().getRealPath("")+FiletransferServiceImpl.upload_To_SeverPath);//附件路径
				//sucess = sucess && flowInstanceDataSaveDaoImpl.sendToFile(saveDataMap,conn);//保存到档案表
				sucess = sucess && flowInstanceDataSaveDaoImpl.sendToFileByInsId((String) flowData.get("accepter_id"), ins_id, conn);//保存到档案表
			}
			
			//在流程处理时,订制个性化增删改
			String customClassName = request.getParameter(FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG);
			if(sucess&&!StringUtil.isBlank(customClassName)){
				FlowBusiDataSaveDao dao = (FlowBusiDataSaveDao)Class.forName(customClassName).newInstance();
				sucess = dao.saveBusiInfo(request, conn);
			}
			//根据业务类型配置的实现类， 去执行该实现类的方法
			String busiTypeCode = request.getParameter("busiTypeCode");
			if(LoadSpringContext.getApplicationContext().containsBean(busiTypeCode)){
				ArchiveExtService service = (ArchiveExtService)LoadSpringContext.getApplicationContext().getBean(busiTypeCode);
				if(service!=null){
					service.doExtFlow(request, flowData, conn);
				}
			}
			//流程发起，放最后
			FlowServlet flowServlet = new FlowServlet();
			sucess = sucess && flowServlet.flowHaddle(request, response, conn);
			
			//组装短信参数
			Map<String,String> insMap = new HashMap<String,String>();
			String send_user_id= (String) flowData.get("accepter_id");
			String send_user_name= (String) flowData.get("accepter");
			insMap.put("send_user_id", send_user_id);
			insMap.put("send_user_name", send_user_name);
			insMap.put("ins_name", insName);
			insMap.put("business_type", NoteConstants.SEND_FLOW);
			//  短信发送
			String isdxtx = request.getParameter("isdxtx");
			if(!StringUtil.isBlank(isdxtx) && "1".equals(isdxtx)){
				sucess = sucess &&this.sendNote(request,insMap, conn);
			}
			// 及时消息提醒
			String isjsxx = request.getParameter("isjsxx");
			if(!StringUtil.isBlank(isjsxx) && "1".equals(isjsxx)){
				sucess = sucess &&this.sendMessage(request, conn);
			}
			// 邮件提醒
			String isyj = request.getParameter("isyj");
			if(!StringUtil.isBlank(isyj) && "1".equals(isyj)){
				
			}
			// 站内消息
			String isznxx = request.getParameter("isznxx");
			if(!StringUtil.isBlank(isznxx) && "1".equals(isznxx)){
				sucess = sucess && this.sendZnxx(request,insMap,conn);
			}
			
			//如果正文ID不为空，并且配置了保存备份正文信息，备份正文，放在流程发起之后。
			String saveastext = OASystemCache.getContextProperty("saveastext");
			if(("dostartflow".equals(operationType)||"docompleteworkflow".equals(operationType))&& !StringUtil.isBlank(mRecordID) && "true".equals(saveastext)){
				sucess = sucess && dsCRUDService.saveAsText(ins_id,action_id,mRecordID,conn);
			}
			
			//是否公开 更新OA_FLOW_INSTANCE是否公开字段
			String is_open = request.getParameter("is_open");
			if(!StringUtil.isBlank(is_open)){
				sucess = sucess &&dsCRUDService.updateIs_open(is_open,ins_id, conn);
			}
			
			//是否信息分类 更新OA_FLOW_INSTANCE是否信息分类字段
			String info_type = request.getParameter("info_type");
			if(!StringUtil.isBlank(info_type)){
				sucess = sucess &&dsCRUDService.updateInfoType(info_type, ins_id, conn);
			}
			String chief_endtime = request.getParameter("chief_endtime");
			if(!StringUtil.isBlank(chief_endtime)){
				sucess = sucess &&dsCRUDService.updateChiefEndTime(chief_endtime, ins_id, conn);
			}
			
			//TODO 请在此处插入新代码
			
			//最后:检测 并 自动办结
			sucess = sucess && flowServlet.checkAndAutoFinishWorkflow(flowData, request, response, conn);
			if(sucess){
				conn.commit();
			}else{
				conn.rollback();
			}
		}catch (Exception e) {
			//删除流程静态参数
			FlowStaticTHreadData.removeAll();
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
