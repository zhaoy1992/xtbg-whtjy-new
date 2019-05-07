
<%@page import="com.chinacreator.xtbg.core.subsystemmanage.entity.OaGwcsConfigBean"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.WordArchiveService"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.impl.WordArchiveServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.archive.entity.ArchiveDispatchBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.subsystemmanage.dao.SubSystemOrgConfigDao"%>
<%@page import="com.chinacreator.xtbg.core.subsystemmanage.dao.impl.GwcsOrgConfigDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OASystemCache" %>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache" %>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean" %>
<%@page import="java.util.Map"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.chinacreator.xtbg.core.common.fancyuoload.service.impl.FiletransferServiceImpl;"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String mRecordID = request.getParameter("mRecordID");
	String ins_id = request.getParameter("ins_id");
	String busi_id = request.getParameter("busi_id");
	String optType = request.getParameter("optType");

	boolean  flag  = false;
	WordArchiveService service = new WordArchiveServiceImpl();
	if("sendWorToArchive".equals(optType)){
		String uuid = service.wordToGWCS(ins_id,mRecordID,"");
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("uuid",uuid);
		out.print(jsonObj);
	}else if("saveArchiveInfo".equals(optType)){
		String returnStr = "";
		ArchiveDispatchBean archiveDispatchBean = new ArchiveDispatchBean();
		RequestBeanUtils.getValuesByRequest(request, archiveDispatchBean);//获取表单提交过来的数据 
		String gwcs_address = StringUtil.deNull(request.getParameter("gwcs_address"));
		archiveDispatchBean.setRecordid(mRecordID);//正文ID
		archiveDispatchBean.setGwcs_address(gwcs_address);//公文传输地址
		archiveDispatchBean.setRemark1(gwcs_address);//将地址薄放入保留字段
		SubSystemOrgConfigDao subSystemOrgConfigDao = (GwcsOrgConfigDaoImpl)LoadSpringContext.getApplicationContext().getBean("gwcsOrgConfigDaoImpl");
		String orgid = accesscontroler.getChargeOrgId();//机构ID
		Map<String,String> orgMap =  subSystemOrgConfigDao.findSubSystemOrgMappingInfoByOAid(orgid);
		String send_org_config = StringUtil.deNull(request.getParameter("send_org_config"));
		archiveDispatchBean.setSend_org_config(send_org_config);
		//根据配置ID，获取该配置的发文单位信息。
		OaGwcsConfigBean oaGwcsConfigBean = subSystemOrgConfigDao.getGwcsConfigByID(send_org_config);
		System.out.println(oaGwcsConfigBean.getGwcs_org_name()+"----"+send_org_config);
		
		if(orgMap!= null && !StringUtil.isBlank(orgMap.get("gwcs_orgaddr"))){
			archiveDispatchBean.setSend_org_addr(orgMap.get("gwcs_orgaddr"));
			archiveDispatchBean.setSend_org_id(orgMap.get("gwcs_org_id"));
			archiveDispatchBean.setSend_org_name(orgMap.get("gwcs_orgname"));
			returnStr = service.sendToArchiveCeb(archiveDispatchBean,"");
		}else{
			returnStr = "无法获取配置的公文传输单位，请按照在外部子系统中配置单位映射！";
		}
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("returnStr",returnStr);
		out.print(jsonObj);
		
	}else if("saveArchiveServer".equals(optType)){
		String erroInfo = "";
		String uuid = "";
		ArchiveDispatchBean archiveDispatchBean = new ArchiveDispatchBean();
		RequestBeanUtils.getValuesByRequest(request, archiveDispatchBean);//获取表单提交过来的数据 
		String gwcs_address = StringUtil.deNull(request.getParameter("gwcs_address"));
		archiveDispatchBean.setGwcs_address(gwcs_address);//公文传输地址
		archiveDispatchBean.setRemark1(gwcs_address);//将地址薄放入保留字段
		archiveDispatchBean.setRecordid(mRecordID);//正文ID
		SubSystemOrgConfigDao subSystemOrgConfigDao = (GwcsOrgConfigDaoImpl)LoadSpringContext.getApplicationContext().getBean("gwcsOrgConfigDaoImpl");
		
		String send_org_config = StringUtil.deNull(request.getParameter("send_org_config"));
		archiveDispatchBean.setSend_org_config(send_org_config);
		//根据配置ID，获取该配置的发文单位信息。
		OaGwcsConfigBean oaGwcsConfigBean = subSystemOrgConfigDao.getGwcsConfigByID(send_org_config);
		System.out.println(oaGwcsConfigBean.getGwcs_org_name()+"----"+send_org_config);
		
		String orgid = accesscontroler.getChargeOrgId();//机构ID
		//Map<String,String> orgMap =  subSystemOrgConfigDao.findSubSystemOrgMappingInfoByOAid(orgid);
		
		if(oaGwcsConfigBean!= null && !StringUtil.isBlank(oaGwcsConfigBean.getGwcs_org_addr())){
			archiveDispatchBean.setSend_org_addr(oaGwcsConfigBean.getGwcs_org_addr());
			archiveDispatchBean.setSend_org_id(oaGwcsConfigBean.getGwcs_org_id());
			archiveDispatchBean.setSend_org_name(oaGwcsConfigBean.getGwcs_org_name());
			archiveDispatchBean.setSender(accesscontroler.getUserName());
			uuid = service.wordToGWCS(ins_id,mRecordID,oaGwcsConfigBean.getWordtogwcswsdl());
			//service.sendToArchive(archiveDispatchBean,"96ac6ba1-3e99-4c41-8e04-ec2fac222952");
			
			if(!StringUtil.isBlank(uuid)){//如果上传成功，那么将数据保存到公文要素表中
				archiveDispatchBean.setArchive_returnid(uuid);
				archiveDispatchBean.setIs_send("0");//设置是否发送成功为0，未发送
				String send_attach_id = StringUtil.deNull(request.getParameter("send_attach_id"));
				if(!StringUtil.isBlank(send_attach_id)){
					service.toTempFile(mRecordID,ins_id,busi_id,send_attach_id);
				}else{
					uuid = "erro";
					erroInfo = "无法正确的将附件生成到临时文件夹！";
				}
				//保存公文要素信息
				boolean flag1 = service.saveOrUpdateArchiveDispatch(archiveDispatchBean);
				if(!flag1){
					uuid = "erro";
					erroInfo = "无法正确的保存公文要素！";
				}
				
			}else{
				uuid = "erro";
				erroInfo = "WORD文档上传失败，无法获取公文系统返回的正确的UUID！";
			}
			
		}else{
			uuid = "erro";
			erroInfo = "无法获取配置的公文传输单位，请按照在外部子系统中配置单位映射！";
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("uuid",uuid);
		jsonObj.put("erroInfo",erroInfo);
		out.print(jsonObj);
		
	}else if("toTempFile".equals(optType)){
		String n_attach_id = StringUtil.deNull(request.getParameter("n_attach_id"));
		flag = service.toTempFile(mRecordID,ins_id,busi_id,n_attach_id);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("flag",flag);
		out.print(jsonObj);
	}else if("sendArchiveFZ".equals(optType)){
		String returnStr = "";
		ArchiveDispatchBean archiveDispatchBean = new ArchiveDispatchBean();
		RequestBeanUtils.getValuesByRequest(request, archiveDispatchBean);//获取表单提交过来的数据 
		String gwcs_address = StringUtil.deNull(request.getParameter("gwcs_address"));
		archiveDispatchBean.setRecordid(mRecordID);//正文ID
		archiveDispatchBean.setGwcs_address(gwcs_address);//公文传输地址
		archiveDispatchBean.setRemark1(gwcs_address);//将地址薄放入保留字段
		SubSystemOrgConfigDao subSystemOrgConfigDao = (GwcsOrgConfigDaoImpl)LoadSpringContext.getApplicationContext().getBean("gwcsOrgConfigDaoImpl");
		String orgid = accesscontroler.getChargeOrgId();//机构ID
		String user_id = accesscontroler.getUserID();//用户
		UserCacheBean userBean = UserCache.getUserCacheBean(user_id);//获得缓存的用户信息
		//插入用户信息
		if(userBean!=null){
			archiveDispatchBean.setSend_user_id(userBean.getUser_name());
			archiveDispatchBean.setSend_user_password(userBean.getUser_password());	
		}
		//modify by shuqi.liu 2014-01-15 修改了公文传输发送地址，以前是根据配置取地址，现在是直接发送UNIT地址，此处有单位，机构同步问题
		//archiveDispatchBean.setSend_org_addr(userBean.getUnit_id());
		//archiveDispatchBean.setSend_org_id(userBean.getUnit_id());
		//archiveDispatchBean.setSend_org_name(userBean.getUnit_name());
		archiveDispatchBean.setSend_org_addr(userBean.getOrg_id());
		archiveDispatchBean.setSend_org_id(userBean.getOrg_id());
		archiveDispatchBean.setSend_org_name(userBean.getOrg_name());
		returnStr = service.sendToArchiveFZ(archiveDispatchBean);
		
		//Map<String,String> orgMap =  subSystemOrgConfigDao.findSubSystemOrgMappingInfoByOAid(orgid);
		//if(orgMap!= null && !StringUtil.isBlank(orgMap.get("gwcs_orgaddr"))){
		//	archiveDispatchBean.setSend_org_addr(orgMap.get("gwcs_orgaddr"));
		//	archiveDispatchBean.setSend_org_id(orgMap.get("gwcs_org_id"));
		//	archiveDispatchBean.setSend_org_name(orgMap.get("gwcs_orgname"));
			
		//	returnStr = service.sendToArchiveFZ(archiveDispatchBean);
		//}else{
		//	returnStr = "无法获取配置的公文传输单位，请按照在外部子系统中配置单位映射！";
		//}
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("returnStr",returnStr);
		out.print(jsonObj);
	}else if("agentSendArchive".equals(optType)){//有章分发，将WORD上传至公文传输。将公文要素，公文地址保存到表中
		String erroInfo = "";
		String uuid = "";
		ArchiveDispatchBean archiveDispatchBean = new ArchiveDispatchBean();
		RequestBeanUtils.getValuesByRequest(request, archiveDispatchBean);//获取表单提交过来的数据 
		String gwcs_address = StringUtil.deNull(request.getParameter("gwcs_address"));
		archiveDispatchBean.setGwcs_address(gwcs_address);//公文传输地址
		archiveDispatchBean.setRemark1(gwcs_address);//将地址薄放入保留字段
		archiveDispatchBean.setRecordid(mRecordID);//正文ID
		SubSystemOrgConfigDao subSystemOrgConfigDao = (GwcsOrgConfigDaoImpl)LoadSpringContext.getApplicationContext().getBean("gwcsOrgConfigDaoImpl");
		String send_org_config = StringUtil.deNull(request.getParameter("send_org_config"));
		archiveDispatchBean.setSend_org_config(send_org_config);
		//根据配置ID，获取该配置的发文单位信息。
		OaGwcsConfigBean oaGwcsConfigBean = subSystemOrgConfigDao.getGwcsConfigByID(send_org_config);
		System.out.println(oaGwcsConfigBean.getGwcs_org_name()+"----"+send_org_config);
		
		String orgid = accesscontroler.getChargeOrgId();//机构ID
		//Map<String,String> orgMap =  subSystemOrgConfigDao.findSubSystemOrgMappingInfoByOAid(orgid);
		if(oaGwcsConfigBean!= null && !StringUtil.isBlank(oaGwcsConfigBean.getGwcs_org_addr())){
			archiveDispatchBean.setSend_org_addr(oaGwcsConfigBean.getGwcs_org_addr());
			archiveDispatchBean.setSend_org_id(oaGwcsConfigBean.getGwcs_org_id());
			archiveDispatchBean.setSend_org_name(oaGwcsConfigBean.getGwcs_org_name());
			archiveDispatchBean.setSender(accesscontroler.getUserName());
			uuid = service.wordToGWCS(ins_id,mRecordID,oaGwcsConfigBean.getWordtogwcswsdl());
			//service.sendToArchive(archiveDispatchBean,"96ac6ba1-3e99-4c41-8e04-ec2fac222952");
			
			if(!StringUtil.isBlank(uuid)&& !"erro".equals(uuid)){//如果上传成功，那么将数据保存到公文要素表中
				archiveDispatchBean.setArchive_returnid(uuid);
				archiveDispatchBean.setIs_send("0");//设置是否发送成功为0，未发送
				String send_attach_id = StringUtil.deNull(request.getParameter("send_attach_id"));
				if(!StringUtil.isBlank(send_attach_id)){
					service.toTempFile(mRecordID,ins_id,busi_id,send_attach_id);
				}else{
					uuid = "erro";
					erroInfo = "无法正确的将附件生成到临时文件夹！";
				}
				//保存公文要素信息，地址信息
				boolean flag1 = service.saveOrUpdateArchiveDispatch(archiveDispatchBean);
				if(!flag1){
					uuid = "erro";
					erroInfo = "无法正确的保存公文要素，地址信息！";
				}
				
			}else{
				uuid = "erro";
				erroInfo = "WORD文档上传失败，无法获取公文系统返回的正确的UUID！";
			}
			
		}else{
			uuid = "erro";
			erroInfo = "无法获取配置的公文传输单位，请按照在外部子系统中配置单位映射！";
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("uuid",uuid);
		jsonObj.put("erroInfo",erroInfo);
		out.print(jsonObj);
	}else if("getArchiveUUID".equals(optType)){//根据流程实例ID，获取保存在公文要素表中，已经上传到公文传输系统的UUID
		String uuid = service.getUUID(ins_id); 
		String gwcsjspaddress = OASystemCache.getContextProperty("gwcsjspaddress");
		//根据流程实例ID 获取公文要素配置
		WordArchiveService archiveService = new WordArchiveServiceImpl();
		ArchiveDispatchBean archiveDispatchBean = archiveService.getArchiveDispatchbean(ins_id);
		//根据配置ID 获取盖章页面
		String send_org_config = archiveDispatchBean.getSend_org_config();
		if(!StringUtil.isBlank(send_org_config)){
			SubSystemOrgConfigDao subSystemOrgConfigDao = (GwcsOrgConfigDaoImpl)LoadSpringContext.getApplicationContext().getBean("gwcsOrgConfigDaoImpl");
			OaGwcsConfigBean oaGwcsConfigBean = subSystemOrgConfigDao.getGwcsConfigByID(send_org_config);
			String gwcsjspaddressConfig = oaGwcsConfigBean.getGwcsjspaddress();
			//如果页面配置盖章页面为空，那么取配置文件
			if(!StringUtil.isBlank(gwcsjspaddressConfig)){
				gwcsjspaddress = gwcsjspaddressConfig;
			}
		}
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("uuid",uuid);
		jsonObj.put("gwcsjspaddress",gwcsjspaddress);
		out.print(jsonObj);
	}else if("getTempActionId".equals(optType)){//根据流程实例ID，获取暂存环节ID
		String action_id = service.getTempActionId(request.getParameter("ins_id"));
		out.print(action_id);
	}else if("initFlowInFlow".equals(optType)){
		//copy from FileUploadServlet
  		String mFilePath = request.getSession().getServletContext().getRealPath("")+FiletransferServiceImpl.upload_To_SeverPath;
		Map<String,String> argMap = new HashMap<String,String>();
		argMap.put("flowTitle", request.getParameter("flowTitle"));
		argMap.put("textIdYW", request.getParameter("textIdYW"));
		argMap.put("textIdMQ", request.getParameter("textIdMQ"));
		argMap.put("textIdZBD", request.getParameter("textIdZBD"));
		argMap.put("attachId", request.getParameter("attach_id"));
		argMap.put("oldAttachId", request.getParameter("oldAttachId"));
		argMap.put("mFilePath", mFilePath);
		argMap.put("userId", accesscontroler.getUserID());
		
		
		Map<String,String> messMap = service.copyAttachForNewFlow(argMap);
		out.print(JSONObject.toJSON(messMap));
	}
%>

