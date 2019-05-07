<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@ page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@ page import="com.alibaba.fastjson.JSONObject" %>
<%@ page import="java.util.List"%>
<%@ page import="com.chinacreator.eform.util.Escape"%>
<%@ page import="com.chinacreator.xtbg.core.kbm.entity.KbmDocBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="com.chinacreator.xtbg.core.kbm.dao.*"%>
<%@page import="com.chinacreator.xtbg.core.kbm.entity.*"%>
<%@page import="com.chinacreator.xtbg.core.kbm.service.*"%>
<%@page import="com.chinacreator.xtbg.core.kbm.service.impl.*"%>
<%@page import="com.chinacreator.xtbg.core.kbm.util.KbmConstants"%>
<%@ page import="com.chinacreator.xtbg.core.file.entity.FileDocBean"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	String userid = accesscontroler.getUserID();
	String username = accesscontroler.getUserName();
	accesscontroler.checkAccess(request, response);
	String action   = request.getParameter("action");
	String opentype = request.getParameter("opentype");
	KbmDocService service = new KbmDocServiceImpl();
	KbmDocFavoritesService kbmDocFavoritesService  = new KbmDocFavoritesServiceImpl();
	KbmDocSuggestService kbmDocSuggestService   = new KbmDocSuggestServiceImpl();
	boolean flag = false;
	JSONObject json = new JSONObject();
	try{
		if("delete".equalsIgnoreCase(action)){
			KbmDocBean model = new KbmDocBean();
			model = (KbmDocBean) RequestBeanUtils.getValuesByRequestObj(request, model,"kbmdocbean");
			String ids = request.getParameter("ids");
			flag = service.deleteKbmDocBeanByIds(ids,model);
		}else if ("save".equalsIgnoreCase(action)){
			KbmDocBean model = new KbmDocBean();
			model = (KbmDocBean) RequestBeanUtils.getValuesByRequestObj(request, model,"kbmdocbean");
			if("uncheck".equalsIgnoreCase(opentype) || "checked".equalsIgnoreCase(opentype)){
				flag = service.checkKbmDocBean(model);
			}else{
				flag = service.updateKbmDocBean(model);
			}
		}else if ("addfavorites".equalsIgnoreCase(action)){
			String k_doc_ids = request.getParameter("k_doc_ids");
			flag = kbmDocFavoritesService.insertKbmDocFavorites(userid,username,k_doc_ids);
		}else if ("addsuggest".equalsIgnoreCase(action)){
			String usercacheid = accesscontroler.getUserID();
			String k_doc_id = request.getParameter("k_doc_id");
			String userids = request.getParameter("userids");
			flag = kbmDocSuggestService.insertKbmDocSuggest(userids,k_doc_id,usercacheid);
		}else if ("updatekdcount".equalsIgnoreCase(action)){
			String k_doc_id = request.getParameter("k_doc_id");
			flag = service.updatekdcount(k_doc_id);
		}else if("deleteUpdate".equalsIgnoreCase(action)){//删除更新通知
			String id = request.getParameter("ids");
			flag = service.deleteUpdate(id);
		}
	}catch (Exception e){
		json.put("info",e.getMessage());
	}
	json.put("flag",flag);
	out.print(json);
%>