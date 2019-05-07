<%--
描述：办公用品入库数据处理页面
作者：童佳
版本：1.0
日期：2014-03-11
--%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.tjy.detectionsupplies.entity.OsHavaObjectBean"%>
<%@page import="com.chinacreator.xtbg.tjy.detectionsupplies.service.impl.OsHavaObjectServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.detectionsupplies.service.OsHavaObjectService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.regex.Matcher"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	String responseCode="";//1:回调js
	Object responseObj=null;
	String responseObj_SUCCESS="操作成功";
	String responseObj_FIAL="操作失败";
	
	 //物品名称
    String OFUSTYPE_NAME_VALUE = request.getParameter("OFUSTYPE_NAME_VALUE");
    
    //物品规格名称
    String IT_NAME_VALUE = request.getParameter("IT_NAME_VALUE");
    
    //入库时间
    String T_HA_BUYDATE = request.getParameter("T_HA_BUYDATE");
    
  	//入库人ID
    String T_HA_RKUSER_ID = request.getParameter("T_HA_RKUSER_ID");
  
 	//入库人名称
    String T_HA_RKUSER_NAME = request.getParameter("T_HA_RKUSER_NAME");
    
    //主键ID
    String T_HA_ID = request.getParameter("T_HA_ID");
    
    //物品分类ID
    String OFTYPE_ID = request.getParameter("OFTYPE_ID");
    
    //物品分类name
	String OFTYPE_NAME = request.getParameter("OFTYPE_NAME");
	
	 //单价
	String T_HA_DJ = request.getParameter("T_HA_DJ");

	 //备注
	String T_HA_BZ = request.getParameter("T_HA_BZ");
	 
	//设备编号
	String T_HA_SBNO = request.getParameter("T_HA_SBNO");
	
	//生产厂商
	String T_HA_GHMAN = request.getParameter("T_HA_GHMAN");

	//售后电话
	String T_HA_OVERTEL = request.getParameter("T_HA_OVERTEL");
	
	String T_HA_SBSTATE = request.getParameter("T_HA_SBSTATE"); 
	//机构iD
	String t_ha_org_id = request.getParameter("t_ha_org_id");
	//机构名称
	String t_ha_org_name = request.getParameter("t_ha_org_name");
	
	boolean flag = false;
	String action = request.getParameter("action");
	OsHavaObjectService osHavaObjectService = new OsHavaObjectServiceImpl();
	if("addOsNoMove".equals(action)){
		responseCode = "1";
		String beanId = "";
			OsHavaObjectBean osHavaObjectBean = new OsHavaObjectBean();
			osHavaObjectBean.setIt_name(IT_NAME_VALUE);
			osHavaObjectBean.setOftype_id(OFTYPE_ID);
			osHavaObjectBean.setOftype_name(OFTYPE_NAME);
			osHavaObjectBean.setOfustype_name(OFUSTYPE_NAME_VALUE);
			osHavaObjectBean.setT_ha_buydate(T_HA_BUYDATE);
			osHavaObjectBean.setT_ha_dj(T_HA_DJ);
			osHavaObjectBean.setT_ha_id(T_HA_ID);
			osHavaObjectBean.setT_ha_rkuser_id(T_HA_RKUSER_ID);
			osHavaObjectBean.setT_ha_rkuser_name(T_HA_RKUSER_NAME);
			osHavaObjectBean.setT_ha_sbno(T_HA_SBNO);
			osHavaObjectBean.setT_ha_ghman(T_HA_GHMAN);
			osHavaObjectBean.setT_ha_overtel(T_HA_OVERTEL);
			osHavaObjectBean.setT_ha_bz(T_HA_BZ);
			osHavaObjectBean.setT_ha_sbstate(T_HA_SBSTATE);//状态  1在库  2领用   3在修  4报废
			osHavaObjectBean.setT_ha_org_id(t_ha_org_id);//机构ID
			osHavaObjectBean.setT_ha_org_name(t_ha_org_name);//机构名称
			
			if(!StringUtil.isBlank(OFTYPE_ID)){
				beanId = osHavaObjectService.insertOrupdateHavaObject(osHavaObjectBean);
			}
		
		if(beanId!=null&&beanId.length()>0){
			responseObj = responseObj_SUCCESS+","+beanId;
		}else{
			responseObj = responseObj_FIAL;
		}
	}

	if("deleteOsNoMove".equals(action)){
		responseCode = "1";
		String deleteStr = request.getParameter("t_ha_ids");
		String[] deleteArr = deleteStr.split(",");
		String flagStr = "false";
		if(deleteArr.length>0){
			flagStr = osHavaObjectService.deleteHavaObjectByIds(deleteArr);
		}
		if("true".equals(flagStr)){
			flag=true;
			responseObj=responseObj_SUCCESS;
		}
		
		if(flag){
			responseObj = responseObj;
		}else{
			responseObj = responseObj_FIAL;
		}
		
	}
	
	if("1".equals(responseCode)){
		if(responseObj!=null){
			String result = "";
			if(responseObj instanceof String){
				result = responseObj.toString();
			}else{
				result = JSON.toJSONString(responseObj,true);
				Pattern p = Pattern.compile("\\s*|\t|\r|\n");
				Matcher m = p.matcher(result);
				result= m.replaceAll("");
			}
		%>
<html>
	<head></head>
	<body>
	<script>
		try{
			var result='<%=result%>';
			eval("parent.afterSubmitFn('"+result+"');");
		}catch(e){alert(e.description);}
	</script>
	</body>
</html>
	<%
		}
	}
	%>